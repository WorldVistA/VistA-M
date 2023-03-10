SDEC792P ;ALB/MGD - SD*5.3*792 Post Init Routine ; Jul 14, 2021@17:45
 ;;5.3;SCHEDULING;**792**;AUG 13, 1993;Build 9
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 W !!?3,"Updating SDEC SETTINGS file (#409.98)",!!
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 D DISPOSITION
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.10
 S DA=SDECDA,DIE=409.98,DR="2///1.7.10;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.10;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 W !!?3,"VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)"
 Q
 ;
DISPOSITION ;
 ; The DISPOSITION (#21) field in the SDEC APPT REQUEST (#409.85) file
 ; has been a Set of Codes with 10 entries which is the max allowed by
 ; the FileMan definition of a Set of Codes. Now that additional Disposition
 ; reasons are needed, the new SDEC DISPOSITION REASON (#409.853) file has
 ; been created to store all Disposition Reasons.
 ;
 ; This subroutine will loop through existing entries in the SDEC APPT REQUEST
 ; (#409.85) file. For any entry with an existing value in the DISPOSITION (#21)
 ; field the Set of Codes value will be replaced by the IEN of the corresponding
 ; entry in the new SDEC DISPOSITION REASON (#409.853) file.
 ; 
 N U S U="^"
 D MSG("SD*5.3*792 Post-Install to re-map the DISPOSITION (#21) field")
 D MSG("in the SDEC APPT REQUEST (#409.85) file is being jobbed off")
 D MSG("to run as a remote process.")
 D MSG("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK
 S ZTRTN="DISP^SDEC792P",ZTDESC="REMAPPING OF DISPOSITION (#21) IN SDEC APPT REQUEST (#409.85)",ZTIO=""
 D ^%ZTLOAD
 I $D(ZTSK) D
 . D MSG(">>>Task "_ZTSK_" has been queued.")
 . D MSG("")
 I '$D(ZTSK) D
 . D MSG("UNABLE TO QUEUE THIS JOB.")
 . D MSG("Please contact the National Help Desk to report this issue.")
 Q
 ;
MSG(SDMES) ;
 D MES^XPDUTL(SDMES)
 Q
 ;
DISP ; Re-map the DISPOSITION (#21) field in the SDEC APPT REQUEST (#409.85) file.
 ; 
 N D,D40985,FDA,PID,SDIEN
 S SDIEN=0
 F  S SDIEN=$O(^SDEC(409.85,SDIEN)) Q:'SDIEN  D
 . S D=$P($G(^SDEC(409.85,SDIEN,"DIS")),U,3)
 . Q:D=""
 . ; Map existing DISPOSITION code to equivalent pointer value
 . S D=$S(D="D":1,D="NC":2,D="SA":3,D="CC":4,D="NN":5,D="ER":6,D="TR":7,D="CL":8,D="MC":9,D="EA":10,1:D)
 . S FDA(409.85,SDIEN_",",21)=D
 . ; If CID/PREFERRED DATE OF APPT (#22) is null, set to CREATE DATE (#1)
 . S D40985=$G(^SDEC(409.85,SDIEN,0))
 . S PID=$P(D40985,U,16)
 . I PID="" D
 . . S PID=$P(D40985,U,2)
 . . I PID'="" S FDA(409.85,SDIEN_",",16)=PID
 . D FILE^DIE(,"FDA","ERR") K FDA
 Q
