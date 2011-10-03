ORMFH ;SLC/MKB - Process Dietetics ORM msgs ;5/5/05  13:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**3,73,92,215,243**;Dec 17, 1997;Build 242
 ;
EN ; -- entry point for FH messages
 I '$L($T(@ORDCNTRL)) Q  ;S ORERR="Invalid order control code" Q
 I ORDCNTRL'="SN",ORDCNTRL'="ZP",'ORIFN!('$D(^OR(100,+ORIFN,0))) S ORERR="Invalid OE/RR order number" Q
 S ORLOG=+$E($$NOW^XLFDT,1,12) S:'$G(ORDUZ) ORDUZ=DUZ S:'$G(ORNP) ORNP=ORDUZ
 S:$G(DGPMT) ORNATR="A",OREASON=$S(DGPMT=1:"Admission",DGPMT=3:"Discharge",1:"Transfer"),ORDUZ=""
 D @ORDCNTRL
 Q
 ;
ZP ; -- Purged
 Q:'ORIFN  Q:'$D(^OR(100,+ORIFN,0))
 K ^OR(100,+ORIFN,4) I "^6^8^"[(U_$P($G(^(3)),U,3)_U) D STATUS^ORCSAVE2(+ORIFN,14) ; Remove pkg reference, sts=lapsed if still active
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
OK ; -- Order accepted, FH order # assigned [ack]
 N ORSTS S ^OR(100,+ORIFN,4)=PKGIFN ; FH identifier
 I "DN"'[$E(PKGIFN) S ORSTS=6 ;not Diet or NPO
 E  S ORSTS=$S($P($G(^OR(100,+ORIFN,0)),U,8)>ORLOG:8,1:6)
 D STATUS^ORCSAVE2(+ORIFN,ORSTS)
 Q
 ;
XX ; -- Edited backdoor order (OP recurring meals only)
 D XX^ORMFH1 Q
 ;
SN ; -- New backdoor order: return NA msg w/ORIFN
 N ODS,ODT,OBR,ORDIALOG,X,I,OI,SEG,ORNEW,ORPARAM,ORTIME,ORSTS,ORDG,ORP,ORTRAIL
 ;I '$D(^VA(200,+ORNP,0)) S ORERR="Missing or invalid ordering provider"Q
 ; Don't require provider until Nature of Order is added
 I '$G(DGPMT),'$D(^VA(200,+ORDUZ,0)) S ORERR="Missing or invalid entering person" Q
 I 'ORSTRT S ORERR="Missing effective date/time" Q
 ;I '$G(ORL) S ORERR="Missing or invalid patient location" Q
 D EN1^FHWOR8(ORL,.ORPARAM)
 S ODS=$O(@ORMSG@(+ORC)) I 'ODS S ORERR="Incomplete message" Q
 S ODS=ODS_U_@ORMSG@(ODS),ORSTS=6 I '$L(ORNATR),ORCAT="I" S ORNATR="S"
 I $E($P(ODS,U,2),1,3)="OBR" S OBR=ODS D IP G SN1
 I $E($P(ODS,U,2),1,3)="ODT" S ODT=ODS D TRAY G SN1
 I $E($P(ODS,U,2),1,3)'="ODS" S ORERR="Missing or invalid ODS segment" Q
 I $P(ODS,"|",2)="ZE" D TF G SN1
 I $P(ODS,"|",4)?1"^^^FH-6".E D ADDL G SN1
 I ORCAT'="I" D OPM^ORMFH1 G SN1
 I $P(ODS,"|",4)?1"^^^FH-5".E D NPO G SN1
DIET ; Diet order
 S ORDIALOG=$O(^ORD(101.41,"AB","FHW1",0)),ORTRAIL="Diet"
 D GETDLG1^ORCD(ORDIALOG) S:ORSTRT>ORLOG ORSTS=8
 S ORDIALOG($$PTR("START DATE/TIME"),1)=ORSTRT
 S:ORSTOP ORDIALOG($$PTR("STOP DATE/TIME"),1)=ORSTOP
 S X=$P(ODS,"|",2),ORDIALOG($$PTR("DELIVERY"),1)=$S($L(X)=1:X,1:$E(X,2))
 ; Comments ??
 S X=$$ORDITEM^ORM($P(ODS,"|",4))
 I 'X S ORERR="Missing or invalid diet modification" Q
 S I=1,OI=$$PTR("ORDERABLE ITEM"),ORDIALOG(OI,I)=X
 I $O(@ORMSG@(+ODS)) F  S ODS=$O(@ORMSG@(+ODS)) Q:ODS'>0  S SEG=$E(@ORMSG@(+ODS),1,3) Q:SEG="ORC"  Q:SEG="MSH"  I SEG="ODS" D  Q:$D(ORERR)
 . S X=$$ORDITEM^ORM($P(@ORMSG@(+ODS),"|",4))
 . I 'X S ORERR="Missing or invalid diet modification" Q
 . S I=I+1,ORDIALOG(OI,I)=X
SN1 ; continue ... save order, post message
 Q:$D(ORERR)
 D EN^ORCSAVE I '$G(ORIFN) S ORERR="Cannot create new order" Q
 D RELEASE^ORCSAVE2(ORIFN,1,ORLOG,ORDUZ,ORNATR),SIGSTS^ORCSAVE2(ORIFN,1)
 D:'$P($G(^OR(100,ORIFN,0)),U,8) DATES^ORCSAVE2(ORIFN,ORSTRT,ORSTOP)
 D STATUS^ORCSAVE2(ORIFN,ORSTS)
 I $G(ORL) S ORP(1)=ORIFN_";1^1" D PRINTS^ORWD1(.ORP,+ORL) ; chart copy
 S ^OR(100,ORIFN,4)=PKGIFN
 Q
 ;
TRAY ; Early/Late tray
 I 'ORSTOP S ORERR="Missing stop date" Q
 S ORDIALOG=$O(^ORD(101.41,"AB","FHW2",0)) D GETDLG1^ORCD(ORDIALOG),EN2^ORCDFH
 S ORDIALOG($$PTR("START DATE"),1)=ORSTRT
 S ORDIALOG($$PTR("STOP DATE"),1)=ORSTOP
 N DAYS,SCH S DAYS="",SCH=$P(ORQT,U,2)
 I $L(SCH),SCH'="ONCE" F I=1:1:$L(SCH,"~") S X=+$P($P(SCH,"~",I),"J",2),DAYS=DAYS_$E("MTWRFSX",X)
 S:$L(DAYS) ORDIALOG($$PTR("SCHEDULE"),1)=DAYS
 S OI=+$O(^ORD(101.43,"S.E/L T",$P(ODT,"|",2)_" TRAY",0)),ORDIALOG($$PTR("ORDERABLE ITEM"),1)=OI
 S X=$P($P(ODT,"|",3),U,4),ORDIALOG($$PTR("MEAL"),1)=$E(X)
 S ORDIALOG($$PTR("MEAL TIME"),1)=$P($G(ORTIME(OI,$E(X),+$E(X,3))),U,2)
 S:$L($P(ODT,"|",4)) ORDIALOG($$PTR("YES/NO"),1)=1
 Q
 ;
IP ; Isolation/Precautions
 N IP S IP=+$P($P(OBR,"|",13),U,4)
 I IP'>0 S ORERR="Missing or invalid isolation type" Q
 S ORDIALOG=$O(^ORD(101.41,"AB","FHW3",0)) D GETDLG1^ORCD(ORDIALOG)
 S ORDIALOG($$PTR("ISOLATION TYPE"),1)=IP
 S ORDIALOG($$PTR("ORDERABLE ITEM"),1)=$O(^ORD(101.43,"S.PREC","ISOLATION PROCEDURES",0))
 Q
 ;
TF ; Tubefeeding
 N OI,STR,INSTR,CMMT,I,X,X4,XI,ZQT,QT,QTY,DUR
 S ORDIALOG=$O(^ORD(101.41,"AB","FHW8",0)) D GETDLG1^ORCD(ORDIALOG)
 S OI=$$PTR("ORDERABLE ITEM"),STR=$$PTR("STRENGTH FH")
 S INSTR=$$PTR("INSTRUCTIONS"),CMMT=$$PTR("FREE TEXT 1")
 ; Comments ??
 S I=0 F  D  S ODS=$O(@ORMSG@(+ODS)) Q:ODS'>0  Q:$E(@ORMSG@(ODS),1,3)="ORC"  S ODS=ODS_U_@ORMSG@(ODS)
 . Q:$E($P(ODS,U,2),1,3)'="ODS"  ; not ODS segment
 . S X=$P(ODS,"|",4),X4=$P(X,U,4) ; OI
 . S:X4["-" $P(X,U,4)=+X4,X4=+$P(X4,"-",2) ; strength
 . S XI=$$ORDITEM^ORM(X) I 'XI S ORERR="Missing or invalid tubefeeding product" Q
 . S ZQT=$O(@ORMSG@(+ODS)) I 'ZQT S ORERR="Missing QT information" Q
 . S QT=$P(@ORMSG@(ZQT),"|",3),DUR=$P(QT,U,3)
 . S QTY=+QT_" "_$$UNITS($P($P(QT,U),"&",2))_"/"_$P(QT,U,2)
 . S:$L(DUR) QTY=QTY_" X "_+$E(DUR,2,99)_$S($E(DUR)="H":"HR",1:"")
 . S I=I+1,ORDIALOG(OI,I)=XI,ORDIALOG(STR,I)=X4,ORDIALOG(INSTR,I)=QTY
 . S:$L($P(ODS,"|",5)) ORDIALOG(CMMT,I)=$P(ODS,"|",5)
 I ORCAT="O",ORQT["~" D DATES
 Q
 ;
UNITS(X) ; -- Returns name of unit X
 N Y S X=$E(X)
 S Y=$S(X="K":"KCAL",X="C":"CC",X="M":"ML",X="O":"OZ",X="U":"UNITS",X="T":"TBSP",X="G":"GM",1:"")
 Q Y
 ;
NPO ; NPO <uses FHW1 dialog - FHW4 now a quick order>
 S ORDIALOG=$O(^ORD(101.41,"AB","FHW1",0)) D GETDLG1^ORCD(ORDIALOG)
 S ORDIALOG($$PTR("ORDERABLE ITEM"),1)=$O(^ORD(101.43,"S.DIET","NPO",0))
 S ORDIALOG($$PTR("START DATE/TIME"),1)=ORSTRT S:ORSTRT>ORLOG ORSTS=8
 S:ORSTOP ORDIALOG($$PTR("STOP DATE/TIME"),1)=ORSTOP
 S:$L($P(ODS,"|",5)) ORDIALOG($$PTR("FREE TEXT 1"),1)=$P(ODS,"|",5)
 Q
 ;
ADDL ; Additional order
 S ORDIALOG=$O(^ORD(101.41,"AB","FHW7",0)) D GETDLG1^ORCD(ORDIALOG)
 S ORDIALOG($$PTR("FREE TEXT 1"),1)=$P(ODS,"|",5)
 I ORCAT="O",ORQT["~" D DATES
 Q
 ;
DATES ; -- pull dates out of ORQT
 N P,I,X S P=$$PTR("DATE/TIME")
 F I=1:1:$L(ORQT,"~") S X=$P(ORQT,"~",I),ORDIALOG(P,I)=$$HL7TFM^XLFDT($P(X,U,4))
 S ORSTRT=$G(ORDIALOG(P,1)),ORSTOP=$G(ORDIALOG(P,I))
 Q
 ;
SC ; -- Status Change
SR ; -- Status Update [ack]
 N ORSTS,OROLD S OROLD=$P($G(^OR(100,+ORIFN,3)),U,3)
 D DATES^ORCSAVE2(+ORIFN,ORSTRT,ORSTOP)
 S ORSTS=$S(ORDSTS="DC":1,ORDSTS="IP":6,ORDSTS="ZE":7,ORDSTS="SC":8,1:"")
 D:ORSTS STATUS^ORCSAVE2(+ORIFN,ORSTS)
 I ORDSTS="DC",'$D(^OR(100,+ORIFN,6)) D  ;set 6-node
 . I ORNATR'="A","DN"[$E(PKGIFN) S ORNATR="C" S:'$L(OREASON) OREASON="Replaced with new diet order" S:ORDUZ<1 ORDUZ=""
 . S ^OR(100,+ORIFN,6)=$S($L(ORNATR):+$O(^ORD(100.02,"C",ORNATR,0)),1:"")_U_ORDUZ_U_ORLOG_U_U_OREASON
 I OROLD=1,ORSTS=6 D  ; reactivate
 . N X S $P(^OR(100,+ORIFN,3),U,7)=1,X=$P(^(0),U,9) K ^(6)
 . I 'ORSTOP,X S $P(^OR(100,+ORIFN,0),U,9)="" K ^OR(100,"AE",X,+ORIFN)
 . D SETALL^ORDD100(+ORIFN)
 Q
 ;
OC ; -- Cancelled <E/L Trays only> / [ack]
 G:ORTYPE="ORR" UA ;rejected new order
 I $P($G(^OR(100,+ORIFN,3)),U,3)=6,$P(^(0),U,8)<ORLOG G OD
 S ^OR(100,+ORIFN,6)=$S($L(ORNATR):+$O(^ORD(100.02,"C",ORNATR,0)),1:"")_U_ORDUZ_U_ORLOG_U_U_OREASON
 D UPDATE(13,"DC")
 Q
 ;
CR ; -- Cancelled as requested [ack]
 D STATUS^ORCSAVE2(+ORIFN,13)
 Q
 ;
OD ; -- Discontinued <Tubefeedings only>
 S ^OR(100,+ORIFN,6)=$S($L(ORNATR):+$O(^ORD(100.02,"C",ORNATR,0)),1:"")_U_ORDUZ_U_ORLOG_U_U_OREASON
 D UPDATE(1,"DC")
 Q
 ;
DR ; -- Discontinued as requested [ack]
 D STATUS^ORCSAVE2(+ORIFN,1)
 Q
 ;
UA ; -- Unable to Accept [ack]
 S:'$L(ORNATR) ORNATR="X" ;Rejected
 S ^OR(100,+ORIFN,6)=+$O(^ORD(100.02,"C",ORNATR,0))_U_U_ORLOG_U_U_OREASON
 D STATUS^ORCSAVE2(+ORIFN,13)
UC ; -- Unable to Cancel [ack]
UD ; -- Unable to Discontinue [ack]
 N DA S DA=$P(ORIFN,";",2) I DA D
 . S:$G(OREJECT) $P(^OR(100,+ORIFN,8,DA,0),U,15)=13 ; request rejected
 . S:$L(OREASON) ^OR(100,+ORIFN,8,DA,1)=OREASON
 Q
 ;
UPDATE(ORSTS,ORACT) ; -- continue processing
 N ORX,DA,ORP D DATES^ORCSAVE2(+ORIFN,ORSTRT,ORSTOP)
 D:$G(ORSTS) STATUS^ORCSAVE2(+ORIFN,ORSTS)
 S ORX=$$CREATE^ORX1(ORNATR) D:ORX
 . S DA=$$ACTION^ORCSAVE(ORACT,+ORIFN,ORNP,OREASON,ORLOG,ORDUZ)
 . I DA'>0 S ORERR="Cannot create new order action" Q
 . D RELEASE^ORCSAVE2(+ORIFN,DA,ORLOG,ORDUZ,ORNATR)
 . D SIGSTS^ORCSAVE2(+ORIFN,DA)
 . I $G(ORL) S ORP(1)=+ORIFN_";"_DA_"^1" D PRINTS^ORWD1(.ORP,+ORL)
 . S $P(^OR(100,+ORIFN,3),U,7)=DA
 I ORACT="DC",'$$ACTV^ORX1(ORNATR) S $P(^OR(100,+ORIFN,3),U,7)=0
 D:ORACT="DC" CANCEL^ORCSEND(+ORIFN)
 Q
 ;
PTR(NAME) ; -- Returns ien of prompt NAME in Order Dialog file #101.41
 Q $O(^ORD(101.41,"AB",$E("OR GTX "_NAME,1,63),0))
