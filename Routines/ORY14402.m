ORY14402 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*144) ;JUN 12,2002 at 12:20
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**144**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY144ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY14403
 ;
 Q
 ;
DATA ;
 ;
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
 ;;SOF^863.4  OCX MDD ATTRIBUTE
 ;;KEY^863.4:^IEN
 ;;R^"863.4:",.01,"E"
 ;;D^IEN
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^NUMERIC
 ;;EOR^
 ;;KEY^863.4:^LAB SPECIMEN
 ;;R^"863.4:",.01,"E"
 ;;D^LAB SPECIMEN
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^LAB SPECIMEN ID
 ;;R^"863.4:",.01,"E"
 ;;D^LAB SPECIMEN ID
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^NUMERIC
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
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^DFN
 ;;EOR^
 ;;KEY^863.3:^PATIENT.LAB_SPECIMEN
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.LAB_SPECIMEN
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.04,"E"
 ;;D^HL7
 ;;R^"863.3:",.05,"E"
 ;;D^LAB SPECIMEN
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^OCXODATA("OBR",15)
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO HL7 SEGMENT ID
 ;;R^"863.3:","863.32:3",.01,"E"
 ;;D^OCXO VT-BAR PIECE NUMBER
 ;;R^"863.3:","863.32:4",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.3:","863.32:4",1,"E"
 ;;D^4
 ;;R^"863.3:","863.32:5",.01,"E"
 ;;D^OCXO DATA DRIVE SOURCE
 ;;R^"863.3:","863.32:5",1,"E"
 ;;D^HL7
 ;;R^"863.3:","863.32:6",.01,"E"
 ;;D^OCXO SEMI-COLON PIECE NUMBER
 ;;R^"863.3:","863.32:6",1,"E"
 ;;D^2
 ;;R^"863.3:","863.32:7",.01,"E"
 ;;D^OCXO FILE POINTER
 ;;EOR^
 ;;KEY^863.3:^PATIENT.LAB_SPECIMEN_ID
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.LAB_SPECIMEN_ID
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^LAB SPECIMEN ID
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^OCXODATA("OBR",15)
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^4
 ;;R^"863.3:","863.32:3",.01,"E"
 ;;D^OCXO SEMI-COLON PIECE NUMBER
 ;;R^"863.3:","863.32:3",1,"E"
 ;;D^1
 ;;EOR^
 ;;KEY^863.3:^PATIENT.OERR_ORDER_PATIENT
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.OERR_ORDER_PATIENT
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^ORDER PATIENT
 ;;R^"863.3:",.06,"E"
 ;;D^5567
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^OCXORD
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^1
 ;;EOR^
 ;;EOF^OCXS(863.3)^1
 ;;SOF^860.9  ORDER CHECK NATIONAL TERM
 ;;KEY^860.9:^ANGIOGRAM (PERIPHERAL)
 ;;R^"860.9:",.01,"E"
 ;;D^ANGIOGRAM (PERIPHERAL)
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^BLOOD SPECIMEN
 ;;R^"860.9:",.01,"E"
 ;;D^BLOOD SPECIMEN
 ;;R^"860.9:",.02,"E"
 ;;D^61
 ;;EOR^
 ;;KEY^860.9:^DANGEROUS MEDS FOR PTS > 64
 ;;R^"860.9:",.01,"E"
 ;;D^DANGEROUS MEDS FOR PTS > 64
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;R^"860.9:",2,"E"
 ;;D^I $P($G(^ORD(100.98,$P($G(^ORD(101.43,+Y,0)),U,5),0)),U)="PHARMACY"
 ;1;
 ;
