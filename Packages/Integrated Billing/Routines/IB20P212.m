IB20P212 ;ISP/TJH - ENVIRONMENT CHECK WITH PRE-INIT CODE for IB*2.0*212 ;04/02/2003
 ;;2.0;INTEGRATED BILLING;**212**;21-MAR-94
 ;
ENV ; environment check
 ; No special environment check at this time.
PRE ; set up check points for pre-init
 N %
 S %=$$NEWCP^XPDUTL("R3","R3^IB20P212")
 Q
 ;
R3 ; set new value into record 3 of file 355.97, re: IND-0902-42308
 ; change the SOURCE LEVEL MINIMUM for CHAMPUS ID to NONE
 D BMES^XPDUTL("Updating SOURCE LEVEL MINIMUM for CHAMPUS ID.")
 N DA,IBFL,IBROOT,IBERR
 S DA=""
 I $D(^IBE(355.97,"B","CHAMPUS ID")) S DA=$O(^IBE(355.97,"B","CHAMPUS ID",""))
 I DA=""  D ERRMSG("CHAMPUS ID record not found") G EXIT
 S IBFL="",IBROOT(355.97,DA_",",.02)=0
 D FILE^DIE(IBFL,"IBROOT","IBERR")
 I $D(IBERR("DIERR")) D ERRMSG(IBERR("DIERR",1,"TEXT",1)) G EXIT
 D BMES^XPDUTL("Pre-init completed successfully.")
EXIT Q
 ;
ERRMSG(TXT) ; Write error message
 D BMES^XPDUTL("Update failed.  "_TXT)
 Q
