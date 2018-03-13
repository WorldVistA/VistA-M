RAESO ;HISC/CAH,GJC AISC/SAW-Override Exam Status to Complete ;16 Jan 2018 9:30 AM
 ;;5.0;Radiology/Nuclear Medicine;**47,137**;Mar 16, 1998;Build 4
 ;Mass override exam status to complete - REMOVED P137 /KLM
SINGLE ;Override Single Exam Status to 'COMPLETE'
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 N RAXIT,RASAVDR S RAXIT=0 D CZECH Q:RAXIT
 S RAVW="" D ^RACNLU G EXIT1:"^"[X W ! S I="",$P(I,"-",80)="" W I
 N RASSAN,RACNDSP S RASSAN=$$SSANVAL^RAHLRU1(RADFN,RADTI,RACNI)
 S RACNDSP=$S((RASSAN'=""):RASSAN,1:RACN)
 I $$USESSAN^RAHLRU1() W !?1,"Name     : ",$E(RANME,1,25),?40,"Pt ID       : ",RASSN,!?1,"Case No. : ",RACNDSP,?40,"Procedure   : ",$E(RAPRC,1,25)
 I '$$USESSAN^RAHLRU1() W !?1,"Name     : ",$E(RANME,1,25),?40,"Pt ID       : ",RASSN,!?1,"Case No. : ",RACN,?40,"Procedure   : ",$E(RAPRC,1,25)
 W !?1,"Exam Date: ",RADATE,?40,"Technologist: " I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",0))>0,$D(^VA(200,+^($O(^(0)),0),0)) W $E($P(^(0),"^"),1,25)
 W !?40,"Req Phys    : ",$E($S($D(^VA(200,+$P(Y(0),"^",14),0)):$P(^(0),"^"),1:""),1,25),! S I="",$P(I,"-",80)="" W I
 I $P($G(^RADPT(RADFN,"DT",RADTI,0)),U,2)'=$O(^RA(79.2,"B",RAIMGTY,0)) W !,"Sorry, your sign-on imaging type, ",RAIMGTY,!,"doesn't match the imaging type of this exam.",! G SINGLE
 I $D(^RA(72,"AA",RAIMGTY,0,+RAST)) W !!?3,$C(7),"...exam 'cancelled' therefore override is not allowed." G SINGLE
 I $D(^RA(72,"AA",RAIMGTY,9,+RAST)) W !!?3,$C(7),"...exam is already 'complete'." G SINGLE
ASKOVR R !!,"Are you sure? No// ",X:DTIME S:'$T!(X="")!(X["^") X="N" G SINGLE:"Nn"[$E(X) I "Yy"'[$E(X) W:X'["?" $C(7) W !!?3,"Enter 'YES' to override exam status to 'COMPLETE', or 'NO' not to." G ASKOVR
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
