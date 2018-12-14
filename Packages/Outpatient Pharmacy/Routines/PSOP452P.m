PSOP452P ;ALB/RTW - PS RX NUMBERING WARNING POST INSTALL ; 11/24/16 1:54pm
 ;;7.0;OUTPATIENT PHARMACY ;**452**;Dec 17, 1997;Build 56
 ; ICR#  Type  Description
 ;-----  ----  -------------------------------------
 ; 1157  Sup   $$LKOPT^XPDMENU
 ; 1472  Sup   RESCH^XUTMOPT [allows creation of new record in 19.2]
 ;10000  Sup   C^%DTC
 ;10111  Sup   FM lookup on file 3.8 using ^DIC API 
 ; 1146  Sup   $$MG^XMBGRP add a mail group
 ;
 D TASK,MAILGRP
 Q
TASK ;
 N X,DA,DIE,DR,PSOAOPTB,PSOAOPTN,PSOERR,PSONM,PSOIEN,PSOWHEN
 S PSONM="PSO RX NUMBERING WARNING"
 S PSOIEN=$$LKOPT^XPDMENU(PSONM) I PSOIEN="" D  Q
 . W !?5,"ERROR: Option "_PSONM_" not found",!
 . Q
 S X1=DT,X2=1 D C^%DTC S PSOWHEN=X_"@0301"
 W !,"The '"_PSONM_"' option is scheduled to run at: "
 D RESCH^XUTMOPT(PSONM,PSOWHEN,"","1D","L",.PSOERR)
 S PSOAOPTB=0,PSOAOPTB=+$P($Q(^DIC(19.2,"B",PSOIEN,PSOAOPTB)),",",4)
 S DIE="^DIC(19.2,",DR="11///.5",DA=PSOAOPTB D ^DIE
 Q
MAILGRP ;Need to check for a pre existing mail group called PHARMACY SURPERVISORS if it exists do nothing.
 N PSOMG,PSOMSG,PSONIEN,PSORX
 S PSOMG=$$FIND1^DIC(3.8,"","X","PHARMACY SUPERVISORS","B")
 I PSOMG W !,"The PHARMACY SUPERVISORS Mail Group already exists, nothing created!" Q
 D:'PSOMG
 . N PSOMGRP,PSODESCR,PSOTYPE,PSOORG,MSG,FDA2,FDA,PSOIEN
 . S PSOMGRP="PHARMACY SUPERVISORS",PSOTYPE="PU",PSOORG=".5"
 . S FDA(3.8,"+1,",.01)=PSOMGRP
 . S FDA(3.8,"+1,",4)=PSOTYPE
 . S FDA(3.8,"+1,",5)=PSOORG
 . S FDA(3.8,"+1,",5.1)=PSOORG
 . S FDA(3.8,"+1,",7)="n"
 . D UPDATE^DIE("","FDA","FDAIEN","MSG")
 . S PSONIEN=$O(^XMB(3.8,"B","PHARMACY SUPERVISORS",0))
 . S PSOMSG(1)="Pharmacy Supervisors Group for end of RX Numbering Alert"
 . D WP^DIE(3.8,PSONIEN_",",3,,"PSOMSG")
 . K FDA,FDAIEN
 I $D(MSG) D  Q
 . S PSORX="Mail Group Creation Failed.  The following error message was returned:"
 . W !
 . D MES^XPDUTL(PSORX)
 I '$D(MSG) S PSORX="Mail Group created successfully." D
 . D MES^XPDUTL(PSORX)
 Q
