FBRXFED ;WOIFO/SAB-FPPS DATA EDIT PHARMACY INVOICE ;8/12/2003
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
 W ! S DIC="^FBAA(162.1,",DIC(0)="AEQM",DIC("A")="Select Invoice #: "
 ; screen on invoices with completed status and EDI
 S DIC("S")="I $P(^(0),U,5)=4&($P(^(0),U,13)]"""")"
 D ^DIC K DIC I Y'>0 S FBAAOUT=1 Q
 S FBDA=+Y
 ;
 I $$CKFPPS^FBFHLL(FBDA)'=1 D  G ASKINV
 . W !?5,"Invoice ",FBDA," has not been transmitted to FPPS."
 ;
 ; save FPPS Claim ID data prior to edit session
 S (FBFPPSC,FBFPPSC(0))=$P($G(^FBAA(162.1,FBDA,0)),U,13)
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
 ; if FPPS CLAIM ID changed, then update file, audit log, and Rx's
 I FBFPPSC'=FBFPPSC(0) D
 . ; set invoice changed flag
 . S FBINVCHG=1
 . ;
 . ; file data in 162.1
 . K FBFDA
 . S FBFDA(162.1,FBDA_",",13)=$S(FBFPPSC="":"@",1:FBFPPSC)
 . I $D(FBFDA) D FILE^DIE("","FBFDA") D MSG^DIALOG()
 . ;
 . ; add record to audit log
 . K FBFDA
 . S FBFDA(163.7,"+1,",.01)=FBDA ; invoice number
 . S FBFDA(163.7,"+1,",1)=$$NOW^XLFDT() ; date/time changed
 . S FBFDA(163.7,"+1,",2)=162.1 ; file #
 . S FBFDA(163.7,"+1,",3)=FBDA_"," ; iens
 . S FBFDA(163.7,"+1,",4)=13 ; field #
 . S FBFDA(163.7,"+1,",5)=FBFPPSC(0) ; old value
 . S FBFDA(163.7,"+1,",6)=FBFPPSC ; new value
 . S FBFDA(163.7,"+1,",7)=DUZ ; user
 . I $D(FBFDA) D UPDATE^DIE("","FBFDA") D MSG^DIALOG()
 . ;
 . ; update Rx's (would only apply if EDI status can change)
 . D CKINVEDI^FBAAEPI1(FBFPPSC(0),FBFPPSC,FBDA)
 ;
ASKRX ; Select Prescription to Edit
 W !
 S DIC="^FBAA(162.1,"_FBDA_",""RX"",",DIC(0)="AEQM"
 S DIC("W")="W ?30,""DATE RX FILLED: "",$E($P(^(0),U,3),4,5)_""/""_$E($P(^(0),U,3),6,7)_""/""_$E($P(^(0),U,3),2,3)"
 D ^DIC I $D(DUOUT) S FBAAOUT=1 G INVEDX
 I Y'>0 D  G:$D(DIRUT)!(Y=1) INVEDX G ASKRX
 . S DIR(0)="Y"
 . S DIR("A")="Are you finished editing prescriptions on invoice "_FBDA
 . D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1
 S FBRXDA=+Y
 ;
 ; get current value of FPPS LINE ITEM to use as default
 S (FBFPPSL(0),FBFPPSL)=$P($G(^FBAA(162.1,FBDA,"RX",FBRXDA,3)),U)
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
 . ; file data in 162.11
 . K FBFDA
 . S FBFDA(162.11,FBRXDA_","_FBDA_",",36)=FBFPPSL
 . I $D(FBFDA) D FILE^DIE("","FBFDA") D MSG^DIALOG()
 . ;
 . ; add record to audit log
 . K FBFDA
 . S FBFDA(163.7,"+1,",.01)=FBDA ; invoice number
 . S FBFDA(163.7,"+1,",1)=$$NOW^XLFDT() ; date/time changed
 . S FBFDA(163.7,"+1,",2)=162.11 ; file #
 . S FBFDA(163.7,"+1,",3)=FBRXDA_","_FBDA_"," ; iens
 . S FBFDA(163.7,"+1,",4)=36 ; field #
 . S FBFDA(163.7,"+1,",5)=FBFPPSL(0) ; old value
 . S FBFDA(163.7,"+1,",6)=FBFPPSL ; new value
 . S FBFDA(163.7,"+1,",7)=DUZ ; user
 . I $D(FBFDA) D UPDATE^DIE("","FBFDA") D MSG^DIALOG()
 ;
 G ASKRX
 ;
INVEDX ; Invoice Edit Exit
 ; if invoice changed then queue for retransmit to FPPS
 I FBINVCHG D FILEQUE^FBFHLL(FBDA,5)
 Q
 ;
CLEAN K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K FBAAOUT,FBDA,FBFDA,FBFPPSC,FBFPPSL,FBINVCHG,FBRXDA,FBX
 Q
 ;FBRXFED
