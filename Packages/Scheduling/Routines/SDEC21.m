SDEC21 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
ADDACCG(SDECY,SDECVAL) ;ADD/EDIT ACCESS GROUP
 ;ADDACCG(SDECY,SDECVAL)  external parameter tag is in SDEC
 ;Add a new SDEC ACCESS GROUP entry
 ;INPUT:
 ; SDECVAL - Access Group IEN and Name separated by pipe |  <IEN>|<name>
 ;        Access Group IEN  - (integer) pointer to the SDEC ACCESS GROUP file
 ;                                      a new entry will be added if null
 ;        Access Group name - (text)    value to be put into the NAME field of
 ;                                      the SDEC ACCESS GROUP FILE
 ;RETURN:
 ; Access Group IEN
 ;
 N SDECIENS,SDECFDA,SDECMSG,SDECIEN,SDEC,SDECNAM
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S ^TMP("SDEC",$J,0)="I00020ACCESSGROUPID^T00030ERRORTEXT"_$C(30)
 I SDECVAL="" D ERR(0,"SDEC21: Invalid null input Parameter") Q
 S SDECIEN=$P(SDECVAL,"|")
 S SDECNAM=$P(SDECVAL,"|",2)
 I +SDECIEN D
 . S SDEC="EDIT"
 . S SDECIENS=SDECIEN_","
 E  D
 . S SDEC="ADD"
 . S SDECIENS="+1,"
 ;
 S SDECNAM=$P(SDECVAL,"|",2)
 I SDECNAM="" D ERR(0,"SDEC14: Invalid null Access Type name.") Q
 ;
 ;Prevent adding entry with duplicate name
 I $D(^SDEC(409.822,"B",SDECNAM)),$O(^SDEC(409.822,"B",SDECNAM,0))'=SDECIEN D  Q
 . D ERR(0,"SDEC21: Cannot have two Access Groups with the same name.")
 . Q
 ;
 S SDECFDA(409.822,SDECIENS,.01)=SDECNAM ;NAME
 I SDEC="ADD" D
 . K SDECIEN
 . D UPDATE^DIE("","SDECFDA","SDECIEN","SDECMSG")
 . S SDECIEN=+$G(SDECIEN(1))
 E  D
 . D FILE^DIE("","SDECFDA","SDECMSG")
 S ^TMP("SDEC",$J,1)=$G(SDECIEN)_"^"_$C(30)_$C(31)
 Q
 ;
DELAG(SDECY,SDECGRP) ;Deletes entry having IEN SDECGRP from SDEC ACCESS GROUP file
 ;DELAG(SDECY,SDECGRP)  external parameter tag is in SDEC
 ;Also deletes all entries in SDEC ACCESS GROUP TYPE that point to this group
 ;Return recordset containing error message or "" if no error
 ;Called by SDEC DELETE ACCESS GROUP
 ;
 N SDECI,DIK,DA,SDECIEN,SDECIEN1
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S ^TMP("SDEC",$J,0)="I00020ACCESSGROUPID^T00030ERRORTEXT"_$C(30)
 S SDECIEN=SDECGRP
 I '+SDECIEN D ERR(SDECI,SDECIEN,70) Q
 I '$D(^SDEC(409.822,SDECIEN,0)) D ERR(0,"SDEC14: Invalid Access Group ID name.") Q
 ;
 ;Delete SDECACCESS GROUP TYPE entries
 ;
 S SDECIEN1=0 F  S SDECIEN1=$O(^SDEC(409.824,"B",SDECIEN,SDECIEN1)) Q:'SDECIEN1  D
 . S DIK="^SDEC(409.824,"
 . S DA=SDECIEN1
 . D ^DIK
 . Q
 ;
 ;Delete entry SDECIEN in SDEC ACCESS GROUP
 S DIK="^SDEC(409.822,"
 S DA=SDECIEN
 D ^DIK
 ;
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECIEN_"^"_""_$C(30)_$C(31)
 Q
 ;
ERR(SDECERID,ERRTXT) ;Error processing
 S:'+$G(SDECI) SDECI=999999
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECERID_"^"_ERRTXT_$C(30,31)
 Q
 ;
ERROR ;
 D ^%ZTER
 I '+$G(SDECI) N SDECI S SDECI=999999
 S SDECI=SDECI+1
 D ERR(0,"SDEC21 Error")
 Q
