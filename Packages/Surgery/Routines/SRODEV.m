SRODEV ;B'HAM ISC/MAM - UPDATE O.R. SCHEDULE DEVICE ; 9 APR 1992 5:20 pm
 ;;3.0; Surgery ;;24 Jun 93
 W @IOF,!,"Update O.R. Schedule Devices",!,"----------------------------",!!
 K DR,DIE,DA S DA=SRSITE,DIE=133,DR=12 D ^DIE K DR,DA,DIE
 D ^SRSKILL W @IOF
 Q
