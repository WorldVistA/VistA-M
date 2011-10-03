EASECSCR ;ALB/LBD - LTC Co-Pay Test Screen Read Processor;10 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,40**;Mar 15, 2001
 ;
 ;NOTE: This routine was modified from DGMTSCR for LTC Co-pay
 ; Input  -- DGRNG    Range of selectable items
 ;           DGMTACT  Means Test Action
 ;           DGMTSC   Screen Driver Array
 ;           DGMTSCI  Screen number
 ;           DGVINI   Veteran Individual Annual Income IEN
 ;           DGVIRI   Veteran Income Relation IEN
 ; Output -- DGDR     Template tags  (ie, 101,102,103,104)
 ;           DGX      User input - maybe modified (ie, 1-4) 
 ;           DGY      Items selected in expanded form  (ie, 1,2,3,4)
 ;    Returned for screen 2 and 4:
 ;           DGSEL    Column selections available  (ie, V, S, C)
 ;           DGSELTY  User input - column selected  (ie, V or S or C)
 ;
EN K DGDR,DGSEL,DGSELTY,DGX,DGY,I D FEED
 I $G(DGSCR1) S X="" G EN1
 W !,DGVI,"<RET>",DGVO," to CONTINUE," W:DGMTACT'="VEW" " ",DGVI,DGRNG,DGVO," or ",DGVI,"'ALL' ",DGVO,"to EDIT," W DGVI," ^N",DGVO," for screen N, or ",DGVI,"'^'",DGVO," to EXIT: " R X:DTIME S:'$T X="^"
EN1 K DGSCR1 S DGX=$$UPPER^DGUTL(X)
 I DGX="^" G Q^EASECSC
 I DGX?1"^".N,$D(DGMTSC(+$P(DGX,"^",2))) G @($$ROU^EASECSCU(+$P(DGX,"^",2)))
 ; Modified next line to allow entry of assets for spouse (only for new
 ; 10-10EC form).  Added for LTC Phase IV (EAS*1*40)
 I DGMTACT'="VEW",(DGMTSCI=5!($G(DGFORM)&(DGMTSCI=4))) D SEL I DGSEL[$E(DGX),$E(DGX,2)?1N S DGSELTY=$E(DGX),DGX=$P(DGX,DGSELTY,2)
 I DGMTACT'="VEW",$E(DGX)="A" S X=DGX,Z="^ALL" D IN^DGHELP S:%'=-1 DGX=DGRNG
 I DGX["?" D HLP G Q^EASECSC:$D(DTOUT)!($D(DUOUT)),@($$ROU^EASECSCU(DGMTSCI))
 I DGX="",$O(DGMTSC(DGMTSCI)) G @($$ROU^EASECSCU($O(DGMTSC(DGMTSCI))))
 I DGX="" G Q^EASECSC
 I DGMTACT'="VEW" D PRO I $D(DGSELTY) S DGX=DGSELTY_DGX
 S:DGMTACT="VEW" DGERR=1 I DGERR D HLP G @($$ROU^EASECSCU(DGMTSCI))
Q G @($$ROURET^EASECSCU(DGMTSCI))
 ;
FEED ;Line feed to the bottom of the screen
 N DGB,I
 S DGB=$S('IOSL:24,1:IOSL)-5 F I=$Y:1:DGB W !
 Q
 ;
SEL ;Check available column selections for Veteran, Spouse or Children
 N DGDC,DGNC,DGND,DGSP,DGVIR0,DGX
 D DEP^EASECSU3
 S DGSEL="V"_$S(DGSP:"S",1:"")
SELQ Q
 ;
HLP ;Help display
 N DGIOM,DGLNE,DGMTSCR,DIR,I,X
 S DGHLPF=1 D HD^EASECSCU
 W !!,"Enter <RET> to continue to the next available screen."
 I DGMTACT'="VEW" W !,"Enter an available item number from ",DGRNG," to edit.",!,"The items should be separated by commas or a range of numbers",!,"separated by a dash, or a combination of commas and dashes."
 ;Modified next line to add screen 4 for LTC Phase IV (EAS*1*40)
 I DGMTACT'="VEW","^4^5^"[(U_DGMTSCI_U),$D(DGSEL) W !,"To edit a specific column, enter 'V'",$S(DGSEL["S":", 'S'",1:"")," in front of the selected items."
 I DGMTACT'="VEW" W !,"Enter 'ALL' to edit all available items on the screen."
 W !,"Enter '^N' to jump to a select screen.  Enter '^' to exit."
 W !!,"AVAILABLE SCREENS"
 S I=0 F  S I=$O(DGMTSC(I)) Q:'I  W !,"[",+$$SCR^EASECSCU(I),"]  ",$P($$SCR^EASECSCU(I),";",2)
 S DGLNE="",DGIOM=$S('IOM:80,1:IOM),$P(DGLNE,"=",(DGIOM-1))=""
 W !,DGLNE S DIR(0)="E" D ^DIR
 Q
 ;
PRO ;Process user selection; cnt - dash - parse - selection
 N DGC,DGD,DGP,DGS
 S DGC=0,DGERR=0,DGY="",DGDR=""
PARSE S DGC=DGC+1,DGP=$P(DGX,",",DGC) G PROQ:DGP=""
 I DGP?.N1"-".N S DGD="" F DGS=$P(DGP,"-"):1:$P(DGP,"-",2) D CHK Q:DGERR
 I '$D(DGD) S DGS=DGP D CHK
 K DGD G PROQ:DGERR,PARSE
PROQ Q
 ;
CHK I $D(DGD),+$P(DGP,"-",2)<+$P(DGP,"-",1) S DGERR=1
 I 'DGERR,DGS'?.N S DGERR=1
 I 'DGERR&(DGS>$P(DGRNG,"-",2)!(DGS<$P(DGRNG,"-"))) S DGERR=1
 I 'DGERR S DGY=DGY_$S($L(DGY):",",1:"")_DGS,DGDR=DGDR_$S($L(DGDR):",",1:"")_(DGS+100)
 Q
