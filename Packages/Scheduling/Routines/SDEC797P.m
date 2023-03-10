SDEC797P ;ALB/MGD - SD*5.3*797 Post Init Routine ; Sep 9, 2021@12:18
 ;;5.3;SCHEDULING;**797**;AUG 13, 1993;Build 8
 ;
 ;External References   Supported by ICR#     Type
 ;-------------------   -----------------     ----------
 ; $$FIND1^DIC           2051                 Supported                       
 ; ^DIE                  2053                 Supported
 ; UPDATE^DIE            2053                 Supported 
 ; BMES^XPDUTL          10141                 Supported
 ; MES^XPDUTL           10141                 Supported
 ;
 D FIND
 D ADDCNRSN ;add Block and Move to CANCELLATION REASONS File #409.2
 Q
 ;
FIND(SDXPD) ;FIND THE IEN FOR "VS GUI NATIONAL"
 N SDECDA,SDECDA1
 W !!?3,"Updating SDEC SETTINGS file (#409.98)",!!
 S SDECDA=0,SDECDA=$O(^SDEC(409.98,"B","VS GUI NATIONAL",SDECDA)) G:$G(SDECDA)="" NOFIND
 D VERSION   ;update GUI version number and date
 Q
 ;
VERSION ;SET THE NEW VERSION UPDATE IN SDEC SETTING FILE #409.98 TO 1.7.13
 S DA=SDECDA,DIE=409.98,DR="2///1.7.13;3///"_DT D ^DIE  ;update VS GUI NATIONAL
 K DIE,DR,DA
 S SDECDA1=0,SDECDA1=$O(^SDEC(409.98,"B","VS GUI LOCAL",SDECDA1)) Q:$G(SDECDA1)=""    ;get DA for the VS GUI LOCAL
 S DA=SDECDA1,DIE=409.98,DR="2///1.7.13;3///"_DT D ^DIE  ;update VS GUI LOCAL
 K DIE,DR,DA
 Q
 ;
NOFIND ;"VS GUI NATIONAL" NOT FOUND
 W !!?3,"VS GUI NATIONAL not found in the SDEC SETTINGS file (#409.98)"
 Q
 ;
ADDCNRSN ;add Block and Move to CANCELLATION REASONS File #409.2
 N SDRSN    ;Cancellation Reason name
 N SDRSNIEN ;Cancellation Reason IEN
 N SDFDA    ;FDA for DBS call
 N SDERR    ;Error array for DBS call
 N MES      ;message
 ;
 S MES(1)="Checking for existence of the BLOCK AND MOVE in the"
 S MES(2)="CANCELLATION REASONS File #409.2."
 D MES^XPDUTL(.MES)
 K SDERR S SDRSN="BLOCK AND MOVE",SDRSNIEN=$$FIND1^DIC(409.2,"","MX",SDRSN,"","","SDERR")
 I +SDRSNIEN>0 D  Q
 . K MES
 . S MES(1)="  "
 . S MES(2)="The BLOCK AND MOVE cancellation reason already exist in File #409.2."
 . S MES(3)="No Action Taken."
 . S MES(4)="  "
 . D MES^XPDUTL(.MES)
 I $D(SDERR) D DISPERR($G(SDERR("DIERR",1,"TEXT",1))) Q  ;do not continue if error occurs
 ;
 D BMES^XPDUTL("Adding BLOCK AND MOVE entry to CANCELLATION REASONS File #409.2")
 S SDFDA(409.2,"+1,",.01)=SDRSN ;Cancellation Reason Name
 S SDFDA(409.2,"+1,",2)="C" ;'C'linic - cancellation reason type
 K SDERR D UPDATE^DIE("E","SDFDA","","SDERR")
 I $D(SDERR) D DISPERR($G(SDERR("DIERR",1,"TEXT",1))) Q  ;do not continue if error occurs
 ;
 D BMES^XPDUTL("BLOCK AND MOVE successfully added to CANCELLATION REASONS File #409.2.")
 Q
 ;
DISPERR(ERROR) ; display error message
 K MES
 S MES(1)="  "
 S MES(2)="Error while adding BLOCK AND MOVE entry to CANCELLATION REASONS File #409.2."
 S MES(3)="Error: "_ERROR
 S MES(4)="  "
 D MES^XPDUTL(.MES)
 Q
 ;
