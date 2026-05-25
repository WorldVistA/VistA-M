PSOERPC0 ;BIRM/MFR - All Patients (Patient Centric) eRx Queue - ListManager ;09/28/22
 ;;7.0;OUTPATIENT PHARMACY;**700,750,746,770**;DEC 1997;Build 145
 ;
 ;Menu option entry point
 N MBMSITE,PSOSTFLT,PSOHDSTS,PSOCCRST,PSOSRTBY,PSORDER,PSOCSGRP,PSOLKBKD,PSOCSERX,PSOCSSCH,PSOCSGRP,PSOMAXQS
 N GRPLN,DIC,DFN,GRPLN,HIGHLN,LASTLINE,VALMCNT,PTMTCHLN,PRMTCHLN,DRMTCHLN,PATFLTR,VPATFLTR,DOBFLTR,MATFLTR,PSONEXTP
 N DIR,Y,DIRUT,DIROUT,CODE,DIRUT,DTOUT,PSOVIEW,PSOCSSCH,PSOCSERX,PSOQUIT,REDTFLTR,PRVFLTR,DRGFLTR,PSOJUMP
 N RESETLBD,PSOCLNC,PSORFRSH,IDX
 ;Initialization
 D INIT^PSOERPC2
 ;
 ;Division Selection
 I '$G(PSOSITE) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! G EXIT
 S PSNPINST=$$GET1^DIQ(59,PSOSITE,101,"I"),RESETLBD=1
 ;
 ;Clinic Selection (MbM Sites Only)
 S PSOCLNC=+$$GET1^DIQ(59,PSOSITE,10,"I")
 I $G(MBMSITE) D  I $G(PSOQUIT) G EXIT
 . W ! K DIC
 . S DIC(0)="AEMQ",DIC=44,DIC("S")="I '$P($G(^(""I"")),U,1)!$P($G(^(""I"")),U,2)"
 . S DIC("A")="eRx Clinic (Optional): "
 . I $G(PSOCLNC) S DIC("B")=$$GET1^DIQ(44,PSOCLNC,.01)
 . D ^DIC I Y="^"!$D(DTOUT)!$D(DUOUT) S PSOQUIT=1 Q
 . I $G(Y)>0 S PSOCLNC=+Y
 ;
 I '$$CHKKEY^PSOERX(DUZ) D  G EXIT
 . W !,"You do not have the appropriate key to access this option." S DIR(0)="E" D ^DIR K DIR
 ;
 D:'$D(PSOPAR) ^PSOLSET I '$D(PSOPAR) D MSG^PSODPT G EXIT
 D:'$D(PSOPINST) INST^PSOORFI2 I $G(PSOIQUIT) K PSOIQUIT G EXIT
 S PSNPINST=$$GET1^DIQ(59,PSOSITE,101,"I")
 I 'PSNPINST W !,"NPI Institution must be defined to continue." S DIR(0)="E" D ^DIR K DIR G EXIT
 ;
STS ; Status Selection Prompt
 K DIR S DIR(0)="SO^"
 I '$D(^XUSEC("PSO ERX WORKLOAD TECH",DUZ)) S DIR(0)=DIR(0)_"A:All;N:New;I:In Progress;W:Wait;"
 S DIR(0)=DIR(0)_"H:Hold;C:CCR;WP:Workload Processing"
 S DIR("B")=$S($D(^XUSEC("PSO ERX WORKLOAD TECH",DUZ)):"WP",1:"A")
 S DIR("?")=" "
 S IDX=0
 I '$D(^XUSEC("PSO ERX WORKLOAD TECH",DUZ)) D
 . S IDX=IDX+1,DIR("?",IDX)="     All - View all patients with actionable prescriptions"
 . S IDX=IDX+1,DIR("?",IDX)="     New - View patients with prescriptions in the 'NEW' status"
 . S IDX=IDX+1,DIR("?",IDX)="     In Process - View patients with prescriptions in the 'IN PROCESS' status"
 . S IDX=IDX+1,DIR("?",IDX)="     Wait - View patients with prescriptions in the 'WAIT' status"
 S IDX=IDX+1,DIR("?",IDX)="     Hold - View patients with prescriptions in the 'HOLD' status"
 S IDX=IDX+1,DIR("?",IDX)="     CCR - View patients with prescriptions in the 'CCR' status"
 S IDX=IDX+1,DIR("?",IDX)="     Workload Processing - Process New prescriptions for one patient at a"
 S IDX=IDX+1,DIR("?",IDX)="                           time using FIFO (First In First Out) method"
 D ^DIR I $D(DIRUT)!$D(DIROUT) G EXIT
 S PSOSTFLT=Y,PSOQUIT=0
 I PSOSTFLT="WP" D MATFLTR I '$G(MATFLTR) G STS
 I PSOSTFLT="H" D
 . K DIR S DIR(0)="SO^S:SINGLE CODE;A:ALL HOLD CODES",DIR("B")="A"
 . S DIR("?")=" ",DIR("?",1)="  Single code - Allows selection of a single hold code",DIR("?",2)="  All Hold Codes - Selects all available hold codes"
 . D ^DIR I $D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 . I Y="S" S PSOHDSTS=$P($$HLDSTS^PSOERPC1(),U) I PSOHDSTS="" S PSOQUIT=1 Q
 . I Y="A" S PSOHDSTS="ALL"
 I PSOSTFLT="C" D
 . K DIR S DIR("B")="A",DIR(0)="SO^S:SINGLE CODE;A:ALL CCR CODES"
 . S DIR("?")=" ",DIR("?",1)="  Single code - Allows selection of a single CCR code",DIR("?",2)="  All CCR Codes - Selects all available CCR codes"
 . D ^DIR I $D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 . I Y="S" S PSOCCRST=$P($$CCRSTS^PSOERPC1("RXN^RXD^RXR^RXE^RXF^RRE^CAO^CAH^CAP^CAR^CAX^CAF^CXD^CXN^CXV^CXY^CXE^CRE"),U) I PSOCCRST="" S PSOQUIT=1 Q
 . I Y="A" S PSOCCRST="ALL"
 I PSOQUIT G STS
 ;
EN ; - Entry point for the PC Action in the RX View
 ; Loading User's preferences
 D LOAD^PSOERPR0
 ;
 I PSOSTFLT="WP" D
 . D NEXTPAT
 E  W !,"Please wait..." D EN^VALM("PSO ERX ALL PATIENTS QUEUE")
 ;
 G EXIT
 ;
LMHDR ; ListMan Header Code
 D SHOW^VALM,HDR^PSOERPC0
 I $G(MBMSITE) S XQORM("B")="Next Screen"
 S XQORM("#")=$O(^ORD(101,"B","PSO ERX ALL PATIENTS SELECT",""))_"^1:"_VALMCNT
 S XQORM("??")="D HELP^VALM2,HDR^PSOERPC0"
 Q
 ;
HDR      ; - Builds the Header section
 D HDR^PSOERPC1
 Q
 ;
INIT ; - Populates the Body section for ListMan
 N LOCKPATS,PAT
 K ^TMP("PSOERPC0",$J),^TMP("PSOERPCS",$J),^TMP("PSOERPAT",$J)
 S PAT=0 F  S PAT=$O(^XTMP("PSOERXLOCK",PAT)) Q:'PAT  S LOCKPATS(PAT)=+$G(^XTMP("PSOERXLOCK",PAT))
 D SETSORT^PSOERPC1,SETLINE^PSOERPC2
 S:$G(VALMSG)="" VALMSG="Select the entry # to view or ?? for more actions"
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
LBD ; - Change Look Back Days Parameter Action
 D FULL^VALM1 S VALMBCK="R"
 W ! K DIR,DA,DIRUT,DIROUT,SAVEX
 S DIR(0)="52.351,1",DIR("B")=PSOLKBKD
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 S PSOLKBKD=Y,RESETLBD=0 D REF S VALMBG=1
 Q
 ;
SQ ; - Search Queue Entry Point
 D FULL^VALM1 S VALMBCK="R"
 N DIR,DUOUT,DIRUT,Y,X,ERXIEN,CHANGE,ERXPTIEN,PSOFPICK
 S CHANGE=0,IOINHI=$G(IOINHI),IOINORM=$G(IOINORM)
REP ; - Repeat Prompt for additional filters
 K DIR S DIR("?",1)="Choose one or multiple filter criteria(s) to sort the current list."
 S DIR("?",2)="To remove an existing filter type ^#, where '#' is filter number below."
 S DIR("?")=" "
 S DIR("A")="SEARCH BY"
 S DIR(0)="SO^1:ERX PATIENT" I $D(PATFLTR) S DIR(0)=DIR(0)_" "_IOINHI_"("_$$EPATFLST^PSOERUT(44)_")"_IOINORM
 S DIR(0)=DIR(0)_";2:ERX DATE OF BIRTH" I $G(DOBFLTR) S DIR(0)=DIR(0)_" "_IOINHI_"("_$$FMTE^XLFDT(DOBFLTR,"2Z")_")"_IOINORM
 S DIR(0)=DIR(0)_";3:ERX REFERENCE NUMBER"
 S DIR(0)=DIR(0)_";4:VISTA RX #"
 S DIR(0)=DIR(0)_";5:VISTA PATIENT" I $D(VPATFLTR) S DIR(0)=DIR(0)_" "_IOINHI_"("_$$VPATFLST^PSOERUT(44)_")"_IOINORM
 S DIR(0)=DIR(0)_";6:MATCH STATUS" I $G(MATFLTR) S DIR(0)=DIR(0)_" "_IOINHI_"("_$$MATCHLBL^PSOERPC2(MATFLTR)_")"_IOINORM
 W !!,$G(IOINHI),"NOTE: Only patients with actionable records are captured with this search.",IOINORM
 W !,IOINHI,"      Non-Actionable records can be searched through the SQ action under Rx",IOINORM
 W !,IOINHI,"      List View.",IOINORM
 D ^DIR
 I X'="^",X?1"^".N D  G REP
 . K:X="^1" PATFLTR,VPATFLTR K:X="^2" DOBFLTR K:X="^5" PATFLTR,VPATFLTR K:X="^6" MATFLTR
 . S CHANGE=1
 I $D(DUOUT)!($D(DIRUT)) D:CHANGE REF S:CHANGE VALMBG=1 Q
 S PSOFPICK=+$G(Y)
 I PSOFPICK=1 D EPATFLTR S CHANGE=1 G REP
 I PSOFPICK=2 D DOBFLTR S CHANGE=1 G REP
 I PSOFPICK=3 D ERXFLTR G:'$G(ERXFLTR) REP D  I '$G(CHANGE) Q
 . ; - Entering the eRx Record
 . D EN^PSOERX1(ERXFLTR)
 . ; - Unlocking the eRx Patient
 . S ERXPTIEN=$$GET1^DIQ(52.49,ERXFLTR,.04,"I") Q:'ERXPTIEN
 . D UL^PSOERX1A(ERXPTIEN)
 . S CHANGE=1
 I PSOFPICK=4 D RXFLTR G:'$G(ERXFLTR) REP D  I '$G(CHANGE) Q
 . ; - Entering the eRx Record
 . D EN^PSOERX1(ERXFLTR)
 . ; - Unlocking the eRx Patient
 . S ERXPTIEN=$$GET1^DIQ(52.49,ERXFLTR,.04,"I") Q:'ERXPTIEN
 . D UL^PSOERX1A(ERXPTIEN)
 . S CHANGE=1
 I PSOFPICK=5 D VPATFLTR S CHANGE=1 G REP
 I PSOFPICK=6 D MATFLTR S CHANGE=1 G REP
 D REF S VALMBG=1
 Q 
 ;
VPATFLTR ; - VistA Patient Filter
 N DIC,Y,EPAT,X K VPATFLTR
REP1 ; - Repeat VistA Patient Prompt
 K DIC,DIR W ! S DIC=2,DIC(0)="QEAM",DIC("A")="VISTA PATIENT: ",DIC("S")="I '$$DEAD^PSONVARP(Y)"
 I $G(MBMSITE) S DIC("W")="D PATIDS^PSOERPT1"
 D ^DPTLK I $G(Y)'>0 Q
 S VPATFLTR(+Y)="" K PATFLTR
 S EPAT=0 F  S EPAT=$O(^PS(52.49,"AVPAT",+Y,EPAT)) Q:'EPAT  D
 . S PATFLTR(EPAT)=""
 I '$O(PATFLTR(0)) D  K VPATFLTR G REP1
 . W !,IOINHI,"There are no eRx Patient(s) matched to this VistA Patient",IOINORM,$C(7)
 Q
 ;
EPATFLTR ; - eRx Patient Filter
 N DIR,PAT,XX,RANGE,COMSEG,I,J,RECDAT,DIRUT,DIROUT,QUIT
REP2 ; - Repeat eRx Patient Prompt
 K ^TMP($J,"PSOPTLST")
 S DIR(0)="F^3:30",DIR("A")="ERX PATIENT NAME"
 W ! D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 K PATLST D FIND^DIC(52.46,"","@;.01;.08;3.3;3.4;IX","",X,,"B","","",$NA(^TMP($J,"PSOPTLST")))
 I '$D(^TMP($J,"PSOPTLST","DILIST",2)) D  G REP2
 . W !,IOINHI,"No eRx Patient found",IOINORM,$C(7)
 I +$G(^TMP($J,"PSOPTLST","DILIST",0))>100 D  K ^TMP($J,"PSOPTLST") G REP2
 . W !!,IOINHI,"There are too many records to display, please narrow your search.",IOINORM,$C(7)
 ;
 D PATLHDR("E")
 S (QUIT,CNT)=0 K DIRUT,DTOUT
 S PAT="" F  S PAT=$O(^TMP($J,"PSOPTLST","DILIST","ID",PAT)) Q:'PAT  D  I QUIT Q
 . W !,PAT,".",?4,$E(^TMP($J,"PSOPTLST","DILIST","ID",PAT,.01),1,30)
 . I ^TMP($J,"PSOPTLST","DILIST","ID",PAT,.08)'="" D
 . . S X=^TMP($J,"PSOPTLST","DILIST","ID",PAT,.08) D ^%DT W ?35,$$FMTE^XLFDT(Y,"5Z")
 . I ^TMP($J,"PSOPTLST","DILIST","ID",PAT,3.3)'="" D
 . . W ?47,$E(^TMP($J,"PSOPTLST","DILIST","ID",PAT,3.3),1,20)_"-"_$$STATEABB^PSOERUT(52.46,^TMP($J,"PSOPTLST","DILIST",2,PAT))
 . S RECDAT=$O(^PS(52.49,"PAT2",^TMP($J,"PSOPTLST","DILIST",2,PAT),999999999),-1)
 . I RECDAT W ?71,$$FMTE^XLFDT(RECDAT\1,"2Z")
 . S CNT=CNT+1
 . I CNT>18,$O(^TMP($J,"PSOPTLST","DILIST","ID",PAT)),$Y>(IOSL-4) D
 . . K DIR S DIR(0)="E" D ^DIR I $D(DIRUT)!$D(DIROUT) S QUIT=1 Q
 . . W @IOF D PATLHDR("E")
 ;
 I CNT=1 K PATFLTR S PATFLTR(^TMP($J,"PSOPTLST","DILIST",2,1))="" K ^TMP($J,"PSOPTLST") Q
 ;
 K DIR S DIR("A")="SELECT (1-"_+$G(^TMP($J,"PSOPTLST","DILIST",0))_"): "
 S DIR(0)="LA^1:"_+$G(^TMP($J,"PSOPTLST","DILIST",0)) W ! D ^DIR I $D(DIRUT)!$D(DIROUT) G REP2
 S RANGE=X
 ;
 K PATFLTR
 F I=1:1:$L(RANGE,",") D
 . S COMSEG=$P(RANGE,",",I)
 . F J=+COMSEG:1:$S(COMSEG["-":$P(COMSEG,"-",2),1:+COMSEG) D
 . . I '$D(^TMP($J,"PSOPTLST","DILIST",2,J)) Q
 . . S PATFLTR(^TMP($J,"PSOPTLST","DILIST",2,J))=""
 K ^TMP($J,"PSOPTLST")
 Q
 ;
PATLHDR(PATTYP) ; - Prints the Patient List Header
 ;Input: Patient Type - "V": VistA Patient | "E": eRx Patient
 N XX W !?73,"LAST",!,"#",?4,$S(PATTYP="E":"ERX",1:"VISTA")_" PATIENT NAME",?35,"DOB",?47,"CITY",?71,"REC.DATE"
 S $P(XX,"-",80)="" W !,XX
 Q
 ;
DOBFLTR ; - DOB Filter
 N DIR,Y,X
 I $G(DOBFLTR) S DIR("B")=$$FMTE^XLFDT(DOBFLTR,"2Z")
 S DIR(0)="DA^:"_DT_":EX",DIR("A")="Date of Birth (DOB): "
 W ! D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 S DOBFLTR=Y
 Q
 ;
MATFLTR ; - Match Status Filter
 N DIR,Y,X
 S DIR("A")="MATCH STATUS"
 S DIR(0)="SO^1:"_$S($G(MBMSITE):"PATIENT FAIL - ",1:"")_"PATIENT NOT MATCHED"
 S DIR(0)=DIR(0)_";2:"_$S($G(MBMSITE):"PROVIDER FAIL - ",1:"")_"PROVIDER NOT MATCHED"
 S DIR(0)=DIR(0)_";3:"_$S($G(MBMSITE):"DRUG FAIL - ",1:"")_"DRUG NOT MATCHED"
 S DIR(0)=DIR(0)_";4:"_$S($G(MBMSITE):"BASIC - ",1:"")_"PATIENT, PROVIDER AND DRUG MATCHED"
 I $G(PSOSTFLT)="WP" S DIR(0)=DIR(0)_";5:ALL (NO FILTERS)",DIR("B")=5
 W ! D ^DIR I $D(DUOUT)!($D(DIRUT)) Q
 S MATFLTR=Y
 Q
 ;
ERXFLTR() ; - eRx ID Filter
 N DIC,Y,DTOUT,DUOUT,QUIT,ERXID,ERXPTIEN
 K ERXFLTR
 W ! S DIC="52.49",DIC(0)="QEA",DIC("A")="ERX REFERENCE NUMBER: "
 S QUIT=0
 F  D  Q:QUIT
 . D ^DIC I $D(DTOUT)!$D(DUOUT)!'Y!(X="") S QUIT=1 Q
 . S ERXID=+Y
 . I 'ERXID W !,"This prescription is not an eRx prescription." Q
 . I '$G(MBMSITE),$$GET1^DIQ(52.49,ERXID,24.1,"I")'=PSNPINST  D  Q
 . . W !!,"eRx belongs to a different Division: "_$$GET1^DIQ(52.49,ERXID,24.1),!,$C(7)
 . S ERXPTIEN=+$$GET1^DIQ(52.49,ERXID,.04,"I")
 . ; - Locking the eRx Patient
 . I '$$LOCK^PSOERPC1(ERXPTIEN) D  Q
 . . W !!,"The patient for this eRx is currently locked by "_$$GET1^DIQ(200,+$G(^XTMP("PSOERXLOCK",ERXPTIEN)),.01)_".",!,$C(7) H 1
 . S ERXFLTR=ERXID,QUIT=1
 Q
 ;
RXFLTR() ; - Rx # Filter
 N DIC,Y,DTOUT,DUOUT,QUIT,ERXID,ERXPTIEN
 K ERXFLTR
 W ! S DIC="52",DIC(0)="QEAM",DIC("A")="VISTA Rx #: "
 S QUIT=0
 F  D  Q:QUIT
 . D ^DIC I $D(DTOUT)!$D(DUOUT)!'Y!(X="") S QUIT=1 Q
 . S ERXID=$$ERXIEN^PSOERXUT(+Y)
 . I 'ERXID W !,"This prescription is not an eRx prescription." Q
 . I '$G(MBMSITE),$$GET1^DIQ(52.49,ERXID,24.1,"I")'=PSNPINST  D  Q
 . . W !!,"eRx belongs to a different Division: "_$$GET1^DIQ(52.49,ERXID,24.1),!,$C(7)
 . S ERXPTIEN=+$$GET1^DIQ(52.49,ERXID,.04,"I")
 . ; - Locking the eRx Patient
 . I '$$LOCK^PSOERPC1(ERXPTIEN) D  Q
 . . W !!,"The patient for this eRx is currently locked by "_$$GET1^DIQ(200,+$G(^XTMP("PSOERXLOCK",ERXPTIEN)),.01)_".",!,$C(7) H 1
 . S ERXFLTR=ERXID,QUIT=1
 Q
 ;
RF ; - Remove All Filters
 K PATFLTR,VPATFLTR,DOBFLTR,MATFLTR D REF S VALMBG=1
 Q
 ;
CS ; - Group/Un-group Controlled Substances
 S PSOCSGRP=$S($G(PSOCSGRP):0,1:1) D REF
 Q
 ;
CV ; - Change View
 D EN^PSOERPR0 I $G(PSORFRSH) D REF S VALMBG=1
 S VALMBCK="R"
 Q
 ;
SORT(FIELD) ; - Sort entries by FIELD
 I PSOSRTBY=FIELD S PSORDER=$S(PSORDER="A":"D",1:"A")
 E  S PSOSRTBY=FIELD,PSORDER="A"
 D REF
 Q
 ;
SEL ; - Process selection of one entry
 N PSOSEL,ERXPTIEN,TMPLKBKD
 S VALMBCK="R" K PSONEXTP
 S PSOSEL=+$P(XQORNOD(0),"=",2) I 'PSOSEL S VALMSG="Invalid selection!",VALMBCK="R" Q
 S ERXPTIEN=$G(^TMP("PSOERPC0",$J,PSOSEL,"PATIEN")) I 'ERXPTIEN S VALMSG="Invalid selection!",VALMBCK="R" Q
 ; - Locking the eRx Patient
 I '$$LOCK^PSOERPC1(ERXPTIEN) Q
 D  ; - Entering the Single Patient View (Protecting Preference Parameters)
 . N PSOSRTBY,PSORDER,PSOCSGRP,PSOALLST
 . S TMPLKBKD=PSOLKBKD D LST^PSOERPT0(ERXPTIEN)
 . I $G(RESETLBD) S PSOLKBKD=TMPLKBKD
 ; - Unlocking the eRx Patient
 D UL^PSOERX1A(ERXPTIEN)
 I $G(PSORFRSH) D REF
 Q
 ;
NEXTPAT  ; Automatically Selects the Next Patient
 N ERXPTIEN,NEXTPAT,PTLOCKED
 S VALMBCK="R",NEXTPAT=0,PTLOCKED=1
 ; - Locking the eRx Patient
 F  S ERXPTIEN=$$NEXTPAT^PSOERPC1(NEXTPAT) Q:'ERXPTIEN  Q:$$LOCK^PSOERPC1(ERXPTIEN)  S:$D(^XTMP("PSOERXWP",ERXPTIEN,DUZ)) PTLOCKED=0 Q:$D(^XTMP("PSOERXWP",ERXPTIEN,DUZ))  D
 . S NEXTPAT=ERXPTIEN I PSOSTFLT="WP" K ^XTMP("PSOERXWP",ERXPTIEN,DUZ)
 I 'ERXPTIEN Q
 I PSOSTFLT="WP",$D(^XUSEC("PSO ERX WORKLOAD TECH",DUZ)) S ^XTMP("PSOERXWP",ERXPTIEN,DUZ)=""
 D  ; - Entering the Single Patient View (Protecting Preference Parameters)
 . N PSOSRTBY,PSORDER,PSOCSGRP,PSOALLST
 . D LST^PSOERPT0(ERXPTIEN)
 ; - Unlocking the eRx Patient
 D:$G(PTLOCKED) UL^PSOERX1A(ERXPTIEN)
 Q
 ;
RX ; - Switch to Rx View
 D EN^PSOERRX0 S VALMBCK="Q"
 Q
 ;
REF ; - Screen Refresh
 W ?65,"Please wait..." D INIT,HDR,REVLOCKS^PSOERPC2 S VALMBCK="R"
 S PSORFRSH=0
 Q
 ;
EXIT ; - exit code
 K ^TMP("PSOERPC0",$J),^TMP("PSOERPCS",$J),^TMP("PSOERPAT",$J)
 D FULL^VALM1
 Q
