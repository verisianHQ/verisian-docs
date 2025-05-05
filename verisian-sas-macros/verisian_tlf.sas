%macro v_tlf(reference=);
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
%mend v_tlf;

*%v_tlf(reference=This is my favorite title);
