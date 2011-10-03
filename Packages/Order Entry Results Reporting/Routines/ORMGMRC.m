ORMGMRC ; SLC/MKB - Process Consult ORM msgs ;03/17/09  10:58
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**3,26,68,92,153,174,195,255,243,280**;Dec 17, 1997;Build 85
EN ; -- entry point for GMRC messges
 I '$L($T(@ORDCNTRL)) Q  ;S ORERR="Invalid order control code" Q
 I ORDCNTRL'="SN",ORDCNTRL'="ZP",'ORIFN!('$D(^OR(100,+ORIFN,0))) S ORERR="Invalid OE/RR order number" Q
 S:ORDCNTRL="OC"&(ORTYPE="ORR") ORDCNTRL="UA" ;new code
 N ORSTS,OREASON1,NTE S ORSTS=$$STATUS(ORDSTS)
 S:'ORLOG ORLOG=$$NOW^XLFDT S:'ORDUZ ORDUZ=DUZ S:$G(DGPMT) ORDUZ=""
 S OREASON=$P(OREASON,U,5),NTE=$O(@ORMSG@(+ORC)),OREASON1=""
 I NTE,$E(@ORMSG@(NTE),1,3)="NTE" S OREASON1=$P(@ORMSG@(NTE),"|",4)
 D @ORDCNTRL
 Q
 ;
ZP ; -- Purged
 Q:'ORIFN  Q:'$D(^OR(100,+ORIFN,0))
 K ^OR(100,+ORIFN,4) I "^3^5^6^8^"[(U_$P($G(^(3)),U,3)_U) D STATUS^ORCSAVE2(+ORIFN,14) ; Remove pkg reference, sts=lapsed if still active
 Q
 ;
ZR ; -- Purged as requested [ack]
 D DELETE^ORCSAVE2(+ORIFN)
 Q
 ;
ZU ; -- Unable to purge [ack]
 S $P(^OR(100,+ORIFN,3),U)=$$NOW^XLFDT ; update Last Activity
 Q
 ;
OK ; -- Order accepted, GMRC order # assigned [ack]
 S ^OR(100,+ORIFN,4)=PKGIFN S:'$G(ORSTS) ORSTS=5
 D STATUS^ORCSAVE2(+ORIFN,ORSTS) ; 5=pending
 D DATES^ORCSAVE2(+ORIFN,+$E($$NOW^XLFDT,1,12))
 Q
 ;
XX ; -- Change order
 N ORDIALOG,ORDG,ORDA,ORX,ORP,ORSIG S:'$L(ORNATR) ORNATR="S"
 D DLG Q:$D(ORERR)  Q:'$D(ORDIALOG)  S ORIFN=+ORIFN
 S ORDA=$$ACTION^ORCSAVE("XX",ORIFN,ORNP,OREASON1,ORLOG,ORDUZ)
 I ORDA'>0 S ORERR="Cannot create new order action" Q
 ; -Update sts of order to active, last action to dc/edit:
 S ORX=+$P($G(^OR(100,ORIFN,3)),U,7) S:ORX'>0 ORX=+$O(^(8,ORDA),-1)
 I $D(^OR(100,ORIFN,8,ORX,0)),$P(^(0),U,15)="" S $P(^(0),U,15)=12
 S $P(^OR(100,ORIFN,3),U,7)=ORDA D:$G(ORSTS) STATUS^ORCSAVE2(ORIFN,ORSTS)
 D PXRMKILL^ORDD100(ORIFN,ORVP,ORLOG) ; JEH 255
 D RELEASE^ORCSAVE2(ORIFN,ORDA,ORLOG,ORDUZ,ORNATR)
 ; -If unsigned edit, leave XX unsigned & mark ORX as Sig Not Req'd
 S ORSIG=$S($P($G(^OR(100,ORIFN,8,ORX,0)),U,4)'=2:1,1:0)
 D SIGSTS^ORCSAVE2(ORIFN,ORDA):ORSIG,SIGN^ORCSAVE2(ORIFN,,,5,ORX):'ORSIG
 ; -Update responses, get/save new order text:
 K ^OR(100,ORIFN,4.5) D RESPONSE^ORCSAVE,ORDTEXT^ORCSAVE1(ORIFN_";"_ORDA)
 S $P(^OR(100,ORIFN,8,ORDA,0),U,14)=ORDA
 K:OREASON="RESUBMIT" ^OR(100,ORIFN,6) ;clear previous DC data
 D PXRMADD^ORDD100(ORIFN,ORVP,ORLOG) ; JEH 255
 I $G(ORL) S ORP(1)=+ORIFN_";"_ORDA_"^1" D PRINTS^ORWD1(.ORP,+ORL)
 Q
 ;
SN ; -- New backdoor order: return NA msg w/ORIFN, or DE msg
 N ORDIALOG,ORDG,ORP K ^TMP("ORWORD",$J) S:'$L(ORNATR) ORNATR="W"
 I '$D(^VA(200,ORNP,0)) S ORERR="Missing or invalid ordering provider" Q
 I ORDUZ,'$D(^VA(200,ORDUZ,0)) S ORERR="Invalid entering person" Q
 I '$G(ORL) S ORERR="Missing or invalid patient location" Q
 D DLG Q:$D(ORERR)  Q:'$D(ORDIALOG)
SN1 D EN^ORCSAVE K ^TMP("ORWORD",$J) ; setting status, xrefs
 I '$G(ORIFN) S ORERR="Cannot create new order" Q
 ;Save DG1 and ZCL segments of HL7 message from backdoor orders
 D BDOSTR^ORWDBA3
 D RELEASE^ORCSAVE2(ORIFN,1,ORLOG,ORDUZ,ORNATR),SIGSTS^ORCSAVE2(ORIFN,1)
 S:'ORSTRT ORSTRT=$$NOW^XLFDT D DATES^ORCSAVE2(+ORIFN,ORSTRT)
 D:$G(ORSTS) STATUS^ORCSAVE2(ORIFN,ORSTS)
 I $G(ORL) S ORP(1)=ORIFN_";1^1" D PRINTS^ORWD1(.ORP,+ORL) ; chart copy
 S ^OR(100,ORIFN,4)=PKGIFN
 Q
 ;
DLG ; -- Build ORDIALOG(),ORDG from msg
 N OBR,USID,TYPE,OI,ZSV,J,OBX,WP,I
 S OBR=$$OBR I 'OBR!($E($G(@ORMSG@(OBR)),1,3)'="OBR") S ORERR="Missing OBR segment" Q
 S USID=$P(@ORMSG@(OBR),"|",5),TYPE=$S(USID["99CON":"CONSULT",1:"REQUEST")
 S ORDIALOG=$O(^ORD(101.41,"AB","GMRCOR "_TYPE,0))
 D GETDLG1^ORCD(ORDIALOG)
 S ORDIALOG($$PTR("URGENCY"),1)=ORURG
 ;ORSTRT defined in routine ORM before coming here ;WAT/280
 S ORDIALOG($$PTR("EARLIEST DATE"),1)=ORSTRT ;WAT/280
 S OI=$$ORDITEM^ORM(USID) I 'OI S ORERR="Invalid consult or procedure" Q
 S ORDIALOG($$PTR("ORDERABLE ITEM"),1)=OI
 S ZSV=$O(@ORMSG@(OBR)) I ZSV,$E(@ORMSG@(ZSV),1,3)="ZSV" D
 . N X1,X2 S X1=$P(@ORMSG@(ZSV),"|",2),X2=$P(@ORMSG@(ZSV),"|",3)
 . I TYPE="REQUEST" S ORDIALOG($$PTR("REQUEST SERVICE"),1)=+$P(X1,U,4)
 . I TYPE="CONSULT",$L(X2) S ORDIALOG($$PTR("FREE TEXT OI"),1)=X2
D1 S ORDIALOG($$PTR("CATEGORY"),1)=$G(ORCAT)
 S J=$P(@ORMSG@(OBR),"|",19),ORDIALOG($$PTR("PLACE OF CONSULTATION"),1)=$S(J="OC":"C",1:J)
 S ORDIALOG($$PTR("PROVIDER"),1)=$P(@ORMSG@(OBR),"|",20)
 S OBX=OBR F  S OBX=$O(@ORMSG@(OBX)) Q:OBX'>0  S J=$E(@ORMSG@(OBX),1,3) Q:J="ORC"  Q:J="MSH"  I J="OBX" D
 . N SEG,NAME,VALUE S SEG=@ORMSG@(OBX)
 . S NAME=$$UP^XLFSTR($P($P(SEG,"|",4),U,2)),VALUE=$P(SEG,"|",6)
 . I NAME="PROVISIONAL DIAGNOSIS" D  Q
 .. S:$P(SEG,"|",3)="CE" ORDIALOG($$PTR("CODE"),1)=$P(VALUE,U),VALUE=$P(VALUE,U,2)
 .. S ORDIALOG($$PTR("FREE TEXT"),1)=VALUE
 . S WP=$$PTR("WORD PROCESSING 1"),I=1,^TMP("ORWORD",$J,WP,1,I,0)=VALUE
 . S J=0 F  S J=$O(@ORMSG@(OBX,J)) Q:J'>0  S I=I+1,^TMP("ORWORD",$J,WP,1,I,0)=@ORMSG@(OBX,J)
 S:$G(I) ^TMP("ORWORD",$J,WP,1,0)="^^"_I_U_I_U_DT_U,ORDIALOG(WP,1)="^TMP(""ORWORD"",$J,"_WP_",1)"
 Q
 ;
OBR() ; -- Return subscript of RXE segment
 N X,I,SEG S X="",I=+ORC
 F  S I=$O(@ORMSG@(I)) Q:I'>0  S SEG=$E(@ORMSG@(I),1,3) Q:SEG="ORC"  I SEG="OBR" S X=I Q
 Q X
 ;
SC ; -- Status changed (i.e. scheduled)
 S:'$G(ORSTS) ORSTS=6 D STATUS^ORCSAVE2(+ORIFN,ORSTS) ; 6=active
 Q
 ;
STATUS(X) ; -- Returns ptr to Order Status file #100.01
 Q $S(X="DC":1,X="CM":2,X="HD":3,X="IP":5,X="SC":6,X="A":9,X="RP":12,X="CA":13,X="ZC":8,1:5)
 ;
RE ; -- Completed, w/results
 N I,SEG,DA,DR,DIE,X,Y
 S:'$G(ORSTS) ORSTS=2 D STATUS^ORCSAVE2(+ORIFN,ORSTS)
 S X="",DA=+ORIFN,DIE="^OR(100,"
 S DR="71////"_+$E($$NOW^XLFDT,1,12) D ^DIE
 S I=+ORC,X="" F  S I=$O(@ORMSG@(I)) Q:I<1  S SEG=$G(@ORMSG@(I)) Q:$E(SEG,1,3)="ORC"  I $E(SEG,1,3)="OBX",$P(SEG,"|",4)["SIG FINDINGS" S X=$P(SEG,"|",6) Q
 S $P(^OR(100,DA,7),U,2)=$S(X="Y":1,1:"")
 S:'$G(ORNP) ORNP=+$P($G(^OR(100,+ORIFN,0)),U,4)
 I $P(ORC,"|",17)["MAINTENANCE" Q  ;group update - no CM ack needed
 I $L($T(ADD^ORRCACK)) D ADD^ORRCACK(+ORIFN,ORNP) ;Ack stub for prov
 Q
 ;
UA ; -- Unable to Accept [ack]
 S ORDUZ="" I '$L(OREASON1),$L(OREASON) S OREASON1=OREASON
OC ; -- Cancelled/Denied
 S:'$L(ORNATR) ORNATR="X" ;Rejected
 S ^OR(100,+ORIFN,6)=$O(^ORD(100.02,"C",ORNATR,0))_U_ORDUZ_U_ORLOG_U_U_OREASON1
 D STATUS^ORCSAVE2(+ORIFN,13) I ORDCNTRL="OC" D UPDATE("DC") Q
UD ; -- Unable to discontinue [ack]
 N DA S DA=$P(ORIFN,";",2) I DA D
 . S $P(^OR(100,+ORIFN,8,DA,0),U,15)=13 ;request rejected
 . S:$L(OREASON1) ^OR(100,+ORIFN,8,DA,1)=OREASON1
 Q
 ;
OD ; -- Discontinued
 S ^OR(100,+ORIFN,6)=$S($L(ORNATR):$O(^ORD(100.02,"C",ORNATR,0)),1:"")_U_ORDUZ_U_ORLOG_U_U_OREASON1
 D STATUS^ORCSAVE2(+ORIFN,1),UPDATE("DC"):$L(ORNATR)
 Q
 ;
DR ; -- Discontinued [ack]
 D STATUS^ORCSAVE2(+ORIFN,1)
 Q
 ;
UPDATE(ORACT) ; -- continue processing
 N ORX,ORDA,ORP
 S ORX=$$CREATE^ORX1(ORNATR) D:ORX
 . S ORDA=$$ACTION^ORCSAVE(ORACT,+ORIFN,ORNP,OREASON1,ORLOG,ORDUZ)
 . I ORDA'>0 S ORERR="Cannot create new order action" Q
 . D RELEASE^ORCSAVE2(+ORIFN,ORDA,ORLOG,ORDUZ,ORNATR)
 . D SIGSTS^ORCSAVE2(+ORIFN,ORDA)
 . I $G(ORL) S ORP(1)=+ORIFN_";"_ORDA_"^1" D PRINTS^ORWD1(.ORP,+ORL)
 . S $P(^OR(100,+ORIFN,3),U,7)=ORDA
 I 'ORX,ORACT="DC",'$$ACTV^ORX1(ORNATR) S $P(^OR(100,+ORIFN,3),U,7)=0
 D:$G(ORACT)="DC" CANCEL^ORCSEND(+ORIFN)
 Q
 ;
PTR(X) ; -- Returns ptr to prompt in Order Dialog file #101.41
 Q $O(^ORD(101.41,"AB",$E("OR GTX "_X,1,63),0))
