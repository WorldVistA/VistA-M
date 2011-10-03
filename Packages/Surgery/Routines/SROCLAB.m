SROCLAB ;BIR/SJA - ENTER/EDIT CARDIAC LAB INFORMATION ;01/21/04  08:27 AM
 ;;3.0; Surgery ;**125,142**;24 Jun 93
 I '$D(SRTN) W !!,"You must select a surgery risk assessment prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START G:SRSOUT END D HDR^SROAUTL
 W !,"Enter/Edit Laboratory Test Results",!!,"1. Capture Laboratory Information",!,"2. Enter, Edit, or Review Laboratory Test Results"
ASK W !!,"Select Number: " R X:DTIME I '$T!("^"[X) G END
 I X>2!(X<1)!(X'?.N) D HELP G:SRSOUT END G START
 I X=1 D ^SROCL1 G START
 D ^SROACPM1 G START
END ;
 W @IOF D ^SRSKILL
 Q
HELP W !!,"Enter '1' if you want to capture laboratory test results from the",!,"DHCP Laboratory records.  Enter '2' if you want to enter, edit, or review laboratory test results."
PRESS W ! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
