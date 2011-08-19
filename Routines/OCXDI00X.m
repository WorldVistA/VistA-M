OCXDI00X ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^OCXDIAG
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXDIAG",$J,$O(^TMP("OCXDIAG",$J,"A"),-1)+1)=TEXT
 ;
 G ^OCXDI00Y
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^B^C
 ;;EOR^
 ;;KEY^863.8:^DATE SPECIAL MASK
 ;;R^"863.8:",.01,"E"
 ;;D^DATE SPECIAL MASK
 ;;R^"863.8:",.02,"E"
 ;;D^DATE MASK
 ;;R^"863.8:",1,1
 ;;D^Executable code using the date in internal FM format and returning a
 ;;R^"863.8:",1,2
 ;;D^truth value which checks the validity of the date outside of %DT
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Date mask code
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^MUMPS CODE
 ;;EOR^
 ;;KEY^863.8:^FM MASK
 ;;R^"863.8:",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:",.02,"E"
 ;;D^FM MASK
 ;;R^"863.8:",1,1
 ;;D^Tag^routine where code is located to parse the FM DD and override the parameter value
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter tag^routine where the FM MASK parser is located
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^REPEAT
 ;;R^"863.8:",.01,"E"
 ;;D^REPEAT
 ;;R^"863.8:",.02,"E"
 ;;D^REPEAT
 ;;R^"863.8:",1,1
 ;;D^Continue to repeat the dialogue untile the user enters a null string or
 ;;R^"863.8:",1,2
 ;;D^he 'hats' out.  1='YES' and 0='NO'
 ;;R^"863.8:",2,"E"
 ;;D^NO
 ;;R^"863.8:","863.84:13",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:13",1,"E"
 ;;D^YES NO
 ;;EOR^
 ;;KEY^863.8:^CASE
 ;;R^"863.8:",.01,"E"
 ;;D^CASE
 ;;R^"863.8:",.02,"E"
 ;;D^CASE
 ;;R^"863.8:",1,1
 ;;D^Translate lowercase user input to uppercase.  1='YES',0="NO"
 ;;R^"863.8:",2,"E"
 ;;D^1
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^Translate lowercase to uppercase
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^YES NO
 ;;EOR^
 ;;KEY^863.8:^OUTPUT VARIABLE
 ;;R^"863.8:",.01,"E"
 ;;D^OUTPUT VARIABLE
 ;;R^"863.8:",.02,"E"
 ;;D^OUTVAR
 ;;R^"863.8:",1,1
 ;;D^The name of a variable which stores the output of a function.  Can be
 ;;R^"863.8:",1,2
 ;;D^a local or a global and may be the root of an array; e.g., 'Y(1)'
 ;;R^"863.8:",2,"E"
 ;;D^Y
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter the closed reference
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Must be the name of a local or global variable in closed reference format
 ;;EOR^
 ;;KEY^863.8:^DONT LIST
 ;;R^"863.8:",.01,"E"
 ;;D^DONT LIST
 ;;R^"863.8:",.02,"E"
 ;;D^DONT LIST
 ;;R^"863.8:",1,1
 ;;D^Don't list choices in user dialogue.  1=DON'T LIST,0=LIST
 ;;R^"863.8:",2,"E"
 ;;D^List
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Want to prevent the display ofthe list of choices
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^BINARY
 ;;R^"863.8:","863.84:9",.01,"E"
 ;;D^SET CODES
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^1:DON'T LIST;0:LIST
 ;;EOR^
 ;;KEY^863.8:^PROMPT
 ;;R^"863.8:",.01,"E"
 ;;D^PROMPT
 ;;R^"863.8:",.02,"E"
 ;;D^PROMPT
 ;;R^"863.8:",1,1
 ;;D^Special user prompt in the I/O dialogue.
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter prompt
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^30
 ;;EOR^
 ;;KEY^863.8:^SET CODES
 ;;R^"863.8:",.01,"E"
 ;;D^SET CODES
 ;;R^"863.8:",.02,"E"
 ;;D^CODES
 ;;R^"863.8:",1,1
 ;;D^A set of codes string in FM format.
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^SET^OCXF6
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^CODE STRING
 ;;EOR^
 ;;KEY^863.8:^HELP FRAME
 ;;R^"863.8:",.01,"E"
 ;;D^HELP FRAME
 ;;R^"863.8:",.02,"E"
 ;;D^HELP FRAME
 ;;R^"863.8:",1,1
 ;;D^If, during the user dialogue, he enters a '??' a help frame will be displayed
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^Enter help frame
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^DIC
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^9.4
 ;;EOR^
 ;;KEY^863.8:^ADD CALL
 ;;R^"863.8:",.01,"E"
 ;;D^ADD CALL
 ;;R^"863.8:",.02,"E"
 ;;D^ADD CALL
 ;;R^"863.8:",1,1
 ;;D^tag^routine which adds a new record (instance) to a class file (i.e., a
 ;;R^"863.8:",1,2
 ;;D^new object is created by this code).
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter tag^routine for entering a new object
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^DEL CALL
 ;1;
 ;
