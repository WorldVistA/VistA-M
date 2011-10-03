OCXDI00Z ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
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
 G ^OCXDI010
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.8:^FM LOCATION
 ;;R^"863.8:",.01,"E"
 ;;D^FM LOCATION
 ;;R^"863.8:",.02,"E"
 ;;D^FM LOC
 ;;R^"863.8:",1,1
 ;;D^FILE #,FIELD #
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^Enter the DD location (file#,field#)
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FILEMAN DD LOCATION
 ;;EOR^
 ;;KEY^863.8:^HELP EXECUTABLE
 ;;R^"863.8:",.01,"E"
 ;;D^HELP EXECUTABLE
 ;;R^"863.8:",.02,"E"
 ;;D^HELPEXEC
 ;;R^"863.8:",1,1
 ;;D^A tag^routine that will be executed if the user enters a '?'
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter tag^routine which generates the message
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^LINE TAG
 ;;EOR^
 ;;KEY^863.8:^SILENT CALL
 ;;R^"863.8:",.01,"E"
 ;;D^SILENT CALL
 ;;R^"863.8:",.02,"E"
 ;;D^SILENT
 ;;R^"863.8:",1,1
 ;;D^This flag tells a dialogue type function to operate without user
 ;;R^"863.8:",1,2
 ;;D^intervention.  Just use the value in the default parameter.
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^Silent call mode
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^YES NO
 ;;EOR^
 ;;KEY^863.8:^ALTERNATE RECORD IDENTIFIER CODE
 ;;R^"863.8:",.01,"E"
 ;;D^ALTERNATE RECORD IDENTIFIER CODE
 ;;R^"863.8:",.02,"E"
 ;;D^ALTID
 ;;EOR^
 ;;KEY^863.8:^FM CROSS REFERENCE LIST
 ;;R^"863.8:",.01,"E"
 ;;D^FM CROSS REFERENCE LIST
 ;;R^"863.8:",.02,"E"
 ;;D^FMXREF
 ;;R^"863.8:","863.84:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:1",1,"E"
 ;;D^FREE TEXT
 ;;R^"863.8:","863.84:2",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:2",1,"E"
 ;;D^Enter a '^' delimited string with index names to be used in the search
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Should be in the format 'B^C^DOB' etc.
 ;;EOR^
 ;;KEY^863.8:^ORPHAN DELETE CLASS
 ;;R^"863.8:",.01,"E"
 ;;D^ORPHAN DELETE CLASS
 ;;R^"863.8:",.02,"E"
 ;;D^ORPH CLASS
 ;;R^"863.8:",1,1
 ;;D^IEN of the class file which contains the deleted object
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Enter the class of the deleted object
 ;;R^"863.8:","863.84:7",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:7",1,"E"
 ;;D^POINTER TO A FILEMAN FILE
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^DIC
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^863
 ;;EOR^
 ;;KEY^863.8:^ORPHAN DELETE OBJECT
 ;;R^"863.8:",.01,"E"
 ;;D^ORPHAN DELETE OBJECT
 ;;R^"863.8:",.02,"E"
 ;;D^ORPH OBJ
 ;;R^"863.8:",1,1
 ;;D^Delete object which may cause orphaned parameters
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Enter the IEN of the deleted object
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^NUMERIC
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^FREE TEXT MAXIMUM LENGTH
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^24
 ;;EOR^
 ;;KEY^863.8:^ORPHAN ALL
 ;;R^"863.8:",.01,"E"
 ;;D^ORPHAN ALL
 ;;R^"863.8:",.02,"E"
 ;;D^ORPH ALL
 ;;R^"863.8:",1,1
 ;;D^Check param to see if it is an orphan.  Not related to the deletion of any object.
 ;;R^"863.8:",2,"E"
 ;;D^0
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^Check all classes for this parameter
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^YES NO
 ;;EOR^
 ;;KEY^863.8:^FREE TEXT MINIMUM LENGTH
 ;;R^"863.8:",.01,"E"
 ;;D^FREE TEXT MINIMUM LENGTH
 ;;R^"863.8:",.02,"E"
 ;;D^FMIN
 ;;R^"863.8:",1,1
 ;;D^Minimum number of characters allowed in a free text response
 ;;R^"863.8:",2,"E"
 ;;D^0
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Enter minimum text string length
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^FM MASK
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^FMIN^OCXF6
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^POSITIVE INTEGER
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
 ;;KEY^863.8:^DATE DEFAULT TIME FRAME
 ;;R^"863.8:",.01,"E"
 ;;D^DATE DEFAULT TIME FRAME
 ;;R^"863.8:",.02,"E"
 ;;D^DATE DFLT
 ;;R^"863.8:",1,1
 ;;D^If year is uspecified, the date will default to the pasr "P", futuren "F",
 ;1;
 ;
