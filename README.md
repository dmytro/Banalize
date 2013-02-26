[![Wizcorp](images/wizcorp-logo.png)](http://wizcorp.jp)

Name
===========

Banalize - static code analyzer for Bash

![banalize](images/banalize.png)

Description
===========

Banalizer is syntax analyzer for bash scripts. It is modelled after ideas of [`Perl::Critic`](http://en.wikipedia.org/wiki/Perl::Critic) static analyzer for Perl. Most of the Banalizer is written in Ruby. Exception is policy files which are language agnostic, and can be written in any language: scripting or compiled.

Banalizer consists of main binary file, banalyzer libraries, command line interface (CLI) and policies. 

Policy is requirement for bash script/file. For example: each script must have 'shebang' as first line.

Each policy is implemented as Ruby or other programming/scripting language file able to perform single check on single bash script file. Rest - aggregating checks, reporting, filtering etc - is handled by Banalizer.

### Severity

### Policy group

Conventions
===========

Policies
-----------

- All policies (policy files) installed in `./lib/policies` directory. 
  Note: There could be other (additionally) policy directories added in the future, like for example `~/.banalizer` or similar
- There are two classes of policies recognized by Banalizer: Ruby and _'other'_
- Ruby policy files detected by `.rb` extension. Files without `.rb` extension are considered to be 'others'
- Policy name is detected from
  - file name of 'other' policy
  - first argument for `banalizer` method for Ruby policy
- all names should be unique, or they will be overwritten

### Attributes

All policies have these attributes:

- name
- description
- severity
- style
- help

Depending on the type of policy some of the attributes are required, some optional or can be set to reasonable default.

### Non-ruby policies (i.e. others)

Policy should conform to few rules:

1. it must return information about itself when called with parameter `config`
  - Output of the `config` command is YAML formatted text
    - Command returns attributes names and values of the policy
    - All attributes in case of 'other' policy are optional

      They are either set to default values if missing, or detected from other meta-data (like, for example, name of a policy is `$(basename file)` of policy file.
2. Policy script must be able to perform single (syntax/semantic/format) check on bash script file and:
  - return non-zero status if check fails or 0 if succeeds
  - return (optional) error massages on STDOUT

    **Note**: Only STDOUT is honored by Banalizer. 
    
    If your check command, for example, prints to STDERR but not to STDOUT, you'd need to redirect shell streams accordingly.

#### Example config section

```yaml
    ---
    name: $(basename $0)
    style: 
      - :bug
      - :test
    severity: 5
    description: Runs bash syntax check using 'bash -n' option
```

### Ruby policy

1. Ruby policy has two required items: 
   - name  
   - must define method called `run`
1. Policy is defined in top-level namespace's method called `banalizer`
   - name is string or Ruby symbol parameter to `banalizer` method
   - additional (optional) attributes are defined as DSL methods calls inside block given to `banalizer` method
   - run method is defined in the same block
1. DSL methods names correspond to policy attributes :
   - description
   - help
   - style
   - severity
   - policy_name ( to avoid clashes with Ruby standard `name` method)
1. `run` method should:
   - return value evaluated into true or false

#### Example 

This is full working example of Ruby DSL policy:

````ruby
banalizer :shebang_format do
  
  help        'Format of shebang should be #!/usr/bin/env bash'
  severity    5

  def run
    unless lines.first =~ %r{^\#!/usr/bin/env\s+bash}

      errors.add "First line is not in the format #!/usr/bin/env bash", 1
      return false
    end
  end

end
````

<!--  LocalWords:  banalize
 -->
