# Shell Scripting: Discover How to Automate Command Line Tasks

These are notes and course work from the [Shell Scripting: Discover How to Automate Command Line Tasks](https://www.udemy.com/course/shell-scripting-linux/learn/lecture/3323076#overview) class by Jason Cannon.

A script is a command line program executed by an interpreter. Shell script is executed by a shell e.g., csh, bash, ksh, PowerShell, etc. Any commands you can run at the command line you can run as part of a shell script.

Before running a shell script, set the executible bit for the script before you can run it by executing. For example, the following enables the `script_name.sh` script located in the current directory for execution:

```sh
chmod 755 ./script_name.sh
```

You can then run the script with by calling it `./script_name.sh`. The script itself will look something like the following:

```csh
#!/bin/csh
echo "This script uses csh as the interpreter."
sleep 10
```

The first line of the script is the "shebag" and dictates what interpreter is used to run the script. Different shells take slightly different syntax. It's generally best practice to include a shebang; however, if not shebang is given, the script is interpreted by your current shell.

When you run a script, a new instance of the interpreter is started and the script is passed to the interpreter as an arugment.

Scripts can be run by programs beside the shell such as Python.

```python
#!/usr/bin/python
print('Testing')
```

Comments are prefixed with a hash (#). The interpreter ignores text in a comment.

You can define variables with-in a script using the syntax:

```sh
VARIABLE_NAME="THIS"
```

There is no space between the identifier, equal-sign, and the value. Variable names must begin with a letter, and they can contain alphanumeric characters and underscores. 

```sh
#!/bin/csh
phrase="amazing"

# Option-1: Add the variable prefixing it with a dollar sign
echo "This is $phrase"

# Option-2: Add the variable wrapping it in curly braces
echo "This is ${phrase}."
```

Option two is typically used when text immediately follows the variable's identifier.

You can capture the output from a call using backticks (older style) or dollar sign and parenthesis (new style):

```sh
#/bin/bash

# Option-1: 
server_name=`hostname`
echo "$hostname"

# Option-2: 
server_name=$(hostname)
echo "$server_name"
```

By default, all variables are global. You can create local variables with-in functions by preceeding them with the `local` keyword.

You can code conditional tests into your scripts using brackets: `[ condition-to-test-for ]`. For example, the following tests for the existence of the `passwd` file in `/etc/`:

```sh
[ -e /etc/passwd ]
```

The following are a list of common tests...

```
-d FILE_PATH    Returns true (0) if the file is a directory.
-e FILE_PATH    Returns true (0) if the file exists.
-f FILE_PATH    Returns true (0) if the file exists and is a regular file.
-r FILE_PATH    Returns true (0) if the file is readable by you
-s FILE_PATH    Returns true (0) if the file exist and isn't empty
-w FILE_PATH    Returns true (0) if the file is writable by you.
-x FILE_PATH    Returns true (0) if the file is executable by you.

-z STRING       Returns true (0) if the string is empty.
-n STRING       Returns true (0) if the string isn't empty.

The following return true (0) if the strings 1 and 2 are equal and not-equal respectively:

STRING1 = STRING2
STRING1 != STRING2

You can also do numeric equality comparisons:

var1 -eq var2   True (0) if arg1 is equal to arg2
var1 -ne var2   True (0) if arg1 is not equal to arg2
var1 -lt var2   True (0) if arg1 is less than arg2
var1 -le var2   True (0) if arg1 is less than or equal to arg2
var1 -gt var2   True (0) if arg1 is greater than arg2
var1 -ge var2   True (0) if arg1 is greater than or equal to arg2
```

False always equates to 1. For a complete list of tests, pull the manual page for test:

```sh
man test
```

Shells also include control flow statements such as `if` and `for`. `if` statements using the following syntax:

```sh
if [ condition ]
then
    ...
fi
```

```sh
if [ condition ]
then
    ...
elif []
then
    ...
fi
```

```sh
if [ condition ]
then
    ...command...
elif []
then
    ...command...
else
    ...command...
fi
```

For loops (similar to foreach loops), follow the syntax:

```sh
for VARIABLE_NAME in ITEM_1 ITEM_2
do
    ...command...
    ...command...
done
```

It is common practice to store the list in variable:

```sh
#!/bin/bash

PICS=$(ls *jpg)
DATE=$(date +%F)

for PIC in $PICS
do
    echo "Rename ${PIC} to ${DATE}-${PIC}"
    mv ${PIC} ${DATE}-${PIC}
done
```

The above adds the current date to JPG files in the current directory.

Scripts can accept parameters. You can access a parameter using it's positional variable:

```
$0      File's name

$@      All parameters; parametes greater than $1

$1      Parameter 1
$2      Parameter 2
$3      ...
```

If a parameter isn't present, the variable returns empty.

`shift` is a bash build-in command that removes the first argument from the argument's list. If we had a script `foo.sh`:

```sh
# Removes `adam`
echo $1; shift

# Removes `jenny
echo $1; shift

# Removes `mikey`
echo $1; shift
```

And, we called `foo.sh` with the following:

```sh
./foo.sh adam jenny mikey
```

You would see the following:

```
adam
jenny
mikey
```

You can prompt for a response using the `read` command:

```sh
# Captures the response in the variable `response_variable`
read -p "prompt" response_variable

# Captures several responses in respective variables.
# The last variable in the list gets the entire remaining
# response.
read -p "testing: " resp1 resp2
echo "response 1: ${resp1}"
echo "response 2: ${resp2}"
```

The prompt can be answered by a user at the terminal or pipeline value.

Everything executed on the command line returns a status code a.k.a., return code. Return codes can be anything from 0 thru 255. A return code of 0 indicates success. A return code greater than 0 indicates a failure, and the exact code indicates what the failure was. Programs can retrieve the status code of the last executed command from the `$?` variable.

```sh
ls /not/here
echo "$?"
```

You can leverage `$?` to determine whether it executed successfully:

```sh
#!/bin/bash

HOST="google.com"

ping -c 1 "$HOST"

if [ "$?" -eq "0" ]
then
    echo "Google is accessible."
else
    echo "Google is not accessible."
fi
```

You can leverage `$?` to run one command only if another command has completed successfully or failed. Alternatively, you can use the following syntax:

```sh
# command2 runs if command1 succeeds
command1 && command2
```

```sh
# command2 runs if command1 fails
command1 || command2
```

Separate commands are delimited by space (appear on separate lines) or semi-colon (they are separated by a semi-colon)

You can use the `exit` keyword to dictate the script's exit code.

```sh
ls /not/here
echo "$?"
exit 1
```

If a script omits the an exit statement, the return code of the last executed command is passed.

## Functions

A function is a named block of statements and/or commands. You can capture logic in a function then call it multiple times. You want to employ functions to replace code that repeats; following the _don't repeat yourself_ (DRY) principle.

Functions must be defined before they are executed (called).

```bash
#!/bin/bash

# Defines the function
function function-name() {
    # ...code here...
}

# Calls the function
function-name
```

Functions can be passed parameters. They appear using the same convention as script arguments e.g., $1, $2, $3, ...

```bash
#!/bin/bash

function foobar() {
    echo $1
    echo $2
}

foobar
```

Functions can call other functions. Just remember, the function must have been defined before it is executed.

```bash
#!/bin/bash

function foobar() {
    my_global_variable=19
    local my_local_variable=20
}

foobar
echo $my_global_variable
```

Variables defined with-in a function without the `local` keyword are global. They can be referenced outside the function; however, they must have been defined before being used. We can define local variables using the `local` keyword before the variable's identifier. You can only define local variables inside a function (vs. the body of the script).

```sh
local THINGER=1
```

**BEST PRACTICE**: You generally want to adhere to the following organization when writting shell scripts:

1. Comment describing what the script does and how to use it in a few lines at the top of the script.
2. Global variables
3. Functions
4. Script body
5. Exit status

**BEST PRACTICE:** Use local variables inside functions.

Functions, like scripts, can return an exit status code. You specify an exit code for a function with the `return` keyword.

```sh
#!/bin/bash

function thinger() {
    return 0
}

thinger
echo $?
```

If omitted the exit code is omitted from the function's definition, the exit status of a function is the exit status of the last command executed. To retrieve a function's exit code, interrogate the `$?`:

```sh
function backup_file() {
    local succeed=1
    local target_file_path=$1    

    if [ -f $target_file_path ]
    then
        local back="/tmp/$(basename ${target_file_path}).$(date +%F).$$"
        
        cp $target_file_path $back

        if [ $? -eq 0]
        then
            echo "Backup succeeded!"
            succeed=0
        else
            echo "Backup failed!"
        fi
        
        exit succeed
    fi
}

backup_file || logger -i -t $0 ERROR "Unable to backup file."
```

**NOTE:** The `$$` variable contains the PID of the process running the script.

## Wildcards

Scripts can make the same use of wildcards as operators can at the command prompt. 

```
*               matches zero or more characters
?               matches one character

[abc]           character class matching a, b, or c
[!abc]          character class matching anything but a, b, or c
[a-b]           match a range of characters, between a and b
[1-3]           match a range of numbers, between 1 and 3

[[:alpha:]]     matches all letters in the alphabet
[[:alnum:]]     matches all alphanumeric characters
[[:digit:]]     matches all numbers
[[:lower:]]     matches lower case letters in the alphabet
[[:space:]]     matches spaces
[[:upper:]]     matches upper case lettes in the alphabet

/       escape, used to escape a wild card character
```

You can use the `??` pattern to specify strings of a certain length:

```sh
# Remove characters that are two characters in length
rm ??
```

You can use wildcards in place of a list. When using wildcards in place of a list, the expression is evaluated into a list before the being run:

```sh
#!/bin/bash

cd /var/www

# The wildcard expands into a list
for FILE in *.html
do
    echo "Copying $FILE"
    cp "$FILE" /var/www-just-html
done
```

Case statements can be used as an alternative to if-statements. They're a good choice when you're comparing a single variable to several values each comparison triggering different actions.

The syntax for the case statement is as follows:

```sh
case "$var" in
    val1)
    # ...command...
    ;;
    val2)
    # ...command...
    ;;
    *)
    ;;
esac
```

`*)` is equivilant to `else` in an if-block. The options in a case statement are delimited by `;;`. The condition is appended by a closing parenthesis `)`.

You can employ wildcards in your case statements. For example, the following could be used to gauge accepted to a prompt with 'y', 'Y', or any case combination of 'yes':

```sh
case "$var" in
    [yY] | [yY][eE][sS])
    # ...command...
    ;;
    [nN] | [yY][eE][sS])
    # ...command...
    ;;
    *)
    ;;
esac
```

## Logging

You will employ logs to tell operators who, what, when, where, and why things happened.  MacOS and Linux system employ a centralized logging system named syslog. Depending on your operating system the log files can be found in one of the following locations:

/var/log/messages
/var/log/syslog

On MacOS, logs can be found in the following:

/var/log                            System Log Folder
/var/log/system.log                 System Log
/var/log/DiagnosticMessages         Mac Analytics Data
/Library/Logs                       System Application Logs
/Library/Logs/DiagnosticReports     System Reports
~/Library/Logs                      User Application Logs
~/Library/Logs/DiagnosticReports    User Reports

Messages can be logged to syslog with the `logger` command. The logger command takes several parameters:

* **facilities**, where messages originated from e.g., kern, mail, user, etc. local0, local1, local2, ..., and local7 are for custom facilities like scripts or user programs.
* **severity**, the importance of the message written to the log i.e., emerg, alert, crit, err, warning, notice, info, and debug

`logger` calls take the format:

```sh
# Log the message 
logger "message-about-thing-that-happened"

# Log the message and associate it to the local0 facility 
# with a severity of informational
logger -p local0.info "message-about-thing-that-happened"

# Tags the entry with the name of the script
logger -t my_script -p local0.info "message"

# -i includes the script's PID
logger -i -t my_script "message"
```

On MacOS, you'll use the `log` command to retrieve message from the system log:

```sh
% logger -is -t LogTest "Message4Me" 
% log show --predicate 'eventMessage contains "Message4Me"' --last 5m
```

While loops are written with the following syntax:

```sh
while [ condition ]
do
    # ...command...
    # ...command...
done
```

The while loop never runs if the condition isn't met. You can set a condition that can never be met with something like...

```sh
while true
do
    # ...command...
    # ...command...
    if [ condition ]
    then
        break
    fi
done
```

You can use the `break` to break out of the loop. You can use the `continue` keyword to skip to the next iteration of the loop. These statements can be used with other kinds of loops like for-loops.

By default, shell treats variable values like strings not numbers. BASH includes arithmetic expression, which let you evaluate a math expression. You place the expression in double paraenthesis: `((index++))` or `((index--))`. We're using the increment and decrement operators in our expressions.

```sh
idx=1

while [ $idx -lt 5 ]
do
    echo $idx
    ((index++))
done
```

You use a while loop to read a file.

You cannot read a file with a for loop. If you try to read a file with a for loop, it will read the file word-by-word. You need to use a while loop to read a file line-by-line.

Tne following uses the `read` command to read th contents of a file line by line:

```sh
#!/bin/bash

line_number=1

while read line
do
    echo "${line_number}: ${line}"
    ((line_number++))
done < /etc/notify.conf
```

Note your passing the file's contents into the loop.

You can pipe the output from a command into a while loop:

```sh
#!/bin/bash

line_number=1

ls /etc | while read line
do
    echo "${line_number}: ${line}"
    ((line_number++))
done
```

This lets you operate on each line from the output of `ls`.

## Debugging

BASH includes a built in debugging feature called x-trace, debugging, or tracing. Tracing prints commands, command arguments, and expanded wildcards to the console.

You can trace an entire program by adding `-x` to the shebang:

```sh
#!/bin/bash -x
```

You can wrap a block of code in a `set -x` command:

```sh
...command...

set -x
...command...
...command...
set +x

...command...
```

The result is the same in either case. The commands are printed to the console with a plus (+) in front of them. The text printed infront of the output (the plus) can be overriden by setting the `PS4` variable; by default `PS4` is set to the plus sign.

```
Option descriptions...

-x      Print commands, arguments, and expanded wildcards.
-e      Terminates your script if a program returns an exit code > 0.
-v      Prints lines from the script as they're exected.

Example calls...

#!/bin/bash -e
#!/bin/bash -x
#!/bin/bash -v
#!/bin/bash -ex
#!/bin/bash -exv

help set | less
```

Boolean values in BASH appear as `true` and `false`. You can use a flag in your script to enable or disable echo statements used to debug your program.

```sh
#!/bin/bash
DEBUG=true
$DEBUG || echo "Something happening"
```

You can use a wrapper function to put some formatting in your console output:

```sh
#!/bin/bash

debug() {
    echo "Executing: $@"
}

DEBUG=true
$DEBUG || debug "Something happening"
```

You can use the following technique to print certain lines when debugging:

```sh
#!/bin/bash
DEBUG="echo"
$DEBUG hostname
```

You would just comment out the DEBUG variable when not debugging the script.

## Windows vs. *nix

New lines are marked with different characters on *nix and Windows systems:

```
Linux       Line Feed (LF)
Windows     Carraige Return and Line Feed (CRLF)
```

Scripts with Windows line endings won't run on *nix systems. The interpreter will choke on the carraige returns. You can determine if a file has *nix line endings (LF) or Windows line endings (CRLF) with `file`:

```sh
file thinger.sh
```

If the `thinger.sh` file has Windows style line endings, the call will return:

```sh
thinger.sh: Bourne-Again shell script text executable, ASCII text, with CRLF line terminators
```

There are two programs that allow you to easiy adjust the line endings based on the system you're using a script on:

```
dos2unix    Converts file to *nix compatible line endings
unix2dos    Converts file to Windows compatible line endings
```

On MacOS, you can install these with Homebrew.

```sh
brew install dos2unix
```

## sed

A stream is data that travels from...

1. One process to another through a pipe
2. One file to another through a redirect
3. One device to another.

`sed` is a **s**tream **ed**itor. It filters and transforms text as its streamed. Check sed's man page for a full list of flags and arguments.

sed is most commonly used to replicate find and replace at the command line. sed can be run directly against files with the syntax:

```sh
echo 'Elf is a smart player!' > ./sample.txt

# Substitute the word smart with tenacious
sed 's/smart/tenacious/' sample.txt
```
sed calls take the form:
```
sed 's/search-pattern/replacement-string/flags'
```
By convention, users delimit the search string with forward slashes, but you can use whatever character you'd like.

```
sed 's#search-pattern#replacement-string#flags'
```
The first delimiter will expected throughout the search string.

The target (thing you're replacing) in the search string is case sensitive by default. You can disregard the string's case by using the `i` flag.

```sh
# Substitute the word smart with tenacious regardless of case
sed 's/sMaRt/tenacious/i' sample.txt
```
The flags portion of the search string lets you adjust where and how sed searches for the target. You can include multiple flags with a transformation.

By default, sed transforms the first occurrence of the target on a line. Meaning, if you're turning "thinger" into "thanger" and "thinger" appears twice on a line, only the first occurrence of "thinger" will be transformed.If you want it to transform all occurrences on a line, you need to include the `g` flag.

```sh
# Substitutes all occurrences of `umm` with `err` 
# on a line
sed 's/umm/err/g' sample.txt

# Substitutes all occurrences of `umm` with `err` 
# on a line regardless of the case of `umm`
sed 's/umm/err/ig' sample.txt
```

If you only want to replace the #th occurrence of a target on a line, you can do that with the following syntax:

```sh
# Substitutes the second occurrence of `umm` with `err`
sed 's/umm/err/2' sample.txt
```

Running sed on a file's contents won't change alter the file. To update the file, you either need to redirect the output of sed back to the file, or use the `-i` option.

```sh
# Makes the change to the source file.
sed -i 's/thinger/thanger/i' stuff.txt

# Makes a backup and makes the change to the source file
sed -i.bak 's/thinger/thanger/i' stuff.txt
```

The second option (in the above) makes a backup of the file before modifying it. The backup is saved as `stuff.txt.bak`.

You can stream files into sed:

```sh
cat filename.txt | sed 's/thinger/thanger/ig'
echo 'whatevers' | sed 's/whatever/whatev/i'
```

You can escape delimiters in the search string with the backslash. Just keep in mind, you can make the delimiters whatever you like.

You can remove lines from a stream with the `d` flag:

```sh
# removes all lines that contain love
cat sample.txt | sed 's/abc/id/'
```

Operators can delete lines that match a given pattern:

```sh
sed '/^#/d' config

# Deletes blank lines
sed '/^$/d' config
```

You can specify multiple transformations in a single call to sed. You can delimit transformations by semi-colons or the -e option. The following two calls to sed are symantically identical:

```sh
# Multiple transformations delimited by semicolon
sed '/^#/d'; '/^$/d' config

# Multiple transformations delimited by `-e`
sed -e '/^#/d' -e '/^$/d' config
```

Alternatively, you can put your sed commands in a file then reference the file in your call to sed.

```sh
sed -f file_with_transformations.sed file_to_transform.txt
```

By default, all lines in a file are evaluated by sed, but you can dictate which lines are evaluated. You indicate which lines should be evaluated using sed addresses. This is where you specify which line or lines should be evluated.

```sh
# Evaluate line 2
sed '2 s/apache/httpd/' config

# Evaluate lines 1 and 3
sed '1,3 s/apache/httpd/' config

# Evaluate the lines that include "group"
sed '/Group/ s/apache/httpd/' config
```

## Random Commands

When you don't want to see the output of a command, you can pipe the output to `/dev/null`.

The `sleep` command waits a specified number of seconds. It uses the syntax: `sleep <seconds>`.

You can use the `dirname` command to grab the path portion of a file name.

You can use `basename` to grab the file name portion of a path. The following will remove the file type from the file name.

```sh
basename -s .xlsx 'fully_qualified_file_name'
```

You can determine whether something is a program, function, etc. using the `type` command in BASH. For example: `type -a sed`.