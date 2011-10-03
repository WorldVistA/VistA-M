LRAR06 ;DALLAS/HOAK CUME ARCHIVE INITIATIVE part of 00 ; 12/12/96  10:16 ;
 ;;5.2;LAB SERVICE;**111**;Sep 27, 1994
INIT ;
RESTART ;
 W !,"Search not complete." L +^LAR:1
 I '$T W !,"Searching in progress, please wait for it to finish." G QUIT
 L -^LAR
 W !,"Do you want to restart the search"
 S %=1 D YN^DICN
 I %'=1 W:%=0 !,"Continue where the last search stopped." G RESTART:%=0,QUIT
 ;
 D DEV^LRAR01
 G QUIT:POP S LRDFN=$S($D(^LAB(69.9,1,"LRDFN")):^("LRDFN"),1:0)
 D STEPOUT^LRARCHIV QUIT
TAPE ;
 S DA=0,DIC="^LAB(69.9,1,6,"
 S DIC("A")="Please enter a name for the archive session: "
 S DIC(0)="AEMQL"
 S DLAYGO=69 D ^DIC
 K DLAYGO Q:Y<1
 S LRDA9=+Y
 I '$P(Y,U,3) W !,"You must create a NEW name for this ARCHIVE." G TAPE
DT ;
 S OK=1
SET S DIR(0)="S^1:CH Subcript only;2:Micro Only;3:Both CH and Micro"
 S DIR("??")="Enter 1 for CH subscripted. Micro will be with next patch"
 S DIR("?")="Please enter a number 1"
 S DIR("A")="What lab section do you wish to Search"
 S DIR("B")="1"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S OK=0 S DA=-1
 Q:'OK
 ;S LRWHICH=$S(Y=1:"CH",Y=2:"MI",1:"BOTH") ;--NEXT PATCH
 S LRWHICH="CH"
 ;
 K DIR
 ;
 S DIR(0)="D",DIR("A")="Archive Start DATE: "
 S DIR("?")="Enter a date in the past where I should begin looking."
 S DIR("B")="T-90"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S OK=0 S DA=-1
 S LR(1)=+Y
 Q:'OK
 S DA=LRDA9
 Q:'$G(DA)
 S P1=DA,DIE=DIC,DR="1;2///N;4///"_LR(1)
 D ^DIE
 K DIC
 ;QUIT
 ;
 K DIR
 ;
TIME ;
 ;--> Maximize user interaction.
 S OK=1
 I '$G(LR(1)) S LR(1)=DT
 S DIR(0)="S^1:Number of days;2:Date Range;3:By the month;4:Quarterly;5:By the year"
 S DIR("?")="Enter 1 for days to archive ie 1,7,30,60,90 etc"
 S DIR("?",1)="Enter 2 for Patients results between a date range."
 S DIR("?",2)="Enter 3 for a specific month and year...11/97"
 S DIR("?",3)="Enter 4 ... 1/97 for Jan-Feb-Mar of 1997 or 2/97 for Apr-May-June of 1997 etc"
 S DIR("?",4)="Enter 5 year 1996 gets you all of 1996"
 S DIR("B")="1"
 D ^DIR
 I $D(DUOUT)!($D(DTOUT))!(+Y'>0) W !!,"OK BYE BYE" S OK=0 QUIT
 ;
 S LRD0=$S(Y=1:"FIRST",Y=2:"SECOND",Y=3:"THIRD",Y=4:"FOURTH",1:"FIFTH")
 S OK=1 S LRD0="D "_LRD0
 X LRD0
 ;
 K DIR
 I 'OK D END QUIT
 S LREDT3=LREDT
 ;
 QUIT
 ;
END ;
QUIT ;
 D QUIT^LRARCHIV
 QUIT
 ;
 ;
FIRST ;--------->by nuber of days
 K DIR SET DIR(0)="N" S DIR("B")="90" S DIR("A")="Enter # of days"
 D ^DIR
 I $D(DUOUT)!($D(DTOUT))!(+Y'>0) W !!,"OK BYE BYE" S OK=0 QUIT
 S X1=LR(1),X2=-Y D C^%DTC
 W !,$$FMTE^XLFDT(X,"D")," TO ",$$FMTE^XLFDT(LR(1),"D")
 S LREDT=X
 K DIR D PASTIT
 QUIT
SECOND ;---------->by date range
 S %DT="AE"
 S %DT("B")="T-90"
 S %DT("A")="Start Date: "
 D ^%DT I Y'>0 S OK=0 D END QUIT
 S LR(1)=Y
 S %DT("B")="T-30"
 S %DT("A")="Ending Date: "
 D ^%DT I Y'>0 S OK=0 D END QUIT
 S LREDT=Y
 S LRY0=LREDT,LREDT=LR(1),LR(1)=LRY0 ;SWAP
 ;I LR(1)>LREDT S X=LR(1),LR(1)=LREDT,LREDT=X
 K %DT
 D PASTIT
 QUIT
THIRD ;----------->by month
 S %DT="AE"
 S %DT("B")=+$E(DT,4,5)_"/"_+$E(DT,2,3)
 S %DT("?")="Enter Month/Year...May 1997...June 1994"
 S %DT("??")="9/94 for September 1994"
 S %DT("A")="Month and year: "
 D ^%DT I Y'>0 S OK=0 QUIT
 ;
 I +$E(Y,4,4)++$E(Y,5,5)'>0 W !!,"You forgot the month." G THIRD
 ;
 S LR(1)=$E(Y,1,5)_"01" S LREDT=$E(LR(1),1,3)_$E(LR(1),4,5)+1_"01"
 S LRY0=LREDT,LREDT=LR(1),LR(1)=LRY0 ;SWAP
 K %DT
 D PASTIT
 QUIT
 ;
FOURTH ;--------------->by quarter
 K DIR
 S DIR(0)="S^1:1st Quarter;2:2nd Quarter;3:3rd Quarter;4:4th Quarter"
 S DIR("B")=1
 S DIR("?")="1=Jan-Feb-Mar 2=Apr-May-June 3=Jul-Aug-Sep 4=Oct-Nov-Dec"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S OK=0 D END QUIT
 S LRQQ=Y
 D AGAIN
 S LRQQ=$S(LRQQ=1:"FIRSTQ(LRYEAR)",LRQQ=2:"SECONDQ(LRYEAR)",LRQQ=3:"THIRDQ(LRYEAR)",1:"FOURTHQ(LRYEAR)")
 S LRQQ="D "_LRQQ X LRQQ
 D PASTIT
 QUIT
AGAIN ;
 ;
 I 'OK D END QUIT
 K %DT
 S %DT="AE" S %DT("A")="Please Enter a Year: "
 S %DT("B")=$S($E(DT,1,1)=2:19_$E(DT,2,3),1:20_$E(DT,2,3))
 D ^%DT
 I Y'>0 S OK=0 D END QUIT
 S LRYEAR=Y
 QUIT
 ;
FIFTH ;
 D AGAIN
 I 'OK D END QUIT
 S LR(1)=$E(Y,1,3)_0101
 S LREDT=$E(Y,1,3)_1231
 ;
PASTIT ;
 ;W !!,"LREDT=",LREDT,"<------>LR(1)=",LR(1)
 Q
QUARTER ;
 ;
FIRSTQ(LRYEAR) ;
 S LRYQ=$E(LRYEAR,2,3)
 S LR(1)=2_LRYQ_"0101",LREDT=2_LRYQ_"0331"
 QUIT
 ;
SECONDQ(LRYEAR) ;
 S LRYQ=$E(LRYEAR,2,3)
 S LR(1)=2_LRYQ_"0401",LREDT=2_LRYQ_"0630"
 QUIT
 ;
THIRDQ(LRYEAR) ;
 S LRYQ=$E(LRYEAR,2,3)
 S LR(1)=2_LRYQ_"0701",LREDT=2_LRYQ_"0930"
 QUIT
 ;
FOURTHQ(LRYEAR) ;
 S LRYQ=$E(LRYEAR,2,3)
 S LR(1)=2_LRYQ_"1001",LREDT=2_LRYQ_"1231"
 QUIT
 ;
DAYS ;
 ;
 Q
 ;
 QUIT
