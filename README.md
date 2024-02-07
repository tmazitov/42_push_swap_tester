# 42 Pushswap tester

## Install
1. Clone this repository:
	```bash
		git clone https://github.com/tmazitov/42_push_swap_tester.git 
	```
2. Extract `test.sh` file and `tests` folder into your Pushswap project root folder
3. Install `pushswap checker` on your computer from intra
4. Copy the path to the `pushswap checker` and paste to CHECKER_PATH variable inside the `test.sh` script
5. Run script:
	```bash
		bash ./test.sh
	``` 

## Settings

*  **CHECKER_PATH** - path to the pushswap checker ( from intra )

* **PUSHSWAP_PATH** - path to your pushswap program

* **PRINT_INPUT** - display input for each one test case
  
* **PRINT_OUTPUT** - display output for each one test case

*  **SHOW_NUMBERS** - if your pushswap print instructions like "sa pb and etc." and also you want to print stack elements this flag will help you to hide all non digit characters in your output
