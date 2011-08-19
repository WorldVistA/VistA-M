ORMRA ; SLC/MKB/RV - Process Radiology ORM msgs ;2/21/02  15:44 [05/30/06 12:30pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**3,53,92,110,136,153,174,195,228,243,296**;Dec 17, 1997;Build 19
 ;DBIA 2968 allows for reading ^DIC(34
EN ; -- entry point for RA messages
 I '$L($T(@ORDCNTRL)) Q  ;S ORERR="Invalid order control code" Q
 I ORDCNTRL'="SN",ORDCNTRL'="ZP",'ORIFN!('$D(^OR(100,+ORIFN,0))) S ORERR="Invalid OE/RR order number" Q
 S OREASON=$S($P(OREASON,U,6)="99RAR":$P(OREASON,U,5),1:$P(OREASON,U,2))
 S:'ORDUZ ORDUZ=DUZ S:'ORLOG ORLOG=+$E($$NOW^XLFDT,1,12)
 D @ORDCNTRL
 Q
 ;
ZP ; -- Purged
 Q:'ORIFN  Q:'$D(^OR(100,+ORIFN,0))  K ^OR(100,+ORIFN,4)
 ; - Set status=lapsed, if still active
 I "^3^5^6^8^"[(U_$P($G(^OR(100,+ORIFN,3)),U,3)_U) D STATUS^ORCSAVE2(ORIFN,14)
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
OK ; -- Order accepted, RA order # assigned [ack]
 N ORSTS,OBR S ^OR(100,+ORIFN,4)=PKGIFN,ORSTS=5 ; 5=pending
 ; Ck if also scheduled, else quit
 S OBR=$O(@ORMSG@(+ORC)) G:'OBR OKQ G:$E(@ORMSG@(OBR),1,3)'="OBR" OKQ
 S ORSTRT=$$FMDATE^ORM($P(@ORMSG@(OBR),"|",37))
 D:ORSTRT DATES^ORCSAVE2(+ORIFN,ORSTRT)
OKQ D STATUS^ORCSAVE2(ORIFN,ORSTS)
 ;Save the Radiology pre-certification Account Reference in the PV1
 ;segment of the HL7 message from the Radiology package to the Order
 ;File (#100). Support for Patch OR*3.0*228
 I +$$SWSTAT^IBBAPI() D PRECERT^ORWPFSS2  ;IA #4663
 Q
 ;
XX ; -- Change order
 N ORDIALOG,ORDG,ORDA,ORX,ORP S:'$L(ORNATR) ORNATR="S"
 D DLG Q:$D(ORERR)  Q:'$D(ORDIALOG)  S ORIFN=+ORIFN
 S ORDA=$$ACTION^ORCSAVE("XX",ORIFN,ORNP,OREASON,ORLOG,ORDUZ)
 I ORDA'>0 S ORERR="Cannot create new order action" Q
 ; -Update sts of order to active, last action to dc/edit:
 S ORX=+$P($G(^OR(100,ORIFN,3)),U,7)
 S:$P($G(^OR(100,ORIFN,8,ORX,0)),U,15)="" $P(^(0),U,15)=12
 S $P(^OR(100,ORIFN,3),U,7)=ORDA D STATUS^ORCSAVE2(ORIFN,6)
 D RELEASE^ORCSAVE2(ORIFN,ORDA,ORLOG,ORDUZ,ORNATR)
 ; -If unsigned edit, leave XX unsigned & mark ORX as Sig Not Req'd
 S ORSIG=$S($P($G(^OR(100,ORIFN,8,ORX,0)),U,4)'=2:1,1:0)
 D SIGSTS^ORCSAVE2(ORIFN,ORDA):ORSIG,SIGN^ORCSAVE2(ORIFN,,,5,ORX):'ORSIG
 ; -Update responses, get/save new order text:
 K ^OR(100,ORIFN,4.5) D RESPONSE^ORCSAVE,ORDTEXT^ORCSAVE1(ORIFN_";"_ORDA)
 S $P(^OR(100,ORIFN,8,ORDA,0),U,14)=ORDA
 I $G(ORL) S ORP(1)=+ORIFN_";"_ORDA_"^1" D PRINTS^ORWD1(.ORP,+ORL)
 Q
 ;
SN ; -- New backdoor order: return NA msg w/ORIFN, or DE msg
 N ORDIALOG,ORDG,ORP K ^TMP("ORWORD",$J) S:'$L(ORNATR) ORNATR="W"
 I ORDUZ,'$D(^VA(200,ORDUZ,0)) S ORERR="Invalid entering person" Q
 I '$D(^VA(200,ORNP,0)) S ORERR="Missing or invalid ordering provider" Q
 I '$G(ORL) S ORERR="Missing or invalid patient location" Q
 D DLG Q:$D(ORERR)  Q:'$D(ORDIALOG)
SNQ D EN^ORCSAVE K ^TMP("ORWORD",$J)
 I '$G(ORIFN) S ORERR="Cannot create new order" Q
 ;Save DG1 and ZCL segments of HL7 message from backdoor orders
 D BDOSTR^ORWDBA3
 ;Save the Radiology pre-certification Account Reference in the PV1
 ;segment of the HL7 message from the Radiology package to the Order
 ;File (#100). Support for Patch OR*3.0*228
 I +$$SWSTAT^IBBAPI() D PRECERT^ORWPFSS2  ;IA #4663
 D RELEASE^ORCSAVE2(ORIFN,1,ORLOG,ORDUZ,ORNATR),SIGSTS^ORCSAVE2(ORIFN,1)
 D STATUS^ORCSAVE2(ORIFN,5) S ^OR(100,ORIFN,4)=PKGIFN
 I $G(ORL) S ORP(1)=ORIFN_";1^1" D PRINTS^ORWD1(.ORP,+ORL) ; chart copy
 Q
 ;
DLG ; -- Build ORDIALOG() from msg
 N OBR,OI,MODS,J,X,Y,ILOC,MODE,CH,CHI,OBX,NTE,REASON
 S ORDIALOG=$O(^ORD(101.41,"AB","RA OERR EXAM",0))
 D GETDLG1^ORCD(ORDIALOG)
 S ORDIALOG($$PTR("CATEGORY"),1)=$G(ORCAT)
 S ORDIALOG($$PTR("START DATE/TIME"),1)=ORSTRT
 S ORDIALOG($$PTR("URGENCY"),1)=ORURG
 S:$P(ORC,"|",12) ORDIALOG($$PTR("PROVIDER"),1)=+$P(ORC,"|",12)
D1 S OBR=$O(@ORMSG@(+ORC)) I 'OBR!($E($G(@ORMSG@(OBR)),1,3)'="OBR") S ORERR="Missing OBR segment" Q
 S OI=$$ORDITEM^ORM($P(@ORMSG@(OBR),"|",5))
 I 'OI S ORERR="Invalid procedure" Q
 S ORDIALOG($$PTR("ORDERABLE ITEM"),1)=OI
 S ORDG=$P($G(^ORD(101.43,+OI,"RA")),U,3) S:$L(ORDG) ORDG=+$O(^ORD(100.98,"B",ORDG,0)) I 'ORDG S ORDG=$P(^ORD(101.41,+ORDIALOG,0),U,5) ; Im Type
 S MODS=$P(@ORMSG@(OBR),"|",19) I $L(MODS) D
 . F J=1:1:$L(MODS,"~") S X=$P(MODS,"~",J) I $L(X) S Y=$O(^RAMIS(71.2,"B",X,0)) S:Y ORDIALOG($$PTR("MODIFIERS"),J)=Y
 S ILOC=+$P(@ORMSG@(OBR),"|",20),MODE=$P(@ORMSG@(OBR),"|",31),REASON=$P($P(@ORMSG@(OBR),"|",32),U,2)
 S:ILOC ORDIALOG($$PTR("IMAGING LOCATION"),1)=ILOC
 S ORDIALOG($$PTR("MODE OF TRANSPORT"),1)=$S(MODE="WALK":"A",MODE="CART":"S",1:$E(MODE))
 S:$L(REASON) ORDIALOG($$PTR("STUDY REASON"),1)=REASON
 I ORDCNTRL="XX" S NTE=+$O(@ORMSG@(OBR)) I NTE,$E($G(@ORMSG@(NTE)),1,3)="NTE" S OREASON=$P(@ORMSG@(NTE),"|",4) ;Tech's Comments
D2 ; might the procedure be scheduled at this point ??  Not in spec
 S CH=$$PTR("WORD PROCESSING 1"),CHI=0
 S OBX=OBR F  S OBX=$O(@ORMSG@(OBX)) Q:OBX'>0  S J=$E(@ORMSG@(OBX),1,3) Q:J="ORC"  Q:J="MSH"  I J="OBX" D
 . N NAME,VALUE,X0 S VALUE=$P(@ORMSG@(OBX),"|",6)
 . S NAME=$$UP^XLFSTR($P($P(@ORMSG@(OBX),"|",4),U,2))
 . I NAME="CONTRACT/SHARING SOURCE" S X0=$G(^DIC(34,+VALUE,0)) S:$L(X0) ORDIALOG($$PTR(NAME),1)=+VALUE,ORDIALOG($$PTR("CATEGORY"),1)=$P(X0,U,2) Q
 . I NAME="RESEARCH SOURCE" S ORDIALOG($$PTR(NAME),1)=VALUE,ORDIALOG($$PTR("CATEGORY"),1)="R" Q
 . I NAME="PREGNANT" S ORDIALOG($$PTR(NAME),1)=VALUE Q
 . I NAME="PRE-OP SCHEDULED DATE/TIME" S ORDIALOG($$PTR(NAME),1)=$$FMDATE^ORM(VALUE) Q
 . S CHI=CHI+1,^TMP("ORWORD",$J,CH,1,CHI,0)=VALUE
 S:CHI ^TMP("ORWORD",$J,CH,1,0)="^^"_CHI_U_CHI_U_DT_U,ORDIALOG(CH,1)="^TMP(""ORWORD"",$J,"_CH_",1)"
 Q
 ;
PTR(X) ; -- Returns ptr to prompt in Order Dialog file #101.41
 Q +$O(^ORD(101.41,"AB",$E("OR GTX "_X,1,63),0))
 ;
SC ; -- Status changed (scheduled, registered, or unverified)
 N ORSTS,OBR,OR3 ;110
 S ORSTS=$S(ORDSTS="ZR":6,ORDSTS="ZU":6,1:8),OR3=$G(^OR(100,+ORIFN,3)) ;110
 G:ORSTS=6 SCQ ;136  Done if active, else get scheduled data
 S OBR=$O(@ORMSG@(+ORC)) I 'OBR!($E($G(@ORMSG@(OBR)),1,3)'="OBR") S ORERR="Missing OBR segment" Q
 S ORSTRT=$$FMDATE^ORM($P(@ORMSG@(OBR),"|",37))
 D:ORSTRT DATES^ORCSAVE2(+ORIFN,ORSTRT)
 I $P(OR3,U,3)=3,$P($G(^OR(100,+ORIFN,8,+$P(OR3,U,7),0)),U,2)="HD" D RL ;If status is hold and current action is hold then release.  Added with 110
SCQ D STATUS^ORCSAVE2(ORIFN,ORSTS)
 Q
 ;
RE ; -- Completed, w/results
 N I,SEG,OBX
 D STATUS^ORCSAVE2(ORIFN,2)
 S OBX="" D  ;get Results D/T [from OBR]
 . N DA,DR,DIE,X,Y,OBR
 . S DA=+ORIFN,DIE="^OR(100,",OBR=+$O(@ORMSG@(+ORC)),X=""
 . I OBR,$E($G(@ORMSG@(OBR)),1,3)="OBR" S X=$P(@ORMSG@(OBR),"|",23)
 . S DR="71////"_$S(X:$$FMDATE^ORM(X),1:+$E($$NOW^XLFDT,1,12)) D ^DIE
 S I=+ORC F  S I=$O(@ORMSG@(I)) Q:I<1  S SEG=$G(@ORMSG@(I)) Q:$E(SEG,1,3)="ORC"  I $E(SEG,1,3)="OBX" S OBX=I_U_SEG Q  ;first one
 S $P(^OR(100,+ORIFN,7),U,2)=$S($P(OBX,"|",9)="A":1,1:"")
 S:'$G(ORNP) ORNP=+$P($G(^OR(100,+ORIFN,0)),U,4)
 I $L($T(ADD^ORRCACK)) D ADD^ORRCACK(+ORIFN,ORNP) ;Ack stub for prov
 Q
 ;
OH ; -- Held
 D UPDATE(3,"HD")
 Q
 ;
OC ; -- Cancelled/Unable to accept [ack]
UA ; -- Unable to accept [ack]
 S:'$L(ORNATR) ORNATR="X" ;Rejected
 S ^OR(100,+ORIFN,6)=$O(^ORD(100.02,"C",ORNATR,0))_U_U_ORLOG_U_U_OREASON
 D STATUS^ORCSAVE2(ORIFN,13)
UD ; -- Unable to discontinue [ack]
 N DA S DA=+$P(ORIFN,";",2) I DA D
 . S $P(^OR(100,+ORIFN,8,DA,0),U,15)=13 ;Request rejected
 . S:$L(OREASON) ^OR(100,+ORIFN,8,DA,1)=OREASON
 Q
 ;
OD ; -- Discontinued
 S:$G(DGPMT) ORDUZ="" ;auto-dc on movement
 S ^OR(100,+ORIFN,6)=$S($L(ORNATR):$O(^ORD(100.02,"C",ORNATR,0)),1:"")_U_ORDUZ_U_ORLOG_U_U_OREASON
 D UPDATE(1,"DC")
 Q
 ;
DR ; -- Discontinued [ack]
 D STATUS^ORCSAVE2(ORIFN,1)
 Q
 ;
UPDATE(ORSTS,ORACT) ; -- continue processing
 N ORX,ORDA,ORP D:$G(ORSTS) STATUS^ORCSAVE2(ORIFN,ORSTS)
 S ORX=$$CREATE^ORX1(ORNATR) D:ORX
 . S ORDA=$$ACTION^ORCSAVE(ORACT,+ORIFN,ORNP,OREASON,ORLOG,ORDUZ)
 . I ORDA'>0 S ORERR="Cannot create new order action" Q
 . D RELEASE^ORCSAVE2(+ORIFN,ORDA,ORLOG,ORDUZ,ORNATR)
 . D SIGSTS^ORCSAVE2(+ORIFN,ORDA)
 . I $G(ORL) S ORP(1)=+ORIFN_";"_ORDA_"^1" D PRINTS^ORWD1(.ORP,+ORL)
 . S $P(^OR(100,+ORIFN,3),U,7)=ORDA
 I 'ORX D  ;no new action created
 . ;I ORACT="DC" S:'$$ACTV^ORX1(ORNATR) $P(^OR(100,+ORIFN,3),U,7)=0 Q
 . S:ORACT="HD"&$L(OREASON) ^OR(100,+ORIFN,8,1,1)=OREASON ;pend/sch only
 I ORACT="DC" D CANCEL^ORCSEND(+ORIFN) S:'$$ACTV^ORX1(ORNATR) $P(^OR(100,+ORIFN,3),U,7)=0
 Q
 ;
RL ;Release hold --entire section added with patch 110
 S ^OR(100,+ORIFN,8,$P(OR3,U,7),2)=ORLOG_"^"_ORDUZ  ;Set release hold date/time and release hold user
 S ORNATR=$S($L(ORNATR):ORNATR,1:$P(^OR(100,+ORIFN,8,$P(OR3,U,7),0),U,12)) ;set nature of order for release equal to nature of order for hold if it doesn't exist
 I $G(ORSTS)="" S ORSTS=6
 D UPDATE(ORSTS,"RL")
 Q
