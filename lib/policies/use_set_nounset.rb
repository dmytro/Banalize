banalizer  File.basename(__FILE__, '.rb').to_sym  do

  
  synopsis "Always use 'set -u' or 'set -o nounset' in scripts"
  severity  :gentle
  style     :bug
  
  description <<EOF

Quote from: http://www.davidpashley.com/articles/writing-robust-shell-scripts.html

Use set -u
===========

    How often have you written a script that broke because a variable
    wasn't set? I know I have, many times.

chroot=$1
...
rm -rf $chroot/usr/share/doc 

    If you ran the script above and accidentally forgot to give a
    parameter, you would have just deleted all of your system
    documentation rather than making a smaller chroot. So what can you
    do about it? Fortunately bash provides you with set -u, which will
    exit your script if you try to use an uninitialised variable. You
    can also use the slightly more readable set -o nounset.

% bash /tmp/shrink-chroot.sh
$chroot=
david% bash -u /tmp/shrink-chroot.sh
/tmp/shrink-chroot.sh: line 3: $1: unbound variable
david% 

EOF

  def run
    ret = true
    #
    # Prohibit using set +e option
    #
    errors.add "Setting +u option in shebang: #{shebang}" if (shebang.has? /\+u/)

    if code.has? /set\s+\+u/
      errors.add "Use of +u to unset -u option. Lines: #{code.lines}"
      errors.add "    #{code.search.inspect}"
    end

    
    if ( code.dont_have?(/set\s+-u/) &&
         code.dont_have?(/set\s+-o\s+nounset/) &&
         shebang.dont_have?(/\s-u/)
         )
      errors.add "Can not find option -u or -o nounset anywhere in the script"
    end
    return errors.empty?
  end

end
