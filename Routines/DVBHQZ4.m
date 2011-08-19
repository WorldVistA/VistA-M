DVBHQZ4 ;ISC-ALBANY/PKE-enter in Suspense File ; 8/25/87  16:05 ;
 ;;V4.0;HINQ;;03/25/92 
 D DIV,TELL,FIND G EX
 Q
FIND S DIC="^DPT(",DIC(0)="AEMQZ" D ^DIC Q:+Y'>0  S DFN=+Y D VER W:$D(DVBVER) !,?20,"Verified" W:'$D(DVBVER) !,?15 D EN^DVBHQUT G FIND
 Q  ;G EX
 ;
EN I $D(^DVB(395.5,DFN,0)),"PNEA"[$P(^(0),U,4) W !,$C(7),"A HINQ Request has already been made for this patient",!,"Do you wish to make another Request"
 E  W !,"Do you wish to request a HINQ inquiry  "
AGAIN S %=2 D YN^DICN I %=1 S DVBDIV=0 D EN^DVBHQUT G EX1
 I %Y'["?" G EX1
 D H1 G AGAIN
 ;
EX K DFN,%
EX1 K X,%Y,C,D0,D1,DA,DVBO,DI,DIC,DIE,DK,DL,DOW,DR,Z,DVBDIV,DVBDIVN,Y,DVBVER,DVBSTOP,DVBKEY,DVBTIM,DVBGO,DVBZ,DVBNUM,DVBP QUIT
 ;
VER K DVBVER I $D(DFN),$D(^DPT(DFN,.361)),$P(^(.361),"^",1)="V" S DVBVER="" Q
 Q
 ;
DIV S DVBDIV=0 I $D(^DVB(395,1,"HQ")),$P(^("HQ"),U,13) S DVBDIV=$P(^DG(43,1,"GL"),U,3) I DVBDIV
 E  Q
 S DIC(0)="AZEQMN",DIC="^DG(40.8,",DIC("A")="Select Medical Center Division: ",DIC("B")=DVBDIV
 S X=DVBDIV D ^DIC I +Y>0 S DVBDIV=+Y,DVBDIVN=$S($D(Y(0,0)):Y(0,0),1:$P(Y,U,2))
 K DIC("A"),DIC("B") Q
 ;
TELL I DVBDIV,$D(DVBDIVN) W !,"The HINQ response will show the '"_DVBDIVN_"' division",!
 Q
 ;
HINQ I $D(DUZ)#2'=1 W !,"DUZ not defined",! Q
 I $D(^VA(200,DUZ,.1)) S DVBNUM=$P(^(.1),U,9) I DVBNUM
 E  W !,"  HINQ Employee Number not in New Person file",!,"  Notify System Manager",! Q
 S DVBGO=0
 W !!,"Select patients, enter your Password and HINQ requests will be sent",!
 ;
 D DIV,TELL,AGN G EX
 ;
AGN S DIC="^DPT(",DIC(0)="AEMQZ" D ^DIC I +Y>0 S DVBGO=DVBGO+1,DFN=+Y D VER W:$D(DVBVER) !,?25,"Verified"
 G:Y'>0 PAS
 I $D(^DVB(395.5,DFN,0)),"PNE"[$P(^(0),U,4) W !,$C(7),"A HINQ Request has already been made for this patient",!,"Do you wish to make another Request"
 E  D ^DVBHQUT G AGN
ASK S %=2 D YN^DICN I %=1 S DVBGO=DVBGO+1 D ^DVBHQUT G AGN
 I %Y["?" D H2 G ASK
 I %=2 S DVBGO=DVBGO-1 G AGN
PAS I DVBGO>0 W ! D PASS^DVBHQDB
 Q  ;G EX
 ;
H1 W !!,"Answer 'Y'es to enter a Request in the HINQ suspense File" D H3 Q
 ;
H2 W !!,"Answer 'Y'es to enter a Request in the HINQ suspense File" W:DVBDIV !,"The HINQ responses will show the '"_DVBDIVN_"' Division"
 W !,"When you enter the HINQ password all 'P'ending requests in the",!,"HINQ suspense file will be processed"
 ;
H3 W !!,"Do you wish to request a HINQ inquiry " Q
