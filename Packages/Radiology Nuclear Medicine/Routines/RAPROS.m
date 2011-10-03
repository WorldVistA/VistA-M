RAPROS ;HISC/GJC AISC/MJK,RMO-Exam Profile (sort) ;6/19/97  09:12
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
PAT S DIC(0)="AQEM" D ^RADPA K DIC G Q:Y<0 S RADFN=+Y G Q:'$D(^DPT(RADFN,0)) S RANME=^(0),RASSN=$$SSN^RAUTL,RANME=$P(RANME,"^")
SORT R !!,"Sort by one of the following:",!?10,"P ==> Procedure",!?10,"D ==> Date of Exam",!?30,"Procedure// ",RAXX:DTIME
 G Q:'$T!(RAXX["^") S RAXX=$E(RAXX) S:RAXX="" RAXX="P" G SORT:RAXX="?" S RAXX=$$UP^XLFSTR(RAXX) I "PD"'[RAXX W *7," ??" G SORT
 I RAXX="D" S RASORT="RADTI" D DATE^RAUTL G Q:RAPOP S BEG=9999999-ENDDATE,END=9999999.9999-BEGDATE G ZIS
ASKSRT S RASORT="RAPRI"
 W ! K DIR S DIR(0)="YA",DIR("B")="Yes"
 S DIR("?")="Enter 'Y' to select a specific procedure, or 'No' not to."
 S DIR("A")="Do you wish to look for a specific procedure? "
 D ^DIR K DIR G:$D(DIRUT) Q
 S:'+Y BEG=0,END=999999 D:+Y PROC G:+Y=-1 Q
ZIS ; Device selection
 W ! S RAPRT=1,ZTRTN="START^RAPROS" F RASV="RANME","RASSN","BEG","END","RADFN","RASORT","RAPRT","^TMP($J,""RA I-TYPE"",","RAXX" S ZTSAVE(RASV)=""
 S ZTDESC="Rad/Nuc Med Exam Profile" D ZIS^RAUTL G Q:RAPOP
 S:IO=IO(0) RAPRT=0
START S RAX="" K ^TMP($J,"RASORT"),^("RASEQ") S (RAPAG,RASEQ)=0
 F RADTI=0:0 S RADTI=$O(^RADPT(RADFN,"DT",RADTI)) Q:RADTI'>0  D
 . I $D(^RADPT(RADFN,"DT",RADTI,0)) S RAZERO=$G(^(0)) D
 .. S RAELOC=$P($G(^SC(+$P($G(^RA(79.1,+$P($G(^RADPT(RADFN,"DT",RADTI,0)),U,4),0)),U),0)),U)
 .. S RADTPRT=+$P(RAZERO,U),RADTPRT=$E(RADTPRT,4,5)_"/"_$E(RADTPRT,6,7)_"/"_$E(RADTPRT,2,3)
 .. S (RADTE,Y)=+$P(RAZERO,"^") D D^RAUTL S RADATE=Y
 .. D RACN
 .. Q
 . Q
 I '$D(^TMP($J,"RASORT")) W !!?5,"For the above criteria, no registered exams filed for patient...",!?30,"...",RANME,"  ",RASSN,".",! G Q1
 U IO D PRT D CLOSE^RAUTL I RAX'=""!(RAPRT) D Q G ST2
ST1 W !,"CHOOSE FROM 1-",RASEQ,": " R RAX:DTIME I RAX["?" D HLP G ST1
 I RAX,'$D(^TMP($J,"RASEQ",RAX)) W !,*7,"You may only select one exam at a time.  Choose a number between 1 and ",RASEQ,"." G ST1
ST2 G Q1:'RAX S Y=^TMP($J,"RASEQ",RAX) F I=1:1:11 S @$P("RACN^RAPRC^RADATE^RAST^RADFN^RADTI^RACNI^RANME^RASSN^RADTE^RARPT","^",I)=$P(Y,"^",I)
 S Y(0)=^RADPT(RADFN,"DT",RADTI,"P",RACNI,0) D ^RAPROD D Q1 G PAT
Q1 K RAX,^TMP($J,"RASORT"),^("RASEQ")
Q ; Kill and quit
 K %,%W,%Y,%Y1,BEG,BEGDATE,C,DIROUT,DIRUT,DTOUT,DUOUT,END,ENDDATE,POP
 K RAPOP,RAA,RACN,RACNI,RADATE,RADFN,RADTE,RADTI,RAI,RAII,RANME,RASSN
 K RAPRC,RAPRT,RARPT,RASEQ,RASORT,RAST,RAPAG,RAZERO,RAXX,RAY,RAPRI,RASV
 K RADTPRT,RAELOC,X,Y,ZTDESC,ZTRTN,ZTSAVE
 K RAXIT,RAMES
 Q
RACN ; Get the case numbers.
 F RACNI=0:0 S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0  I $D(^(RACNI,0)) S Y=^(0) D STORE
 Q
STORE ; Store data in the ^TMP global
 S RAPRI=+$P(Y,"^",2),RAPRC=99 S:$D(^RAMIS(71,RAPRI,0)) RAPRC=$P(^(0),"^")
 S RAST=+$P(Y,"^",3),RACN=+Y,RARPT=+$P(Y,"^",17)
 I @RASORT>BEG,@RASORT<END F RAI=1:1 I '$D(^TMP($J,"RASORT",$S(RAXX="P":RAPRC,1:@RASORT),RAI)) S ^(RAI)=RACN_"^"_RAPRC_"^"_RADATE_"^"_RAST_"^"_RADFN_"^"_RADTI_"^"_RACNI_"^"_RANME_"^"_RASSN_"^"_RADTE_"^"_RARPT_"^"_RADTPRT_"^"_RAELOC Q
 Q
PRT ; Begin output
 S RAA="" D HD F RAI=0:0 Q:RAX["^"!(RAX>0)  S RAA=$O(^TMP($J,"RASORT",RAA)) Q:RAA=""  F RAII=0:0 S RAII=$O(^TMP($J,"RASORT",RAA,RAII)) Q:RAII'>0  S RAY=^(RAII) D PRT1 Q:RAX="^"!(RAX>0)
 Q
PRT1 G PRT2:RAPRT!(RASEQ#15)!('RASEQ) I '(RASEQ#15) W !,"Type '^' to STOP, or",!,"CHOOSE FROM 1-",RASEQ,": " R RAX:DTIME G PRT3:RAX="" Q:RAX["^"  I RAX["?" D HLP G PRT1
 I '$D(^TMP($J,"RASEQ",RAX)) W !,*7,"You may only select one exam at a time.  Choose a number between 1 and ",RASEQ,"." G PRT1
 S RAX=+RAX Q
PRT2 I ($Y+4)>IOSL,RAPRT D HD
PRT3 S RASEQ=RASEQ+1,^TMP($J,"RASEQ",RASEQ)=RAY
 N RADFN,RADTI,RACNI
 S RADFN=$P(RAY,"^",5),RADTI=$P(RAY,"^",6),RACNI=$P(RAY,"^",7)
 N RAPRTSET,RAMEMLOW D EN1^RAUTL20
 W !,RASEQ W:RASORT="RADTI" ?5,$S(RAMEMLOW:"+",RAPRTSET:".",1:" ")
 W ?6,$P(RAY,"^"),?11,$$IMGDISP^RAPTLU(+$P(RAY,"^",11))
 W ?13,$E($P(RAY,"^",2),1,26),?41,$P(RAY,U,12)
 W ?52,$S($D(^RA(72,$P(RAY,"^",4),0)):$E($P(^(0),"^"),1,16),1:"Unknown")
 W ?69,$E($P(RAY,U,13),1,11)
 Q
HD ; Generic header output
 W:$E(IOST,1,2)="C-"!(RAPAG) @IOF
 W "Profile for ",RANME,"  ",RASSN,?55,"Run Date: " S Y=DT D DT^DIO2 W !!,?20,"***** Registered Exams Profile *****"
 W !?3,"Case No.",?13,"Procedure",?41,"Exam Date",?52,"Status of Exam",?69,"Imaging Loc",!?3,"--------",?13,"-------------",?41,"---------",?52,"------------",?69,"-----------" Q
HLP ; Generic help
 W !!?3,"Enter the number corresponding to the exam you wish to select.",!
 Q
PROC ; Select Procedure
 N %,%Y,C,DA,DDH,DIC,X
 S DIC="^RAMIS(71,",DIC(0)="QEAMZ",DIC("A")="Select Procedure: "
 W !! D ^DIC
 S:+Y>0 BEG=Y-1,END=Y+1
 Q
