SDEC809P ;ALB/LAB - SD*5.3*809 Post Init Routine ; Feb 16, 2022@09:58
 ;;5.3;SCHEDULING;**809**;AUG 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 D FIND
 D RA
 Q
 ;
FIND ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 D MES^XPDUTL("Updating SDEC SETTINGS file (#409.98)")
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.21
 S DA=SDECDA,DIE=409.98,DR="2///1.7.21;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.21;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 D MES^XPDUTL("VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)")
 Q
 ;
RA ; Create record to add & update file
 ; This TAG adds an entry to the REMOTE APPLICATION file (#8994.5) for ENTERPRISE APPOINTMENT SERVICE
 N ARY,OPTIEN
 D BMES^XPDUTL("Adding ENTERPRISE APPOINTMENT SERVICE to the REMOTE APPLICATION (#8994.5) file.")
 S OPTIEN=+$O(^DIC(19,"B","SDESRPC",""))
 I 'OPTIEN D BMES^XPDUTL("SDESRPC Option not found in the OPTION (#19) file.") Q
 ; Set up array and create entry
 S ARY(8994.5,"?+1,",.01)="ENTERPRISE APPOINTMENT SERVICE"  ;Remote application name
 S ARY(8994.5,"?+1,",.02)=OPTIEN  ;Context option IEN FOR ""
 S ARY(8994.5,"?+1,",.03)="I3u6b0H0Rc3Qk5CV5GoGqnQ+6Gi6uF6pzyN9q7foKA4="  ;Application code
 S ARY(8994.51,"?+2,?+1,",.01)="R"   ;Callback type = RPC-BROKER
 S ARY(8994.51,"?+2,?+1,",.02)=-1    ;Callback port
 S ARY(8994.51,"?+2,?+1,",.03)="XXX" ;Callback server
 D UPDATE^DIE("","ARY","","MSG")     ;Update Remote Application file with new ENTERPRISE APPOINTMENT SERVICE entry
 I $G(MSG("DIERR"))="" D  Q
 .D BMES^XPDUTL("ENTERPRISE APPOINTMENT SERVICE successfully added to the REMOTE APPLICATION")
 .D MES^XPDUTL("(#8994.5) file.")
 I $G(MSG("DIERR"))'="" D
 .N ERR,LN,LN2,X
 .S (ERR,LN2)=0
 .F  S ERR=+$O(MSG("DIERR",ERR)) Q:'ERR  D
 ..S LN=0
 ..F  S LN=+$O(MSG("DIERR",ERR,"TEXT",LN)) Q:'LN  D
 ...S LN2=LN2+1
 ...S X(LN2)=MSG("DIERR",ERR,"TEXT",LN)
 ...D BMES^XPDUTL(X(LN2))
 .K MSG
 Q
