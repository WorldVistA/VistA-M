SRSTIME ;B'HAM ISC/MAM - SET SCHEDULE TIMES ; 15 NOV 1991  1:20 PM
 ;;3.0; Surgery ;**5,15,34,36,37**;24 Jun 93
TIMES ; sets starting and ending times for reservations
 W ! K DIR S DIR("A")="Reserve from what time ? (NEAREST 15 MIN): ",DIR(0)="FOA^1:30",DIR("?",1)="Please enter a starting time to the nearest 15 minutes, for example,"
 S DIR("?")="7:00, 7:15, 7:30, 7:45.  Enter the time only with no date."
 D ^DIR K DIR I $D(DIRUT) S SRSOUT=1 K SRSST1,SRSET1 Q
 S Z=Y D CHK G:Z=-1 TIMES S Z(0)=$P(Z,".",2),Z(0)=Z(0)_"0000",Z(0)=$E(Z(0),1,4),Z(1)=$E(Z(0),1,2),Z(2)=$E(Z(0),3,4) I "00,15,30,45"'[Z(2) S Z(2)=$S(Z(2)<15:"00",Z(2)<30:15,Z(2)<45:30,1:45)
 S (Z,SRT,SRSST1)=Z(1)_":"_Z(2),SRSDT1=+(SRSDATE_"."_Z(1)_Z(2)) W "   ("_Z_")"
 ;
TIMES2 ; ending time
 S SRSOUT=0 W ! K DIR S DIR("A")="Reserve to what time ? (NEAREST 15 MIN): ",DIR(0)="FOA^1:30",DIR("?",1)="Please enter an ending time to the nearest 15 minutes, for example,"
 S DIR("?")="7:00, 7:15, 7:30, 7:45.  Enter the time only with no date."
 D ^DIR K DIR I $D(DIRUT) S SRSOUT=1 K SRSST1,SRSET1 Q
 S Z=Y D CHK G:Z=-1 TIMES2 S Z(0)=$P(Z,".",2),Z(0)=Z(0)_"0000",Z(0)=$E(Z(0),1,4),Z(1)=$E(Z(0),1,2),Z(2)=$E(Z(0),3,4) I "00,15,30,45"'[Z(2) S Z(2)=$S(Z(2)<15:"00",Z(2)<30:15,Z(2)<45:30,1:45)
 S Z=Z(1)_":"_Z(2) W "   ("_Z_")" I Z=SRT W !!,"The ending time must be after the starting time." G TIMES2
 S SRSDT2=+(SRSDATE_"."_Z(1)_Z(2)) I SRSDT2<SRSDT1 D TOMM I '$D(SRSDT2)!(SRSOUT) G TIMES2
 S SRSTIME=SRT_"^"_Z,SRSET1=Z
 Q
TOMM ; next day end time
 S X1=SRSDATE,X2=1 D C^%DTC S SRSDT3=X S Y=X D D^DIQ S SRSDTT=Y
 W !!,"You have entered an ending time which is earlier than the starting time.",! I $D(SRSBANG) S SRSOUT=1 Q
ASK K DIR S DIR("A",1)="Do you want to schedule this case to end on the following day, "_SRSDTT,DIR("A")="at "_Z_" ? ",DIR("B")="NO",DIR(0)="YA"
 S DIR("?",1)="Enter 'YES' if you want this case to end at "_Z_" of the following day.",DIR("?")="Otherwise, enter 'NO'." D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y K SRSDT2 Q
 S SRSDT2=+(SRSDT3_"."_$P(Z,":")_$P(Z,":",2))
 Q
CHK K %DT S %DT="FR",X=SRSDATE_"@"_Z,%DT(0)=SRSDATE D ^%DT S Z=Y
 Q
