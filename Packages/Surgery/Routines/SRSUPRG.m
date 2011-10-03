SRSUPRG ;B'HAM ISC/MAM - PURGE UTILIZATION ; [ 10/01/98  11:48 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
 S SRSOUT=0 W @IOF,!,"Purge Utilization Information",!!
 K %DT S %DT="AEPX",%DT("A")="Starting with Date: " D ^%DT I Y<0 S SRSOUT=1 G END
 S SRSDT=Y D D^DIQ S SRDATE=Y
 W !!,"This option will purge all utilization information for the dates prior to (and",!,"including) "_SRDATE_"."
ASK W !!,"Are you sure that you want to purge for this date range ?  NO// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) I SRYN["?" D HELP G ASK
 I "YyNn"'[SRYN W !!,"Enter 'YES' to purge information, 'NO' to quit, or '?' for more help." G ASK
 I "Nn"[SRYN S SRSOUT=1 G END
 D NOW^%DTC S ZTDTH=%
 W ! S ZTIO="",ZTRTN="EN^SRSUPRG",(ZTSAVE("SRSDT"),ZTSAVE("SRSITE*"))="",ZTDESC="Purge Surgery Utilization Data" D ^%ZTLOAD
 W !,"The option to purge utilization data has been queued." G END
EN ; entry when queued
 S SRSOUT=0,SRDT=0 F  S SRDT=$O(^SRU(SRDT)) Q:'SRDT!(SRDT>SRSDT)  S SROOM=0 F  S SROOM=$O(^SRU(SRDT,1,SROOM)) Q:'SROOM  I $$ORDIV^SROUTL0(SROOM,$G(SRSITE("DIV"))) D
 .K DA,DIK S DA(1)=SRDT,DA=SROOM,DIK="^SRU("_DA(1)_",1," D ^DIK K DA,DIK
 .I $O(^SRU(SRDT,1,0))="" S DA=SRDT,DIK="^SRU(" D ^DIK K DA,DIK
 S ZTREQ="@"
 Q
END I 'SRSOUT W !!,"Press RETURN to continue  " R X:DTIME
 W @IOF D ^SRSKILL
 Q
HELP W !!,"Enter 'YES' to purge utilization information for all dates prior to and",!,"including "_SRDATE_".  Enter 'NO' to quit this option."
 Q
