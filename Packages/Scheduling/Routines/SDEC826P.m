SDEC826P ;ALB/MGD/DJS - SD*5.3*826 Post Init Routine ; Oct 17, 2022
 ;;5.3;SCHEDULING;**826**;AUG 13, 1993;Build 18
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 D FIND,RA,TASK
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.32
 S DA=SDECDA,DIE=409.98,DR="2///1.7.32;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.32;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
 ;
RA ; Update Remote Application Entry
 N ARY,MSG
 D MSG("Beginning update of Remote Application Entry.")
 D MSG("")
 N IEN
 S IEN=$$FIND1^DIC(8994.5,"","X","ENTERPRISE APPOINTMENT SERVICE","B","","ERROR")
 I 'IEN D RAMSG Q
 S ARY(8994.5,IEN_",",.03)="Gb03w41EsF0EQkvaVOftqh4FBIHQADuCjZ0zdwQwZE0=" ; New
 ;S ARY(8994.5,IEN_",",.03)="I3u6b0H0Rc3Qk5CV5GoGqnQ+6Gi6uF6pzyN9q7foKA4=" ; Old
 D UPDATE^DIE("","ARY","","MSG")
 I $D(MSG) D RAMSG Q
 D MSG("Remote Application Entry successfully updated.")
 D MSG("")
 Q
 ;
RAMSG ;
 D MSG("Remote Application Entry was not updated.")
 D MSG("Please contact the National Help Desk to report this issue.")
 D MSG("")
 Q
 ;
TASK ;
 D MSG("SD*5.3*826 Post-Install to fix incorrect check-in dates")
 D MSG("in the SDEC APPOINTMENT (#409.84) file")
 D MSG("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*826 Post Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="VPS^SDEC826P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MSG(">>>Task "_ZTSK_" has been queued.")
 . D MSG("")
 I '$D(ZTSK) D
 . D MSG("UNABLE TO QUEUE THIS JOB.")
 . D MSG("Please contact the National Help Desk to report this issue.")
 Q
 ;
MSG(SDMES) ;
 D BMES^XPDUTL(SDMES)
 Q
 ;
 ; CORRECT CHECK-IN TIME IN SDES APPOINTMENT FILE (#409.84)
VPS ;
 N APTDT,APTIEN,RESOURCE,HOSPLOC,DFN,HLAPPT,HLCHKIN,STOPDT,NOCHECKIN,APPTCHK,UPDAPPT,INSTLIEN,DTIENS,STATUS
 S ^XTMP("SDEC826P",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"Logging of repaired check-in times."
 S ^XTMP("SDEC826P","VPS","CNT")=0
 S STOPDT=$$NOW^XLFDT
 S INSTLIEN="",INSTLIEN=$O(^XPD(9.7,"B","VPS*1.0*21",INSTLIEN))
 I INSTLIEN="" Q
 S DTIENS=INSTLIEN_","
 S STATUS=$$GET1^DIQ(9.7,DTIENS,.02)
 I STATUS'="Install Completed" Q
 S APTDT=$$GET1^DIQ(9.7,DTIENS,17,"I")
 S APTDT=$E(APTDT,1,7)
 S (NOCHECKIN,UPDAPPT)=0
 F  S APTDT=$O(^SDEC(409.84,"B",APTDT)) Q:'APTDT!(APTDT>STOPDT)  D
 .S APTIEN=0 F  S APTIEN=$O(^SDEC(409.84,"B",APTDT,APTIEN)) Q:APTIEN=""  D
 ..; B index exists, but there is no data at the IEN.
 ..Q:'$D(^SDEC(409.84,APTIEN))
 ..; If cancelled, do not process
 ..I $P($G(^SDEC(409.84,APTIEN,0)),U,12) Q
 ..; quit if no-show
 ..I $P($G(^SDEC(409.84,APTIEN,0)),U,10) Q
 ..; quit if Walk-in
 ..I $P($G(^SDEC(409.84,APTIEN,0)),U,13)="y" Q
 ..I $P($G(^SDEC(409.84,APTIEN,0)),U,3)="" S NOCHECKIN=1  ;Appt. has not been checked in
 ..S APPTCHK=$P($G(^SDEC(409.84,APTIEN,0)),U,3)
 ..I $P($G(^SDEC(409.84,APTIEN,0)),U,1)=APPTCHK!(APPTCHK="") S UPDAPPT=1 D  ;ApptCheckin=ApptStartTime
 ...S RESOURCE=$P(^SDEC(409.84,APTIEN,0),U,7) Q:'RESOURCE
 ...Q:'$D(^SDEC(409.831,RESOURCE))
 ...S HOSPLOC=$P(^SDEC(409.831,RESOURCE,0),U,4)
 ...S DFN=$P(^SDEC(409.84,APTIEN,0),U,5)
 ...S HLAPPT=0,HLCHKIN=""
 ...F  S HLAPPT=$O(^SC(HOSPLOC,"S",APTDT,1,HLAPPT)) Q:'HLAPPT  D
 ....; quit if not the same patient
 ....I $P($G(^SC(HOSPLOC,"S",APTDT,1,HLAPPT,0)),U)'=DFN Q
 ....; quit if the appointment was cancelled
 ....I $P($G(^SC(HOSPLOC,"S",APTDT,1,HLAPPT,0)),U,9)]"" Q
 ....; quit if there is no check-in
 ....I $D(^SC(HOSPLOC,"S",APTDT,1,HLAPPT,"C")) S HLCHKIN=$P($G(^SC(HOSPLOC,"S",APTDT,1,HLAPPT,"C")),U)  Q:HLCHKIN=""&NOCHECKIN  Q:HLCHKIN=""  D
 .....; check if appt. checked in & if it matches Hospital Location file
 .....I $G(UPDAPPT),APPTCHK=HLCHKIN Q  ;no update needed
 .....I ($G(UPDAPPT)&(APPTCHK'=HLCHKIN))!(HLCHKIN'=""&NOCHECKIN) D
 ......S ^XTMP("SDEC826P","VPS",APTIEN,"BEFORE","CHECK-IN")=$P($G(^SDEC(409.84,APTIEN,0)),U,3)
 ......S ^XTMP("SDEC826P","VPS",APTIEN,"BEFORE","CHECK-IN ENTERED")=$P($G(^SDEC(409.84,APTIEN,0)),U,4)
 ......S $P(^SDEC(409.84,APTIEN,0),U,3)=HLCHKIN
 ......S $P(^SDEC(409.84,APTIEN,0),U,4)=HLCHKIN
 ......S ^XTMP("SDEC826P",APTIEN)=HLCHKIN
 ......S ^XTMP("SDEC826P","VPS",APTIEN,"AFTER","CHECK-IN")=$P($G(^SDEC(409.84,APTIEN,0)),U,3)
 ......S ^XTMP("SDEC826P","VPS",APTIEN,"AFTER","CHECK-IN ENTERED")=$P($G(^SDEC(409.84,APTIEN,0)),U,4)
 ......S ^XTMP("SDEC826P","VPS",APTIEN,"SOURCE")=HLCHKIN
 ......S ^XTMP("SDEC826P","VPS","CNT")=$G(^XTMP("SDEC826P","VPS","CNT"))+1
 ......S NOCHECKIN=0
 D MAIL
 Q
MAIL ;
 ; Get Station Number
 ;
 N STANUM,MESS1,XMTEXT,TEXT,XMSUB,XMY,XMDUZ,DIFROM
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 ;
 ; Send MailMan message
 S XMDUZ=DUZ
 S XMTEXT="TEXT("
 S TEXT(1)="The SD*5.3*826 post install has run to completion."
 S TEXT(2)="The data was reviewed and updated without any issues."
 S XMSUB=MESS1_"SD*5.3*826 - Post Install Update"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 D ^XMD
 Q
