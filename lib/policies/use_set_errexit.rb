banalizer  File.basename(__FILE__, '.rb').to_sym  do

  synopsis 'Script should be run with -e option or `set -o errexit`'
  
  description <<EOF
Using this option forces bash script to exit on first error.
  
man bash:

         -e      Exit immediately if a simple command (see SHELL GRAMMAR above)
                 exits with a non-zero status.  The shell does not exit if  the
                 command  that  fails  is  part of the command list immediately
                 following a while or until keyword, part of the test in an  if
                 statement, part of a && or || list, or if the command's return
                 value is being inverted via !.  A trap on ERR, if set, is exe-
                 cuted before the shell exits.


`set -o errexit` is the same as `set -e`.

EOF

  severity :gentle

  def run
    ret = true
    #
    # Prohibit using set +e option
    #
    errors.add "Setting +e option in shebang: #{shebang}" if (shebang.has? /\+e/)

    if code.has? /set\s+\+e/
      errors.add "Use of +e to unset -e option. Lines: #{code.lines}"
    end

    
    if ( code.dont_have?(/set\s+-e/) &&
         code.dont_have?(/set\s+-o\s+errexit/) &&
         shebang.dont_have?(/\s-e/)
         )
      errors.add "Can not find option -e or -o errexit anywhere in the script"
    end
    return errors.empty?
  end

end
