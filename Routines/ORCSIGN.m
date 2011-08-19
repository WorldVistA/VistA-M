ORCSIGN ;SLC/MKB-Sign/Release orders ;10/29/01  11:44
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,56,48,79,108,110,134,215**;Dec 17, 1997
 ;
EN ; -- start here
 I '$D(^XUSEC("ORES",DUZ)),'$D(^XUSEC("ORELSE",DUZ)),'$D(^XUSEC("OREMAS",DUZ)) W !,"Insufficient privilege!" H 1 Q
 N ORPTLK,ORI,NMBR,IDX,ORIFN,ORSIG,OREL,ORNATR,ORPRNT,ORPRINT,ORCHART,ORQUIT,ORERR,ORES,ORDER,OROLDSTS,ORACT,X,OR0,ORA0,ORLAB,ORWAIT,ORDA,ORWORK,ORCCNAT,ORCL,ORLR
 S ORPTLK=$$LOCK^ORX2(+ORVP) I 'ORPTLK W !!,$C(7),$P(ORPTLK,U,2) H 2 Q
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("") Q:'ORNMBR
 D FREEZE^ORCMENU S VALMBCK="R" K OREBUILD
 I '$G(ORL) S ORL=$$FINDLOC S:'ORL ORL=$$LOCATION^ORCMENU1 G:ORL="^" ENQ
 S ORACT=$S($D(^XUSEC("ORES",DUZ)):"ES",$D(^XUSEC("OREMAS",DUZ)):"OC",$D(^XUSEC("ORELSE",DUZ)):$$SELSIG,1:"^") G:ORACT="^" ENQ
 S ORNATR=$S(ORACT="RS":$$NATURE,1:"") Q:ORNATR="^"
 F ORI="LR","VBEC" S X=+$O(^DIC(9.4,"C",ORI,0)) S:X ORLR(X)=1,ORLR(ORI)=X
 F ORI=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",ORI) I NMBR D
 . S IDX=$G(^TMP("OR",$J,ORTAB,"IDX",NMBR)),ORDER=$P(IDX,U)
 . Q:'ORDER  S:'$P(ORDER,";",2) ORDER=+ORDER_";1"
 . S ORIFN=+ORDER,ORDA=+$P(ORDER,";",2) K ORQUIT
 . D VALID Q:$G(ORQUIT)  S ORES(ORDER)=""
 . S X=$P($G(^OR(100,ORIFN,0)),U,14) S:$G(ORLR(X)) ORES("LAB")=1
 . S:$P($G(^OR(100,ORIFN,8,ORDA,0)),U,4)=2 ORES("ES")=1
EN1 G:'$O(ORES(0)) ENQ K ORQUIT,ORWAIT
 D ORDCHK^ORCMENU1 G:'$O(ORES(0)) ENQ0
 I $G(ORQUIT) D UNLOCK G ENQ ;quit - ^ at override reason
 S ORSIG=$S($G(ORES("ES")):2,1:3),OREL=0
 I ORSIG=3 W !,"These order(s) do not require a signature."
 E  D  I ORSIG=2,'OREL W !,"Nothing signed or released!" D UNLOCK H 2 G ENQ
 . I ORACT="ES" S:$$ESIG ORSIG=1,OREL=1 Q
 . I ORACT="OC" S:$$ONCHART ORSIG=0,OREL=1,ORNATR="W" Q
 . I ORACT="RS" W:ORNATR'="I" !!,"A signature is required to RELEASE these orders; the responsible provider will",!,"be alerted to electronically sign them." S:$$ESIG ORSIG=$S(ORNATR="I":1,1:$$SIGSTS^ORX1(ORNATR)),OREL=1
 S ORPRNT=$$GET^XPAR("ALL","ORPF PRINT CHART COPY WHEN"),ORPRINT=0
 S ORCCNAT=$$CHART^ORX1($S(ORNATR="":"E",1:ORNATR)),ORCHART=0
 S ORLAB=0 I '$D(^XUSEC("ORES",DUZ))!$$GET^XPAR("ALL","ORPF SHOW LAB #") S ORLAB=$G(ORLR("LR")) ;show Lab# when released
 W !!,"Processing orders ..." D:$G(ORES("LAB")) BHS^ORMBLD(ORVP)
EN2 S ORDER=0 F  S ORDER=$O(ORES(ORDER)) Q:ORDER'>0  D
 . S OROLDSTS=$P($G(^OR(100,+ORDER,3)),U,3),OR0=$G(^(0)),ORA0=$G(^(8,+$P(ORDER,";",2),0))
 . N ORNP S ORNP=$P(ORA0,U,3),ORIFN=+ORDER,ORDA=+$P(ORDER,";",2)
 . S ORNATR=$S($P(ORA0,U,4)=3:"",1:ORNATR) ; reset nature of order for sig not reqd orders --added with patch 110
 . D EN^ORCSEND(ORDER,,ORSIG,OREL,ORNATR,,.ORERR),UNLK1^ORX2(ORIFN)
 . I $D(^TMP("ORNEW",$J,ORIFN,ORDA)) K ^(ORDA) D UNLK1^ORX2(ORIFN)
 . I $G(ORERR) D  S ORWAIT=1 Q
 . . W !!,$$ORDITEM^ORCACT(ORDER)_" "_$$STATUS(ORDER)
 . . W:$L($P($G(ORERR),U,2)) !,"  >> "_$P(ORERR,U,2)
 . I $P(ORA0,U,2)="NW",OROLDSTS=11,$P(OR0,U,14)=ORLAB,$G(^OR(100,ORIFN,4)) W !,$$ORDITEM^ORCACT(ORIFN)_"  (LB #"_+^OR(100,ORIFN,4)_")" S ORWAIT=1
 . I $P(ORA0,U,2)="DC",$P(OR0,U,11)=$O(^ORD(100.98,"B","DO",0)),OROLDSTS=6 D  ;dc'd active NPO
 . . N ORSTRT,ORDATE S ORSTRT=+$E($P($$NOW^XLFDT,".",2)_"0000",1,4)
 . . S ORDATE=DT D LTRAY^ORCDFH ;need late tray for reinstated diet?
 . D SETPRINT W "."
 D:$G(ORES("LAB")) BTS^ORMBLD(ORVP)
EN3 I $O(ORCHART(0))!$O(ORPRINT(0)) S ORCL=$$LOC^ORMEVNT I ORCL,ORCL'=ORL D
 . N X,Y,DIR S DIR(0)="YA",DIR("B")="YES"
 . S DIR("A",1)="This patient's location has been changed to "_$P($G(^SC(+ORCL,0)),U)_"."
 . S DIR("A")="Should the orders be printed using the new location? "
 . S DIR("?")="Enter NO to continue using "_$P($G(^SC(+ORL,0)),U)_" for ordering and printing, or YES to switch to the patient's current location instead"
 . D ^DIR S:Y ORL=ORCL
 D:$O(ORCHART(0)) PRINT^ORPR02(ORVP,.ORCHART,,ORL,"1^0^0^0^0")
 D:$O(ORPRINT(0)) PRINT^ORPR02(ORVP,.ORPRINT,,ORL,"0^1^1^1^"_$$WORK(ORNATR))
ENQ0 D UNOTIF S OREBUILD=1
ENQ D:'$D(^TMP("ORNEW",$J)) UNLOCK^ORX2(+ORVP) D:$G(ORWAIT) READ ;output
 Q
 ;
ESIG() ; -- Get electronic signature
 N CODE,X,X1,Y
 S CODE=$P($G(^VA(200,DUZ,20)),U,4),Y=0 I '$L(CODE) D  Q Y
 . W $C(7),!,"You do not have an electronic signature code."
 . W !,"Please contact your IRM office." ; allow to enter code here?
 D SIG^XUSESIG S Y=(X1'="")
 Q Y
 ;
ONCHART() ; -- Signed on Chart?
 N X,Y,DIR S DIR(0)="YA"
 S DIR("B")=$S($$GET^XPAR("ALL","OR SIGNED ON CHART"):"YES",1:"NO")
 S DIR("A")="Are you sure you want to mark these orders as already Signed on Chart? "
 S DIR("?")="Enter YES only if these orders have already been signed in the patient's paper chart"
 D ^DIR S:$D(DTOUT)!($D(DUOUT)) Y="^"
 Q Y
 ;
SELSIG() ; -- Select type of signature &/or release [ORELSE holders only]
 N X,Y,DIR,ES,ELSE
 D CKAUTH(.ES,.ELSE) I ES,'ELSE Q "ES" ;all may be elec signed
 S DIR("A")="Sign or release: ",DIR(0)="SAOM^"_$S($G(ES):"ES:Electronic Signature;",1:"")_"OC:Signed on Chart;RS:Release w/o MD Signature"
 S DIR("B")=$S($G(ES):"Electronic Signature",$$GET^XPAR("ALL","OR SIGNATURE DEFAULT ACTION")="OC":"Signed on Chart",1:"Release w/o MD Signature")
 S:$G(ES) DIR("?",1)="To electronically sign those orders that you are priviledged to, select ES."
 S DIR("?")="If these orders have already been signed on the paper chart, select OC.  To simply release these orders to the appropriate service for action, select RS; the requesting clinician will receive an alert to sign them."
 W !!,$S($G(ES):"  ES Electronic Signature  ",1:"")_"  OC Signed on Chart    RS Release w/o MD Signature",!
 D ^DIR S:$D(DTOUT)!($D(DUOUT))!(X="") Y="^"
 Q Y
 ;
CKAUTH(SIGN,NOT) ; -- Ck authorization needed
 N I,N,IFN,ACT S (SIGN,NOT)=0
 F I=1:1:$L(ORNMBR,",") S N=$P(ORNMBR,",",I) I N D
 . S IFN=$P($G(^TMP("OR",$J,ORTAB,"IDX",N)),U) Q:'IFN
 . S ACT=$P(IFN,";",2),IFN=+IFN S:ACT'>0 ACT=1
 . I $P($G(^OR(100,IFN,0)),U,16)<2 S SIGN=SIGN+1
 . E  S NOT=NOT+1
 Q
 ;
NATURE() ; -- Returns nature of order/activity
 N X,Y,DIR S DIR("A")="NATURE OF ORDER ACTIVITY: "
 S DIR("B")=$S($G(ORNP)=DUZ:"Policy",1:"Verbal")
 S DIR(0)="SAM^V:Verbal;T:Telephoned;P:Policy;"
 S DIR("?")="Enter how this order was requested or originated."
 D ^DIR S:$D(DTOUT)!($D(DUOUT)) Y="^" S:Y="P" Y="I" S:Y="T" Y="P"
 Q Y
 ;
SETPRINT ; -- Set print arrays
 I $P(^OR(100,ORIFN,3),U,3)=10 Q  ; Still delayed
 N Y S Y=$S($P(ORA0,U,15)=10:1,$P(ORA0,U,15)=11:1,1:0)
 S:Y ORPRINT=ORPRINT+1,ORPRINT(ORPRINT)=ORDER
 I ("R"[ORPRNT&Y)!(ORPRNT="S"&(ORSIG'=2)),ORCCNAT S ORCHART=ORCHART+1,ORCHART(ORCHART)=ORDER
 Q
 ;
WORK(NATR) ; -- Returns 1 or 0, to print work copies for NATR
 S:$G(NATR)="" NATR="E" S:'NATR NATR=+$O(^ORD(100.02,"C",NATR,0))
 Q +$P($G(^ORD(100.02,NATR,1)),U,5)
 ;
CHART ; -- Trigger chart signature notification
 N ORB S ORB=+ORVP_U_+ORIFN_U_ORNP_"^^1"
 D EN^OCXOERR(ORB)
 Q
 ;
NOTIF ; -- Trigger unsigned orders notification
 N ORB S ORB=+ORVP_U_+ORIFN_U_ORNP_"^^^^^1"
 D EN^OCXOERR(ORB)
 Q
 ;
UNOTIF ; -- Undo unsigned orders notification
 Q:$O(^OR(100,"AS",ORVP,0))  ; more left
 N XQAKILL,ORNIFN
 S ORNIFN=$O(^ORD(100.9,"B","ORDER REQUIRES ELEC SIGNATURE",0))
 S XQAKILL=$$XQAKILL^ORB3F1(ORNIFN) ; unsigned orders notif
 I $D(XQAID),$P($P(XQAID,";"),",",3)=ORNIFN D DELETE^XQALERT
 I '$D(XQAID) S XQAID=$P($G(^ORD(100.9,ORNIFN,0)),U,2)_","_+ORVP_","_ORNIFN D DELETEA^XQALERT K XQAID
 Q
 ;
VALID ; -- validate ORDER for signature/release
 N ORLK,ORDIALOG,OROUT,ORPKG
 I '$$VALID^ORCACT0(ORDER,ORACT,.ORERR,ORNATR) W !!,"Cannot sign "_$$ORDITEM^ORCACT(ORDER),!,"  >> "_ORERR S (ORQUIT,ORWAIT)=1 Q
 S ORLK=$$LOCK1^ORX2(ORIFN) I 'ORLK W !!,"Cannot sign "_$$ORDITEM^ORCACT(ORDER),!,"  >> "_$P(ORLK,U,2) S (ORQUIT,ORWAIT)=1 Q  ;order locked
 S ORDIALOG=+$P(^OR(100,ORIFN,0),U,5),ORPKG=+$P(^(0),U,14)
 I $P($G(^OR(100,ORIFN,8,ORDA,0)),U,15)'=11,ORPKG'=$$PKG^ORMPS1("PSO") Q
 S OROUT=$$MSG^ORXD(ORDIALOG) I OROUT W !!,"Cannot release "_$$ORDITEM^ORCACT(ORDER),!,"  >> "_$P(OROUT,U,2) S (ORQUIT,ORWAIT)=1 Q  ;dlg out of order
 I ORDA'>1,$L($G(^ORD(101.41,ORDIALOG,7))) X ^(7) ;validate new orders
 Q
 ;
UNLOCK ; -- Unlock orders in ORES(ORDER)
 N ORIFN S ORIFN=0
 F  S ORIFN=$O(ORES(ORIFN)) Q:ORIFN'>0  D UNLK1^ORX2(+ORIFN)
 Q
 ;
STATUS(ORD) ; -- return [release] status of order ORD
 N STS,X,Y S STS=$P($G(^OR(100,+ORD,8,+$P(ORD,";",2),0)),U,15)
 I STS S Y=$S(STS=10:"delayed",STS=11:"not released",STS=13:"cancelled",1:"")
 E  S X=$P($G(^OR(100,+ORD,3)),U,3),X=$P($G(^ORD(100.01,+X,0)),U),Y=$$LOW^XLFSTR(X)
 Q Y
 ;
READ ; -- Press return to continue
 N X,Y,DIR
 S DIR(0)="EA",DIR("A")="Press <return> to continue ..."
 D ^DIR
 Q
 ;
FINDLOC() ; -- Determine location from selected orders
 N ORI,ORN,ORIFN,ORX,ORY S ORY=""
 F ORI=1:1:$L(ORNMBR,",") S ORN=+$P(ORNMBR,",",ORI) I ORN D  Q:ORY="^"
 . S ORIFN=+$G(^TMP("OR",$J,ORTAB,"IDX",ORN)) Q:'ORIFN
 . S ORX=$P($G(^OR(100,ORIFN,0)),U,10) Q:'ORX  S:ORY="" ORY=ORX
 . I ORY'="",ORY'=ORX S ORY="^" Q  ;different loc's -> prompt
 Q ORY
