/**
 * %v_options
 *
 * Description:
 *   This macro is a controlled way of setting common SAS system options
 *   (NOTES, SOURCE, SOURCE2, MPRINT, MPRINTNEST, and optionally SYMBOLGEN).
 *   It is useful in debugging and tracing macro execution during
 *   Verisian-related runs.
 *
 * Parameters:
 *   - symbolgen = 0|1
 *       Default: 0
 *       If 1, turns on the SYMBOLGEN option to display macro variable resolution
 *       in the SAS log.
 *
 * Toggle Control:
 *   Execution is governed by the global macro variable `verisian_toggle`.
 *   - If `verisian_toggle` = 1 → options are applied.
 *   - If `verisian_toggle` = 0 → macro does nothing (skipped).
 *
 *   By default, if `verisian_toggle` does not exist, the macro sets it to 1
 *   (so the options are applied).
 **/

%macro v_options(symbolgen=0);
    /* Set default if not already defined */
    %if not %symexist(verisian_toggle) %then %let verisian_toggle = 1;

    %* Only run if verisian_toggle is ON (1);
    %if &verisian_toggle %then %do;

	    options
	        NOTES
	        SOURCE
	        SOURCE2
	        MPRINT
	        MPRINTNEST
	    ;

	    %if &symbolgen %then %do;
	        options SYMBOLGEN;
	    %end;

    %end; %* verisian_toggle check;
%mend v_options;