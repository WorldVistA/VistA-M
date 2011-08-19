ECSUN ;BIR/JLP,RHK-Category and Procedure Summary (Old File) ;30 Apr 96
 ;;2.0; EVENT CAPTURE ;;8 May 96
LOC K ECL S EC1=0 D ^ECL S:$D(LOC(2)) EC1=1 K LOC I '$D(ECL) S ECOUT=1 G END
 S ECJLP=0 I $G(^ECC(722,+$O(^ECC(722,"B",ECL,0)),"BRO"))="" S ECJLP=1
 S (ECOUT,ECALL)=0,ECPG=1
UNIT ;
 W @IOF F Q=0:0 W !!,"Do you want to list all accessible DSS Units for "_ECLN S %=1 D YN^DICN Q:%  W !!,"Enter <RET> to list all your accessible DSS Units for this location,",!," or NO to select a specific DSS Unit"
 G:%<0 END I %=1 S ECALL=1 G DEV
 W @IOF,! K DIC S DIC=724,DIC(0)="QEAMZ",DIC("A")="Select DSS Unit: " S:ECL DIC("S")="I $D(^ECK(""AP"",ECL,+Y))" D ^DIC K DIC G:Y<0 END S ECD=+Y,ECDN=$P(Y,"^",2)
 S ECS=+$P(^ECD(ECD,0),"^",2),ECSN=$S($P($G(^DIC(49,ECS,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
SEL ;
 I ECJLP G DEV
 W @IOF F Q=0:0 W !!,"Do you want to list all categories for "_ECDN S %=1 D YN^DICN Q:%  W !!,"Enter <RET> if you would like to list all categories for this DSS Unit,",!," or NO to select a specific category"
 G:%<0 END I %=1 S ECC="ALL" G DEV
 W @IOF,! K DIC S DIC=720,DIC(0)="QEAMZ",DIC("A")="Select Category for "_ECDN_" DSS Unit:  " S:ECD DIC("S")="I $D(^ECK(""AP"",ECL,ECD,+Y))" D ^DIC K DIC G:Y<0 END S ECC=+Y,ECCN=$P(Y,"^",2)
DEV W !! K IOP,POP,IO("Q"),%ZIS,ZTSK S %ZIS="QM",%ZIS("A")="Select Device:  " D ^%ZIS I POP S ECOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="CATEGORY AND PROCEDURE SUMMARY",ZTRTN="START^ECSUN",ZTIO=ION D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
START ;
 U IO
 S %H=$H D YX^%DTC S ECDATE=Y
 S ECOUT=0,ECPG=1 I ECALL D ^ECSUN1 G CLEAR
 D ^ECSUN2
CLEAR I $E(IOST,1,2)'="C-" W @IOF G END
 I ECPG W !!,"Press <RET> to continue  " R X:DTIME I '$T!(X="^") S ECOUT=1 G END
 G:ECALL END
ASK ;
 W @IOF F Q=0:0 W !!,"Would you like to list another DSS Unit for this Location" S %=2 D YN^DICN Q:%  W !!,"Enter YES to list another DSS Unit or <RET> to continue"
 G:%<0 END I %=1 K ECD,ECDN,ECC,ECCN,ECP,ECPN,ECS,ECSN G UNIT
 K ECD,ECDN,ECC,ECCN,ECP,ECPN,ECS,ECSN G:EC1 LOC
END ;
 D ^ECKILL W @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;
 S (ZTSAVE("ECA*"),ZTSAVE("ECJLP"),ZTSAVE("ECC*"),ZTSAVE("ECD*"),ZTSAVE("ECL*"),ZTSAVE("ECM*"),ZTSAVE("ECP*"),ZTSAVE("ECS*"))=""
 Q
