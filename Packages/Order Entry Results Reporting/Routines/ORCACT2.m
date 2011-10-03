ORCACT2 ;SLC/MKB-DC orders ; 03/27/2007
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,48,79,92,108,94,141,149,265,243**;Dec 17, 1997;Build 242
 ;;Per VHA Directive 2004-038, this routine should not be modified.
DC ; -- start here with:
 ;    ORNMBR = #,#,...,# of selected orders
 ;
 ;    OREBUILD defined on return if Orders tab needs to be rebuilt
 ;
 N ORACT,ORI,NMBR,ORQUIT,ORIFN,ORDC,OREVT,ORNATR,ORPTLK,ORLK,IDX,ORDITM,ORPRINT,ORERR,ORSTS,ORPRNT,ORCLNUP,ORDA,ORCREATE,OR0,OR3,OREASON,ORXNP,ORX S VALMBCK=""
 S ORPTLK=$$LOCK^ORX2(+ORVP) I 'ORPTLK W !!,$C(7),$P(ORPTLK,U,2) H 2 Q
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("") G:'ORNMBR DCQ
 D FREEZE^ORCMENU S ORACT="DC",VALMBCK="R" K OREBUILD
DC1 F ORI=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",ORI) D:NMBR  Q:$D(ORQUIT)
 . S IDX=$G(^TMP("OR",$J,ORTAB,"IDX",NMBR))
 . S ORIFN=$S(ORTAB="MEDS":$P(IDX,U,4),1:$P(IDX,U)) Q:'ORIFN
 . I '$D(^OR(100,+ORIFN,0)) W !,"This order has been deleted!" H 1 Q
 . S:'$P(ORIFN,";",2) ORIFN=+ORIFN_";"_+$P($G(^OR(100,+ORIFN,3)),U,7)
 . S ORDITM=$$ORDITEM(ORIFN) D SUBHDR(ORDITM)
 . I '$$VALID^ORCACT0(ORIFN,ORACT,.ORERR) W !,ORERR H 1 Q
 . S ORLK=$$LOCK1^ORX2(+ORIFN) I 'ORLK W !,$P(ORLK,U,2) H 1 Q
 . S OR0=$G(^OR(100,+ORIFN,0)),OR3=$G(^(3)),ORSTS=$P($G(^(8,+$P(ORIFN,";",2),0)),U,15)
 . S:$P(OR0,U,17) OREVT(+$P(OR0,U,17))="" ;ck event when done
 . I (ORSTS=10)!(ORSTS=11) D UNREL Q  ;delete unreleased orders
 . I $P(OR0,U,11)=$O(^ORD(100.98,"B","TF",0)),$P(OR3,U,3)=6 D RESUME(ORIFN) Q:$G(ORQUIT)
DC2 . S ORDC(ORI)=ORIFN I $$NMSP^ORCD(+$P(OR0,U,14))="PS" S ORX=1 D  ;meds
 .. I $P(OR3,U,9),$$VALUE^ORX8(+ORIFN,"SCHEDULE")'="NOW",$$DOSES^ORCACT4($P(OR3,U,9))>1 D
 ... N I,X S ORDC("DAD",+$P(OR3,U,9),+ORIFN)=""
 ... W !,$C(7),"This is part of a complex order, which will be discontinued in its entirety:"
 ... S I=0 F  S I=$O(^OR(100,+$P(OR3,U,9),8,1,.1,I)) Q:I<1  S X=$G(^(I,0)) W:$$UP^XLFSTR(X)'=" FIRST DOSE NOW" !,X
 .. N ORY,ORJ,ORV,ORTX,DA,DIK D DELAYED^ORX8(.ORY,+ORIFN) Q:ORY'>0
 .. W !,+ORY_" delayed order(s) for the same medication were found:"
 .. S ORJ=0 F  S ORJ=$O(ORY(ORJ)) Q:ORJ'>0  S ORV=ORY(ORJ) D TEXT^ORQ12(.ORTX,ORJ) W !,$E(ORTX(1),1,75)_$S($L(ORTX(1))>75:"...",1:""),!,"  >> delayed until "_$P(ORV,U,2)
 .. I '$$OK(+ORY) W ! Q
 .. W !,"Orders not signed or released to the service will be deleted.",!
 .. S DIK="^OR(100,",DA=0 F  S DA=$O(ORY(DA)) Q:DA'>0  D
 ... N ORJ,ORSIG,STS,ORLKD
 ... S ORLKD=$$LOCK1^ORX2(+DA) I 'ORLKD W !,$P(ORLKD,U,2) H 1 Q
 ... S STS=$P($G(^OR(100,DA,3)),U,3),ORSIG=$S($P($G(^(8,1,0)),U,4)=2:0,1:1)
 ... I STS'=10 S ORDC($$NXT)=DA Q  ;released - add to list
 ... D CLRDLY(DA):ORSIG,^DIK:'ORSIG S OREVT(+ORY(DA))=""
 ... I $D(^TMP("ORNEW",$J,DA,1)) K ^(1) D UNLK1^ORX2(DA) ;unlock again
 G:'$O(ORDC(0)) DCQ D:$D(ORDC("DAD")) COMPLX
DC3 S OREASON=$$DCREASON I OREASON'>0 D UNLOCK G DCQ
 S ORNATR=$P(OREASON,U,3),ORCREATE=1 ; CHGD $$CREATE^ORX1(ORNATR)
 I 'ORCREATE,$G(ORX),$D(^XUSEC("OREMAS",DUZ)),$$GET^XPAR("ALL","OR OREMAS MED ORDERS")<2 W $C(7),!,"You are not authorized to release med orders.",! G DC3
 I ORCREATE D  I (ORNP="^")!($G(ORL)="^") D UNLOCK G DCQ
 . S ORNP=$$PROVIDER^ORCMENU1 Q:ORNP="^"  ;S:ORNP=DUZ ORNATR="E"
 . I $G(ORX) D PROVIDER^ORCDPSIV I $G(ORQUIT) S ORNP="^" Q
 . S:'$G(ORL) ORL=$$LOCATION^ORCMENU1
 W ! W:'ORCREATE "Discontinuing orders ..."
 S ORPRNT=$$PRINT(ORNATR),ORCLNUP=$S(ORNATR="D":1,ORNATR="M":1,1:0)
 S (ORI,ORPRINT)=0 F  S ORI=$O(ORDC(ORI)) Q:ORI'>0  S ORIFN=ORDC(ORI) D
 . I ORCREATE S ORDA=$$ACTION^ORCSAVE("DC",+ORIFN,ORNP) Q:'ORDA  D SET(+ORIFN,ORNATR,+OREASON,$P(OREASON,U,2)) S ^TMP("ORNEW",$J,+ORIFN,ORDA)="" W "." Q
 . ; release -> no order or ES req'd
 . D EN^ORCSEND(+ORIFN,ORACT,3,1,ORNATR,+OREASON,.ORERR),UNLK1^ORX2(+ORIFN)
 . I '$G(ORERR) S:$P(ORPRNT,U)!$P(ORPRNT,U,5) ORPRINT=ORPRINT+1,ORPRINT(ORPRINT)=+ORIFN_";" W "." Q
 . W !,$$ORDITEM(+ORIFN)_" not discontinued."
 . W:$L($P($G(ORERR),U,2)) !,"  >> "_$P(ORERR,U,2) W ! H 1
 W:ORCREATE "... discontinue order(s) placed." H 1
 I $O(ORPRINT(0)) D PRINT^ORPR02(ORVP,.ORPRINT,,ORL,ORPRNT)
 S OREBUILD=1 ; rebuild orders list
DCQ D:$G(OREBUILD) UNOTIF^ORCSIGN ; undo notif?
 D:'$D(^TMP("ORNEW",$J)) UNLOCK^ORX2(+ORVP) ;unlock if no new orders
 S:$G(ORXNP) ORNP=ORXNP ;reset provider if needed
 D:$D(OREVT) EVENT ;cancel any events?
 Q
 ;
UNLOCK ; -- Unlock orders in ORDC(ORI)=ORIFN
 N ORI,ORIFN S ORI=0
 F  S ORI=$O(ORDC(ORI)) Q:ORI'>0  S ORIFN=+ORDC(ORI) D UNLK1^ORX2(ORIFN)
 Q
 ;
OK(NUM) ; -- Ok to DC delayed order(s) too?
 N X,Y,DIR S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Do you want to discontinue "_$S(NUM>1:"these orders",1:"this order")_" too? "
 S DIR("?")="Enter YES to also cancel the delayed order(s), or NO to allow the order(s) to be activated when the designated event occurs."
 W ! D ^DIR
 Q +Y
 ;
NXT() ; -- Return next available subscript in ORDC()
 N Y S Y=$L(ORNMBR,",")+1 S:Y'>$O(ORDC(""),-1) Y=$O(ORDC(""),-1)+1
 Q Y
 ;
PRINT(NATR) ; -- Ok to print order?
 N I,OR1,Y S I=$O(^ORD(100.02,"C",NATR,0)),OR1=$G(^ORD(100.02,I,1))
 S Y=$P(OR1,U,2)_"^^^^"_$P(OR1,U,5)
 Q Y
 ;
ORDITEM(ID) ; -- Returns order text
 ;N X,I,MORE S X=""
 ;I $P(ID,";",2)>1 S I=$P($G(^OR(100,+ID,8,+$P(ID,";",2),0)),U,2),X=$S(I="DC":"Discontinue ",I="HD":"Hold ",1:"")
 ;S I=$O(^OR(100,+ID,1,0)) Q:'I "" S MORE=$O(^(I)),X=X_$G(^(I,0))
 ;I $L(X)>68 S X=$E(X,1,68),MORE=1
 ;S:MORE X=X_" ..."
 N X,ORX D TEXT^ORQ12(.ORX,ID,68) S X=ORX(1)_$S(ORX>1:" ...",1:"")
 Q X
 ;
SUBHDR(X) ; -- Display subheader of order being acted on
 W !!,?(36-($L(X)\2)),"-- "_X_" --",!
 Q
 ;
COMPLX ; -- Ck for other child orders to be dc'd at same time
 N DAD,CHLD
 S DAD=0 F  S DAD=$O(ORDC("DAD",DAD)) Q:DAD<1  D
 . S CHLD=0 F  S CHLD=$O(^OR(100,DAD,2,CHLD)) Q:CHLD<1  D
 .. Q:"^1^2^7^12^13^14^15^"[(U_$P($G(^OR(100,CHLD,3)),U,3)_U)
 .. Q:$D(ORDC("DAD",DAD,CHLD))  S ORDC($$NXT)=CHLD
 Q
 ;
DCREASON() ; -- Returns Reason for DC
 N X,Y,DIC
 ;I $D(^XUSEC("ORES",DUZ)) S Y=+$O(^ORD(100.03,"C","ORREQ",0)) I Y S Y(0)=$G(^ORD(100.03,Y,0)),Y=Y_U_$P(Y(0),U) G DCRQ ; silent
 S DIC="^ORD(100.03,",DIC(0)="AEMQZ",DIC("B")=+$O(^ORD(100.03,"C","ORREQ",0)),DIC("W")="W:$L($P(^(0),U))>30 $E($P(^(0),U),31,999)" K:DIC("B")'>0 DIC("B")
 S DIC("S")="I '$P(^(0),U,4),$P(^(0),U,5)="_+$O(^DIC(9.4,"C","OR",0))_",$P(^(0),U,7)'="_+$O(^ORD(100.02,"C","A",0)),DIC("A")="REASON FOR DC: "
 D ^DIC
DCRQ S:Y>0 Y=Y_U_$S($P(Y(0),U,7):$P($G(^ORD(100.02,+$P(Y(0),U,7),0)),U,2),1:"W") ; ^nature
 Q Y
 ;
SET(ORDER,NATURE,REASON,TEXT,DCORIG) ; -- Set DC Reason into 6-node
 Q:'$G(ORDER)  Q:'$D(^OR(100,+ORDER,0))  S ORDER=+ORDER
 I $L($G(NATURE)),NATURE'>0 S NATURE=$O(^ORD(100.02,"C",NATURE,0))
 S $P(^OR(100,ORDER,6),U,1,5)=$G(NATURE)_U_DUZ_U_$E($$NOW^XLFDT,1,12)_U_$G(REASON)_U_$G(TEXT),$P(^(6),U,9)=$G(DCORIG)
 Q
 ;
RESUME(ORDER) ; -- Resume tray service when dc'ing tubefeeding ORDER?
 N X,Y,DIR,DIC,DA S X=$$RESUME^FHWORR(+ORVP)
 I '$L(X) W !,"NOTE: NO current diet order exists for this patient!" Q
 Q:'X  I X=2 W !,"Note: Patient is on a WITHHOLD SERVICE order!"
 S DIR(0)="YA",DIR("A")="Do you wish to resume tray service? "
 S DIR("?")="Enter YES to resume the previous diet order",DIR("B")="NO"
 D ^DIR I Y'=1 S:$D(DTOUT)!(X["^") ORQUIT=1
 D:Y=1 RESUME^ORCSAVE(+ORDER)
 Q
 ;
UNREL ; -- Process unreleased/delayed order
 N ORA,ORA0,DA,DR,DIE
 S ORA=+$P(ORIFN,";",2),ORA0=$G(^OR(100,+ORIFN,8,ORA,0))
 ;S ORDEL=$S(ORSTS=11:1,$P(ORA0,U,4)=2:1,1:0)
 ;W !,"This order was not released "_$S(ORDEL:"to the service and will be deleted.",1:"but signed and will be cancelled.")
 K:$P(ORA0,U,2)="DC" ^OR(100,+ORIFN,6) I $P(ORA0,U,2)="NW" D
 . S:$P(OR3,U,5) $P(^OR(100,+$P(OR3,U,5),3),U,6)=""
 . I $P(OR0,U,17) S DA=+$O(^ORE(100.2,"AO",+ORIFN,0)) I DA S DR="4///@",DIE=100.2 D ^DIE
 D UNLK1^ORX2(+ORIFN) S OREBUILD=1
 I $D(^TMP("ORNEW",$J,+ORIFN,ORA)) K ^(ORA) D  Q  ;new this session
 . W !,"This order will be deleted." H 1
 . D DELETE^ORCSAVE2(ORIFN),UNLK1^ORX2(+ORIFN) ;decrement lock again
 W !,"This order was not released and will be cancelled." H 1
 D CANCEL^ORCSAVE2(ORIFN):ORSTS=11,CLRDLY(+ORIFN):ORSTS=10
 Q
 ;
CLRDLY(IFN) ; -- [old Clear delayed fields] Cancel delayed [event]order
 N STS,ORX S IFN=+$G(IFN) Q:IFN'>0
 Q:'$D(^OR(100,IFN,0))  S STS=$P($G(^(3)),U,3)
 S ORX="Delayed "_$S(STS=10:"Order",1:"Release Event")_" Cancelled"
 S ^OR(100,IFN,6)=$O(^ORD(100.02,"C","M",0))_U_DUZ_U_+$E($$NOW^XLFDT,1,12)_U_U_ORX
 D STATUS^ORCSAVE2(IFN,13) S $P(^OR(100,IFN,8,1,0),U,15)=13
 Q
 ;
EVENT ; -- Cancel event too?
 N EVT,X
 S EVT=0 F  S EVT=$O(OREVT(EVT)) Q:EVT<1  D  Q:$G(ORQUIT)
 . Q:$G(^ORE(100.2,EVT,1))  Q:'$$EMPTY^OREVNTX(EVT)  ;done or has orders
 . ;W !!,$P($$NAME^OREVNTX(EVT)," ",2,99)_" has no more delayed orders."
 . ;S DIR(0)="YA",DIR("A")="Do you want to cancel this event? "
 . ;S DIR("?")="Enter NO if you wish to enter new delayed orders for this event, otherwise enter YES to terminate it."
 . ;S DIR("B")="YES" D ^DIR I $D(DTOUT)!$D(DUOUT) S ORQUIT=1 Q
 . D CANCEL^OREVNTX(EVT) S X=$P($$NAME^OREVNTX(EVT)," ",2,99)
 . W !,"   ... "_X_" event cancelled." H 1
 . I $G(OREVENT),OREVENT=EVT D EX^OREVNT ;Return to Active Orders
 Q
 ;
DCD(IFN) ; -- order discontinued already?
 N STS,Y,I S Y=0 I '$G(IFN) Q 1
 S STS=+$P($G(^OR(100,+IFN,3)),U,3)
 I "^1^2^7^12^13^14^"[(U_STS_U) S Y=1 G DQ ;terminal sts
 ;look for existing DC action awaiting ES:
 S I=0 F  S I=+$O(^OR(100,+IFN,8,"C","DC",I)) Q:I<1  I $P($G(^OR(100,+IFN,8,I,0)),U,15)=11 S Y=1 Q
DQ Q Y
