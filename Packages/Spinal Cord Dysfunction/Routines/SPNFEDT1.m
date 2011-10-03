SPNFEDT1 ;HISC/DAD/WAA-INPUT/OUTPUT PROCESS FOR SURVEY ;10/24/2001
 ;;2.0;Spinal Cord Dysfunction;**2,10,15,16**;01/02/1997
 ;
 ; This routine is to enter and edit Registry and Clinical data
 ; for a patient.  It will enter and edit data in file 154
 ;
PAT(SPNFTYPE,SPNFDFN) ;Enter/Edit local registry file (#154) & FIM file (#154.1)
 ; Input:
 ;    SPNFDFN = Patient DFN in File 2
 ; Output:
 ;    SPNFEXIT = User force exit
 S SPNFEXIT=0
 I '$D(^SPNL(154,SPNFDFN,0)) D  Q:SPNFEXIT
 . S X=SPNFDFN
 . K DIC,DD,DINUM,DO S DINUM=SPNFDFN,DIC="^SPNL(154,",DIC(0)="L"
 . S DLAYGO=154 D FILE^DICN S SPNLD0=Y I SPNLD0'>0 S SPNFEXIT=1 Q
 . S SPNLDFN=+SPNLD0
 . Q
 E  S SPNLD0=SPNFDFN
 I $P(SPNLD0,U,3)=1 D
 . N SPNTMP
 . S SPNTMP=$$GET1^DIQ(2,SPNFDFN,57.4,"I")
 . K DA,DIE,DR
 . S DIE="^SPNL(154,",DA=SPNFDFN
 . S DR=".03///SCD - CURRENTLY SERVED"
 . S DR=DR_";.05///NOW;.06///`"_DUZ
 . I SPNTMP'="" S:SPNTMP'=5 DR=DR_";2.6////"_SPNTMP
 . D ^DIE
 . Q
 L +^SPNL(154,SPNFDFN,0):0 I '$T D  Q
 . W !!?5,"Another user is editing this record."
 . W !?5,"Please try again later.",$C(7)
 . Q
 D EDIT(SPNFTYPE,SPNFDFN)
 Q
EDIT(SPNFTYPE,SPNFDFN) ; *** Choose add / edit a record
 ;  SPNFTYPE = 1 - Registration and Health Care Information
 ;             2 - Functional Information
 ;             3 - Clinical Information
 ;  SPNFDFN  = DFN in PATIENT file (#2)
 S SPNFEXIT=0
 I SPNFTYPE=2 Q
 D EN^SPNDIV(SPNFDFN)
 K DA,DDSFILE,DDSPAGE,DDSPARM,DR
 S DDSFILE="^SPNL(154,",DR="["_$P($P($T(SCREEN+SPNFTYPE),";;",2),U)_"]",DA=SPNFDFN
 S DDSPARM="C" D ^DDS
 K DDSPARM,DIE,DA,DR
 S DIE="^SPNL(154,",DR=".05///NOW;.06///`"_DUZ,DA=SPNFDFN
 D ^DIE K SPNQFL
 L -^SPNL(154,SPNFDFN,0)
HL7 ;added line 9-30-1998 to check and build the hl7 message
 I $G(DDSCHANG)=1 D  ;
 .D CHK^SPNHL7(SPNFDFN)
 .D EXIT^SPNHL7
 ;
SCREEN ; This is a list of what type go to what Screen Man screens.
 ;;SPNLPFM1^1 - Registration and Health Care Information
 ;;^2
 ;;SPNLPFM2^3 - Clinical Information
