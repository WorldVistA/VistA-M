DENTCRDI ;ISC2/HCD,SAW-INITIALIZE CARD READER ; 6/27/88  3:49 PM ;
 ;VERSION 1.2
 S Z1=0 G:'$D(^DENT(225,0)) W F Z3=0:1:2 S Z1=$O(^(Z1)) Q:Z1'>0  S Z2=Z1
 G:Z3=0 W I Z3>1 S DIC="^DENT(225,",DIC(0)="AEMNQZ" D ^DIC G EXIT:Y<0
 S Z=$S(Z3=1:Z2,1:+Y) G W:'$D(^DENT(225,Z,0)) S IOP=$P(^(0),"^",2) G W:IOP=""
 D ^%ZIS I POP W !,"The port is in use.  Try again later" G EXIT
 K IOP S X1="4 0 0 50 85 10 4 0 9 3 25 6 0 0 1 0 0 1 1 0 0 0 0 0 0 0 0 75 1 1 0 ",Z(1)=0 W !,"Initializing card reader" U IO X ^%ZOSF("TYPE-AHEAD")
INIT U IO W *27,"Z0",*13 H 1
 W *27,"C14800",*13 H 1 W *27,"M150",*13 H 1 W *27,"M310",*13 H 1
 W *27,"M69",*13 H 1 W *27,"M975",*13 H 1 W *27,"O16",*13 H 1
 W *27,"H71",*13 H 1 W *27,"M44",*13 H 1 W *27,"T51",*13 H 1
 W *27,"S",*13 R X:5 I X'=X1 S Z(1)=Z(1)+1 U IO(0) G C:Z(1)=5 W !,"Card reader did not respond correctly.  I will try to initialize it again." G INIT
 W *27,"R",*13 G W2
C S Z(1)=0
C1 U IO W *18,"R7777",*18,"H00",*18,"E",*13 H 1
 R X:5 I X'="G" S Z(1)=Z(1)+1 U IO(0) G W1:Z(1)=5 W !,"Card reader did not respond correctly.  I will try to initialize it again." G C1
 G W2
W W !!,"A card reader device has not been entered for your station in the Dental Site",!,"Parameter file.  One must be entered before you can run this option" G EXIT
W1 W !!,"Initialization unsuccessful after 8 attempts.  Initialization aborted" G EX
W2 U IO(0) W !!,"Initialization complete."
EX X ^%ZIS("C")
EXIT S IOP=$I D ^%ZIS K DIC,IOP,X,X1,Y,Z,Z1,Z2,Z3 Q
