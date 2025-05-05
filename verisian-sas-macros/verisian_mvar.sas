%macro v_mvar(varlist);
    options nomprint;
    options nonotes;
    %put <verisian-macrovar-trace-begin>;

    %if %sysfunc(countw(&varlist, %str( ))) <= 0 %then %do;

        * _GLOBAL_ macro variables - we can ignore _LOCAL_ bc they get captured by MPRINTs;
        proc sql noprint;
            select name into :varlist separated by '|' from dictionary.macros
                where scope='GLOBAL';
        quit;
    %end;

    %let n=%sysfunc(countw(&varlist));
    %do _vmvar_i=1 %to &n;
        %let var=%scan(&varlist, &_vmvar_i, %str(|));
        %put <mvar-begin> GLOBAL &var &&&var <mvar-end>;
    %end;

    %put <verisian-macrovar-trace-end>;

    options mprint notes;
%mend v_mvar;
key:
*%v_mvar;
*%v_mvar(SYS_COMPUTE_DATA);
*%v_mvar(SYS_COMPUTE_DATA _CASHOST_);
