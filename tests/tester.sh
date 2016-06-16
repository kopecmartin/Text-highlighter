#!/usr/bin/env bash

TASK=syn
INTERPRETER="php -d open_basedir=\"\""
EXTENSION=php


# paths to input and output files
LOCAL_IN_PATH="./" # (simple relative path)
LOCAL_IN_PATH2=`pwd`"/" #Alternative 2 (absolute path)
LOCAL_IN_PATH3="" #Alternative 1 (primitive relative path)

LOCAL_OUT_PATH="./" # (simple relative path)
LOCAL_OUT_PATH2=`pwd`"/" #Alternative 2 (absolute path)
LOCAL_OUT_PATH3="" #Alternative 1 (primitive relative path)

# path for error output
LOG_PATH="./"


# test01: Argument error; Expected output: test01.out; Expected return code: 1
$INTERPRETER $TASK.$EXTENSION --error 2> ${LOG_PATH}test01.err
echo -n $? > test01.!!!
diff test01.\!\!\! ./ref-out/test01.\!\!\!
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_1"
fi

# test02: Input error; Expected output: test02.out; Expected return code: 2
$INTERPRETER $TASK.$EXTENSION --input=nonexistent --output=${LOCAL_OUT_PATH3}test02.out 2> ${LOG_PATH}test02.err
echo -n $? > test02.!!!
diff test02.\!\!\! ./ref-out/test02.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_2"
fi

# test03: Output error; Expected output: test03.out; Expected return code: 3
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH3}empty --output=nonexistent/${LOCAL_OUT_PATH2}test03.out 2> ${LOG_PATH}test03.err
echo -n $? > test03.!!!
diff test03.\!\!\! ./ref-out/test03.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_3"
fi

# test04: Format table error - nonexistent parameter; Expected output: test04.out; Expected return code: 4
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH3}empty --output=${LOCAL_OUT_PATH}test04.out --format=error-parameter.fmt 2> ${LOG_PATH}test04.err
echo -n $? > test04.!!!
diff test04.\!\!\! ./ref-out/test04.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_4"
fi

#do not check err output, because errors statements may be different

diff test04.out ./ref-out/test04.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_4"
fi

# test05: Format table error - size; Expected output: test05.out; Expected return code: 4
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}empty --output=${LOCAL_OUT_PATH3}test05.out --format=error-size.fmt 2> ${LOG_PATH}test05.err
echo -n $? > test05.!!!
diff test05.\!\!\! ./ref-out/test05.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_5"
fi

#do not check err output, because errors statements may be different

diff test05.out ./ref-out/test05.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_5"
fi

# test06: Format table error - color; Expected output: test06.out; Expected return code: 4
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}empty --output=${LOCAL_OUT_PATH}test06.out --format=error-color.fmt 2> ${LOG_PATH}test06.err
echo -n $? > test06.!!!
diff test06.\!\!\! ./ref-out/test06.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_6"
fi

#do not check err output, because errors statements may be different

diff test06.out ./ref-out/test06.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_6"
fi

# test07: Format table error - RE syntax; Expected output: test07.out; Expected return code: 4
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH3}empty --output=${LOCAL_OUT_PATH3}test07.out --format=error-re.fmt 2> ${LOG_PATH}test07.err
echo -n $? > test07.!!!
diff test07.\!\!\! ./ref-out/test07.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_7"
fi

#do not check err output, because errors statements may be different

diff test07.out ./ref-out/test07.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_7"
fi

# test08: Empty files; Expected output: test08.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}empty --output=${LOCAL_OUT_PATH3}test08.out --format=empty 2> ${LOG_PATH}test08.err
echo -n $? > test08.!!!
diff test08.\!\!\! ./ref-out/test08.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_8"
fi

diff test08.err ./ref-out/test08.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_8"
fi

diff test08.out ./ref-out/test08.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_8"
fi

# test09: Format parameters; Expected output: test09.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}basic-parameter.in --output=${LOCAL_OUT_PATH3}test09.out --format=basic-parameter.fmt 2> ${LOG_PATH}test09.err
echo -n $? > test09.!!!
diff test09.\!\!\! ./ref-out/test09.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_9"
fi

diff test09.err ./ref-out/test09.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_9"
fi

diff test09.out ./ref-out/test09.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_9"
fi

# test10: Argument swap; Expected output: test10.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --format=basic-parameter.fmt --output=${LOCAL_OUT_PATH3}test10.out --input=${LOCAL_IN_PATH}basic-parameter.in 2> ${LOG_PATH}test10.err
echo -n $? > test10.!!!
diff test10.\!\!\! ./ref-out/test10.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_10"
fi

diff test10.err ./ref-out/test10.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_10"
fi

diff test10.out ./ref-out/test10.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_10"
fi

# test11: Standard input/output; Expected output: test11.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --format=basic-parameter.fmt >${LOCAL_OUT_PATH3}test11.out <${LOCAL_IN_PATH}basic-parameter.in 2> ${LOG_PATH}test11.err
echo -n $? > test11.!!!
diff test11.\!\!\! ./ref-out/test11.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_11"
fi

diff test11.err ./ref-out/test11.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_11"
fi

diff test11.out ./ref-out/test11.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_11"
fi

# test12: Basic regular expressions; Expected output: test12.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}basic-re.in --output=${LOCAL_OUT_PATH3}test12.out --format=basic-re.fmt 2> ${LOG_PATH}test12.err
echo -n $? > test12.!!!
diff test12.\!\!\! ./ref-out/test12.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_12"
fi

diff test12.err ./ref-out/test12.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_12"
fi

diff test12.out ./ref-out/test12.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_12"
fi

# test13: Special regular expressions; Expected output: test13.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH3}special-re.in --output=${LOCAL_OUT_PATH3}test13.out --format=special-re.fmt 2> ${LOG_PATH}test13.err
echo -n $? > test13.!!!
diff test13.\!\!\! ./ref-out/test13.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_13"
fi

diff test13.err ./ref-out/test13.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_13"
fi

diff test13.out ./ref-out/test13.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_13"
fi

# test14: Special RE - symbols; Expected output: test14.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}special-symbols.in --output=${LOCAL_OUT_PATH2}test14.out --format=special-symbols.fmt 2> ${LOG_PATH}test14.err
echo -n $? > test14.!!!
diff test14.\!\!\! ./ref-out/test14.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_14"
fi

diff test14.err ./ref-out/test14.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_14"
fi

diff test14.out ./ref-out/test14.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_14"
fi

# test15: Negation; Expected output: test15.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH}negation.in --output=${LOCAL_OUT_PATH3}test15.out --format=negation.fmt 2> ${LOG_PATH}test15.err
echo -n $? > test15.!!!
diff test15.\!\!\! ./ref-out/test15.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_15"
fi

diff test15.err ./ref-out/test15.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_15"
fi

diff test15.out ./ref-out/test15.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_15"
fi

# test16: Multiple format parameters; Expected output: test16.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH3}multiple.in --output=${LOCAL_OUT_PATH3}test16.out --format=multiple.fmt 2> ${LOG_PATH}test16.err
echo -n $? > test16.!!!
diff test16.\!\!\! ./ref-out/test16.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_16"
fi

diff test16.err ./ref-out/test16.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_16"
fi

diff test16.out ./ref-out/test16.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_16"
fi

# test17: Spaces/tabs in format parameters; Expected output: test17.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH3}multiple.in --output=${LOCAL_OUT_PATH3}test17.out --format=spaces.fmt 2> ${LOG_PATH}test17.err
echo -n $? > test17.!!!
diff test17.\!\!\! ./ref-out/test17.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_17"
fi

diff test17.err ./ref-out/test17.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_17"
fi

diff test17.out ./ref-out/test17.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_17"
fi

# test18: Line break tag; Expected output: test18.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH3}newlines.in --output=${LOCAL_OUT_PATH}test18.out --format=empty --br 2> ${LOG_PATH}test18.err
echo -n $? > test18.!!!
diff test18.\!\!\! ./ref-out/test18.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_18"
fi

diff test18.err ./ref-out/test18.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_18"
fi

diff test18.out ./ref-out/test18.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_18"
fi

# test19: Overlap; Expected output: test19.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}overlap.in --output=${LOCAL_OUT_PATH3}test19.out --format=overlap.fmt 2> ${LOG_PATH}test19.err
echo -n $? > test19.!!!
diff test19.\!\!\! ./ref-out/test19.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_19"
fi

diff test19.err ./ref-out/test19.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_19"
fi

diff test19.out ./ref-out/test19.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_19"
fi

# test20: Perl RE; Expected output: test20.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH3}special-symbols.in --output=${LOCAL_OUT_PATH3}test20.out --format=re.fmt 2> ${LOG_PATH}test20.err
echo -n $? > test20.!!!
diff test20.\!\!\! ./ref-out/test20.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_20"
fi

diff test20.err ./ref-out/test20.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_20"
fi

diff test20.out ./ref-out/test20.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_20"
fi

# test21: Example; Expected output: test21.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}example.in --br --format=example.fmt > ${LOCAL_OUT_PATH3}test21.out 2> ${LOG_PATH}test21.err
echo -n $? > test21.!!!
diff test21.\!\!\! ./ref-out/test21.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_21"
fi

diff test21.err ./ref-out/test21.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_21"
fi

diff test21.out ./ref-out/test21.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_21"
fi

# test22: Simple C program; Expected output: test22.out; Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}cprog.c --br --format=c.fmt > ${LOCAL_OUT_PATH2}test22.out 2> ${LOG_PATH}test22.err
echo -n $? > test22.!!!
diff test22.\!\!\! ./ref-out/test22.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_22"
fi

diff test22.err ./ref-out/test22.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_22"
fi

diff test22.out ./ref-out/test22.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_22"
fi

#--------------------------------------------------

#double and single !, Expected return code:0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}my_test.in --format=my_test.fmt > ${LOCAL_OUT_PATH2}test23.out 2> ${LOG_PATH}test23.err
echo -n $? > test23.!!!
diff test23.\!\!\! ./ref-out/test23.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_23"
fi

diff test23.err ./ref-out/test23.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_23"
fi

diff test23.out ./ref-out/test23.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_23"
fi

#original RE, Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}my_test_1.in --format=my_test_1.fmt > ${LOCAL_OUT_PATH2}test24.out 2> ${LOG_PATH}test24.err
echo -n $? > test24.!!!
diff test24.\!\!\! ./ref-out/test24.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_24"
fi

diff test24.err ./ref-out/test24.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_24"
fi

diff test24.out ./ref-out/test24.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_24"
fi

# Expected return code: 0
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}my_test_2.in --format=my_test_2.fmt > ${LOCAL_OUT_PATH2}test25.out 2> ${LOG_PATH}test25.err
echo -n $? > test25.!!!
diff test25.\!\!\! ./ref-out/test25.\!\!\! >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_ret_code_number_25"
fi

diff test25.err ./ref-out/test25.err >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_err_number_25"
fi

diff test25.out ./ref-out/test25.out >/dev/null
if [ $? -ne 0 ]; then        
    echo "!!!BAD_out_number_25"
fi