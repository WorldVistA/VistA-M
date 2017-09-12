IB20P216 ;ISP/TJH - ENVIRONMENT CHECK WITH PRE-INIT CODE ;04/24/2003
 ;;2.0;INTEGRATED BILLING;**216**;21-MAR-94
 ;
ENV ; environment check
 ; No special environment check at this time.
PRE ; set up check points for pre-init
 N %
 S %=$$NEWCP^XPDUTL("F364P6","F364P6^IB20P216")
 Q
 ;
F364P6 ; modify LOCAL OVERRIDE ALLOWED for Admission Hour and Discharge Hour
 ; File 364.6, records 55 and 57, field .07 changed from 0 to 1
 N IBIEN,IBMSG,DA,DIE,DR
 F IBIEN=55,57 D
 . S IBMSG(1)="Updating the LOCAL OVERRIDE ALLOWED field for IEN #"_IBIEN
 . S IBMSG(2)="in the IB FORM SKELETON DEFINITION file."
 . D BMES^XPDUTL(.IBMSG)
 . S DA=IBIEN,DIE="^IBA(364.6,",DR=".07////1" D ^DIE
 D COMPLETE
 Q
 ;
COMPLETE ; display message that step has completed
 D BMES^XPDUTL("Step complete.")
 Q
 ;
END ; display message that pre-init has completed successfully
 D BMES^XPDUTL("Pre-init complete")
 Q
 ;
