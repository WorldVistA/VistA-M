EC20P95 ;ALB/RPM - PATCH 95 ENV/PRE/POST INSTALL ; 07/29/08
 ;;2.0; EVENT CAPTURE ;**95**; 8 MAY 96;Build 26
 ;
ENV ;environment check
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 ;rename option only during install, not during load
 I '$G(XPDABORT),$G(XPDENV)=1 D
 . I '$$RENOPT("EC NIGHT","EC PCE FEED") S XPDABORT=2
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;pre-install
 Q
 ;
 ;
POST ;post-install
 D POST1  ;build 'APRV' index
 Q
 ;
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
 ;
RENOPT(ECOLD,ECNEW) ;rename option
 ;
 ;  Input:
 ;    ECOLD - original option name
 ;    ECNEW - new option name
 ;
 ;  Output:
 ;   Function value - returns 1 on success; 0 on failure
 ;
 N ECRSLT
 S ECRSLT=1
 I $G(ECOLD)'="",$G(ECNEW)'="",+$$LKOPT^XPDMENU(ECOLD)>0 D
 . D RENAME^XPDMENU(ECOLD,ECNEW)
 . I +$$LKOPT^XPDMENU(ECNEW)'>0 D
 . . D BMES^XPDUTL("******")
 . . D MES^XPDUTL("The installation process failed to rename the")
 . . D MES^XPDUTL(ECOLD_" option to "_ECNEW_".")
 . . D MES^XPDUTL("Installation aborted.")
 . . D MES^XPDUTL("******")
 . . S ECRSLT=0
 Q ECRSLT
 ;
POST1 ;Set up TaskMan to build 'APRV' index in the background
 N ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="BLDIDX^EC20P95"
 S ZTDESC="Populate 'APRV' index for EC*2.0*95"
 ;Queue Task to start in 60 seconds
 S ZTDTH=$$SCH^XLFDT("60S",$$NOW^XLFDT)
 S ZTIO=""
 D ^%ZTLOAD
 D BMES^XPDUTL("*****")
 D
 . I $D(ZTSK)[0 D  Q
 . .D MES^XPDUTL("TaskMan run to populate 'APRV' index for EC*2.0*95 was not started.")
 . .D MES^XPDUTL("Re-run Post Install routine POST1^EC20P95.")
 . D MES^XPDUTL("Task "_ZTSK_" started to populate 'APRV' index.")
 . I $D(ZTSK("D")) D
 . . D MES^XPDUTL("Task will start at "_$$HTE^XLFDT(ZTSK("D")))
 D MES^XPDUTL("*****")
 Q
 ;
BLDIDX ;BUILD 'APRV' INDEX
 N DA,DIK
 N ECMSG    ;error/stop messages
 N ECSTIME  ;start time
 N ECCNT    ;record counter
 N ECQUIT   ;task stop flag
 ;
 S ECQUIT=0
 S ECCNT=0
 S ECMSG=""
 S ECSTIME=$$NOW^XLFDT()
 S DA(1)=0
 F  S DA(1)=$O(^ECH(DA(1))) Q:'DA(1)!(ECQUIT)  D
 . S ECCNT=ECCNT+1
 . S DIK="^ECH(DA(1),""PRV"","
 . S DIK(1)=".01^APRV"
 . D ENALL^DIK
 . I ECCNT#1000,$$S^%ZTLOAD D  Q
 . . S ECMSG=2
 . . S ECMSG(1)="Patch EC*2.0*95 'APRV' Re-index Task Stopped by User"
 . . S ECMSG(2)="Re-run Post Install routine POST1^EC20P95."
 . . S (ZTSTOP,ECQUIT)=1
 D NOTIFY(ECSTIME,.ECMSG)
 Q
 ;
NOTIFY(ECSTIME,ECMESS) ;send job msg
 ;
 ;  Input
 ;    ECSTIME - job start date/time
 ;    ECMESS - free text message array for task stop or errors passed
 ;             by reference
 ;
 ;  Output
 ;    none
 ;
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 N ECSITE,ECETIME,ECTEXT,ECI
 S ECSITE=$$SITE^VASITE
 S ECETIME=$$NOW^XLFDT
 S XMDUZ="'APRV' RE-INDEX"
 S XMSUB="Patch EC*2.0*95 ECS FY08 Enhancements"
 S XMTEXT="ECTEXT("
 S XMY(DUZ)=""
 S ECTEXT(1)=""
 S ECTEXT(2)="          Facility Name:  "_$P(ECSITE,U,2)
 S ECTEXT(3)="         Station Number:  "_$P(ECSITE,U,3)
 S ECTEXT(4)=""
 S ECTEXT(5)="  Date/Time job started:  "_$$FMTE^XLFDT(ECSTIME)
 S ECTEXT(6)="  Date/Time job stopped:  "_$$FMTE^XLFDT(ECETIME)
 S ECTEXT(7)=""
 I $G(ECMESS) D
 . F ECI=1:1:ECMESS D
 . . S ECTEXT(7+ECI)="*** "_$E($G(ECMESS(ECI)),1,65)
 I '$G(ECMESS) D
 . S ECTEXT(8)="'APRV' Index Populated Successfully"
 D ^XMD
 Q
