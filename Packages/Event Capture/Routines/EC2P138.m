EC2P138 ;ALB/DE - EC Procedure Reason Update ; 6/20/17 11:00am
 ;;2.0;EVENT CAPTURE;**138**;8 May 96;Build 1
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the EC Procedure Reason (#720.4) file
 ;
 Q
 ;
POST ;Add entries in file 720.4
 ;
 N ECXFDA,ECXERR,ECREAS,ECINC
 ;
 ;-add procedure reason
 F ECINC=1:1 S ECREAS=$P($T(ADDREAS+ECINC),";;",2) Q:ECREAS="QUIT"  D
 .;
 .;-quit w/error message if entry already exists in file #720.4
 .I $$FIND1^DIC(720.4,"","X",ECREAS) D  Q
 ..D BMES^XPDUTL(">>>..."_ECREAS_" not added, entry already exists.")
 .;
 .;Setup field values of new entry
 .S ECXFDA(720.4,"+1,",.01)=ECREAS
 .S ECXFDA(720.4,"+1,",.02)=1 ;Set "ACTIVE?" field to 1 (active)
 .;
 .;-add new entry to file #720.4
 .D UPDATE^DIE("E","ECXFDA","","ECXERR")
 .;
 .I '$D(ECXERR) D BMES^XPDUTL(">>>..."_ECREAS_" added to file.")
 .I $D(ECXERR) D BMES^XPDUTL(">>>...Unable to add "_ECREAS_" to file.")
 ;
 Q
 ;
ADDREAS ;List of new procedure reasons
 ;;CHAP ADV CARE PLAN
 ;;CHAP EMPOWER VET PGM
 ;;QUIT
