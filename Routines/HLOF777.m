HLOF777  ;ALB/CJM-HL7 - API'S for saving data to file 777 ;02/04/2004
 ;;1.6;HEALTH LEVEL SEVEN;**126**;Oct 13, 1995
 ;
SAVEMSG(HLMSTATE) ;
 ;If a record has not yet been created in file 777, then it will be created.  Otherwise, it just stores the segments not yet stored.
 ;Input:
 ;  HLMSTATE (pass by reference) - contains information about the message
 ;    These subscripts must be defined:
 ;    ("BATCH")=1 if batch, 0 otherwise
 ;    ("BODY")=ien file 777
 ;  ("UNSTORED LINES") - count of lines to be stored. The lines are stored at a lower subscript <message#>,<segment#>,<line#>
 ;Output:
 ;  HLMSTATE("UNSTORED LINES")-set to 0
 ;
 ;if the record has not been created yet,then create it
 I 'HLMSTATE("BODY"),'$$NEW(.HLMSTATE) Q 0
 ;
 ;any segments to store to disk?
 Q:'HLMSTATE("UNSTORED LINES") HLMSTATE("BODY")
 ;
 I 'HLMSTATE("BATCH") D
 .N ARY,SEG,LINE
 .S ARY="^HLA("_HLMSTATE("BODY")_",1)"
 .S SEG=0
 .F  S SEG=$O(HLMSTATE("UNSTORED LINES",1,SEG)) Q:'SEG  D
 ..S LINE=0
 ..F  S LINE=$O(HLMSTATE("UNSTORED LINES",1,SEG,LINE)) Q:'LINE  S @ARY@(LINE,0)=HLMSTATE("UNSTORED LINES",1,SEG,LINE)
 .;
 I HLMSTATE("BATCH") D
 .;NOTE: will not store any segments that come before the first MSH!
 .N MSG S MSG=0
 .F  S MSG=$O(HLMSTATE("UNSTORED LINES",MSG)) Q:'MSG  D
 ..N ARY,SEG,LINE
 ..S ARY="^HLA("_HLMSTATE("BODY")_",2,"_MSG_")"
 ..;
 ..;if starting a new message, add its 0 node.  The message type and event are stored in HLMSTATE("UNSTORED LINES",MSG)
 ..I '$D(@ARY@(0)) D
 ...S @ARY@(0)=MSG_"^"_$G(HLMSTATE("UNSTORED LINES",MSG))
 ...;
 ...S ^HLA(HLMSTATE("BODY"),2,"B",MSG,MSG)=""
 ..;
 ..S SEG=0
 ..F  S SEG=$O(HLMSTATE("UNSTORED LINES",MSG,SEG)) Q:'SEG  D
 ...S LINE=0
 ...F  S LINE=$O(HLMSTATE("UNSTORED LINES",MSG,SEG,LINE)) Q:'LINE  S @ARY@(1,LINE,0)=HLMSTATE("UNSTORED LINES",MSG,SEG,LINE)
 ;
 ;clear the cache
 K HLMSTATE("UNSTORED LINES")
 S HLMSTATE("UNSTORED LINES")=0
 ;S:HLMSTATE("BATCH") HLMSTATE("BATCH","CURRENT MESSAGE")=0
 Q HLMSTATE("BODY")
 ;
NEW(HLMSTATE) ;
 ;This function creates a new entry in file 777.
 ;Input:
 ;   HLMSTATE (required, pass by reference) These subscripts are expected:
 ;     "DIRECTION"
 ;     "DT/TM"   (optional, $$NOW used as default)
 ;     "BATCH"
 ;     "HDR","ENCODING CHARACTERS"
 ;     "HDR","EVENT"
 ;     "HDR","FIELD SEPARATOR"
 ;     "HDR","MESSAGE TYPE"
 ;     "HDR","VERSION"
 ;
 ;Output - the function returns the ien of the newly created record
 ;
 N IEN,TIME,NODE
 S IEN=$$NEWIEN(HLMSTATE("DIRECTION"),$$TCP^HLOF778A)
 Q:'IEN 0
 K ^HLA(IEN)
 S HLMSTATE("DT/TM CREATED")=$S($G(HLMSTATE("DT/TM")):HLMSTATE("DT/TM"),1:$$NOW^XLFDT)
 ;
 S NODE=HLMSTATE("DT/TM CREATED")_"^"_HLMSTATE("BATCH")_"^^^"_$G(HLMSTATE("HDR","VERSION"))
 I 'HLMSTATE("BATCH") S $P(NODE,"^",3)=HLMSTATE("HDR","MESSAGE TYPE"),$P(NODE,"^",4)=HLMSTATE("HDR","EVENT")
 S $P(NODE,"^",20)=HLMSTATE("HDR","FIELD SEPARATOR")_HLMSTATE("HDR","ENCODING CHARACTERS")
 S ^HLA(IEN,0)=NODE
 ;
 ;for incoming msgs, set the "B" xref later
 S:HLMSTATE("DIRECTION")="OUT" ^HLA("B",HLMSTATE("DT/TM CREATED"),IEN)=""
 ;
 S HLMSTATE("BODY")=IEN
 Q IEN
 ;
NEWIEN(DIR,TCP) ;
 ;This function uses a counter to get the next available ien for file 777. There are 3 different counters, each assigned a specific number range, selected via the input parameters. It does not create a record.
 ;Inputs:
 ;  DIR = "IN" or "OUT" (required)
 ;  TCP = 1,0 (optional)
 ;Output - the function returns the next available ien. Several counters are used:
 ;   <"OUT">
 ;   <"IN","TCP">
 ;   <"IN","NOT TCP">
 ;
 N IEN,COUNTER
 S:DIR="IN" COUNTER=$NA(^HLC("FILE777",DIR,$S(+$G(TCP):"TCP",1:"NOT TCP")))
 S:DIR="OUT" COUNTER=$NA(^HLC("FILE777",DIR))
AGAIN ;
 S IEN=$$INC^HLOSITE(COUNTER,1)
 I IEN>100000000000 D
 .L +@COUNTER:200
 .I $T,@COUNTER>100000000000 S @COUNTER=1,IEN=1
 .L -@COUNTER
 I IEN>100000000000 G AGAIN
 Q (IEN+$S(DIR="OUT":0,+$G(TCP):100000000000,1:200000000000))
