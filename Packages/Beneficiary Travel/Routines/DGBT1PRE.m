DGBT1PRE ;ALB/MRY - Env/Pre/Post-install of DGBT V1.0 ; 9/25/01 10:10 AM
 ;;1.0;Beneficiary Travel;;September 25, 2001
 ;
EN ;
 S XPDABORT=""
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 ; Verify Registration v5.3 exists, else Quit.
 I $$VERSION^XPDUTL("DG")'=5.3 D  G ABRT
 . W !!,"VERSION 5.3 OF REGISTRATION HAS NOT BEEN LOADED."
 W !!,">> Environment check complete and okay."
 Q
 ;
PRE ; Pre-init
 ; If previous beta version with different name, then correct name.
 D FIND^DIC(9.4,"","@;1;.01","P","DGBT","","C","","","DGBTARRY")
 S DGBTI=0
 F  S DGBTI=$O(DGBTARRY("DILIST",DGBTI)) Q:'DGBTI  D
 . S X=$G(DGBTARRY("DILIST",DGBTI,0)),DGBTIEN=$P(X,"^",1)
 . I $P(X,"^",2)="DGBT",$P(X,"^",3)'="BENEFICIARY TRAVEL" D
 . . ; Correct old name to this version name.
 . . S FDATA(9.4,DGBTIEN_",",.01)="BENEFICIARY TRAVEL"
 . . D FILE^DIE("E","FDATA","ERR")
 K DGBTI,DGBTIEN,X,FDATA,ERR,DGBTARRY
 ;
 ; Remove 'DGBT' from ADDITIONAL PREFIXES of the Registration Package.
 N DIC
 S DIC="^DIC(9.4,",DIC(0)="X",X="REGISTRATION"
 D ^DIC I Y<0 D  G ABRT
 . D BMES^XPDUTL("REGISTRATION PACKAGE HAS NOT BEEN FOUND")
 . D MES^XPDUTL("CONTACT - PIMS National VISTA Support Team for assistance!")
APREF ; Delete 'DGBT' from ADDITIONAL PREFIXES Field (#14).
 S (DA(1),DGBTY)=+Y,DIC=DIC_DA(1)_",14,"
 S DIC(0)="X",DIC("P")=$P(^DD(9.4,14,0),"^",2),X="DGBT"
 D ^DIC I Y<0 K DIC,X G XPREF
 S DIE=DIC K DIC
 S DA=+Y,DR=".01///@" D ^DIE
 K DIE,DR,DA,Y
XPREF ; Add 'DGBT' entry to the EXCLUDED NAME SPACE (#919) field.
 S DIC="^DIC(9.4,",DA(1)=+DGBTY
 S DIC=DIC_DA(1)_",""EX"",",DIC(0)="L",DIC("P")=$P(^DD(9.4,919,0),"^",2)
 S X="DGBT" D ^DIC
 K DIC,DA,Y,X,DGBT Q
 ;
POST ; - Run Post-init to update PACKAGE entry for 'DGBT'.
 D ^DGBT1POS
 Q
 ;
ABRT S XPDABORT=2 Q
