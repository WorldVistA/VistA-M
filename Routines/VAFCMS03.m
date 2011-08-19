VAFCMS03 ;BPFO/JRP - GENERAL ADT-A08 MESSAGE SENDER ; 22 Jan 2002 10:32 AM
 ;;5.3;Registration;**494**;Aug 13, 1993
 ;
BULKA08(ARRAY,EVNTPROT,USER,OUTARR) ;Build/send ADT-A08 messages
 ;Input  : ARRAY - List of patients to send (full global reference)
 ;                 ARRAY(x) = yyy
 ;                            x is pointer to Patient file (#2)
 ;                            yyy can be anything (it's ignored)
 ;         EVNTPROT - HL7 event protocol to post message to (name or ptr)
 ;         USER - User causing message generation (DUZ or name)
 ;                Defaults to current DUZ
 ;         OUTARR - Array to return message IDs in (full global ref)
 ;         HLL("LINKS") - Refer to HL7 Dev Guide for definition
 ;                        Use of this array is optional
 ;Output : OUTARR - Array containing assigned message IDs or error text
 ;                  OUTARR(x) = HL7 message ID
 ;                  OUTARR(x) = 0^ErrorText
 ;                              x is pointer to Patient file
 ;Notes  : OUTARR will be initialized (KILLed) on input
 ;       : OUTARR will be not be returned if USER evaluates to a number
 ;         and that number is not a valid DUZ
 ;       : OUTARR will not be returned on bad input
 ;       : It is assumed that EVNTPROT is defined to have a message
 ;         type of 'ADT' and event type of 'A08'
 ;
 ;Check input
 Q:'$D(OUTARR)
 K @OUTARR
 Q:$G(ARRAY)=""
 Q:'$D(EVNTPROT)
 I '$D(USER) S USER=+$G(DUZ) S:'USER USER=""
 I USER S USER=$$GET1^DIQ(200,(USER_","),.01) D CLEAN^DILF
 Q:USER=""
 ;Declare variables
 N DFN,MSGID,COUNT,STOP
 ;Loop through list of patients
 S DFN=0
 S STOP=0
 F COUNT=1:1 S DFN=+$O(@ARRAY@(DFN)) Q:'DFN  D  Q:STOP
 .;Build/send ADT-A08 message
 .S @OUTARR@(DFN)=$$SNDA08(DFN,EVNTPROT,USER)
 .;Check for request to stop every 100th patient (allows for queuing)
 .I '(COUNT#100) S STOP=$$S^%ZTLOAD(COUNT_"th DFN = "_DFN)
 Q
 ;
SNDA08(DFN,EVNTPROT,USER) ;Build/send ADT-A08 message for patient
 ;Input  : DFN - Pointer to Patient file (#2)
 ;         EVNTPROT - HL7 event protocol to post message to (name or ptr)
 ;         USER - User causing message generation (DUZ or name)
 ;                Defaults to current DUZ
 ;         HLL("LINKS") - Refer to HL7 Dev Guide for definition
 ;                        Use of this array is optional
 ;Output : MsgID - HL7 message ID
 ;         0^Text - Error
 ;Notes  : An error will be returned if USER evaluates to a number and
 ;         that number is not a valid DUZ
 ;       : It is assumed that EVNTPROT is defined to have a message
 ;         type of 'ADT' and event type of 'A08'
 ;
 ;Check input
 S DFN=+$G(DFN)
 I '$D(^DPT(DFN,0)) Q "0^Did not pass valid DFN"
 I '$D(EVNTPROT) Q "0^Did not pass reference to HL7 event protocol"
 I '$D(USER) S USER=+$G(DUZ) S:'USER USER=""
 I USER S USER=$$GET1^DIQ(200,(USER_","),.01) D CLEAN^DILF
 I USER="" Q "0^Did not pass reference to user causing event"
 ;Declare variables
 N VARPTR,PIVOTNUM,PIVOTPTR,INFOARR,MSGARR,TMP,RESULT
 ;Create entry in ADT/HL7 PIVOT file
 S VARPTR=DFN_";DPT("
 S PIVOTNUM=+$$PIVNW^VAFHPIVT(DFN,$P(DT,"."),4,VARPTR)
 I (PIVOTNUM<0) Q "0^Unable to create/find entry in ADT/HL7 PIVOT file"
 ;Convert pivot number to pointer
 S PIVOTPTR=+$O(^VAT(391.71,"D",PIVOTNUM,0))
 I ('PIVOTPTR) Q "0^Unable to create/find entry in ADT/HL7 PIVOT file"
 ;Set variables needed to build HL7 message
 S INFOARR=$NA(^TMP("DG53494",$J,"INFO"))
 S MSGARR=$NA(^TMP("HLS",$J))
 K @INFOARR,@MSGARR
 S @INFOARR@("PIVOT")=PIVOTPTR
 S @INFOARR@("EVENT-NUM")=PIVOTNUM
 S @INFOARR@("VAR-PTR")=VARPTR
 S @INFOARR@("SERVER PROTOCOL")=EVNTPROT
 S @INFOARR@("REASON",1)=""
 S @INFOARR@("USER")=USER
 S @INFOARR@("DFN")=DFN
 S @INFOARR@("EVENT")="A08"
 S @INFOARR@("DATE")=$$NOW^XLFDT()
 ;Build message
 S TMP=$$BLDMSG^VAFCMSG1(DFN,"A08",$$NOW^XLFDT(),INFOARR,MSGARR)
 I (TMP<1) K @INFOARR,@MSGARR Q "0^"_$P(TMP,"^",2)
 ;Send message
 D GENERATE^HLMA(EVNTPROT,"GM",1,.RESULT)
 ;Store message ID (or error text) in pivot file
 S TMP=$S($P(RESULT,"^",2):$P(RESULT,"^",3),1:+RESULT)
 D FILERM^VAFCUTL(PIVOTPTR,TMP)
 ;Done
 K @INFOARR,@MSGARR
 I '$P(RESULT,"^",2) S RESULT=+RESULT
 I $P(RESULT,"^",2) S RESULT="0^"_$P(RESULT,"^",3)
 Q RESULT
 ;
TASK ;Entry point for TaskMan to do bulk send
 ;Input  : ARRAY - List of patients to send (full global reference)
 ;                 ARRAY(x) = yyy
 ;                            x is pointer to Patient file (#2)
 ;                            yyy can be anything (it's ignored)
 ;         EVNTPROT - Pointer to event protocol
 ;         DUZ - User that caused name changes
 ;Notes  : Contents of ARRAY will be deleted upon completion
 ;
 ;Make sure partition contains input
 Q:'$D(ARRAY)
 Q:'$D(EVNTPROT)
 Q:'$D(DUZ)
 ;Declare variables
 N IENS,ITEM,SUBS,OUT
 ;Make sure event protocol has subscribers
 S IENS=","_EVNTPROT_","
 D LIST^DIC(101.01,IENS,.01,"I",,,,,,,"ITEM")
 D LIST^DIC(101.0775,IENS,.01,"I",,,,,,,"SUBS")
 D CLEAN^DILF
 ;No subscribers - delete contents of ARRAY and quit
 I ('$G(ITEM("DILIST",0)))&('$G(SUBS("DILIST",0))) D  Q
 .K @ARRAY
 ;Send messages
 K MULT,IENS
 S OUT=$NA(^TMP("VAFCMS03",$J))
 D BULKA08(ARRAY,EVNTPROT,DUZ,OUT)
 K @ARRAY,@OUT
 S ZTREQ="@"
 Q
