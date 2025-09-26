/**
 * %v_tlf
 *
 * Description:
 *   This macro cleans and logs a TLF reference by removing quotes, compressing spaces,
 * and trimming the string.
 *
 * Parameters:
 *   - reference = string
 *       The reference text to be cleaned and logged.
 *
 * Toggle Control:
 *   Execution is governed by the global macro variable `verisian_toggle`.
 *   - If `verisian_toggle` = 1 → reference is processed and logged.
 *   - If `verisian_toggle` = 0 → macro does nothing (skipped).
 *
 *   By default, if `verisian_toggle` does not exist, the macro sets it to 1
 *   (so processing occurs).
 **/


%macro v_tlf(reference=);
    /* Set default if not already defined */
    %if not %symexist(verisian_toggle) %then %let verisian_toggle = 1;

    %* Only run if verisian_toggle is ON (1);
    %if &verisian_toggle %then %do;

        option nomprint;
        option nonotes;

        %let ctitle=%sysfunc(compress(&reference, %str(%')));
        %let cctitle=%sysfunc(compress(&ctitle, %str(%")));
        %let ccctitle=%sysfunc(prxchange(%str(s/\s+/ /), -1, &cctitle));
        %let cccctitle=%sysfunc(trim(&ccctitle));

        %put verisian-tlf:reference:"&cccctitle";
        %put;

        option notes;
        option mprint;

    %end; %* verisian_toggle check;
%mend v_tlf;