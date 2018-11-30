DVBCRPON ;ALB/GTS-557/THM-REPRINT C&P REPORTS ; 7/1/91  1:09 PM
 ;;2.7;AMIE;**2,32**;Apr 10, 1995
 ;
SETUP D HOME^%ZIS K ULINE S FF=IOF,HD="Reprint C & P Exams"
 S XDD=^DD("DD"),$P(ULINE,"_",70)="_"
 I $G(DUZ(2))<1 W !!,*7,"Your division code is invalid.",!! H 2 G EXIT
 S SUPER=0 I $D(^XUSEC("DVBA C SUPERVISOR",DUZ)) S SUPER=1
 ;
SETUP1 ;** Drops into if setup is ok
 W @IOF,!?(IOM-$L(HD)\2),HD,!!!
 S ONE="N",Y=DT X XDD
 S DVBCDT(0)=Y,PGHD="Compensation and Pension Exam Report",LOC=DUZ(2),PG=0,DVBCSITE=$S($D(^DVB(396.1,1,0)):$P(^(0),U,1),1:"Not specified")
 ;
RASK W !!,"Select Reprint Option - (D)ate or (V)eteran:  D// " R RTYPE:DTIME I RTYPE[U!('$T) G EXIT
 I RTYPE'=""&(RTYPE'="D"&(RTYPE'="d"&(RTYPE'="v"&(RTYPE'="V")))) S RTYPE="E"
 W:RTYPE="" "Date" W $S(RTYPE="D"!(RTYPE="d"):"ate",RTYPE="V"!(RTYPE="v"):"eteran",1:"") I RTYPE=""!(RTYPE="d") S RTYPE="D"
 I RTYPE="v" S RTYPE="V"
 I RTYPE'?1"D",RTYPE'?1"V" W !!,"Must be D or V" G RASK
 G:RTYPE="D" ADATE I RTYPE="V" S ONE="Y"
 ;
ONLYLAB ;** Dropped into if the user doesn't exit from RASK and selects to
 ;**  to reprint by veteran
 W !!,"Do you want just the Lab/X-ray results" S %=2 D YN^DICN I %=1 H 1 G REN^DVBCLABR ;** Branches to ^DVBCLABR which branches to ^DVBCPRNT
 I %=0 W !!,"Enter Y to get just the Lab/X-ray results for the Vet",!,"or N to get the entire exam results AND Lab/X-ray." H 2 G ONLYLAB
 ;
ADATE ;** Jumped into from RASK or dropped into from ONLYLAB
 I RTYPE="D" S %DT="AE",%DT("A")="Enter original printing date: ",%DT(0)=-DT D ^%DT G:+Y<0 EXIT S RUNDATE=+Y
 ;
WHO ;** Dropped into from ADATE
 W !!,"Reprinted by the RO or MAS ?   >> " R ANS:DTIME G:'$T EXIT I ANS=""!(ANS=U) G EXIT
 I ANS'="R"&(ANS'="r"&(ANS'="m"&(ANS'="M"))) S ANS="E"
 W $S(ANS="M"!(ANS="m"):"AS",ANS="R"!(ANS="r"):"O",1:"")
 S:ANS="r" ANS="R"
 S:ANS="m" ANS="M"
 I ANS'?1"R"&(ANS'?1"M") W !,"Must be R for Regional Office or M for MAS.",!!,*7 G WHO
 I ANS="R" K AUTO ;selects header type
 I ANS="M" S AUTO=1
 I ONE="Y" K OUT D ONEVET I $D(OUT) G EXIT
 ;
DEVICE ;** Dropped into from WHO
 W @IOF S %ZIS="AEQ",%ZIS("B")="0;P-OTHER",%ZIS("A")="Output device: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")),ONE="N" S ZTRTN="GO^DVBCRPRT",ZTIO=ION,ZTDESC="2507 Final Exam Reprint" F I="XDD","D*","PGHD","RTYPE","RUNDATE","Y","AUTO","LOC","ANS","ULINE","ONE" S ZTSAVE(I)=""
 I $D(IO("Q")),ONE="Y" S ZTRTN="OV^DVBCRPON",ZTIO=ION,ZTDESC="Single 2507 Final Exam Reprint" F I="XDD","D*","PGHD","RTYPE","RUNDATE","Y","AUTO","LOC","ANS","ULINE","ONE" S ZTSAVE(I)=""
 I $D(IO("Q")) D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued",!! H 1 G EXIT
 I ONE="N" G GO^DVBCRPRT
 I ONE="Y" G OV
 ;
ONEVET ;** Called from WHO when ONE=Y
 W !! S DIC("W")="D DICW^DVBCUTIL",DIC="^DVB(396.3,",DIC(0)="AEQM" D ^DIC I X=""!(X=U) S OUT=1 Q
 I +Y<0 W *7,"   ???" H 2 G ONEVET
 S DA=+Y
 S RO=$P(^DVB(396.3,DA,0),U,3) I RO'=DUZ(2)&('$D(AUTO))&(SUPER=0) W !!,*7,"Those results do not belong to your office.",!! H 3 G ONEVET
 I RO=DUZ(2)&('$D(AUTO))&("RC"'[($P(^DVB(396.3,DA,0),U,18))) W *7,!!,"This request has not been released to the Regional Office yet.",!! H 3 G ONEVET
 S PRTDATE=$P(^DVB(396.3,DA,0),U,16) I PRTDATE="" W *7,!!,"This has never been printed.",!! I SUPER=0 S OUT=1 H 3 Q
 Q
 ;
OV ;** Run as a background task or in real-time
 U IO S DA(1)=DA K DVBAON2 D SETLAB^DVBCPRNT,VARS^DVBCUTIL,STEP2^DVBCRPRT
 K AUTO D ^%ZISC I '$D(ZTQUEUED) G SETUP1
 ;
EXIT K AUTO S LKILL=1 D:$D(ZTQUEUED) KILL^%ZTLOAD G KILL^DVBCUTIL
 ;
 Q
