OREVNT1 ;SLC/MKB - Release delayed orders ;3/31/04  09:08
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141,195**;Dec 17, 1997
 ;
EN ; -- start here
 I '$$CANREL^OREV3() W !,"Insufficient privilege!" H 1 Q
 N ORPTLK,ORLR,ORACT,ORNATR,ORI,NMBR,IDX,ORDER,ORIFN,ORDA,ORQUIT,ORES,ORWAIT,ORSIG,OREL,ORPRNT,ORPRINT,ORCHART,ORWORK,ORLAB,OR0,ORA0,ORERR,ORCL,OREVT,OREVENT,J ;195
 S ORPTLK=$$LOCK^ORX2(+ORVP) I 'ORPTLK W !!,$C(7),$P(ORPTLK,U,2) H 2 Q
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("") G:'ORNMBR ENQ
 D FREEZE^ORCMENU S VALMBCK="R" K OREBUILD
 S ORL=$$LOCATION^ORCMENU1 G:ORL="^" ENQ ;I '$G(ORL)
 S ORLR=+$O(^DIC(9.4,"C","LR",0)),(ORACT,ORNATR)=""
 I $$NEEDSIG S ORACT=$S($D(^XUSEC("ORES",DUZ)):"ES",$D(^XUSEC("OREMAS",DUZ)):"OC",$D(^XUSEC("ORELSE",DUZ)):$$SELSIG^ORCSIGN,1:"^") G:ORACT="^" ENQ
 F ORI=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",ORI) I NMBR D
 . S IDX=$G(^TMP("OR",$J,ORTAB,"IDX",NMBR)),ORDER=$P(IDX,U)
 . Q:'ORDER  S:'$P(ORDER,";",2) ORDER=+ORDER_";1"
 . S ORIFN=+ORDER,ORDA=+$P(ORDER,";",2) K ORQUIT
 . D VALID Q:$G(ORQUIT)  S ORES(ORDER)=""
 . S:$P($G(^OR(100,ORIFN,0)),U,14)=ORLR ORES("LAB")=1
EN1 G:'$O(ORES(0)) ENQ K ORQUIT,ORWAIT
 ;D ORDCHK^ORCMENU1 G:'$O(ORES(0)) ENQ0
 ;I $G(ORQUIT) D UNLOCK G ENQ ;quit - ^ at override reason
 S ORSIG=$S($G(ORES("ES")):2,1:""),OREL=$S(ORSIG:0,1:1)
 I ORSIG D  I ORSIG=2,'OREL W !,"Nothing signed or released!" D UNLOCK H 2 G ENQ
 . I ORACT="ES" S:$$ESIG^ORCSIGN ORSIG=1,OREL=1 Q
 . I ORACT="OC" S:$$ONCHART^ORCSIGN ORSIG=0,OREL=1,ORNATR="W" Q
 . S ORNATR=$$NATURE^ORCSIGN Q:ORNATR="^"  ;ORACT="RS"
 . W:ORNATR'="I" !!,"A signature is required to RELEASE these orders; the responsible provider will",!,"be alerted to electronically sign them."
 . S:$$ESIG^ORCSIGN ORSIG=$S(ORNATR="I":1,1:$$SIGSTS^ORX1(ORNATR)),OREL=1
 S ORPRNT=$$GET^XPAR("ALL","ORPF PRINT CHART COPY WHEN")
 S (ORPRINT,ORCHART,ORWORK,ORLAB)=0
 I '$D(^XUSEC("ORES",DUZ))!$$GET^XPAR("ALL","ORPF SHOW LAB #") S ORLAB=ORLR ;show Lab# when released
 W !!,"Processing orders ..." D:$G(ORES("LAB")) BHS^ORMBLD(ORVP)
EN2 S ORDER=0 F  S ORDER=$O(ORES(ORDER)) Q:ORDER'>0  D
 . S OR0=$G(^OR(100,+ORDER,0)),ORA0=$G(^(8,+$P(ORDER,";",2),0))
 . I '$$LCKEVT^ORX2($P(OR0,U,17)) S EVENT($P(OR0,U,17))="" Q  ;195 Don't process if event locked
 . N ORNP S ORNP=$P(ORA0,U,3),ORIFN=+ORDER,ORDA=+$P(ORDER,";",2)
 . S:$G(ORL) $P(^OR(100,ORIFN,0),U,10)=ORL ;set location
 . S:$G(ORTS) $P(^OR(100,ORIFN,0),U,13)=ORTS ;set specialty
 . D EN2^ORCSEND(ORDER,ORSIG,ORNATR,.ORERR),UNLK1^ORX2(ORIFN)
 . I $D(^TMP("ORNEW",$J,ORIFN,ORDA)) K ^(ORDA) D UNLK1^ORX2(ORIFN)
 . I $G(ORERR) D  S ORWAIT=1 Q
 . . W !!,$$ORDITEM^ORCACT(ORDER)_" "_$$STATUS^ORCSIGN(ORDER)
 . . W:$L($P($G(ORERR),U,2)) !,"  >> "_$P(ORERR,U,2)
 . I $P(OR0,U,14)=ORLAB,$G(^OR(100,ORIFN,4)) W !,$$ORDITEM^ORCACT(ORIFN)_"  (LB #"_+^OR(100,ORIFN,4)_")" S ORWAIT=1
 . S ORV=+$P(OR0,U,17),OREVT(ORV)="" D SETPRINT(ORNATR)
 . D:$$TYPE^OREVNTX(ORV)="M" SAVE^ORMEVNT1(ORIFN,ORV,2) W "."
 D:$G(ORES("LAB")) BTS^ORMBLD(ORVP)
EN3 I $O(ORCHART(0))!$O(ORPRINT(0)) S ORCL=$$LOC^ORMEVNT I ORCL,ORCL'=ORL D
 . N X,Y,DIR S DIR(0)="YA",DIR("B")="YES"
 . S DIR("A",1)="This patient's location has been changed to "_$P($G(^SC(+ORCL,0)),U)_"."
 . S DIR("A")="Should the orders be printed using the new location? "
 . S DIR("?")="Enter NO to continue using "_$P($G(^SC(+ORL,0)),U)_" for ordering and printing, or YES to switch to the patient's current location instead"
 . D ^DIR S:Y ORL=ORCL
 D:$O(ORCHART(0)) PRINT^ORPR02(ORVP,.ORCHART,,ORL,"1^0^0^0^0")
 D:$O(ORPRINT(0)) PRINT^ORPR02(ORVP,.ORPRINT,,ORL,"0^1^1^1^0")
 D:$O(ORWORK(0)) PRINT^ORPR02(ORVP,.ORWORK,,ORL,"0^0^0^0^1")
ENQ0 D UNOTIF^ORCSIGN,EMPTY S OREBUILD=1
ENQ D:'$D(^TMP("ORNEW",$J)) UNLOCK^ORX2(+ORVP) D:$G(ORWAIT) READ ;output
 I $D(EVENT) W !!,"Orders not released >> Delayed event being processed by another user!" D READ S J=0 F  S J=$O(EVENT(J)) Q:'+J  D UNLEVT^ORX2(J) ;195
 Q
 ;
SETPRINT(NATR) ; -- Set print arrays
 S:'$L(NATR)!($P(ORA0,U,4)'=2) NATR=$P(ORA0,U,12)
 S ORPRINT=ORPRINT+1,ORPRINT(ORPRINT)=ORDER
 I ("R"[ORPRNT)!(ORPRNT="S"&($P(ORA0,U,4)=2)&(ORSIG'=2)),$$CHART^ORX1(NATR) S ORCHART=ORCHART+1,ORCHART(ORCHART)=ORDER
 S:$$WORK(NATR) ORWORK=ORWORK+1,ORWORK(ORWORK)=ORDER
 Q
 ;
WORK(NATR) ; -- Returns 1 or 0, to print work copies for NATR
 S:$G(NATR)="" NATR="E" S:'NATR NATR=+$O(^ORD(100.02,"C",NATR,0))
 Q +$P($G(^ORD(100.02,NATR,1)),U,5)
 ;
NEEDSIG()       ; -- Return 1 or 0, if any selected orders need ES
 N ORI,NMBR,ORIFN,ORDA,Y S Y=0
 F ORI=1:1:$L(ORNMBR,",") S NMBR=$P(ORNMBR,",",ORI) I NMBR D  Q:Y
 . S ORIFN=$P($G(^TMP("OR",$J,ORTAB,"IDX",NMBR)),U) Q:'ORIFN
 . S ORDA=+$P(ORIFN,";",2),ORIFN=+ORIFN S:'ORDA ORDA=1
 . S:$P($G(^OR(100,ORIFN,8,ORDA,0)),U,4)=2 ORES("ES")=1,Y=1
 Q Y
 ;
VALID ; -- validate ORDER for signature/release
 I '$$VALID^ORCACT0(ORDER,"MN",.ORERR) W !!,"Cannot release "_$$ORDITEM^ORCACT(ORDER),!,"  >> "_ORERR S (ORQUIT,ORWAIT)=1 Q
 I $L(ORACT),$P($G(^OR(100,ORIFN,8,ORDA,0)),U,4)=2,'$$VALID^ORCACT0(ORDER,ORACT,.ORERR,ORNATR) W !!,"Cannot sign "_$$ORDITEM^ORCACT(ORDER),!,"  >> "_ORERR S (ORQUIT,ORWAIT)=1 Q
 N ORLK,ORDIALOG S ORLK=$$LOCK1^ORX2(ORIFN)
 I 'ORLK W !!,"Cannot release "_$$ORDITEM^ORCACT(ORDER),!,"  >> "_$P(ORLK,U,2) S (ORQUIT,ORWAIT)=1 Q  ;order locked
 S ORDIALOG=+$P($G(^OR(100,ORIFN,0)),U,5)
 I $L($G(^ORD(101.41,ORDIALOG,7))) X ^(7) D:$G(ORQUIT) UNLK1^ORX2(ORIFN)
 Q
 ;
EMPTY ; -- check if no more orders for events in OREVT()
 N EVT,X
 S EVT=0 F  S EVT=$O(OREVT(EVT)) Q:EVT<1  D  ;terminate any events?
 . Q:$G(^ORE(100.2,EVT,1))  Q:'$$EMPTY^OREVNTX(EVT)  ;active,empty
 . ;W !!,$P($$NAME^OREVNTX(EVT)," ",2,99)_" has no more delayed orders."
 . ;S DIR(0)="YA",DIR("A")="Do you want to terminate this event? "
 . ;S DIR("?")="Enter NO if you wish to enter new delayed orders for this event, otherwise enter YES to terminate it."
 . ;S DIR("B")="YES" D ^DIR I $D(DTOUT)!$D(DUOUT) S ORQUIT=1 Q
 . D DONE^OREVNTX(EVT),ACTLOG^OREVNTX(EVT,"MN")
 . S X=$P($$NAME^OREVNTX(EVT)," ",2,99)
 . W !,"   ... "_X_" event completed." H 1
 . D:$G(OREVENT) EX^OREVNT ;return view to Active
 Q
 ;
UNLOCK ; -- Unlock orders in ORES(ORDER)
 N ORIFN S ORIFN=0
 F  S ORIFN=$O(ORES(ORIFN)) Q:ORIFN'>0  D UNLK1^ORX2(+ORIFN)
 Q
 ;
READ ; -- Press return to continue
 N X,Y,DIR
 S DIR(0)="EA",DIR("A")="Press <return> to continue ..."
 D ^DIR
 Q
 ;
DONE() ; -- OREVENT done?
 Q:'$G(^ORE(100.2,+$G(OREVENT),1)) 0  ;not done yet
 D FULL^VALM1
 W !!,"The event "_$$NAME^OREVNTX(OREVENT)_" has occurred since"
 W !,"you started writing delayed orders.  The orders that were signed have now been"
 W !,"released; any unsigned orders will be released immediately upon signature."
 W !!,"To write new delayed orders for this event you must select the Delayed Orders"
 W !,"action and this release event again.  Orders delayed to this same event will"
 W !,"remain delayed until the event occurs again."
 W !!,"The Orders tab will now be refreshed in the Active Orders view; you may then"
 W !,"write active orders for this patient as usual."
 D READ S XQORQUIT=1 D EX^OREVNT ;return view to Active
 Q 1
