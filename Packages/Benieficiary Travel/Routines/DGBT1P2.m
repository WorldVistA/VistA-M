DGBT1P2 ;ALB/MRY - Patch #2 Environment Check ; 4/23/02 10:04 AM
 ;;1.0;Beneficiary Travel;**2**;Septembr 25, 2001
EN ;
 S XPDABORT=""
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 ; Verify that Bene Travel v1.0 exists, else Quit.
 I $$VERSION^XPDUTL("DGBT")'="1.0" D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("VERSION 1.0 OF BENEFICIARY TRAVEL HAS NOT BEEN LOADED.")
 . D MES^XPDUTL("Installation aborted.")
 W !!,">> Environment check complete and okay."
 Q
 ;
ABRT ; Abort transport, but leave in ^XTMP.
 S ^XPDABORT=2 Q
 ;
POST ; Post install - add #392.31 file to list of DGBT files in Package file.
 N DGBTI,DGBTIEN,DGBTARRY,DIC,X,DA,DR
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("   Updating PACKAGE File...")
 ;
PKG ; Retrieve 'DGBT' Package name
 ; Get Package IEN
 D FIND^DIC(9.4,"","@;1","P","DGBT","","C","","","DGBTARRY")
 S (DGBTI,DGBTIEN)=0
 F  S DGBTI=$O(DGBTARRY("DILIST",DGBTI)) Q:'DGBTI  D
 . Q:$P($G(DGBTARRY("DILIST",DGBTI,0)),"^",2)'="DGBT"
 . S DGBTIEN=$P($G(DGBTARRY("DILIST",DGBTI,0)),"^",1)
 I 'DGBTIEN D  G EXIT
 . D BMES^XPDUTL(" ")
 . D MES^XPDUTL("  No PACKAGE entry defined - Cannot update!")
 ;
UPD ; - Update fields not updated by the KIDS install.
 ; fields:
 ;       File (#6)             ; multiple
 ;         Fields              ; multiple
 ;
FILE ; Add #392.31 to list of files under Bene Travel.
 F X="392.31" D
 . S DIC="^DIC(9.4,",DA(1)=DGBTIEN
 . S DIC=DIC_DA(1)_",4,",DIC(0)="L",DIC("P")=$P(^DD(9.4,6,0),"^",2)
 . D ^DIC
 ;
FLDS ; Add ASSIGN A VERSION NUMBER? entries to File entry #392.31
 S DIC="^DIC(9.4,",DA(1)=DGBTIEN,DIC(0)="X"
 S DIC=DIC_DA(1)_",4,",DIC("P")=$P(^DD(9.4,6,0),"^",2)
 F X="392.31" D
 . D ^DIC
 . S DIE=DIC,DA=+Y
 . I X[392 S DR="222.2///Y" D ^DIE
 D BMES^XPDUTL(" ")
 D MES^XPDUTL("     Updating PACKAGE file complete.")
 ;
DD ;Hardset IDENTIFIER routine into DD (DBIA #4093)
 S ^DD(392.31,0,"ID","Z")="G START^DGBTID"
 ;
EXIT K DIC,DGBTARRY,DGBTI,DGBTIEN,X,DA,DR
 Q
