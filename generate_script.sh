#!/bin/bash
step1(){ #hallo

    echo "step1 ";
    echo "${FUNCNAME[0]}";
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
function script.functions () {
    local fncs=step1
step2
checkstep2
checkstep22
checkstep999
    echo ; # not quoted here to create shell "argument list" of funcs.
}
declare -rx MyVar=();
# printf "%s\n" "";

for f in ; do
    
done

