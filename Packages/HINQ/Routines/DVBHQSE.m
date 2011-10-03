DVBHQSE ;ISC-ALBANY/PKE-Select view Hinq suspense file ; 04 OCT 85  12:46 pm
 ;;V4.0;HINQ;;03/25/92 
SHOW S DVBVIEW=1,DVBTSK=0,U="^",H=1
 ;
SEL S DVBSEL=""
 W !,"Do you wish to "_$S(DVBVIEW:"view ",1:"see ")_$S(DVBVIEW:"all ",1:"pending and IDCU ")_"entries ? "_$S(DVBVIEW:"ALL",1:"PENDING & ABBREVIATED")_"// " R X:DTIME
 G:'$T!(X["^") EX
 I "AENP"[$E(X_1) S DVBSEL=X
 I X="ALL"!(X=""),DVBVIEW S DVBSEL="AENP"
 I X="?" W !,"Enter ALL or first letter(s) of file status you wish to see " G SEL
 I DVBSEL=""!(X="??") W !,"Enter 'A'bbreviated, 'P'ending, 'N'ew mail, 'E'rror " G SEL
 ;
 S %ZIS="FMQ" D ^%ZIS G EX:POP I $D(IO("C"))!($D(IO("Q"))) D TSK,^%ZTLOAD X ^%ZIS("C") G EX
 U IO D HDR,LIST X ^%ZIS("C")
 ;
EX K DVBVIEW,DVBSTAT,DVBUSER,DVBT,DVBTM,DVBDAY,Y0,H,DVBSHOW,DVBN,X,Y,Z,R,IO("C"),IO("Q"),DVBSEL,DVBTSK,DFN,ZTSK,POP
 Q
QUE S U="^",H=1,DVBVIEW=1,DVBTSK=ZTSK D HDR,LIST G EX
 ;
LIST F DVBT=0:0 Q:'H  S DVBT=$O(^DVB(395.5,"C",DVBT)) Q:'DVBT  F DFN=0:0 S DFN=$O(^DVB(395.5,"C",DVBT,DFN)) Q:'DFN  Q:'$D(^DVB(395.5,DFN,0))  S DVBN=^(0),DVBTM=$P(DVBN,U,3),DVBSTAT=$P(DVBN,U,4) I DVBSEL[DVBSTAT K R D WRTDFN Q:'H
 Q
 ;
WRTDFN I 'DVBVIEW,$D(DVBSTAT),DVBSTAT="PV" D HDR
 W:$D(^DPT(DFN,0)) !,$E($P(^(0),U,1),1,20),?22,$E($P(^(0),U,9),1,10),?34,"..",DVBSTAT,".." S Y=DVBTM D TM W Y
 ;
 F DVBUSER=0:0 S DVBUSER=$O(^DVB(395.5,DFN,1,DVBUSER)) Q:'DVBUSER  S R(DVBUSER)="^"_$P(^(DVBUSER,0),U,2)
 F DVBUSER=0:0 S DVBUSER=$O(R(DVBUSER)) Q:'DVBUSER  I $D(^VA(200,DVBUSER,0)) S $P(R(DVBUSER),U,1)=$P(^(0),U,1)
 ;
WRTUSER F DVBUSER=0:0 S DVBUSER=$O(R(DVBUSER)) Q:'DVBUSER  S Y=$P(R(DVBUSER),U,2) D TM W ?52,$E($P(R(DVBUSER),U,1),1,15),?68,Y,!
 I DVBVIEW D:$Y>(IOSL-6) SROLL
 Q
ABS S Y0=255-Y0 Q:($Y+Y0)<(IOSL-2)
SROLL ;
 I IOST["C",'DVBTSK W $C(7),"Press Enter to continue or '^' to escape " R X:DTIME I '$T!("^."[$E(X_1,1)) S H=0 Q
HDR W @IOF W "Patient",?23,"SSN",?33,"..status..time",?57,"Requested by",! Q
 ;
TM S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".") Q
 ;
 Q
TSK K IO("C"),IO("Q") X ^%ZOSF("UCI") S ZTUCI=Y,ZTRTN="QUE^DVBHQSE",ZTSAVE("DVBSEL")="",ZTDESC="This job is the select view of the HINQ Suspense file."
 Q
