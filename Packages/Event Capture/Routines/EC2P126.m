EC2P126 ;ALB/DAN Post-install events for Event Capture patch 126 ;11/18/14  15:38
 ;;2.0;EVENT CAPTURE;**126**;8 May 96;Build 8
 ;
POST ;Come here for post-install actions
 D REASON ;Update procedure reason file
 Q
 ;
REASON ;Modify entries in file 720.4
 ;
 N ECXFDA,ECXERR,ECREAS,I,DONE,IEN,FDA
 ;
 ;-add procedure reason
 F I=1:1 S ECREAS=$P($T(ADDREAS+I),";;",2) Q:ECREAS="QUIT"  D
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
 ;update procedure reason
 F I=1:1 S ECREAS=$P($T(CHGREAS+I),";;",2) Q:ECREAS="QUIT"  D
 .S IEN=$$FIND1^DIC(720.4,"","X",$P(ECREAS,";"))
 .I '+IEN D  Q
 ..I $$FIND1^DIC(720.4,"","X",$P(ECREAS,";",2)) D BMES^XPDUTL(">>>..."_$P(ECREAS,";")_" already updated.") Q
 ..D BMES^XPDUTL(">>>...unable to change "_$P(ECREAS,";")_" - Entry not found!")
 .S FDA(720.4,IEN_",",".01")=$P(ECREAS,";",2)
 .D FILE^DIE("","FDA")
 .D BMES^XPDUTL(">>>..."_$P(ECREAS,";")_" updated to "_$P(ECREAS,";",2))
 Q
 ;
ADDREAS ;List of new procedure reasons
 ;;CHAP MIL SEXUAL TRAUMA
 ;;CHAP DOM/TREATMENT CENTERS
 ;;QUIT
 ;
CHGREAS ;List of procedure reasons to be updated
 ;;CHAP PRRP;CHAP PRRP/PRTP INP/OUT
 ;;QUIT
