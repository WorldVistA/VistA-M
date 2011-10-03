HLOAPI ;ALB/CJM-HL7 - Developer API's for sending & receiving messages ;05/12/2009
 ;;1.6;HEALTH LEVEL SEVEN;**126,133,138,139,146**;Oct 13, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
NEWMSG(PARMS,HLMSTATE,ERROR) ;; Starts a new message.
 ;;
 ;;** External API **
 ;;  
 ;;Input: 
 ;;   PARMS( *pass by reference*
 ;;     "COUNTRY")=3 character country code (optional)
 ;;     "CONTINUATION POINTER" -indicates a fragmented message
 ;;     "EVENT")=3 character event type (required)
 ;;     "FIELD SEPARATOR")=field separator (optional, defaults to "|")
 ;;     "ENCODING CHARACTERS")= 4 HL7 encoding characters (optional,defaults to "^~\&")
 ;;     "MESSAGE STRUCTURE" - MSH 9, component 3 - a code from the standard HL7 table (optional)
 ;;     "MESSAGE TYPE")=3 character message type (required)
 ;;     "PROCESSING MODE" - MSH 11, component 2 - a 1 character code (optional)
 ;;     "VERSION")=the HL7 Version ID, for example, "2.4" (optional, defaults to 2.4)
 ;;Output:
 ;;  Function- returns 1 on success, 0 on failure
 ;;  HLMSTATE() - (pass by reference, required) This array is used by the HL7 package to track the progress of the message.  The application MUST NOT touch it!
 ;;  PARMS - left defined when the function returns
 ;;  ERROR (optional, pass by reference) - returns an error message on failure
 ;;
 ;
 N DATA,I,SYSTEM,SUCCESS
 S SUCCESS=0
 K ERROR,HLMSTATE
 D
 .I $L($G(PARMS("PROCESSING MODE"))),$L(PARMS("PROCESSING MODE"))'=1 S ERROR="INVALID PROCESSING MODE" Q
 .I $L($G(PARMS("COUNTRY"))),$L(PARMS("COUNTRY"))'=3 S ERROR="INVALID COUNTRY CODE" Q
 .I $L($G(PARMS("EVENT")))'=3 S ERROR="INVALID EVENT CODE" Q
 .I $L($G(PARMS("MESSAGE TYPE")))'=3 S ERROR="INVALID MESSAGE TYPE" Q
 .I $L($G(PARMS("ENCODING CHARACTERS"))),$L(PARMS("ENCODING CHARACTERS"))'=4 S ERROR="INVALID ENCODING CHARACTERS" Q
 .I $L($G(PARMS("FIELD SEPARATOR"))),$L(PARMS("FIELD SEPARATOR"))'=1 S ERROR="INVALID FIELD SEPARATOR" Q
 .I '$L($G(PARMS("FIELD SEPARATOR"))) S PARMS("FIELD SEPARATOR")="|"
 .I '$L($G(PARMS("ENCODING CHARACTERS"))) S PARMS("ENCODING CHARACTERS")="^~\&"
 .I $G(PARMS("VERSION"))="" S PARMS("VERSION")="2.4"
 .I ($L($G(PARMS("VERSION")))>20) S ERROR="VERSION > 20 CHARACTERS" Q
 .F I="MESSAGE TYPE","EVENT","COUNTRY","FIELD SEPARATOR","ENCODING CHARACTERS","VERSION","CONTINUATION POINTER","MESSAGE STRUCTURE","PROCESSING MODE" S HLMSTATE("HDR",I)=$G(PARMS(I))
 .S HLMSTATE("BATCH")=0 ;not a batch
 .S HLMSTATE("DIRECTION")="OUT"
 .S HLMSTATE("IEN")=""
 .S HLMSTATE("BODY")="" ;record not yet created
 .S HLMSTATE("CURRENT SEGMENT")=0 ;no segments cached
 .S HLMSTATE("UNSTORED LINES")=0 ;nothing in cache
 .S HLMSTATE("LINE COUNT")=0
 .D GETSYS(.HLMSTATE)
 .S SUCCESS=1
 Q SUCCESS
 ;
NEWBATCH(PARMS,HLMSTATE,ERROR) ;;Starts a new batch message.  
 ;;Input: 
 ;;  PARMS( *pass by reference*
 ;;   "COUNTRY")=3 character country code (optional)
 ;;   "FIELD SEPARATOR")=field separator (optional, defaults to "|")
 ;;   "ENCODING CHARACTERS")= 4 HL7 encoding characters (optional,defaults to "^~\&") 
 ;;   "VERSION")=the HL7 Version ID, for example, "2.4" (optional, defaults to 2.4)
 ;;Output:
 ;;  Function - returns 1 on success, 0 on failure
 ;;  PARMS - left defined when the function returns
 ;;  HLMSTATE() - (pass by reference, required) This array is used by the HL7 package to track the progress of the message.  The application MUST NOT touch it!
 ;;  ERROR (optional, pass by reference) - returns an error message on failure
 ;;
 ;
 N DATA,I,SYSTEM,SUCCESS
 S SUCCESS=0
 K ERROR,HLMSTATE
 D
 .I $L($G(PARMS("COUNTRY"))),$L(PARMS("COUNTRY"))'=3 S ERROR="INVALID COUNTRY CODE" Q
 .I $L($G(PARMS("ENCODING CHARACTERS"))),$L(PARMS("ENCODING CHARACTERS"))'=4 S ERROR="INVALID ENCODING CHARACTERS" Q
 .I $L($G(PARMS("FIELD SEPARATOR"))),$L(PARMS("FIELD SEPARATOR"))'=1 S ERROR="INVALID FIELD SEPARATOR" Q
 .I '$L($G(PARMS("FIELD SEPARATOR"))) S PARMS("FIELD SEPARATOR")="|"
 .I '$L($G(PARMS("ENCODING CHARACTERS"))) S PARMS("ENCODING CHARACTERS")="^~\&"
 .I $G(PARMS("VERSION"))="" S PARMS("VERSION")="2.4"
 .I ($L(PARMS("VERSION"))>20) S ERROR="VERSION > 20 CHARACTERS" Q
 .F I="COUNTRY","FIELD SEPARATOR","ENCODING CHARACTERS","VERSION" S HLMSTATE("HDR",I)=$G(PARMS(I))
 .S HLMSTATE("IEN")=""
 .S HLMSTATE("BODY")="" ;msg not yet stored
 .S HLMSTATE("BATCH")=1
 .S HLMSTATE("DIRECTION")="OUT"
 .S HLMSTATE("BATCH","CURRENT MESSAGE")=0 ;no messages in batch
 .S HLMSTATE("CURRENT SEGMENT")=0 ;no segments in cache
 .S HLMSTATE("UNSTORED LINES")=0 ;nothing in cache
 .S HLMSTATE("LINE COUNT")=0 ;no lines within message stored
 .D GETSYS(.HLMSTATE)
 .S SUCCESS=1
 Q SUCCESS
 ;
SET(SEG,VALUE,FIELD,COMP,SUBCOMP,REP) ;;Sets a value to the array SEG(), used for building segments.
 ;;Input:
 ;; SEG - (required, pass by reference) - this is the array where the segment is being built.
 ;; VALUE - the individual value to be set into the segment
 ;; FIELD - the sequence # of the field (optional, defaults to 0)
 ;;     *NOTE: FIELD=0 is used to denote the segment type.
 ;; COMP - the # of the component (optional, defaults to 1)
 ;; SUBCOMP - the # of the subcomponent (optional, defaults to 1)
 ;; REP - the occurrence# (optional, defaults to 1)  For a non-repeating field, the occurrence # need not be provided, because it would be 1.
 ;;Output: 
 ;;  SEG array
 ;;
 ;;  Example:
 ;;    D SET(.SEG,"MSA",0) creates an MSA segment 
 ;;    D SET(.SEG,"AE",1) will place the value into the array position
 ;;    reserved for the 1st field,1st occurence,1st comp,1st subcomp
 ;;
 ;;Implementation Note - This format is used for the segment array built by calls to SET: SEGMENT(<SEQ #>,<occurrence #>,<component #>,<subcomponent #>)=<subcomponent value> 
 ;
 S:'$G(FIELD) FIELD=0
 S:'$G(COMP) COMP=1
 S:'$G(SUBCOMP) SUBCOMP=1
 S:'$G(REP) REP=1
 S SEG(FIELD,REP,COMP,SUBCOMP)=$G(VALUE)
 Q
 ;
ADDSEG(HLMSTATE,SEG,ERROR,TOARY) ;; Adds a segment to the message.
 ;;Input:
 ;;  HLMSTATE() - (pass by reference, required) This array is a workspace for HLO.  The application MUST NOT touch it!
 ;;  SEG() - (pass-by-reference, required) Contains the data.  It be created prior to calling $$ADDSEG.
 ;;
 ;;Note#1:  The message control segments, including the MSH and BHS segments, are added automatically.
 ;;Note#2:  The 0th field must be a 3 character segment type
 ;;Note#3: ***SEG is killed upon successfully adding the segment***
 ;;
 ;;Output:
 ;;   HLMSTATE() - (pass-by-reference, required) This array is used by the HL7 package to track the progress of the message.
 ;;  FUNCTION - returns 1 on success, 0 on failure
 ;;  TOARY (optional, pass by reference) returns the built segment in
 ;;        this format:
 ;;         TOARY(1)
 ;;         TOARY(2)
 ;;         TOARY(3), etc.
 ;;    If the segment fits on a single line, only TOARY(1) is returned.
 ;;
 ;;  ERROR (optional, pass by reference) - returns an error message on failure
 ;;
 ;
 K ERROR
 N TYPE
 K TOARY
 ;
 S TYPE=$G(SEG(0,1,1,1)) ;segment type
 ;
 ;if a 'generic' app ack MSA was built, add it as the first segment before this one
 I $D(HLMSTATE("MSA")) D
 .I TYPE'="MSA" S TOARY(1)=HLMSTATE("MSA") D ADDSEG^HLOMSG(.HLMSTATE,.TOARY) K TOARY
 .K HLMSTATE("MSA")
 ;
 I ($L(TYPE)'=3) S ERROR="INVALID SEGMENT TYPE" Q 0
 I (TYPE="MSH")!(TYPE="BHS")!(TYPE="BTS")!(TYPE="FHS")!(TYPE="FTS") S ERROR="INVALID SEGMENT TYPE" Q 0
 I HLMSTATE("BATCH"),'HLMSTATE("BATCH","CURRENT MESSAGE") S ERROR="NO MESSAGES IN BATCH, SO SEGMENTS NOT ALLOWED" Q 0
 I $$BUILDSEG^HLOPBLD(.HLMSTATE,.SEG,.TOARY,.ERROR) D ADDSEG^HLOMSG(.HLMSTATE,.TOARY) K SEG Q 1
 Q 0
 ;
 ;**P146 START CJM
MOVESEG(HLMSTATE,SEG,ERROR) ;Adds a segment built in the 'traditional' way as an array of lines into the message.
 ;;Input:
 ;;  HLMSTATE() - (pass by reference, required) This array is a workspace for HLO. 
 ;;  SEG() - (pass-by-reference, required) Contains the segment.  The segement.  If the segment is short enough it should consist of only SEG or SEG(1).  If longer, additional lines can be added as SEG(<n>). 
 ;;
 ;;Note#1:  The message control segments, including the MSH, BHS & FTS segments, are added automatically, so may not be added by MOVESEG.
 ;;
 ;;Output:
 ;;   HLMSTATE() - (pass-by-reference, required) This array is the workspace used by HLO.
 ;;  FUNCTION - returns 1 on success, 0 on failure
 ;;
 ;;  ERROR (optional, pass by reference) - returns an error message on failure
 ;;
 ;
 K ERROR
 N TYPE,NEWCOUNT,OLDCOUNT,TOARY
 ;
 S NEWCOUNT=1
 I $L($G(SEG)) S TOARY(1)=SEG,NEWCOUNT=2
 S OLDCOUNT=0
 F  S OLDCOUNT=$O(SEG(OLDCOUNT)) Q:'OLDCOUNT  S TOARY(NEWCOUNT)=SEG(OLDCOUNT),NEWCOUNT=NEWCOUNT+1
 S TYPE=$P($G(TOARY(1)),HLMSTATE("HDR","FIELD SEPARATOR")) ;segment type
 ;
 ;if a 'generic' app ack MSA was built, add it as the first segment before this one
 I $D(HLMSTATE("MSA")) D
 .I TYPE'="MSA" N TOARY S TOARY(1)=HLMSTATE("MSA") D ADDSEG^HLOMSG(.HLMSTATE,.TOARY)
 .K HLMSTATE("MSA")
 ;
 I ($L(TYPE)'=3) S ERROR="INVALID SEGMENT TYPE" Q 0
 I (TYPE="MSH")!(TYPE="BHS")!(TYPE="BTS")!(TYPE="FHS")!(TYPE="FTS") S ERROR="INVALID SEGMENT TYPE" Q 0
 I HLMSTATE("BATCH"),'HLMSTATE("BATCH","CURRENT MESSAGE") S ERROR="NO MESSAGES IN BATCH, SO SEGMENTS NOT ALLOWED" Q 0
 D ADDSEG^HLOMSG(.HLMSTATE,.TOARY)
 Q 1
 ;**P146 END CJM
 ;
ADDMSG(HLMSTATE,PARMS,ERROR) ;; Begins a new message in the batch.
 ;;Input:
 ;;  HLMSTATE() - (pass by reference, required) This array is used by the HL7 package to track the progress of the message.  The application MUST NOT touch it!
 ;;  PARMS( *pass by reference*
 ;;    "EVENT")=3 character event type (required)
 ;;    "MESSAGE TYPE")=3 character message type (required)
 ;;
 ;;Output:
 ;;   FUNCTION - returns 1 on success, 0 on failure
 ;;   HLMSTATE() - (pass by reference, required) This array is used by the HL7 package to track the progress of the message.
 ;;   PARMS - left defined when this function returns
 ;;   ERROR (optional, pass by reference) - returns an error message on failure
 ;;
 N I
 K ERROR
 ;if a 'generic' app ack MSA was built, add it as the first segment before this one
 I $D(HLMSTATE("MSA")) D
 .N TOARY S TOARY(1)=HLMSTATE("MSA") D ADDSEG^HLOMSG(.HLMSTATE,.TOARY)
 .K HLMSTATE("MSA")
 I $L($G(PARMS("EVENT")))'=3 S ERROR="EVENT TYPE INVALID" Q 0
 I $L($G(PARMS("MESSAGE TYPE")))'=3 S ERROR="MESSAGE TYPE INVALID" Q 0
 D ADDMSG^HLOMSG(.HLMSTATE,.PARMS)
 Q 1
 ;
GETSYS(HLMSTATE) ;
 N SYS,SUB
 D SYSPARMS^HLOSITE(.SYS)
 F SUB="DOMAIN","STATION","PROCESSING ID","MAXSTRING","ERROR PURGE","NORMAL PURGE","PORT" S HLMSTATE("SYSTEM",SUB)=SYS(SUB)
 S HLMSTATE("SYSTEM","BUFFER")=SYS("USER BUFFER")
 Q
 ;
MOVEMSG(HLMSTATE,ARY) ;;
 ;If a message was built in the 'old' way, and resides in an array, this  routine will move it into file 777 (HL7 Message Body)
 ;Input:
 ;  HLMSTATE (pass by reference) the array created by calling $$NEWMSG or $$NEWBATCH
 ;  ARY - is the name of the array, local or global, where the message was built, used to reference the array by indirection.
 ;Output:
 ;  HLMSTATE (pass by reference) Is updated with information about the
 ;            message.
 ;;
 N I S I=0
 F  S I=$O(@ARY@(I)) Q:'I  D
 .N SEG,J,J2
 .S J=0,J2=1
 .S SEG(J2)=@ARY@(I)
 .F  S J=$O(@ARY@(I,J)) Q:'J  S J2=J2+1,SEG(J2)=@ARY@(I,J)
 .I 'HLMSTATE("BATCH") D
 ..D ADDSEG^HLOMSG(.HLMSTATE,.SEG)
 .E  D
 ..I $E(SEG(1),1,3)="MSH" D
 ...D SPLITHDR^HLOSRVR1(.SEG)
 ...D ADDMSG2^HLOMSG(.HLMSTATE,.SEG)
 ..E  D ADDSEG^HLOMSG(.HLMSTATE,.SEG)
 ;
 ;signal SENDACK^HLOAPI2 that the application built its own msg
 K HLMSTATE("MSA")
 Q
