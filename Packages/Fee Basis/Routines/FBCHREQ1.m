FBCHREQ1 ;AISC/DMK-FEE NOTIFICATION CONT ;31AUG90
 ;;3.5;FEE BASIS;**103**;JAN 30, 1995;Build 19
 ;;Per VHA Directive 2004-038, this routine should not be modified.
VENDOR ;ASK VENDOR FOR NOTIFICATION
 W ! K FBCHVEN S DIC="^FBAAV(",DIC(0)="AEQLM",DLAYGO=161.2 D ^DIC G END:X=""!(X="^"),VENDOR:Y<0 S (DA,FBCHVEN)=+Y,DIE=DIC I $P(Y,"^",3)=1 S FBVENEW=1 D NEW^FBAAVD K DIC,DIE,DA,DLAYGO Q
ASKVOK I '$D(FBVENEW) D EN1^FBAAVD S DIR(0)="Y",DIR("A")="Is this the correct vendor",DIR("B")="YES" D ^DIR K DIR G VENDOR:$D(DIRUT)!'Y
END K DIC,DIE,DLAYGO
 Q
TIMCK ;72 hour time check called from FBAA ENTER REQUEST template
 S X1=$P(^FBAA(162.2,DA,0),"^",1),X=$P(^(0),"^",19),HY=Y,FBSW=""
 S Y=$E(X1_"000",9,10)-$E(X_"000",9,10)*60+$E(X1_"00000",11,12)-$E(X_"00000",11,12),X2=X,X=$P(X,".",1)'=$P(X1,".",1) D ^%DTC:X S FBX=X*1440+Y
SURE I FBX>4320 W *7,!!,"This Authorization From Date exceeds the 72 hour notification period. ",!,?8,"Do you want to continue ? No// " R X:DTIME S:X="" X="N" G HELP:X["^" D VALCK^FBAAUTL1 G SURE:'VAL I "Nn"[$E(X,1) S FBSW=1,Y=HY Q
 S Y=HY Q
HELP W !,"Entering an '^' is not allowed.  Please answer 'Yes' or 'No'." G SURE
EN I $D(DA),DA S FBDA(0)=DA,DIE="^FBAA(162.2,",DR=".01////@" D ^DIE
 I '$D(DA)  W *7,!?3,"...request deleted",! I $D(^FBAA(161.5,FBDA(0),0)) S DA=FBDA(0),DIK="^FBAA(161.5," D ^DIK
 K DIC,DIE,DIK,DA,X,FBDA,DR,DLAYGO,FBDATE,FBLG,FBN,FBUP,FBVT,VA D END^FBCHREQ
 Q
EDIT ;EDIT A REQUEST THAT'S NOT COMPLETE
 S DIC("S")="I $P(^(0),U,15)'=3" D ASKV^FBCHREQ K DIC("S") G Q:X=""!(X="^") S DA=+Y,FB(0)=^FBAA(162.2,DA,0),FBDOA=$P(FB(0),"^",19),FBFRDT=$P(FB(0),"^",5)
 ; fb*3.5*103  add REFERRING PROVIDER (162.2,17) to DR string
 S DIE="^FBAA(162.2,",DR="1;2;3.5;S:X=FBDOA!(X<FBFRDT) Y=""@10"";S FBDOA=X;4////^S X=FBDOA;I 1;@10;4;5;17;I $G(X) W !,""REFERRING PROVIDER NPI: "",$$REFNPI^FBCH78(X);6;S FBCHVEN=X" D ^DIE S FBN(0)=^FBAA(162.2,DA,0)
 I FB(0)'=FBN(0) S DR="7////^S X=DUZ" D ^DIE
 I $D(DA),$D(^FBAA(161.5,DA,0)) D
 .I FB(0)'=FBN(0) S $P(^FBAA(161.5,DA,0),"^",2)=$P(FBN(0),"^",2),$P(^(0),"^",5)=$P(FBN(0),"^",5),$P(^FBAA(161.5,DA,1),"^",7)=$P(FBN(0),"^",19),$P(^(1),U)=$P(FBN(0),U,6),DIK="^FBAA(161.5," D IX^DIK K DIK
 .S FBREQED=1,DIC="^FBAA(161.5,",DIC(0)="AEQM" D EN^FBCHROC
Q K DIE,DIC,DIRUT,DUOUT,DTOUT,X,Y,DR,FB,FBN,FBDA,FBDFN,FBNAME,FBSSN,DA,FBCHVEN,FBREQED,FBDOA,FBFRDT,J
 Q
DATCK ;Verify authorized from date is > or = date of admission.
 S FBDOA=$P(^FBAA(162.2,DA,0),"^",19) I $G(FBDOA),X<FBDOA W !,*7,"Authorized From Date must be equal to or greater than the Date of Admission" S FBOUT=1
 Q
