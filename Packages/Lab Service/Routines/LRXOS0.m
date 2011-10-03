LRXOS0 ;SLC/DCM - Order timing utility ;1/29/91  14:44
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;;V~5.02~;LAB;;04/11/91 11:06
CHK I $S($D(^PS(59.7,1,20)):$S(+^(20)<2.8:1,1:0),1:1) W !,"Unable to continue.",!,"This option requires version 2.8 or greater of Inpatient Medications package." S LREND=1
 I $S($D(^DD(100,0,"VR")):$S(^("VR")<2:1,1:0),1:1) W !,"Unable to continue.",!,"This option requires version 2 or greater of OE/RR" S LREND=1
 Q
INQ ;Inquiry to a schedule
 S LREND=0 D CHK Q:LREND
 S PSJPP="LR" D ENSVI^PSJEEU
 G END
EDIT ;Edit a schedule
 S LREND=0 D CHK Q:LREND
 S PSJPP="LR",DLAYGO=51 D ENSE^PSJEEU
 G END
END ;End
 K DLAYGO,PSJPP,PSJX,PSJPP,PSJW,PSJNE,PSJSCH,PSJAT,PSJM,PSJSD,PSJFD,PSJOSD,PSJOFD,PSJC,DIC
 Q
