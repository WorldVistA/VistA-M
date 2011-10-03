RTRPT ;MJK/TROY ISC;Management Reports Option; ; 5/20/87  4:33 PM ;
 ;;v 2.0;Record Tracking;**1**;10/22/91 
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),9)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A D OVERALL^RTPSET Q:$D(XQUIT)
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
 ;
1 ;;Missing Records Report
 S L=0,DIC="^RTV(190.2,",FLDS="[RT MISSING]",BY="[RT MISSING]",FR="",TO="",DIS(0)="I $D(^RT(+^RTV(190.2,D0,0),0)),$P(^(0),U,4)=+RTAPL" K DTOUT D EN1^DIP K FLDS,BY,FR,TO,DIS(0),L,X,DHD Q
 ;
2 ;;Records Charged to a Borrower
 G ^RTRPT2
 ;
3 ;;Overdue Records List
 G 3^RTRPT3
 ;
4 ;;Pending Requests for a Borrower
 G PEND^RTRPT1
 ;
5 ;;Pending Requests List
 D DIV^RTP4 G Q5:'$D(RTDV) S RTDV=$P($P(^DIC(4,+RTDV,0),"^"),","),RTPCE=9 D WINDOW G Q5:RTWND=9999999
 S RTRD(1)="Yes^include clinic appointment requests",RTRD(2)="No^not include clinic appointment requests",RTRD(0)="S",RTRD("B")=2,RTRD("A")="Do you want to include unfilled clinic requests? " D SET^RTRD K RTRD S X=$E(X) G Q5:X="^"
 S DIS(0)="I $D(^RTV(190.1,D0,0)) S Z=^(0) I $P(Z,U,6)=""r""!($P(Z,U,6)=""n"")"_$S(X="Y":"",1:",'$P(Z,U,10)")_",$D(^RT(+Z,0)),$D(RTWND(+$P(^(0),U,3))),RTWND(+$P(^(0),U,3))'>$P(Z,U,4)"
 S:RTDEV]"" %ZIS("B")=RTDEV S DIOEND="W !?5,""Total Requests Pending: "",RTCOUNT",RTCOUNT=0,FR=RTWND_","_RTDV D NOW^%DTC S TO=%_","_RTDV_"z",DIC="^RTV(190.1,",L=0,(BY,FLDS)="[RT PENDING REQUESTS]" K DTOUT D EN1^DIP
Q5 K RTDEV,DIS,RTPCE,RTCOUNT,DIOEND,RTWND,RTDV,FR,TO,BY,FLDS,DIC,X,X1,DHD,B,L Q
 ;
CPND D W1 Q
PND S RTPCE=9
WINDOW ;calculates overdue,pending date window for each type of record
 S:'$D(RTPCE) RTPCE=11 K RTWND S RTWND=9999999
 F RTI=0:0 S RTI=$O(^DIC(195.2,"C",+RTAPL,RTI)) Q:'RTI  I $D(^DIC(195.2,RTI,0)),$S(RTPCE'=9:1,1:$P(^(0),"^",14)="y") S X1=DT,X2=-$P(^(0),"^",RTPCE) S:'X2 X2=-1 D C^%DTC S RTWND(RTI)=X S:X<RTWND RTWND=X
 D W2 Q
W1 ;positive window logic for checkin-pending
 K RTWND S RTWND=99999999
 N L0,L1 F RTI=0:0 S RTI=$O(^DIC(195.2,"C",+RTAPL,RTI)) Q:'RTI  I $D(^DIC(195.2,RTI,0)),$P(^(0),U,14)="y" S L0=$P(^(0),U,9),L1=$S($D(^(1)):$P(^(1),U),1:""),X1=DT,X2=$S(L1]"":L1,L0:-L0,1:-1) I X2 S:L1]"" X2=X2-1 D W3
 ;
W2 K RTPCE,RTI Q
W3 D C^%DTC S RTWND(RTI)=X S:X<RTWND RTWND=X Q
 ;
6 ;;Charged Records By Home Location
 G 6^RTRPT3
 ;
7 ;;Inpatient Record List
 S RTRD(1)="All^print record locations for all inpatients",RTRD(2)="Range^print record locations for a range of admission dates",RTRD(0)="S",RTRD("B")=2,RTRD("A")="'ALL' inpatients or 'Range' of admissions? " D SET^RTRD K RTRD S X=$E(X)
 G Q7:X="^" I X="A" K DHD S BY="[RT ALL INPATIENTS]",(FR,TO)=",," G PRT
 W ! K %DT S %DT="AETX",%DT("A")="Beginning Admission Date/Time: " D ^%DT G Q7:Y<0 S (%DT(0),RTBEG,FR)=Y_","
 W ! S %DT="AETX",%DT("A")="Ending    Admission Date/Time: " D ^%DT K %DT G Q7:Y<0 W ! S (RTEND,TO)=$S(Y[".":Y,1:Y_".99")_","
 S Y=RTBEG D D^DIQ S DHD="Record Location Lists for In-patients Admitted from "_Y_" to ",Y=$P(RTEND,".") D D^DIQ S DHD=DHD_Y,BY="[RT WARD LIST]"
 D ^RTRPT5 G Q7
PRT S DIC="^DPT(",FLDS="[RT WARD LIST]",FR=FR_$P($P(RTAPL,"^"),";",2),TO=TO_$P($P(RTAPL,"^"),";",2),L=0 K DTOUT D EN1^DIP
Q7 K %DT,FLDS,TO,FR,BY,DHD,L,RTBEG,RTEND
 K X,X1 D CLOSE^RTUTL Q
 ;
8 ;;Request Response Statistics
 G ^RTRPT4
 ;
9 ;;Loose Filing List
 S DIC="^RT(",BY="[RT LOOSE FILING]",FLDS="[RT HOME LOCATION]",DHD="Loose Filing List [Sort: Terminal Digits] ["_$P($P(RTAPL,"^"),";",2)_"]",DIS(0)="I $D(^RT(D0,0)),$P(^(0),U,4)="_+RTAPL K DTOUT D EN1^DIP K BY,FLDS,TO,FR,DHD,X Q
 ;
10 ;;Retrieval Rate
 G ^RTREP
