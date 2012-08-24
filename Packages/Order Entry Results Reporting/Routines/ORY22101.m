ORY22101 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*221) ;AUG 30,2005 at 11:41
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**221**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY221ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY22102
 ;
 Q
 ;
DATA ;
 ;
 ;;ROOT^OCXS(860.2,0)^ORDER CHECK RULE^860.2I
 ;;ROOT^OCXS(860.3,0)^ORDER CHECK ELEMENT^860.3
 ;;ROOT^OCXS(860.4,0)^ORDER CHECK DATA FIELD^860.4I
 ;;ROOT^OCXS(860.5,0)^ORDER CHECK DATA SOURCE^860.5
 ;;ROOT^OCXS(860.6,0)^ORDER CHECK DATA CONTEXT^860.6
 ;;ROOT^OCXS(860.8,0)^ORDER CHECK COMPILER FUNCTIONS^860.8
 ;;ROOT^OCXS(860.9,0)^ORDER CHECK NATIONAL TERM^860.9
 ;;ROOT^OCXS(863,0)^OCX MDD CLASS^863
 ;;ROOT^OCXS(863.1,0)^OCX MDD APPLICATION^863.1
 ;;ROOT^OCXS(863.2,0)^OCX MDD SUBJECT^863.2
 ;;ROOT^OCXS(863.3,0)^OCX MDD LINK^863.3I
 ;;ROOT^OCXS(863.4,0)^OCX MDD ATTRIBUTE^863.4
 ;;ROOT^OCXS(863.5,0)^OCX MDD VALUES^863.5
 ;;ROOT^OCXS(863.6,0)^OCX MDD METHOD^863.6
 ;;ROOT^OCXS(863.7,0)^OCX MDD PUBLIC FUNCTION^863.7
 ;;ROOT^OCXS(863.8,0)^OCX MDD PARAMETER^863.8
 ;;ROOT^OCXS(863.9,0)^OCX MDD CONDITION/FUNCTION^863.9I
 ;;ROOT^OCXS(864,0)^OCX MDD SITE PREFERENCES^864P
 ;;ROOT^OCXS(864.1,0)^OCX MDD DATATYPE^864.1
 ;;ROOT^OCXD(860.1,0)^ORDER CHECK PATIENT ACTIVE DATA^860.1P
 ;;ROOT^OCXD(860.7,0)^ORDER CHECK PATIENT RULE EVENT^860.7P
 ;;ROOT^OCXD(861,0)^ORDER CHECK RAW DATA LOG^861
 ;;SOF^863.8  OCX MDD PARAMETER
 ;;KEY^863.8:^COMPARISON VALUE
 ;;R^"863.8:",.01,"E"
 ;;D^COMPARISON VALUE
 ;;R^"863.8:",.02,"E"
 ;;D^CVAL
 ;;R^"863.8:",1,1
 ;;D^ 
 ;;R^"863.8:",1,2
 ;;D^   This is a value to be compared with PRIMARY DATA FIELD
 ;;R^"863.8:",1,3
 ;;D^ in a truth conditional.
 ;;R^"863.8:",1,4
 ;;D^ 
 ;;EOR^
 ;;KEY^863.8:^CONDITION CALL
 ;;R^"863.8:",.01,"E"
 ;;D^CONDITION CALL
 ;;R^"863.8:",.02,"E"
 ;;D^COND CALL
 ;;R^"863.8:",1,1
 ;;D^tag^routine which manages the dialogue for selecting and validating a
 ;;R^"863.8:",1,2
 ;;D^condition.
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Tag^routine which manages the condition
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^DATA TYPE
 ;;R^"863.8:",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:",.02,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:",1,1
 ;;D^An MDD data type; i.e., an entry in the OCX MDD DATA TYPE file.
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Enter the datatype
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^DIC
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^864.1
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"863.8:","863.84:9",.01,"E"
 ;;D^DIC LOOKUP INDEX STRING
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^B^C
 ;;EOR^
 ;;KEY^863.8:^DATE EXACT
 ;;R^"863.8:",.01,"E"
 ;;D^DATE EXACT
 ;;R^"863.8:",.02,"E"
 ;;D^DATE X
 ;;R^"863.8:",1,1
 ;;D^Exact date required.  "X"=EXACT DATE REQUIRED
 ;;R^"863.8:","863.84:10",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:10",1,"E"
 ;;D^DEX^OCXF6
 ;;R^"863.8:","863.84:11",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:11",1,"E"
 ;;D^SET OF CODES
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^Enter an 'X' if exact date is required
 ;;R^"863.8:","863.84:9",.01,"E"
 ;;D^SET CODES
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^X:EXACT DATE REQUIRED
 ;;EOR^
 ;;KEY^863.8:^DATE INPUT FORMAT
 ;;R^"863.8:",.01,"E"
 ;;D^DATE INPUT FORMAT
 ;;R^"863.8:",.02,"E"
 ;;D^DATE INPUT
 ;;R^"863.8:",1,1
 ;;D^Can numeric input format (MMDDYY) be used? "N"=NO
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Enter 'N' if numeric date input (MMDDYY) cannot be used
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^SET CODES
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^N:NO
 ;;R^"863.8:","863.84:9",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^SET OF CODES
 ;;EOR^
 ;;KEY^863.8:^DATE LIMIT
 ;;R^"863.8:",.01,"E"
 ;;D^DATE LIMIT
 ;;R^"863.8:",.02,"E"
 ;;D^DATE LIM
 ;;R^"863.8:",1,1
 ;;D^Equivalent to %DT(0); e.g., 2940101=MUst be > or = to 1/1/94, -2940101=
 ;;R^"863.8:",1,2
 ;;D^Must be < or = 1/1/94
 ;;R^"863.8:",2,"E"
 ;;D^ 
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Max or min date allowed [(-)yyymmdd]
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FILEMAN DATE INTERNAL FORMAT
 ;;EOR^
 ;;KEY^863.8:^DATE MAXIMUM
 ;;R^"863.8:",.01,"E"
 ;;D^DATE MAXIMUM
 ;;R^"863.8:",.02,"E"
 ;;D^DATE MAX
 ;;R^"863.8:",1,1
 ;;D^Maximum date allowed in internal FM format
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Maximum date
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^FILEMAN DATE INTERNAL FORMAT
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^DMAX^OCXF6
 ;;EOR^
 ;;KEY^863.8:^DATE MINIMUM
 ;;R^"863.8:",.01,"E"
 ;;D^DATE MINIMUM
 ;;R^"863.8:",.02,"E"
 ;;D^DATE MIN
 ;;R^"863.8:",1,1
 ;;D^Earliest date allowed
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Enter earliest date allowed
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^FILEMAN DATE INTERNAL FORMAT
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^DMIN^OCXF6
 ;;EOR^
 ;;KEY^863.8:^DATE SECONDS
 ;;R^"863.8:",.01,"E"
 ;;D^DATE SECONDS
 ;;R^"863.8:",.02,"E"
 ;;D^DATE SEC
 ;;R^"863.8:",1,1
 ;;D^Seconds allowed and returned.  "S"=SECONDS RETURNED
 ;;R^"863.8:","863.84:10",.01,"E"
 ;;D^SET CODES
 ;;R^"863.8:","863.84:10",1,"E"
 ;;D^S:SECONDS RETURNED
 ;;R^"863.8:","863.84:11",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:11",1,"E"
 ;;D^DSEC^OCXF6
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^Enter 'S' if you want seconds returned
 ;;R^"863.8:","863.84:9",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^SET OF CODES
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
 ;;KEY^863.8:^DATE SPECIAL OUTPUT FORMAT
 ;;R^"863.8:",.01,"E"
 ;;D^DATE SPECIAL OUTPUT FORMAT
 ;;R^"863.8:",.02,"E"
 ;;D^DATE OUT
 ;;R^"863.8:",1,1
 ;;D^M code which transforms internal FM date format to external format
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Output format code
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^MUMPS CODE
 ;;EOR^
 ;;KEY^863.8:^DATE TIME
 ;;R^"863.8:",.01,"E"
 ;;D^DATE TIME
 ;;R^"863.8:",.02,"E"
 ;;D^DATE TIME
 ;;R^"863.8:",1,1
 ;;D^Can time be entered along with the date? "T"=TIME ALLOWED, "R"=TIME REQUIRED
 ;;R^"863.8:","863.84:10",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:10",1,"E"
 ;;D^SET OF CODES
 ;;R^"863.8:","863.84:11",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:11",1,"E"
 ;;D^DTIME^OCXF6
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^Time parameter
 ;;R^"863.8:","863.84:9",.01,"E"
 ;1;
 ;
