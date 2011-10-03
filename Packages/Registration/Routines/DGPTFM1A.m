DGPTFM1A ;ALB/JDS - MASTER DIAG/OP/PRO CODE HELP ;3/28/05 1:05pm
 ;;5.3;Registration;**517,635**;Aug 13, 1993
 ;
HELP W !!,"Enter ",?10,"'A'-To add an ICD diagnosis",!?10 W:DGPTFE "'M'-To add a new patient movement",!?10,"'X'-To delete a patient movement"
 W:'DGPTFE "'M'-To edit treating specialty transfers which generate",!,?14,"patient movements"
 W !?10,"'S'-To add a new surgery record"
 W !?10,"'T'-To add a new procedure record"
 W !?10,"'I'-To add a new 801 record"
 W !?10,"'Z'-To delete a surgery record"
 W !?10,"'R'-To delete a procedure record"
 W !?10,"'Y'-To delete an 801 record."
 W !?10,"'A'-To add an ICD diagnosis"
 W !?10,"'O'-To add an ICD op code"
 W !?10,"'P'-To add a new ICD procedure code"
 W !?10,"'N'-To add a CPT procedure code"
 W !?10,"'D'-To delete an ICD diagnosis"
 W !?10,"'C'-To delete a ICD op code"
 W !?10,"'Q'-To delete a ICD procedure code"
 W !?10,"'G'-To delete a CPT procedure code"
 W !?10,"'V'-To review all patient movements",!?10,"'J'-To review all surgery segments"
 W !?10,"'E'-To review all procedure segments"
 W !?10,"'F'-To review all 801 segments"
 W !?10,"'^' to abort",!?10,"<RET> to continue on to the next screen"
 R !,"Enter <RET> to continue: ",ANS:DTIME K ANS
 W !,"The delete codes (D,C,Q,G) may be followed by the numbers that are before the",!,"ICD codes, separated by commas. ('D1,2,8' to delete ICD diagnoses 1,2 and 8",!,"if they were on the screen above)"
 W !!,"The edit code F may be followed by a number to start editing"
 W !,"the 801 records at that number record."
 R !!,"Enter <RET> to continue: ",ANS:DTIME K ANS G ^DGPTFM
