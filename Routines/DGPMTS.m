DGPMTS ;ALB/LM - TREATING SPECIALTY INPATIENT PRINT ; 2-2-93
 ;;5.3;Registration;;Aug 13, 1993
EN ;
 S %DT="AEPX"
 S %DT("A")="Select Date for Treating Specialty Inpatient Information: "
 W ! D ^%DT K %DT G ENQ:Y'>0
 S DGTSDT=Y_".2400"
 S PTLWD=1,X="Patient Listing by Ward" D READ Q:E  S:'X1 PTLWD=0
 S PTLTS=1,X="Patient Listing by Treating Specialty" D READ Q:E  S:'X1 PTLTS=0
 S PTCTS=1,X="Patient Counts by Treating Specialty" D READ Q:E  S:'X1 PTCTS=0
 I 'PTLWD,'PTLTS,'PTCTS W !!,"Nothing Selected!",*7 G ENQ
 S %ZIS="PMQ" D ^%ZIS I POP G ENQ
 I '$D(IO("Q")) D START^DGPMTSI G ENQ
 S Y=$$QUE
ENQ D:'$D(ZTQUEUED) ^%ZISC
 K DGTSDT,PTLWD,PTLTS,PTCTS,E
 Q
 ;
READ S E=0 W !!,"Print ",X S %=1 D YN^DICN I % S X1=$S(%=1:%,1:0) S:%=-1 E=2 Q
 W !?4,"Answer YES if you wish to generate a ",X,!?4,"for this date ...Otherwise answer NO." G READ
 Q
 ;
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Treating Specialty Inpatient Information List"
 S ZTSAVE("DGTSDT")=""
 S ZTSAVE("PTLWD")=""
 S ZTSAVE("PTLTS")=""
 S ZTSAVE("PTCTS")=""
 S ZTRTN="START^DGPMTSI"
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
