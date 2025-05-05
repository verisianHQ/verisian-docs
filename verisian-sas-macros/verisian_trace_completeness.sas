libname source '/path/to/your/libraries/source';
libname sdtm '/path/to/your/libraries/sdtm';
libname adam '/path/to/your/libraries/adam';
libname tlf '/path/to/your/libraries/tlf';

proc sql;
    create table sourcecont as select libname as library, memname as dataset,
        name as variable, type, length, label, format from dictionary.columns
        where libname IN ('SOURCE', 'SDTM', 'ADAM', 'TLF');
quit;

proc export data=sourcecont outfile="path/of/your/choosing/trace_spec.csv"
    dbms=csv replace;
run;
