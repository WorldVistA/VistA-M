SDES844P ;ALB/MGD,TJB - SD*5.3*844 Post Init Routine ; May 24, 2023
 ;;5.3;SCHEDULING;**844**;AUG 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ; Find 'COMMUNITY CARE CONSULT' IEN in file 40.7 then look in 409.85 to find all records
 ; that have that STOP CODE in fields 8.5 or 8.6 that do not have the CURRENT STATUS field 23 set to 'C'
 ; Any records found should have the following fields updated:
 ; Update fields:
 ;  -CURRENT STATUS (field 23) (0;17) - Set to 'C' - This is a set and can have the values of C for CLOSED and O for OPEN
 ;  -DISPOSITION (Field 21) (DIS;3) - use REMOVED/NON-VA, look in file 409.853 for the IEN of the disposition
 ;  -DISPOSITIONED BY (Field 20) (DIS;2) - use POSTMASTER, look in the NEW PERSON file for the IEN
 ;  -DATE DISPOSITIONED (Field 19) (DIS;1) - use date post install routine was run on this VistA
 ;  -DISPOSITION CLOSED BY CLEANUP (Field 21.1) (DIS;4) - Set to 'Y' - this is a yes/no set field
 ;
EN ; Entry point for the post-install routine
 D FIND,TASK
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("")
 D MES^XPDUTL(" Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.42
 S DA=SDECDA,DIE=409.98,DR="2///1.7.42;3///"_DT D ^DIE ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.42;3///"_DT D ^DIE ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL(" VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
 ;
TASK ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*844 Post-Install to fix Disposition records")
 D MES^XPDUTL("   in the SDEC APPT REQUEST (#409.85) file is being")
 D MES^XPDUTL("   queued to run in the background. Once it finishes")
 D MES^XPDUTL("   a MailMan message will be sent to the installer to")
 D MES^XPDUTL("   provide them a job completion status and data summary.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*844 Post Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="DISP^SDES844P",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
DISP ; Disposition old OPEN Appointment Requests that have the STOP CODE "COMMUNITY CARE CONSULT"
 N DISPIEN,FDA,ZN,TCNT,ERCNT,I
 N CLNIEN,SDIEN,PMIEN,FLD85,FLD86 ; FLD85 => Field 8.5 from file 409.85, FLD86 => Field 8.6 from file 409.85
 S TCNT=0,ERCNT=0
 ; Get IEN of CLINIC STOP (40.7)
 S CLNIEN=$$FIND1^DIC(40.7,"","X","COMMUNITY CARE CONSULT","B","","ERROR")
 I 'CLNIEN D  Q
 .S TEXT(1)="The COMMUNITY CARE CONSULT stop code could not be found in"
 .S TEXT(2)="the CLINIC STOP (#40.7) file. Please contact the National"
 .S TEXT(3)="Help Desk to report this issue."
 .D MAIL
 ; Get IEN of the Disposition
 S DISPIEN=$$FIND1^DIC(409.853,"","X","REMOVED/NON-VA CARE","B","","ERROR")
 I 'DISPIEN D  Q
 .S TEXT(1)="The REMOVED/NON-VA CARE Disposition Reason could not be found"
 .S TEXT(2)="in the SDEC DISPOSITION REASON (#409.853) file. Please contact the"
 .S TEXT(3)="National Help Desk to report this issue."
 .D MAIL
 ; Get IEN of POSTMASTER
 S PMIEN=$$FIND1^DIC(200,"","X","POSTMASTER","B","","ERROR")
 I 'PMIEN D  Q
 .S TEXT(1)="The POSTMASTER mail account could not be found"
 .S TEXT(2)="in the NEW PERSON (#200) file. Please contact the"
 .S TEXT(3)="National Help Desk to report this issue."
 .D MAIL
 ; Walk SDEC APPT REQUEST file 409.85
 ;; Fields 8.5 and 8.6 contain the IEN of the stop codes
 S SDIEN=0
 ; If the CURRENT STATUS (Field #23 [0;17]) is not CLOSED then look further in the record
 F  S SDIEN=$O(^SDEC(409.85,SDIEN)) Q:+SDIEN'>0  S ZN=$G(^SDEC(409.85,SDIEN,0)) I ZN]""&($P(ZN,U,17)'="C") D
 . ; Grab fields 8.5 and 8.6
 . S FLD85=$P(ZN,U,4),FLD86=$P($G(^SDEC(409.85,SDIEN,"SDREQ")),U,1)
 . I FLD85=CLNIEN!(FLD86=CLNIEN) D
 . . ; Found a record with the correct stop code; file the data for the record, mark it closed and increment the found count
 . . S FDA(409.85,SDIEN_",",19)=$$DT^XLFDT
 . . S FDA(409.85,SDIEN_",",20)=PMIEN
 . . S FDA(409.85,SDIEN_",",21)=DISPIEN
 . . S FDA(409.85,SDIEN_",",21.1)="Y"
 . . S FDA(409.85,SDIEN_",",23)="C"
 . . D FILE^DIE("","FDA","ERR84")
 . . I '$D(ERR84) S TCNT=TCNT+1
 . . E  S ERCNT=ERCNT+1 S:ERCNT<5 ERCNT(ERCNT)=SDIEN
 . . K FDA,ERR84
 S TEXT(1)="The SD*5.3*844 post install has run to completion."
 I ERCNT=0 S TEXT(2)="The data was reviewed and updated without any issues."
 E  S TEXT(2)="The data was reviewed and "_ERCNT_" errors where encountered."
 S TEXT(3)="Total Appointment Requests updated: "_TCNT
 I ERCNT>0 D
 . S TEXT(4)=" "
 . S TEXT(5)="Here are the IENs from 409.85 where errors were detected while"
 . S TEXT(6)="processing records in SD*5.3*844 post install process run."
 . S TEXT(7)="Errors found: "_ERCNT
 . S TEXT(8)="IENs with errors: "
 . S I=0 F  S I=$O(ERCNT(I)) Q:I>5!(I="")  S TEXT(8)=TEXT(8)_$S(I>1:", ",1:" ")_ERCNT(I)
 D MAIL
 Q
MAIL ;
 ; Get Station Number
 ;
 N STANUM,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 ;
 ; Send MailMan message
 S XMDUZ=DUZ
 S XMTEXT="TEXT("
 S XMSUB=MESS1_"SD*5.3*844 - Post Install Update"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 D ^XMD
 K TEXT
 Q
