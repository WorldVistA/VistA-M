RTSYS ;TROY ISC/MJK-Record Tracking System Definition Menu ; 5/19/87  11:34 AM ; 4/10/03 3:27pm
 ;;2.0;Record Tracking;**21,29,35,37,40**;10/22/91
 D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),9)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A D OVERALL^RTPSET Q:$D(XQUIT)
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Type of Record Set-up
 W ! S DIC("DR")="3////"_+RTAPL,DIC("A")="Select Record Type: ",DIC(0)="IAEMLQ",DIC("S")="I $P(^(0),U,3)=+RTAPL",DIC="^DIC(195.2,",DLAYGO=195.2 D ^DIC K DIC,DLAYGO G Q:Y<0 S DA=+Y
 S DIE="^DIC(195.2,",DR="[RT TYPE SET-UP]" D ^DIE K DQ,DE G 1
Q K DA,D0,DIC,DIE,DR,I,C,P,X,Y,RT0 Q
 ;
2 ;;File Room Set-up
L2 D FR^RTSM G Q:Y<0 S DA=+Y,DIE="^RTV(195.9,",DR="[RT FILE ROOM SET-UP]" D ^DIE K DQ,DE G L2
Q2 Q
 ;
3 ;;Application Set-up
 W ! S DA=+RTAPL,DIE="^DIC(195.1,",DR="[RT APPL SET-UP]" D ^DIE K DE,DQ G Q
 ;
4 ;;Reasons File Set-up
L4 W ! S DIC("DR")="3////"_+RTAPL,DIC("A")="Select Reason: ",DIC(0)="IAEMLQ",DIC("S")="I $P(^(0),U,3)=+RTAPL",DIC="^DIC(195.6," D ^DIC K DIC G Q:Y<0 S DA=+Y
 S DIE="^DIC(195.6,",DR="[RT REASON SET-UP]" D ^DIE K DQ,DE G L4
Q4 Q
 ;
5 ;;Label Function Menu
 G ^RTL
 ;
6 ;;Individual Borrower Set-up
L6 W ! S A=+RTAPL D DIC^RTDPA31 S DIC="^RTV(195.9,",DIC("A")="Select Borrower: ",DIC(0)="IAELMQ",DIC("S")="S Z0=^(0),Z=$P($P(Z0,U),"";"",2) I $P(Z0,U,3)="_+RTAPL_" D DICS1^RTSYS" D ^DIC K DIC G Q6:Y<0
 ;
 D BOR G L6
Q6 K RTDA G Q
 ;
BOR S DA=+Y,DR="[RT BORROWER SET-UP]",DIE="^RTV(195.9," D ^DIE K DE,DQ Q
 ;
7 ;;[FOR FUTURE USE]
 ;
TFR W ! S DIC(0)="IAEMQ",DIC="^DIC(4,",DIC("A")="Transfer Institution: " D ^DIC K DIC Q:Y<0  S RTA=+RTAPL,RTB=+Y_";DIC(4,",Y=+$O(^RTV(195.9,"ABOR",RTB,RTA,0)) D SET^RTDPA3:'Y K RTB,RTA
 Q
 ;
8 ;;Print Borrower Label
 I $S('$D(^DIC(194.4,+$P(RTAPL,"^",3),0)):1,$P(^(0),"^",4)'="b":1,$P(^(0),"^",3)'=+RTAPL:1,1:0) W !?3,*7,"No valid borrower label format assigned for application." G Q8
 S DIC("A")="Select Borrower: ",DIC="^RTV(195.9,",DIC(0)="IAEMLQ",DIC("DR")="3////"_+RTAPL,DIC("S")="I $P(^(0),U,3)="_+RTAPL D ^DIC K DIC G Q8:Y<0
 S:$D(RTFR) RTION=$P(RTFR,"^",4) S RTIFN=+Y,RTFMT=+$P(RTAPL,"^",3),RTMES="W !?3,""...Barcode label has been queued to print on device "",RTION,"".""",RTNUM=1 D Q^RTL1 G 8
Q8 K RTFMT,RTA,RTIFN,RTION,RTNUM,RTMES G Q
 ;
9 ;;Add/Edit 'PERSON' Borrower
 ;W ! S DIC="^VA(200,",DIC(0)="IAEQELM" D ^DIC K DIC G Q:Y<0 D CHK^RTDPA3,BOR:Y>0 G 9
Q9 Q
 ;
OTHER ;
 W !!,"Applications Using this 'PERSON' borrower:" S I=0 F A=0:0 S A=$O(^RTV(195.9,"ABOR",$P(Y,"^",2),A)) Q:'A  S I=I+1 W !?5,"- ",$S($D(^DIC(195.1,A,0)):$P(^(0),"^"),1:"UNKNOWN")
 W:'I !!?5,*7,"No applications use this 'PERSON'." W !!,"Be careful when changing the 'NAME' of this 'PERSON' borrower." K A,I Q
 ;
10 ;;Movement Type Set-up
 W ! S DIC="^DIC(195.3,",DIC(0)="IAEMQ",DIC("S")="I $P(^(0),U,3)="_+RTAPL,DIC("A")="Select MOVEMENT TYPE: " D ^DIC K DIC G Q:Y<0 S DA=+Y,DIE="^DIC(195.3,",DR="[RT MOVEMENT SET-UP]" D ^DIE K DE,DR,DQ G 10
 Q
 ;
DICS1 ; DICS1^RTDPA31 is called by multiple routines
 ;       copied from RTDPA31 isolate changes needed for patch RT*2*37
 I '$D(^DIC(195.1,+$P(Z0,"^",3),"BOR","AC",Z)) X "I 0" G DICSQ
 I Z="DIC(4,",$S('$D(^DIC(195.1,+$P(Z0,U,3),0)):1,$P(^(0),U,8)']"":1,1:'$D(^XUSEC($P(^(0),U,8),DUZ))) X "I 0" G DICSQ
 I "SC(;DIC(42,"'[Z G DICSQ
 ;inactive flags check
 ;
 I Z="SC(" S Z1=$S('$D(^SC(+Z0,"I")):1,'^("I"):1,DT<+^("I"):1,'$P(^("I"),"^",2):0,+$P(^("I"),"^",2):1,1:0) X "I Z1" G DICSQ
 I Z="DIC(42," N D0,X S D0=+Z0 D WIN^DGPMDDCF X "I 'X" G DICSQ
 ;
DICSQ K Z,Z0,Z1 Q
