#!/bin/bash

OUTPUT_FILE=${1:-generate_script.sh}
INPUT_FILE=${2:-README.md}  

echo "#!/bin/bash" |tee $OUTPUT_FILE

sed '/^\(step\|checkstep\).*()/,/^}$/!d' README.md |tee -a $OUTPUT_FILE

# sed -n 's/^.*\(step\)/\1/p' README.md |sed 's/(.*//g'|sed 's/^.* //g'

# sed -n 's/^\(step\|checkstep\).*[0-9].*\((\).*\()\)/\0/p' README.md|sed 's/(.*//g'|sed 's/^.* //g'

cat << FFF |tee -a $OUTPUT_FILE
function script.functions () {
    local fncs=$(sed -n 's/^\(step\|checkstep\).*[0-9].*\((\).*\()\)/\0/p' README.md|sed 's/(.*//g'|sed 's/^.* //g')
    echo $fncs; # not quoted here to create shell "argument list" of funcs.
}
declare -rx MyVar=();
# printf "%s\n" "";

for f in ; do
    
done

FFF

chmod +x $OUTPUT_FILE
echo "create script to $OUTPUT_FILE"
