SDEC19 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
ADDRG(SDECY,SDECVAL) ;ADD/EDIT RESOURCE GROUP
 ;ADDRG(SDECY,SDECVAL)  external parameter tag is in SDEC
 ;Add a new SDEC RESOURCE GROUP entry
 ;INPUT:
 ; SDECVAL - IEN | NAME
 ;           IEN  = (integer) Resource Group ID - Pointer to the SDEC RESOURCE GROUP file
 ;           NAME = (text)    Value to be put into the NAME field of the SDEC RESOURCE GROUP file
 ;RETURN:
 ;  IEN of added/edited entry or 0 if error
 ;
 N SDECIENS,SDECFDA,SDECMSG,SDECIEN,SDEC,SDECNAM
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S ^TMP("SDEC",$J,0)="I00020RESOURCEGROUPID^T00030ERRORTEXT"_$C(30)
 I SDECVAL="" D ERR(0,"SDEC19: Invalid null input Parameter") Q
 S SDECIEN=$P(SDECVAL,"|")
 I SDECIEN'="" I '$D(^SDEC(409.832,SDECIEN,0)) D ERR(0,"SDEC19: Invalid Resource Group ID.")
 S SDECNAM=$P(SDECVAL,"|",2)
 I +SDECIEN D
 . S SDEC="EDIT"
 . S SDECIENS=SDECIEN_","
 E  D
 . S SDEC="ADD"
 . S SDECIENS="+1,"
 I SDEC="ADD",SDECNAM="" D ERR(0,"SDEC16: Resource Group ID is required.") ;name required for ADD
 ;
 ;Prevent adding entry with duplicate name
 I SDECNAM'="",$D(^SDEC(409.832,"B",SDECNAM)),$O(^SDEC(409.832,"B",SDECNAM,0))'=SDECIEN D  Q
 . D ERR(0,"SDEC19: Cannot have two Resource Groups with the same name.")
 . Q
 ;
 S SDECFDA(409.832,SDECIENS,.01)=SDECNAM ;NAME
 I SDEC="ADD" D
 . K SDECIEN
 . D UPDATE^DIE("","SDECFDA","SDECIEN","SDECMSG")
 . S SDECIEN=+$G(SDECIEN(1))
 E  D
 . D FILE^DIE("","SDECFDA","SDECMSG")
 S ^TMP("SDEC",$J,1)=$G(SDECIEN)_"^"_$C(30)_$C(31)
 Q
 ;
DELRESGP(SDECY,SDECGRP) ;Deletes entry name SDECGRP from SDEC RESOURCE GROUP file
 ;DELRESGP(SDECY,SDECGRP)  external parameter tag is in SDEC
 ;Return recordset containing error message or "" if no error
 ;
 N SDECI,DIK,DA,SDECIEN
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S ^TMP("SDEC",$J,0)="I00020RESOURCEGROUPID^T00030ERRORTEXT"_$C(30)
 I SDECGRP="" D ERR(0,"DELRG~SDEC19: Invalid null Resource Group Name") Q
 S SDECIEN=$O(^SDEC(409.832,"B",SDECGRP,0))
 I '+SDECIEN D ERR(0,"DELRG~SDEC19: Invalid Resource Group Name") Q
 I '$D(^SDEC(409.832,SDECIEN,0)) D ERR(0,"DELRG~SDEC19: Invalid Resource Group IEN") Q
 ;Delete entry SDECIEN
 S DIK="^SDEC(409.832,"
 S DA=SDECIEN
 D ^DIK
 ;
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECIEN_"^"_$C(30)_$C(31)
 Q
 ;
ERR(SDECERID,ERRTXT) ;Error processing
 S:'+$G(SDECI) SDECI=999999
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECERID_"^"_ERRTXT_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
ERROR ;
 D ^%ZTER
 I '+$G(SDECI) N SDECI S SDECI=999999
 S SDECI=SDECI+1
 D ERR(0,"SDEC19 Error")
 Q
