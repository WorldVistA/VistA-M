ECBEP2B ;BIR/MAM,JPW-Batch Entry by Procedure (cont'd) ;1 May 96
 ;;2.0; EVENT CAPTURE ;**4,10,13,18,72**;8 May 96
EN ;entry point
 S CNT=0
STUFF ; set up info to stuff
 S ECDUZ=DUZ
 W @IOF,!,"You have selected "_$S(ECCPT'="":ECPTCD_" ",1:"")_$E(ECPN,1,40)
 W $S(SYN'["NOT DEFINED":" ["_SYN_"]",1:"")_"  (#"_NATN_")"
 ;- Display CPT procedure Modifiers
 I ECCPT'="" N MOD S MOD="" F  S MOD=$O(ECMOD(ECCPT,MOD)) Q:MOD=""  D
 . W !," Modifier: ",?22,"- ",MOD," ",$E($P(ECMOD(ECCPT,MOD),U),1,55)
 W !,"for this group of patients."
 W !!,"I will now enter these patient procedures in the file.  OK ?  YES//  " R ECYN:DTIME I '$T!(ECYN="^") S ECOUT=1 Q
 S ECYN=$E(ECYN) S:ECYN="" ECYN="Y"
 I "YyNn"'[ECYN W !!,"Enter <RET> to create the entries in the file.  If you have made a mistake",!,"and do not wish to continue, enter NO.",!!,"Press <RET> to continue  " R X:DTIME G STUFF
 I "Nn"[ECYN D NO I "Yy"[ECYN Q
 W !!,"I am now sending these procedures to background for filing."
 K DIR W !! S DIR(0)="E",DIR("A")="Press <RET> to continue" D ^DIR K DIR
 S ECA=ECDT_"^"_ECL_"^"_ECS_"^"_ECM_"^"_ECD_"^"_ECPCE
 S ECOUT=2
 S (ZTSAVE("ECPT*"),ZTSAVE("ECA"),ZTSAVE("ECEC*"),ZTSAVE("ECDUZ"),ZTSAVE("ECELPT*"),ZTSAVE("ECPRVARY*"))=""
 S ZTIO="",ZTDTH=$H,ZTDESC="BATCH ENTRY EVENT CAPTURE PROCEDURES",ZTRTN="CRAM^ECBEPF" D ^%ZTLOAD,HOME^%ZIS K ECEC Q
 Q
NO ; do not stuff
 W !!,"Are you sure that you want to quit without entering any of the procedures",!,"that you have created for the patients selected ?  NO//  " R ECYN:DTIME I '$T!(ECYN="^") S ECOUT=1,ECYN="Y" Q
 S ECYN=$E(ECYN) S:ECYN="" ECYN="N" I "YyNn"'[ECYN W !!,"If you do not want to enter the procedures selected, enter YES.  If the",!,"procedures selected should be entered for the patients chosen, enter <RET>." G NO
 Q
