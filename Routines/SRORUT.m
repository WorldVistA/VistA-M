SRORUT ;B'HAM ISC/MAM - OPERATING ROOM UTILIZATION ; [ 09/22/98  11:36 AM ]
 ;;3.0; Surgery ;**34,77,50**;24 Jun 93
 S SRSOUT=0
 W @IOF,!,"Operating Room Utilization Report",!
DATE W ! K %DT S %DT="AEPX",%DT("A")="Print utilization information starting with which date ?  " D ^%DT I Y<0 S SRSOUT=1 G END
 S SRSD=+Y,SRSD1=Y-.0001
 W ! K %DT S %DT="AEPX",%DT("A")="Print utilization information through which date ?  " D ^%DT I Y<0 S SRSOUT=1 G END
 I Y<SRSD W !!,"The ending date must be more recent than the starting date." G DATE
 S SRED=+Y,SRED1=SRED+.25
 N SRINSTP,SRDIV I '$D(^XUSEC("SROCHIEF",+DUZ)) S SRINST=SRSITE("SITE"),(SRDIV,SRINSTP)=SRSITE("DIV")
 I $D(^XUSEC("SROCHIEF",+DUZ)) S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2)),SRDIV=$S(SRINST["ALL DIVISIONS":SRINST,1:SRINSTP)
 D ^SRORIN G:SRSOUT END I "Yy"'[SRYN S SRSOUT=1 G END
ROOMS ; all operating rooms ?
 S SROR="ALL" W @IOF,!,"Do you want to print the Operating Room Utilization Report for all",!,"operating rooms ?  YES//  " R SRYN:DTIME I SRYN["^" S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you want to print utilization information for every operating",!,"room, or 'NO' to print the report for one particular room.",!!,"Press RETURN to continue  " R X:DTIME G ROOMS
 I "Yy"[SRYN G ZIS
 W ! K DIC S DIC("S")="I $$ORDIV^SROUTL0(+Y,SRINSTP),('$P(^SRS(+Y,0),U,6))",DIC="^SRS(",DIC(0)="QEAMZ",DIC("A")="Print the report for which Operating Room ?  " D ^DIC I Y<0 S SRSOUT=1 G END
 S SROR=+Y
 W !!,"This report is designed to use a 132 column format, and must be run",!,"on a printer.",!
ZIS K %ZIS,IO("Q"),IOP,POP S %ZIS="QM",%ZIS("A")="Print the Operating Room Utilization Report on which Device ?  " D ^%ZIS I POP S SRSOUT=1 G END
 I $E(IOST)'="P" W !!,"This report must be run on a printer.  Please select another device.",! G ZIS
 I $D(IO("Q")) K IO("Q") S ZTDESC="OPERATING ROOM UTILIZATION REPORT",ZTRTN="EN^SRORUT0",(ZTSAVE("SRSD*"),ZTSAVE("SRED*"),ZTSAVE("SROR"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"),ZTSAVE("SRDIV"))="" D ^%ZTLOAD G END
 G EN^SRORUT0
END D ^%ZISC  W @IOF D ^SRSKILL
 Q
