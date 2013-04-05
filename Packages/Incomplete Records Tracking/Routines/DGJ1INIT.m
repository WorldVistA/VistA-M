DGJ1INIT ;ALB/MRY - Env/Pre/Post-install of DGJ v1.0 ;[ 06/25/01 15:51 pm]
 ;;1.0;Incomplete Records Tracking;;Jun 25, 2001
 ;
EN ;
 S XPDABORT=""
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 ; Verify Registration v5.3 exists, else Quit.
 I $$VERSION^XPDUTL("DG")'=5.3 D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("VERSION 5.3 OF REGISTRATION HAS NOT BEEN LOADED.")
 . D MES^XPDUTL("Installation aborted.")
 ;
 ; Verify 'DGJ' was removed from Additional Prefixes of REGISTRATION.
 N DIC
 S DIC="^DIC(9.4,",DIC(0)="X",X="REGISTRATION"
 D ^DIC I Y<0 D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("REGISTRATION PACKAGE HAS NOT BEEN FOUND")
 . D MES^XPDUTL("CONTACT - PIMS National VISTA Support Team for assistance!")
 . D MES^XPDUTL("Installation aborted.")
 S DA(1)=+Y,DIC=DIC_DA(1)_",14,"
 S DIC(0)="X",DIC("P")=$P(^DD(9.4,14,0),"^",2),X="DGJ"
 D ^DIC I Y>0 D  G ABRT
 . D BMES^XPDUTL("*****")
 . D MES^XPDUTL("'DGJ' must be removed from REGISTRATION's Additional Prefix field.")
 . D MES^XPDUTL("Follow INSTALLATION instructions found in the Installation Guide.")
 . D MES^XPDUTL("Installation aborted.")
 K DA,DIC
 ;
 ; If previous beta version with different name, then correct name.
 D FIND^DIC(9.4,"","@;1;.01","P","DGJ","","C","","","DGJARRY")
 S DGJI=0
 F  S DGJI=$O(DGJARRY("DILIST",DGJI)) Q:'DGJI  D
 . S X=$G(DGJARRY("DILIST",DGJI,0)),DGJIEN=$P(X,"^",1)
 . I $P(X,"^",2)="DGJ",$P(X,"^",3)'="INCOMPLETE RECORDS TRACKING" D
 . . ; Correct old name to this version name.
 . . S FDATA(9.4,DGJIEN_",",.01)="INCOMPLETE RECORDS TRACKING"
 . . D FILE^DIE("E","FDATA","ERR")
 K DGJI,DGJIEN,X,FDATA,ERR,DGJARRY
 ;
OK K DIE,DR,DA,Y
 ;
 W !!,"Environment check completed and okay."
 Q
 ;
POST ; - Run Post-init to Update Package entry for 'DGJ'.
 D ^DGJ1INIP
 Q
ABRT S XPDABORT=2 Q
