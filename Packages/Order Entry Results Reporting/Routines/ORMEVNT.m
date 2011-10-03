ORMEVNT ;SLC/MKB-Trigger HL7 msg off MAS events ;3/31/04  09:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**24,45,70,79,141,165,177,186,195,278,243**;Dec 17, 1997;Build 242
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN1 ; -- tasked entry point
 Q:'$G(DFN)  Q:$D(DGPMPC)  Q:DGPMT=4!(DGPMT=5)  ;skip lodger mvts
 N ZTDESC,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTSK,I
 S ZTDESC="Auto-DC and/or Release orders on MAS movement",ZTIO=""
 S ZTRTN="EN^ORMEVNT",ZTDTH=$H,ZTSAVE("^UTILITY(""DGPM"",$J,")=""
 F I="DFN","DGPMDA","DGPMA","DGPMP","DGPMT" S ZTSAVE(I)=""
 D ^%ZTLOAD ;D EN^ORYDGPM
 Q
 ;
EN ; -- main entry point
 S:$D(ZTQUEUED) ZTREQ="@"
 Q:'$G(DFN)  Q:$D(DGPMPC)  Q:DGPMT=4!(DGPMT=5)
 I '$G(DGPMP) S ^XTMP("OREVENT",DFN,DGPMDA,0)=DT_U_$$FMADD^XLFDT(DT,2)_U_"Event process flag" ;195
 I $G(DGPMP),$D(^XTMP("OREVENT",DFN,DGPMDA)) D EN1 Q  ;195 edits processed after new JEH
 N XQORQUIT,XQORPOP,DTOUT,DUOUT,DIRUT,DIROUT ;protect protocol context
 N VAIP,DONE,ORVP,ORWARD,ORTS,ORL,ORDIV,ORLAST,X,Y,I,ORCURRNT,OREVENT,ORDCRULE,ORACT,ORPRINT
 S VAIP("E")=DGPMDA D IN5^VADPT M ORVP=VAIP I '$G(DGPMA) D  Q  ;deleted
 . N LAST,OREVT S LAST=+$O(^ORE(100.2,"ADT",DGPMDA,""),-1) Q:LAST<1
 . S OREVT=+$O(^ORE(100.2,"ADT",DGPMDA,LAST,0))
 . D ACTLOG^OREVNTX(OREVT,"DL")
A ;
 S ORVP=+DFN_";DPT(",ORTS=+$G(^DPT(DFN,.103)),ORWARD=$G(^(.1))
 S ORWARD=$S($L(ORWARD):+$O(^DIC(42,"B",ORWARD,0)),1:0)
 S ORL=$S(ORWARD:+$G(^DIC(42,ORWARD,44))_";SC(",1:""),ORDIV=$$DIV(+ORL)
 S ORLAST("TS")=$$PREVTS,X=+VAIP(15,4) F I="WD","LOC","DIV" S ORLAST(I)=""
 S:X ORLAST("WD")=X,Y=+$G(^DIC(42,X,44)),ORLAST("LOC")=Y_";SC(",ORLAST("DIV")=$$DIV(Y)
 N OREVNTLK S OREVNTLK=""  ;JEH
 S ORCURRNT=$$CURRENT,OREVENT=$$PATEVT,ORACT=$S($G(DGPMP):"ED",1:"NW") ; Lock
 I OREVENT=-1 D EN1 Q  ;195 Can't lock, retry
 S OREVNTLK=OREVENT  ; save routine copy of ifn JEH
 I $G(DGPMP),$D(^ORE(100.2,"ADT",DGPMDA)) D   ;edited 
 . N LAST,OREVT,DA,X,I S LAST=+$O(^ORE(100.2,"ADT",DGPMDA,""),-1) Q:LAST<1
 . S OREVT=+$O(^ORE(100.2,"ADT",DGPMDA,LAST,0)),DA=+$O(^(OREVT,0))
 . S X=$G(^ORE(100.2,OREVT,10,DA,0)) ;last activity on movement
 . I $P(X,U,5)=+$G(VAIP(4)),$P(X,U,6)=+$G(VAIP(8)),$P(X,U,7)=+$G(VAIP(5)) S DONE=1 Q  ;no change
 . I 'OREVENT D ACTLOG^OREVNTX(OREVT,"ED",$$TYPE(DGPMT),1) S DONE=1
 I $G(DONE) D FINISHED Q  ; unlock and clean up before quit IFNjeh 
B ;
 I '$G(DGPMP),ORCURRNT D  ;new mvt - autoDC
 . I $D(^ORE(100.2,"ADT",DGPMDA)) D  Q:$G(DONE)  ;ReEntered
 .. N LAST,OREVT S DONE=0
 .. S LAST=+$O(^ORE(100.2,"ADT",DGPMDA,""),-1),OREVT=+$O(^(LAST,0))
 .. Q:+ORVP'=+$G(^ORE(100.2,OREVT,0))  ;diff pat -> diff mvt
 .. S ORACT="RE",DONE=1 Q:OREVENT  ;log on new event instead
 .. D ACTLOG^OREVNTX(OREVT,ORACT,$$TYPE(DGPMT),1)
 . I DGPMT=3 D COMP("ALG") ;keep until GMRA*4*15 gets out
 . S ORDCRULE=$$DCEVT D:ORDCRULE AUTODC^ORMEVNT1(ORDCRULE,$P(DGPMA,U))
 . I DGPMT=1!(DGPMT=2&("^13^40^"[("^"_$P(DGPMA,U,18)_"^"))) I $G(^XTMP("ORDCOBS-"_+ORVP,0)) D REINST ;186 TO ASIH tran mvmt
C ;
 I OREVENT D  ;release delayed orders, complete event
 . D RELEASE^ORMEVNT1(OREVENT),DONE^OREVNTX(OREVENT,$P(DGPMA,U),DGPMDA)
 . I '$G(VAIP(1)) M VAIP=ORVP ;reset for ACTLOG use
 . D ACTLOG^OREVNTX(OREVENT,ORACT,$$TYPE(DGPMT),1)
 . I DGPMT=1,'$P($G(^ORE(100.2,+OREVENT,0)),U,3) S $P(^(0),U,3)=DGPMDA
 . ;D UNLEVT^ORX2(OREVENT)
 I $O(ORPRINT(0)),$G(ORL) D PRINTS^ORWD1(.ORPRINT,+ORL)
 I DGPMT=3,ORCURRNT,'$G(DGPMP) D DISCH ;lapse remaining events
 I '$G(DFN),$G(ORVP) S DFN=+ORVP ;just in case
FINISHED  ; unlock and clean up JEH
 D:$G(OREVNTLK) UNLEVT^ORX2(OREVNTLK) K ^XTMP("OREVENT",DFN,DGPMDA) ;195
 Q
 ;
CURRENT() ; -- Returns 1 or 0, if DGPMDA is the latest movement
 N Y,LAST,LASTYPE,LASTDT S Y=0
 S LAST=+VAIP(14),LASTDT=+VAIP(14,1),LASTYPE=+VAIP(14,2)
 ; VAIP(14) = last physical movement for the admission
 I DGPMT=6 D  G CQ
 . N CA,IDT I LAST,LASTDT>+VAIP(3) Q  ;last physical mvt
 . S CA=+VAIP(13),IDT=9999999.9999999-VAIP(3)
 . I '$O(^DGPM("ATS",DFN,CA,IDT),-1) S Y=1 Q  ;last TS mvt
 I DGPMT=3 D  ;get last mvt overall
 . N VAIP,Y S VAIP("D")="LAST" D IN5^VADPT
 . S LAST=+VAIP(14),LASTYPE=+VAIP(14,2) ;reset
 I LAST=DGPMDA S Y=1 G CQ ;primary mvt
 I $D(^UTILITY("DGPM",$J,LASTYPE,LAST)) S Y=1 ;secondary mvt
CQ Q Y
 ;
PREVTS() ; -- Returns previous treating specialty
 N TS,TSP,CA,ID,LAST,Y
 S TS=+$O(^UTILITY("DGPM",$J,6,0)),TSP=$G(^(TS,"P"))
 I $G(TSP) S Y=+$P(TSP,U,9) G PRVQ ;edited TS mvt
 ; look for TS mvt since last phys mvt
 S CA=$P(DGPMA,U,14),ID=9999999.9999999-DGPMA
 S LAST=+$O(^DGPM("ATS",DFN,CA,ID)),Y=$S(LAST:+$O(^(LAST,0)),1:+VAIP(15,6))
PRVQ Q Y
 ;
TYPE(X) ; -- Return type of event from MAS code
 N Y S Y=$S(X=1:"A",X=2:"T",X=3:"D",X=6:"S",1:"")
 Q Y
 ;
DIV(LOC) ; -- Return Institution file #4 ptr for LOC
 N X0,Y S X0=$G(^SC(+LOC,0))
 S Y=$S($P(X0,U,4):$P(X0,U,4),$P(X0,U,15):$$SITE^VASITE(DT,$P(X0,U,15)),1:+$G(DUZ(2)))
 Q Y
 ;
PATEVT() ; -- Find match to new data in Patient Event file
 N TYPE,MVTYPE,EVT,IFN,X0,Y S Y="" G:'$G(ORCURRNT) PTQ
 S TYPE=$S(DGPMT=1:"A",DGPMT=3:"D",DGPMT=2!(DGPMT=6):"T",1:""),EVT=0
 S MVTYPE=$P(DGPMA,U,18),TYPE(1)="",MVTYPE(1)=""
 I DGPMT=2,MVTYPE=13 S TYPE(1)="A",MVTYPE(1)=40 ;To ASIH
 I DGPMT=3,MVTYPE=41 S TYPE(1)="T",MVTYPE(1)=14 ;From ASIH
 I DGPMT'=3,$$GET1^DIQ(45.7,+$G(ORTS)_",","SPECIALTY:SERVICE")="NHCU" S TYPE(1)=$S(TYPE="A":"T",1:"A") ;DBIA #1154
 F  S EVT=+$O(^ORE(100.2,"AE",DFN,EVT)) Q:EVT<1  S IFN=+$O(^(EVT,0)) D  Q:Y
 . Q:$$LAPSED^OREVNTX(+IFN)  Q:$P($G(^ORE(100.2,IFN,1)),U,5)
 . S X0=$G(^ORD(100.5,EVT,0)) Q:$P(X0,U,3)'=ORDIV
 . I $P(X0,U,2)'=TYPE,$P(X0,U,2)'=TYPE(1) Q  ;Xaction type
 . I $P(X0,U,7),$P(X0,U,7)'=MVTYPE,$P(X0,U,7)'=MVTYPE(1) Q  ;Mvt type
 . I $O(^ORD(100.5,EVT,"TS",0)) Q:'$D(^("B",ORTS))  Q:ORTS=ORLAST("TS")&(ORDIV=ORLAST("DIV"))
 . I $O(^ORD(100.5,EVT,"LOC",0)) Q:'$D(^("B",ORWARD))  Q:ORWARD=ORLAST("WD")
 . S Y=+IFN ;ok
 I Y S:'$$LCKEVT^ORX2(Y) Y=-1 ;195 Lock event if possible
PTQ Q Y
 ;
DCEVT() ; -- Find match to event in AutoDC Rules file for [new] ORDIV,ORTS,ORL
 N MVTYPE,DIV,XFER,ORY,EXC,OBS
 S OBS=$S(DGPMT=3:$$MVT^DGPMOBS(DGPMDA),1:0) ;observation mvt
 S MVTYPE=+$P(DGPMA,U,18) S:MVTYPE=41 MVTYPE=14 S:MVTYPE=40 MVTYPE=13 ;ASIH- 186
 S XFER=$S(DGPMT=2:1,DGPMT=6:1,MVTYPE'=14:0,OBS:0,1:1)
 I DGPMT=2,MVTYPE=13,$G(^XTMP("ORDCOBS-"_+ORVP,"READMIT")) S ORY=0 K ^XTMP("ORDCOBS-"_+ORVP,"READMIT") G DCQ ;186 Obs readmit from ASIH don't auto-dc
 I XFER,ORLAST("TS")'=ORTS,$D(^ORD(100.6,"AC",ORDIV,20)) S MVTYPE=20 ;TS
 S DIV=ORDIV I DGPMT=3,MVTYPE'=14 S DIV=ORLAST("DIV") ;discharge
 S ORY=+$O(^ORD(100.6,"AC",ORDIV,MVTYPE,0)) K:ORY<1&(DGPMT=3)&(OBS) ^XTMP("ORDCOBS-"_+ORVP) G:ORY<1 DCQ ;186, If obs, no active rule, no reinstate
 I MVTYPE=20,$D(^ORD(100.6,ORY,4,ORLAST("TS"),1,ORTS))!(ORTS=ORLAST("TS")) S ORY=0 G DCQ
 I MVTYPE=4 D  G DCQ ;ck Div and Loc multiples
 . I ORLAST("DIV")'=ORDIV S:'$D(^ORD(100.6,ORY,6,ORLAST("DIV"))) ORY=0 Q
 . N OLD,INCL S INCL=0 ;ck incl loc's
 . F OLD=+ORLAST("LOC"),"ALL" I $D(^ORD(100.6,ORY,5,"ADC",OLD,+ORL))!$D(^("ALL")) S INCL=1 Q
 . S:'INCL ORY=0
 I DGPMT=3,OBS D  ;readmitting from observation?
 . N TORY
 . S TORY=ORY
 . S EXC=+$P($G(^ORD(100.6,ORY,0)),U,6) S:EXC=2 ORY=0 ;ignore rule
 . I EXC=1,'$D(ZTQUEUED),$$READMIT S ORY=0
 . I ORY=0 D DCGEN^ORMEVNT2,TIMER^ORMEVNT2 S:"^14^41^"[("^"_$P(DGPMA,U,18)_"^") ^XTMP("ORDCOBS-"_+ORVP,"READMIT")=1 ;177,186 
 . K:ORY ^XTMP("ORDCOBS-"_+ORVP) ;have rule -> dc, don't reinstate meds
DCQ Q ORY
 ;
READMIT() ; -- Return 1 or 0, if patient is being readmitted
 N X,Y,DIR
 S DIR(0)="YA",DIR("A")="Will the patient be re-admitted immediately? "
 S DIR("?")="Enter YES if the patient is to be admitted to the hospital immediately following this discharge from observation."
 D ^DIR S:$D(DTOUT)!$D(DUOUT) Y="^"
 Q Y
 ;
COMP(ORDG) ; -- Complete orders on event [Keep until GMRA*4*15]
 N ORI,ORLIST,ORIFN,OREDT
 I 'ORDG S:ORDG?1.U ORDG=+$O(^ORD(100.98,"B",ORDG,0)) Q:ORDG'>0
 D EN^ORQ1(ORVP,ORDG,2) S ORI=0,OREDT=$P(DGPMA,U)
 F  S ORI=$O(^TMP("ORR",$J,ORLIST,ORI)) Q:ORI'>0  S ORIFN=^(ORI) D STATUS^ORCSAVE2(+ORIFN,2) S:$G(OREDT) $P(^OR(100,+ORIFN,3),U)=OREDT,$P(^(6),U,6)=OREDT
 Q
 ;
LOC(NODE) ; -- Returns [new] patient location from NODE
 N X,Y S X=$P($G(NODE),U,6)
 I X'>0 S X=$P($G(^DPT(+ORVP,.1)),U) S:$L(X) X=$O(^DIC(42,"B",X,0))
 S Y=+$G(^DIC(42,+X,44))_";SC("
 Q Y
 ;
DISCH ; -- Lapse/cancel outstanding events on discharge
 D DISCH^ORMEVNT2 ;195 Code moved to ORMEVNT2 for space considerations
 Q
 ;
XTMP ; -- Save ORIFN to possibly reinstate on admission
 ;    Also uses ORVP, DGPMDA
 Q:'$G(DGPMDA)  Q:'$G(ORIFN)  Q:'$G(ORVP)
 N ORNOW S ORNOW=+$$NOW^XLFDT
 I $G(^XTMP("ORDCOBS-"_+ORVP,0)),+^(0)<ORNOW K ^XTMP("ORDCOBS-"_+ORVP)
 I '$G(^XTMP("ORDCOBS-"_+ORVP,0)) D
 . N ORNOW1H S ORNOW1H=$$FMADD^XLFDT(ORNOW,,1)
 . S ^XTMP("ORDCOBS-"_+ORVP,0)=ORNOW1H_U_ORNOW_"^InptMeds AutoDC'd on Discharge from Observation"
 S ^XTMP("ORDCOBS-"_+ORVP,+ORIFN)=$G(^OR(100,+ORIFN,4))
 S ^XTMP("ORDCOBS-"_+ORVP,"DISCHARGE")=DGPMDA
 Q
 ;
REINST ; -- Reinstate meds from observation
 I '$L($T(ENR^PSJOERI)) K ^XTMP("ORDCOBS-"_+ORVP) Q   ;DBIA 3598
 N ORIDT,ORLASTDC,X0,ORIFN,PSIFN
 S ORIDT=+$O(^DGPM("ATID3",+ORVP,0)) S:DGPMT=2 ORIDT=$O(^DGPM("ATID3",+ORVP,ORIDT)) Q:ORIDT<1  S ORLASTDC=+$O(^(ORIDT,0)) ;186 If reinstating for transfer TO ASIH then skip pseudo discharge for WHILE ASIH
 Q:$G(^XTMP("ORDCOBS-"_+ORVP,"DISCHARGE"))'=ORLASTDC  S X0=$G(^(0))
 I $P(X0,U)<$$NOW^XLFDT K ^XTMP("ORDCOBS-"_+ORVP) Q  ;readmit after one hour 177
 S ORIFN=0 F  S ORIFN=+$O(^XTMP("ORDCOBS-"_+ORVP,ORIFN))  Q:ORIFN<1  S PSIFN=$G(^(ORIFN)) D:PSIFN ENR^PSJOERI(+ORVP,PSIFN,+ORWARD)  ;DBIA 3598
 K ^XTMP("ORDCOBS-"_+ORVP)
 Q
 ;
 ; -- Moved code:
EXP(ORDER,ORSTOP) G EXP^ORMEVNT1
ACTIVE(ORDER,ORSTRT) G ACT^ORMEVNT1
PURGE(ORDER) G PUR^ORMEVNT1
