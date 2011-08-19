RTSM2 ;MJK/TROY ISC;Record File Initialization Utility; ; 5/27/87  9:17 AM ;
 ;;v 2.0;Record Tracking;;10/22/91 
SEL K RTHOLD W !!?5,"For each patient, the following records",$S('$D(RTION):"",RTION]"":" and labels",1:"")," will be created:"
 S Y=+$P(RTAPL,"^",10) D TYPE1^RTUTL G SELQ1:'$D(RTTY) W !?20,$P($P(RTTY,"^"),";",2) S Y=+RTTY,RTN=0 K ^TMP($J,"RT") D SET
 F I=0:0 S I=$O(^DIC(195.2,+RTTY,"LINKED",I)) Q:'I  I $D(^(I,0)) S I1=+^(0) I $D(^DIC(195.2,I1,0)) W !?20,$P(^(0),"^") S Y=I1 D SET
SEL1 K RTDEL R !!,"Select Type of Record: ",X:DTIME D HELP:$E(X)="?" G SEL1:'$D(X),SELQ:X=""!(X["^") S:$E(X)="-" RTDEL="",X=$E(X,2,99)
 S DIC(0)="IEMNQ",DIC="^DIC(195.2,",DIC("S")="I $P(^(0),U,3)="_+RTAPL_",$P(^(0),U,15)'=""y""" D ^DIC K DIC G SEL:X["?" I Y>0 S Y=+Y D ARRAY1^RTUTL1 G SEL1
SELQ I '$D(^TMP($J,"RT")) W !?3,"...no types of records selected" G SELQ1
 S RTHOLD="" F I=0:0 S I=+$O(^TMP($J,"RT","XREF",I)) Q:'I  S RTHOLD=RTHOLD_I_"^"
 S Y=$S('$D(RTION):"",RTION]"":" and labels",1:""),RTRD(1)="Yes^ok to create records"_Y,RTRD(2)="No^do NOT create records"_Y,RTRD("B")=2
 S RTRD("A")="Do you want to create these records"_Y_"? ",RTRD(0)="S" D SET^RTRD K RTRD I $E(X)'="Y" K RTHOLD
SELQ1 K RTDEL Q
 ;
HELP W !!,"Types of Records already selected:" F I=0:0 S I=+$O(^TMP($J,"RT","XREF",I)) Q:'I  W !?10,I," - ",$P(^DIC(195.2,I,0),"^")
 W !!?3,"Also, you can delete a selected type by entering a",!?3,"'minus' sign(-) before the type number (eg. Select Record: -2).",!
 Q
 ;
SET S RTN=RTN+1,^TMP($J,"RT","AR",RTN)=+Y,^TMP($J,"RT","XREF",+Y)=RTN Q
 ;
TERM K RTERM D LIST S RTC=100,RTRD("A")="Select Terminal Digits: ",RTSEL="S" D SEL^RTRD I $D(RTY(51)) W !?3,*7,"...allowed to choose a maximum of fifty terminal digits at a time." G TERM
 I $D(RTY) S Y=RTY($O(RTY(0))),RTERM="" F I=0:0 S I=$O(RTY(I)) Q:'I  S RTERM=RTERM_RTY(I)_"^"
 I $D(RTERM),RTLOAD="PAT^RTSM3" D BEG I '$D(RTSTART) K RTERM G TERM
TERMQ K RTC,I,I1,RTS,RTY,RTRD,RTSEL Q
 ;
LIST W !!?5,"Selecting...",?20,"Chooses patients with SSN's ending with..."
 F I=1:1:100 S I1=$S(I=100:"00",I<10:"0"_I,1:I) W:I<12!(I>97) !?10,I,?35,I1 W:I>12&(I<16) !?10,".",?35,"." S RTS(I)=I1
 Q
 ;
BEG S X1="0000000"_Y W !!,"Printing will start at SSN#: ",X1,"// " R X:DTIME G BEGQ:'$T!(X["^") I X'="",X'?9N S X="?"
 I X["?" W !!,"Enter an SSN# that ends with '",Y,"'." G BEG
 S:X="" X=X1 I X?9N,$E(X,8,9)=Y S X=$E(X,8,9)_$E(X,6,7)_$E(X,1,5),RTSTART=$S($E(X):X-1,1:$E(X,1,8)_$C($A($E(X,9))-1))
 W:'$D(RTSTART) !!,*7,"Starting SSN must end with '",Y,"'."
BEGQ Q
