OCXDI01Q ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI01R
 ;
 Q
 ;
DATA ;
 ;
 ;;KEY^863.4:^DATE OF BIRTH
 ;;R^"863.4:",.01,"E"
 ;;D^DATE OF BIRTH
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^QUERY
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^Enter DOB
 ;;R^"863.4:","863.41:13",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:13",1,"E"
 ;;D^DATE/TIME
 ;;R^"863.4:","863.41:3",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.4:","863.41:3",1,"E"
 ;;D^Enter the date of birth in any convenient format; e.g., MM/DD/YY
 ;;R^"863.4:","863.41:5",.01,"E"
 ;;D^DATE EXACT
 ;;R^"863.4:","863.41:5",1,"E"
 ;;D^X
 ;;R^"863.4:","863.41:7",.01,"E"
 ;;D^DATE LIMIT
 ;;R^"863.4:","863.41:7",1,"E"
 ;;D^-T
 ;;R^"863.4:","863.41:8",.01,"E"
 ;;D^DATE MINIMUM
 ;;R^"863.4:","863.41:8",1,"E"
 ;;D^1850101
 ;;R^"863.4:","863.41:9",.01,"E"
 ;;D^DATE MAXIMUM
 ;;R^"863.4:","863.41:9",1,"E"
 ;;D^T
 ;;EOR^
 ;;KEY^863.4:^BLOOD TYPE
 ;;R^"863.4:",.01,"E"
 ;;D^BLOOD TYPE
 ;;EOR^
 ;;KEY^863.4:^DATE OF VISIT
 ;;R^"863.4:",.01,"E"
 ;;D^DATE OF VISIT
 ;;EOR^
 ;;KEY^863.4:^TYPE OF VISIT
 ;;R^"863.4:",.01,"E"
 ;;D^TYPE OF VISIT
 ;;EOR^
 ;;KEY^863.4:^SERVICE CATEGORY
 ;;R^"863.4:",.01,"E"
 ;;D^SERVICE CATEGORY
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^SOCIAL SECURITY NUMBER
 ;;R^"863.4:",.01,"E"
 ;;D^SOCIAL SECURITY NUMBER
 ;;EOR^
 ;;KEY^863.4:^CITY
 ;;R^"863.4:",.01,"E"
 ;;D^CITY
 ;;EOR^
 ;;KEY^863.4:^AGE
 ;;R^"863.4:",.01,"E"
 ;;D^AGE
 ;;R^"863.4:","863.41:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.4:","863.41:2",1,"E"
 ;;D^Enter an age.
 ;;R^"863.4:","863.41:3",.01,"E"
 ;;D^NUMERIC MINIMUM
 ;;R^"863.4:","863.41:3",1,"E"
 ;;D^0
 ;;R^"863.4:","863.41:4",.01,"E"
 ;;D^NUMERIC MAXIMUM
 ;;R^"863.4:","863.41:4",1,"E"
 ;;D^150
 ;;R^"863.4:","863.41:5",.01,"E"
 ;;D^NUMERIC DECIMAL PLACES
 ;;R^"863.4:","863.41:5",1,"E"
 ;;D^0
 ;;R^"863.4:","863.41:6",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:6",1,"E"
 ;;D^NUMERIC
 ;;EOR^
 ;;KEY^863.4:^GENERIC NAME
 ;;R^"863.4:",.01,"E"
 ;;D^GENERIC NAME
 ;;R^"863.4:",.02,"E"
 ;;D^GNAME
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^QUERY
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^Enter generic name
 ;;R^"863.4:","863.41:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.4:","863.41:2",1,"E"
 ;;D^Enter the name of your choice.  |FTMM HELP|
 ;;R^"863.4:","863.41:3",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:3",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^HL7 FILLER
 ;;R^"863.4:",.01,"E"
 ;;D^HL7 FILLER
 ;;R^"863.4:",.02,"E"
 ;;D^HL7FILLR
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^HL7 CONTROL CODE
 ;;R^"863.4:",.01,"E"
 ;;D^HL7 CONTROL CODE
 ;;R^"863.4:",.02,"E"
 ;;D^HL7CCODE
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^HL7 ORDERING PROVIDER
 ;;R^"863.4:",.01,"E"
 ;;D^HL7 ORDERING PROVIDER
 ;;R^"863.4:",.02,"E"
 ;;D^HL7ORDPROV
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.4:","863.41:3",.01,"E"
 ;;D^FILEMAN FILE NUMBER
 ;;R^"863.4:","863.41:3",1,"E"
 ;;D^200
 ;;EOR^
 ;;KEY^863.4:^HL7 STATUS
 ;;R^"863.4:",.01,"E"
 ;;D^HL7 STATUS
 ;;R^"863.4:",.02,"E"
 ;;D^HL7STAT
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^HL7 ORDER START D/T
 ;;R^"863.4:",.01,"E"
 ;;D^HL7 ORDER START D/T
 ;;R^"863.4:",.02,"E"
 ;;D^HL7STDATE
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^DATE/TIME
 ;;EOR^
 ;;KEY^863.4:^ORDER PRIORITY
 ;;R^"863.4:",.01,"E"
 ;;D^ORDER PRIORITY
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^RESULT STATUS
 ;;R^"863.4:",.01,"E"
 ;;D^RESULT STATUS
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^ABNORM FLAG
 ;;R^"863.4:",.01,"E"
 ;;D^ABNORM FLAG
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^START DATE
 ;;R^"863.4:",.01,"E"
 ;;D^START DATE
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^DATE/TIME
 ;;EOR^
 ;;KEY^863.4:^LAB LOCAL OI
 ;;R^"863.4:",.01,"E"
 ;;D^LAB LOCAL OI
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^ORD PLACE DT
 ;;R^"863.4:",.01,"E"
 ;;D^ORD PLACE DT
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^DATE/TIME
 ;;EOR^
 ;;KEY^863.4:^EXAM/ORDER ID
 ;;R^"863.4:",.01,"E"
 ;;D^EXAM/ORDER ID
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^COMMENT
 ;;R^"863.4:",.01,"E"
 ;;D^COMMENT
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^CONSULT/REQUEST NAME
 ;;R^"863.4:",.01,"E"
 ;;D^CONSULT/REQUEST NAME
 ;;R^"863.4:","863.41:1",.01,"E"
 ;1;
 ;
