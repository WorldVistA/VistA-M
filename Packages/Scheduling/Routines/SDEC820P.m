SDEC820P ;ALB/MGD,BWF - SD*5.3*820 Post Init Routine ; June 28, 2022@14:03
 ;;5.3;SCHEDULING;**820**;AUG 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 D FIND,ADD,TASK
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.28
 S DA=SDECDA,DIE=409.98,DR="2///1.7.28;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.28;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
TASK ;
 D MSG("SD*5.3*820 Post-Install to fix missing check-in dates")
 D MSG("in the SDEC APPOINTMENT (#409.84) file, and MRTC")
 D MSG("intervals/sequence numbers in the SDEC APPT REQUEST")
 D MSG("(#409.85) file is being tasked to run as a remote process.")
 D MSG("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*820 Post Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="VPS^SDEC820P",ZTSAVE("*")="" D ^%ZTLOAD
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
VPS ;
 N APTDT,APTIEN,RESOURCE,HOSPLOC,DFN,HLAPPT,CHKIN,STOPDT
 S ^XTMP("SDEC820P",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"Logging of repaired check-in times/MRTCs."
 S ^XTMP("SDEC820P","VPS","CNT")=0
 S STOPDT=$$NOW^XLFDT
 S APTDT=0 F  S APTDT=$O(^SDEC(409.84,"B",APTDT)) Q:'APTDT!(APTDT>STOPDT)  D
 .S APTIEN=0 F  S APTIEN=$O(^SDEC(409.84,"B",APTDT,APTIEN)) Q:'APTIEN  D
 ..; B index exists, but there is no data at the IEN.
 ..Q:'$D(^SDEC(409.84,APTIEN))
 ..; quit if checked in
 ..I $P(^SDEC(409.84,APTIEN,0),U,3) Q
 ..; If not checked out, quit
 ..I '$P($G(^SDEC(409.84,APTIEN,0)),U,14) Q
 ..; If cancelled, do not process
 ..I $P($G(^SDEC(409.84,APTIEN,0)),U,12) Q
 ..; quit if no-show
 ..I $P($G(^SDEC(409.84,APTIEN,0)),U,10) Q
 ..S RESOURCE=$P(^SDEC(409.84,APTIEN,0),U,7) Q:'RESOURCE
 ..Q:'$D(^SDEC(409.831,RESOURCE))
 ..S HOSPLOC=$P(^SDEC(409.831,RESOURCE,0),U,4)
 ..S DFN=$P(^SDEC(409.84,APTIEN,0),U,5)
 ..S HLAPPT=0
 ..F  S HLAPPT=$O(^SC(HOSPLOC,"S",APTDT,1,HLAPPT)) Q:'HLAPPT  D
 ...; quit if not the same patient
 ...I $P($G(^SC(HOSPLOC,"S",APTDT,1,HLAPPT,0)),U)'=DFN Q
 ...; quit if the appointment was cancelled
 ...I $P($G(^SC(HOSPLOC,"S",APTDT,1,HLAPPT,0)),U,9)]"" Q
 ...; quit if there is no check-in
 ...S CHKIN=$P($G(^SC(HOSPLOC,"S",APTDT,1,HLAPPT,"C")),U) Q:CHKIN']""
 ...S ^XTMP("SDEC820P","VPS",APTIEN,"BEFORE","CHECK-IN")=$P($G(^SDEC(409.84,APTIEN,0)),U,3)
 ...S ^XTMP("SDEC820P","VPS",APTIEN,"BEFORE","CHECK-IN ENTERED")=$P($G(^SDEC(409.84,APTIEN,0)),U,4)
 ...S $P(^SDEC(409.84,APTIEN,0),U,3)=CHKIN
 ...S $P(^SDEC(409.84,APTIEN,0),U,4)=CHKIN
 ...S ^XTMP("SDEC820P","VPS",APTIEN,"AFTER","CHECK-IN")=$P($G(^SDEC(409.84,APTIEN,0)),U,3)
 ...S ^XTMP("SDEC820P","VPS",APTIEN,"AFTER","CHECK-IN ENTERED")=$P($G(^SDEC(409.84,APTIEN,0)),U,4)
 ...S ^XTMP("SDEC820P","VPS",APTIEN,"SOURCE")=CHKIN
 ...S ^XTMP("SDEC820P","VPS","CNT")=$G(^XTMP("SDEC820P","VPS","CNT"))+1
 ;
 ; MRTC cleanup
 N REQUESTIEN,PARENTIEN,SUBIEN,MIENS,COUNT,PARENTINTERVAL,MRTCCHILDIEN
 S REQUESTIEN=0,COUNT=0
 F  S REQUESTIEN=$O(^SDEC(409.85,REQUESTIEN)) Q:'REQUESTIEN  D
 .;if this record is a parent request, get the mrtc children IENs
 .I $P($G(^SDEC(409.85,REQUESTIEN,3)),U)=1,'$P($G(^SDEC(409.85,REQUESTIEN,3)),U,5) D
 .S PARENTINTERVAL=$P($G(^SDEC(409.85,REQUESTIEN,3)),U,2)
 .S DFN=$P($G(^SDEC(409.85,REQUESTIEN,0)),U)
 .S SUBIEN=0,COUNT=0
 .F  S SUBIEN=$O(^SDEC(409.85,REQUESTIEN,2,SUBIEN)) Q:'SUBIEN  D
 ..S COUNT=COUNT+1
 ..S MRTCCHILDIEN=$P($G(^SDEC(409.85,REQUESTIEN,2,SUBIEN,0)),U)
 ..S ^XTMP("SDEC820P","MRTC",MRTCCHILDIEN,"BEFORE","INTERVAL")=$P($G(^SDEC(409.85,MRTCCHILDIEN,3)),U,2)
 ..S ^XTMP("SDEC820P","MRTC",MRTCCHILDIEN,"BEFORE","CHILD SEQUENCE")=$P($G(^SDEC(409.85,MRTCCHILDIEN,3)),U,6)
 ..S $P(^SDEC(409.85,MRTCCHILDIEN,3),U,2)=PARENTINTERVAL
 ..S $P(^SDEC(409.85,MRTCCHILDIEN,3),U,6)=COUNT
 ..S ^XTMP("SDEC820P","MRTC",MRTCCHILDIEN,"AFTER","INTERVAL")=$P($G(^SDEC(409.85,MRTCCHILDIEN,3)),U,2)
 ..S ^XTMP("SDEC820P","MRTC",MRTCCHILDIEN,"AFTER","CHILD SEQUENCE")=$P($G(^SDEC(409.85,MRTCCHILDIEN,3)),U,6)
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
 S TEXT(1)="The SD*5.3*820 post install has run to completion."
 S TEXT(2)="The data was reviewed and updated without any issues."
 S XMSUB=MESS1_"SD*5.3*820 - Post Install Update"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 D ^XMD
 Q
ADD ;** Add DSS IDs
 ;
 ;  SDXX is in format:
 ; STOP CODE NAME^AMIS #^RESTRICTION TYPE^REST. DATE^CDR #
 ;
 N SDX,SDXX
 S SDVAR=1
 D MES^XPDUTL("")
 D BMES^XPDUTL(">>> Adding new Clinic Stops to CLINIC STOP File (#40.7)...")
 ;
 ;
 D BMES^XPDUTL(" [NOTE: These Stop Codes CANNOT be used UNTIL 9/1/2022]")
 S DIC(0)="L",DLAYGO=40.7,DIC="^DIC(40.7,"
 F SDX=1:1 K DD,DO,DA S SDXX=$P($T(NEW+SDX),";;",2) Q:SDXX="QUIT"  DO
 .S DIC("DR")="1////"_$P(SDXX,"^",2)
 .S DIC("DR")=DIC("DR")_";5////"_$P(SDXX,"^",3)_";6///"_$P(SDXX,"^",4)
 .S X=$P(SDXX,"^",1)
 .I '$D(^DIC(40.7,"C",$P(SDXX,"^",2))) D FILE^DICN,MESS Q
 .I $D(^DIC(40.7,"C",$P(SDXX,"^",2))) D EDIT(SDXX),MESSEX
 K DIC,DLAYGO,X
 Q
 ;
NEW ;STOP CODE NAME^NUMBER^RESTRICTION TYPE^RESTRICTION DATE^CDR
 ;;REGISTRY EXAM CVT PT SITE^497^S^9/1/2022
 ;;REGISTRY EXAM CVT PROV SITE^498^S^9/1/2022
 ;;QUIT
 ;
MESS ;** Add message
 N ECXADMSG
 I +$G(SDVAR) D HDR(SDVAR)
 D MES^XPDUTL(" ")
 S ECXADMSG="Added:       "_$P(SDXX,"^",2)_"      "_$P(SDXX,"^")
 I $P(SDXX,"^",5)'="" S ECXADMSG=ECXADMSG_" [CDR#: "_$P(SDXX,"^",5)_"]"
 D MES^XPDUTL(ECXADMSG)
 I $P(SDXX,"^",3)'="" S ECXADMSG="                      Restricted Type: "_$P(SDXX,"^",3)_"    Restricted Date: "_$P(SDXX,"^",4)
 D MES^XPDUTL(ECXADMSG)
 K SDVAR
 Q
 ;
MESSEX ;** Display message if stop code already exists
 N ECXADMSG
 I +$G(SDVAR) D HDR(SDVAR)
 D MES^XPDUTL(" ")
 S ECXADMSG="             "_$P(SDXX,"^",2)_"      "_$P(SDXX,"^")_"  already exists."
 D MES^XPDUTL(ECXADMSG)
 K SDVAR
 Q
 ;
EDIT(SDXX) ;- Edit fields w/new values if stop code record already exists
 ;
 Q:$G(SDXX)=""
 N DA,DIE,DLAYGO,DR
 S DA=+$O(^DIC(40.7,"C",+$P(SDXX,"^",2),0))
 Q:'DA
 S DIE="^DIC(40.7,",DR=".01///"_$P(SDXX,"^")_";1///"_$P(SDXX,"^",2)_";2///@"_$S('+$P(SDXX,U,5):"",1:";4///"_$P(SDXX,"^",5))_";5///"_$P(SDXX,"^",3)_";6///"_$P(SDXX,"^",4)
 D ^DIE
 Q
HDR(SDVAR) ;- Header
 Q:'$G(SDVAR)
 N SDHDR
 S SDHDR=$P($T(@("HDR"_SDVAR)),";;",2)
 D BMES^XPDUTL(SDHDR)
 Q
 ;
 ;
HDR1 ;;           Stop Code              Name
 ;
HDR2 ;;                CDR        Stop Code             Name
 ;
HDR3 ;;           Stop Code      Name                       Rest. Type    Date
 ;
 ;
 Q
