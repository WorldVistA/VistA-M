EASECSCU ;ALB/LBD - LTC Co-Pay Test Screen Driver Utilities ;10 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,40**;Mar 15, 2001
 ;
 ;NOTE: This routine was modified from DGMTSCU for LTC Co-pay
SETUP ;Set-up the screen driver array and required screen variables
 ; Input  -- DFN              Patient IEN
 ;           DGMTDT           Date of Test
 ;           DGMTYPT          Type of Test
 ; Output -- DGMTSC           Screen Driver Array
 ;           DGVPRI           Veteran Patient Relation IEN
 ;           DGVINI           Veteran Individual Annual Income IEN
 ;           DGVIRI           Veteran Income Relation IEN
 ;           DGMTPAR          Annual Means Test Parameter Array
 ;           DGFORM           10-10EC Form (1=Revised; 0=Original)
 ;           DGERR            1=ERROR and 0=NO ERROR
 N DGINI,DGIRI,DGLY,DGPRI,DGPRTY,DGSCR,I,X
 K DGMTSC S DGERR=0,DGLY=$$LYR^DGMTSCU1(DGMTDT)
 F I=1:1 S X=$P($T(SCRNS+I),";;",2) Q:X="QUIT"  S DGMTSC(+X)=X
 D NEW^EASECED1 S:DGPRI'>0 DGERR=1 G Q:DGERR S DGVPRI=DGPRI
 D GETIENS^EASECU2(DFN,DGPRI,DGMTDT) G Q:DGERR S DGVINI=DGINI,DGVIRI=DGIRI
 D PAR S:DGMTPAR="" DGERR=1
 ; Set DGFORM to indicate which 10-10EC form was used to complete
 ; the LTC copay test.  If DGFORM=1 the revised format will be used
 ; for the LTC copay test screens, otherwise the original format is
 ; used. Added for LTC IV (EAS*1*40).
 S DGFORM=$$FORM^EASECU($G(DGMTI))
Q Q
 ;
PAR ;Annual Means Test Parameters
 ; Input  -- DGLY             Last Year
 ; Output -- DGMTPAR          Means Test Parameter 0th node
 ;    Returned if the current year's parameters are not available:
 ;           DGMTPAR("PREV")  Previous Year Income Parameters
 S DGMTPAR=$S($D(^DG(43,1,"MT",DGLY+10000,0)):^(0),1:"")
 I DGMTPAR']"",$D(^DG(43,1,"MT",DGLY,0)) S DGMTPAR=^(0),DGMTPAR("PREV")=""
 Q
 ;
HD ;Print screen header
 ; Input  -- DGMTSCI  Screen number
 ;           DGVPRI   Veteran Patient Relation IEN
 ;           DGMTDT   Date of Test
 ;           DGHLPF   Help Flag  (Optional)
 ; Output -- Screen Header
 N DGHDR,DGIOM,DGLNE,DGMTSCR,DGTAB,Y,IOINHI,IOINLOW
 S:'$D(DGHLPF) DGHLPF=0
 S DGLNE="",DGIOM=$S('IOM:80,1:IOM),$P(DGLNE,"=",(DGIOM-1))=""
 S DGHDR=$P($$SCR(DGMTSCI),";",2)_", SCREEN <"_+$$SCR(DGMTSCI)_"> "_$S(DGHLPF:"HELP",1:"")
 S DGTAB=DGIOM-$L(DGHDR)\2
 S (DGVI,DGVO)="" I $S('$D(IOST(0)):1,'$D(^DG(43,1,0)):1,'$P(^DG(43,1,0),"^",36):1,$D(^DG(43,1,"TERM",IOST(0))):1,1:0) G HDNH ;goto HDNH if not high intensity
 S X="IOINHI;IOINLOW" D ENDR^%ZISS K X S DGVI=IOINHI,DGVO=IOINLOW S X=132 X ^%ZOSF("RM")
HDNH ;
 W @IOF W ?DGTAB,DGVI,DGHDR,DGVO
 I 'DGHLPF W !,$$NAME^DGMTU1(DGVPRI),"  ",$$SSN^DGMTU1(DGVPRI),?(DGIOM-26),"LTC COPAY TEST FOR " S Y=$E(DGMTDT,1,3)_"0000" X ^DD("DD") W Y
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
SCRNS ;Screen Number;Screen Name;Screen Entry Routine;Reader Return Routine
 ;;1;MILITARY SERVICE DATA;EN^EASECSC1;EN1^EASECSC1
 ;;2;INSURANCE DATA;EN^EASECSC2;EN1^EASECSC2
 ;;3;MARITAL STATUS/DEPENDENTS;EN^EASECSC3;EN1^EASECSC3
 ;;4;FIXED AND LIQUID ASSETS;EN^EASECSC4;EN1^EASECSC4
 ;;5;CURRENT CALENDAR YEAR GROSS INCOME;EN^EASECSC5;EN1^EASECSC5
 ;;6;DEDUCTIBLE EXPENSES;EN^EASECSC6;EN1^EASECSC6
 ;;QUIT
