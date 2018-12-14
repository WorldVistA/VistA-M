PSD84P ;EPIP/RTW - PSD CONTROL SUBSTANCE WARNING POST INSTALL ; 05/074/18 18:46pm
 ;;3.0;CONTROLLED SUBSTANCES ;**84**;13 Feb 97;Build 15
 ; ICR#  Type  Description
 ;-----  ----  -------------------------------------
 ;10111  Sup   FM lookup on file 3.8 using ^DIC API 
 ;
MAILGRP ;Need to check for a pre existing mail group called CS BALANCE DISCREPANCY if it exists do nothing.
 N PSDMG,PSDMSG,PSDNIEN,PSDRX
 S PSDMG=$$FIND1^DIC(3.8,"","X","CS BALANCE DISCREPANCY","","","")
 D:'PSDMG
 . N PSDMGRP,PSDDESCR,PSDTYPE,PSDORG,MSG,FDA2,FDA,PSDIEN
 . S PSDMGRP="CS BALANCE DISCREPANCY",PSDTYPE="PU",PSDORG=".5"
 . S PSDDESCR(1)="Pharmacy Supervisors Group for reporting Narcotic Balance Discrepancies"
 . S FDA(3.8,"+1,",.01)=PSDMGRP
 . S FDA(3.8,"+1,",4)=PSDTYPE
 . S FDA(3.8,"+1,",5)=PSDORG
 . D UPDATE^DIE("","FDA","FDAIEN","MSG")
 . S PSDNIEN=$O(^XMB(3.8,"B","CS BALANCE DISCREPANCY",0))
 . S PSDMSG(1)="Pharmacy Supervisors Group for reporting Narcotic Balance Discrepancies"
 . D WP^DIE(3.8,PSDNIEN_",",3,,"PSDMSG")
 . K FDA,FDAIEN
 I $D(MSG) D  Q
 . S PSDRX="Mail Group Creation Failed.  The following error message was returned:"
 . W !
 . D MES^XPDUTL(PSDRX)
 S PSDRX="Mail Group created successfully."
 D MES^XPDUTL(PSDRX)
 Q
