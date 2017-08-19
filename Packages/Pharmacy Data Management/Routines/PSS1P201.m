PSS1P201 ;BP/CMF - PATCH PSS*1*201 Pre/Post-Init Rtn ;09/13/2016
 ;;1.0;PHARMACY DATA MANAGEMENT;**201**;9/30/97;Build 25
 ;
ENV ;environment check
 S XPDABORT=""
 ;D PRODCHK(.XPDABORT) I XPDABORT=2 Q  restriction removed after sprint 3
 D PROGCHK(.XPDABORT)
 I XPDABORT="" K XPDABORT
 Q
 ;
PRODCHK(XPDABORT) ;checks for test/production account
 ;
 I $$PROD^XUPROD DO
 . D BMES^XPDUTL("******")
 . D MES^XPDUTL("PSS*1*201 is not yet ready for production accounts.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("******")
 . S XPDABORT=2
 Q
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 . D BMES^XPDUTL("******")
 . D MES^XPDUTL("Your programming variables are not set up properly.")
 . D MES^XPDUTL("Installation aborted.")
 . D MES^XPDUTL("******")
 . S XPDABORT=2
 Q
 ;
POST ;;
 D APSP  ; add entries to Intervention Type file
 D DOSEUNIT  ; edit entry 40
 Q
 ;;
APSP ;;
 N FDA,FDERROR,LIST,LISTERR,I,IEN
 D BMES^XPDUTL("Adding entries to APSP Intervention Type file")
 D FIND^DIC(9009032.3,"","","X","MAX DAILY DOSE","","","","","LIST","LISTERR")
 D:$P(LIST("DILIST",0),U,1)=0 
 .S FDA(1,9009032.3,"+1,",.01)="MAX DAILY DOSE"
 .D UPDATE^DIE("E","FDA(1)","","FDERROR")
 .I '$D(FDERROR) D MES^XPDUTL("MAX DAILY DOSE added.")
 .Q
 D:$P(LIST("DILIST",0),U,1)>1 
 .S I=1
 .F  S I=$O(LIST("DILIST",2,I)) Q:I=""  D 
 ..S IEN=LIST("DILIST",2,I)
 ..D KILLAPSP(IEN)
 ..Q
 K FDA,FDERROR,LIST,LISTERR,I,IEN
 D FIND^DIC(9009032.3,"","","X","MAX SINGLE DOSE & MAX DAILY DOSE","","","","","LIST","LISTERR")
 D:$P(LIST("DILIST",0),U,1)=0 
 .S FDA(1,9009032.3,"+1,",.01)="MAX SINGLE DOSE & MAX DAILY DOSE"
 .D UPDATE^DIE("E","FDA(1)","","FDERROR")
 .I '$D(FDERROR) D MES^XPDUTL("MAX SINGLE DOSE & MAX DAILY DOSE added.")
 .Q
 D:$P(LIST("DILIST",0),U,1)>1 
 .S I=1
 .F  S I=$O(LIST("DILIST",2,I)) Q:I=""  D 
 ..S IEN=LIST("DILIST",2,I)
 ..D KILLAPSP(IEN)
 ..Q
 K FDA,FDERROR,LIST,LISTERR,I,IEN
 Q
 ;;
KILLAPSP(IEN) ;; remove duplicates
 N DIK,DA
 S DIK="^APSPQA(32.3,",DA=IEN D ^DIK
 Q
 ;;
DOSEUNIT ;; change file 51.24 entry 40 .01 value, so KIDS can update the correct entry
 N XUMF,DA,DIE,DR
 Q:$$FIND1^DIC(51.24,"","MX","SUPPOSITORY(IES)")>0
 S DA=+$$FIND1^DIC(51.24,"","MX","SUPPOSITOR(IES)")
 Q:DA<1
 S XUMF=1,DR=".01////SUPPOSITORY(IES)",DIE=51.24 D ^DIE
 D:$$FIND1^DIC(51.24,"","MX","SUPPOSITORY(IES)")>0 BMES^XPDUTL("Dose Unit Entry Modified")
 Q
 ;;
