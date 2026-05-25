SDES905P ;ALB/MCB - SD*5.3*905 Post Init Routine ; APR 10, 2025
 ;;5.3;SCHEDULING;**905**;AUG 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;
 Q
 ;
EN ;
 D SDECSET
 Q
 ;
SDECSET ; Update SDEC Settings remove Contact VSE Program Office
 N NATIEN,SUBIEN,FDA,FDAERR
 S NATIEN=$O(^SDEC(409.98,"B","VS GUI NATIONAL",0))
 S SUBIEN=$O(^SDEC(409.98,NATIEN,1,"B","Contact VSE Program Office",0)) Q:'SUBIEN
 S FDA(409.981,SUBIEN_","_NATIEN_",",.01)="@"
 D FILE^DIE(,"FDA","FDAERR") K FDA
 Q
 ;
PRE ; SDES ERROR CODES (#409.93) File updates
 ; Remove duplicate errors in SDES ERROR CODES (#409.93) File
 N ERRNUM,DUPIEN,DA,DIK,CNT,FDA,FDAERR
 S ERRNUM=0
 F  S ERRNUM=$O(^SDEC(409.93,"B",ERRNUM)) Q:'ERRNUM  D
 . S DUPIEN=0,CNT=0
 . F  S DUPIEN=$O(^SDEC(409.93,"B",ERRNUM,DUPIEN)) Q:'DUPIEN  D
 . . S CNT=CNT+1
 . . I CNT>1 D
 . . . S DA=DUPIEN,DIK="^SDEC(409.93," D ^DIK
 ;
 ; Update error text for 3 errors
 S DUPIEN=$O(^SDEC(409.93,"B",209,""))
 I DUPIEN S FDA(409.93,DUPIEN_",",1)="""DAYS BETWEEN APPTS"" parameter must be a number from 1 through 365."
 I $D(FDA) D FILE^DIE(,"FDA","FDAERR")
 I $D(FDAERR) D ERROR(209)
 K FDA,FDAERR,DUPIEN
 S DUPIEN=$O(^SDEC(409.93,"B",468,""))
 I DUPIEN S FDA(409.93,DUPIEN_",",1)="Cannot block and move from slots that originated with more than 1 available appointment slot."
 I $D(FDA) D FILE^DIE(,"FDA","FDAERR")
 I $D(FDAERR) D ERROR(468)
 K FDA,FDAERR,DUPIEN
 S DUPIEN=$O(^SDEC(409.93,"B",473,""))
 I DUPIEN S FDA(409.93,DUPIEN_",",1)="Search string must be 3 through 30 characters."
 I $D(FDA) D FILE^DIE(,"FDA","FDAERR")
 I $D(FDAERR) D ERROR(473)
 K FDA,FDAERR
 Q
 ;  
ERROR(ERRNUM) ;
 D MES^XPDUTL("")
 D MES^XPDUTL("Error updating Error Code "_ERRNUM_".")
 D MES^XPDUTL("Please create a SNOW ticket and route to the Vista Scheduling team")
 Q
