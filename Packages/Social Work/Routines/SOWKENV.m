SOWKENV ;B'HAM ISC/DLR - KIDS ENVIRONMENT CHECKER ROUTINE [ 05/12/97  10:26 AM ]
 ;;3.0; Social Work ;**46**;27 Apr 93
 N SOWKFI,X
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) W !!,*7,"  DUZ and DUZ(0) must be defined as an active user to initialize." S XPDQUIT=2
 I $$VERSION^XPDUTL("EC")<2 W !!,"You need to install Event Capture v2.0" S SOWKF=1
 W !!,"Checking the environment for Event Capture routines."
 F X="ECAMIS","ECBEN","ECBEP","ECED","ECOSSUM","ECPAT","ECPROV","ECPRSUM1" W !,"  ",X X ^%ZOSF("TEST") I $T'=1 W !!,"The Event Capture routine, ",X," needs to be loaded before installing this patch." S SOWKF=1
 D:$G(SOWKF)=1 ABRT
 Q
ABRT ;abort install, delete transport global
 S XPDQUIT=1 Q
PRE ;Initialize file 655.202 to reflect Event Capture National Procedures
 S DIU=655.202,DIU(0)="D" D EN^DIU2
 Q
POST ;post KIDS install entry point
 S X=$$ADD^XPDMENU("SOWKCRUSER","ECENTER") D
 . W:X=0 !!,"KIDS was unable to add the Event Capture option, ECENTER,",!,"to the Social Work Case Management Menu." W:X=1 !!,"Adding the Event Capture Menu, ECENTER, to the Social Work Case Management Menu."
 S X=$$ADD^XPDMENU("SOWKREPORTS","ECREPS") W:X=0 !!,"KIDS was unable to add the Event Capture option, ECREPS,",!,"to the Social Work Reports Menu." W:X=1 !!,"Adding the Event Capture Menu, ECREPS, to the Social Work Reports Menu."
 D ^SOWK46B
 Q
