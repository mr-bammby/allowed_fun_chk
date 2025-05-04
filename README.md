# Forbidden Function Checker

This shell script, `forbidden_fun_chk.sh`, checks a given file for forbidden functions using the `nm` command. It compares a list of allowed functions against the undefined symbols (assumed to be standard library functions) found in the file, then outputs the allowed, found, and forbidden functions.

⚠️ **For final determination if forbbiden function was used the soure code should be checked.**

📓 **Please note that some standard functions call other standard functions. Functions called inside standard function will also be found by this script.**


## How It Works

The script uses `nm -u` to extract undefined symbols from the specified file. It takes a list of allowed functions (either from standard input or a file) and identifies any functions in the file that aren't on the allowed list. These are the "forbidden" functions. The results are displayed on standard output, with an option to save forbidden functions to a file.


## Usage

Run the script with this syntax:

```bash
./forbidden_fun_chk.sh [-i [input_file]] [-o [output_file]] file_to_test
```

### Options:
- `-i [input_file]`: Reads the list of allowed functions from `input_file`. Defaults to `allowed_fun.txt` if no file is specified.
- `-o [output_file]`: Writes the forbidden functions to `output_file`. Defaults to `forbidden_fun.txt` if no file is specified.
- `file_to_test`: The file to analyze (required).

If `-i` is omitted, the script reads the allowed functions from standard input.

## Input and Output Formats

### Input File Format
The input file (e.g., `allowed_fun.txt`) should contain a list of allowed functions, with each function on a separate line. For example:

```
malloc
free
printf
```

### Output File Format
If the `-o` option is used, the script generates an output file (e.g., `forbidden_fun.txt`) containing the list of forbidden functions, with each function on a separate line. For example:

```
scanf
exit
```

### Standard Output Format
The script prints three sections to the standard output:
- **ALLOWED FUNCTIONS**: Lists the functions from the input (allowed functions), each on a separate line.
- **FOUND FUNCTIONS**: Lists the functions found in the test file, each on a separate line.
- **FORBIDDEN FUNCTIONS**: Lists the functions that are found but not allowed, each on a separate line.

Example output:

```
ALLOWED FUNCTIONS:
malloc
free
printf

FOUND FUNCTIONS:
malloc
scanf
exit

FORBIDDEN FUNCTIONS:
scanf
exit
```

## Examples

### Using Input Redirection
Provide the allowed functions via input redirection:

```bash
./forbidden_fun_chk.sh test_file < allowed_fun.txt
```

### With Options
Use files for input and output:

```bash
./forbidden_fun_chk.sh -i allowed_fun.txt -o forbidden_fun.txt test_file
```

### Piping Input
Pipe the allowed functions into the script:

```bash
echo -e "malloc\nfree" | ./forbidden_fun_chk.sh test_file
```

## Step-by-Step Guide

1. **Clone the repository**:
   ```bash
   git clone https://github.com/mr-bammby/forbidden-function-checker.git
   ```

2. **Enter the directory**:
   ```bash
   cd forbidden-function-checker
   ```

3. **Set up the allowed functions**:
   - Create `allowed_fun.txt` with one function per line (e.g., `malloc`, `free`), or
   - Prepare to pipe or redirect the list into the script.

4. **Run the script**:
   - With input redirection:
     ```bash
     ./forbidden_fun_chk.sh test_file < allowed_fun.txt
     ```
   - With options:
     ```bash
     ./forbidden_fun_chk.sh -i allowed_fun.txt -o forbidden_fun.txt test_file
     ```
   - With piping:
     ```bash
     echo -e "malloc\nfree" | ./forbidden_fun_chk.sh test_file
     ```

5. **Review the results**:
   - Check the terminal output for allowed, found, and forbidden functions.
   - If `-o` was used, see the forbidden functions in the output file.

## Prerequisites

- **`nm` command**: Is preinstalled in most of Linux destributions.
  Part of the `binutils` package. Install it on Linux with:
  ```bash
  sudo apt install binutils  # Debian/Ubuntu
  sudo yum install binutils  # CentOS/RHEL
  ```

## Troubleshooting

- **No output**: Verify the file has undefined symbols with `nm -u test_file`.
- **Permission denied**: Make the script executable:
  ```bash
  chmod +x forbidden_fun_chk.sh
  ```
