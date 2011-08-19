ORMEVNT1 ;SLC/MKB-Trigger HL7 msg off OR events,ORMTIME ;9/9/03  13:00
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141,165,177,186,215**;Dec 17, 1997
 ;
 ;DBIA Section
 ; 3559 - Direct read of ^SRF
 ;10039 - Direct read of ^DIC(42,
 ;
OR2(ORSRDA) ;Queue EDO process to background, return control to surgery
 ;
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,ZTSAVE
 S ZTRTN="OR2Q^ORMEVNT1",ZTDTH=$H,ZTDESC="Surgery triggered EDO processing",ZTIO="",ZTSAVE("ORSRDA")="" D ^%ZTLOAD
 Q
 ;
OR2Q ; -- Kill logic, from Surgery package [DBIA #3558]
 I $D(^XTMP("ORSURG",ORSRDA)) D OR2(ORSRDA) Q  ;186 requeue if flag set
 N X,Y,DA,OREVT,ORSRF,ORACT
 S OREVT=+$O(^ORE(100.2,"ASR",+$G(ORSRDA),0)) Q:OREVT<1
 S ORSRF=$G(^SRF(+ORSRDA,.2)),ORACT=$S($L($P(ORSRF,U,12)):"ED",1:"DL")
 D ACTLOG^OREVNTX(OREVT,ORACT)
 Q
 ;
OR1(ORSRDA,ORSRX) ;Queue EDO process to background, return control to surgery
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,ZTSAVE
 S ZTRTN="OR1Q^ORMEVNT1",ZTDTH=$H,ZTDESC="Surgery triggered EDO processing",ZTIO="",ZTSAVE("ORSRDA")="",ZTSAVE("ORSRX")="" D ^%ZTLOAD
 Q
 ;
OR1Q ; -- Set logic, from Surgery package [DBIA #3558]
 I $D(^XTMP("ORSURG",ORSRDA)) D OR1(ORSRDA,ORSRX) Q  ;186 requeue if flag set
 N X S X=ORSRX
 I $G(^SRF(+$G(ORSRDA),"CON")),$D(^ORE(100.2,"ASR",+^("CON"))) Q  ;concurrent
 Q:$D(^ORE(100.2,"ASR",+$G(ORSRDA)))  Q:'$$CURRENT  ;edit
 ;
 N ORSR0,DFN,VAIP,VAERR,X,Y,DA,ORVP,ORL,ORDIV,ORTS,OREVENT,ORDCRULE,ORPRINT
 S ORSR0=$G(^SRF(+$G(ORSRDA),0)),DFN=+$P(ORSR0,U)
 D IN5^VADPT Q:'$G(VAIP(13))  ;not admitted
 S ^XTMP("ORSURG",ORSRDA)=$$FMADD^XLFDT(DT,5)_U_DT ;186 Set flag
 S ORL=$P($G(^SRS(+$P(ORSR0,U,2),0)),U)_";SC(",ORDIV=$$DIV(+ORL) ;DBIA #3362
 I '$G(LOC) S ORL=+$G(^DIC(42,+$G(VAIP(5)),44))_";SC(" ;186 If no O.R. loc then use current loc
 S ORTS=+$G(VAIP(8)) ; need surg spec too?  DBIA #991
 S ORVP=DFN_";DPT(",OREVENT=$$PATEVT,ORDCRULE=$$DCEVT
 D:ORDCRULE AUTODC(ORDCRULE,ORSRX) I OREVENT D
 . D RELEASE(OREVENT),DONE^OREVNTX(OREVENT,ORSRX,,ORSRDA)
 . D ACTLOG^OREVNTX(OREVENT,"NW","O")
 I $O(ORPRINT(0)),$G(ORL) D PRINTS^ORWD1(.ORPRINT,+ORL)
 K ^XTMP("ORSURG",ORSRDA) ;186
 Q
 ;
DIV(LOC) ; -- Return Institution file #4 ptr for LOC
 N X0,Y S X0=$G(^SC(+LOC,0))
 S Y=$S($P(X0,U,4):$P(X0,U,4),$P(X0,U,15):$$SITE^VASITE(DT,$P(X0,U,15)),1:+$G(DUZ(2)))
 Q Y
 ;
CURRENT() ; -- Is posted mvt the latest one?
 N Y S Y=$S((DT-X)<1:1,1:0)
 Q Y
 ;
PATEVT() ; -- Find match to new data in Patient Event file
 N EVT,IFN,X0,Y S EVT=0,Y=""
 F  S EVT=+$O(^ORE(100.2,"AE",+ORVP,EVT)) Q:EVT<1  S IFN=$O(^(EVT,0)) D  Q:Y
 . Q:$$LAPSED^OREVNTX(+IFN)  ;don't release orders
 . S X0=$G(^ORD(100.5,EVT,0))
 . I $P(X0,U,2)="O",$P(X0,U,3)=ORDIV S Y=+IFN Q
 Q Y
 ;
DCEVT() ; -- Find match to event in AutoDC Rules file for [new] ORDIV
 N Y I '$G(^DPT(+ORVP,.105)) Q 0 ;no auto-dc's if not admitted
 S Y=+$O(^ORD(100.6,"AE",ORDIV,"O",0))
 Q Y
 ;
AUTODC(ORDC,ORDT) ; -- DC orders based on rule ORDC [also from ORMEVNT]
 ;    Expects VAIP array with current admission data
 N ORADM,ORNOW,ORN,X,OREASON,ORNATR,ORCREATE,ORPRNT,ORSIG,ORDG,ORI,ORPKG,ORLIST,ORIFN,OR0,ORDER,ORERR
 S OREASON=+$P($G(^ORD(100.6,ORDC,0)),U,4) I OREASON<1 D
 . S OREASON=$S('$G(DGPMT):"OROR",DGPMT=1:"ORADMIT",DGPMT=2:"ORTRANS",DGPMT=3:"ORDIS",1:"ORSPEC")
 . S OREASON=+$O(^ORD(100.03,"C",OREASON,0))
 S ORNATR=+$P($G(^ORD(100.03,+$G(OREASON),0)),U,7)
 S:ORNATR'>0 ORNATR=+$O(^ORD(100.02,"C","A",0))
 S X=$G(^ORD(100.02,ORNATR,1)),ORCREATE=+$P(X,U),ORPRNT=+$P(X,U,2)
 S ORSIG=$S('ORCREATE:"",1:$P(X,U,4)),ORDG=$O(^ORD(100.98,"B","ALL",0))
 S ORI=0 F  S ORI=$O(^ORD(100.6,ORDC,7,"B",ORI)) Q:ORI<1  S ORPKG(ORI)=1
 D:$G(DGPMT)'=1 CHKOBS S:'$G(ORADM) ORADM=+$G(VAIP(13,1)) S ORNOW=$$NOW^XLFDT,ORN="A",ORI=6 ;177
 I $G(DGPMT)=1 S ORI=2,ORADM="",ORN="A"
 I $G(DGPMT)=3,"^12^38^"[(U_$P(DGPMA,U,18)_U) S ORI=2,ORADM="",ORN=""
 D EN^ORQ1(ORVP,ORDG,ORI,,ORADM,ORNOW),ADMORD S ORI=0
DC1 F  S ORI=$O(^TMP("ORR",$J,ORLIST,ORI)) Q:ORI'>0  S ORIFN=^(ORI) D
 . ;Q:$P(ORIFN,";",2)>1  ; or DC/Delete actions ??
 . Q:"^1^2^7^11^12^13^"[(U_$P(^OR(100,+ORIFN,3),U,3)_U)  S OR0=$G(^(0))
 . Q:'$G(ORPKG($P(OR0,U,14)))  Q:$D(^ORD(100.6,ORDC,10,"B",+$P(OR0,U,11)))
 . S X=+$$VALUE^ORX8(+ORIFN,"ORDERABLE") Q:$D(^ORD(100.6,ORDC,8,"B",X))
 . Q:'$$VALID^ORCACT0(ORIFN,"DC",,ORN)  ;ok to auto-dc order?
 . I '$G(OREVENT) S OREVENT=+$$NEW^OREVNT(+ORVP) ;no delayed orders
 . S ORDER=+ORIFN_$S(ORCREATE:";"_$$ACTION^ORCSAVE("DC",+ORIFN,$G(ORNP),,$G(ORDT)),1:"")
 . D EN^ORCSEND(ORDER,"DC",ORSIG,1,ORNATR,$G(OREASON),.ORERR) Q:$G(ORERR)
 . S $P(^OR(100,+ORIFN,6),U,8)=OREVENT D SAVE(ORIFN,OREVENT,3)
 . S:ORPRNT ORPRINT=$G(ORPRINT)+1,ORPRINT(ORPRINT)=ORDER_"^1"
DC2 I $G(OREVENT) D
 . S $P(^ORE(100.2,OREVENT,1),U,3)=ORDC,^ORE(100.2,"DC",ORDC,OREVENT)=""
 . I $G(DGPMDA),$D(^XTMP("ORDC-"_DGPMDA)) D XTMP ;save order#'s
 K ^TMP("ORR",$J,ORLIST),^XTMP("ORDC-"_$G(DGPMDA))
 Q
 ;
RELEASE(OREVT) ; -- release orders for OREVT [also from ORMEVNT]
 ;    Returns ORPRINT(#)=order^prints for orders released
 Q:'$G(OREVT)  N ORPARM,ORLR,ORX,ORI,ORV,ORIFN,ORERR,OR0,OR3,ORLAB
 S ORPARM="" I $G(ORL) F ORI="CHART COPY","LABELS","REQUISITIONS","SERVICE","WORK COPY" S ORX=$S(ORI="SERVICE":0,1:$$GET^XPAR("ALL^"_ORL,"ORPF PROMPT FOR "_ORI,1,"I")),ORPARM=ORPARM_U_$S(ORX="*":0,1:1)
 I $D(^XTMP("ORSURG",+$G(ORSRDA))) S ORL=+$G(^DIC(42,+$G(VAIP(5)),44))_";SC(" ;186 Reset loc
 F ORI="LR","VBEC" S ORX=+$O(^DIC(9.4,"C",ORI,0)) S:ORX ORLR(ORX)=1
 S ORX=OREVT,ORI=0
 F  S ORI=+$O(^ORE(100.2,"DAD",OREVT,ORI)) Q:ORI<1  S ORX=ORX_U_ORI
 F ORV=1:1:$L(ORX,U) S OREVT=$P(ORX,U,ORV) D  ;event[+children]
 . F  S ORI=$O(^OR(100,"AEVNT",ORVP,OREVT,ORI)) Q:ORI'>0  D
 .. S ORIFN=ORI,OR0=$G(^OR(100,ORIFN,0)),OR3=$G(^(3))
 .. I ORIFN=+$P($G(^ORE(100.2,OREVT,0)),U,4) D  Q  ;event order
 ... Q:$$TYPE^OREVNTX(OREVT)="D"  Q:$P(OR3,U,3)=11
 ... S ORPRINT=+$G(ORPRINT)+1,ORPRINT(ORPRINT)=ORIFN_";1"_ORPARM
 .. Q:$P(OR3,U,3)'=10  Q:$P(OR3,U,9)  ;released or cancelled, has parent
 .. S:$G(ORL) $P(^OR(100,ORIFN,0),U,10)=ORL ;set location
 .. S:$G(ORTS) $P(^OR(100,ORIFN,0),U,13)=ORTS ;set specialty
 .. I $G(ORLR(+$P(OR0,U,14))),'$G(ORLAB) D BHS^ORMBLD(ORVP) S ORLAB=1
 .. K ORERR D EN1^ORCSEND(ORIFN,.ORERR) Q:$G(ORERR)
 .. Q:"^10^11^"[(U_$P($G(^OR(100,ORIFN,3)),U,3)_U)  D SAVE(ORIFN,OREVT,2)
 .. S ORPRINT=+$G(ORPRINT)+1,ORPRINT(ORPRINT)=ORIFN_";1"_ORPARM
 D BTS^ORMBLD(ORVP):$G(ORLAB) ;send batch hdr/tlr segments for labs
 Q
 ;
ADMORD ; -- Add admission order to list
 ;    Uses VAIP(13),ORADM from AUTODC
 ;Q:$G(DGPMT)'=3
 I $G(DGPMT)=3 Q:"^12^38^"[(U_$P(DGPMA,U,18)_U)  ;already included
 N LAST,ADMEVT,IFN
 S LAST=+$O(^ORE(100.2,"ADT",+$G(VAIP(13)),""),-1),ADMEVT=+$O(^(LAST,0))
 S IFN=+$P($G(^ORE(100.2,ADMEVT,0)),U,4) Q:IFN<1
 I $P($G(^OR(100,IFN,8,1,0)),U,16)<ORADM D  ;add to auto-dc list
 . N ORI S ORI=+$O(^TMP("ORR",$J,ORLIST,"A"),-1),ORI=ORI+1
 . S ^TMP("ORR",$J,ORLIST,ORI)=IFN
 Q
 ;
XTMP ; -- Save auto-dc'd by package order numbers
 N ORDC,ORIFN,X Q:'$G(OREVENT)
 S ORDC="ORDC-"_$G(DGPMDA),ORIFN=0
 F  S ORIFN=+$O(^XTMP(ORDC,ORIFN)) Q:ORIFN<1  S X=$G(^(ORIFN)) D
 . D SAVE(ORIFN,OREVENT,3,X)
 . S $P(^OR(100,+ORIFN,6),U,8)=OREVENT
 Q
 ;
SAVE(IFN,EVT,NODE,PKG) ; -- Save order# IFN with EVT at NODE
 ;    NODE=2: Released orders, NODE=3: Auto-DC'd orders
 Q:'$G(IFN)!'$G(EVT)!'$G(NODE)  ;missing data
 Q:$D(^ORE(100.2,EVT,NODE,+IFN,0))  ;already saved
 N I,HDR,TOTAL
 F I=1:1:10 L +^ORE(100.2,EVT,NODE,0):1 Q:$T  H 2
 Q:'$T  S HDR=$G(^ORE(100.2,EVT,NODE,0))
 I '$L(HDR) S:NODE=2 HDR="^100.26PA^^" S:NODE=3 HDR="^100.27PA^^"
 Q:'$L(HDR)  S TOTAL=+$P(HDR,U,4),$P(HDR,U,3,4)=+IFN_U_(TOTAL+1)
 S ^ORE(100.2,EVT,NODE,0)=HDR L -^ORE(100.2,EVT,NODE,0)
 S ^ORE(100.2,EVT,NODE,+IFN,0)=+IFN_$S($D(PKG):U_PKG,1:"")
 Q
 ;
EXP ; -- expire an order from EXP^ORMEVNT(ORDER,ORSTOP)
 ;    [ORMTIME]
 G:'$D(^OR(100,+ORDER,0)) EXPQ
 N OR0,ORNMSP,ORSTS
 S OR0=$G(^OR(100,+ORDER,0)),ORSTS=$P($G(^(3)),U,3)
 I "^1^2^7^12^13^14^"[(U_ORSTS_U) G EXPQ ;done
 I $O(^OR(100,+ORDER,2,0)) G EXPQ ;parent
 I $P(^ORD(100.98,$P(OR0,U,11),0),U,3)="NV RX" G EXPQ  ;Non-VA med
 S ORNMSP=$$NMSP^ORCD($P(OR0,U,14))
 D:ORNMSP="PS"!(ORNMSP="FH") MSG^ORMBLD(+ORDER,"SS")
 I ORNMSP="OR"!(ORNMSP="FH"),"^1^7^"'[(U_ORSTS_U) D STATUS^ORCSAVE2(+ORDER,7) ;ck FH
EXPQ K ^OR(100,"AE",ORSTOP,ORDER)
 Q
 ;
ACT ; -- activate an order from ACTIVE^ORMEVNT(ORDER,ORSTRT)
 ;    [ORMTIME]
 G:'$D(^OR(100,+ORDER,0)) ACTQ
 N OR0,ORNMSP,ORSTS
 S OR0=$G(^OR(100,+ORDER,0)),ORSTS=$P($G(^(3)),U,3)
 I "^1^2^6^7^12^13^14^"[(U_ORSTS_U) G ACTQ ;done
 I $O(^OR(100,+ORDER,2,0)) G ACTQ ;parent
 S ORNMSP=$$NMSP^ORCD($P(OR0,U,14))
 D:ORNMSP="PS"!(ORNMSP="FH") MSG^ORMBLD(+ORDER,"SS")
 I ORNMSP="OR"!(ORNMSP="FH"),ORSTS=8 D STATUS^ORCSAVE2(+ORDER,6) ;ck FH
ACTQ K ^OR(100,"AD",ORSTRT,ORDER)
 Q
 ;
PUR ; -- purge an order
 ;    from PURGE^ORMEVNT(ORDER)
 N ORSTS,ORPK,ORNMSP,ORCHLD Q:'$D(^OR(100,ORDER))
 S ORSTS=$P($G(^OR(100,ORDER,3)),U,3),ORPK=$G(^(4)),ORNMSP=$P($G(^(0)),U,14),ORNMSP=$$NMSP^ORCD(ORNMSP)
 I '$L(ORPK)!(ORSTS=11)!(ORNMSP="OR")!(ORNMSP="LR"&('ORPK)) D DELETE^ORCSAVE2(ORDER) Q
 I '$D(^OR(100,ORDER,2)) D MSG^ORMBLD(ORDER,"Z@") Q
 S ORCHLD=0 F  S ORCHLD=$O(^OR(100,ORDER,2,ORCHLD)) Q:ORCHLD'>0  D MSG^ORMBLD(ORCHLD,"Z@")
 I '$O(^OR(100,ORDER,2,0)) D DELETE^ORCSAVE2(ORDER) ; delete parent
 Q
 ;
CHKOBS ;177, previous dx from obs?
 N INVDT,PDCDT,PDCMVT,CADMDT
 S CADMDT=+$G(VAIP(13,1)) Q:'CADMDT  ;Current admission d/t of movement
 S INVDT=9999999.9999999-(+VAIP(3)) ;Inverse date of movement
 S PDCDT=$O(^DGPM("ATID3",DFN,INVDT)) Q:'+PDCDT  ;No previous discharge
 S PDCMVT=$O(^DGPM("ATID3",DFN,PDCDT,0))
 Q:+$$MVT^DGPMOBS(PDCMVT)'=1  ;Quit if previous discharge not from obs
 N VAIP
 S VAIP("E")=PDCMVT
 D IN5^VADPT
 Q:'$G(VAIP(13))  ;No previous admission data
 Q:$$FMDIFF^XLFDT(CADMDT,+$G(VAIP(3)),2)>3600  ;Quit if previous discharge was more than 1 hour before admission
 S ORADM=+$G(VAIP(13,1))
 Q
