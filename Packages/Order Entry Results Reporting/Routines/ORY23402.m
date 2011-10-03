ORY23402 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*234) ;MAY 13,2005 at 09:31
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**234**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY234ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY23403
 ;
 Q
 ;
DATA ;
 ;
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
 ;;KEY^863.7:^GCC FREE TEXT CONTAINS ELEMENT IN SET
 ;;R^"863.7:",.01,"E"
 ;;D^GCC FREE TEXT CONTAINS ELEMENT IN SET
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",3,"E"
 ;;D^CONSET^OCXF22
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^PRIMARY DATA FIELD
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^COMPARISON VALUE
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;EOR^
 ;;KEY^863.7:^GCC FREE TEXT EQUALS
 ;;R^"863.7:",.01,"E"
 ;;D^GCC FREE TEXT EQUALS
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",3,"E"
 ;;D^AEQ^OCXF22
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^PRIMARY DATA FIELD
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:2",.01,"E"
 ;;D^COMPARISON VALUE
 ;;R^"863.7:","863.74:2",1.1,"E"
 ;;D^2
 ;;EOR^
 ;;EOF^OCXS(863.7)^1
 ;;SOF^863.9  OCX MDD CONDITION/FUNCTION
 ;;KEY^863.9:^CONTAINS ELEMENT IN SET
 ;;R^"863.9:",.01,"E"
 ;;D^CONTAINS ELEMENT IN SET
 ;;R^"863.9:",.02,"E"
 ;;D^FREE TEXT
 ;;R^"863.9:",.04,"E"
 ;;D^CONTAINS AN ELEMENT IN THE SET
 ;;R^"863.9:","863.91:1",.01,"E"
 ;;D^OCXO GENERATE CODE FUNCTION
 ;;R^"863.9:","863.91:1",1,"E"
 ;;D^GCC FREE TEXT CONTAINS ELEMENT IN SET
 ;;EOR^
 ;;KEY^863.9:^EQ FREE TEXT
 ;;R^"863.9:",.01,"E"
 ;;D^EQ FREE TEXT
 ;;R^"863.9:",.02,"E"
 ;;D^FREE TEXT
 ;;R^"863.9:",.04,"E"
 ;;D^IS EQUAL TO
 ;;R^"863.9:","863.91:3",.01,"E"
 ;;D^OCXO GENERATE CODE FUNCTION
 ;;R^"863.9:","863.91:3",1,"E"
 ;;D^GCC FREE TEXT EQUALS
 ;;R^"863.9:","863.92:1",.01,"E"
 ;;D^EQUALS
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
 ;;KEY^863.4:^CONTRAST MEDIA
 ;;R^"863.4:",.01,"E"
 ;;D^CONTRAST MEDIA
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^CONTRAST MEDIA ALLERGY FLAG
 ;;R^"863.4:",.01,"E"
 ;;D^CONTRAST MEDIA ALLERGY FLAG
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^BOOLEAN
 ;;EOR^
 ;;KEY^863.4:^CONTRAST MEDIA CODE
 ;;R^"863.4:",.01,"E"
 ;;D^CONTRAST MEDIA CODE
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^FILLER
 ;;R^"863.4:",.01,"E"
 ;;D^FILLER
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^HL7 FILLER
 ;;R^"863.4:",.01,"E"
 ;1;
 ;
