# @title Banalizer configuration

![banalize](images/banalize_small.png)

# Per user configuration

## Command line options

All command line options for Banalizer can be set as defaults in `~/.banalizer/config` file. `config` file is in YAML format. 

See [GLI configuration](https://github.com/davetron5000/gli/wiki/Config) for details.

## Policies defaults

Defaults defined in policy recipes using `default`method  (see {Banalize::Registry.default}) can be overwritten by per-user or per-project custom styles file. 

Default locatio for the style file is `~/.banalize/style`. It's YAML formatted file. Example is available in Banalize project config directory. Please see for details.

### Disable policy

Any policy can be disabled by setting `active` flag to `false` in personal style file, as in:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~yaml

:disabled_policy:
  :active: false

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Custom policies

User can add own policies outside of Banalize gem. Additionally to policies included with gem Banalize will search for policy files in `~/.banalize/policies/`. 

If you want to creagte own policies, simply drop policy file in the directory.


# Environment variables

* `BANALIZE_TRUNCATE_LINES`

    Set this to 'false' to avoid long lines truncated. Otherwise lines with long lists of failed lines are truncated as:
    
    ```
        consistent_indents
        ## Code indented inconsistently: TABS and SPACES mixed
        ##     TAB indented: 490, 491
        ##     SPC indented: 35, 37, 39, 41, 42, 43, 45, 47, 49, 51, 52,... (total 233)
    ```

* `GLI_DEBUG`
  
  To see full trace of errors in GLI set this to 'true'
