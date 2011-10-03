DVBA149P ;ALB/RPM - PATCH DVBA*2.7*149 PRE-INSTALL ; 1/26/11 3:46pm
 ;;2.7;AMIE;**149**;Apr 10, 1995;Build 16
 ;
 Q  ;NO DIRECT ENTRY
 ;
PRE ;Main entry point for Pre-init items.
 ;
 N DVBERR,DVBIEN,DVBFDA
 ;if the 2507 cancellation reason, 'VETERAN PLANS TO SUBMIT DBQ',
 ;exists in File #396.5, then delete the entry prior to installing 
 ;the build.
 S DVBIEN=$$FIND1^DIC(396.5,"","BX","VETERAN PLANS TO SUBMIT DBQ","","","DVBERR")
 I +DVBIEN D
 .S DVBFDA(396.5,DVBIEN_",",.01)="@"
 .D FILE^DIE("SK","DVBFDA","DVBERR")
 Q
