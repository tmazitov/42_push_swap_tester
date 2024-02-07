#!/bin/bash

PRINT_INPUT=false
PRINT_OUTPUT=false
SHOW_NUMBERS=false

CHECKER_PATH=""
PUSHSWAP_PATH="./push_swap"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "\n${BLUE}\t\tERROR TESTS${NC}\n"

echo "### Errors should be printed into ${RED}standart error${NC} fd ###\n"

for file in ./tests/*testerror*; do
	numbers=$(cat "$file")
	result=$($PUSHSWAP_PATH $numbers 2>&1)
	
	if [ $PRINT_INPUT = true ]; then
		echo "Input\t: $(echo "$numbers" | tr '\n' ' ')"
	fi
	if [ $PRINT_OUTPUT = true ]; then
		echo "Output\t: $(echo "$result" | tr '\n' ' ')"
	fi
	
	case $result in 
		*Error*) printf "%30s : ${GREEN}OK${NC}\n" $file;; 
		*) 	printf "%30s : ${RED}KO${NC}\n" $file;; 
	esac
done

echo "\n${BLUE}\t\tIDENTITY TESTS${NC}\n"

for file in ./tests/*testiden*; do
	numbers=$(cat "$file")
	result=$($PUSHSWAP_PATH $numbers | wc -m)

	if [ $PRINT_INPUT = true ]; then
		echo "Input\t: $(echo "$numbers" | tr '\n' ' ')"
	fi
	if [ $PRINT_OUTPUT = true ]; then
		echo "Output\t: $(echo "$result" | tr '\n' ' ')"
	fi
	
	if [ $result -eq 0 ]; then
		printf "%30s : ${GREEN}OK${NC}\n" $file
	else
		printf "%30s : ${RED}KO${NC}\n" $file
	fi
done

echo "\n${BLUE}\t\tMAIN TESTS${NC}\n"

for file in ./tests/*test_*; do
	numbers=$(cat "$file")

	result=$($PUSHSWAP_PATH $numbers)
	
	count_of_operations=$(echo $result |  tr ' ' '\n' | wc -l)
	cheker_result=$($PUSHSWAP_PATH $numbers | $CHECKER_PATH $numbers)

	if [ $SHOW_NUMBERS = true ]; then
		result=$(echo "$result" | tr -cs '[:digit:]' ' ' | tr -s ' ')
	fi

	case $cheker_result 
		in *OK*) printf "%24s : ${GREEN} OK ${NC} %d\n" $file $count_of_operations;; 
		*)		 printf "%24s : ${RED} KO ${NC} %d\n" $file $count_of_operations;; 
	esac

	if [ $PRINT_INPUT = true ]; then
		echo "Input\t: $(echo "$numbers" | tr '\n' ' ')"
	fi
	if [ $PRINT_OUTPUT = true ]; then
		echo "Output\t: $(echo "$result" | tr '\n' ' ')"
	fi
done
