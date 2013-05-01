## v.0.0.6
* Wed May 01 2013 -- Dmytro Kovalov

  - bugfix. Fix logic in set -u/-e policies
  
## v.0.0.5
* Tue Apr 30 2013 -- Dmytro Kovalov

  - bugfix. Add required gems to gemspec file
  
## v.0.0.4

* Fri Mar 29 2013 -- Dmytro Kovalov

  - Generate Markdown documentation from policy descriptions

## v.0.0.3

* Thu Mar 28 2013 -- Dmytro Kovalov

  - Filtering files by extension list: comma separated
  - Add default sorting to policy search
  - Policy to check braces $a around variables
    with test  for it
  - Add template for ruby policy in the docs directory
  - Policy to check uninitialized variables
  - Currently processed bash: Add error reporting on exit of currently processed bash file.
  - ShellVariables module for parser
    Find all shell variables in script into array and accessor `variables`

## v.0.0.2

* Wed Mar 27 2013 -- Dmytro Kovalov
    Multiple changes:
  - Allow search policies by regexp from CLI
  - search method changes in Policy
      - add search by Regexp
      - YARD formatting
  - Changes to describe command
      - Better screen output with color support
      - Drop policy name argument from desc command, use global policies search
  - Fix NaN - divizion by 0n comment coverage
  - Use of active = false
      By using false on active default allow disabling policies.
  - Policy to check percetantage coverage of the comments over code
  - POD comments module
      POD comments included into standard parser as module.  It recognizes comments in POD here-doc style and moves them from code part to comments.
  - For Numbered class:
      - method slice
      - method sort
  - Move @lines parsing to Parser class
  - Add GLI_DEBUG for exit_now!
  - Documnetation for Numbered class
  - Fix no method error when $styles section for policy don't exist
