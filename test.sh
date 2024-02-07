#!/bin/bash

PRINT_INPUT=false
PRINT_OUTPUT=false
SHOW_NUMBERS=true

CHECKER_PATH=/home/tlenovo/tools/pushswap_checker
PUSHSWAP_PATH=/home/tlenovo/projects/study/42_push_swap/push_swap


# FILEPATH: /home/tlenovo/projects/study/42_push_swap/test.sh
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


echo "\n${BLUE}PARSING TESTS${NC}\n"

for file in ./tests/*testerror*; do
	numbers=$(cat "$file")
	result=$($PUSHSWAP_PATH $numbers)
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
	# if [ -z "${$result##*Error*}"]; then
	# 	echo "$file:\t ${GREEN}OK${NC}"
	# else
	# 	echo "$file:\t ${RED}KO${NC}"
	# fi 
done

echo "\n${BLUE}IDENTITY TESTS${NC}\n"

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
	
	# if [ -z "${$result##*Error*}"]; then
	# 	echo "$file:\t ${GREEN}OK${NC}"
	# else
	# 	echo "$file:\t ${RED}KO${NC}"
	# fi 
done

echo "\n${BLUE}MAIN TESTS${NC}\n"

# Loop through all files in the ./tests folder that contain the word "test"
for file in ./tests/*test_*; do
	# Extract the numbers from the file
	numbers=$(cat "$file")

	# Execute the program "pushswap" with the numbers as arguments
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
