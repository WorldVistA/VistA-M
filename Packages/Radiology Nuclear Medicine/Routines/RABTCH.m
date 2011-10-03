RABTCH ;HISC/CAH,FPT AISC/MJK,RMO-Batch Report Menu ;3/1/96  13:18
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
1 ;;Select a Batch
 W ! K RABTCH S DIC("S")="I $P(^(0),U,3)=DUZ,'$P(^(0),U,4)",DIC("DR")="2///NOW;3////"_DUZ,DIC("A")="Select Batch: ",DIC="^RABTCH(74.2,",DIC(0)="AEZLQ",DLAYGO=74.2
 D ^DIC G Q1:Y<0 S RABTCH=+Y,RABTCHN=$P(Y,"^",2)
Q1 K %,%DT,C,D0,DA,DDH,DI,DIC,DIE,DLAYGO,DQ,DR,I,POP,X,Y Q
 ;
2 ;;List Batch Entries
 F RAPEAT=0:0 W ! Q:$G(RAX)["^"  S DIC("A")="Select Batch: ",DIC="^RABTCH(74.2,",DIC(0)="AEZMQ" D ^DIC K DIC Q:Y<1  S RABTCH=+Y,ZTRTN="START2^RABTCH",ZTSAVE("RABTCH")="" W ! D ZIS^RAUTL I 'RAPOP D START2
 K RAPEAT,RAPOP,RAX D Q2
 Q
START2 ; start report processing
 U IO S Y(0)=$G(^RABTCH(74.2,RABTCH,0)),RAPGE=0,RAX=""
 N RA1 D HDR2
 F I=0:0 S I=$O(^RABTCH(74.2,RABTCH,"R",I)) Q:I'>0!(RAX["^")  I $D(^(I,0)) S RARPT=^(0),RAFL=$S($P(RARPT,"^",2)="Y":"*",1:""),RARPT=+RARPT I $D(^RARPT(RARPT,0)) S RA0=^(0),RA1=$O(^(1,"B",0)) D
 .I $Y>(IOSL-4) D:$E(IOST)="C" CRCHK^RAORD6 D:$D(ZTQUEUED) STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAX="^" Q:RAX["^"  D HDR2
 .S RACN=$P(RA0,"^",4),RADTI=9999999.9999-$P(RA0,"^",3),RADFN=+$P(RA0,"^",2)
 .W !?2,RAFL,?3,$J(RACN,4) W:RA1]"" " +" S Y=$P($P(RA0,"^",3),".") D D^RAUTL W ?15,Y,?30,$S($D(^DPT(RADFN,0)):$E($P(^(0),"^"),1,29),1:"Unknown")
 .S Z="" I $D(^RADPT(RADFN,"DT",RADTI,"P","B",RACN)),$O(^(RACN,0))>0,$D(^RADPT(RADFN,"DT",RADTI,"P",$O(^(0)),0)) S Z=^(0)
 .W ?60,$E($S($D(^VA(200,+$P(Z,"^",12),0)):$P(^(0),"^"),$D(^VA(200,+$P(Z,"^",15),0)):$P(^(0),"^"),1:"Unknown"),1,19)
Q2 K %,DIC,I,RA0,RABTCH,RACN,RADFN,RADTI,RAFL,RAPGE,RARPT,X,Y,Z,ZTQUEUED,ZTSTOP
 K C,DDH,I,POP,DISYS
 D CLOSE^RAUTL
 Q
 ;
HDR2 ; report header
 S RAPGE=RAPGE+1
 W:$Y>0 @IOF
 W !,"Batch: ",$P(Y(0),"^"),?30,"Date Created: " S Y=$P(Y(0),"^",2) D D^RAUTL W Y,?65,$S($D(^VA(200,+$P(Y(0),"^",3),0)):$E($P(^(0),"^"),1,14),1:"")
 S Y=$P(Y(0),"^",4) D D^RAUTL:Y]"" W !?30,"Last Printed: ",Y,!!,"* indicates the report has been printed from batch",!
 W $$REPEAT^XLFSTR("=",79)
 W !!?1,"Case No.",?15,"Exam Date",?30,"Patient",?60,"Interpreting Phys."
 W !?1,"--------",?15,"---------",?30,"-------",?60,"------------------"
 Q
3 ;;Print a Batch
 ;SET^RAPSET1 is called so that RAMLC is defined and the default print
 ;device for report printing can be determined
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 W ! S DIC("A")="Select Batch: ",DIC="^RABTCH(74.2,",DIC(0)="AEZMQ" D ^DIC K DIC G Q3:Y<0 S RABTCH=+Y
 W !!,"Batch: ",$P(Y(0),"^"),?30,"Date Created: " S Y=$P(Y(0),"^",2) D D^RAUTL W Y,?65,$S($D(^VA(200,+$P(Y(0),"^",3),0)):$E($P(^(0),"^"),1,14),1:"")
 S Y=$P(Y(0),"^",4) D D^RAUTL:Y]"" W !?30,"Last Printed: ",Y
ASKPRT R !!,"Are you sure? No// ",X:DTIME S:'$T!(X="")!(X["^") X="N" G Q3:"Nn"[$E(X) I "Yy"'[$E(X) W:X'["?" *7 W !!?3,"Enter 'YES' to print this batch, or 'NO' not to." G ASKPRT
BTCH S ION=$P(RAMLC,"^",10),IOP=$S(ION]"":"Q;"_ION,1:"Q")
 S DIE="^RABTCH(74.2,",DA=RABTCH,DR="4///^S X=""NOW""" D ^DIE
 S ZTRTN="START^RABTCH",ZTSAVE("RABTCH")=""
 W ! D ZIS^RAUTL G Q3:RAPOP
START U IO S U="^",RABT=RABTCH
 S X="T",%DT="" D ^%DT S DT=Y
 F RABTI=0:0 S RABTI=$O(^RABTCH(74.2,RABT,"R",RABTI)) Q:RABTI'>0  I $D(^(RABTI,0)) S RABTCH=RABT,RARPT=+^(0),^(0)=RARPT_"^Y" D PRT^RARTR
Q3 K C,D0,DA,DIE,DR,J,K,RABT,RABTI,RADTI,RACN,RADTE,RADFN,RARPT,RABTCH,W,RAPOP
 K %W,%X,%Y1,D,DI,DIC,DQ,X,Y
 K DDH,DISYS,I,POP
 W ! D CLOSE^RAUTL Q
 ;
4 ;;Remove/Add a Report from a Batch
 W ! S DIC("S")="I $P(^(0),U,3)=DUZ",DIC("A")="Select Batch: ",DIC="^RABTCH(74.2,",DIC(0)="AEZMQ" D ^DIC K DIC G Q4:Y<0 S DA=+Y
 S DIE="^RABTCH(74.2,",DR="25",DR(2,74.21)=".01" D ^DIE
Q4 K %,%Y,C,D0,DA,DIE,DR,J,K,RABT,RABTI,RADTI,RACN,RADTE,RADFN,RARPT,RABTCH,W
 K D,D1,DDH,DI,DIC,DIZ,DLAYGO,DQ,I,X
 K DDC,DST,DISYS,POP
 Q
