OCXDI011 ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
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
 G ^OCXDI012
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Special "identifier" code
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^MUMPS CODE
 ;;EOR^
 ;;KEY^863.8:^FLI SCREEN
 ;;R^"863.8:",.01,"E"
 ;;D^FLI SCREEN
 ;;R^"863.8:",.02,"E"
 ;;D^FLI SCREEN
 ;;R^"863.8:",1,1
 ;;D^M code to screen each potential entry which sets $T.  This screen is in
 ;;R^"863.8:",1,2
 ;;D^addition to any FileMan screens in the file.
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Screen code
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^MUMPS CODE
 ;;EOR^
 ;;KEY^863.8:^CLOSED REFERENCE
 ;;R^"863.8:",.01,"E"
 ;;D^CLOSED REFERENCE
 ;;R^"863.8:",.02,"E"
 ;;D^CREF
 ;;R^"863.8:",1,1
 ;;D^A closed global or local varaible reference which can be used with subscript
 ;;R^"863.8:",1,2
 ;;D^indirection.
 ;;R^"863.8:",2,"E"
 ;;D^ 
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Closed reference
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^CLOSED REFERENCE
 ;;EOR^
 ;;KEY^863.8:^CLASS NUMBER
 ;;R^"863.8:",.01,"E"
 ;;D^CLASS NUMBER
 ;;R^"863.8:",.02,"E"
 ;;D^CLASS IEN
 ;;R^"863.8:",1,1
 ;;D^Class internal entry number
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^CLASS IEN
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^NUMERIC
 ;;EOR^
 ;;KEY^863.8:^FILEMAN FILE NUMBER
 ;;R^"863.8:",.01,"E"
 ;;D^FILEMAN FILE NUMBER
 ;;R^"863.8:",.02,"E"
 ;;D^FILE NO.
 ;;R^"863.8:",1,1
 ;;D^The IEN of an entry in FileMan file #1
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^File number
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^NUMERIC
 ;;EOR^
 ;;KEY^863.8:^TEXT STRING
 ;;R^"863.8:",.01,"E"
 ;;D^TEXT STRING
 ;;R^"863.8:",1,1
 ;;D^Any free text string up to 240 characters long
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Text string
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^CODE OR VALUE
 ;;R^"863.8:",.01,"E"
 ;;D^CODE OR VALUE
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter a code or a value
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^CODE OR DECODE
 ;;R^"863.8:",.01,"E"
 ;;D^CODE OR DECODE
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^SET OF CODES
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^SET CODES
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^1:CODE;0:DECODE
 ;;EOR^
 ;;KEY^863.8:^FIRST LINE TAB
 ;;R^"863.8:",.01,"E"
 ;;D^FIRST LINE TAB
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^First line tab offset
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^POSITIVE INTEGER
 ;;EOR^
 ;;KEY^863.8:^CLASS NAME
 ;;R^"863.8:",.01,"E"
 ;;D^CLASS NAME
 ;;R^"863.8:",1,1
 ;;D^The name of an object class
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter class name
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^30
 ;;EOR^
 ;;KEY^863.8:^CLOSED OR OPEN
 ;;R^"863.8:",.01,"E"
 ;;D^CLOSED OR OPEN
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Is the reference closed or open
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^SET CODES
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^1:CLOSED REFERENCE;0:OPEN REFERENCE
 ;;R^"863.8:","863.84:9",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^SET OF CODES
 ;;EOR^
 ;;KEY^863.8:^OPEN REFERENCE
 ;;R^"863.8:",.01,"E"
 ;;D^OPEN REFERENCE
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter an open local/global reference
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^OPEN REFERENCE
 ;;EOR^
 ;;KEY^863.8:^LIST START
 ;;R^"863.8:",.01,"E"
 ;;D^LIST START
 ;;R^"863.8:",1,1
 ;;D^Start display after this index value
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^LIST END
 ;;R^"863.8:",.01,"E"
 ;;D^LIST END
 ;;R^"863.8:",1,1
 ;;D^Stop listing after this index value is displayed
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^OUTPUT TRANSFORM
 ;;R^"863.8:",.01,"E"
 ;;D^OUTPUT TRANSFORM
 ;;R^"863.8:",1,1
 ;;D^Mumps code to do the output transform
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:3",1,"E"
 ;1;
 ;
