ORMVBEC ; SLC/MKB - Process VBECS order msgs ;2/11/08  11:05
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**212,309**;Dec 17, 1997;Build 26
 ;
EN ; -- entry point for VBEC messages from ORMHLREC
 ;M ^MKB(+ORIFN)=@ORMSG ;for testing
 I '$L($T(@ORDCNTRL)) Q  ;S ORERR="1^Invalid order control code" Q
 I '$G(ORIFN)!'$D(^OR(100,+$G(ORIFN),0)) S ORERR="1^Invalid order number" Q
 S:$G(ORLOG)<1 ORLOG=+$E($$NOW^XLFDT,1,12)
 D @ORDCNTRL
 Q
 ;
ACK(ORIFN) ; -- process DIRECT^HLMA acknowledgment [from ORMBLDVB]
 N ORMSG,I,J,MSH,MSA,ORC,ORTYPE,ORLOG,OREASON,ORNATR,ORDCNTRL,PKGIFN,X
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D  ;get,parse message from HL7 package
 . S ORMSG(I)=HLNODE,J=0 ;Get segment node
 . ; Get continuation nodes for long segments, if any
 . F  S J=$O(HLNODE(J)) Q:'J  S ORMSG(I,J)=HLNODE(J)
 ;I '$O(ORMSG(0)) D EN^ORERR("Missing HL7 message",.ORMSG) Q
 S MSH=0 F  S MSH=$O(ORMSG(MSH)) Q:MSH'>0  Q:$E(ORMSG(MSH),1,3)="MSH"
 I 'MSH S ORERR="1^Missing or invalid MSH segment" D ERR Q
 S MSA=+$O(ORMSG(MSH)) I 'MSA!($E($G(ORMSG(MSA)),1,3)'="MSA") D  Q
 . S ORERR="1^Missing or invalid MSA segment" D ERR
 S ORTYPE=$P(ORMSG(MSH),"|",9),MSA=MSA_U_ORMSG(MSA)
 S ORLOG=+$E($$NOW^XLFDT,1,12),OREASON=U_$P(MSA,"|",4),ORNATR=""
 I $P(MSA,"|",2)'="AA",'$O(ORMSG(+MSA)) D  Q  ;unsuccessful, no order#
 . S ORERR="1^"_$P(OREASON,U,2) D UA,ERR
 S ORC=+MSA F  S ORC=$O(ORMSG(+ORC)) Q:ORC<1  I $E(ORMSG(ORC),1,3)="ORC" D
 . S X=ORMSG(ORC),ORDCNTRL=$P(X,"|",2),PKGIFN=+$P(X,"|",4)
 . I '$G(ORIFN) S ORIFN=+$P(X,"|",3) I ORDCNTRL["U" D  ;find action to cancel
 .. N DA,CODE S CODE=$S(ORDCNTRL="UC":"DC",1:"NW")
 .. S DA=$O(^OR(100,DA,8,"C",CODE,"?"),-1) S:DA<1 DA=1
 .. S ORIFN=ORIFN_";"_DA
 . D @ORDCNTRL
 Q
 ;
ERR ; -- Log an error
 N X S X=$P(ORERR,U,2)
 D EN^ORERR(X,.ORMSG)
 Q
 ;
STATUS(X) ; -- Returns Order Status for HL7 code X
 N Y S Y=$S(X="OC":1,X="CM":2,X="IP":5,X="SC":6,X="ZE":7,1:"")
 Q Y
 ;
OK ; -- Order accepted, VBECS order # assigned [reply]
 S ^OR(100,+ORIFN,4)=PKGIFN ;VBECS identifier
 D STATUS^ORCSAVE2(+ORIFN,5) ;pending
 Q
 ;
SC ; -- Status changed
 N ORSTS S ORSTS=$$STATUS(ORDSTS)
 I ORSTS=1 D OC Q  ;Cancel
 D STATUS^ORCSAVE2(+ORIFN,ORSTS)
 D:ORSTS=6 DATES^ORCSAVE2(+ORIFN,ORLOG)                  ;Start Time
 D:ORSTS=7 DATES^ORCSAVE2(+ORIFN,,+$E($$NOW^XLFDT,1,12)) ;Stop Time
 Q
 ;
OC ; -- Cancelled
 G:ORTYPE["ORG" UA ;reject reply
 S:ORNATR="" ORNATR=+$O(^ORD(100.02,"C","X",0)) ;Rejected
 S ^OR(100,+ORIFN,6)=ORNATR_U_ORDUZ_U_ORLOG_U_U_$E($P(OREASON,U,2),1,80)
 D UPDATE(1,"DC"),LAB D  ;set parent's 6-node
 . N DAD S DAD=+$P($G(^OR(100,+ORIFN,3)),U,9)
 . I DAD,$P($G(^OR(100,DAD,3)),U,3)=1,'$D(^(6)) S ^OR(100,DAD,6)=^OR(100,+ORIFN,6)
 Q
 ;
CR ; -- Cancelled [reply]
 D STATUS^ORCSAVE2(+ORIFN,1)
 Q
 ;
UA ; -- Unable to accept [reply]
 S:'ORNATR ORNATR=$O(^ORD(100.02,"C","X",0)) ;rejected
 S ^OR(100,+ORIFN,6)=ORNATR_U_U_ORLOG_U_U_$E($P(OREASON,U,2),1,80)
 D STATUS^ORCSAVE2(+ORIFN,13),CANCEL ;cancel associated orders
UC ; -- Unable to cancel [reply]
DE ; -- Data Error [reply]
 N DA S DA=$P(ORIFN,";",2) Q:'DA
 S $P(^OR(100,+ORIFN,8,DA,0),U,15)=13 ;request rejected
 S:$L($P(OREASON,U,2)) ^OR(100,+ORIFN,8,DA,1)=$E($P(OREASON,U,2),1,240)
 Q
 ;
CANCEL ; -- cancel associated lab, parent orders
 N ORDAD
 S ORDAD=+$P($G(^OR(100,+ORIFN,3)),U,9) Q:'ORDAD
 D CANCEL^ORCSEND2(ORDAD,$P(OREASON,U,2)) ;cancel parent+children
 Q
 ;
UPDATE(ORSTS,ORACT) ; -- continue processing
 N DA,ORX,ORCMMT,ORP
 ;D DATES^ORCSAVE2(+ORIFN,ORSTRT,ORSTOP) ;DC stop set in $$STATUS
 D:$G(ORSTS) STATUS^ORCSAVE2(+ORIFN,ORSTS)
 S ORCMMT=$E($P(OREASON,U,2),1,240),ORX=$$CREATE^ORX1(ORNATR) D:ORX
 . S DA=$$ACTION^ORCSAVE(ORACT,+ORIFN,ORNP,ORCMMT,ORLOG,ORDUZ)
 . I DA'>0 S ORERR="1^Cannot create new order action" Q
 . D RELEASE^ORCSAVE2(+ORIFN,DA,ORLOG,ORDUZ,ORNATR)
 . D SIGSTS^ORCSAVE2(+ORIFN,DA)
 . I $G(ORL) S ORP(1)=+ORIFN_";"_DA_"^1" D PRINTS^ORWD1(.ORP,+ORL)
 . S $P(^OR(100,+ORIFN,3),U,7)=DA
 I '$$ACTV^ORX1(ORNATR) S $P(^OR(100,+ORIFN,3),U,7)=0
 D:ORACT="DC" CANCEL^ORCSEND(+ORIFN) ;cancel unreleased actions
 Q
 ;
ZP ; -- Purged
 Q:'ORIFN  Q:'$D(^OR(100,+ORIFN,0))
 S $P(^OR(100,+ORIFN,4),";",1,3)=";;" I "^5^6^"[(U_$P($G(^(3)),U,3)_U) D STATUS^ORCSAVE2(+ORIFN,$S($P(^(4),";",5):2,1:14)) ; Remove pkg reference, sts=lapsed if still active
 Q
 ;
ZR ; -- Purged as requested [reply]
 D DELETE^ORCSAVE2(+ORIFN)
 Q
 ;
ZU ; -- Unable to purge [reply]
 S $P(^OR(100,+ORIFN,3),U)=$$NOW^XLFDT ; update Last Activity
 Q
 ;
LAB ; -- find and cancel ORIFN'S associated Lab order
 N ORLRIFN S ORLRIFN=$$VALUE^ORX8(ORIFN,"LAB")
 I 'ORLRIFN D  ;search children for match
 . N ORDAD,ORIT,ORLAB,ORI,ORX
 . S ORDAD=+$P($G(^OR(100,+ORIFN,3)),U,9) Q:'ORDAD
 . S ORIT=$$VALUE^ORX8(ORIFN,"ORDERABLE",1,"E") Q:'$L(ORIT)
 . S ORLAB=$$PKG^ORMPS1("LR"),(ORLRIFN,ORI)=0
 . F  S ORI=+$O(^OR(100,ORDAD,2,+ORI)) Q:'ORI  I ORI'=+ORIFN D  Q:ORLRIFN
 .. Q:$P($G(^OR(100,ORI,0)),U,14)'=ORLAB
 .. S ORX=$$VALUE^ORX8(ORI,"ORDERABLE",1,"E")
 .. I ORX[ORIT S ORLRIFN=ORI Q
 D:ORLRIFN MSG^ORMBLD(ORLRIFN,"CA")
 Q
