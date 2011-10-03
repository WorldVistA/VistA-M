PRSEDEL ;HISC/MD-PURGE ROUTINE FOR FILES 452/452.8 ;6/24/93
 ;;4.0;PAID;;Sep 21, 1995
EN1 ; ENTRY POINT TO PURGE DATA FROM FILE 452 FROM OPTION PRSE-STU-PURG
 S X=$G(^PRSE(452.7,1,"OFF")) I X=""!(X=1) D MSG6^PRSEMSG Q
 W !!,$C(7),"Has IRM been contacted before purging data from file 452",!,"to insure that journaling of the ^PRSE global has been suspended" S %=1 D YN^DICN
 I %=0 W !!,$C(7),"ANSWER 'YES' or 'NO'" G EN1
 I %=2 W !!!,$C(7),"Contact IRM to suspend ^PRSE global journaling before proceeding!",! G Q
 G:%'>0 Q
ASK W ! S POUT=0,U="^",X="T-156W",%DT="" D ^%DT D:+Y D^DIQ S PRSEDATE=Y,%DT("A")="Start With DATE: ",%DT("B")=PRSEDATE,%DT(0)=-DT,%DT="AEPT" D ^%DT G Q:+Y'>0 S PRSEDATE=+Y
ASK1 W !!,"Are you sure you want to delete data prior to " D DT^DIQ S %=1 D YN^DICN I '% W $C(7),!,?4,"ANSWER 'YES' OR 'NO':" G ASK1
 G Q:%<0 G ASK:%'=1
 D  G Q:$D(POUT)
 .   ; ENTRY POINT TO PURGE DATA FROM THE PRSE(452 GLOBAL
 .   I $G(^PRSE(452,0))="" S POUT=1 Q
 .   I '$D(^PRSE(452,"H")) W !,$C(7),"INCOMPLETE DATA FILE" S POUT=1 Q
 .   W !!,"Purging 452 data...." S DIK="^PRSE(452," F PDATE=0:0 S PDATE=$O(^PRSE(452,"H",PDATE)) Q:+PDATE>PRSEDATE!(PDATE'>0)  F DA=0:0 S DA=$O(^PRSE(452,"H",PDATE,DA)) Q:DA'>0  I $P($G(^PRSE(452,DA,0)),U,2)'="" D
 .   .    S X=$P($G(^PRSE(452,+DA,0)),U,2) I X'="" S PRDA=$O(^PRSE(452.1,"B",X,0)) I $P($G(^PRSE(452.1,+PRDA,0)),U,6)'="0" D ^DIK W "."
 .   .   Q
 .   Q
 W !!,$C(7),"Notify IRM that the purge is completed and that journaling for the ^PRSE",!,"global should be restarted!"
Q D ^PRSEKILL
 Q
