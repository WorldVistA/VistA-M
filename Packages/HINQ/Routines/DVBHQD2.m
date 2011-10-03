DVBHQD2 ;ALB/CMM - INDIVIDUAL HINQ ; 7/7/05 11:15am
 ;;4.0;HINQ;**22,33,34,43,49**;03/25/92 
 ;
KTO K TRY,CN,DVBZ0,DVBZ1 Q
 ;
DOT U IO(0) W "." U IO Q
 ;
ABS S Y0=255-Y0 Q:($Y+Y0)<(DVBIOSL-4)
 ;
SROLL Q:DVBIOST'["C-"!($D(DVBJDX))  U IO(0) W !,$C(7),"Press Enter to continue or '^' to quit" R X:DTIME S:'$T X="^" W @DVBIOF S Y0=$Y Q
 ;
REQENT U IO(0) W !,"Request being processed " U IO Q
 ;
RECMAL U IO(0) W !,"Response received and mailed" Q
 ;
LOAD2 ;
 U IO(0) W !!
 I $D(DVBRTC) W $S(DVBRTC>3:"Received 'Missing Character' more than 9 times.",1:"")
 W !,"Try again later."
 S IO=DVBIO U IO(0) K DVBP,DVBMISS S DVBABORT=0
 G ASK^DVBHQD1
 Q
LOAD ;
 U IO(0) W !!
 I $D(DVBRTC) W $S(DVBRTC>3:"Received 'Missing Character' more than 9 times.",1:"")
 U IO(0) W !," Request loaded into the HINQ Suspense file with a status of Pending."
 Q 
RETRY ;
 N ANS
 S DVBRTC=DVBRTC+1 I DVBRTC>3 S DVBNRT="N" Q
 U IO(0) R !!,"Received 'Missing Character' 3 times,",!,"Would you like to try again (Y/N)? Y//",ANS:DTIME
 I ('$T)!(ANS["^")!("N"=$E(ANS))!("n"=$E(ANS)) S DVBNRT="N" Q
 I ANS["?" W !!,"Enter Y to try again or N to Quit",!! G RETRY
 I (ANS="")!("Yy"[$E(ANS)) S DVBNRT="Y",DVBTRY=1 W !! Q
 G RETRY
 ;
SEND K X U IO F Z=1:1:1000 R *X:0 Q:'$T
 W $S('TRY:DVBZ0,1:DVBZ1),$C(13),! S DVBECHO=$P($H,",",2)
 ;
REC ;;;U IO R X:10 S DVBECHO=$P($H,",",2)-DVBECHO I 'DVBTSK D REQENT^DVBHQD2
 ;;;I '$L(X) S DVBABORT=DVBABORT+1 U IO(0) W:'DVBTSK "No response" H 1 Q
 ;
 S F4=5
 F Z=1:1:10 R X(1)#512:33 Q:$L(X(1))&(X(1)'=$C(10))  D:DVBXM DOT
 S F1=$F(X(1),DVBEND) G:F1 OK^DVBHQD1
 ;
 ;added with DVB*4*49 to make loops more robust and to add more 
 ;iterations of the loop if needed
 N DVBC,DVBCT
 S DVBCT=0
 F DVBC=2:1:30 D LOOP Q:DVBCT=1
 I DVBCT=0 S DVBABORT=DVBABORT+1
 Q
LOOP ;
 F Z=1:1:4 R X(DVBC)#512:5 Q:$L(X(DVBC))!DVBCT=1  D:DVBXM DOT
 S F1=$F(X(DVBC),DVBEND) I F1 S DVBCT=1 G OK^DVBHQD1
 S W=DVBC D CH^DVBHQD1 I F1 S DVBCT=1 G OK^DVBHQD1
 Q
