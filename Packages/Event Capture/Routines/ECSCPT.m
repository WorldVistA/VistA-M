ECSCPT ;ALB/JAM - Event Code Screen With CPT Codes ; 8 Nov 07
 ;;2.0; EVENT CAPTURE ;**72,92,95**;8 May 96;Build 26
LOC K ECL S EC1=0 D ^ECL S:$D(LOC(2)) EC1=1 K LOC I '$D(ECL) S ECOUT=1 G END
UNIT ;set var and sel dss unit
 S ECJLP=0
 S (ECOUT,ECALL)=0,ECPG=1
 W @IOF F Q=0:0 D  Q:%
 .W !!,"Do you want to list all DSS Units for "_ECLN S %=1 D YN^DICN Q:%
 .W !!?5,"Enter <RET> to list all your DSS Units for this location, or"
 .W !?11,"NO to select a specific DSS Unit"
 G:%<0 END I %=1 S ECALL=1 G ECCPT
 W @IOF,! K DIC S DIC=724,DIC(0)="QEAMZ",DIC("A")="Select DSS Unit: "
 S:ECL DIC("S")="I $D(^ECJ(""AP"",ECL,+Y))"
 D ^DIC K DIC G:Y<0 END S ECD=+Y,ECDN=$P(Y,"^",2)
 S ECDN=ECDN_$S($P($G(^ECD(+ECD,0)),"^",6):" **Inactive**",1:"")
 S ECJLP=+$P(^ECD(ECD,0),"^",11)
SEL ;
 I 'ECJLP S ECC=0,ECCN="None" G ECCPT
 W @IOF F Q=0:0 D  Q:%
 .W !!,"Do you want to list all categories for "_ECDN S %=1 D YN^DICN Q:%
 .W !!,"Enter <RET> if you would like to list all categories for this "
 .W "DSS Unit,",!," or NO to select a specific category"
 G:%<0 END I %=1 S ECC="ALL" G ECCPT
 W @IOF,! K DIC S DIC=726,DIC(0)="QEAMZ",DIC("A")="Select Category for "
 S DIC("A")=DIC("A")_ECDN_" DSS Unit:  "
 S:ECD DIC("S")="I $D(^ECJ(""AP"",ECL,ECD,+Y))"
 D ^DIC K DIC G:Y<0 END S ECC=+Y,ECCN=$P(Y,"^",2)
ECCPT ;CPT Codes to display
 K DIR
 S DIR(0)="SO^A:Active CPT Codes;I:Inactive CPT Codes;B:Both"
 S DIR("B")="I",DIR("A")="CPT Codes to display"
 S DIR("?",1)="Enter an A for Event Code screens with Active CPT Codes,"
 S DIR("?",1)=DIR("?",1)_" I for Inactive Codes,"
 S DIR("?")="B for a consolidated report of CPT codes, or ^ to quit."
 S DIR("??")="ECSCPT^"
 D ^DIR K DIR I $D(DIRUT) G END
 S ECCPT=Y
DEV W !! K IOP,POP,IO("Q"),%ZIS,ZTSK
 S %ZIS="QM",%ZIS("A")="Select Device:  " D ^%ZIS I POP S ECOUT=1 G END
 I $D(IO("Q")) K IO("Q") D  G END
 .S ZTDESC="CATEGORY AND PROCEDURE SUMMARY",ZTRTN="START^ECSCPT",ZTIO=ION
 .D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK
 U IO
START ;
 N ECI  ;generic index
 N ECL  ;location IEN
 N ECLN  ;location name
 S %H=$H D YX^%DTC S ECRDT=Y
 S ECOUT=0,ECPG=1
 S ECI=0
 F  S ECI=$O(ECLOC(ECI)) Q:'ECI  D
 . S ECL=$P(ECLOC(ECI),U),ECLN=$P(ECLOC(ECI),U,2)
 . D ^ECSCPT1
CLEAR I $E(IOST,1,2)'="C-" G END
 G:ECOUT END
 I ECPG W !!!!!,"Press <RET> to continue  " R X:DTIME I '$T!(X="^") S ECOUT=1 G END
 G:ECALL END
ASK ;
 W @IOF F Q=0:0 D  I % Q
 .W !!,"Would you like to list another DSS Unit for this Location"
 .S %=2 D YN^DICN I % Q
 .W !!,"Enter YES to list another DSS Unit or <RET> to continue"
 G:%<0 END I %=1 D  G UNIT
 .K ECD,ECDN,ECC,ECCN,ECP,ECPN,NATN,ECFILE,ECCPT
 K ECD,ECDN,ECC,ECCN,ECP,ECPN,NATN,ECFILE,ECCPT
 I EC1 G LOC
END ;
 D ^ECKILL Q:$D(ECGUI)  W @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;
 S (ZTSAVE("ECALL"),ZTSAVE("ECJLP"),ZTSAVE("ECC*"),ZTSAVE("ECD*"),ZTSAVE("ECL*"),ZTSAVE("ECP*"))=""
 Q
