ORY26701 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*267) ;OCT 23,2006 at 10:42
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**267**;Dec 17,1997;Build 6
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY267ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY26702
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
 ;;KEY^863.8:^DIC
 ;;R^"863.8:",.01,"E"
 ;;D^DIC
 ;;R^"863.8:",.02,"E"
 ;;D^DIC
 ;;R^"863.8:",1,1
 ;;D^An open reference used to specify the file in a DIC lookup
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^DIC
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^1
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter the name of the file you are pointing to
 ;;EOR^
 ;;KEY^863.8:^DIC LOOKUP INDEX STRING
 ;;R^"863.8:",.01,"E"
 ;;D^DIC LOOKUP INDEX STRING
 ;;R^"863.8:",.02,"E"
 ;;D^DICIX
 ;;R^"863.8:",1,1
 ;;D^Contains the names of indices to be used in a DIC lookup in a comma
 ;;R^"863.8:",1,2
 ;;D^delimited string.
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter a DIC lookup index string
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^This is an '^' delimited string which contains the names of indices which are to be used in a DIC lookup; e.g., B^C^DOB.
 ;;EOR^
 ;;KEY^863.8:^FILE
 ;;R^"863.8:",.01,"E"
 ;;D^FILE
 ;;R^"863.8:",.02,"E"
 ;;D^FILE
 ;;R^"863.8:",1,1
 ;;D^The internal entry number of a file.
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^File
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^DIC
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^1
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
 ;;KEY^863.8:^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:",.02,"E"
 ;;D^FMAX
 ;;R^"863.8:",1,1
 ;;D^Maximum string length allowed
 ;;R^"863.8:",2,"E"
 ;;D^245
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Maximum text string length allowed
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^FMAX^OCXF6
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^POSITIVE INTEGER
 ;;EOR^
 ;;KEY^863.8:^HELP MESSAGE
 ;;R^"863.8:",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:",.02,"E"
 ;;D^HELP
 ;;R^"863.8:",1,1
 ;;D^A text string 1-250 characters long which overrides the Fileman help
 ;;R^"863.8:",1,2
 ;;D^message.
 ;;R^"863.8:","863.84:10",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:10",1,"E"
 ;;D^Enter a brief help message
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:9",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^HELP^OCXF6
 ;;EOR^
 ;;KEY^863.8:^LOOP QUERY
 ;;R^"863.8:",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"863.8:",.02,"E"
 ;;D^LOOP QUERY
 ;;R^"863.8:",1,1
 ;;D^Alternate query used when repeated answers are required
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter loop query text
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^This is the query text for all entries after the first one
 ;;EOR^
 ;;KEY^863.8:^MANDATORY MESSAGE
 ;;R^"863.8:",.01,"E"
 ;;D^MANDATORY MESSAGE
 ;;R^"863.8:",.02,"E"
 ;;D^MAND MSG
 ;;R^"863.8:",1,1
 ;;D^Message sent to user telling him that his entry is mandatory
 ;;R^"863.8:",2,"E"
 ;;D^Mandatory answer.  You must enter a value or '^' to exit.
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter message
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^OCXO DATA DRIVE SOURCE
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO DATA DRIVE SOURCE
 ;;EOR^
 ;;KEY^863.8:^OCXO EXTERNAL FUNCTION CALL
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO EXTERNAL FUNCTION CALL
 ;;EOR^
 ;;KEY^863.8:^OCXO FILE POINTER
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO FILE POINTER
 ;;EOR^
 ;;KEY^863.8:^OCXO GENERATE CODE FUNCTION
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO GENERATE CODE FUNCTION
 ;;R^"863.8:",.02,"E"
 ;;D^GEN
 ;;EOR^
 ;;KEY^863.8:^OCXO HL7 SEGMENT ID
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO HL7 SEGMENT ID
 ;;R^"863.8:",.02,"E"
 ;;D^HL7SEGID
 ;;EOR^
 ;;KEY^863.8:^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;EOR^
 ;;KEY^863.8:^OCXO VARIABLE NAME
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;EOR^
 ;;KEY^863.8:^OCXO VT-BAR PIECE NUMBER
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO VT-BAR PIECE NUMBER
 ;;EOR^
 ;;KEY^863.8:^PRIMARY DATA FIELD
 ;;R^"863.8:",.01,"E"
 ;;D^PRIMARY DATA FIELD
 ;;R^"863.8:",.02,"E"
 ;;D^PDFLD
 ;;R^"863.8:",1,1
 ;;D^ 
 ;;R^"863.8:",1,2
 ;1;
 ;
