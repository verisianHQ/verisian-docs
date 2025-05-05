# Welcome to the verisian-docs repository

## Documentation

Find it in our [Wiki](https://github.com/verisianHQ/verisian-docs/wiki)

## Verisian Tracing Macros

| macro                   | use                                                                                                                                                                                               |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| trace/verisian_init.sas | run at beginning of session to capture all datasets and variables available in environment; run after every proc import to capture imported dataset and its variables to avoid source-error nodes |
| trace/verisian_mvar.sas | run after each declaration of macro variables outside of macros, unless macro variables are statically assigned                                                                                   |
| trace/verisian_tlf.sas  | use to tag TLF outputs. Needs to be placed right AFTER the step / company standard macro that produces the TLF output                                                                             |
