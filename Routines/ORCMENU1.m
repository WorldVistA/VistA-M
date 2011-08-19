ORCMENU1 ;SLC/MKB-Add Orders cont ;2/7/97  15:41
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,36,55,48,92**;Dec 17, 1997
ORDCHK ; -- Order Checking [called from ORCSIGN]
 ;    Returns ORQUIT=1 if ^ or timeout
 N ORCHECK,ORIFN,ORY,ORTX,ORIGVIEW
 D SESSION^ORCHECK Q:'$G(ORCHECK)
 W !,"Unsigned orders with order checks:"
 S (ORIFN,ORY)=0 F  S ORIFN=$O(ORCHECK(ORIFN)) Q:ORIFN'>0  D
 . S ORY=ORY+1,ORY(ORY)=ORIFN,ORIGVIEW=2 D TEXT^ORQ12(.ORTX,ORIFN,70)
 . W !!,$J(ORY,3)_". "_$G(ORTX(1))_$S($O(ORTX(1)):" ...",1:"")
 . D LIST^ORCHECK(ORIFN)
OC1 I $$CANCEL^ORCHECK D  ; cancel order(s)
 . N X,Y,Z,DIR,NMBR,DIK,DA,ORI S:ORY=1 Y=1
 . I ORY'=1 S DIR(0)="LA^1:"_ORY,DIR("A")="Select orders: ",DIR("?")="Enter the orders you wish to cancel, as a range or list of numbers" D ^DIR Q:$D(DTOUT)!($D(DUOUT))
 . S NMBR=Y,DIK="^OR(100,"
 . F ORI=1:1:$L(NMBR,",") S X=$P(NMBR,",",ORI) I X D
 . . S DA=+$G(ORY(X)) Q:'DA  D ^DIK,UNLK1^ORX2(DA)
 . . K ORES(DA_";1"),^TMP("ORNEW",$J,DA,1),ORCHECK(DA),ORY(X) S ORY=ORY-1
 . W !?10,"... orders cancelled.",!
OC2 Q:ORY'>0  ; all orders cancelled
 S ORIFN=0 F  S ORIFN=$O(ORCHECK(ORIFN)) Q:ORIFN'>0  I $D(ORCHECK(ORIFN,1)) W !!,"Critical order checks remain that require a justification." S ORCHECK("OK")=$$REASON^ORCHECK Q
 I $G(ORCHECK("OK"))="^" S ORQUIT=1 K ORCHECK("OK") ; save unsigned
 S ORIFN=0 F  S ORIFN=$O(ORCHECK(ORIFN)) Q:ORIFN'>0  D OC^ORCSAVE2
 Q
 ;
LOCATION(ORQ,ORB,ORS) ; -- Returns patient location
 ;    Optional: ORQ = 1 if not required
 ;              ORB = Default value in vptr format
 ;              ORS = String of location types to allow
 ;
 N X,Y,DIR S:'$L($G(ORS)) ORS="CZW" ;assume Clinic, Other, Ward
 S DIR(0)="PA"_$S($G(ORQ):"O",1:"")_"^44:AEQM",DIR("A")="Patient Location: "
 S DIR("S")="I ORS[$P(^(0),U,3),'$P($G(^(""OOS"")),""^"")"
 S DIR("?")="Enter the patient's current location."
 S:$G(ORB) DIR("B")=$P($G(^SC(+ORB,0)),U)
LOC1 D ^DIR S:Y>0 Y=+Y_";SC(" S:Y'>0 Y="^"
 I Y,'$$ACTLOC^ORWU(+Y) W $C(7),!,"This location is inactive!" G LOC1
 Q Y
 ;
PROVIDER(ASK) ; -- Return ordering provider [ASK=1: force prompting]
 N X,Y,DIC,DFN,%
 I '$G(ASK),$D(^XUSEC("ORES",DUZ)),$D(^XUSEC("PROVIDER",DUZ)) D  Q Y
 . S Y=DUZ Q:'$G(ORNP)  Q:ORNP=DUZ  ;no change, else show current prov
 . S Y=+ORNP W !,"Requesting CLINICIAN: "_$P($G(^VA(200,Y,0)),U) H 1
 S Y=$$OUTPTPR^SDUTL3(+ORVP) W:Y !,"Primary Care Physician is "_$P(Y,U,2),!
 I $$GET^XPAR("ALL","ORPF DEFAULT PROVIDER") S:$G(ORNP) DIC("B")=$P($G(^VA(200,+ORNP,0)),U) I '$G(ORNP),$D(^XUSEC("PROVIDER",DUZ)),'$$GET^XPAR("ALL","ORPF RESTRICT REQUESTOR")!$D(^XUSEC("ORES",DUZ)) S DIC("B")=DUZ
P S DIC=200,DIC(0)="AEQM",DIC("A")="Requesting CLINICIAN: " ;D=AK.PROVIDER
 S DIC("S")="I $D(^VA(200,""AK.PROVIDER"",$P(^(0),U)))"
 D ^DIC S:Y>0 Y=+Y I Y'>0 S Y="^" G PQ
 I Y,'$$PROVIDER^XUSER(+Y) W $C(7),!,"This provider is no longer active!" G P ;IA#2343
 I +Y=DUZ S X=$$GET^XPAR("ALL","ORPF RESTRICT REQUESTOR") I X,$S($D(^XUSEC("ORELSE",DUZ)):1,$D(^XUSEC("OREMAS",DUZ))&(X=2):1,1:0) W !!,"You are not allowed to choose yourself as the Requesting Clinician",! G P
 S X=$$GET^XPAR("ALL","ORPF CONFIRM PROVIDER") I X G:(X=2&($D(^XUSEC("ORES",DUZ)))) PQ W !!,"Requesting Clinician: "_$P(^VA(200,+Y,0),"^")_"  Are you sure" S %=$S(X=3:1,1:2) D YN^DICN I %'=1 G P
PQ Q Y
 ;
SPEC(EVENT) ; -- Return treating specialty
 N X,Y,DIC S:'$L($G(EVENT)) EVENT="" D FULL^VALM1 S VALMBCK="R"
 S DIC="^DIC(45.7,",DIC(0)="AEQM",DIC("S")="I $$ACTIVE^DGACT(45.7,Y)",D="B^AHN"
 S DIC("A")=$S(EVENT="A":"Admit to Specialty: ",EVENT="T":"Transfer to Specialty: ",1:"Treating Specialty: ")
 D MIX^DIC1 S:$D(DTOUT)!$D(DUOUT)!(Y'>0) Y="^"
 Q Y
 ;
CHANGE ; -- Change location and/or provider
 N ORRV,ORX,ORCHNGD I $D(^TMP("ORNEW",$J)) D
 . W !!,"There are new orders for this patient from the current location or provider!"
 . H 1 S ORRV=1 D EN^ORCMENU2,NOTIF^ORCMENU2 ;EX^ORCMENU2 in Exit Action
 D FULL^VALM1 S VALMBCK="R",ORCHNGD=0
 W !!,"NOTE: You may now select a new ordering location and/or provider."
 W !,"===== These changes will remain in effect until the chart is closed unless",!,"      these values are changed again!",!,$C(7)
 S ORX=$$LOCATION(0,ORL) Q:ORX="^"
 I ORX,ORX'=ORL S ORL=ORX,ORL(0)=$P($G(^SC(+ORL,0)),U),ORL(1)="",ORCHNGD=1 K ^TMP("ORNEW",$J),VALMHDR
 S ORX=$$PROVIDER(1) I ORX,ORX'=$G(ORNP) S ORNP=ORX,ORCHNGD=1
 W !?10,"... "_$S(ORCHNGD:"changes now effective!",1:"nothing changed!")
 H 1 Q
