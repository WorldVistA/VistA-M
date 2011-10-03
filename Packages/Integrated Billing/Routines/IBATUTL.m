IBATUTL ;LL/ELZ - TRANSFER PRICING UTILITES ; 3-SEP-1998
 ;;2.0;INTEGRATED BILLING;**115,266,347,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
SL() ; -- called to select a patient or enrolled facility
 N X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DIR
 S DIR(0)="350.9,10.01",DIR("A")="Select Patient or Enrolled Facility"
 D ^DIR
 Q Y
SLPT() ; -- called to select a patient, returns 0 or patient dfn
 N X,Y,DIC,DTOUT,DUOUT
 S DIC="^IBAT(351.6,",DIC(0)="AEMQ" D ^DIC
 Q $S(+Y>0:+Y,1:0)
 ;
SLDR(Q) ; -- called to select a date range
 ; defaults are from=T-365, to=TODAY
 ; output IBBDT, IBEDT, quit returns 0 if not valid
 ;
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y,IBDT
 S DIR(0)="DA^:NOW:EX",DIR("A")="Select FROM DATE: "
 S:$D(Q) DIR("?")=Q
 D ^DIR G:'Y SLDRQ S IBDT=+Y
 S DIR(0)="DA^"_+Y_":NOW:EX",DIR("A")="              TO: "
 D ^DIR
 S:Y IBEDT=+Y+.999999,IBBDT=IBDT G SLDRQ
SLDR1Y() ; -- called to select a date range w/1y past default
 ; defaults are from=T-365, to=TODAY
 ; output IBBDT, IBEDT, quit returns 0 if not valid
 ;
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y,IBDT
 S DIR(0)="DA^:NOW:EX",DIR("A")="Select FROM DATE: "
 S DIR("B")=$$DAT2^IBOUTL($$FMADD^XLFDT(DT,-365)) D ^DIR
 G:'Y SLDRQ S IBDT=+Y
 S DIR(0)="DA^"_+Y_":NOW:EX",DIR("A")="              to: "
 S DIR("B")=$$DAT2^IBOUTL($$FMADD^XLFDT(IBDT,365)) D ^DIR
 G:'Y SLDRQ S IBEDT=+Y+.999999,IBBDT=IBDT
SLDRQ Q $D(DIRUT)!($D(DUOUT))
 ;
PTTRAN(IBFILE,IBARRAY,IBXREF) ; builds a list of patient transactions by date
 ; assumes DFN, IBBDT, IBEDT
 ; input IBARRAY - where to store info
 ;       IBXREF  - which date x-ref to use
 ; output 0,6 node of file IBFILE in array specified
 ;
 N IBIEN,IBDT,IBNODE
 K @IBARRAY
 S IBDT=IBBDT-.999999
 F  S IBDT=$O(^IBAT(IBFILE,IBXREF,DFN,IBDT)) Q:IBDT<1!(IBDT>IBEDT)  D
 . S IBIEN=0
 . F  S IBIEN=$O(^IBAT(IBFILE,IBXREF,DFN,IBDT,IBIEN)) Q:IBIEN<1  D
 .. F IBNODE=0,6 S @IBARRAY@(IBDT,IBIEN,IBNODE)=$G(^IBAT(IBFILE,IBIEN,IBNODE))
 Q
LMOPT ; -- called to do standard listmanager option calling
 D FULL^VALM1
 S VALMBCK="R"
 Q
 ;
SETVALM(LINE,TEXT,IEN,ON,OFF) ; -- sets up listmanager lines
 S LINE=LINE+1
 D SET^VALM10(LINE,TEXT,LINE)
 S:$G(IEN) @VALMAR@("INDEX",LINE,IEN)=""
 D:$G(ON)]""!($G(OFF)]"") CNTRL^VALM10(LINE,1,$L(TEXT),$G(ON),$G(OFF))
 W:'(LINE#5) "."
 Q LINE
 ;
VISN(STATION) ; -- looks up ien & name of VISN from ien of station
 N IBAT
 D PARENT^XUAF4("IBAT","`"_STATION,"VISN")
 S IBAT=0,IBAT=$O(IBAT("P",IBAT))
 Q $S(IBAT:IBAT_"^"_$P(IBAT("P",IBAT),"^"),1:"")
 ;
ONEFAC() ; returns one facility only, no visns allowed
 N DIC,DTOUT,DUOUT,X,Y
 S DIC="^DIC(4,",DIC(0)="AEMNQ"
 S DIC("S")="I $$SCR^IBATUTL(Y),$$INST^IBATUTL(Y)'[""VISN"""
 D ^DIC
 Q Y
FAC() ; -- facility/visn or all selection
 N DIC,X,Y,DTOUT,DUOUT K IBFAC
 S DIC="^DIC(4,",DIC(0)="EQMNZ"
 S DIC("S")="I $$SCR^IBATUTL(Y)"
REDO W !,"Select FACILITY/VISN: ALL// " R X:DTIME Q:(X["^")!'$T 1
 I X="?" W !,"Select a Facility (Name or Number), VISN (VISN XX), or press RETURN for ALL" G REDO
 I X=""!($$UP^XLFSTR(X)="ALL") Q 0
 D ^DIC G:Y<1 REDO D SET(Y)
 S DIC("A")="Select another FACILITY/VISN: ",DIC(0)="AEQMNZ"
 F  D ^DIC Q:X=""!(Y<1)  D SET(Y)
 Q 0
SET(Y) I Y'["VISN" N IBVISN D PARENT^XUAF4("IBVISN","`"_+Y,"VISN") D
 . S IBVISN=0,IBVISN=$O(IBVISN("P",IBVISN))
 . S IBFAC(IBVISN,"C",+Y)=$$INST(+Y)
 E  S IBFAC(+Y)="" D CHILDREN^XUAF4("IBFAC(+Y)","`"_+Y,"VISN")
 Q
SCR(X) ; screens invalid institution file entries
 N IBVISN
 ;Q:$P(X,".",2) 0
 D PARENT^XUAF4("IBVISN","`"_X,"VISN")
 S IBVISN=0,IBVISN=$O(IBVISN("P",IBVISN)) I IBVISN Q 1
 D CHILDREN^XUAF4("IBVISN","`"_X,"VISN")
 S IBVISN=0,IBVISN=$O(IBVISN("C",IBVISN)) I IBVISN Q 1
 Q 0
PPF(DFN) ; returns patient's enrolled/preferred facility
 N IBPPF
 ; first find current enrolment
 S IBPPF=+$$PREF^DGENPTA(DFN) ; dbia #2919
 ; now if they are already tp update if necessary
 I $D(^IBAT(351.6,DFN)),$P(^(DFN,0),"^",3)'=IBPPF D UPPPF^IBATFILE(DFN,IBPPF)
 ; now if they have an over ride facility use that
 Q $S($P($G(^IBAT(351.6,DFN,0)),"^",10):$P(^(0),"^",10),IBPPF=$$SITE:0,1:IBPPF)
TPP(DFN) ; returns dfn and files patient if a valid tp patient
 N IBSITE,IBPPF
 S IBSITE=$$SITE
 S IBPPF=$$PPF(DFN)
 I IBPPF,IBSITE'=IBPPF  S DFN=+$$PAT^IBATFILE(DFN,IBPPF)
 I DFN,$P($G(^IBAT(351.6,DFN,0)),"^",4) Q DFN
 Q 0
SITE() ; returns ien of current va site (this way I have only one outside call
 Q +$$SITE^VASITE
 ;
INST(DA) ; returns institution file info
 ; This will return the station name ^ station number ^ station type
 ; DA - The pointer value into file 4.
 I '$D(^DIC(4,DA,0)) Q 0
 Q $$NNT^XUAF4(DA)
IPT(X) ; returns institution file pointer from name
 Q $$LKUP^XUAF4(X)
PROC(X,IBDATE) ; -- returns CPT and descriptive name for cpts
 S X=$$CPT^ICPTCOD(X,$G(IBDATE))
 Q $P(X,"^",2,3)
COPAY(DFN,IBFROM,IBBDT,IBEDT) ; -- returns copay amount if any
 ; dfn=patient's dfn, from=what event the bill is from
 ; ibbdt & ibedt are date ranges (n/a for rx)
 N IBAMT,Y,Y1,IBDA,IBX S IBAMT=0
 I IBFROM["PSRX(" D  Q IBAMT
 . I $P(IBFROM,";",3)>0 D  Q
 .. ; refills
 .. S IBFROM=$$SUBFILE^IBRXUTL(+IBFROM,$P(IBFROM,";",3),52,9) I 'IBFROM Q
 .. S IBAMT=$P($G(^IB(IBFROM,0)),"^",7)
 . E  D  Q
 .. ; initial fill 
 .. S IBFROM=$$FILE^IBRXUTL(+IBFROM,106) I 'IBFROM Q
 .. S IBAMT=$P($G(^IB(IBFROM,0)),"^",7)
 ; now on to scheduling and admissions
 S Y="" F  S Y=$O(^IB("AFDT",DFN,Y)) Q:'Y  I -Y'>IBEDT S Y1=0 F  S Y1=$O(^IB("AFDT",DFN,Y,Y1)) Q:'Y1  D
 . S IBDA=0 F  S IBDA=$O(^IB("AF",Y1,IBDA)) Q:'IBDA  D
 .. Q:'$D(^IB(IBDA,0))  S IBX=^(0)
 .. Q:$P(IBX,"^",8)["ADMISSION"
 .. ;
 .. ; quit if not correct type (inpatient vs outpatient)
 .. Q:$S(IBFROM["SCE("&($P($P(IBX,"^",4),":")'=409.68):1,IBFROM["DGPM("&($P($P(IBX,"^",4),":")=409.68):1,1:0)
 .. ;
 .. I $P(IBX,"^",15)<IBBDT!($P(IBX,"^",14)>IBEDT) Q
 .. S IBAMT=IBAMT+$P(IBX,"^",7)
 Q IBAMT
FINDT(X) ; -- looks up transactions for source in X
 ; returns ien of 351.61 if not cancelled
 Q:$G(X)="" 0
 N Y,Z S (Y,Z)=0
 F  S Y=$O(^IBAT(351.61,"AD",X,Y)) Q:Y<1!(Z)  D
 . I $G(^IBAT(351.61,Y,0)),$P(^(0),"^",5)'="X" S Z=Y
 Q Z
 ;
PIN(P660,P6611) ; return Prosthetics Item Description (#661.1,.02)
 ; input:  P660 - pointer to Patient Item (#660) or P6611 - pointer to HCPCS (#661.1)
 ; return: pointer to HCPCS (#661.1) ^ Short Description (#661.1,.01) ^ HCPCS (#661.1,.01)
 N IBX,IBY S IBY=""
 I +$G(P660) S P6611=+$P($G(^RMPR(660,+P660,1)),U,4)
 I +$G(P6611) S IBX=$G(^RMPR(661.1,+P6611,0)) I IBX'="" S IBY=P6611_U_$P(IBX,U,2)_U_$P(IBX,U,1)
 Q IBY
 ;
EX(FILE,FIELD,VALUE) ; -- return external value
 N Y,C S Y=$G(VALUE)
 I +$G(FILE),+$G(FIELD),Y'="" S C=$P(^DD(FILE,FIELD,0),"^",2) D Y^DIQ
 Q Y
 ;
