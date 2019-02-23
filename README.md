# step - create executable script from step bash block of README.md

## create script getScriptFromReadme.sh

```bash
sed begin/end
```

## motivation - no double documentation effort in different files

## sed create script

```bash
 sed '/^.*()/,/^}$/!d' test.sh
```

## generate script from README.md

```bash
GENERATE_SCRIPT_FROM_README_SH="generateScriptfromReadme.sh"
cat << EOF > $GENERATE_SCRIPT_FROM_README_SH
#!/bin/bash

OUTPUT_FILE=\${1:-generate_script.sh}
INPUT_FILE=\${2:-README.md}  
MARK_FILE=mark.txt
MARK_REBOOT="REBOOTED"
REBOOTED="NO"


# check mark file
checkMarkFile(){

    #TODOD
    exit 1
}


# check reboot mark file available
checkReboot(){
if [[ -r $MARK_REBOOTED ]]
then
echo "MARK_REBOOT file found"
echo "This file toggle you have reboot this device."
echo "Is not right or you want start again from begin delete this file now"
echo "you want delete the MARK file
read -r -p "Are you sure? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        rm -rf $MARK_FILE
        ;;
    *)
        echo "reboot detected"
        checkMarkRebootFile;
        ;;
esac
fi

} # end of checkReboot

# detect a reboot mark file is our
checkMarkRebootFile(){

if ( $REBOOTED =="YES"){
    if grep -c \$(cat $MARK_FILE) \$(MARK_REBBOT); then
    echo "ok"
    \$REBOOTED="YES"
else
    echo "Error found bad MARk_FILE please delete and start from begin"
    exit 1
fi

} # end of checkMarkFile

shouldReboot(){
# mark requested reboot
if [[git rev-parse --is-inside-work-tree == "true" ]] ; then
git rev-parse --verify HEAD|sha256sum |tee  \$MARK_REBOOT
else
\$(pwd) | sha256sum | tee \$MARK_REBOOT
fi
echo "Please reboot this device now and start the script again"
}

echo "#!/bin/bash" |tee \$OUTPUT_FILE

sed '/^\(step\|checkstep\).*()/,/^}$/!d' README.md |tee -a \$OUTPUT_FILE

# sed -n 's/^.*\(step\)/\1/p' README.md |sed 's/(.*//g'|sed 's/^.* //g'

# sed -n 's/^\(step\|checkstep\).*[0-9].*\((\).*\()\)/\0/p' README.md|sed 's/(.*//g'|sed 's/^.* //g'

cat << FFF |tee -a \$OUTPUT_FILE
function script.functions () {
    local fncs=\$(sed -n 's/^\(step\|checkstep\).*[0-9].*\((\).*\()\)/\0/p' README.md|sed 's/(.*//g'|sed 's/^.* //g')
    echo \$fncs; # not quoted here to create shell "argument list" of funcs.
}
declare -rx MyVar=(\$(script.functions));
# printf "%s\n" "\${MyVar[@]}";

for f in \${MyVar[@]}; do
    $f
done

FFF

chmod +x \$OUTPUT_FILE
echo "create script to \$OUTPUT_FILE"
EOF
chmod +x $GENERATE_SCRIPT_FROM_README_SH
unset GENERATE_SCRIPT_FROM_README_SH
```

## test steps bash block

```bash

step1(){ #hallo

    echo "step1 ";
    echo "${FUNCNAME[0]}";
}

function checkstep1(){

    echo "check step 1"

}

step2() {

    echo "step2 ";
}


checkstep2(){

    echo "check step 2";
}

checkstep22(){

    echo "check step 2";
}

checkstep999(){

    echo "check step 2";
}

stepA(){
    echo not that
}

```
