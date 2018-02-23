PSO467PO ;ALB/BWF - patch 467 post-install ; 8/17/2016 1:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467**;DEC 1997;Build 153
 ;
 ; ICR #4677 = $$CREATE^XUSAP (API for Application Proxy)
 ; ICR #10141 = BMES^XPDUTL & MES^XPDUTL
 ; 
 ; Application Proxy name = "PSOAPPLICATIONPROXY,PSO"
 ; Secondary Menu Option name = "PSO WEB SERVICES OPTION"
 ;
RUNALL ; Entry point in the (Patch - PSO*7.0*467)
 D BMSG("Starting Post-Init")
 D PROXY
 D MSG("Post-Init Complete")
 D APRIND
 D WSERV
 D PAYMIG
 D INDEX
 Q
 ;
PROXY ; Create an Application Proxy for PSO application
 N X
 S X=$$CREATE^XUSAP("PSOAPPLICATIONPROXY,PSO","","PSO WEB SERVICES OPTION")
 ;
 I +X=0 D  Q
 .D BMSG("   Application Proxy User - 'PSOAPPLICATIONPROXY,PSO'")
 .D MSG("   already exists in the NEW PERSON file (#200)"),MSG("")
 ;
 I +X=-1 D  Q
 .D BMSG("   Application Proxy User - 'PSOAPPLICATIONPROXY,PSO'")
 .D MSG("   Unsuccessful; could not create Application Proxy User")
 .D MSG("   OR error in call to UPDATE^DIE)"),MSG("")
 ;
 D BMSG("   *****************************************************************")
 D MSG("   ** Application Proxy User - 'PSOAPPLICATIONPROXY,PSO' = created **")
 D MSG("   ** Secondary Menu Option - 'PSO WEB SERVICES OPTION' = linked   **")
 D MSG("   **                         to the Application Proxy.            **")
 D MSG("   ******************************************************************")
 D MSG("")
 Q
 ;
 ; A message is also recorded in INSTALL file
 ; (#9.7) entry for the installation.
 ;
 ; Output a message.
MSG(MSG) ; Integration Agreement #10141
 D MES^XPDUTL(MSG)
 Q
 ;
 ; Output a message with a blank line added.
BMSG(MSG) ; Integration Agreement #10141
 D BMES^XPDUTL(MSG)
 Q
 ; create the APR index
APRIND ;
 N DIK,DA
 S DIK="^PSDRUG(",DIK(1)="22^APR"
 D ENALL^DIK
 Q
 ; create web server and service
WSERV ;
 N FDA,WSIEN,NWSIEN,WSERVIEN,WSRVIEN
 ; if the web service already exists, this has been configured
 I $$FIND1^DIC(18.02,,"B","PSO ERX WEB SERVICE") Q
 ; set up the web service
 S FDA(18.02,"+1,",.01)="PSO ERX WEB SERVICE"
 S FDA(18.02,"+1,",.02)=2
 S FDA(18.02,"+1,",200)="/INB-ERX/"
 D UPDATE^DIE(,"FDA","WSIEN") K FDA
 S NWSIEN=$O(WSIEN(0)),NWSIEN=$G(WSIEN(NWSIEN)) Q:'NWSIEN
 S FDA(18.12,"+1,",.01)="PSO WEB SERVER"
 S FDA(18.12,"+1,",.03)=80
 ;S FDA(18.12,"+1,",.04)="vaauserxappdev1.aac.domain.ext"
 S FDA(18.12,"+1,",.06)=1
 S FDA(18.12,"+1,",.07)=30
 S FDA(18.12,"+1,",1.01)=0
 D UPDATE^DIE(,"FDA","WSERVIEN") K FDA
 S WSRVIEN=$O(WSERVIEN(0)) Q:'WSRVIEN
 S WSRVIEN=$G(WSERVIEN(WSRVIEN)) Q:'WSRVIEN
 S FDA(18.121,"+1,"_WSRVIEN_",",.01)=NWSIEN
 S FDA(18.121,"+1,"_WSRVIEN_",",.06)=1
 D UPDATE^DIE(,"FDA",,"ERR") K FDA
 Q
CALL ;
 N I,X
 F I=52.46,52.47,52.48,52.49 D
 .S X=0 F  S X=$O(^PS(I,X)) Q:'X  D
 ..S FDA(I,X_",",.01)="@"
 D FILE^DIE(,"FDA","FERR") K FDA
 Q
 ; migrate payer fields for new cardholder and sequence structure
PAYMIG ;
 N ERXIEN,BFCIEN,CHID,BIENS,FDA,DA,DR
 ; no need to reindex if there is no data
 I '$O(^PS(52.49,0)) Q
 S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,ERXIEN)) Q:'ERXIEN  D
 .; do not process entries that have already been converted
 .Q:$$GET1^DIQ(52.49,ERXIEN,44,"I")=1
 .S BFCIEN=0 F  S BFCIEN=$O(^PS(52.49,ERXIEN,18,BFCIEN)) Q:'BFCIEN  D
 ..S BIENS=BFCIEN_","_ERXIEN_","
 ..S CHID=$$GET1^DIQ(52.4918,BIENS,.01,"E")
 ..; move the cardholder id to field 7 and change the .01 field to the IEN (as a sequence)
 ..S FDA(52.4918,BIENS,7)=CHID
 ..S FDA(52.4918,BIENS,.01)=BFCIEN
 ..D FILE^DIE(,"FDA") K FDA
 .; set the conversion flag so this conversion will not run again for this entry.
 .S DIE="^PS(52.49,",DA=ERXIEN,DR="44///1" D ^DIE K DIE
 Q
 ; reindex all files
INDEX ;
 N DIK,FILE
 ; no need to reindex if there is no data
 I '$O(^PS(52.49,0)) Q
 F FILE="52.45","52.46","52.47","52.48","52.49" D
 .S DIK="^PS("_FILE_"," D IXALL2^DIK,IXALL^DIK
 Q
