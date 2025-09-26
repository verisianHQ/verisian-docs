/**
 * Outputs the macro variables from the environment, so Verisian can
 * parse them out of the log. Used for macro variables which exist in the
 * environment or which are created by Proc SQL into clause

 * Example uses;
 * 1: call without parameters - prints all the macro variables present in the environment
 * - %v_mvar;
 * 2: call with a list of macro variables - prints the specified macro variables
 * - %v_mvar(SYS_COMPUTE_DATA);
 * - %v_mvar(SYS_COMPUTE_DATA | _CASHOST_);

 * Toggle control:
 * A global toggle variable `verisian_toggle` can be defined once to control
 * whether the macro executes.
 *   %global verisian_toggle;
 *   %let verisian_toggle = 1;   /* 1 = run, 0 = skip */
 *
 * If `verisian_toggle` is not defined, the macro sets it to 1 by default.
 **/

%macro v_mvar(varlist=);
    /* Set default if not already defined */
    %if not %symexist(verisian_toggle) %then %let verisian_toggle = 1;

    %* Only run if verisian_toggle is ON (1);
    %if &verisian_toggle %then %do;

        options nomprint;
        options nonotes;
        %put <verisian-macrovar-trace-begin>;

        %if %sysfunc(countw(&varlist, %str( ))) <= 0 %then %do;

            * _GLOBAL_ macro variables - we can ignore _LOCAL_ bc they get captured by MPRINTs;
            proc sql noprint;
                select name
                       into :varlist separated by '|'
                from dictionary.macros
                where scope='GLOBAL';
            quit;
        %end;

        %let n=%sysfunc(countw(&varlist, %str(|)));
        %do _vmvar_i=1 %to &n;
            %let var=%scan(&varlist, &_vmvar_i, %str(|));
            %put <mvar-begin> GLOBAL &var &&&var <mvar-end>;
        %end;

        %put <verisian-macrovar-trace-end>;

        options mprint notes;

    %end; %* verisian_toggle check;
%mend v_mvar;