FBAAFED ;WOIFO/SAB-FPPS DATA EDIT OUTPATIENT/ANCILLARY INVOICE ;8/6/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) D  Q
 . W $C(7),!,"You must hold the FBAASUPERVISOR security key to use this option!"
 ;
 S FBAAOUT=0
 F  D INVED Q:FBAAOUT
 D CLEAN
 Q
 ;
INVED ; Invoice Edit
 ;
ASKINV ; Select Invoice to Edit
 W !
 S DIR(0)="NO",DIR("A")="Select Invoice Number"
 S DIR("?")="^D HELP^FBAAPIN1"
 D ^DIR K DIR I $D(DIRUT)!(Y="") S FBAAOUT=1 Q
 I '$D(^FBAAC("C",Y)) W !,$C(7),"Invalid selection.",! G ASKINV
 S FBAAIN=Y
 ;
 I $$CKFPPS^FBFHLL(FBAAIN)'=1 D  G ASKINV
 . W !?5,"Invoice ",FBAAIN," has not been transmitted to FPPS."
 ;
 ; Get Lines on Invoice
 D MILL^FBAAPET1(FBAAIN,.FBMILL)
 ;
 ; Determine Vendor and FPPS CLAIM ID based on first line on invoice
 S FBIENS=FBMILL($O(FBMILL(0)))
 S FBV=$P(FBIENS,",",3)
 S (FBFPPSC,FBFPPSC(0))=$$GET1^DIQ(162.03,FBIENS,50)
 ;
 I FBFPPSC="" D  G ASKINV
 . W !,$C(7),"Only EDI Claims can be selected!"
 ;
 S FBINVCHG=0 ; initialize invoice changed flag
 ;
EDITFC ; edit FPPS CLAIM ID
 S FBX=$$FPPSC^FBUTL5(1,FBFPPSC)
 I FBX=-1 S FBAAOUT=1 G INVEDX
 ; need to verify if following restriction is appropriate
 I FBX="" D  G EDITFC
 . W !,$C(7),"Can not change EDI from YES to NO on invoice that has been sent to FPPS!"
 S FBFPPSC=FBX
 ;
 ; if FPPS CLAIM ID changed, then update file, audit log, and lines
 I FBFPPSC'=FBFPPSC(0) D
 . ; set invoice changed flag
 . S FBINVCHG=1
 . ;
 . K FBFDA
 . ; loop thru lines on invoice
 . S FBI=0 F  S FBI=$O(FBMILL(FBI)) Q:'FBI  D
 . . S FBIENS=FBMILL(FBI)
 . . ; file data in 162.03 for each line
 . . S FBFDA(162.03,FBIENS,50)=$S(FBFPPSC="":"@",1:FBFPPSC)
 . . ;
 . . ; add record to audit log
 . . K FBFDAA
 . . S FBFDAA(163.7,"+1,",.01)=FBAAIN ; invoice number
 . . S FBFDAA(163.7,"+1,",1)=$$NOW^XLFDT() ; date/time changed
 . . S FBFDAA(163.7,"+1,",2)=162.03 ; file #
 . . S FBFDAA(163.7,"+1,",3)=FBIENS ; iens
 . . S FBFDAA(163.7,"+1,",4)=50 ; field #
 . . S FBFDAA(163.7,"+1,",5)=FBFPPSC(0) ; old value
 . . S FBFDAA(163.7,"+1,",6)=FBFPPSC ; new value
 . . S FBFDAA(163.7,"+1,",7)=DUZ ; user
 . . I $D(FBFDAA) D UPDATE^DIE("","FBFDAA") D MSG^DIALOG()
 . . ;
 . I $D(FBFDA) D FILE^DIE("","FBFDA") D MSG^DIALOG()
 ;
ASKLINE ; Select Line to Edit
 ;
ASKPT ; Select Patient
 W !
 S DIC="^FBAAC(",DIC(0)="AEQM"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT) G INVEDX
 I Y'>0 D  G:$D(DIRUT) INVEDX G:'Y ASKPT G INVEDX
 . S DIR(0)="Y"
 . S DIR("A")="Are you finished entering patients for this invoice"
 . D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1
 S FBDA(3)=+Y
 ;
ASKVEN ; Select Vendor
 W !
 ;S DIC(0)="AEQM"
 ;S DIC="^FBAAC("_FBDA(3)_",1,"
 ;D ^DIC K DIC I $D(DTOUT)!$D(DUOUT) G INVEDX
 ;I Y'>0 D  G:$D(DIRUT) INVEDX G:'Y ASKVEN G ASKPT
 ;. S DIR(0)="Y"
 ;. S DIR("A")="Are you finished entering vendors for this patient"
 ;. D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1
 ;S FBDA(2)=+Y
 S FBDA(2)=FBV
 W !,"Vendor = ",$P($G(^FBAAV(FBV,0)),U)
 ;
ASKDOS ; Select Date of Service
 W !
 S DIC(0)="AEQM"
 S DIC="^FBAAC("_FBDA(3)_",1,"_FBDA(2)_",1,"
 S DIC("A")="Select DATE OF SERVICE: "
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT) G INVEDX
 I Y'>0 D  G:$D(DIRUT) INVEDX G:'Y ASKDOS G ASKPT
 . S DIR(0)="Y"
 . S DIR("A")="Are you finished entering dates for this patient"
 . D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1
 S FBDA(1)=+Y
 ;
ASKSVC ; Select Service Provided
 W !
 S DIC(0)="AEQM"
 S DIC="^FBAAC("_FBDA(3)_",1,"_FBDA(2)_",1,"_FBDA(1)_",1,"
 D ^DIC K DIC I $D(DTOUT)!$D(DUOUT) G INVEDX
 I Y'>0 D  G:$D(DIRUT) INVEDX G:'Y ASKSVC G ASKDOS
 . S DIR(0)="Y"
 . S DIR("A")="Are you finished entering services for this date"
 . D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1
 S FBDA=+Y
 ;
 S FBIENS=FBDA_","_FBDA(1)_","_FBDA(2)_","_FBDA(3)_","
 ;
 ; check if line is on invoice
 I $$GET1^DIQ(162.03,FBIENS,14)'=FBAAIN D  G ASKSVC
 . W $C(7),!,"Line is not on invoice ",FBAAIN,"!"
 ;
 ; get current value of FPPS LINE ITEM to use as default
 S (FBFPPSL(0),FBFPPSL)=$$GET1^DIQ(162.03,FBIENS,51)
 ;
EDITFL ; edit FPPS Line Item
 S FBX=$$FPPSL^FBUTL5(FBFPPSL)
 I FBX=-1 S FBAAOUT=1 G INVEDX
 ; need to verify if following restriction is appropriate
 S FBFPPSL=FBX
 ;
 ; if FPPS LINE ITEM changed, then update file and audit log
 I FBFPPSL'=FBFPPSL(0) D
 . ; set invoice changed flag
 . S FBINVCHG=1
 . ;
 . ; file data in 162.03
 . K FBFDA
 . S FBFDA(162.03,FBIENS,51)=FBFPPSL
 . I $D(FBFDA) D FILE^DIE("","FBFDA") D MSG^DIALOG()
 . ;
 . ; add record to audit log
 . K FBFDA
 . S FBFDA(163.7,"+1,",.01)=FBAAIN ; invoice number
 . S FBFDA(163.7,"+1,",1)=$$NOW^XLFDT() ; date/time changed
 . S FBFDA(163.7,"+1,",2)=162.03 ; file #
 . S FBFDA(163.7,"+1,",3)=FBIENS ; iens
 . S FBFDA(163.7,"+1,",4)=51 ; field #
 . S FBFDA(163.7,"+1,",5)=FBFPPSL(0) ; old value
 . S FBFDA(163.7,"+1,",6)=FBFPPSL ; new value
 . S FBFDA(163.7,"+1,",7)=DUZ ; user
 . I $D(FBFDA) D UPDATE^DIE("","FBFDA") D MSG^DIALOG()
 ;
 G ASKSVC
 ;
INVEDX ; Invoice Edit Exit
 ; if invoice changed then queue for retransmit to FPPS
 I FBINVCHG D FILEQUE^FBFHLL(FBAAIN,3)
 Q
 ;
CLEAN K D,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K FBAAIN,FBAAOUT,FBDA,FBFDA,FBFDAA,FBIENS,FBFPPSC,FBFPPSL,FBINVCHG
 K FBMILL,FBV,FBX
 Q
 ;FBAAFED
