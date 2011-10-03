MDHL7U3 ; HOIFO/WAA -Utilities for CP to process HL7 messages  ;02/17/10  15:59
 ;;1.0;CLINICAL PROCEDURES;**6,21**;Apr 01, 2004;Build 30
 ; Reference DBIA #2729 [Supported]  for XMXPAI
 ; Reference DBIA #4262 [Supported] for HLUOPT2 call.
 ; Reference DBIA #3244 [Subscription] for MSH node of HLMA file (#773).
 ; Reference DBIA #3273 [Subscription] for reference HLMA of file (#773).
 ; Reference DBIA #10138 [Supported] for reference of HL file (#772).
 ; Reference DBIA #3990 [Supported] for ICDCODE call
 ; Reference DBIA #1131 [Supported] for XMB("NETNAME") reference
 ; Reference DBIA #1995 [Supported] for ICPTCOD to handle CPT Codes call
 ; Reference DBIA #10060 [Supported] NEW PERSON FILE (#200) Lookup.
 ; Reference DBIA #10111 [Supported] for FILE 3.8 call
 ; Reference DBIA #10103 [Supported] for XLFDT call
 ;
HL7CHK(MDD702) ; Check to see of there is an entry in 703.1 for a patient.
 N X
 S X="1^"
 D
 . N Y
 . I $G(^MDD(702,MDD702,0))="" S X="-1^No Entry in 702." Q
 . I $D(^MDD(703.1,"ASTUDYID",MDD702))=0 Q
 . S Y=0
 . S Y=$O(^MDD(703.1,"ASTUDYID",MDD702,Y)) I Y>0 S X="-1^This Study has Data on file."
 . Q
 Q X
XVERT(MDA,MDB) ; Strip out blank Lines
 Q:MDA=""
 Q:MDB=""
 Q:$G(^TMP($J,MDA,1))
 N I,CNT,CNT2,NODE,FLG
 S (CNT,I,FLG)=0
 F  S I=$O(^TMP($J,MDA,I)) Q:I<1  D
 . S NODE=$TR(^TMP($J,MDA,I),$C(10),"")
 . I NODE=" " S NODE=""
 . I NODE="" S FLG=0 Q
 . I FLG  D  Q
 . . S CNT2=CNT2+1
 . . S ^TMP($J,MDB,CNT,CNT2)=NODE
 . . Q
 . I 'FLG D  Q
 . . S CNT=CNT+1
 . . S ^TMP($J,MDB,CNT)=NODE
 . . S FLG=1,CNT2=0
 . . Q
 . Q
 Q
 ;
PURGE(MDD7031) ;
 ; This sub-routine will delete HL7 772 Message text after a message
 ; been processed by Imaging.
 Q:'$D(^MDD(703.1,MDD7031,0))  ; No entry found
 S MDD772=$P(^MDD(703.1,MDD7031,0),U,6) Q:MDD772=""
 D DELBODY^HLUOPT2(MDD772,"CLINICAL PROCEDURES message purge","^TMP($J,""IN"")")
 S $P(^MDD(703.1,MDD7031,0),U,6)=""
 Q
 ;
PHY(X,MDIEN) ; Add the doc who did the exam to the report
 Q
 ; This will be implemented with the Doctor Lookup when it comes out.
 N LINE1,LINE
 S LINE1=$P(X,"|",17)
 S LINE=$P(LINE1,"^",2) ; Last
 S LINE=LINE_$S($P(LINE1,"^",3)'="":", "_$P(LINE1,"^",3),1:"") ; First
 S LINE=LINE_$S($P(LINE1,"^",4)'="":" "_$P(LINE1,"^",4),1:"") ; MI
 D ADD(MDIEN,"9",LINE)
 Q
 ;
CPTICD(X,MDIEN) ; Break out CPT and ICD9 codes
 N ICD,CPT
 Q:MDIEN<1
 S CPT=$P(X,"|",45) I CPT'="" D FILECD(MDIEN,CPT,"7")
 S ICD=$P(X,"|",14) I ICD'="" D FILECD(MDIEN,ICD,"8")
 Q
FILECD(MDIEN,CODE,TYPE) ; fILE THE DATA
 N LINE,Y,I,CNT,RESULT
 S CNT=$L(CODE,"~")
 S LINE=""
 F I=1:1:CNT S Y=$P(CODE,"~",I),RESULT=$P(Y,"^",1),LINE(.2,I,0)=RESULT
 S LINE(.2,0)="^^"_CNT_"^"_CNT_"^"_$P(%,".")
 Q:CNT<1  ; file the results if there is any
 D ADD(MDIEN,TYPE,.LINE,CNT)
 Q
 ;
ADD(MDIEN,TYPE,LINE,CNT) ;
 ; Create an entry in the .1 node
 N NODE,X
 S NODE=$G(^MDD(703.1,MDIEN,.1,0)) Q:NODE=""
 S NODE=$P(NODE,"^",3)
 S NODE=NODE+1
 S $P(^MDD(703.1,MDIEN,.1,0),"^",3,4)=NODE_"^"_NODE
 S $P(^MDD(703.1,MDIEN,.1,NODE,0),"^")=TYPE
 D NOW^%DTC
 M ^MDD(703.1,MDIEN,.1,NODE)=LINE
 Q
 ;
MSGIEN(MDHLIENS,MDHLREST) ; Return the message as definded in MDHLIENS  to the array in MDHLREST
 ; Only TCP type messages
 ; input: MDHLIENS= the intern entry number of the message in ^HLMA
 ; MDHLREST = the return array that will contain the whole HL7 message
 ; output: return "1^Message complete" if message was successful, "0^reason" if failed.
 ;
 N MDHLIEN,MDHLI,MDHLCNT,MDHLZ,RET
 S (MDHLCNT,MDHLI,RET)=0
 I $G(MDHLIENS)="" S RET=RET_"^No IEN defined" Q RET  ; Exit because no IEN for ^HLMA was provided
 I $G(MDHLREST)="" S RET=RET_"^No Return ARRAY provided" Q RET  ; Exit because no return array was provided
 I $G(^HLMA(MDHLIENS,0))="" S RET=RET_"^HLMA entry does not exist" Q RET  ; Exit because invalid OR non-EXISTING HLMA ENTRY
 S MDHLIEN=$P(^HLMA(MDHLIENS,0),U)
 I MDHLIEN="" S RET=RET_"^No pointer value to file 772" Q RET  ; No Pointer to 772
 I $G(^HL(772,MDHLIEN,0))="" S RET=RET_"^772 Entry does not exist" Q RET  ; No 772 entry exist
 ;get header
 S MDHLZ=$G(^HLMA(MDHLIENS,"MSH",1,0))
 I MDHLZ="" S RET=RET_"^No MSH segment found" Q RET  ; No MSH was found
 S MDHLCNT=MDHLCNT+1,@MDHLREST@(MDHLCNT)=MDHLZ
 S MDHLCNT=MDHLCNT+1,@MDHLREST@(MDHLCNT)=""
 ;get body
 S MDHLI=0
 F  S MDHLI=$O(^HL(772,MDHLIEN,"IN",MDHLI)) Q:'MDHLI  D
 . S MDHLCNT=MDHLCNT+1
 . S @MDHLREST@(MDHLCNT)=$G(^HL(772,MDHLIEN,"IN",MDHLI,0))
 . Q
 I MDHLCNT'>2 S RET=RET_"^No message body found" Q RET  ; There was no body
 S RET="1^Message complete"
 Q RET
 ;
CICNV(MDIEN,RETURN) ; This subroutine will read the data in 703.1 and return the results
 ;in the indicated global
 N NODE,FLG
 S FLG=1
 Q:MDIEN=""  ; The ien was null
 Q:RETURN=""  ; the array was null
 S ARRAY(0)="0^0"
 I $G(^MDD(703.1,MDIEN,.1,0))="" S FLG=0 Q  ; There is not data.
 ; Start the processing of ICD/POV codes Value is 8
 S NODE=0
 I FLG I $G(^MDD(703.1,MDIEN,.1,0))'="" D
 . F  S NODE=$O(^MDD(703.1,MDIEN,.1,NODE)) Q:NODE<1  D
 . . S TYPE=$P($G(^MDD(703.1,MDIEN,.1,NODE,0),0),"^",1)
 . . I TYPE=8 D PROCESS(MDIEN,NODE,TYPE,.ARRAY)
 . . I TYPE=7 D PROCESS(MDIEN,NODE,TYPE,.ARRAY)
 . . Q
 . Q
 M @RETURN=ARRAY
 Q
PROCESS(MDIEN,NODE,TYPE,ARRAY) ; This will process the data for each
 N CNT,X,CONT,CODE,AR,TP,LOC
 S CNT=0,CONT=0
 F  S CNT=$O(^MDD(703.1,MDIEN,.1,NODE,.2,CNT)) Q:CNT<1  D
 . S CODE=$G(^MDD(703.1,MDIEN,.1,NODE,.2,CNT,0),"") ; Grabbing the ICD9 AND CPT codes
 . I CODE="" Q
 . I TYPE=8 S AR=1,TP="POV",X=$$ICDDX^ICDCODE(CODE) Q:X=""  ; Reference DBIA #3990 [Supported] for ICDCODE call
 . I TYPE=7 S AR=2,TP="CPT",X=$$CPT^ICPTCOD(CODE) Q:X=""  ; Reference DBIA #1995 [Supported] for ICPTCOD to handle CPT Codes call
 . S CONT=CONT+1
 . S ARRAY(AR)=CONT_"^"_CONT
 . I AR=1 D
 . . N DESC,IN,LN
 . . S IN=$P(X,"^",1) Q:IN<1
 . . S DESC=$P(X,"^",4) Q:DESC=""
 . . S I=CONT
 . . S $P(ARRAY(AR,I),"^",1)=TP
 . . S $P(ARRAY(AR,I),"^",2)=$P(X,"^",1)
 . . S $P(ARRAY(AR,I),"^",3)=$P(X,"^",2)
 . . S $P(ARRAY(AR,I),"^",5)=DESC
 . . S $P(ARRAY(AR,I),"^",6)=$S(I=1:1,1:0)
 . . Q
 . I AR=2 D
 . . N DESC,IN,LN,LEX,CPTCNT
 . . S IN=$P(X,"^",1) Q:IN<1
 . . D CPTLEX^MDRPCWU(.LEX,CODE,"CPT")
 . . Q:$D(^TMP("MDLEX",$J))<1
 . . S DESC="",CPTCNT=""
 . . F  S CPTCNT=$O(^TMP("MDLEX",$J,CPTCNT)) Q:CPTCNT<1  D  Q:$L(DESC)>200
 . . . N LINE
 . . . S LINE=$P(^TMP("MDLEX",$J,CPTCNT),"^",3)
 . . . Q:LINE=""
 . . . S DESC=DESC_LINE_" "
 . . . Q
 . . I $L(DESC)>200 S DESC=$E(DESC,1,200)
 . . ; S LN=$G(^ICPT(IN,0),0) Q:LN=""
 . . ; S DESC=$P(X,"^",3) Q:DESC=""  ; DBIA1995 $$CPT^ICPTCOD(CODE) returns X and the second piece of X is the DESC
 . . S I=CNT
 . . S $P(ARRAY(AR,I),"^",1)=TP
 . . S $P(ARRAY(AR,I),"^",2)=$P(X,"^",1)
 . . S $P(ARRAY(AR,I),"^",3)=$P(X,"^",2)
 . . S $P(ARRAY(AR,I),"^",5)=DESC
 . . ; S $P(ARRAY(AR,I),"^",5)=LEX^MDRPCW1(RESULTS,CODE,"CPT") ; 02
 . . S $P(ARRAY(AR,I),"^",7)=$S(I=1:1,1:0)
 . . Q
 . Q
 I $D(ARRAY(1))!$D(ARRAY(2)) S ARRAY(0)="1^1"
 Q
 ;
NOTICE(SUBJECT,TXT,DEVIEN,DUZ) ; This will fire off a mail message to the Indicated mail group saying that a study was deleted
 ;
 N INST,MG,XMTO,XMDUZ,XMSUBJ,XMBODY,N,X
 S MG=0
 S INST=DEVIEN
 I INST>1 S MG=$P($G(^MDS(702.09,INST,0)),"^",2)
 I 'MG!('$$MG^MDHL7U2(MG)) S MG=$$FIND1^DIC(3.8,"","BX","MD DEVICE ERRORS") Q:'MG
 S MG=$$GET1^DIQ(3.8,+MG_",",.01)
 S XMTO="G."_MG_"@"_^XMB("NETNAME"),XMINSTR("FROM")=.5
 S XMBODY="TXT"
 S XMSUBJ=SUBJECT
 D SENDMSG^XMXAPI(DUZ,XMSUBJ,XMBODY,XMTO,.XMINSTR)
 Q
 ;
ALERT(MDSIEN) ; This is to send an e-mail to the main device mail group that a study has been deleted
 D NOW^%DTC
 S SUBJECT="Study "_MDSIEN_" for Patient "_$$GET1^DIQ(702,MDSIEN,.01,"E")_" has been DELETED!"
 S BODY(1)="The following study has been deleted."
 S BODY(2)="         By the USER:       "_$$GET1^DIQ(200,DUZ,.01,"E")
 S BODY(3)="             On Date:       "_$$FMTE^XLFDT(%,1)
 S BODY(4)="           "
 S BODY(5)="                   CP Study Information"
 S BODY(6)="------------------------------------------------------------------------------ "
 S BODY(7)="CP Study ID:       "_MDSIEN
 S BODY(8)="CP Study Def:      "_$$GET1^DIQ(702,MDSIEN,.04,"E")
 S BODY(9)="Created on:        "_$$FMTE^XLFDT($$GET1^DIQ(702,MDSIEN,.02,"I"),1)
 S BODY(10)="Created by:        "_$$GET1^DIQ(702,MDSIEN,.03,"E")
 S BODY(11)="On Instrument:     "_$$GET1^DIQ(702,MDSIEN,.11,"E")
 S BODY(12)="For Patient:       "_$$GET1^DIQ(702,MDSIEN,.01,"E")
 S BODY(13)="        SSN:       "_$E($$GET1^DIQ(702,MDSIEN,.011,"E"),6,9)
 S BODY(14)="        DOB:       "_$$FMTE^XLFDT($$GET1^DIQ(702,MDSIEN,.012,"I"),1)
 S DEVIEN=$$GET1^DIQ(702,MDSIEN,.11,"I")
 Q
