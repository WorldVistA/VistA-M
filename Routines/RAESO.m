RAESO ;HISC/CAH,GJC AISC/SAW-Override Exam Status to Complete ;4/28/97  08:00
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;Mass override exam status to complete
 D SET^RAPSET1 I $D(XQUIT) K XQUIT,POP Q
 N RAXIT,RASAVDR S RAXIT=0 D CZECH Q:RAXIT
 W !,"Your sign-on imaging type is ",RAIMGTY,", so only exams",!,"of imaging type ",RAIMGTY," will be changed to complete.",!
 K DIR S DIR(0)="Y",DIR("A")="Are you sure you want to proceed" D ^DIR I Y'=1 G EXIT
 K DIR,X,Y
ASK K DIC S DIC(0)="AEQM",DIC="^RA(72,"
 S DIC("S")="I $P(^(0),U,3)'=9,($P(^(0),U,3)'=0),($P(^(0),U,7)=+$O(^RA(79.2,""B"",RAIMGTY,0)))"
 D ^DIC G EXIT:$D(DUOUT)!($D(DTOUT)) I Y'<0 S RASTIEN(+Y)="" G ASK
 G EXIT:'$D(RASTIEN) K DIC W !!,"Enter a cutoff date that is at least sixty days prior to today."
 S X1=DT,X2=-60 D C^%DTC S DIR(0)="D^:"_X D ^DIR G EXIT:$D(DIRUT) S RAECDTI=9999999-Y D DD^%DT S RAECDTE=Y
 ;Following line commented out for v 4.5 - setting the 10th piece to 0 was preventing update of subfld 75, Exam Status Times. These are now updated.
 W ! S IOP="Q",ZTRTN="DQ^RAESO"
 S ZTSAVE("RAI*")="",ZTSAVE("RAM*")="",ZTSAVE("RAE*")=""
 S ZTSAVE("RASTIEN(")=""
 S ZTDESC="Rad/Nuc Med Mass Override of Exam Status to Complete",RAMES="W !,?5,""Output Queued.""",RAZIS=1 D ZIS^RAUTL K IOP
 G EXIT
DQ U IO S PG=0 S RAIMGTYI=$O(^RA(79.2,"B",RAIMGTY,0))
 F RAST=0:0 S RAST=$O(RASTIEN(RAST)) Q:RAST'>0  F RADFN=0:0 S RADFN=$O(^RADPT("AS",RAST,RADFN)) Q:RADFN'>0  F RADTI=RAECDTI:0 S RADTI=$O(^RADPT("AS",RAST,RADFN,RADTI)) Q:RADTI'>0  D L1
 I '$D(RAF4) D HD W !!,"There were no exams with the statuses selected in the time frame specified that",!,"needed to be overridden to complete."
EXIT D CLOSE^RAUTL
 K DA,DIC,DIE,DIR,DIRUT,DIROUT,DUOUT,DTOUT,DR,PG,POP
 K RA,RACN,RACNI,RADFN,RADTE,RADTI,RAECDTE,RAECDTI,RAF1,RAF4,RAIMGTYI,RAMES,RAPOP,RAST,RASTIEN,RAZMDV,RAZIS
 K X,X1,X2,XQUIT,Y,ZTDESC,ZTRTN,ZTSAVE,I,POP,DISYS,C Q
L1 F RACNI=0:0 S RACNI=$O(^RADPT("AS",RAST,RADFN,RADTI,RACNI)) Q:RACNI'>0  I $P($G(^RADPT(RADFN,"DT",RADTI,0)),U,2)=RAIMGTYI I $D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S RA(0)=^(0) D SET
 Q
SET S RACN=$P(RA(0),"^"),RADTE=9999999.9999-RADTI,DA=RADFN,DIE="^RADPT(",DR="[RA OVERRIDE]",RASAVDR=DR D ^DIE K DE,DQ,DIE,DR
 D:'$D(RAF1) HD D:$Y-(IOSL-11)>0 HD W !,$E($P(^DPT(RADFN,0),"^"),1,25),?28 S Y=RADTE D DD^%DT W Y,?49,RACN,?57,$S($D(^RA(72,RAST,0)):$E($P(^(0),"^"),1,20),1:"Unknown") S RAF4=1
 D ^RAORDC Q
HD S PG=PG+1 W:$Y>0 @IOF,!!,?(IOM\2-26),"Report on Mass Override of Exam Statuses to Complete",?(IOM-8),"PAGE ",PG
 W !,?(IOM\2-22),"Cutoff Date for this Report is: ",RAECDTE,!,?(IOM\2-17),"Date Report was Run: " S Y=DT D DD^%DT W Y
 W !!!,"Patient Name",?28,"Exam Date",?49,"Case #",?57,"Status Before Override",! S RAF1=1 Q
SINGLE ;Override Single Exam Status to 'COMPLETE'
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 N RAXIT,RASAVDR S RAXIT=0 D CZECH Q:RAXIT
 S RAVW="" D ^RACNLU G EXIT1:"^"[X W ! S I="",$P(I,"-",80)="" W I
 W !?1,"Name     : ",$E(RANME,1,25),?40,"Pt ID       : ",RASSN,!?1,"Case No. : ",RACN,?40,"Procedure   : ",$E(RAPRC,1,25)
 W !?1,"Exam Date: ",RADATE,?40,"Technologist: " I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",0))>0,$D(^VA(200,+^($O(^(0)),0),0)) W $E($P(^(0),"^"),1,25)
 W !?40,"Req Phys    : ",$E($S($D(^VA(200,+$P(Y(0),"^",14),0)):$P(^(0),"^"),1:""),1,25),! S I="",$P(I,"-",80)="" W I
 I $P($G(^RADPT(RADFN,"DT",RADTI,0)),U,2)'=$O(^RA(79.2,"B",RAIMGTY,0)) W !,"Sorry, your sign-on imaging type, ",RAIMGTY,!,"doesn't match the imaging type of this exam.",! G SINGLE
 I $D(^RA(72,"AA",RAIMGTY,0,+RAST)) W !!?3,*7,"...exam 'cancelled' therefore override is not allowed." G SINGLE
 I $D(^RA(72,"AA",RAIMGTY,9,+RAST)) W !!?3,*7,"...exam is already 'complete'." G SINGLE
ASKOVR R !!,"Are you sure? No// ",X:DTIME S:'$T!(X="")!(X["^") X="N" G SINGLE:"Nn"[$E(X) I "Yy"'[$E(X) W:X'["?" *7 W !!?3,"Enter 'YES' to override exam status to 'COMPLETE', or 'NO' not to." G ASKOVR
 W !?3,"...will now attempt override..." S DA=RADFN,DIE="^RADPT(",DR="[RA OVERRIDE]",RASAVDR=DR D ^DIE K DE,DQ,DIE,DR I '$D(Y) W !?6,"...exam status is now '",$P(^RA(72,$O(^RA(72,"AA",RAIMGTY,9,0)),0),"^"),"'.",! D ^RAORDC K DR
 G SINGLE
EXIT1 K %,%DT,%I,%X,%Y,D,D0,D1,D2,D3,DA,DI,DIC,J,POP,RADFN,RADIV,RADTI,RACNI
 K RANME,RASSN,RADATE,RADTE,RACN,RAHEAD,RAI,RAPRC,RAPIFN,RARPT,RAST,RAVW
 K W,X,XQUIT,Y,^TMP($J,"RAEX")
 Q
CZECH ; Check for a 'Complete' exam status for a particular imaging type
 I '+$O(^RA(72,"AA",RAIMGTY,9,0)) D
 . S RAXIT=1
 . W !?5,"An Examination Status of 'Complete' must be defined for an"
 . W !?5,"Imaging Type of: "_RAIMGTY_".  Please contact your"
 . W !?5,"Radiology/Nuclear Medicine ADPAC for further assistance.",$C(7)
 . Q
 Q
