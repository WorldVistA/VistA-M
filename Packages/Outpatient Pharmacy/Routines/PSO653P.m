PSO653P ;BIRM/KML - PHARMACY TELEPHONE REFILL ; 12/26/17 12:13pm
 ;;7.0;OUTPATIENT PHARMACY;**653**;Dec 1997;Build 14
 ; --------------------------------------------------------------------------------------
 ; 1.  TASK - schedules the new PSO PURGE PROCESSED 52.444 option
 ; 2.  MENU - adds the new option, Process Telephone Refills [PSO PROCESS TELEPHONE REFILLS] to the existing Barcode Rx Menu [BARCODE RX MENU]
 N TEXT D TASK,MENU
 ; disable the class 3 option A3A PHONE REFILLS by adding an out-of-order message to the entry in the OPTION file 
 D OUT^XPDMENU("A3A PHONE REFILLS","Replaced by Class 1 Option [PSO PROCESS TELEPHONE REFILLS]")
 S TEXT(1)="Process Telephone Refills [A3A PHONE REFILLS] option"
 S TEXT(2)="has been placed OUT-OF-ORDER"
 S TEXT(3)="****************************"
 S TEXT(4)=""
 D MES^XPDUTL(.TEXT)
 Q 
TASK ; schedule the new purge option
 N PSOAOPTB,PSOAOPTN,DA,DIE,DR,X,X1,X2,PSOWHEN,PSOSD
 S X1=DT,X2=+1 D C^%DTC S PSOSD=X
 S PSOWHEN=PSOSD_"@0405" ;PSOPURGE DATE TIME.
 D RESCH^XUTMOPT("PSO PURGE PROCESSED 52.444",PSOWHEN,"","1D","L",".PSOA_ERROR")
 S TEXT(1)="Purge Processed Telephone Refill Requests [PSO PURGE PROCESSED 52.444] option"
 S TEXT(2)="has been scheduled to occur at 4:05 am every day."
 S TEXT(3)="****************************"
 S TEXT(4)=""
 D MES^XPDUTL(.TEXT)
 Q
MENU ;add new class 1 option
 ;PSO BARCODE MENU class 1 MENU
 ;PSO PROCESS TELEPHONE REFILLS
 N FDA,PSOCOP,PSOCIEN,PSOCOPNM,PSOCSYN
 S PSOCOP=$O(^DIC(19,"B","PSO BARCODE MENU",0))
 S PSOCOPNM="PSO PROCESS TELEPHONE REFILLS"
 S PSOCIEN=0 S PSOCIEN=$O(^DIC(19,"B",PSOCOPNM,0))
 S PSOCSYN="PTR"
 S TEXT(1)="Process Telephone Refills [PSO PROCESS TELEPHONE REFILLS] option"
 S TEXT(2)="has been added to the existing Barcode Rx Menu [PSO BARCODE MENU]"
 S TEXT(3)="****************************"
 S TEXT(4)=""
 D MES^XPDUTL(.TEXT)
 Q:$D(^DIC(19,PSOCOP,10,"B",PSOCIEN))
 S FDA(1,19.01,"+2,"_PSOCOP_",",.01)=PSOCIEN
 S FDA(1,19.01,"+2,"_PSOCOP_",",2)=PSOCSYN
 D UPDATE^DIE("","FDA(1)")
 Q
