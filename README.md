# Welcome to the verisian-docs repository

## Documentation

Find it in our [Wiki](https://github.com/verisianHQ/verisian-docs/wiki)

## Verisian Tracing Macros

| macro                                 | use                                                                                                                                                                                                           |
|---------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| trace/verisian_init.sas               | Run at the beginning of a session to capture all datasets and variables available in the environment. Also run after each proc import to capture imported datasets and their variables, avoiding source errors. |
| trace/verisian_mvar.sas               | Run after each declaration of macro variables outside of macros, unless macro variables are statically assigned.                                                                                              |
| trace/verisian_tlf.sas                | Use to tag TLF outputs. Needs to be placed right AFTER the step / company standard macro that produces the TLF output.                                                                                        |
| trace/verisian_options.sas            | Run at the beginning of a session. This turns on all the SAS options required by Verisian.                                                                                         |
| trace/verisian_trace_completeness.sas | Run at the very end of execution as a diagnostic. Share the output with Verisian to systematically track any breaks in study tracing.                                                                         |
