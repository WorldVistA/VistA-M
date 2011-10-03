LR7OF0 ;slc/dcm/JAH - Receive/Route MSG array from OE/RR ;8/10/04
 ;;5.2;LAB SERVICE;**121,187,223,230,256,291**;Sep 27, 1994
 ;
 ;This routine invokes IA #2187
 ;
EN(MSG,MSGTYPE) ;Route all messages from here
 ;MSG=HL7 message array
 ;MSGTYPE=LRCH for chem (default), LRAP for AP
 N X,VISIT,LOC,LOCP,ROOM,DFN,LRPNM,LRXMSG,TEST,TESTN,TYPE,SAMP,SPEC,URG,ORIFN,STARTDT,LRDUZ,PROV,REASON,LRSX,LRLLOC,LROLLOC,LRPRAC,LROUTINE,LRSDT,LRXZ,LRODT,LRSAMP,LRSPEC,LRORDR,LRLB,LRNT,LRSX,LROT,LRCOM,LRI,LRIO,LRJ,LRORD,QUANT
 N LOCA,LINE,LRHDR,LRORDER,LRORIFN,LRSN,LRSUM,LRSXN,LRTIME,LRTSTS,LRURG,LRSDT,LREND,LRXTYPE,LRXORC,LRDFN,LRDPF,LRPLACR,LRQUANT,LRVERZ,NOBR,NORC
 S (NOBR,NORC)=1 ;flag to check for OBR, ORC segments
 D END
 S LRI=2,LRXORC="ORC"
 F  S LRI=$O(MSG(LRI)) Q:LRI<1  S X=MSG(LRI) I $P(MSG(LRI),"|")="ORC" S LRXORC=MSG(LRI),NORC=0 Q
 S LRHDR=$$HDRCHK($G(MSG(1)))
 Q:'$L(LRHDR)
 I '$$PIDCHK($G(MSG(2))) Q
 I LRHDR="BHS" K ^TMP("OR",$J,"LRES")  Q  ;Initialization to begin batch
 I LRHDR="BTS" D  Q  ;Clean-up to end batch
 . D LC
 . K ^TMP("OR",$J,"LRES")
 S LINE=2,LRSX=0,LREND=0 F  S LINE=$O(MSG(LINE)) Q:LINE<1  S LRXMSG=MSG(LINE) D:$O(MSG(LINE,0)) SPLIT D  I LREND Q
 . I $P(LRXMSG,"|")="PV1" S VISIT=$P(LRXMSG,"|",19),LOC=$P($P(LRXMSG,"|",4),"^"),ROOM=$P($P(LRXMSG,"|",4),"^",2),LOCP=LOC,LOCA=$S(LOCP:$P(^SC(LOCP,0),"^",2),1:"") Q
 . I $P(LRXMSG,"|")="ORC" S NORC=0,LRXTYPE=$P(LRXMSG,"|",2),LRXORC=LRXMSG I LRXTYPE="NW" D NEW^LR7OF2 Q  ;New order, from OE/RR
 . I $P(LRXMSG,"|")="ORC",LRXTYPE="CA" Q  ; D CANC^LR7OF2 S LREND=1 Q  ;Cancel order, from OE/RR
 . I $P(LRXMSG,"|")="OBR" S NOBR=0 I LRXTYPE="CA" D CANC^LR7OF2 Q  ;Cancel tests identified in OBR segment
 . I $P(LRXMSG,"|")="ORC",LRXTYPE="Z@" D PURG1^LR7OF4 S LREND=1 Q  ;Purge request-weird
 . I $P(LRXMSG,"|")="OBR",LRXTYPE="Z@" D PURG^LR7OF4 S LREND=1 Q  ;Purge request
 . I $P(LRXMSG,"|")="ORC",LRXTYPE="XO" D XO^LR7OF2 Q  ;Change order
 . I $P(LRXMSG,"|")="ORC",LRXTYPE="NA" D NUM^LR7OF2 Q  ;Backdoor new order, request order number
 . I $P(LRXMSG,"|")="ORC" S X="Unrecognized order control: "_LRXTYPE D ACK("DE",LRXORC,X) Q
 . I $P(LRXMSG,"|")="OBR",LRXTYPE="NA" D NA^LR7OF2 Q  ;Backdoor assign ORIFN to test
 . I $P(LRXMSG,"|")="OBR",LRXTYPE="NW" D OBR^LR7OF3 Q
 . I $P(LRXMSG,"|")="OBR",LRXTYPE="XO" D OBR^LR7OF3 Q
 . I $P(LRXMSG,"|")="DG1" D DG1^LRBEBA2(LRXMSG) Q    ; CIDC
 . I $P(LRXMSG,"|")="ZCL" D ZCL^LRBEBA2(LRXMSG) Q    ; CIDC
 . I $P(LRXMSG,"|")="NTE" D NTE^LR7OF2 Q  ;Order comments
 . D ACK("DE",LRXORC,"Unrecognized Message segment: "_$P(LRXMSG,"|")) Q
 I LREND S LREND=0 D END Q
 I NORC D ACK("OC",LRXORC,"Incomplete transaction...no ORC segment in message!") D END Q
 I NOBR D ACK("OC",LRXORC,"Incomplete transaction...no OBR segment in message") D END Q
 I LRXTYPE="NW" D  ;Process new order request
 . N REJECT
 . S LROLLOC=LOCP,LRLLOC=$S($L($G(LOCA)):LOCA,1:"UNKNOWN"),LRPRAC=PROV,LROUTINE=$P(^LAB(69.9,1,3),"^",2)
 . I $D(^TMP("OR",$J,"LROT")) S LRSDT=0 D
 .. F  S LRSDT=$O(^TMP("OR",$J,"LROT",LRSDT)) Q:LRSDT<1  S LRXZ="" F LRI=0:0 S LRXZ=$O(^TMP("OR",$J,"LROT",LRSDT,LRXZ)) Q:LRXZ=""  S LRODT=$P(LRSDT,".") D
 ... I $G(MSGTYPE)="LRAP" D EN^LR7OFA1 Q
 ... D EN^LR7OF1
 . D END,ACK("OK","ORC|OK|"_LRPLACR_"|"_LRORD_";"_LRODT_";"_LRSN_"^"_$S($G(MSG)="BBMSG":"LRBB",$G(MSG)="APMSG":"LRAP",1:"LRCH"),"")
 Q
HDRCHK(HDR) ;Check & return message Header (BHS,MSH,BTS)
 I '$L(HDR) D ACK("DE",LRXORC,"No Message Header Defined") Q ""
 I $P(HDR,"|")="BTS" Q "BTS"
 I $P(HDR,"|")'="BHS",$P(HDR,"|")'="MSH" D ACK("DE",LRXORC,"Invalid Message Header: "_$P(HDR,"|")) Q ""
 I $P(HDR,"|",2)'="^~\&" D ACK("DE",LRXORC,"Invalid Encoding Characters: "_$P(HDR,"|",2)) Q ""
 I $P(HDR,"|",3)'="ORDER ENTRY" D ACK("DE",LRXORC,"Unrecognized message source: "_$P(HDR,"|",3)) Q ""
 I $P(HDR,"|",4)'=DUZ(2) D ACK("DE",LRXORC,"DUZ(2) doesn't match institution in message: "_DUZ(2)_"'="_$P(HDR,"|",4)) Q ""
 I $P(HDR,"|")="MSH",$P(HDR,"|",9)'="ORM"&($P(HDR,"|",9)'="ORR") D ACK("DE",LRXORC,"Unrecognized Message type: "_$P(HDR,"|",9)) Q ""
 Q $P(HDR,"|")
 ;
PIDCHK(PID) ;Check PID & setup patient variables (DFN,LRDPF,LRDFN,LRPNM)
 I '$L(PID) D ACK("DE",LRXORC,"No Patient ID in message") Q 0
 I $P(PID,"|")'="PID" D ACK("DE",LRXORC,"Invalid (PID) message header: "_$P(X,"|")) Q 0
 I '$L($P(PID,"|",6)) D ACK("DE",LRXORC,"No Patient Name") Q 0
 S DFN=$S($P(PID,"|",4):$P(PID,"|",4),1:+$P(PID,"|",5)),LRDPF=$S($P(PID,"|",4):"2^DPT(",1:$P(@("^"_$P($P(PID,"|",5),";",2)_"0)"),"^",2)_"^"_$P($P(PID,"|",5),";",2)),LRPNM=$P(PID,"|",6),LRDFN=$$LRDFN^LR7OR1(+DFN,$P(LRDPF,"^",2))
 I 'LRDFN D END^LRDPA I LRDFN<1 D ACK("DE",LRXORC,"Invalid LRDFN") Q 0
 I '$D(@("^"_$P(LRDPF,"^",2)_+DFN_",0)")) D ACK("DE",LRXORC,"Patient identifier: "_LRDFN_" not found in "_LRDPF_" file") Q 0
 Q 1
 ;
LC ;Print to LC Lab device
 N LRSDT,LRXZ,CTR,LRODT,LRSN,LRPTR
 S LRSDT=0
 F  S LRSDT=$O(^TMP("OR",$J,"LRES",LRDFN,LRSDT)) Q:'LRSDT  S LRXZ="" F  S LRXZ=$O(^TMP("OR",$J,"LRES",LRDFN,LRSDT,LRXZ)) Q:LRXZ=""  D
 . S CTR=0 F  S CTR=$O(^TMP("OR",$J,"LRES",LRDFN,LRSDT,LRXZ,CTR)) Q:'CTR  S X=^(CTR) D
 .. S LRPTR(LRXZ,$P(X,"^",2),$P(X,"^",3))=""
 S LRODT=0 F  S LRODT=$O(LRPTR("LC",LRODT)) Q:'LRODT  S LRSN=0 F  S LRSN=$O(LRPTR("LC",LRODT,LRSN)) Q:'LRSN  D
 . S ION=$P($G(^LAB(69.9,1,3.5,+DUZ(2),0)),U,2) S:ION="" ION=$P(^LAB(69.9,1,3),U,4) I ION]"" D ^LROW2P
 S LRODT=0 F  S LRODT=$O(LRPTR("I",LRODT)) Q:'LRODT  S LRSN=0 F  S LRSN=$O(LRPTR("I",LRODT,LRSN)) Q:'LRSN  D
 . S ION=$P($G(^LAB(69.9,1,7,DUZ(2),0)),U,3) I ION]"" D ^LROW2P
 Q
ACK(TYPE,MSG3,COMMENT) ;Send back ok or nok to OE/RR
 ;TYPE=Message control
 ;COMMENT=Comment to be passed back
 ;MSG3=contents of MSG(3) containing the ORC segment
 N LRMSG,ARRAY,X8,VAR
 I TYPE="DE" S VAR("XQY0")="" D EN^ORERR("BAD msg xchng OE/RR->LAB:"_$G(COMMENT),.MSG,.VAR) S:$P($G(MSG3),"|",2)="NW" TYPE="OC" ;Trap problem message and send back to OE/RR as an OC type
 S LRMSG(1)=$$MSH^LR7OU0("ORR")
 S LRMSG(2)=$G(MSG(2))
 S LRMSG(3)=$G(MSG3),$P(LRMSG(3),"|",2)=TYPE
 I $O(REJECT(0)),$O(^ORD(100.03,"C","LRDUP",0)) S X8=$$DC1^LROR6($O(^(0)),"Already ordered for this specimen, type and time"),$P(LRMSG(3),"|",2)="OC",$P(LRMSG(3),"|",4)="",$P(LRMSG(3),"|",17)=X8
 I $D(COMMENT) N MSG S MSG="LRMSG",ARRAY(1)=COMMENT D NTE^LR7OU01(1,"L","ARRAY(",4)
 S LRMSG="LRMSG"
 D MSG^XQOR("LR7O CH EVSEND OR",.LRMSG) ;Lab accepts, returns Order #
 Q
SPLIT ;Build array for long segment
 N I
 S I=0 F  S I=$O(MSG(LINE,I)) Q:I<1  S LRXMSG(I)=MSG(LINE,I)
 Q
END ;Clean-up and get out
 K ^TMP("OR",$J,"LROT"),^("COM")
 Q
