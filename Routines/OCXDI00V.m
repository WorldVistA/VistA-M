OCXDI00V ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:29
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
 G ^OCXDI00W
 ;
 Q
 ;
DATA ;
 ;
 ;;RSUM^32723.311^6732.141^14263.201^14904.201^16691.211^28324.281^14912.201^11235.171^25095.261^20482.241^14920.201^11243.171^15322.211^12736.181^14937.201^24666.261^16506.211^18963.231^9521.161^11009.171
 ;;RSUM^25201.261^14980.201^18647.231^16730.211^14970.201^36863.321^25199.261^14987.201^24306.261^16746.211^33661.301^45092.351^13409.191^11299.171^34771.311^22466.251^14918.201^533.41^150.21
 ;;RND^OCXSENDD^8/04/98  13:21
 ;;REND
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
 ;;KEY^863.8:^DEFAULT VALUE
 ;;R^"863.8:",.01,"E"
 ;;D^DEFAULT VALUE
 ;;R^"863.8:",.02,"E"
 ;;D^DEFAULT
 ;;R^"863.8:",1,1
 ;;D^Used with methods that manage interactive dialogues.
 ;;R^"863.8:",1,2
 ;;D^Equivalent to the default value before the "//" in a FileMan query.
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^Default value
 ;;R^"863.8:","863.84:5",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:5",1,"E"
 ;;D^FREE TEXT
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
 ;;KEY^863.8:^TAB OFFSET
 ;;R^"863.8:",.01,"E"
 ;;D^TAB OFFSET
 ;;R^"863.8:",.02,"E"
 ;;D^TAB
 ;;R^"863.8:",1,1
 ;;D^Horizontal offset (measured in spaces) for text output from a method
 ;;R^"863.8:",2,"E"
 ;;D^0
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Tab offset
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^POSITIVE INTEGER
 ;;EOR^
 ;;KEY^863.8:^LINE FEED
 ;;R^"863.8:",.01,"E"
 ;;D^LINE FEED
 ;;R^"863.8:",.02,"E"
 ;;D^LF
 ;;R^"863.8:",1,1
 ;;D^Vertical offset (measured in lines) for text output from a method
 ;;R^"863.8:",2,"E"
 ;;D^1
 ;;R^"863.8:","863.84:3",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:3",1,"E"
 ;;D^Vertical offset
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:4",1,"E"
 ;;D^POSITIVE INTEGER
 ;;EOR^
 ;;KEY^863.8:^MAND
 ;;R^"863.8:",.01,"E"
 ;;D^MAND
 ;;R^"863.8:",.02,"E"
 ;;D^MAND
 ;;R^"863.8:",1,1
 ;;D^Is a user response mandatory (=1) or optional (=0)?
 ;;R^"863.8:",2,"E"
 ;;D^0
 ;;R^"863.8:","863.84:6",.01,"E"
 ;;D^QUERY
 ;;R^"863.8:","863.84:6",1,"E"
 ;;D^Mandatory answer
 ;;R^"863.8:","863.84:8",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.8:","863.84:8",1,"E"
 ;;D^BINARY
 ;;R^"863.8:","863.84:9",.01,"E"
 ;;D^SET CODES
 ;;R^"863.8:","863.84:9",1,"E"
 ;;D^1:MANDATORY;0:OPTIONAL
 ;;EOR^
 ;;KEY^863.8:^NULL ALLOWED
 ;;R^"863.8:",.01,"E"
 ;;D^NULL ALLOWED
 ;;R^"863.8:",.02,"E"
 ;;D^NULL
 ;;R^"863.8:",1,1
 ;;D^If the user is asked for a responce, he may enter the term "NULL" regardless
 ;;R^"863.8:",1,2
 ;;D^of the edit mask.  0="NULL" NOT ALLOWED, 1="NULL" ALLOWED
 ;;R^"863.8:",2,"E"
 ;;D^0
 ;;R^"863.8:","863.84:4",.01,"E"
 ;;D^DATA TYPE
 ;1;
 ;
