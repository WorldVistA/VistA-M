SCDXSTOP ;ALB/TXH - STOP ACRP HL7 TRANSMISSIONS;08/21/18
 ;;5.3;Scheduling;**640**;AUG 13, 1993;Build 8
 ;
 ; This post-init routine will
 ; - disable the AMB-CARE & SDPM Logical Links
 ; - unschedule the AMB-CARE NIGHTLY transmission task
 ; - place AMB-CARE & APM related options Out of Order
 ;
 Q
 ;
EN ; Entry Point
 D BMES^XPDUTL("SD*5.3*640 Post-Init Started...")
 D LOGLNK
 D DELETE
 D OPTOUT
 D BMES^XPDUTL("SD*5.3*640 Post-Init Finished.")
 D MES^XPDUTL(" ")
 Q
 ;
LOGLNK ; Disable the AMB-CARE & SDPM Logical Links
 ;
 D BMES^XPDUTL("   * Disabling the following Logical Links...")
 N SDLOG,SDLOGN,SDLOGLNK,DA,DR,SDLNKMSG,SDLNK
 S SDLOG=0
 F SDLOGN=1:1 S SDLOGLNK=$P($TEXT(LOGLIST+SDLOGN),";;",2) Q:SDLOGLNK="$$END"!(SDLOGLNK="")  D
 . S SDLNK=+$$FIND1^DIC(870,"","BX",SDLOGLNK,"","","")
 . I SDLNK="" D MES^XPDUTL("    "_SDLOGLNK_" not found. It's okay.") Q
 . ; Get AUTOSTART disabled and set SHUTDOWN LLP to YES.
 . N DIE S DIE="^HLCS(870,",DA=SDLNK,DR="4.5///0;14///1"
 . D ^DIE
 . S SDLNKMSG="     "_SDLOGLNK
 . D MES^XPDUTL(SDLNKMSG)
 D MES^XPDUTL("     Done.")
 Q
 ;
DELETE ; Remove the following tasks in Option Schedule
 ; SCDX AMBCAR NIGHTLY XMIT Ambulatory Care Nightly Transmission to NPCDB
 ; SCRPW APM TASK JOB       Schedule APM Performance Monitor Task
 ; SDOQM PM NIGHTLY JOB     Nightly job for PM data extract
 ;
 ; IA #6121 Remove Scheduled options from #19.2
 ; IA #2051 Database Server API: Lookup Utilities (DIC)
 ;
 K ^XTMP("SCDXTSK")
 D BMES^XPDUTL("   * Removing ACRP & APM related scheduled tasks...")
 N SDMCN,SDRPTSK,SDOPT,DA,DIK,SDTSKMSG
 S SDN=0
 F SDMCN=1:1 S SDRPTSK=$P($TEXT(TSKLIST+SDMCN),";;",2) Q:SDRPTSK="$$END"!(SDRPTSK="")  D
 . S SDOPT=+$$FIND1^DIC(19,"","BX",SDRPTSK,"","","")
 . I SDOPT="" D MES^XPDUTL("    "_SDRPTSK_" not found. It's okay.") Q
 . S DA="" F  S DA=$O(^DIC(19.2,"B",SDOPT,DA)) Q:'+DA  D
 . . S ^XTMP("SCDXTSK",$J,SDN)=$$FMADD^XLFDT(DT+90)_"^"_DT_"^copy of "_SDRPTSK_" in #19.2^"_DA
 . . M ^XTMP("SCDXTSK",$J,SDN,"DIC",19.2,DA)=^DIC(19.2,DA)
 . . S DIK="^DIC(19.2," D ^DIK
 . . S SDTSKMSG="     "_SDRPTSK
 . . D MES^XPDUTL(SDTSKMSG)
 . . S SDN=SDN+1
 K SDN
 D MES^XPDUTL("     Done.")
 Q
 ;
OPTOUT ; Set options out of order
 ;
 ; IA #1157 OUT^XPDMENU(OPT,TXT)
 ;
 D BMES^XPDUTL("   * Placing the following options out of order...")
 N SDMCN,SDOPT,SDTXT,SDOPTMSG
 S SDTXT="This functionality is now accomplished by CDW/VSSC."
 F SDMCN=1:1 S SDOPT=$P($TEXT(OPTLIST+SDMCN),";;",2) Q:SDOPT="$$END"!(SDOPT="")  D
 . D OUT^XPDMENU(SDOPT,SDTXT)  ;Mark option out-of-order
 . S SDOPTMSG="     "_SDOPT
 . D MES^XPDUTL(SDOPTMSG)
 D MES^XPDUTL("     Done.")
 Q
 ;
OPTLIST ; options
 ;;SCDX AMBCAR NIGHTLY XMIT
 ;;SCDX AMBCAR RETRANS BY DATE
 ;;SCDX AMBCAR RETRANS ERROR
 ;;SCDX AMBCAR RETRANS SEL REJ
 ;;SCRPW APM TASK JOB
 ;;SCRPW PM RETRANSMIT REPORT
 ;;SDOQM PM NIGHTLY JOB
 ;;$$END
 ;
TSKLIST ; Scheduled tasks
 ;;SCDX AMBCAR NIGHTLY XMIT
 ;;SCRPW APM TASK JOB
 ;;SDOQM PM NIGHTLY JOB
 ;;$$END
 ;
LOGLIST ; Logical Links
 ;;AMB-CARE
 ;;SDPM
 ;;$$END
 ;
