/* %put verisian-nmi-s<%nrstr(%MACRONAME(param1, param2, param3))>verisian-nmi-e; */
options MPRINT MPRINTNEST NOTES SOURCE SOURCE2;

%macro standard_macro(param1, param2, param3);

    data _tmp;
        length param1 $100 param2 $100 param3 $100;
        param1="&param1";
        param2="&param2";
        param3="&param3";
    run;

%mend standard_macro;

%macro sm_wrapper(p1, p2, p3);
    %put verisian-nmi-s<%nrstr(%standard_macro(&p1, &p2, &p3))>verisian-nmi-e;
    %standard_macro(&p1, &p2, &p3);
%mend sm_wrapper;

%sm_wrapper(apple,banana,chicken);

/* expected log output:
...
25   %sm_wrapper(apple,banana,chicken)
verisian-nmi-s<%standard_macro(&p1, &p2, &p3)>verisian-nmi-e
...
 */
