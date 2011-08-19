RABTCH1 ;HISC/CAH,FPT AISC/MJK,RMO-Batch Report Menu ;9/28/94  10:49
 ;;5.0;Radiology/Nuclear Medicine;**8**;Mar 16, 1998
VERIFY ;Verify Batch
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 W ! S DIC("S")="I $P(^(0),U,4)",DIC("A")="Select Batch: ",DIC="^RABTCH(74.2,",DIC(0)="AEZMQ" D ^DIC K DIC G Q:Y<0 S RAPGM="NXT^RABTCH1",RABTCH=+Y,LINE="",$P(LINE,"-",80)=""
 W !!,"Batch: ",$P(Y(0),"^"),?30,"Date Created: " S Y=$P(Y(0),"^",2) D D^RAUTL W Y,?65,$S($D(^VA(200,+$P(Y(0),"^",3),0)):$E($P(^(0),"^"),1,14),1:"")
 S Y=$P(Y(0),"^",4) D D^RAUTL:Y]"" W !?30,"Last Printed: ",Y
ASKVER R !!,"Is this the batch you want to verify? No// ",X:DTIME S:'$T!(X="")!(X["^") X="N" G Q:"Nn"[$E(X) I "Yy"'[$E(X) W:X'["?" *7 W !!,?3,"Enter 'YES' to verify this batch, or 'NO' not to." G ASKVER
 ; Get e-sig
 D ^RASIGU I %=0 G Q
 S RAVER=$P(^VA(200,RASIG("PER"),0),U,1)
 S RAONLINE=""
 ;
 W !,LINE F RAI=0:0 S RAI=$O(^RABTCH(74.2,RABTCH,"R",RAI)) Q:RAI'>0  I $D(^(RAI,0)) S (RARPT,Y)=+^(0) D RASET^RAUTL2 D CHK:+Y Q:$D(RAUP)!('$D(RACT))
 G:'$D(RACT) Q1
ASKBAT R !!,"Can this batch now be deleted? No// ",X:DTIME S:'$T!(X="")!(X["^") X="N" G Q1:"Nn"[$E(X) I "Yy"'[$E(X) W:X'["?" *7 W !!?3,"Enter 'YES' to delete this batch, or 'NO' not to." G ASKBAT
 S DA=RABTCH,DIK="^RABTCH(74.2," D ^DIK W !?3,"...deletion complete."
Q1 I '$D(RAUP),$D(^TMP($J,"RA","DT")) D UPSTATM^RAUTL0
Q K %,%X,D,D0,D1,DA,DIC,DIK,DIE,DR,RA,RACT,RADATE,RAUP,RABTCH,LINE,RADFN,RADTE,RADTI,RACN,RACNI,RAOR,RARPT,RA0,RAI,RAPGM,RASN,RASTI,RAVER,^TMP($J,"RA")
 K %W,%X,%Y1,C,X,Y
 K DDH,DISYS,POP
 K RAVER,RAONLINE,RASIG
 Q
 ;
CHK I $P(^RARPT(RARPT,0),"^",5)="V" W !?3,"...report for case no. ",RACN," is already verified" S RACT="" W !,LINE Q
 W !,"Report for case no. ",RACN," for ",$S($D(^DPT(RADFN,0)):$P(^(0),"^"),1:"UNKNOWN") G 31^RART
NXT I '$D(RACT) K RAAB Q
 W !,LINE I RACT="V" S ^TMP($J,"RA","DT",RADTE,RARPT)=$S($D(RAAB):1,1:"")
 K RAAB Q
