DGVTSFS ;7DELTA/KDC - VTS Stand alone Option routine ;07-MAR-2012
 ;;5.3;REGISTRATION;**853**;07-MAR-2012;Build 104
 Q
EN ;Entry point for stand-alone RideShare sign-up option
 ;This routine provides the option to SET the VTS Patient 
 ;Flag in File #2 (Patient File) which indicates that the
 ;patient is enrolled in RideShare
 ;
 ;
 ; SET (YES) - 1
 ; Not SET (NO) -0 or ""
 ;
 ;An HL7 ADT-A28 (ADD) message is built/sent
 ; Input  -- None
 ; Output -- None
 ;
 ;
 ;
 ;
 N DFN
 ;
 ;Get Patient file (#2) IEN - DFN
EN1 D GETPAT^DGRPTU(,,.DFN,) G ENQ:DFN<0
 L +^DPT(DFN):5 I '$T W !,"Patient record is currently locked, Try again later." G EN1
 ;
E1 ; Retrieve patient's VTS flag information
 N DIC,DR,DA,%,DIE,DGVTRSF
 S DGVTRSF=$$GET1^DIQ(2,DFN_",",3000)
 W !,"The VTS Patient Flag is currently: ",DGVTRSF
 I DGVTRSF="YES" W !,"Patient is already a RideShare participant" L -^DPT(DFN) K DFN G EN1
 W !!,"Are you sure you want to enroll patient in RideShare",!,"and set the VTS Patient Flag"
 D YN^DICN I %Y["?" W !!,"Enter YES or NO.",! G E1
 I %'=1 L -^DPT(DFN) G ENQ
 S DIE=2,DA=DFN,DR="3000///1" D ^DIE
 L -^DPT(DFN)
 ;
 ; Build and send HL7 ADT-A28 ADD Message 
 D A28^DGVTSA28(DFN)
 ;
 W !!,"Patient is now a RideShare participant and VTS Patient Flag is set"
 K DFN
 G EN1
 ;
ENQ ;
 K DIQ1
 Q
