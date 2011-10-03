RMPOLF2 ;HIN CIOFO/RVD-CONTINUATION OF RMPOLF1 ;06/22/99
 ;;3.0;PROSTHETICS;**29**;Feb 09, 1996
VIEW ;VIEW LETTERS FROM ELIG SCREEN2 UNDER ISSUE FROM STOCK
 N RMPRDA,DA,RMPRIN
 Q:$G(DFN)=""!(%=3)
 S RMPRFF=1 I '$D(^RMPR(665.4,"B",DFN)) G RO1
 K KILL
 W !!,"Letters on file:"
 ;!,?5,"Type",?29,"Employee",?55,"Date or Vendor"
ASK1 ;SET UP REVERSE LETTER LIST & ASK IF USER WANTS TO VIEW MORE LETTERS
 D EN^RMPRUTL2
 S DA=RMPRIN G:$G(DA)'>0 ASK2
 S RMPRIN=DA D PRINT^RMPOLF1
MOLET K DA,RMPRDA,RMPRIN
 S %=2 W !,"Would you like to see more letters" D YN^DICN
 I %=-1 S KILL=1 Q
 I %=0 W !,"'YES' will let you review another letter for this patient",!,"'NO' will let you continue the program"
 I  W !,"Enter '^' to exit the correspondence screen totally" G MOLET
 I %=2 S KILL=1 D RO1 Q
 I %=1 G ASK1
 G RO1
ASK2 ;Q:RMPRIN=-1
 S %=2 W !,"Do you wish to view a letter" D YN^DICN Q:$D(DTOUT)  S:%<0 KILL=1 G:%=2!(%<0) RO1
 I %=0 W !,"Answer `YES` or `NO`" G ASK2
 I %=1 G VIEW
 ;I %=1 S %=3 G VIEW
ASK3 I %=2 K X R !!,"Enter the number: ",X:DTIME Q:'$T!(X="")  Q:X="^"  I X>(I-1)!(+X<1)!(X'?1N.N) W !,$C(7),"Enter a number between 1 and ",(I-1)_" or `^` to quit." G ASK3
 I %=1 I $G(X)'="" I $G(RMPR9VA($G(X)))=""&($G(RMPRDFN)'="") S RMPR9VA($G(X))=RMPRDFN
 I %=1,$D(^RMPR(665.4,RMPR9VA(+X),0)) S RMPRIN=RMPR9VA(+X),RMPREN=1 D PRINT^RMPOLF1 G VIEW
RO1 ;K RMPREN S %=2 W !,"Do you wish to create a correspondence letter" D YN^DICN
 ;I %=1 D CUM^RMPOLF0 Q
 ;I %=0 W !,"Answer `YES` to create a form letter, `NO` to continue." G RO1
 ;I %=2 K RMPRBB,RMPRFF,RMPR9ZRO,RMPR9VA(1),RMPR9VA(2)
 ;S %=3 Q
 Q
 ;
EN4 ;EDIT A SKELETON
 K DIC S DIC="^RMPR(665.2,",DIC(0)="AEQLM",DLAYGO=665.2 D ^DIC K DLAYGO
 I +Y<0!($P(Y,U,4)["1") W !!,"SORRY, THIS IS A NON-EDITABLE LETTER" Q
 S RMPRIN=+Y L +^RMPR(665.2,RMPRIN,0):1 I $T=0 W !,$C(7),?5,"Someone else is Editing this entry!" K RMPRIN Q
 S DIE="^RMPR(665.2,",DA=RMPRIN,DR=".01;1",DIE("NO^")="" D ^DIE L -^RMPR(665.2,RMPRIN,0) I '$D(DA)!($D(DTOUT))!($D(DUOUT)) Q
DEN S %=$S($P(^RMPR(665.2,RMPRIN,0),U,2)=1:1,1:2) W !,"Is this a Denial type of letter" D YN^DICN
 Q:%<0
 I %=0 G QUES1
 S $P(^RMPR(665.2,RMPRIN,0),U,2)=$S(%=2:0,%=1:1,1:"")
 Q
QUES1 W !,"Enter `YES` if letter is an AMIS Denial" G DEN
EN3 ;PRINT FORM LETTER
 I '$D(RMPR("SIG")) D DIV4^RMPRSIT Q:$D(X)
 D HOME^%ZIS
 ;CHECK IF IT IS THE ADP FL 10-90
 K DIC S DIC="^RMPR(665.2,",DIC(0)="AEQM" D ^DIC Q:+Y<0
 S RMPRIN=+Y K DIC
 ;check if it is the ADP FL 10-90
PR S DIWF="^RMPR(665.2,RMPRIN,1,",DIWF(1)=665.2,BY="@NUMBER",FR=RMPRIN,TO=RMPRIN D EN2^DIWF
 Q
 ;
SET K DIC S DIC="^RMPR(665.4,",DIC(0)="L",X=DFN,DLAYGO=665.4 K DD,DO,DINUM D FILE^DICN K DLAYGO
 G:Y<0 EXIT^RMPOLF1
 S RMPRIN=+Y,$P(^RMPR(665.4,RMPRIN,0),U,2)=RMPRFA,$P(^(0),U,3)=DT,$P(^(0),U,4)=DUZ,$P(^RMPR(665.4,RMPRIN,0),U,5)=$P(^RMPR(665.2,RMPRFA,0),U,2),$P(^RMPR(665.4,RMPRIN,0),U,6)=RMPOXITE S DIK=DIC,DA=RMPRIN D IX1^DIK
 S %X="^TMP($J,""DW"",",%Y="^RMPR(665.4,+Y,1," D %XY^%RCR
 G PRINT^RMPOLF1
 Q
 ;
SETALL K DIC S DIC="^RMPR(665.4,",DIC(0)="L",X=DFN,DLAYGO=665.4 K DD,DO,DINUM D FILE^DICN K DLAYGO
 G:Y<0 EXIT^RMPOLF1
 S RMPRIN=+Y,$P(^RMPR(665.4,RMPRIN,0),U,2)=RMPRFA,$P(^(0),U,3)=DT,$P(^(0),U,4)=DUZ,$P(^RMPR(665.4,RMPRIN,0),U,5)=$P(^RMPR(665.2,RMPRFA,0),U,2),$P(^RMPR(665.4,RMPRIN,0),U,6)=RMPOXITE S DIK=DIC,DA=RMPRIN D IX1^DIK
 S %X="^TMP($J,""DW"",",%Y="^RMPR(665.4,+Y,1," D %XY^%RCR
 S ^TMP("RL",$J,1,RMPRIN)=DFN
 Q
WRITE S:$G(RMPR9ZRO)'=""&(RO="") RO=RMPR9ZRO
 I I#15=0 S DIR(0)="FAOU^1:245",DIR("A")="End of page: select a letter by number or enter'^' to continue listining" D  I $G(X)="^" Q
 .D ^DIR
 .I $G(X)="" Q
 .I $G(X)>0&($G(RO)>0&($G(X)<(RO+1))) S DA=^TMP($J,"RMPR",RO) W !,"***",DA Q
 W !,I_" ",?4,$S($D(^RMPR(665.2,+$P(^RMPR(665.4,^TMP($J,"RMPR",RO),0),U,2),0)):$E($P(^(0),U,1),1,20),1:"UNKNOWN")
 S:$D(^RMPR(665.4,^TMP($J,"RMPR",RO),2)) RMPR2=$P(^RMPR(665.4,^TMP($J,"RMPR",RO),2),U,1)
 ;W ?27,$S($D(^VA(200,+$P(^RMPR(665.4,^TMP($J,"RMPR",RO),0),U,4),0)):$E($P(^(0),U),1,15),1:"")
 S RMPRPP=$G(^VA(200,+$P(^RMPR(665.4,^TMP($J,"RMPR",RO),0),U,4),0))'="" W ?27,$E($P(^(0),U),1,15) K RMPRPP
 S Y=$S($P(^RMPR(665.4,^TMP($J,"RMPR",RO),0),U,3):$P(^RMPR(665.4,^TMP($J,"RMPR",RO),0),U,3),$D(RMPR2):$P(^PRC(440,RMPR2,0),U,1),1:"") D DD^%DT W ?55,$E(Y,1,24) S RMPR9VA(I)=^TMP($J,"RMPR",RO)
 Q
