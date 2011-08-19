FBCHFED ;WOIFO/SAB-FPPS DATA EDIT INPATIENT INVOICE ;8/12/2003
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
 W ! S DIC="^FBAAI(",DIC(0)="AEQZ"
 S DIC("S")="I $P($G(^(3)),U)]""""" ; screen on EDI claim
 D ^DIC K DIC I Y'>0 S FBAAOUT=1 Q
 S FBDA=+Y
 ;
 I $$CKFPPS^FBFHLL(FBDA)'=1 D  G ASKINV
 . W !?5,"Invoice ",FBDA," has not been transmitted to FPPS."
 ;
 ; save FPPS Claim ID and Line Item data prior to edit session
 S (FBFPPSC,FBFPPSC(0))=$P($G(^FBAAI(FBDA,3)),U)
 S (FBFPPSL,FBFPPSL(0))=$P($G(^FBAAI(FBDA,3)),U,2)
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
 ; if FPPS CLAIM ID changed, then update file and audit log
 I FBFPPSC'=FBFPPSC(0) D
 . ; set invoice changed flag
 . S FBINVCHG=1
 . ;
 . ; file data in 162.5
 . K FBFDA
 . S FBFDA(162.5,FBDA_",",56)=$S(FBFPPSC="":"@",1:FBFPPSC)
 . I $D(FBFDA) D FILE^DIE("","FBFDA") D MSG^DIALOG()
 . ;
 . ; add record to audit log
 . K FBFDA
 . S FBFDA(163.7,"+1,",.01)=FBDA ; invoice number
 . S FBFDA(163.7,"+1,",1)=$$NOW^XLFDT() ; date/time changed
 . S FBFDA(163.7,"+1,",2)=162.5 ; file #
 . S FBFDA(163.7,"+1,",3)=FBDA_"," ; iens
 . S FBFDA(163.7,"+1,",4)=56 ; field #
 . S FBFDA(163.7,"+1,",5)=FBFPPSC(0) ; old value
 . S FBFDA(163.7,"+1,",6)=FBFPPSC ; new value
 . S FBFDA(163.7,"+1,",7)=DUZ ; user
 . I $D(FBFDA) D UPDATE^DIE("","FBFDA") D MSG^DIALOG()
 ;
 ;
EDITFL ; edit FPPS Line Item
 W !
 S FBX=$$FPPSL^FBUTL5(FBFPPSL,1)
 I FBX=-1 S FBAAOUT=1 G INVEDX
 S FBFPPSL=FBX
 ;
 ; if FPPS LINE ITEM changed, then update file and audit log
 I FBFPPSL'=FBFPPSL(0) D
 . ; set invoice changed flag
 . S FBINVCHG=1
 . ;
 . ; file data in 162.5
 . K FBFDA
 . S FBFDA(162.5,FBDA_",",57)=FBFPPSL
 . I $D(FBFDA) D FILE^DIE("","FBFDA") D MSG^DIALOG()
 . ;
 . ; add record to audit log
 . K FBFDA
 . S FBFDA(163.7,"+1,",.01)=FBDA ; invoice number
 . S FBFDA(163.7,"+1,",1)=$$NOW^XLFDT() ; date/time changed
 . S FBFDA(163.7,"+1,",2)=162.5 ; file #
 . S FBFDA(163.7,"+1,",3)=FBDA_"," ; iens
 . S FBFDA(163.7,"+1,",4)=57 ; field #
 . S FBFDA(163.7,"+1,",5)=FBFPPSL(0) ; old value
 . S FBFDA(163.7,"+1,",6)=FBFPPSL ; new value
 . S FBFDA(163.7,"+1,",7)=DUZ ; user
 . I $D(FBFDA) D UPDATE^DIE("","FBFDA") D MSG^DIALOG()
 ;
INVEDX ; Invoice Edit Exit
 ; if invoice changed then queue for retransmit to FPPS
 I FBINVCHG D FILEQUE^FBFHLL(FBDA,9)
 Q
 ;
CLEAN K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K FBAAOUT,FBDA,FBFDA,FBFPPSC,FBFPPSL,FBINVCHG,FBX
 Q
 ;FBCHFED
