DGMTCOU ;ALB/CAW - Copay Utilities ; 12/10/92
 ;;5.3;Registration;**45,182**;Aug 13, 1993
 ;
EDT(DFN,DGDT) ;Display patients current copay test information and provide
 ;        the user with the option of proceeding with adding a
 ;        copay test or editing an existing copay test
 ;         Input  -- DFN    Patient IEN
 ;                   DGDT   Date/Time
 ;         Output -- None
 ;
 ;
 N DGMTERR,SOURCE,DGMTYPT
 S DGMTYPT=2
 ;
 ; obtain lock used to synchronize local MT/CT options with income test upload
 I $$LOCK^DGMTUTL(DFN)
 ;
 S DGMTI=+$$LST^DGMTU(DFN,DGDT,2)
 S DGMT0=$G(^DGMT(408.31,DGMTI,0)),DGMTDT=+DGMT0 S DGMTS=$P(DGMT0,"^",3)
 I $$YR(DFN,DGDT,+DGMT0) S DGMTS=""
 G:$P($$RXST^IBARXEU(DFN,DT),U,3)=2010&('$$YR(DFN,DT,DGMTI)) EDTQ D DISP^IBARXEU(DFN,DGDT,2) W !
 ;
 ;If test is uneditable, print error message and allow user to view test
 S SOURCE=$P($G(^DGMT(408.31,DGMTI,0)),U,23)
 I SOURCE,'$P($G(^DG(408.34,SOURCE,0)),U,2) D  D:$G(DGMTERR) DISPLAY^DGMTU23(DGMTI,2),PAUSE^DGMTE G EDTQ
 .W !,"The source of this test makes the test uneditable."
 .S DIR("A")="Would you like to view the copay test",DIR("B")="NO",DIR(0)="Y"
 .D ^DIR K DIR S DGMTERR=Y I $D(DTOUT)!($D(DUOUT)) K DGMTERR,DTOUT,DUOUT
 ;
 S DIR("A")="Do you wish to "_$S(DGMTS="":"add a",1:"edit the")_" copay test at this time"
 S DIR("B")=$S(DGMTS=10:"YES",1:"NO"),DIR(0)="Y"
 W ! D ^DIR G EDTQ:$D(DTOUT)!($D(DUOUT))
 I Y,DGMTS]"" S DGMTYPT=2,DGMTACT="EDT",DGMTROU="EDTQ^DGMTCOU" G EN^DGMTSC
 I Y,DGMTS="" S DGMTYPT=2,DGMTACT="ADD",DGMTROU="EDTQ^DGMTCOU" S DGMTDT=DT D ADD^DGMTA G EN^DGMTSC
EDTQ K DGMT0,DGMTACT,DGMTDT,DGMTI,DGMTROU,DGMTS,DIR,Y
 ;
 ; release lock used to synchronize local MT/CT options with income test upload
 D UNLOCK^DGMTUTL(DFN)
 Q
 ;
YR(DFN,DGDT,DGMT0) ;Check to see if test is greater than 365 days
 ;        Input  -- DFN     Patient IEN
 ;                  DGDT    Date/Time to check against
 ;                 DGMT0    Zeroth node of Copay test
 ;        Output -- 1 = TEST IS 365 OR MORE DAYS OLD
 ;                  0 = TEST IS LESS THAN 365 DAYS OLD
 ;
 N X,X1,X2,DGLDYR,DGY S DGY=1
 S DGLDYR=$E(DGMT0,1,3)_"1231"
 I DGMTI S X1=DGDT,X2=$P(DGMT0,U,2) D ^%DTC I X<365,DGDT'>DGLDYR S DGY=0
 Q DGY
 ;
ON ; Check to see of copay software is on
 ;    Input - none
 ;   Output - 1 = YES
 ;            0 = NO
 I $P(^DG(43,1,0),U,41) S Y=1 Q
 S Y=0
 Q
ASKNW() ;
 Q 0
