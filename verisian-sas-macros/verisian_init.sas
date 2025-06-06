/**
 * Outputs the variables contained in a dataset, so Verisian can
 * parse them out of the log. Used for datasets which exist in the
 * environment or which are imported, such as in a proc import.
 *
 * Example uses;
 * 1: call with a library - prints the contents of that library
 * - %v_init(library=sdtm);
 * 2: call with a list of datasets - prints the specified datasets
 * - %v_init(datasets=sdtm.cm);
 *
 * If datasets are specified but cannot be found in the environment,
 * there will be a single line entry for the dataset like:
 *
 * lib:work,ds:qs_x,DOESNOTEXIST
 **/
%macro v_init(datasets=, library=);
    option nomprint;
    option nonotes;

    %macro verisian_is_blank(param);
        %sysevalf(%superq(param)=,boolean) %mend verisian_is_blank;

        %local _vinit_i lib_datasets cur_lib_ds ln dn data_set_num;

        %put ;

        %if %verisian_is_blank(&library)=0 %then %do;

            proc sql noprint;
                %* Put into macro var;
                select catx('.', libname, memname) into :lib_datasets separated
                    by ' ' from dictionary.tables where
                    libname=upcase("&library") ORDER BY memname ASC;
            quit;

            %let datasets=&lib_datasets;
        %end;

        %* Loop through each dataset in the input list;
        %do _vinit_i=1 %to %sysfunc(countw(&datasets, %str( )));

            %* Extract the dataset name;
            %let cur_lib_ds=%scan(&datasets, &_vinit_i, %str( ));
            %let ln=%scan(&cur_lib_ds, 1, ".");
            %let dn=%scan(&cur_lib_ds, 2, ".");

            %* Display dataset metadata to the log;
            proc sql noprint;
                select count(*) into :data_set_num from dictionary.tables where
                    libname=upcase("&ln") and memname=upcase("&dn");
            quit;

            %if &data_set_num > 0 %then %do;
                %* If we are printing a whole library, add null steps to link datasets to;
                %if %verisian_is_blank(&library)=0 %then %do;
                    option mprint;

                    data _null_;
                        %str( * &cur_lib_ds was found in the environment);
                    run;
                    option nomprint;
                %end;

                %* Retrieve the variable metadata;
                proc sql noprint;
                    create table ds_vars as select * from dictionary.columns
                        where libname=upcase("&ln") and memname=upcase("&dn");
                quit;

                %* Print to log;
                data _null_;
                    set ds_vars;

                    length elabel $200;
                    elabel=strip(tranwrd(tranwrd(label, '"', ''), "'", ''));

                    putlog 'verisian-lib:' libname+(-1) '|||ds:' memname+(-1)
                        '|||var:' name+(-1) '|||label:"' elabel+(-1) '"|||type:'
                        type+(-1) '|||length:' length+(-1) '|||format:'
                        format+(-1);
                run;
            %end;
            %else %do;
                %put lib:&ln|||ds:&dn|||DOESNOTEXIST;
            %end;
        %end;

        %put ;
        option notes;
        option mprint;

    %mend v_init;

    /*
     * Testing;
    options dlcreatedir;
    libname tmp '/tmp/tmp-library';
    options nodlcreatedir;

    data tmp.a;
    x=1;
    y=2;
    z="";
    run;

    data tmp.b;
    x=1;
    y=2;
    z="";
    run;

    data tmp.c;
    x=1;
    y=2;
    z="";
    run;

    option mprint;
    %v_init(library=tmp);
    %v_init(datasets=tmp.a tmp.b);
    %v_init(datasets=tmp.d);
     */
