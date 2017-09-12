EC2P72PT ;ALB/JAM - PATCH EC*2.0*72 Post-Init Rtn ; 5/11/06 2:57pm
 ;;2.0; EVENT CAPTURE ;**72**;8 May 96
 ;
POST ; entry point
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Converting Provider fields 10,15 and 17 to a multiple field")
 D MES^XPDUTL("                           in EVENT CAPTURE PATIENT file (#721)...")
 D MES^XPDUTL(" ")
 I '$D(^ECH) D  Q
 .D BMES^XPDUTL("Event Capture File #721 doesn't exist on this account.")
 .D MES^XPDUTL("            No conversion necessary.  Process terminated...")
 D MES^XPDUTL(" ")
 I '$D(^DD(721,42)) D  Q
 .D BMES^XPDUTL("Event Capture Field #42 doesn't exist on this account.")
 .D MES^XPDUTL("            Conversion CANNOT proceed.  Process terminated...")
 D EN1
 Q
 ;
RESTART ;Restart Provider fields conversion backjob 
 D BMES^XPDUTL("Restarting Conversion of Provider fields 10,15 and 17 to a ")
 D MES^XPDUTL("       multiple field in EVENT CAPTURE PATIENT file (#721)...")
 D MES^XPDUTL(" ")
 D EN1
 Q
EN1 ;
 L +^ECH(0):10 I '$T D  G END
 .D BMES^XPDUTL("Event Capture File in Use.  Try again later..")
 D BMES^XPDUTL("*** Event Capture menu will be locked and unavailable... ***")
 D BMES^XPDUTL("You will receive a MailMan message when task is completed or if stopped.")
 D BMES^XPDUTL("  ")
 S ZTRTN="START^EC2P72PT",ZTDESC="Provider Conversion in File #721, EC*2*72",ZTIO=""
 S ZTDTH=$H,ZTREQ="@",ZTSAVE("ZTREQ")=""
 I $G(XPDSET)'="" S ZTSAVE("XPDSET")=""
 D ^%ZTLOAD
END D KILL1
 L -^ECH(0)
 Q
 ;
START ;* background job entry point
 N ECIEN,ECDAT,ECPRV,X1,X2,X,I,TXTVAR,LINE,COUNT,STOP,ECX1
 ;Disable options
 D OUT^XPDMENU("ECXEC","OUT OF ORDER FOR EC PROVIDER CONVERSION")
 D OUT^XPDMENU("ECMENU","OUT OF ORDER FOR EC PROVIDER CONVERSION")
 D OUT^XPDMENU("EC GUI CONTEXT","OUT OF ORDER FOR EC PROVIDER CONVERSION")
 D OUT^XPDMENU("ECMGR","OUT OF ORDER FOR EC PROVIDER CONVERSION")
 K ^TMP($J,"EC2P72")
 S (COUNT,STOP)=0,ECIEN=+$G(^XTMP("ECPROVIDER",1))
 S (ECX1,X1)=$$NOW^XLFDT(),X2=60 D C^%DTC
 I '$D(^XTMP("ECPROVIDER",0)) D
 .S ^XTMP("ECPROVIDER",0)=X_"^"_ECX1_"^EC Provider fields conversion to multiple"
 S ^XTMP("ECPROVIDER",3)=$$FMTE^XLFDT($$NOW^XLFDT(),1)  ;start time
 F I=1:1 S TXTVAR=$P($T(MSGTXT+I),";;",2) Q:TXTVAR="QUIT"  D LINE(TXTVAR)
 L +^ECH(0):60   ;review if this is necessary
 F  S ECIEN=$O(^ECH(ECIEN)) Q:'ECIEN  D  I STOP Q
 .S ECDAT=$G(^ECH(ECIEN,0)) I ECDAT="" D UPXTMP Q
 .K ECPRV
 .I $P(ECDAT,"^",11)'="" S ECPRV(1)=$P(ECDAT,"^",11)_"^P"
 .I $P(ECDAT,"^",15)'="" S ECPRV(2)=$P(ECDAT,"^",15)_"^"_$S($O(ECPRV("")):"S",1:"P")
 .I $P(ECDAT,"^",17)'="" S ECPRV(3)=$P(ECDAT,"^",17)_"^"_$S($O(ECPRV("")):"S",1:"P")
 .D UPD721
 .D UPXTMP
 .;Check Background task (taskman) - to see if task stopped
 .S STOP=$$S^%ZTLOAD()
 S $P(^XTMP("ECPROVIDER",3),"^",2)=$$FMTE^XLFDT($$NOW^XLFDT(),1)
 I STOP D  G END1
 .D LINE("  The provider conversion process was aborted.")
 .D LINE("     Conversion began:          "_$P($G(^XTMP("ECPROVIDER",3)),"^"))
 .D LINE("     Conversion terminated:     "_$P($G(^XTMP("ECPROVIDER",3)),"^",2))
 .D LINE("     Last record (IEN) Updated: "_$G(^XTMP("ECPROVIDER",1)))
 .D LINE("     Last IEN in File #721:     "_$O(^ECH("A"),-1))
 .D LINE("     Total # Records converted: "_$G(^XTMP("ECPROVIDER",2)))
 .D LINE(" ")
 .D LINE("  To restart the provider conversion process enter the following at the programmer's prompt.")
 .D LINE("      D RESTART^EC2P72PT")
 .D LINE(" ")
 .D LINE("   Make sure the following options are placed out of order")
 .D LINE("      ECMENU           Event Capture Menu")
 .D LINE("      EC GUI CONTEXT   EC GUI Context version 2.0.11.1")
 .D LINE("      ECXEC            Event Capture Extract")
 .D LINE("      ECMGR            Event Capture Management Menu")
 D LINE("  The provider conversion process was successfully completed.")
 D LINE("     Conversion began:            "_$P($G(^XTMP("ECPROVIDER",3)),"^"))
 D LINE("     Conversion completed:        "_$P($G(^XTMP("ECPROVIDER",3)),"^",2))
 D LINE("     Last record (IEN) converted: "_$G(^XTMP("ECPROVIDER",1)))
 D LINE("     Last IEN in File #721:       "_$O(^ECH("A"),-1))
 D LINE("     Total # Records converted:   "_$G(^XTMP("ECPROVIDER",2)))
 D LINE(" ")
 D LINE("  Make sure the following options are placed back in order")
 D LINE("     ECMENU           Event Capture Menu")
 D LINE("     EC GUI CONTEXT   EC GUI Context version 2.1.0.0")
 D LINE("     ECXEC            Event Capture Extract")
 ;Place option back in order
 D OUT^XPDMENU("ECXEC","")
 D OUT^XPDMENU("ECMENU","")
 D OUT^XPDMENU("EC GUI CONTEXT","")
 D OUT^XPDMENU("ECMGR","")
END1 D MAIL
 L -^ECH(0)
 K ^TMP($J,"EC2P72"),I,Y
 Q
UPXTMP ;Update ^XTMP with last ECIEN from ^ECH
 S ^XTMP("ECPROVIDER",1)=ECIEN
 S ^XTMP("ECPROVIDER",2)=+$G(^XTMP("ECPROVIDER",2))+1
 Q
UPD721 ;Update ^ECH with providers at multiple field #42.
 N SIEN,ECDATA,ECPRVDA,ECERR,DA,DIK
 ;delete old entries
 I '$D(ECPRV) Q
 I $D(^ECH(ECIEN,"PRV")) D
 . S DA(1)=ECIEN,DIK="^ECH("_DA(1)_",""PRV"",",DA=0
 . F  S DA=$O(^ECH(DA(1),"PRV",DA)) Q:'DA  D ^DIK
 S SIEN=0
 F  S SIEN=$O(ECPRV(SIEN)) Q:'SIEN  D
 .S ECDATA=ECPRV(SIEN)
 .D FILALT
 Q
FILALT ;If error occurs filing trying record using another method
 N DIC,DD,DO,X,DIE,DR,DA
 S DIC(0)="L",DA(1)=ECIEN,DIC("P")=$P(^DD(721,42,0),U,2)
 S X=+ECDATA,DIC="^ECH("_DA(1)_","_"""PRV"""_"," D FILE^DICN
 S DIE=DIC,DR=".02////"_$P(ECDATA,U,2) D ^DIE
 Q
 ;
LINE(TEXT) ; Add line to message global
 S COUNT=COUNT+1,^TMP($J,"EC2P72",COUNT)=TEXT
 Q
 ;
MSGTXT ; Message intro
 ;; Please forward this message to your local DSS Site Manager or
 ;; Event Capture ADPAC.
 ;;
 ;; A conversion was done on the providers stored in fields #10, 15 
 ;; and 17 in Event Capture file #721. The data was moved to a new 
 ;; provider multiple field #42 in file #721. The data in fields 
 ;; #10, 15 and 17 will remain but no new data will be populated in 
 ;; these fields with the installation of EC*2.0*72.  This message 
 ;; provides the results of the conversion.
 ;;
 ;;QUIT
 ;
MAIL ; Send message
 N XMDUZ,XMY,XMTEXT,XMSUB
 S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Event Capture Provider Field Conversion to New Multiple Field"
 S XMTEXT="^TMP($J,""EC2P72"","
 D ^XMD
 Q
KILL1 ;
 K ZTDESC,ZTDTH,ZTIO,ZTREQ,ZTRTN,ZTSAVE("ZTREQ"),ECKID
 Q
