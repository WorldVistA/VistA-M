OREVNT ; SLC/MKB - Event delayed orders ;3/31/04  13:42 [4/9/04 10:20am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141,177,195**;Dec 17, 1997
 ;
EN ; -- view/add EVOs
 N X,ORP,ORQUIT S VALMBCK=""
 I $G(OREVENT) D  Q:$G(ORQUIT)
 . S X=$$ACTIVE I X D EX S ORQUIT=1 Q  ;return to Active Orders
 . I X="^" S ORQUIT=1 Q
 D FULL^VALM1 S VALMBCK="R"
 W !!,$$CURRENT
 S:'$G(ORL) ORL=$$LOCATION^ORCMENU1 Q:ORL="^"
 S ORP=$$PTEVENT(+ORVP) Q:ORP="^"
 S $P(^TMP("OR",$J,"ORDERS",0),U,3,4)=";;;;;;;"_+ORP_U,OREVENT=+ORP
 D TAB^ORCHART(ORTAB,1) ;redisplay new order sheet/view
 Q
 ;
EX ; -- Back to Active Orders
 I +$G(OREVENT),'$G(^ORE(100.2,OREVENT,1)),$$EMPTY^OREVNTX(OREVENT) D CANCEL^OREVNTX(OREVENT) ;cancel empty events
 K OREVENT S $P(^TMP("OR",$J,"ORDERS",0),U,3,4)="^1" ;default view
 D TAB^ORCHART(ORTAB,1)
 Q
 ;
ED ; -- Change delay event
 N ORI,NMBR,IDX,ORIFN,ORLK,ORDERS,OREVT,ORQUIT,X,EVT
 I '$G(ORNMBR) S ORNMBR=$$ORDERS^ORCHART("change the delay event") Q:'ORNMBR
 D FREEZE^ORCMENU S VALMBCK="R" K OREBUILD
 F ORI=1:1:$L(ORNMBR) S NMBR=$P(ORNMBR,",",ORI) D:NMBR  Q:$D(ORQUIT)
 . S IDX=$G(^TMP("OR",$J,ORTAB,"IDX",NMBR)),ORIFN=$P(IDX,U)
 . Q:'ORIFN  S:'$P(ORIFN,";",2) ORIFN=+ORIFN_";1" ;unsign/unrel only
 . I '$$VALID^ORCACT0(ORIFN,"EV",.ORERR) W !!,$$ORDITEM^ORCACT(ORIFN)_" invalid.",!,"  >> "_ORERR H 1 Q
 . S ORLK=$$LOCK1^ORX2(+ORIFN) I 'ORLK W !!,$$ORDITEM^ORCACT(ORIFN)_" invalid.",!,"  >> "_$P(ORLK,U,2) H 1 Q
 . S ORDERS(+ORIFN)=""
ED1 Q:'$O(ORDERS(0))  I $$DELAYED D  Q:$G(ORQUIT)  G:$G(OREBUILD) ED3
 . S X=$$NODELAY ;remove event?
 . I X="^" W !,"Nothing changed!" D UNLOCK S ORQUIT=1 H 1 Q
 . Q:'X  W !!,"Removing release event ..."
 . S ORIFN=0 F  S ORIFN=$O(ORDERS(ORIFN)) Q:ORIFN<1  D
 .. S EVT=+$P($G(^OR(100,ORIFN,0)),U,17),OREVT(EVT)=""
 .. D CHGEVT^OREVNTX(ORIFN,""),UNLK1^ORX2(ORIFN) W "."
 . W " done." S OREBUILD=1
ED2 W !!,$$CURRENT S ORP=$$PTEVENT(+ORVP,1)
 I ORP="^" W !,"Nothing changed!" D UNLOCK H 1 Q
 W !!,"Setting release event to "_$P(ORP,U,2)_" ..."
 S ORIFN=0 F  S ORIFN=$O(ORDERS(ORIFN)) Q:ORIFN<1  D
 . S EVT=+$P($G(^OR(100,ORIFN,0)),U,17) Q:EVT=+ORP  S OREVT(EVT)=""
 . D CHGEVT^OREVNTX(ORIFN,+ORP),UNLK1^ORX2(ORIFN) W "."
 W " done." S OREBUILD=1
ED3 S EVT=0 F  S EVT=$O(OREVT(EVT)) Q:EVT<1  D  ;terminate any events?
 . Q:$G(^ORE(100.2,EVT,1))  Q:'$$EMPTY^OREVNTX(EVT)  ;active,empty
 . ;W !!,$P($$NAME^OREVNTX(EVT)," ",2,99)_" has no more delayed orders."
 . ;S DIR(0)="YA",DIR("A")="Do you want to cancel this event? "
 . ;S DIR("?")="Enter NO if you wish to enter new delayed orders for this event, otherwise enter YES to terminate it."
 . ;S DIR("B")="YES" D ^DIR I $D(DTOUT)!$D(DUOUT) S ORQUIT=1 Q
 . D CANCEL^OREVNTX(EVT) S X=$P($$NAME^OREVNTX(EVT)," ",2,99)
 . W !,"   ... "_X_" event cancelled." H 1
 . D:$G(OREVENT) EX ;Change view back to Active
 Q
 ;
ACTIVE() ; -- Return to Active orders?
 N X,Y,DIR S DIR(0)="YA"
 S DIR("A")="Return to viewing Active Orders? ",DIR("B")="YES"
 S DIR("?")="Enter NO to select another delayed order sheet to view, or YES to exit delayed mode and return to your default Orders view."
 D ^DIR S:$D(DTOUT)!$D(DUOUT) Y="^"
 Q Y
 ;
DELAYED() ; -- Return 1 or 0, if current view=EDOs
 I $G(OREVENT) Q 1
 N X,Y S X=$P($G(^TMP("OR",$J,ORTAB,0)),U,3),X=$P(X,";",3)
 S Y=$S("^15^16^17^24^25^"[(U_X_U):1,1:0)
 Q Y
 ;
NODELAY() ; -- Return 1 or 0, if event should be removed
 N X,Y,DIR S DIR(0)="YA"
 S DIR("A")="Remove the release event from these orders? ",DIR("B")="NO"
 S DIR("?")="Enter YES to allow these orders to be released immediately upon signature, or NO to continue and keep this event or select another."
 D ^DIR S:$D(DTOUT)!$D(DUOUT) Y="^"
 Q Y
 ;
UNLOCK ; -- Unlock orders after ^
 F  S ORIFN=$O(ORDERS(ORIFN)) Q:ORIFN'>0  D UNLK1^ORX2(+ORIFN)
 Q
 ;
CURRENT() ; -- Display current patient data
 N Y S Y=ORPNM_" is currently"_$S('$G(ORWARD):" not",1:"")_" admitted"_$S($G(ORWARD)&$G(ORTS):" to "_$P($G(^DIC(45.7,+ORTS,0)),U),1:"")_"."
 Q Y
 ;
PTEVENT(DFN,DLGONLY) ; -- Select Patient Event [or create new one]
 ;    Pass in DLGONLY=1 to skip new event's Order Set (from Copy, Xfer)
 ;    Returns Pt Evt ien ^ Event name
 I '$G(DFN)!'$D(^DPT(+$G(DFN),0)) Q "^" ;invalid patient
 N ORPTEVT,OREVT,X,Y,DIR,DTOUT,DUOUT,ORDIV,DOMAIN,OREV0,ORDAD,ORDIALOG,ORDSET,ORIFN,ORPTLK,OREBUILD,OREVENT
 I $D(^ORE(100.2,"AE",DFN)) D  ;pending events
 . N CNT,EVT S (CNT,EVT)=0,DOMAIN=100.2 K ORPTEVT,DIR
 . F  S EVT=+$O(^ORE(100.2,"AE",DFN,EVT)) Q:EVT'>0  S Y=+$O(^(EVT,0)) D
 .. Q:$G(^ORE(100.2,Y,1))  Q:$$LAPSED^OREVNTX(Y)  Q:$D(^ORE(100.2,"DAD",Y))
 .. S X=$P($G(^ORD(100.5,EVT,0)),U,8),CNT=CNT+1,ORPTEVT(CNT)=Y_U_X
 .. S X=$$UP^XLFSTR(X),ORPTEVT("B",X)=Y
 . Q:CNT'>0  S DIR("A",1)="Delayed orders exist for "_ORPNM_" for the following events:"
 . F I=1:1:CNT S DIR("A",I+1)=$J(I,5)_"  "_$P(ORPTEVT(I),U,2)
 . S DIR("A",CNT+2)="To review or add delayed orders, select from (1-"_CNT_") or enter a new event."
 S X=+$$GET^XPAR("ALL","OREVNT DEFAULT")
 I X S Y=$P($G(^ORD(100.5,X,0)),U,8),DIR("B")=$$UP^XLFSTR(Y)
PT1 S I=0 F  S I=+$O(DIR("A",I)) Q:I<1  W !,DIR("A",I)
 W !,"Select RELEASE EVENT: "_$S($L($G(DIR("B"))):DIR("B")_"//",1:"")
 R X:DTIME I '$T!(X["^")!(X=""&'$D(DIR("B"))) Q "^"
 S:X="" X=$G(DIR("B")) I X["?" D HELP^OREVNT(X) G PT1
 I $O(DIR("A",0)) S ORPTEVT=$$FIND^ORCDLG2("ORPTEVT",X) G:$L(ORPTEVT) PTQ
 S OREVT="" D  I OREVT<1 G PT1 ;reask
 . N DIC,DIR,D S DIC="^ORD(100.5,",DIC(0)="EQZS",D="C",DIC("W")=""
 . S DIC("S")="I '$D(^ORD(100.5,""DAD"",Y))"
 . ;S:'$G(ORWARD) DIC("S")="I $P(^(0),U,2)=""A"""
 . D IX^DIC S:Y>0 OREVT=+Y_U_$P(Y(0),U,8)
 I $$MATCH(DFN,+OREVT),'$$CONT G PT1 ;reask
 S OREV0=$G(^ORD(100.5,+OREVT,0)),ORDAD=+$P(OREV0,U,12)
 S ORDIALOG=+$P(OREV0,U,4),ORDSET=+$P(OREV0,U,5)
 I 'ORDIALOG,'ORDSET!$G(DLGONLY),'ORDAD S ORPTEVT=$$NEW(DFN,+OREVT) S:ORPTEVT<1 ORPTEVT="^" G PTQ
PT2 S ORPTLK=$$LOCK^ORX2(DFN) I 'ORPTLK W !!,$C(7),$P(ORPTLK,U,2) H 2 Q "^"
 S ORNP=$$PROVIDER^ORCMENU1 I ORNP="^" Q "^"
 I ORDAD D  I $G(ORIFN)="^" Q "^"  ;parent
 . N OREVT S OREVT=ORDAD,ORDIALOG=+$P($G(^ORD(100.5,ORDAD,0)),U,4)
 . I ORDIALOG S ORIFN=+$$ORDER^ORCDLG(ORDIALOG) I ORIFN<1 S ORIFN="^" Q
 . S ORPTEVT=$$NEW(DFN,ORDAD,$G(ORIFN)),ORDIALOG="" K ORIFN
 I ORDIALOG S ORIFN=+$$ORDER^ORCDLG(ORDIALOG) I ORIFN<1 Q "^"
 S ORPTEVT=$$NEW(DFN,+OREVT,$G(ORIFN)) I ORPTEVT<1 Q "^"
 I ORDSET,'$G(DLGONLY) S OREVENT=+ORPTEVT D EN^ORCDLG(ORDSET) K ^TMP("ORECALL",$J)
 D:'$D(^TMP("ORNEW",$J)) UNLOCK^ORX2(DFN) ;unlock if no new orders
PTQ Q ORPTEVT
 ;
HELP(RSP) ; -- ?help for DIR Event lookup
 N X,Y,Z,CNT,DONE
 W !,"Select the release event for which you wish to delay orders."
 W !,"Choose from:" S CNT=1
 S X="" F  S X=$O(^ORD(100.5,"C",X)) Q:X=""  D  Q:$G(DONE)
 . S Y=0 F  S Y=$O(^ORD(100.5,"C",X,Y)) Q:Y<1  D  Q:$G(DONE)
 .. Q:$O(^ORD(100.5,"DAD",Y,0))  ;Parent event
 .. S TYPE=$P($G(^ORD(100.5,Y,0)),U,2)
 .. I RSP="?" Q:TYPE="A"&$G(ORWARD)  Q:TYPE'="A"&'$G(ORWARD)
 .. W !,"   "_X S CNT=CNT+1 Q:CNT'>(IOSL-3)  S CNT=0
 .. W !,"   '^' TO STOP: " R Z:DTIME S:'$T!(Z["^") DONE=1
 Q
 ;
NEW(DFN,EVT,IFN) ; -- Create new Patient Event in #100.2
 I '$G(DFN) Q "^"
 N I,HDR,LAST,TOTAL,DA,ADM,DAD,X0
 F I=1:1:10 L +^ORE(100.2,0):1 Q:$T  H 2
 I '$T Q "^"
 S HDR=$G(^ORE(100.2,0)),TOTAL=+$P(HDR,U,4),LAST=$O(^ORE(100.2,"?"),-1)
 S I=LAST F I=(I+1):1 Q:'$D(^ORE(100.2,I,0))
 S DA=I,$P(HDR,U,3,4)=DA_U_(TOTAL+1),DFN=+DFN
 S ^ORE(100.2,0)=HDR ;195 Moved unlock to later in code
 S X0=$G(^ORD(100.5,+$G(EVT),0)) I $P(X0,U,12) D  ;link to parent event
 . S DAD=+$P(X0,U,12),$P(X0,U,2)=$P($G(^ORD(100.5,DAD,0)),U,2)
 . S DAD=+$O(^ORE(100.2,"AE",DFN,DAD,0)) Q:DAD<1
 . S $P(^ORE(100.2,DA,1),U,5)=DAD,^ORE(100.2,"DAD",DAD,DA)=""
 S ADM=$S('$G(EVT):$G(VAIP(13)),$P(X0,U,2)="A":"",$P(X0,U,2)="T"&$$NHCU(EVT):"",1:+$G(^DPT(DFN,.105)))
 S ^ORE(100.2,"B",DFN,DA)="" S:$G(IFN) IFN=+IFN
 S ^ORE(100.2,DA,0)=DFN_U_$G(EVT)_U_ADM_U_$G(IFN)_U_+$E($$NOW^XLFDT,1,12)_U_$G(DUZ)
 S:$G(EVT) ^ORE(100.2,"E",EVT,DA)="",^ORE(100.2,"AE",DFN,EVT,DA)=""
 I $G(IFN) S ^ORE(100.2,"AO",IFN,DA)="",$P(^OR(100,IFN,0),U,17)=DA,^OR(100,"AEVNT",DFN_";DPT(",DA,IFN)=""
 L -^ORE(100.2,0) ;195 Unlock after global is set
 Q DA
 ;
NHCU(OREVT) ; -- Returns 1 or 0, if EVT is to NHCU
 N ORI,ORX,ORY S (ORI,ORY)=0
 F  S ORI=$O(^ORD(100.5,+$G(OREVT),"TS",ORI)) Q:ORI<1  S ORX=+$G(^(ORI,0)) I $$GET1^DIQ(45.7,ORX_",","SPECIALTY:SERVICE")="NHCU" S ORY=1 Q  ;DBIA #1154
 Q ORY
 ;
DELETE(DA) ; -- Delete Patient Event
 N DIK S DIK="^ORE(100.2," D:$G(DA) ^DIK
 Q
 ;
MATCH(DFN,EVT) ; -- Does Pt's current data match selected Event?
 N X0,Y,LOC,WD,TS,PEVT ;177 This section updated to account for child events
 S PEVT=$P($G(^ORD(100.5,EVT,0)),U,12) ;177 Is this a child event?
 S X0=$G(^ORD(100.5,$S($G(PEVT):PEVT,1:EVT),0)),Y=1 ;177
 I "^D^O^M^"[(U_$P(X0,U,2)_U) S Y=0 G MQ
 S LOC=$S($G(ORL):+ORL,1:+$$CURRLOC(DFN)),WD=+$G(^SC(LOC,42))
 I $$DIV^ORMEVNT(LOC)'=$P(X0,U,3) S Y=0 G MQ
 S TS=$S($G(ORTS):+ORTS,1:+$G(^DPT(DFN,.103)))
 I $O(^ORD(100.5,$S($G(PEVT):PEVT,1:EVT),"TS",0)),'$D(^("B",TS)) S Y=0 G MQ ;177
 I $O(^ORD(100.5,$S($G(PEVT):PEVT,1:EVT),"LOC",0)),'$D(^("B",WD)) S Y=0 G MQ ;177
MQ Q Y
 ;
CURRLOC(DFN) ; -- Return current Hospital Location (ptr to #44) of patient DFN
 N X,Y S X=$P($G(^DPT(DFN,.1)),U),Y=""
 I $L(X) S X=+$O(^DIC(42,"B",X,0)),Y=+$G(^DIC(42,X,44))
 Q Y
 ;
CONT() ; -- ok to continue?
 N X,Y,DIR
 S DIR("A",1)=ORPNM_" is already assigned to "_$P($G(^DIC(45.7,+$G(ORTS),0)),U)_" on "_$P($G(^SC(+$G(ORL),0)),U)_"!"
 S DIR(0)="YA",DIR("A")="Do you still want to add future orders? "
 S DIR("?")="Enter YES to add orders that will be delayed until this event occurs in the future, or NO to quit."
 S DIR("B")="NO" W ! D ^DIR S:$D(DTOUT)!$D(DUOUT) Y="^"
 Q Y
