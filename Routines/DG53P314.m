DG53P314 ;ALB/RPM - Patch DG*5.3*314 Install Utility Routine ; 12/12/00 5:19pm
 ;;5.3;Registration;**314**;AUG 13, 1993
 ;
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items.
 Q
 ;
 ;
POST ;Main entry point for Post-init items.
 ;
 D POST1 ;Add new entry to ELIGIBILITY CODE file (#8)
 D POST2 ;Add new entry to ENROLLMENT STATUS file (#27.15)
 D POST3 ;Add PURPLE HEART RECIPIENT to PERIOD OF SERVICE file (#21)
 Q
 ;
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
 ;
POST1 ;Add new entry to ELIGIBILITY CODE file (#8)
 ;
 NEW DGEC,DGPH,DGFDA,DGERR
 S DGEC="PURPLE HEART RECIPIENT"
 D BMES^XPDUTL("*** Adding 'PURPLE HEART RECIPIENT' to the ELIGIBILITY CODE file (#8).")
 S DGPH=$$FIND1^DIC(8.1,"","X",DGEC)
 I 'DGPH D  Q
 . D BMES^XPDUTL("*** PURPLE HEART RECIPIENT entry missing from file 8.1 - contact NVS.")
 I $$FIND1^DIC(8,"","X",DGEC) D  Q
 . D BMES^XPDUTL("*** PURPLE HEART RECIPIENT entry already exists!")
 ;add entry to file
 S DGFDA(8,"+1,",.01)=DGEC
 S DGFDA(8,"+1,",1)="BLUE"
 S DGFDA(8,"+1,",2)="PH"
 S DGFDA(8,"+1,",3)=2
 S DGFDA(8,"+1,",4)="Y"
 S DGFDA(8,"+1,",5)=DGEC
 S DGFDA(8,"+1,",7)=1
 S DGFDA(8,"+1,",8)=DGEC
 S DGFDA(8,"+1,",9)="VA STANDARD"
 S DGFDA(8,"+1,",11)="VA"
 D UPDATE^DIE("E","DGFDA","","DGERR")
 I '$D(DGERR) D BMES^XPDUTL("*** PURPLE HEART RECIPIENT successfully added to file #8.")
 I $D(DGERR) D BMES^XPDUTL("*** PURPLE HEART RECIPIENT was NOT successfully added to file #8.")
 Q
 ;
POST2 ; Add new entry to ENROLLMENT STATUS file (#27.15)
 N FDA,ERR
 D BMES^XPDUTL("Add New Pending Status, Purple Heart Unconfirmed.")
 I $$FIND1^DIC(27.15,"","X","PENDING; PURPLE HEART UNCONFIRMED") D BMES^XPDUTL("*** New Pending Status entry already exists!") Q
 S FDA(27.15,"+1,",.01)="PENDING; PURPLE HEART UNCONFIRMED"
 S FDA(27.15,"+1,",.02)="P"
 D UPDATE^DIE("","FDA","","ERR")
 I $D(ERR) D BMES^XPDUTL("ERROR! New Pending Status not added!"),MES^XPDUTL(ERR("DIERR",1)_": "_ERR("DIERR",1,"TEXT",1)) Q
 D MES^XPDUTL("New Pending Status successfully added.")
 Q
 ;
POST3 ;Add Purple Heart to the PERIOD OF SERVICE file (#21) eligibility
 ;sub-file (#21.01)
 ;
 N DGPHEC    ;Purple Heart Eligibility Code name
 N DGPHIEN   ;Purple Heart IEN in file #8
 N DGCNT     ;Counter for number of Periods of Service modified
 N DGPOS     ;Period of Service name
 N DGPOSIEN  ;Period of Service IEN in file #21
 N DGFDA     ;FDA for DBS call
 N DGERR     ;Error array for DBS call
 ;
 D BMES^XPDUTL("** Updating PERIOD OF SERVICE file with Purple Heart Eligibility code.")
 S DGPHEC="PURPLE HEART RECIPIENT"
 S DGPHIEN=$$FIND1^DIC(8,"","MX",DGPHEC,"","","DGERR")
 I 'DGPHIEN!$D(DGERR) D  G POST3Q
 . D BMES^XPDUTL("** PURPLE HEART RECIPIENT not found in the ELIGIBLITY CODE file (#8).")
 . D BMES^XPDUTL("** Unable to update PERIOD OF SERVICE file.")
 ;
 S DGCNT=1
 F  S DGPOS=$P($T(POSTEX+DGCNT),";;",2) Q:DGPOS=""  S DGCNT=DGCNT+1 D
 . N DGERR
 . S DGPOSIEN=$$FIND1^DIC(21,"","MX",DGPOS,"","","DGERR")
 . I 'DGPOSIEN!$D(DGERR) Q
 . S DGFDA(21.01,"+1,"_DGPOSIEN_",",.01)=DGPHEC
 . D UPDATE^DIE("E","DGFDA","","DGERR")
 D BMES^XPDUTL("** PURPLE HEART RECIPIENT successfully added to the PERIOD OF SERVICE file (#21).")
 ;
POST3Q ;
 Q
 ;
POSTEX ;
 ;;KOREAN
 ;;OPERATION DESERT SHIELD
 ;;PERSIAN GULF WAR
 ;;POST-KOREAN
 ;;POST-VIETNAM
 ;;PRE-KOREAN
 ;;SPANISH AMERICAN
 ;;VIETNAM ERA
 ;;WORLD WAR I
 ;;WORLD WAR II
 ;;
