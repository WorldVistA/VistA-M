YSSR2 ;SLC/DJP-SECLUSION/RESTRAINT - Management Utilities ; 10/18/88  17:40 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
ENEDIT ; Called from MENU option YSSR EDIT
 ;
 ; Permits editing of Seclusion/Restraint Entry
 S DIC="^YS(615.2,",DIC(0)="AEQLM",DLAYGO=615,D="C",DIC("A")="Select PATIENT NAME:  " D IX^DIC K DIC("A"),D S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) I YSTOUT!YSUOUT D END^YSSR Q
 I Y<0 W !?10,"Patient not shown on file." D END^YSSR Q
 S DIE=DIC,DA=+Y,DR=".03:3;5:27;30" L +^YS(615.2,DA) D ^DIE L -^YS(615.2,DA) S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) I YSTOUT!YSUOUT D END^YSSR Q
 L +^YS(615.2,DA)
 I $D(^YS(615.2,DA,40)) S DR="40:42;45" D ^DIE
 I $D(^YS(615.2,DA,50)) S DR="50:52;55" D ^DIE
 I $D(^YS(615.2,DA,60)) S DR=60 D ^DIE
 L -^YS(615.2,DA) D END^YSSR
 Q
 ;
ENTRYD ; Called from MENU option YSSR DELETE
 ;
 ; Permit deletion of an entire Seclusion/Restraint Entry.
 S DIC="^YS(615.2,",DIC(0)="AEQLM",DLAYGO=615,D="C",DIC("A")="Select PATIENT NAME:  " D IX^DIC K DIC("A"),D S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) I YSTOUT!YSUOUT D END^YSSR Q
 I Y<0 W !?10,"Patient not shown on file." D END^YSSR Q
 W @IOF S (FN,DA,YSDA)=+Y,DR=".01:60",S=0 D EN^DIQ
QUES ;
 W !!,"Is this the entry you wish to delete" S %=2 D YN^DICN S YSTOUT=$D(DTOUT),YSUOUT=$D(DUOUT) I YSTOUT!YSUOUT D END^YSSR Q
 I %=0 W !!,"YES will remove the entry from the file.  It will not be recoverable.",!,"NO will exit you from this option.  Entry will remain on file.",! G QUES
 I %=1 S W1=$P(^YS(615.2,DA,0),U,2),W2=^DPT(W1,0),(YSNM,W3)=$P(W2,U),FN=DA D DELETE^YSSR
 D END^YSSR
 Q
 ;
KILLALL ;This sub routine is an exit action to be called from the following
 ;'YSSR*' Seclusion/Restraint options.
 K %DT,A,B,B1,D,D0,DIK,DIQ,DIS,DLAYGO,DTOUT,DUOUT,FN,JRBY,JRBYN,JRVAR
 K K,L,MSG1,QRVN,RVN,RVNM,RVP,S,SSN,W1,W2,W3,X1,XQY
 K YS02,YSA1,YSDA,YSDFN,YSDX,YSI,YSN,YSNM,YSWN
 QUIT
 ;
EOR ;YSSR2 -  SECLUSION/RESTRAINT - Management Utilities ; 10/18/88  17:40 ;
