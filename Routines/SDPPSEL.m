SDPPSEL ;ALB/CAW - Specific selection and Date Range; 5/4/92
 ;;5.3;Scheduling;**6,20,28,32,79**;Aug 13, 1993
 ;
ASK ; Ask either stop code or clinic depending on DIC
 ;
 W !,"Do you want a specific "_$S(DIC=40.7:"stop code",DIC=44:"clinic",DIC=408.31:"means test")
 S %=2 D YN^DICN S:%=-1 SDERR=1 I %=0 D HELP G ASK
 Q:%'=1
ASK1 S DIC(0)="AEMQ",DIC("S")=$S(DIC=40.7:"I '$P(^(0),U,3)",DIC=44:"I $P(^(0),U,3)=""C"",'$G(^(""OOS""))",1:"")
 I DIC=408.31 D ASK2 S DIC(0)="EMQ",DIC("S")="I $P(^(0),U,2)=DFN"
 D ^DIC K DIC S:Y=-1 SDERR=1 S SDY=+Y
 Q
HELP ;
 W !,"Answer 'Y' for Yes or 'N' for No"
 Q
DATE ; Ask date range
 N SDBDPRE,SDEDPRE
 I $D(SDBD),$D(SDED) S SDBDPRE=SDBD,SDEDPRE=SDED
 K SDBD,SDED S SDT00="AEX" D DATE^SDUTL I '$D(SDED) K SDBD,BEGDATE,SDT00 S SDBEG=0,SDEND=9999999
 I $D(SDED) K SDBEG,SDEND
 I '$D(SDED) S SDBD=SDBDPRE,SDED=SDEDPRE D
 . W !,"Date Range has not been changed" H 1
 Q
ALL ;Ask whether user wants 'all'
 S SDACT=0,SDERR=0,%=2
 I SDFLG=4 W !,"Active enrollments only" S %=2 D YN^DICN S SDACT=$S(%=1:1,1:0) I %=0 D HELP G ALL
 S SDFLG=0
 I %=1 S SDBEG=0,SDEND=9999999,SDHDR=1 K VALMHDR
 K % Q
 Q
 ;
ASK2 ;Entry point to look-up a means test for a patient
 N X1
 W !,"Select ANNUAL MEANS TEST DATE OF TEST:  "
 R X:DTIME I '$T S DTOUT=1,Y=-1 G Q
 S:X["^" DUOUT=1 I X["^"!(X="") S Y=-1 G Q
 I X'["?" Q
 S X1=X
 D FULL^VALM1
 S X=X1,D="ADFN"_DFN,DIC(0)="Q" D IX^DIC K D
 G ASK2
Q Q
