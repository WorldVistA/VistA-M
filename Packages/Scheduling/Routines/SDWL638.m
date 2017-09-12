SDWL638 ;ALB/JAM - STOP EWL AAC SCHEDULED TRANSMISSIONS ;May 7, 2015
 ;;5.3;Scheduling;**638**;AUG 13, 1993;Build 8
 ;
 ;
 Q
 ; Reference/ICR
 ; REMOVE SCHEDULED OPTIONS FROM #19.2/6121
 ; XPDMENU CALL/1157 
 ;
 ;
EN ;Validate user and initialize variables.
 I '$D(DUZ) D BMES^XPDUTL("*** PROGRAMMER NOT DEFINED ***") Q
 N SDWLOPT,SDWLIEN
 S SDWLOPT="SD WAIT LIST TRANS TO AAC",SDWLIEN=$O(^DIC(19,"B",SDWLOPT,""))
 D OPTOUT
 I SDWLIEN D DELTSK
 Q
OPTOUT ;Disable EWL transmission option.
 N SDWLTEXT
 S SDWLTEXT="This functionality is now accomplished by CDW/VSSC"
 D OUT^XPDMENU(SDWLOPT,SDWLTEXT)
 D BMES^XPDUTL(SDWLOPT_" option has been placed out of order.")
 Q
DELTSK ;Confirm option entry exists in the OPTION SCHEDULING (#19.2) file and delete scheduled task as needed.
 N DA,DIK
 S DA=""
 F  S DA=$O(^DIC(19.2,"B",SDWLIEN,DA)) Q:'+DA  D
 . S ^XTMP("SDWLOPT",$J,0)=$$FMADD^XLFDT(DT+90)_"^"_DT_"^copy of EWL Transmission Task^"_DA
 . M ^XTMP("SDWLOPT",$J,"DIC",19.2,DA)=^DIC(19.2,DA)
 . S DIK="^DIC(19.2," D ^DIK
 . D BMES^XPDUTL("Scheduled option "_SDWLOPT_" has been removed.")
 Q
