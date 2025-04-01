#!/bin/sh

# 配置选项
EXECU = "program"	# 生成可执行文件
SRC_FILES = "ft_putchar.c" "ft_swap.c" "ft_putstr.c" "ft_strlen.c" "ft_strcmp.c"
TEST_CASE = "test1" "test2"

CC = "gcc"
CFLAGS = "-Wall -Wextra -Werror -g"
GDB = "gdb"

clean()
{
	rm -f "$EXECU" *.o *.out
}

compile()
{
	echo "Compiling..."
	if $CC $CFLAGS -o "$EXECU" "${SRC_FILES[@]}"; then
		echo "Compile finished"
		return 0
	else
		echo "Compile failed"
		return 1
	fi
}

run()
{
	if [ ! -f "$EXECU" ]; then
		compile || return 1
	fi
	echo "Executing..."
	./"$EXECU"
}

test()
{
	local pass=0
	local fail=0

	for testcase in "${TEST_CASES[@]}"; do
		local input_file="test/${testcase}.in"
		local expected_file="test/${testcase}.expected"
		local output_file="test/${testcase}.out"

		if [ ! -f "$input_file" ]; then
			echo "Test case $testcase: Input file do not exists"
			((fail++))
			continue
		fi

		echo "Testing $testcase..."
		./"$EXECU" < "$input_file" > "$output_file"

		if diff -q "$expected_file" "$output_file" > /dev/null; then
			echo "Test $testcase approved"
			((pass++))
		else
			echo "Test $testcase failed"
			diff "$expected_file" "$output_file"
			((fail++))
		fi
	done

	echo "Test result: passed $pass , failed $fail "
	return $fail
}

debug()
{
	if [ ! -f "$EXECU" ]; then
		compile || return 1
	fi
	echo "Init GDB..."
	$GDB -q ./"$EXECU"
}

usage()
{
	echo "Usage: $0 [option]"
	echo "option:"
	echo "		-c	to compile"
	echo "		-r	to run"
	echo "		-t	to execute"
	echo "		-d	to debug"
	echo "		-a	to compile, execute and test"
	echo "		--clean to clear all the generated files"
	echo "		-h	to display informations"
}

main()
{
	local do_compile=0
	local do_run=0
	local do_test=0
	local do_debug=0

	while getopts "crtdah" opt; do
		case $opt in
			c) do_compiled=1 ;;
			r) do_run=1 ;;
			t) do_test=1 ;;
			d) do_debug=1 ;;
			a) do_compile=1 ; do_run=1 ; do_test=1 ;;
			h) usage; exit 0 ;;
			*) usage; exit 1 ;;
		esac
	done

	for arg in "$@"; do
		if [[ "$arg" == "--clean" ]]; then
			clean
			exit 0
		fi
	done

	if [ $OPTIND -eq 1 ]; then
		usage
		exit 0
	fi

	(( do_compile )) && { compile || exit 1; }
	(( do_run )) && { run || exit 1; }
	(( do_test )) && { test || exit 1; }
	(( do_debug )) && { debug || exit 1; }
}

main "$@"
