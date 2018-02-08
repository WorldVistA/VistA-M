PSN513PO ;BIR/SJA-Post install routine for patch PSN*4*513 ; 19 Jan 2017  1:20 PM
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;
 Q
POST ; -- post-install entry
 N II,PSNA,ITEM,PSNSVR1 S PSSMXUA2=1
 ; delete invalid hazard waste entries 
 S II=0 F  S II=$O(^PSNDF(50.68,II)) Q:'II  D
 . I $G(^PSNDF(50.68,II,"HAZTODIS2",0))=0 K ^PSNDF(50.68,II,"HAZTODIS2",0)
 ;
 D BMES^XPDUTL("Rebuilding National Drug File Menu....")
 D ADD
 D BMES^XPDUTL("Rebuilding menus complete.")
 D PPSN
 D SETWS
 S PSNSVR1=$$FILESRVR("PPSN","vaausppsapp21.aac.domain.ext",443)
 D SERVICE("UPDATE_STATUS","PPSN",PSNSVR1) ; add web service to web server
 Q
 ;
ADD ; -- add new menu option and update order for PSNMGR & PSN PPS MENU
 S PSNA=$$ADD^XPDMENU("PSNMGR","PSNPMIS PRINT","PMIS",9)
 S PSNA=$$ADD^XPDMENU("PSNMGR","PSN MED GUIDE","FDA",10)
 S PSNA=$$ADD^XPDMENU("PSNMGR","PSN PPS MENU","PPS",20)
 D BMES^XPDUTL("  PSN PPS MENU option "_$S('+$G(PSNA):"NOT ",1:"")_"added to menu PSNMGR")
 D BMES^XPDUTL("Updating PSN PPS MENU menu display order...")
 S ITEM="PSN PPS SCHEDULE DOWNLOAD",PSNA=$$ADD^XPDMENU("PSN PPS MENU",ITEM,"SD",1) D MSG(ITEM,PSNA)
 S ITEM="PSN PPS SCHEDULE INSTALL",PSNA=$$ADD^XPDMENU("PSN PPS MENU",ITEM,"SI",2)
 S ITEM="PSN PPS MANUAL DOWNLOAD",PSNA=$$ADD^XPDMENU("PSN PPS MENU",ITEM,"MD",3)
 S ITEM="PSN PPS MANUAL INSTALL",PSNA=$$ADD^XPDMENU("PSN PPS MENU",ITEM,"MI",4)
 S ITEM="PSN PPS REJECT FILE",PSNA=$$ADD^XPDMENU("PSN PPS MENU",ITEM,"RJ",5)
 S ITEM="PSN PPS PARAM",PSNA=$$ADD^XPDMENU("PSN PPS MENU",ITEM,"SP",6)
 D MES^XPDUTL("Display order updated")
 Q
MSG(ITEM,PSNA) ; -- write message
 D BMES^XPDUTL("  "_ITEM_" option "_$S('+$G(PSNA):"NOT ",1:"")_"added to menu PSN PPS MENU")
 Q
PPSN ; -- add new entry in ^PS(57.23 if it doesn't exist
 Q:$O(^PS(57.23,0))
 N PSNTN,RADD,RUSR
 K DA,DIC S X="PPSN",DIC="^PS(57.23,",DIC(0)="L" D FILE^DICN K DIC
 S PSNTN=+Y
 S RADD="vaausmocftpprd01.aac.domain.ext",RUSR="presftp"
 S DA=PSNTN,DIE=57.23,DR="2///0;8///0;9///N;10///N;20///"_RADD_";22///"_RUSR_";45///Y" D ^DIE K DR
 S $P(^PS(59.7,1,10),"^",12)="P"
 Q
 ;
SETWS ;define UPDATE_STATUS web service
 N PSSWSERV,PSSWSER2,PPSWPPSN,PSSWSCNT,PSSWSMSG,PSSWSSTA,PSSWSERR,DA,DIE,DIC,DR,X,Y,DLAYGO,WSARR
 S (PSSWSERR,PSSWSCNT)=0,PSSMXUA2=1
 S DIC="^XOB(18.12,",X="PPSN",DIC(0)="X" D ^DIC
 I Y<1 D
 .D BMES^XPDUTL("  Creating PPSN web server.") S PSSMXUA2=PSSMXUA2+1
 .S WSARR("WSDL FILE")=""
 .S WSARR("CACHE PACKAGE NAME")=""
 .S WSARR("WEB SERVICE NAME")="PPSN"
 .S WSARR("AVAILABILITY RESOURCE")="?wsdl"
 .S XOBSTAT=$$GENPORT^XOBWLIB(.WSARR)
 .S DIC="^XOB(18.12,",X="PPSN",DIC(0)=X
 S PPSWPPSN=+Y K DIC  ;find the PPSN web server IEN
 D BMES^XPDUTL("Beginning UPDATE_STATUS Web Service definition for PPSN web server: ")
 S @XPDGREF@("PSSMLMSG",PSSMXUA2)="Beginning UPDATE_STATUS Web Service definition: " S PSSMXUA2=PSSMXUA2+1
 I PPSWPPSN=-1 D  G SETWSQT
 .D BMES^XPDUTL("     PPSN Web Server is not defined. Please contact product support.") S PSSWSERR=1
 .S @XPDGREF@("PSSMLMSG",PSSMXUA2)="  PPSN Web Server isn't defined and UPDATE_STATUS Web Service couldn't be" S PSSMXUA2=PSSMXUA2+1
 .S @XPDGREF@("PSSMLMSG",PSSMXUA2)="     created.  Please log a National Help Desk Ticket and refer to this message." S PSSMXUA2=PSSMXUA2+1
SETWS2 ;
 S DIC="^XOB(18.02,",X="UPDATE_STATUS",DIC(0)="X" D ^DIC S PSSWSERV=+Y ;get the IEN for the UPDATE_STATUS web service
 I +Y<1,PSSWSCNT=0 D REGREST^XOBWLIB("UPDATE_STATUS","/PRE/ndf/update/","status") H 3 S PSSWSCNT=1 G SETWS2  ;if not there register the web service
 I +Y<1 D  H 3 G SETWSQT
 .D BMES^XPDUTL("  UPDATE_STATUS web service has NOT been created. Please contact product support.")
 .S @XPDGREF@("PSSMLMSG",PSSMXUA2)="  UPDATE_STATUS web service has NOT been defined.  Please log a" S PSSMXUA2=PSSMXUA2+1,PSSWSERR=1
 .S @XPDGREF@("PSSMLMSG",PSSMXUA2)="  National Help Desk ticket and refer to this message." S PSSMXUA2=PSSMXUA2+1
 .S @XPDGREF@("PSSMLMSG",PSSMXUA2)=" " S PSSMXUA2=PSSMXUA2+1
 S PSSWSMSG=$S(PSSWSCNT=0:"UPDATE_STATUS web service was previously defined.  No action taken.",1:"UPDATE_STATUS web service has been defined.")
 S @XPDGREF@("PSSMLMSG",PSSMXUA2)="  "_PSSWSMSG S PSSMXUA2=PSSMXUA2+1
 D BMES^XPDUTL("     "_PSSWSMSG)
 ;
 K DIC,DIE,DA,DR,X,Y
 S DIC="^XOB(18.12,"_PPSWPPSN_",100,",X="UPDATE_STATUS",DIC(0)="X" D ^DIC S PSSWSER2=+Y
 L +^XOB(18.12,PPSWPPSN):20 I '$T D  H 3 G SETWSQT
 .D BMES^XPDUTL("     Unable to lock file 18.12 to enable UPDATE_STATUS web service. Please ")
 .D BMES^XPDUTL("     contact product support.")
 .S @XPDGREF@("PSSMLMSG",PSSMXUA2)="  Unable to lock file 18.12 to enable UPDATE_STATUS web service." S PSSMXUA2=PSSMXUA2+1
 .S @XPDGREF@("PSSMLMSG",PSSMXUA2)="  Please contact the National Help Desk and refer to this message." S PSSMXUA2=PSSMXUA2+1,PSSWSERR=1
 I PSSWSER2=-1 D PSSENABL G SETWSQT
 S PSSWSSTA=$$GET1^DIQ(18.121,PSSWSER2_",1",".06","I")
 I PSSWSSTA=-1 D PSSENABL G SETWSQT
 I PSSWSSTA=""!(PSSWSSTA=0) D PSSENAB2 G SETWSQT
 I PSSWSSTA D
 .D BMES^XPDUTL("     UPDATE_STATUS web service was previously enabled.  No action taken.")
 .S @XPDGREF@("PSSMLMSG",PSSMXUA2)="  UPDATE_STATUS web service was previously enabled. No action taken." S PSSMXUA2=PSSMXUA2+1
SETWSQT ;
 L -^XOB(18.12,PPSWPPSN)
 I $G(PSSWSERR) D
 .D BMES^XPDUTL("  **************************************************************************")
 .D BMES^XPDUTL("  ** Due to error(s), UPDATE_STATUS web service definition is not complete. **")
 .D BMES^XPDUTL("  **************************************************************************")
 .S @XPDGREF@("PSSMLMSG",PSSMXUA2)="*** Due to error(s), UPDATE_STATUS web service definition is not complete." S PSSMXUA2=PSSMXUA2+1
 I '$G(PSSWSERR) D BMES^XPDUTL("Web Service definition process is complete for PPSN web server.") D
 .S @XPDGREF@("PSSMLMSG",PSSMXUA2)="Web Service definition process is complete." S PSSMXUA2=PSSMXUA2+1
 D LINE
 Q
 ;
LINE ;
 S @XPDGREF@("PSSMLMSG",PSSMXUA2)=" " S PSSMXUA2=PSSMXUA2+1
 Q
 ;
PSSENABL ;
 S DIC="^XOB(18.12,"_PPSWPPSN_",100,",DLAYGO=18.121,DIC(0)="L",DA(1)=PPSWPPSN,X="UPDATE_STATUS" D ^DIC S PSSWSER2=+Y
PSSENAB2 ;
 S DIE="^XOB(18.12,"_PPSWPPSN_",100,",DR=".06///ENABLE",DA(1)=PPSWPPSN,DA=PSSWSER2 D ^DIE
 S PSSWSSTA=$$GET1^DIQ(18.121,PSSWSER2_",1",".06","I")
 I PSSWSSTA D
 .D BMES^XPDUTL("     UPDATE_STATUS web service has been enabled.")
 .S @XPDGREF@("PSSMLMSG",PSSMXUA2)="  UPDATE_STATUS web service has been enabled." S PSSMXUA2=PSSMXUA2+1
 Q
 ;
FILESRVR(PSNSRVR,PSNADRS,PSNPORT) ; File a new record in file #18.12 or edit existing
 ; Input: PSNSRVR - web server name
 ;        PSNADRS - web server address
 ;        PSNPORT - port number
 ; Output:
 ;        Function Value - Returns IEN of record on success, 0 on failure
 ;
 N FDA,FDAI,PSNERR,PSNIENS,PSNIEN,DIERR
 S PSNIEN=+$$FIND1^DIC(18.12,"","BX",PSNSRVR,"","","")
 ;
 ; If record doesn't already exist, create new
 I PSNIEN S PSNIENS=PSNIEN_","
 E  S PSNIENS="+1,"
 D BMES^XPDUTL($S(PSNIEN:"Updating",1:"Creating")_" PPSN Web Server...")
 S @XPDGREF@("PSSMLMSG",PSSMXUA2)=$S(PSNIEN:"Updating",1:"Creating")_" PPSN Web Server..."
 S PSSMXUA2=PSSMXUA2+1
 ;
 ; Set up FDA with field values
 S FDA(18.12,PSNIENS,.01)=$G(PSNSRVR) ;server name
 S FDA(18.12,PSNIENS,.03)=$G(PSNPORT) ;ws port nbr
 I 'PSNIEN S FDA(18.12,PSNIENS,.04)=$G(PSNADRS) ;server address
 S FDA(18.12,PSNIENS,.06)=1 ;status
 S FDA(18.12,PSNIENS,.07)=30 ;timeout
 S FDA(18.12,PSNIENS,3.01)=1 ;ssl enabled
 S FDA(18.12,PSNIENS,3.02)="encrypt_only" ;SSL configuration
 S FDA(18.12,PSNIENS,3.03)=443 ;SSL port number
 ;
 I PSNIEN D  ;update current record
 . D FILE^DIE("K","FDA","PSNERR")
 . I $D(PSNERR) D
 . . D DISPERR($NA(PSNERR),PSSMXUA2)
 . . S PSNIEN=0
 E  D  ;create new record
 . D UPDATE^DIE("","FDA","FDAI","PSNERR")
 . I $D(PSNERR) D
 . . D DISPERR($NA(PSNERR),PSSMXUA2)
 . . S PSNIEN=0
 . E  D
 . . S PSNIEN=$G(FDAI(1))
 ;
 Q $S($G(PSNIEN)>0:PSNIEN,1:0)
 ;
SERVICE(SVCS,SRVR,SVRIEN) ; add web service to web server
 ; Input: SVCS   - web service name
 ;        SRVR   - web server name
 ;        SVRIEN - web server ien
 ;
 N SVCIEN,PSNIENS,PSNFDA,PSNFDAI,PSNERR,DIERR
 ;
 S SVCIEN=+$$FIND1^DIC(18.02,"","BX",SVCS,"","","")
 I '$D(^XOB(18.12,"AB",SVCIEN,SVRIEN)) D
 . ;add sub rec
 . S PSNIENS="+1,"_SVRIEN_","
 . S PSNFDA(18.121,PSNIENS,.01)=SVCIEN ;service ien
 . S PSNFDA(18.121,PSNIENS,.06)=1 ;status
 . D UPDATE^DIE("","PSNFDA","PSNFDAI","PSNERR")
 . I $D(DIERR) D
 . . D DISPERR($NA(PSNERR))
 . . D MES^XPDUTL(" o  ERROR occurred registering WEB SERVICE '"_SVCS_"' to WEB SERVER '"_SRVR_"'")
 . . D MES^XPDUTL(" ")
 . E  D
 . . D MES^XPDUTL(" o  WEB SERVICE '"_SVCS_"' was registered to WEB SERVER '"_SRVR_"'")
 . . D MES^XPDUTL(" ")
 . D CLEAN^DILF
 E  D
 . D MES^XPDUTL(" o  WEB SERVICE '"_SVCS_"' already registered to WEB SERVER '"_SRVR_"'")
 . D MES^XPDUTL(" ")
 Q
 ;
DISPERR(PSNARR,PSSMXUA2) ; display error message
 N PSNOUT,PSNI
 W !,"Database Server Error Information:" S PSSMXUA2=PSSMXUA2+1
 D MSG^DIALOG("AE",.PSNOUT,70,"",PSNARR)
 F PSNI=1:1 Q:$D(PSNOUT(PSNI))=0  W !,$G(PSNOUT(PSNI)) S PSSMXUA2=PSSMXUA2+1
 Q
 ;
