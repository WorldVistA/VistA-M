EASECSC ;ALB/LBD - LTC Co-Pay Test Screen Driver ;10 AUG 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7**;Mar 15, 2001
 ;
 ;A series of screens used to collect the LTC Co-pay Test data
 ; Input  -- DFN      Patient IEN
 ;           DGMTACT  Menu Action  (ie, ADD to Add a New Test)
 ;           DGMTDT   Date of Test
 ;           DGMTI    Annual Means Test IEN
 ;           DGMTYPT  Type of Test 3=LTC COPAY
 ;           DGMTROU  Option Routine Return
 ; Output -- None
 ;NOTE: This routine was modified from DGMTSC for LTC Co-pay
 ;
EN ;Entry point for LTC co-pay test screen driver
 D HOME^%ZIS,SETUP^EASECSCU I DGERR D MG G Q1
EN1 ;Entry point to edit LTC co-pay test if incomplete
 S DGMTSCI=+$O(DGMTSC(0)) G @($$ROU^EASECSCU(DGMTSCI))
 ;
Q I DGMTACT'="VEW" D:$G(DGX)'="^" EN^EASECSCC I DGERR G EN1:$$EDT
Q1 ;
 K %,DGBL,DGDC,DGDEP,DGDR,DGFCOL,DGFL,DGMT0,DGMTA,DGMTINF,DGMTOUT,DGMTP,DGMTPAR,DGMTSC,DGMTSCI,DGREL,DGRNG,DGRPPR,DGSCOL,DGSEL,DGSELTY,DGVI,DGVINI,DGVIRI,DGVO,DGVPRI,DGX,DGY,DTOUT,DUOUT,Y,Z
 ;
 ;Update the TEST-DETERMINED STATUS field (#2.03) in the ANNUAL MEANS
 ;TEST file (408.31) when adding a means or copay test, completing a 
 ;means test, or editing a means or copay test.
 ;I "ADDCOMEDT"[DGMTACT D SAVESTAT^DGMTU4(DGMTI,DGERR)
 K DGERR
 ;
 G @(DGMTROU)
 ;
MG ;Print set-up error messages
 I $D(DGVPRI),DGVPRI'>0 W !!?3,"Patient Relation cannot be setup for patient."
 I $D(DGVINI),DGVINI'>0 W !!?3,"Individual Annual Income cannot be setup for patient."
 ;I $D(DGMTPAR),DGMTPAR']"",DGMTYPT=1 W !!?3,"Means Test Thresholds are not defined."
 W !?3,*7,"Please contact your site manager."
 Q
 ;
EDT() ;Edit means/copay test if incomplete
 N DIR,Y
 S DIR("A")="Do you wish to edit the LTC copay test"
 S DIR("B")="YES",DIR(0)="Y" D ^DIR
 Q +$G(Y)
