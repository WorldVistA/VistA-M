DVBA179P ;ALB/EF - Post init for DVBA*2.7*179 ; 1/15/2012
 ;;2.7;AMIE;**179**;Apr 10, 1995;Build 15
 ;
 ; The POST1 section of this routine adds menu items to two of the
 ; HRC menus distributed in DVBA*2.7*149.
 ; The PSO HRC PROFILE/REFILL menu item is included in patch PSO*7*382
 ; See ICR #4595
 ;
 ; The POST2 section of this routine collects the last 90 days of records
 ; in the 2507 REQUEST (#396.3) file and populates the new
 ; DATE STATUS LAST CHANGED (#7) field.
 ;
POST ;
 ;
 D POST1  ;add HRC menu
 D POST2  ;populate DATE STATUS LAST CHANGED (#7) field in 2507 REQUEST (#396.3) file.
 Q
 ;
POST1 ;
 ;
 ;See ADDMNU for documentation on input parameters.
 ;Last parameter is the Display Order.  Must be a number from 1 - 99.
 ;
 ;Pharmacy menu
 ;
 D BMES^XPDUTL("-> Adding PSO HRC PROFILE/REFILL option to HRC Pharmacy Customer Care Menu <-")
 D ADDMNU("DVBA HRC MENU PHARMACY CC","PSO HRC PROFILE/REFILL","PPR",30)
 ;
 D BMES^XPDUTL("-> Adding PSO HRC PROFILE/REFILL option to HRC Pharmacy Menu <-")
 D ADDMNU("DVBA HRC MENU PHARMACY","PSO HRC PROFILE/REFILL","PPR",30)
 ;
 Q
ADDMNU(DVB1,DVB2,DVB3,DVB4) ;
 ;
 ;Adds Items to Menu (#19.01) subfile in Option (#19) file
 ;Input:  
 ;     DVB1 = Name of the menu(Required)
 ;     DVB2 = Item (#.01)- Name of Option being added to the menu. (Required)
 ;     DVB3 = Synonym (#2) field (optional)
 ;     DVB4 = Display Order (#3) field (optional) (Number from 1 - 99)
 ;
 ;Output: 1 = Success - Option added to menu.
 ;        0 = Failure - Option not added to menu.
 ;
 N DVOK
 S DVOK=$$ADD^XPDMENU(DVB1,DVB2,DVB3,DVB4)
 I 'DVOK D  Q
 .D MES^XPDUTL("  Could not add "_DVB2_" to "_DVB1)
 D MES^XPDUTL("  "_DVB2_" added to "_DVB1)
 Q
 ;
POST2 ;Set up TaskMan to populate new Date field in the background
 N ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="SETFLD7^DVBA179P"
 S ZTDESC="Populate DATE STATUS LAST CHANGED for DVBA*2.7*179"
 ;Queue Task to start in 60 seconds
 S ZTDTH=$$SCH^XLFDT("60S",$$NOW^XLFDT)
 S ZTIO=""
 D ^%ZTLOAD
 D BMES^XPDUTL("*****")
 D
 . I $D(ZTSK)[0 D  Q
 . .D MES^XPDUTL("TaskMan run to populate new Date field for DVBA*2.7*179 was not started.")
 . .D MES^XPDUTL("Re-run Post Install routine POST2^DVBA179P.")
 . D MES^XPDUTL("Task "_ZTSK_" started to populate new Date field.")
 . I $D(ZTSK("D")) D
 . . D MES^XPDUTL("Task will start at "_$$HTE^XLFDT(ZTSK("D")))
 D MES^XPDUTL("*****")
 Q
 ;
SETFLD7 ;
 ;  Retrieve 2507 REQUEST (#396.3) record date fields for the last 90 days,
 ;  determine most recent activity date and populate the DATE STATUS LAST
 ;  CHANGED (#7) field.
 ;
 N DVBCNT   ;updated record count
 N DVBDAT   ;2507 REQUEST DATE
 N DVBIEN   ;2507 REQUEST IEN
 N DVBLST   ;last activity date
 N DVBMSG   ;notification text
 N DVBQUIT  ;stop task
 N DVBSTART  ;start time
 ;
 S DVBSTART=$$NOW^XLFDT()
 S DVBCNT=0
 S DVBQUIT=0
 S DVBDAT=$$FMADD^XLFDT($$DT^XLFDT(),-91)
 F  S DVBDAT=$O(^DVB(396.3,"C",DVBDAT)) Q:'DVBDAT!(DVBQUIT)  D
 . S DVBIEN=0
 . S DVBIEN=$O(^DVB(396.3,"C",DVBDAT,DVBIEN)) Q:'DVBIEN  D
 . . S DVBLST=$$GETLAST(DVBIEN)
 . . I DVBLST,$$SETLAST(DVBIEN,DVBLST) S DVBCNT=DVBCNT+1
 . . ;
 . I $$S^%ZTLOAD D  Q  ;check for task stop request
 . . S DVBMSG=2
 . . S DVBMSG(1)="Patch DVBA*2.7*179 Field Population Task Stopped by User"
 . . S DVBMSG(2)="Re-run Post Install routine POST2^DVBA179P."
 . . S (ZTSTOP,DVBQUIT)=1
 ;
 D NOTIFY(DVBSTART,DVBCNT,.DVBMSG)
 Q
 ;
GETLAST(DVBIEN) ;get last activity date
 ;  This function returns the most recent activity date on success.
 ;
 ;  Fields  Name
 ;  1       Request Date
 ;  4       Date Reported to MAS
 ;  6       Date Completed
 ;  13      Date Released
 ;  15      Date Printed by RO
 ;  19      Cancellation Date
 ;
 ;  Input:
 ;    DVBIEN - 2507 REQUEST file IEN
 ;
 ;  Output:
 ;    Funtion result - most recent activity date in FM format on success;
 ;                     otherwise, returns "0"
 ;
 N DVBDATS  ;FM DIQ results array
 N DVBERR   ;FM error msg
 N DVBFLD   ;request field# 
 N DVBIENS  ;request record IENS
 N DVBLST   ;last activity date - function result
 N DVBSRT   ;activity dates sorted array
 ;
 S DVBLST=0
 S DVBIENS=DVBIEN_","
 D GETS^DIQ(396.3,DVBIENS,"1;4;6;13;15;19","I","DVBDATS","DVBERR")
 I '$D(DVBERR) D
 . S DVBFLD=0
 . F  S DVBFLD=$O(DVBDATS(396.3,DVBIENS,DVBFLD)) Q:'DVBFLD  D
 . . S DVBSRT(+$G(DVBDATS(396.3,DVBIENS,DVBFLD,"I")))=""
 . S DVBLST=$P(+$O(DVBSRT(""),-1),".",1)
 Q DVBLST
 ;
SETLAST(DVBIEN,DVBLAST) ;file the date in the new field
 ;  File the last activity date in the DATE STATUS LAST CHANGED (#7) field
 ;
 ;  Input:
 ;    DVBIEN - 2507 REQUEST IEN
 ;    DVBLAST - last activity date in FM format
 ;
 ;  Output:
 ;    Function result - returns 1 on success; otherwise returns 0
 ;
 N DVBERR   ;FM error msg
 N DVBFDA   ;FDA array
 S DVBFDA(396.3,DVBIEN_",",7)=DVBLAST
 D FILE^DIE("","DVBFDA","DVBERR")
 Q $S($D(DVBERR):0,1:1)
 ;
NOTIFY(DVBSTIME,DVBTOT,DVBMESS) ;send job msg
 ;
 ;  Input
 ;    DVBSTIME - job start date/time
 ;    DVBTOT - count of records updated
 ;    DVBMESS - free text message array for task stop or errors passed
 ;             by reference
 ;
 ;  Output
 ;    none
 ;
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 N DVBSITE,DVBETIME,DVBTEXT,DVBI
 S DVBSITE=$$SITE^VASITE
 S DVBETIME=$$NOW^XLFDT
 S XMDUZ="Populate DATE STATUS LAST CHANGED"
 S XMSUB="Patch DVBA*2.7*179"
 S XMTEXT="DVBTEXT("
 S XMY(DUZ)=""
 S DVBTEXT(1)=""
 S DVBTEXT(2)="          Facility Name:  "_$P(DVBSITE,U,2)
 S DVBTEXT(3)="         Station Number:  "_$P(DVBSITE,U,3)
 S DVBTEXT(4)=""
 S DVBTEXT(5)="  Date/Time job started:  "_$$FMTE^XLFDT(DVBSTIME)
 S DVBTEXT(6)="  Date/Time job stopped:  "_$$FMTE^XLFDT(DVBETIME)
 S DVBTEXT(7)=""
 I $G(DVBMESS) D
 . F DVBI=1:1:DVBMESS D
 . . S DVBTEXT(7+DVBI)="*** "_$E($G(DVBMESS(DVBI)),1,65)
 I '$G(DVBMESS) D
 . S DVBTEXT(8)="DATE STATUS LAST CHANGED (#7) Field Popluation Complete"
 . S DVBTEXT(9)="Total 2507 REQUEST (#396.3) Records Updated: "_DVBTOT
 D ^XMD
 Q
