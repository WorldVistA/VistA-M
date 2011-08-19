DGMTSCU ;ALB/RMO/CAW,LBD - Means Test Screen Driver Utilities ;21 JAN 1992 8:00 pm
 ;;5.3;Registration;**456,688**;Aug 13, 1993;Build 29
 ;
SETUP ;Set-up the screen driver array and required screen variables
 ; Input  -- DFN              Patient IEN
 ;           DGMTDT           Date of Test
 ;           DGMTYPT          Type of Test
 ; Output -- DGMTSC           Screen Driver Array
 ;           DGVPRI           Veteran Patient Relation IEN
 ;           DGVINI           Veteran Individual Annual Income IEN
 ;           DGVIRI           Veteran Income Relation IEN
 ;           DGMTPAR          Annual Means Test Parameter Array
 ;           DGMTGMT          GMT Threshold Values
 ;           DGMTNWC          Net Worth Calculation flag
 ;           DGERR            1=ERROR and 0=NO ERROR
 N DGINI,DGIRI,DGLY,DGPRI,DGPRTY,DGSCR,I,X
 K DGMTSC S DGERR=0,DGLY=$$LYR^DGMTSCU1(DGMTDT)
 S DGSCR=$S(DGMTYPT=1:5,DGMTYPT=2&($$ASKNW^DGMTCOU):5,1:4)
 ;
 ;* Check version; IF pre 2005 form, call version 0 input
 I (+$P($G(^DGMT(408.31,DGMTI,2)),"^",11)=0) DO
 . F I=1:1 S X=$P($T(SCRNS+I),";;",2) Q:X="QUIT"!(+X=DGSCR)  S DGMTSC(+X)=X
 ;* Check version; IF Feb-2005 form, call version 1 input
 I (+$P($G(^DGMT(408.31,DGMTI,2)),"^",11)=1) DO
 . F I=1:1 S X=$P($T(SCRNS1+I),";;",2) Q:X="QUIT"!(+X=DGSCR)  S DGMTSC(+X)=X
 ;
 D NEW^DGRPEIS1 S:DGPRI'>0 DGERR=1 G Q:DGERR S DGVPRI=DGPRI
 D GETIENS^DGMTU2(DFN,DGPRI,DGMTDT) G Q:DGERR S DGVINI=DGINI,DGVIRI=DGIRI
 D PAR S:DGMTPAR="" DGERR=1
Q Q
 ;
PAR ;Annual Means Test Parameters
 ; Input  -- DGLY             Last Year
 ; Output -- DGMTPAR          Means Test Parameter 0th node
 ;           DGMTGMT          GMT Threshold values
 ;           DGMTNWC          Net Worth Calculation flag
 ;    Returned if the current year's parameters are not available:
 ;           DGMTPAR("PREV")  Previous Year Income Parameters
 N GMT
 S DGMTPAR=$S($D(^DG(43,1,"MT",DGLY+10000,0)):^(0),1:"")
 I DGMTPAR']"",$D(^DG(43,1,"MT",DGLY,0)) S DGMTPAR=^(0),DGMTPAR("PREV")=""
 ; Get Net Worth Calculation flag
 S DGMTNWC=+$G(^DG(43,1,"GMT"))
 ; Get GMT Threshold values for this veteran
 S DGMTGMT=""
 D GETFIPS^EASAILK(DFN,DGLY,.GMT)
 I '$G(GMT("GMTIEN")) Q
 S DGMTGMT=$G(^EAS(712.5,GMT("GMTIEN"),1))
 Q
 ;
HD ;Print screen header
 ; Input  -- DGMTSCI  Screen number
 ;           DGVPRI   Veteran Patient Relation IEN
 ;           DGMTDT   Date of Test
 ;           DGHLPF   Help Flag  (Optional)
 ; Output -- Screen Header
 N DGHDR,DGIOM,DGLNE,DGMTSCR,DGTAB,Y
 S:'$D(DGHLPF) DGHLPF=0
 S DGLNE="",DGIOM=$S('IOM:80,1:IOM),$P(DGLNE,"=",(DGIOM-1))=""
 S DGHDR=$P($$SCR(DGMTSCI),";",2)_", SCREEN <"_+$$SCR(DGMTSCI)_"> "_$S(DGHLPF:"HELP",1:"")
 S DGTAB=DGIOM-$L(DGHDR)\2
 S (DGVI,DGVO)="" I $S('$D(IOST(0)):1,'$D(^DG(43,1,0)):1,'$P(^DG(43,1,0),"^",36):1,$D(^DG(43,1,"TERM",IOST(0))):1,1:0) G HDNH ;goto HDNH if not high intensity
 S X="IOINHI;IOINLOW" D ENDR^%ZISS K X S DGVI=IOINHI,DGVO=IOINLOW S X=132 X ^%ZOSF("RM")
HDNH ;
 W @IOF W ?DGTAB,DGVI,DGHDR,DGVO
 I 'DGHLPF W !,$$NAME^DGMTU1(DGVPRI),"  ",$$SSN^DGMTU1(DGVPRI),?(DGIOM-24),"ANNUAL INCOME FOR " S Y=$$LYR^DGMTSCU1(DGMTDT) X ^DD("DD") W Y
 W !,DGLNE
 K DGHLPF Q
 ;
SCR(DGMTSCI) ;Screen name and number
 ;         Input  -- DGMTSCI  Screen number
 ;         Output -- Screen number;Screen name
 N DGMTSCR
 S DGMTSCR=$P($G(DGMTSC(DGMTSCI)),";",1,2)
 Q $G(DGMTSCR)
 ;
ROU(DGMTSCI) ;Screen entry routine
 ;         Input  -- DGMTSCI  Screen number
 ;         Output -- Routine name
 N DGROU
 S DGROU=$P($G(DGMTSC(DGMTSCI)),";",3)
 Q $G(DGROU)
 ;
ROURET(DGMTSCI) ;Screen read processor return routine
 ;         Input  -- DGMTSCI  Screen number
 ;         Output -- Routine name
 N DGROU
 S DGROU=$P($G(DGMTSC(DGMTSCI)),";",4)
 Q $G(DGROU)
 ;
 ;Version 0 screen processing
SCRNS ;Screen Number;Screen Name;Screen Entry Routine;Reader Return Routine
 ;;1;MARITAL STATUS/DEPENDENTS;EN^DGMTSC1;EN1^DGMTSC1
 ;;2;PREVIOUS CALENDAR YEAR GROSS INCOME;EN^DGMTSC2;EN1^DGMTSC2
 ;;3;DEDUCTIBLE EXPENSES;EN^DGMTSC3;EN1^DGMTSC3
 ;;4;PREVIOUS CALENDAR YEAR NET WORTH;EN^DGMTSC4;EN1^DGMTSC4
 ;;QUIT
 ;
 ;Version 1 screen processing
SCRNS1 ;Screen Number;Screen Name;Screen Entry Routine;Reader Return Routine
 ;;1;MARITAL STATUS/DEPENDENTS;EN^DGMTSC1;EN1^DGMTSC1
 ;;2;PREVIOUS CALENDAR YEAR GROSS INCOME;EN^DGMTSC2V;EN1^DGMTSC2V
 ;;3;DEDUCTIBLE EXPENSES;EN^DGMTSC3V;EN1^DGMTSC3V
 ;;4;PREVIOUS CALENDAR YEAR NET WORTH;EN^DGMTSC4V;EN1^DGMTSC4V
 ;;QUIT
