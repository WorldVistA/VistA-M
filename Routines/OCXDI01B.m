OCXDI01B ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
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
 G ^OCXDI01C
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"864.1:",.01,"E"
 ;;D^POSITIVE INTEGER
 ;;R^"864.1:",.02,"E"
 ;;D^POSINT
 ;;R^"864.1:",2,"E"
 ;;D^NUMERIC
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Enter a positive integer
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^NUMERIC MINIMUM
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^0
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^NUMERIC DECIMAL PLACES
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^0
 ;;EOR^
 ;;KEY^864.1:^FILEMAN DATE INTERNAL FORMAT
 ;;R^"864.1:",.01,"E"
 ;;D^FILEMAN DATE INTERNAL FORMAT
 ;;R^"864.1:",.02,"E"
 ;;D^FM DATE
 ;;R^"864.1:",2,"E"
 ;;D^FREE TEXT
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Enter a FileMan date in internal format
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^The valid format is a 7 digit number followed by 0-6 decimal places.  The first 3 palces are (CURRENT YR-1700) followed by a 2 digit numeric month and a 2 digit numeric day; e.g. 2860131.184502
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^DIALOGUE VALIDATION CODE
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^FMDATE^OCXFDFTE
 ;;EOR^
 ;;KEY^864.1:^NEW FILE ENTRY
 ;;R^"864.1:",.01,"E"
 ;;D^NEW FILE ENTRY
 ;;R^"864.1:",.02,"E"
 ;;D^NEW ENT
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Enter the name for a new entry in the file
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^This must be between 1 and |FMAX| characters in length and must not yet exist as an entry in the file.  Enter '??' to see previously selected choices.
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^NE^OCXFDNE
 ;;EOR^
 ;;KEY^864.1:^LIST OF VALUES
 ;;R^"864.1:",.01,"E"
 ;;D^LIST OF VALUES
 ;;R^"864.1:",.02,"E"
 ;;D^LIST
 ;;R^"864.1:",2,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^LI^OCXFDLI
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:2",1,"E"
 ;;D^Select an entry from the list
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^Type a name from the list.  Enter '??' to view the possible choices.
 ;;EOR^
 ;;KEY^864.1:^BOOLEAN
 ;;R^"864.1:",.01,"E"
 ;;D^BOOLEAN
 ;;R^"864.1:",.02,"E"
 ;;D^BOOL
 ;;EOR^
 ;;KEY^864.1:^DOT
 ;;R^"864.1:",.01,"E"
 ;;D^DOT
 ;;R^"864.1:",.02,"E"
 ;;D^DOT
 ;;R^"864.1:",2,"E"
 ;;D^GENERIC
 ;;R^"864.1:","864.11:1",.01,"E"
 ;;D^QUERY
 ;;R^"864.1:","864.11:1",1,"E"
 ;;D^Enter 'JUNE 3, 1992' in the desired format
 ;;R^"864.1:","864.11:2",.01,"E"
 ;;D^PROMPT
 ;;R^"864.1:","864.11:3",.01,"E"
 ;;D^HELP MESSAGE
 ;;R^"864.1:","864.11:3",1,"E"
 ;;D^Remember, the date JUNE 3, 1992 must be entered in the desired format.  Only uppercase letters should be used.  No other date will work.  Examples of valid date formats: 6/3/1992, 6.3.92, 3JUN92, etc.
 ;;R^"864.1:","864.11:4",.01,"E"
 ;;D^VALUE CALL
 ;;R^"864.1:","864.11:4",1,"E"
 ;;D^DOT^OCXFDDOT
 ;;EOR^
 ;;EOF^OCXS(864.1)^1
 ;;SOF^863.7  OCX MDD PUBLIC FUNCTION
 ;;KEY^863.7:^CLASS TO FUNCTION
 ;;R^"863.7:",.01,"E"
 ;;D^CLASS TO FUNCTION
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Converts a class IEN to a file number
 ;;R^"863.7:",3,"E"
 ;;D^CONF^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^CLASS NUMBER
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^X
 ;;EOR^
 ;;KEY^863.7:^FILE TO CLASS
 ;;R^"863.7:",.01,"E"
 ;;D^FILE TO CLASS
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Converts a FileMan file number to the IEN of an entry in the class file
 ;;R^"863.7:",3,"E"
 ;;D^CONV^OCXF
 ;;EOR^
 ;;KEY^863.7:^QUOTE DOUBLER
 ;;R^"863.7:",.01,"E"
 ;;D^QUOTE DOUBLER
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Doubles all the quotation marks in a string
 ;;R^"863.7:",3,"E"
 ;;D^QT^OCXF
 ;;EOR^
 ;;KEY^863.7:^UPPER CASE
 ;;R^"863.7:",.01,"E"
 ;;D^UPPER CASE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Convert a string to all upper case characters
 ;;R^"863.7:",3,"E"
 ;;D^UC^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^TEXT STRING
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^X
 ;;EOR^
 ;;KEY^863.7:^LOWER CASE
 ;;R^"863.7:",.01,"E"
 ;;D^LOWER CASE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Converts a text string to all lowercase characters
 ;;R^"863.7:",3,"E"
 ;;D^LC^OCXF
 ;;R^"863.7:","863.74:1",.01,"E"
 ;;D^TEXT STRING
 ;;R^"863.7:","863.74:1",1.1,"E"
 ;;D^1
 ;;R^"863.7:","863.74:1",1.2,"E"
 ;;D^X
 ;;EOR^
 ;;KEY^863.7:^HEADER LINE
 ;;R^"863.7:",.01,"E"
 ;;D^HEADER LINE
 ;;R^"863.7:",.02,"E"
 ;;D^EXTRINSIC FUNCTION
 ;;R^"863.7:",1,"E"
 ;;D^Convert a text string into a header line
 ;1;
 ;
