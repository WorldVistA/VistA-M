EC2P86PT ;ALB/JAM - PATCH EC*2.0*86 Post-Init Rtn ; 04/22/07 5:04pm
 ;;2.0; EVENT CAPTURE ;**86**;8 May 96;Build 8
 ;
 Q
POST ; entry point
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("This installation will disable all of Event Capture System (ECS) Roll-and-Scroll")
 D MES^XPDUTL("options as part of the official shutdown of this interface.")
 D MES^XPDUTL(" ")
 D MES^XPDUTL("The Roll-and-Scroll interface will no longer be supported and as such users are")
 D MES^XPDUTL("required to use the Graphical User Interface which provides the equivalent")
 D MES^XPDUTL("functionality.")
 D MES^XPDUTL(" ")
 D EN
 Q
 ;
EN ;* entry point
 N LOOP,OPT,ECNT,SCNT,PCNT,COUNT,I,TXTVAR,DATA,DESC
 K ^TMP($J,"EC2P86","NFND"),^TMP($J,"EC2P86","FND"),^TMP($J,"EC2P86MG")
 K ^TMP($J,"EC2P86","PFND")
 S (ECNT,SCNT,COUNT,PCNT)=0,$P(BLK," ",30)=""
 D MES^XPDUTL("Disabling Event Capture Roll-and-Scroll Options...")
 F I=1:1 S TXTVAR=$P($T(MSGTXT+I),";;",2) Q:TXTVAR="QUIT"  D LINE(TXTVAR)
 ;Disable options
 F LOOP=1:1 S DATA=$P($T(OPTIONS+LOOP),";;",2) Q:DATA="QUIT"  D
 .S OPT=$P(DATA,";"),DESC=$P(DATA,";",2)
 .I $$LKOPT^XPDMENU(OPT)'>0 Q:LOOP>36  D ELINE($E(OPT_BLK,1,19)_DESC) Q
 .D OUT^XPDMENU(OPT,"OPTION NO LONGER SUPPORTED. USE THE ECS GUI INTERFACE.")
 .D MES^XPDUTL($E(OPT_BLK,1,19)_" "_DESC_" Disabled...")
 .I LOOP>36 D PLINE($E(OPT_BLK,1,19)_DESC) Q
 .D SLINE($E(OPT_BLK,1,19)_DESC)
 D BMES^XPDUTL("National Options Disabled Successfully:     "_SCNT)
 I PCNT>0 D MES^XPDUTL("Pre-Released Options Disabled Successfully:  "_PCNT)
 D MES^XPDUTL("National Options Disabled Unsuccessfully:    "_ECNT)
 D ADDMSG
 D MAIL
 K ^TMP($J,"EC2P86"),^TMP($J,"EC2P86MG")
 Q
 ;
RESTORE ;Place options back in order
 N LOOP,OPT,BLK
 S $P(BLK," ",30)=""
 D MES^XPDUTL("Placing Event Capture Roll-and-Scroll Options back in order.")
 F LOOP=1:1 S DATA=$P($T(OPTIONS+LOOP),";;",2) Q:DATA="QUIT"  D
 .S OPT=$P(DATA,";")
 .D OUT^XPDMENU(OPT,"")
 .D MES^XPDUTL($E(OPT_BLK,1,19)_"  "_$P(DATA,":",2)_" Enabled...")
 Q
 ;
LINE(TEXT) ;Add line to message global
 S COUNT=COUNT+1
 S ^TMP($J,"EC2P86MG",COUNT)=TEXT
 Q
 ;
SLINE(TEXT) ;Add line to global for option found
 S SCNT=SCNT+1
 S ^TMP($J,"EC2P86","FND",SCNT)=TEXT
 Q
 ;
ELINE(TEXT) ;Add line to global for option not found
 S ECNT=ECNT+1
 S ^TMP($J,"EC2P86","NFND",ECNT)=TEXT
 Q
 ;
PLINE(TEXT) ;Add line to global for pre-release option found
 S PCNT=PCNT+1
 S ^TMP($J,"EC2P86","PFND",PCNT)=TEXT
 Q
 ;
ADDMSG ;Add lines to message global
 N CNT
 I $D(^TMP($J,"EC2P86","FND")) D
 .D LINE("Event Capture roll-and-scroll options disabled:")
 .S CNT=0 F  S CNT=$O(^TMP($J,"EC2P86","FND",CNT)) Q:'CNT  D LINE(^(CNT))
 .D LINE(""),LINE("Options Disabled Successfully:   "_SCNT)
 I $D(^TMP($J,"EC2P86","PFND")) S CNT=0 D
 .D LINE("")
 .D LINE("Pre-Released Event Capture Options disabled:")
 .F  S CNT=$O(^TMP($J,"EC2P86","PFND",CNT)) Q:'CNT  D LINE(^(CNT))
 .D LINE(""),LINE("Pre-Released Options Disabled:   "_PCNT)
 I $D(^TMP($J,"EC2P86","NFND")) S CNT=0 D
 .D LINE("")
 .D LINE("National Event Capture Options Not Found:")
 .F  S CNT=$O(^TMP($J,"EC2P86","NFND",CNT)) Q:'CNT  D LINE(^(CNT))
 .D LINE(""),LINE("Options Disabled Unsuccessfully:   "_ECNT)
 Q
 ;
MSGTXT ; Message intro
 ;;Please forward this message to your local DSS Site Manager or Event Capture
 ;;ADPAC.
 ;;
 ;; This message details the national VistA options that were disabled under
 ;; the Event Capture System (ECS) roll-and-scroll interface. If an option was
 ;; not found, then it will be identified in a section of this email message.
 ;; Additionally, any pre-released EC2P* options will be disabled and listed.
 ;; 
 ;; If your site has edited the name of a national option, then your IRM will
 ;; need to manually disable any such option.
 ;; 
 ;; As of the release of this patch, ECS roll-and-scroll interface will no longer
 ;; be supported. Sites should be using the graphical user interface (GUI) which
 ;; has the equivalent functionality.
 ;;
 ;;QUIT
 ;
MAIL ; Send message
 N DIFROM,XMDUZ,XMY,XMTEXT,XMSUB,XMDUN,XMZ
 S XMY(DUZ)="",XMDUZ=.5,XMY(XMDUZ)=""
 S XMSUB="Event Capture Roll-and-Scroll Shutdown"
 S XMTEXT="^TMP($J,""EC2P86MG"","
 D ^XMD
 Q
 ;
OPTIONS ;Event Capture Options that will be set out of order.
 ;;ECLOC;Current Locations (Create/Remove)
 ;;ECSECT;DSS Units for Event Capture (Enter/Edit)
 ;;ECDSUNIT;Assign User Access to DSS Units
 ;;ECDEAL;Remove User Access to DSS Units
 ;;ECDS CATEGORY;Local Category (Enter/Edit)
 ;;ECDSS PROCEDURE;Local Procedure (Enter/Edit)
 ;;ECSCREEN;Event Code Screens (Create)
 ;;ECDSSYN;Procedure Synonym/Default Volume (Enter/Edit)
 ;;ECNACT;Inactivate Event Code Screens
 ;;ECDSDEAC;Activate/Inactivate Local Procedures
 ;;ECDS CATEGORY DEAC;Activate/Inactivate Local Category
 ;;ECDSS1;National/Local Procedure Reports
 ;;ECDSS3;Category Reports
 ;;ECCP;Print Category and Procedure Summary
 ;;ECCP1;*Summary of Procedures and Categories (Old File)
 ;;ECSCPT;Event Code Screens with CPT Codes
 ;;ECINCPT;National/Local Procedure Codes with Inactive CPT
 ;;ECDSRPT;Management Reports
 ;;ECMGR;Event Capture Management Menu
 ;;ECPAT;Enter/Edit Patient Procedures
 ;;ECBATCH;Batch Enter Data by Patient
 ;;ECBATCH PROC;Data Entry (Batch) by Procedure
 ;;ECMULT PROC;Multiple Dates/Multiple Procedures Data Entry
 ;;ECENTER;Event Capture Data Entry
 ;;ECPAT SUM;Patient Summary - Event Capture
 ;;ECRDSSU;DSS Unit Workload Summary
 ;;ECPROV;Provider Summary Report
 ;;EC OS SUM;Ordering Section Summary Report
 ;;EC PRO SUM;Provider (1-7) Summary Report
 ;;EC PCE REPORT;PCE Data Summary
 ;;ECRPERS;Inactive Person Class Report
 ;;ECRPRSN;Procedure Reason Report
 ;;EC NTPCE REPORT;Records Failing Transmission to PCE Report
 ;;ECREPS;Event Capture Reports
 ;;ECDSONL;Event Capture Online Documentation
 ;;ECMENU;Event Capture Menu
 ;;EC2PEDIT;Map Event Capture Procedures to National Files
 ;;EC2PLIST;List Mapped/Unmapped Event Capture Procedures
 ;;EC2PMGR;Pre Release for Event Capture
 ;;QUIT
