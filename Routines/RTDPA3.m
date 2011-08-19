RTDPA3 ;TROY ISC/MJK-Borrower File Look-up ; 5/19/87  11:23 AM ; 1/30/03 8:35am
 ;;2.0;Record Tracking;**21,33**;10/22/91 
 S DIC("S")="D DICS^RTDPA31",DIC("V")="D DICV^RTDPA31",DIC("DR")="3////"_RTA,DIC="^RTV(195.9," D ^DIC K DIC,RTB S:Y>0 RTB=$P(Y,"^",2) Q
 ;
CHK S RTA=+RTAPL,RTB=+Y_";SC(",Y=+$O(^RTV(195.9,"ABOR",RTB,RTA,0)) D SET:'Y K RTA,RTB Q
 ;
SET S I=$P(^RTV(195.9,0),"^",3)
LOCK S I=I+1 L +^RTV(195.9,I):1 I '$T!$D(^RTV(195.9,I)) L -^RTV(195.9,I) G LOCK
 S ^RTV(195.9,I,0)=RTB_"^^"_RTA,^RTV(195.9,"B",RTB,I)="",^(0)=$P(^RTV(195.9,0),"^",1,2)_"^"_I_"^"_($P(^(0),"^",4)+1),^DISV($S($D(DUZ)'[0:DUZ,1:0),"^RTV(195.9,")=I,^RTV(195.9,"ABOR",RTB,RTA,I)=""
 I RTB[";SC(" S X=^RTV(195.9,I,0),$P(X,"^",2)=+RTB,$P(X,"^",13)=$P(^SC(+RTB,0),"^",3),$P(X,"^",8,9)=$S($D(^(99)):$P(^(99),"^"),1:"")_"^"_$P(^(0),"^",11),$P(X,"^",7)=$E($P(X,"^",8),1,10)_"/"_$E($P(X,"^",9),1,10),^RTV(195.9,I,0)=X
LOCKQ L -^RTV(195.9,I) S Y=I Q
 ;
ATT S Y=0 Q:$S('$D(RTB):1,'$D(^RTV(195.9,+RTB,0)):1,1:0)  S:$D(X)#2 RTZ("X")=X S X=^(0) I @("'$D(^"_$P($P(X,"^"),";",2)_"0))") G ATTQ
 ;naked reference to the borrower entry set by @(^$D(^ in tag att
 S F=+$P(^(0),"^",2),A=+$P(X,"^",3) I $D(^DIC(195.1,A,"BOR",+$O(^DIC(195.1,A,"BOR","B",F,0)),0)),$P(^(0),"^",RTPCE)="y" S Y=1
ATTQ S:$D(RTZ("X")) X=RTZ("X") K RTZ("X"),F,A Q
 ;
DR I $P(RTMV0,"^")'["RE-CHARGE",$P(^RTV(195.9,RTB,0),"^",13)'="F" S RTPCE=4 D ATT I Y S IOP="" D ^%ZIS K IOP S RTBX=RTB D START^RTRPT2 S RTB=RTBX K RTBX,RTC,RT1,RTS,RTY
 I $P(RTMV0,"^")'["RE-CHARGE" S RTPCE=2 D ATT I Y W ! S DA=+RTB,DIE="^RTV(195.9,",DR="[RT QUICK UPDATE]" D ^DIE K DE,DQ
 S RTPCE=3 D ATT S RTPROVFL=Y K RTPCE Q
 ;
ASSCO I 'RTPROVFL!('$D(^RTV(195.9,+RTB,0))) S RTPROV="" Q
 S RTA=+$P(^RTV(195.9,+RTB,0),"^",3),DIC="^RTV(195.9,",DIC("DR")="3////"_RTA,DIC(0)="IAELMQ",DIC("S")="I Y'="_+RTB_",$P(^(0),U,3)="_RTA_" D DICS^RTDPA31",DIC("V")="D DICV^RTDPA31",DIC("A")="ASSOCIATED BORROWER: "
 S:$S('$D(RTPROV):0,'$D(^RTV(195.9,+RTPROV,0)):0,1:1) DIC("B")=$P(^(0),"^")
 D ^DIC K DIC S RTPROV=$S(Y>0:+Y,1:"") Q
 ;
PRT ;entry point used by input transforms of default printer fields
 ;in file 195.9 - RECORD BORROWERS/FILE AREAS.
 I $D(RTREMOTE) D REMOT Q
 S DIC(0)="EM" D PRT1 S X=$P(Y,"^",2) K:Y<0 X Q
PRT1 S DIC="^%ZIS(1,",DIC("S")="I $D(^(""SUBTYPE"")),$D(^%ZIS(2,+^(""SUBTYPE""),0)),$E(^(0))=""P""" D ^DIC K DIC S DIC=DIE Q
 ;
HELP ;entry point used for help for default printer fields in file 195.9
 I $D(RTREMOTE) D REMOT Q
 S DIC(0)="E" D PRT1 Q
 ;
COUNT ;Entry point to count the number of records charged to a borrower
 ;  'X' is defined as the internal entry number of file 195.9
 ;  'X' is returned as number of records charged
 S X1=X,X=0 Q:'$D(^RTV(195.9,X1,0))  S RTA=+$P(^(0),"^",3)
 F RTI=0:0 S RTI=$O(^RT("ABOR",X1,RTI)) Q:'RTI  I $D(^RT(RTI,0)),$P(^(0),"^",4)=RTA S X=X+1
 K X1,RTI,RTA Q
 ;
 ; RT*2*33 (when S SAVY=Y Y was undefined)
REMOT ;S SAVY=Y,Y=$P(^RTV(195.9,DA,0),"^") D NAME^RTB
 N Y
 S Y=$P(^RTV(195.9,DA,0),"^") D NAME^RTB
 W !?3,"You must enter a valid file remote Request Printer device"
 W !?3,"at `",Y,"'     Contact the site manager at `",Y,"'",!
 ;S Y=SAVY K SAVY
