# step - create executable script from step bash block of README.md

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

OUTPUT_FILE==\${1:-generate_script.sh}
INPUT_FILE=\${2:-README.md}  

sed '/^.*step.*()/,/^}$/!d' \$INPUT_FILE >>\$OUTPUT_FILE

EOF
chmod +x $GENERATE_SCRIPT_FROM_README_SH
unset GENERATE_SCRIPT_FROM_README_SH
```

## test steps bash block

```bash

funtion step1(){

    echo "step1 ";
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

```
