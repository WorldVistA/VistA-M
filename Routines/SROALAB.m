SROALAB ;BIR/MAM - ENTER/EDIT LABORATORY INFORMATION ;05/26/99  10:51 AM
 ;;3.0; Surgery ;**38,88,142**;24 Jun 93
 I '$D(SRTN) W !!,"You must select a surgery risk assessment prior to using this option.",!!,"Press <RET> to continue  " R X:DTIME G END
 S SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START G:SRSOUT END D HDR^SROAUTL
 W !,"Enter/Edit Laboratory Test Results",!!,"1. Capture Preoperative Laboratory Information",!,"2. Capture Postoperative Laboratory Information"
 W !,"3. Enter, Edit, or Review Laboratory Test Results"
ASK W !!,"Select Number: " R X:DTIME I '$T!("^"[X) G END
 I X>3!(X<1)!(X'?.N) D HELP G:SRSOUT END G START
 I X=1 D ^SROAL1 G START
 I X=2 D ^SROAL2 G START
 D ^SROALEN G START
END ;
 W @IOF D ^SRSKILL
 Q
HELP W !!,"Enter '1' if you want to capture preoperative laboratory test results from the",!,"DHCP Laboratory records.  Enter '2' if you want to capture the postoperative"
 W !,"laboratory test results from the DHCP Laboratory records.  If you want to ",!,"enter, edit, or review preoperative and postoperative laboratory test results,",!,"enter '3'."
PRESS W ! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
