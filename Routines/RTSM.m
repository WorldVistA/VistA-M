RTSM ;MJK/TROY ISC;Site Manager's Menu; ; 4/21/87  2:05 PM ;
 ;;v 2.0;Record Tracking;**7**;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),17)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A D OVERALL^RTPSET Q:$D(XQUIT)
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Application
 W ! S DA=+RTAPL,DIE="^DIC(195.1,",DR="[RT APPL SET-UP (SITE MGR)]" D ^DIE K DE,DQ,DA,D0,DIE,DR Q
 ;
2 ;;File Room
L2 D FR G Q2:Y<0 S DA=+Y,DIE="^RTV(195.9,",DR="[RT FILE ROOM SET-UP (SITE MGR)]" D ^DIE K DQ,DE G L2
Q2 K X,Y,DA,D0,DR,DIE Q
 ;
FR W ! S DIC="^SC(",DIC("A")="Select File Room: ",DIC(0)="IAEMLQ",DIC("DR")="2///F",DIC("S")="I $P(^(0),U,3)=""F"",$S('$D(^RTV(195.9,""ABOR"",(Y_"";SC(""))):1,1:$D(^((Y_"";SC(""),"_+RTAPL_")))" D ^DIC K DIC Q:Y<0  D CHK^RTDPA3 Q
 ;
3 ;;File Room/Remote Set-up (site mgr)
 G SM^RTTR
 ;
4 ;;[]
 Q
 ;
5 ;;Overall Parameters
 W ! S DA=1,DIE="^DIC(195.4,",DR="[RT OVERALL PARAMETERS]" D ^DIE K DE,DQ,DR,DIE,DA,D0 Q
 ;
6 ;;Admitting Area
 D MAS Q:'Y
L6 D AA G Q6:Y<0 S DA=+Y,DIE="^RTV(195.9,",DR="[RT ADMIT SET-UP (SITE MGR)]" D ^DIE G L6
Q6 K DA,D0,DIE,DR Q
 ;
AA W ! S DIC="^SC(",DIC("A")="Select Admitting Area: ",DIC(0)="IAEMLQ",DIC("DR")="2///Z;2.1///AA"
 S DIC("S")="I $P(^(0),U,3)=""Z"",$D(^DIC(40.9,+$P(^(0),U,22),0)),$P(^(0),U,2)=""AA""" D ^DIC K DIC Q:Y<0  D CHK^RTDPA3 Q
 ;
7 ;;Imaging Area (Radiology)
 D RAD Q:'Y
L7 D RA^RTRAD G Q7:Y<0 S DA=+Y,DIE="^RTV(195.9,",DR="4" D ^DIE G L7
Q7 K DA,D0,DIE,DQ,DR,I,C Q
 ;
8 ;;Templates
 S %ZIS="N",%ZIS("A")="Select Report Device: " D ^%ZIS Q:POP  S RTION=ION K %ZIS
 F RTEMP="INPUT","SORT","PRINT" S Y="RT "_RTEMP_" TEMPLATES" W !!,"Record Tracking's ",RTEMP," Templates: " S (BY,FLDS)="["_Y_"]",L=0,DIC=$S(RTEMP="PRINT":"^DIPT(",RTEMP="SORT":"^DIBT(",1:"^DIE("),IOP="Q;"_RTION K DTOUT D EN1^DIP K BY,FLDS,L
 K IOP,RTION Q
 ;
9 ;;Initialize Records
 G 9^RTSM3
 ;
10 ;;Patient Labels
 G 10^RTSM3
 ;
11 ;;In-Patient Labels
 G 11^RTSM3
 ;
12 ;;Create Terminal Digit Sort Global
 G 12^RTSM1
 ;
13 ;;Delete Terminal Digit Sort Global
 G 13^RTSM1
 ;
14 ;;Initialize Borrowers
 S RTA=+RTAPL S Y="CLINICS" D ASK G Q14:RTASK="^"
 I RTASK="Y" F RTI=0:0 S RTI=$O(^SC(RTI)) Q:'RTI  I $D(^SC(RTI,0)),$P(^(0),"^",3)="C",$S('$D(^("I")):1,'^("I"):1,DT<+^("I"):1,'$P(^("I"),"^",2):0,DT>+$P(^("I"),"^",2):1,1:0) S RTB=RTI_";SC(" D RTB
 W:RTASK="Y" "...Done" S Y="WARDS" D ASK G Q14:RTASK="^"
 I RTASK="Y" F RTI=0:0 S RTI=$O(^DIC(42,RTI)) Q:'RTI  I $D(^DIC(42,RTI,0)) N D0,X S D0=RTI D WIN^DGPMDDCF I 'X S RTB=RTI_";DIC(42," D RTB
 W:RTASK="Y" "...Done" S Y="PROVIDERS" D ASK G Q14:RTASK'="Y" W !!,"OK.  This may take awhile..."
 F RTI=0:0 S RTI=$O(^VA(200,RTI)) Q:'RTI  I $D(^VA(200,RTI,0)),$S('$D(^("I")):1,'^("I"):1,^("I")>DT:1,1:0) S RTB=RTI_";VA(200," D RTB
Q14 W:RTASK="Y" "...Done" K RTASK,RTI,RTB,RTA
 K X1,Y,X,I,J Q
ASK S RTRD(1)="Yes^initialize/update "_Y_" as borrowers",RTRD(2)="No^not initialize/update "_Y_" as borrowers",RTRD("B")=2,RTRD(0)="S",RTRD("A")="Initialize active '"_Y_"' as "_$P($P(RTAPL,"^"),";",2)_" borrowers? "
 D SET^RTRD K RTRD S RTASK=$E(X) Q
 ;
RTB S Y=+$O(^RTV(195.9,"ABOR",RTB,RTA,0)) D SET^RTDPA3:'Y W "." Q
 ;
15 ;;Re-compile
 G BOTH^RTUTL5
 ;
16 ;;Clinic Request Init
 G 16^RTSM4
 ;
17 ;;Purge Data
 G ^RTPURGE
 ;
18 ;;1 Clinic Request Init
 G 18^RTSM5
 ;
19 ;;Dailey Clinic Request Init
 G 19^RTSM6
 ;
MAS S Y=1 I $S('$D(^DIC(195.4,1,"MAS")):1,+^("MAS")'=+RTAPL:1,1:0) W !!?3,*7,"Current application is not the 'Medical Records' application." S Y=0
 Q
 ;
RAD S Y=1 I $S('$D(^DIC(195.4,1,"RAD")):1,+^("RAD")'=+RTAPL:1,1:0) W !!?3,*7,"Current application is not the 'Film Tracking' application." S Y=0
 Q
 ;
BOTH K RADPT I $D(^DIC(195.4,1,"MAS")),+^("MAS")=+RTAPL S RADPT=0 Q
 I $D(^DIC(195.4,1,"RAD")),+^("RAD")=+RTAPL S RADPT=1 Q
 W !!?3,*7,"Current application is not the 'Film Tracking' nor the"
 W !?3,"'Medical Records' application." Q
