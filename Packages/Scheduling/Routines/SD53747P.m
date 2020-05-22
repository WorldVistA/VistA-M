SD53747P ;MNT/BJR - Clean up Untransmitted Encounters ; Apr 01, 2020@19:34
 ;;5.3;Scheduling;**747**;Aug 13, 1993;Build 5
 ;
 Q
 ;
 ;Reference to $$EMGRES^DGUTL supported by ICR # 4800
 ;Reference to $$SITE^VASITE supported by ICR # 10112
 ;Reference to $$FMTE^XLFDT supported by ICR # 10103
 ;Reference to $$HTE^XLFDT supported by ICR # 10103
 ;Reference to $$NOW^XLFDT supported by ICR # 10103
 ;Reference to $$SCH^XLFDT supported by ICR # 10103
 ;Reference to ^XMD supported by ICR # 10070
 ;Reference to BMES^XPDUTL supported by ICR # 10141
 ;Reference to MES^XPDUTL supported by ICR # 10141
 ;
POST ;Scan the TRANSMITTED OUTPATIENT ENCOUNTER file (#409.73) for records
 ;transmitted with the Pandemic EMERGENCY RESPONSE INDICATOR. 
 ;
 N SDTIEN   ;Transmitted Outpatient Encounter file pointer
 N SDENCPTR ;Outpatient Encounter file pointer
 N SDREQUE  ;Count of messages re-queued
 N SDSTART  ;start date/time
 N SDXMITDT ;Date/Time Counter 
 N SDERIDT  ;Pandemic patch earliest install date
 N SDDFN      ;IEN to PATIENT file (#2)
 ;
 K ^TMP("SD53747P",$J)
 S SDERIDT=3200327
 S SDSTART=$$NOW^XLFDT
 S SDREQUE=0
 S SDXMITDT=SDERIDT-.00001
 D MES^XPDUTL("Performing Ambulatory Care Validation Checks...")
 F  S SDXMITDT=$O(^SD(409.73,"AACXMIT",SDXMITDT)) Q:'SDXMITDT  D
 . S SDTIEN=0
 . F  S SDTIEN=$O(^SD(409.73,"AACXMIT",SDXMITDT,SDTIEN)) Q:'SDTIEN  D
 . . S SDENCPTR=$P($G(^SD(409.73,SDTIEN,0)),U,2)
 . . Q:'SDENCPTR
 . . S SDDFN=$P($G(^SCE(SDENCPTR,0)),U,2)
 . . Q:($$EMGRES^DGUTL(SDDFN)'="P")
 . . D FLG(SDTIEN)
 . . S SDREQUE=SDREQUE+1
 ;send completion MailMan message
 D NOTIFY(SDSTART,SDREQUE)
 Q
 ;
NOTIFY(SDSTIME,SDREQ) ;send job completion msg
 ;
 ;  Input
 ;    SDSTIME - job start date/time
 ;    SDREQ - count of untransmitted encounters re-queued
 ;
 ;  Output
 ;    none
 ;
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 N SDSITE,SDETIME,SDTEXT,LINECT
 S SDSITE=$$SITE^VASITE
 S SDETIME=$$NOW^XLFDT
 S XMDUZ="Untransmitted Encounters Re-queue"
 S XMSUB="Patch SD*5.3*747 Pandemic ERI (Encounter Transmissions)"
 S XMTEXT="^TMP(""SD53747P"",$J,"
 S XMY(DUZ)=""
 S ^TMP("SD53747P",$J,1)=""
 S ^TMP("SD53747P",$J,2)="          Facility Name:  "_$P(SDSITE,U,2)
 S ^TMP("SD53747P",$J,3)="         Station Number:  "_$P(SDSITE,U,3)
 S ^TMP("SD53747P",$J,4)=""
 S ^TMP("SD53747P",$J,5)="  Date/Time job started:  "_$$FMTE^XLFDT(SDSTIME)
 S ^TMP("SD53747P",$J,6)="  Date/Time job stopped:  "_$$FMTE^XLFDT(SDETIME)
 S ^TMP("SD53747P",$J,7)=""
 S ^TMP("SD53747P",$J,9)="Total untransmitted encounters re-queued  : "_SDREQ
 S ^TMP("SD53747P",$J,10)="Please Note: There is no user intervention required with the re-transmission"
 S ^TMP("SD53747P",$J,11)="of the untransmitted encounters.  They will be retransmitted via the nightly"
 S ^TMP("SD53747P",$J,12)="background job that is scheduled at your site."
 D ^XMD K ^TMP("SD53747P",$J),XMY
 Q
FLG(SDXMT) ; Entry point for Reflag Transmission protocol
 N SDRTN
 S SDRTN=$$VALIDATE^SCMSVUT2(SDXMT)
 I SDRTN<0 Q
 S SDRTN=$$SETRFLG(SDXMT)
 I SDRTN<0 D MES^XPDUTL("There was a problem reflagging the transmission for "_SDXMT)
 Q
 ;
SETRFLG(SDXMT) ;
 ;  Input
 ;     SDXMT  - Pointer to Transmission File, #409.73
 ;
 ;  Output
 ;      -1  - There was a problem reflagging the transmission 
 ;       0  - No errors occurred
 ;       1  - The entry is already flagged for transmission
 ;
 N SDRSLT,SDSTAT
 S SDRSLT=-1
 S SDSTAT=$P($G(^SD(409.73,SDXMT,0)),U,4)
 I SDSTAT S SDRSLT=1
 E  D
 . D XMITFLAG^SCDXFU01(SDXMT,0),STREEVNT^SCDXFU01(SDXMT,0)
 . S SDRSLT=0
 Q SDRSLT
 ;
