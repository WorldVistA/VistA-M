GMRGEDA ;CISC/RM-PATIENT DATA EDIT (cont.) ;5/28/92
 ;;3.0;Text Generator;;Jan 24, 1996
JUMP ;
 S DX=$S($X'>IOM:$X,1:$X-IOM),DY=0 X ^%ZOSF("XY") S X=$P(GMRGS,"^^",2),DIC="^GMRD(124.2,",DIC(0)="EZS",DIC("S")="I +Y'=+GMRGTERM",D="C" D IX^DIC K DIC
 I +Y'>0 S:$D(DTOUT) GMRGOUT=1 Q:GMRGOUT!$D(DUOUT)  W !?5,"Invalid choice, try again.",!!?5,"Press return to continue " R X:DTIME S:X="^"!(X="^^")!'$T GMRGOUT=1 Q
 I $D(^GMR(124.3,GMRGPDA,1,"ALIST",+Y)) D SETSLP G KEEP
 W !!,"Because '",$P(Y(0),"^"),"' is not part of the",!,"patient data, it must be ""linked"" in via a pathway.",!,"The following list will be a list of pathways to choose from.",!,"To continue with this jump, you must pick a pathway."
 W !!,"Enter return to continue, ^ to abort the jump " R X:DTIME S:X="^^"!'$T GMRGOUT=1 Q:GMRGOUT!(X="^")
 K GMRGPATH S GMRG0(0)=+Y,GMRGSELP="",(GMRG0,GMRGPATH)=0,GMRGPATH(0)=GMRG0(0) W !!,"...Excuse me while I perform some necessary calculations..." D PATH
 I 'GMRGPATH W $C(7),!?5,"Cannot jump, no valid paths were found.",!!?5,"Press return to continue " R X:DTIME S:X="^"!(X="^^")!'$T GMRGOUT=1 G KEEP
 W @IOF S GMRGLIST=0 F GMRG1=0:0 S GMRG1=$O(^TMP($J,"GMRGPATH",GMRG1)) Q:GMRG1'>0  D LPTH Q:GMRGOUT!GMRGSELP
 D:'GMRGOUT&'GMRGSELP PICK S:GMRG3'="^^" GMRGOUT=0 I GMRGSELP S GMRGSELP=$S($D(^TMP($J,"GMRGLIST",GMRGSELP)):^(GMRGSELP),1:"")
KEEP K ^TMP($J,"GMRGPATH"),^TMP($J,"GMRGLIST") Q:GMRGOUT!'GMRGSELP  S GMRGUSL(+Y_"*")=GMRGSELP
 Q
PATH ; CALCULATE ALL PATHS
 F GMRG1=0:0 S GMRG1=$O(^GMRD(124.2,"AKID",GMRG0(GMRG0),GMRG1)) Q:GMRG1'>0  I $D(^(GMRG1,0)) D RECPAT
 S GMRG1=GMRG0(GMRG0),GMRG0=GMRG0-1,GMRGPATH(0)=$P(GMRGPATH(0),"^",2,$L(GMRGPATH(0),"^"))
 Q
RECPAT ;
 I +GMRGRT=GMRG1!$D(^GMR(124.3,GMRGPDA,1,"ALIST",GMRG1)) S GMRGPATH=GMRGPATH+1,^TMP($J,"GMRGPATH",$L(GMRGPATH(0),"^"),GMRG1,GMRGPATH)=GMRGPATH(0) W:'$R(100) "." Q
 S GMRGPATH(0)=GMRG1_"^"_GMRGPATH(0),GMRG0=GMRG0+1,GMRG0(GMRG0)=GMRG1
 D PATH
 Q
LPTH ;
 F GMRG0(1)=0:0 S GMRG0(1)=$O(^TMP($J,"GMRGPATH",GMRG1,GMRG0(1))) Q:GMRG0(1)'>0!GMRGOUT!GMRGSELP  F GMRG0=0:0 S GMRG0=$O(^TMP($J,"GMRGPATH",GMRG1,GMRG0(1),GMRG0)) Q:GMRG0'>0  D SELPAT Q:GMRGOUT!GMRGSELP
 Q
SELPAT ;
 S GMRG0(0)=$S($D(^TMP($J,"GMRGPATH",GMRG1,GMRG0(1),GMRG0)):^(GMRG0),1:"") Q:GMRG0(0)=""
 I ($Y+$L(GMRG0(0),"^")+1)>(IOSL-3) D PICK I GMRGOUT!GMRGSELP Q
 S GMRGLIST=GMRGLIST+1,^TMP($J,"GMRGLIST",GMRGLIST)=GMRG0(1)_"^"_GMRG0(0) K ^TMP($J,"GMRGPATH",GMRG1,GMRG0(1),GMRG0)
 W !,$J(GMRGLIST,3),". ",$S($D(^GMRD(124.2,+GMRG0(1),0)):$P(^(0),"^"),1:"") F GMRG0(2)=1:1:$L(GMRG0(0),"^") W !?(GMRG0(2)+2*2+1),$S($D(^GMRD(124.2,+$P(GMRG0(0),"^",GMRG0(2)),0)):$P(^(0),"^"),1:"")
 Q
PICK S GMRG3="" W !!,"Select a pathway, Choose a number 1-",GMRGLIST,", or enter return to see more: " R X:DTIME S:'$T!(X="^^") GMRG3="^^",X="^" S:X="^" GMRGOUT=1 I X=""!GMRGOUT W:X="" @IOF Q
 I X=+X,$D(^TMP($J,"GMRGLIST",X)) S GMRGSELP=X Q
 W !?4,$C(7),"ENTER A VALID NUMBER BETWEEN 1 AND ",GMRGLIST
 G PICK
SETSLP ;
 I +Y=+GMRGRT S GMRGSELP=+Y Q
 S GMRGLIST=0 F X=0:0 S X=$O(^GMRD(124.2,"AKID",+Y,X)) Q:X'>0  I $D(^(X,0)),$D(^GMR(124.3,GMRGPDA,1,"ALIST",X)) S GMRGLIST=GMRGLIST+1,GMRGLIST(GMRGLIST)=X
 I GMRGLIST'>0 S GMRGSELP="" Q
 I GMRGLIST>1 D CHC S:'GMRGLIST GMRGSELP="" Q:GMRGOUT!'GMRGLIST
 I GMRGLIST=1 S GMRGLIST=GMRGLIST(1)
 S GMRGSELP=GMRGLIST_"^"_+Y
 Q
CHC ;
 W !!!
 F X=0:0 S X=$O(GMRGLIST(X)) Q:X'>0  W ?4,$J(X,2)," ",$S($D(^GMRD(124.2,+GMRGLIST(X),0)):$P(^(0),"^"),1:""),!?7,"PARENT: " F Z=0:0 S Z=$O(^GMRD(124.2,"AKID",+GMRGLIST(X),Z)) Q:Z'>0  D
 .   I $D(^(Z,0)) W ?15,$S($D(^GMRD(124.2,+Z,0)):$P(^(0),"^"),1:""),!
 .   Q
 W !,"The term you wish to jump to can be reached from multiple paths.",!,"Please choose the number (1-"_GMRGLIST_") of the corresponding path you wish to use: "
 R X:DTIME S:X="^^"!'$T X="^" S:X="^" GMRGOUT=1 S:X="" GMRGLIST=X Q:'GMRGLIST!GMRGOUT  I X<1!(X>GMRGLIST) W !?3,$C(7),"PLEASE CHOOSE A NUMBER BETWEEN 1 AND ",GMRGLIST G CHC
 S GMRGLIST=GMRGLIST(X)
 Q
