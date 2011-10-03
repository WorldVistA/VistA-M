ORY22102 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*221) ;AUG 30,2005 at 11:41
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
 G ^ORY22103
 ;
 Q
 ;
DATA ;
 ;
 ;;D^SET CODES
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^T:TIME ALLOWED;R:TIME REQUIRED
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
 ;;KEY^863.8:^HELP FRAME MESSAGE
 ;;R^"863.8:",.01,"E"
 ;;D^HELP FRAME MESSAGE
 ;;R^"863.8:",.02,"E"
 ;;D^HF MSG
 ;;R^"863.8:",1,1
 ;;D^Message to the user that, in addition to the normal help text, a help
 ;;R^"863.8:",1,2
 ;;D^frame is available.
 ;;R^"863.8:",2,"E"
 ;;D^Do you want to view a more detailed help message
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Help frame request message
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
 ;;KEY^863.8:^OCXO NULL VALUE ALLOWED
 ;;R^"863.8:",.01,"E"
 ;;D^OCXO NULL VALUE ALLOWED
 ;;R^"863.8:",.02,"E"
 ;;D^NVAL
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
 ;;D^  Primary data field in a comparison expression that
 ;;R^"863.8:",1,3
 ;;D^ is to be tested.
 ;;R^"863.8:",1,4
 ;;D^ 
 ;;EOR^
 ;;KEY^863.8:^QUERY
 ;;R^"863.8:",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:",.02,"E"
 ;;D^QUERY
 ;;R^"863.8:",1,1
 ;;D^Used with methods that manage interactive dialogues.  Equivalent to DIC("A")
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter the query (free text string)
 ;;EOR^
 ;;KEY^863.8:^REPEAT THE QUERY
 ;;R^"863.8:",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"863.8:",.02,"E"
 ;;D^LOOP
 ;;R^"863.8:",1,1
 ;;D^Set this = 1 to repetitively ask the user to enter a value
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^YES NO
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Answer 'YES' if you want the user to repetitively enter a value.
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Is the query repetitive
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
 ;1;
 ;
