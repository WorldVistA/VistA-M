RAIPS228 ;WOIFO/KLM - Post-init Driver, patch 228 ; May 21, 2025@09:16:58
 ;;5.0;Radiology/Nuclear Medicine;**228**;Mar 16, 1998;Build 4
 ;
 ;Post-Init will add a new LIRADS code to file 78.3.  
 ;
 Q
EN ; Add new LI-RAD to Diagnosis Code File 78.3
 N RAFDA,RADNUM,RAMSG
 ;There is only one code, so I'll just set it.
 S RAFDA(78.3,"+1,",.01)="LI-RADS TR NONPROGRESSING" ;DIAG CODE
 S RAFDA(78.3,"+1,",2)="Treated, stable or decreased in size over time after LRT"   ;DIAG DESC
 S RAFDA(78.3,"+1,",3)="Y"  ;PRINT ON ABN REPORT
 S RAFDA(78.3,"+1,",4)="y"   ;GENERATE ALERT
 S RADNUM(1)=1425
 D UPDATE^DIE("","RAFDA","RADNUM","RAMSG")
 I $D(RAMSG("DIERR")) D MES^XPDUTL("There was a problem filing LI-RADS code 1425. Contact radiology development.") Q
 D MES^XPDUTL("LI-RADS 1425 filed!")
 Q
