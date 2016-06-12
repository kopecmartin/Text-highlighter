#Text highlighter


##About
Script was implemented in PHP5 as a school project. The script emphasizes parts of a text according to a format file. The format file contains table of regular expressions where one or several format commands are assigned to one regular expression.


##Parameters
- --help 
- --format=filename - format file
- --input=filename - input file, if this parameter is missing, input file is expected in standard input
- --output=filename - output file, if this parameter is missing, script output is printed to standard output
- --br - \<br /> tag will be added at the end of each line of an output text after format commands were applied


##Format file
Syntax of a format file:
```
<regular expression>\t+<list of format commands>
```

**Format commands:**  
```
- bold      => <b>text</b> 
- italic    => <i>text</i> 
- underline => <u>text</u>
- teletype  => <tt>text</tt> 
- size:[number] = font size where number is in range <1,7> => <font size=[number]>text</font>
- color:[hex] = font color where hex means hexadecimal number in range <000000,FFFFFF> => <font color=#[hex]>text</font>
```

**Regular expressions:**  
If A and B are regular expressions, then:
- A.B = AB => A and B
- A|B => A or B
- !A  => not A
- A*  => zero or more occurences of A
- A+  => one or more occurences of A
- (A) =>

Priority of operators: ! > *,+ > . > |

**Special regular expressions:**
- %s => whitespace character (\t,\n,\r,\f,\v)
- %a => matches any character 
- %d => number in range \<0,9>
- %l => lowercase letters from a to z
- %L => uppercase letters from A to Z
- %w => (%l|%L)
- %W => (%w|%d)
- %t => tab character (\t)
- %n => newline character (\n)
- %<special symbol> => escapes special character (.|!*+()%)
