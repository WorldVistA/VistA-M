SROUTED ;B'HAM ISC/MAM - EDIT UTILIZATION TIMES ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
START W @IOF,!,"Update Start and End Times for Operating Rooms",! K %DT S %DT="AEPX",%DT("A")="Update Times for which Date ?  " D ^%DT I Y<0 G END
 S SRUL="" F I=1:1:80 S SRUL=SRUL_"-"
 S SRSDATE=+Y D D^DIQ S SRSDT=Y I '$D(^SRU(SRSDATE)) D STUFF
OR W @IOF,!,"Operating Room Utilization on "_SRSDT,!,SRUL,! K DIC,DA
 S DIC("S")="I $$ORDIV^SROUTL0(+Y,$G(SRSITE(""DIV""))),('$P(^SRS(+Y,0),U,6))",DIC="^SRS(",DIC(0)="QEAMZ",DIC("A")="Update Start and End Times for which Operating Room ?  " D ^DIC K DIC I Y<0 G:$D(DTOUT)!$D(DUOUT) END G START
 S SROR=+Y
 W ! K DIE,DA,DR S DA(1)=SRSDATE,DA=SROR,DIE="^SRU(SRSDATE,1,",DR="1T;2T;3T" D ^DIE K DR G:$D(DTOUT)!$D(DUOUT) END
 G OR
END D ^SRSKILL W @IOF
 Q
STUFF ; stuff operating rooms and specialties
 S Y=SRSDATE D D^DIQ S SRDT=Y
 K DA,DIC,DD,DO,DINUM,SRTN S (X,DINUM)=SRSDATE,DIC="^SRU(",DIC(0)="L",DLAYGO=131.8 D FILE^DICN K DIC,DLAYGO
 S ^SRU(SRSDATE,1,0)="^131.81PA^0^0"
 S SROR=0 F  S SROR=$O(^SRS(SROR)) Q:'SROR  I '$P(^(SROR,0),"^",6) S X1=SRSDATE,X2=-7 D C^%DTC S SRDTOLD=X,SRDTNEW=SRSDATE D OR^SROUTUP
 Q
