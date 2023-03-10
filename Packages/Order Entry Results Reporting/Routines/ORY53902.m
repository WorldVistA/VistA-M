ORY53902 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*539) ;JAN 13,2021 at 11:13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**539**;Dec 17,1997;Build 41
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY539ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY53903
 ;
 Q
 ;
DATA ;
 ;
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
 ;;KEY^863.8:^TERMINATOR
 ;;R^"863.8:",.01,"E"
 ;;D^TERMINATOR
 ;;R^"863.8:",.02,"E"
 ;;D^TERMINATOR
 ;;R^"863.8:",1,1
 ;;D^A text string terminator; e.g., '?', ': ', '=>'
 ;;R^"863.8:",2,"E"
 ;;D^:
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter text string terminator
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^9
 ;;EOR^
 ;;KEY^863.8:^VALUE CALL
 ;;R^"863.8:",.01,"E"
 ;;D^VALUE CALL
 ;;R^"863.8:",.02,"E"
 ;;D^VAL CALL
 ;;R^"863.8:",.03,"E"
 ;;D^NO
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
 ;;EOF^OCXS(863.8)^1
 ;;SOF^864.1  OCX MDD DATATYPE
 ;;KEY^864.1:^BOOLEAN
 ;;R^"864.1:",.01,"E"
 ;;D^BOOLEAN
 ;;R^"864.1:",.02,"E"
 ;;D^BOOL
 ;;EOR^
 ;;KEY^864.1:^FREE TEXT
 ;;R^"864.1:",.01,"E"
 ;;D^FREE TEXT
 ;;R^"864.1:",.02,"E"
 ;;D^FT
 ;;R^"864.1:",2,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^FT^OCXFDFT
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^Enter a free text string
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^240
 ;;R^"864.1:","864.11:4",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:4",1,"E"
 ;;D^Enter a free text string.  Do not use control characters.  |FTMM HELP|
 ;;R^"864.1:","864.11:5",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"864.1:","864.11:5",1,"E"
 ;;D^Enter another free text string
 ;;R^"864.1:","864.11:6",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:6",1,"E"
 ;;D^0
 ;;EOR^
 ;;KEY^864.1:^GENERIC
 ;;R^"864.1:",.01,"E"
 ;;D^GENERIC
 ;;R^"864.1:",.02,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:11",.01,"E"
 ;;D^MANDATORY MESSAGE
 ;;R^"864.1:","864.11:11",1,"E"
 ;;D^This answer is mandatory.  Enter a response or press '^' to exit.
 ;;R^"864.1:","864.11:12",.01,"E"
 ;;D^TERMINATOR
 ;;R^"864.1:","864.11:12",1,"E"
 ;;D^:
 ;;R^"864.1:","864.11:13",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"864.1:","864.11:13",1,"E"
 ;;D^Enter another value
 ;;R^"864.1:","864.11:7",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:7",1,"E"
 ;;D^GEN^OCXFDMOM
 ;;R^"864.1:","864.11:8",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:8",1,"E"
 ;;D^Enter a value
 ;;R^"864.1:","864.11:9",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:9",1,"E"
 ;;D^ 
 ;;EOR^
 ;;KEY^864.1:^NUMERIC
 ;;R^"864.1:",.01,"E"
 ;;D^NUMERIC
 ;;R^"864.1:",.02,"E"
 ;;D^NUMERIC
 ;;R^"864.1:",2,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^NU^OCXFDNU
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^Enter a number
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^LOOP QUERY
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^Enter another number
 ;;R^"864.1:","864.11:4",.01,"E"
 ;;D^REPEAT THE QUERY
 ;;R^"864.1:","864.11:4",1,"E"
 ;;D^0
 ;;EOR^
 ;;EOF^OCXS(864.1)^1
 ;;SOF^863.7  OCX MDD PUBLIC FUNCTION
 ;;KEY^863.7:^GCC BOOLEAN LOGICAL FALSE
 ;;R^"863.7:",.01,"E"
 ;;D^GCC BOOLEAN LOGICAL FALSE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",3,"E"
 ;;D^FALSE^OCXF23
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^PRIMARY DATA FIELD
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;EOR^
 ;;KEY^863.7:^GCC BOOLEAN LOGICAL TRUE
 ;;R^"863.7:",.01,"E"
 ;;D^GCC BOOLEAN LOGICAL TRUE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",3,"E"
 ;;D^TRUE^OCXF23
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^PRIMARY DATA FIELD
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;EOR^
 ;;EOF^OCXS(863.7)^1
 ;;SOF^863.9  OCX MDD CONDITION/FUNCTION
 ;;KEY^863.9:^LOGICAL FALSE
 ;;R^"863.9:",.01,"E"
 ;;D^LOGICAL FALSE
 ;;R^"863.9:",.02,"E"
 ;;D^BOOLEAN
 ;;R^"863.9:",.03,"E"
 ;;D^GCC BOOLEAN LOGICAL FALSE
 ;;R^"863.9:",.04,"E"
 ;;D^IS FALSE
 ;;R^"863.9:","863.91:1",.01,"E"
 ;;D^OCXO GENERATE CODE FUNCTION
 ;;R^"863.9:","863.91:1",1,"E"
 ;;D^GCC BOOLEAN LOGICAL FALSE
 ;;R^"863.9:","863.92:1",.01,"E"
 ;;D^FALSE
 ;;EOR^
 ;;KEY^863.9:^LOGICAL TRUE
 ;;R^"863.9:",.01,"E"
 ;;D^LOGICAL TRUE
 ;;R^"863.9:",.02,"E"
 ;;D^BOOLEAN
 ;;R^"863.9:",.03,"E"
 ;;D^GCC BOOLEAN LOGICAL TRUE
 ;;R^"863.9:",.04,"E"
 ;;D^IS TRUE
 ;;R^"863.9:","863.91:1",.01,"E"
 ;;D^OCXO GENERATE CODE FUNCTION
 ;;R^"863.9:","863.91:1",1,"E"
 ;;D^GCC BOOLEAN LOGICAL TRUE
 ;;R^"863.9:","863.92:1",.01,"E"
 ;;D^TRUE
 ;;EOR^
 ;;EOF^OCXS(863.9)^1
 ;;SOF^863.4  OCX MDD ATTRIBUTE
 ;;KEY^863.4:^DATE/TIME
 ;;R^"863.4:",.01,"E"
 ;;D^DATE/TIME
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^IEN
 ;;R^"863.4:",.01,"E"
 ;;D^IEN
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^NUMERIC
 ;;EOR^
 ;;KEY^863.4:^ORDER FLAGGED
 ;;R^"863.4:",.01,"E"
 ;;D^ORDER FLAGGED
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^BOOLEAN
 ;;EOR^
 ;;KEY^863.4:^ORDER PATIENT
 ;;R^"863.4:",.01,"E"
 ;;D^ORDER PATIENT
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^NUMERIC
 ;;EOR^
 ;;EOF^OCXS(863.4)^1
 ;;SOF^863.2  OCX MDD SUBJECT
 ;;KEY^863.2:^PATIENT
 ;;R^"863.2:",.01,"E"
 ;;D^PATIENT
 ;;R^"863.2:","863.21:1",.01,"E"
 ;;D^FILE
 ;;R^"863.2:","863.21:1",1,"E"
 ;;D^2
 ;;EOR^
 ;;EOF^OCXS(863.2)^1
 ;;SOF^863.3  OCX MDD LINK
 ;;KEY^863.3:^CURRENT_DATE/TIME
 ;;R^"863.3:",.01,"E"
 ;;D^CURRENT_DATE/TIME
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^DATE/TIME
 ;;R^"863.3:",.06,"E"
 ;;D^999
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO EXTERNAL FUNCTION CALL
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^INT2DT($$DT2INT("N"),0)
 ;;EOR^
 ;;KEY^863.3:^PATIENT.HL7_PATIENT_ID
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.HL7_PATIENT_ID
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.04,"E"
 ;;D^HL7
 ;;R^"863.3:",.05,"E"
 ;;D^IEN
 ;;R^"863.3:",.06,"E"
 ;;D^99
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO HL7 SEGMENT ID
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO VT-BAR PIECE NUMBER
 ;;R^"863.3:","863.32:3",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;R^"863.3:","863.32:3",1,"E"
 ;;D^OCXODATA("PID",3)
 ;;EOR^
 ;;KEY^863.3:^PATIENT.IEN
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.IEN
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^IEN
 ;;R^"863.3:",.06,"E"
 ;;D^99
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;1;
 ;
