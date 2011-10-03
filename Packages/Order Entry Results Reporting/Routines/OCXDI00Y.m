OCXDI00Y ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
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
 G ^OCXDI00Z
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.8:",.01,"E"
 ;;D^DEL CALL
 ;;R^"863.8:",.02,"E"
 ;;D^DEL CALL
 ;;R^"863.8:",1,1
 ;;D^tag^routine which deletes a record (instance) from a class file (i.e., an
 ;;R^"863.8:",1,2
 ;;D^object is deleted.)
 ;;R^"863.8:",2,"E"
 ;;D^ 
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter tag^routine
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^EDIT CALL
 ;;R^"863.8:",.01,"E"
 ;;D^EDIT CALL
 ;;R^"863.8:",.02,"E"
 ;;D^EDIT CALL
 ;;R^"863.8:",1,1
 ;;D^tag^routine which edits an existing record (instance) in a class file.
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter tag^routine for data type entry
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^LINE TAG
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^Enter the tag^routine which is the entry point to edit this data type
 ;;EOR^
 ;;KEY^863.8:^VIEW CALL
 ;;R^"863.8:",.01,"E"
 ;;D^VIEW CALL
 ;;R^"863.8:",.02,"E"
 ;;D^VIEW CALL
 ;;R^"863.8:",1,1
 ;;D^tag^routine which enables the user to view an existing record (instance)
 ;;R^"863.8:",1,2
 ;;D^in a class file.
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter tag^routine
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^VALUE CALL
 ;;R^"863.8:",.01,"E"
 ;;D^VALUE CALL
 ;;R^"863.8:",.02,"E"
 ;;D^VAL CALL
 ;;R^"863.8:",1,1
 ;;D^tag^routine which manages the dialogue for collecting and validating a value
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter tag^routine
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^CONDITION CALL
 ;;R^"863.8:",.01,"E"
 ;;D^CONDITION CALL
 ;;R^"863.8:",.02,"E"
 ;;D^COND CALL
 ;;R^"863.8:",1,1
 ;;D^tag^routine which manages the dialogue for selecting and validiating a
 ;;R^"863.8:",1,2
 ;;D^condition.
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Tag^routine which manages the contition
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^NUMERIC MAXIMUM
 ;;R^"863.8:",.01,"E"
 ;;D^NUMERIC MAXIMUM
 ;;R^"863.8:",.02,"E"
 ;;D^MAX
 ;;R^"863.8:",1,1
 ;;D^Maximum numeric value allowed.
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Maximum number allowed
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^POSITIVE INTEGER
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^MAX^OCXF6
 ;;EOR^
 ;;KEY^863.8:^NUMERIC MINIMUM
 ;;R^"863.8:",.01,"E"
 ;;D^NUMERIC MINIMUM
 ;;R^"863.8:",.02,"E"
 ;;D^MIN
 ;;R^"863.8:",1,1
 ;;D^Minimum numeric value allowed.
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Minimum nunber allowed
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^POSITIVE INTEGER
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^MIN^OCXF6
 ;;EOR^
 ;;KEY^863.8:^NUMERIC DECIMAL PLACES
 ;;R^"863.8:",.01,"E"
 ;;D^NUMERIC DECIMAL PLACES
 ;;R^"863.8:",.02,"E"
 ;;D^DEC
 ;;R^"863.8:",1,1
 ;;D^Number of decimal places allowed.
 ;;R^"863.8:",2,"E"
 ;;D^0
 ;;R^"863.8:","863.84:10",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:10",1,"E"
 ;;D^DEC^OCXF6
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^Enter the maximum number of decimal places allowed
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^POSITIVE INTEGER
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^NUMERIC MINIMUM
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^0
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^NUMERIC MAXIMUM
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^9
 ;;R^"863.8:","863.84:9",.01,"E"
 ;;D^NUMERIC DECIMAL PLACES
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^0
 ;;EOR^
 ;;KEY^863.8:^MASK OVERRIDE
 ;;R^"863.8:",.01,"E"
 ;;D^MASK OVERRIDE
 ;;R^"863.8:",.02,"E"
 ;;D^NO MASK
 ;;R^"863.8:",1,1
 ;;D^If certain conditions are used the standard validation params are void.
 ;;R^"863.8:",1,2
 ;;D^1=YES,0=NO
 ;;R^"863.8:",2,"E"
 ;;D^NO
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Ignore the validation code
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^YES NO
 ;;EOR^
 ;;KEY^863.8:^FM NAVIGATION CODE
 ;;R^"863.8:",.01,"E"
 ;;D^FM NAVIGATION CODE
 ;;R^"863.8:",.02,"E"
 ;;D^FMNAVCODE
 ;;R^"863.8:",1,1
 ;;D^String fed to EN1^DIP for generating a report.
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter the DR string for EN1^DIP
 ;1;
 ;
