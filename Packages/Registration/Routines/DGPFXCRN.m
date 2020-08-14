DGPFXCRN ; ALB/CNF/CMF - UTILITY TO DISABLE CAT II PRF AFTER CERNER ; 10-05-2019
 ;;5.3;Registration;**1005**;Aug 13, 1993;Build 57
 ;
 ;Tag EN is entry point
 Q
 ;
 ;*****************************************************************
 ;**** DO NOT RUN THIS CODE UNTIL THE SITE MOVES PRF TO CERNER ****
 ;*****************************************************************
 ;
 ; To disable Patient Record Flags after Cerner, mark PRF options
 ; as out of order so flags can't be added or edited from VistA.
 ;
 ; Mark all CAT II flags as inactive so CAT II flags are no longer
 ; displayed for legacy products remaining on VistA.
 ;
POST ; Entry point for post install from KIDS
 D CAT2 ;Inactivate Category II flags   
 ;
 Q
 ;
CAT2 ;
 N FLGNM,FLG,DGPFLH,DGPFLF
 ;
 D BMES^XPDUTL("Inactivate Category II Patient Record Flags (Local patient record flags).")
 D MES^XPDUTL("All patient assignments for category II flags will be inactivated.")
 ;
 ; Loop through active category II patient record flags
 S MSG="PRF functionality inactivated after migration to Cerner"
 S FLGNM=""
 F  S FLGNM=$O(^DGPF(26.11,"ASTAT",1,FLGNM)) Q:FLGNM=""  D
 . S FLG=$O(^DGPF(26.11,"ASTAT",1,FLGNM,0)) Q:FLG=""
 . D DEACT(FLG,FLGNM,MSG)
 . Q
 ;
 Q
 ;
DEACT(FLG,FLGNM,MSG) ;Deactivate; called from DG*1005 post init;  called from DG*991 post init
 ;
 N DGIDXIEN ;ien of flag record 
 N DGPFLF   ;array containing flag record field values
 N DGPFLH   ;array containing flag history record field values
 N DGABORT  ;abort flag
 N DGRESULT ;result of $$STOALL^DGPFALF1 api call
 N DGERR    ;if error returned
 N DGOK     ;ok flag to enter record flag entry & flag description
 N DGMSG    ;user message
 N DGX      ;temp variable
 ;
 ; init variables
 S (DGABORT,DGRESULT)=0
 S DGOK=1
 ;
 S DGIDXIEN=FLG
 K DGPFLF,DGPFLH
 ;
 ; call api to get record back in array DGPFLF with existing record entries
 I '$$GETLF^DGPFALF($P(DGIDXIEN,";"),.DGPFLF) Q   ; If true, record can't be found
 ;
 ; Set array to change entries in 26.11
 S DGPFLF("FLAG")=FLGNM                 ;flag description
 S DGPFLF("STAT")="0^INACTIVE"          ;change to inactive
 ;
 ; setup remaining flag history array nodes for filing in 26.12
 S DGPFLH("FLAG")=FLGNM                 ;flag description
 S DGPFLH("ENTERDT")=$$NOW^XLFDT()      ;current date/time
 S DGPFLH("ENTERBY")=DUZ                ;current user
 S DGX="^^1^1^"_($P(DGPFLH("ENTERDT"),".",1))_"^"
 S DGPFLH("REASON",0)=DGX               ;reason array
 S DGPFLH("REASON",1,0)=MSG
 ;
 ; Inactivate the category II patient record flag which will also trigger
 ; inactivation of all active patient record flag assignment records in
 ; the PRF ASSIGNMENT (#26.13) file associated with this flag.
 ;
 ; file both the (#26.11) & (#26.12) entries
 S DGRESULT=$$STOALL^DGPFALF1(.DGPFLF,.DGPFLH,.DGERR)
 ;
 D MES^XPDUTL("Local record flag "_FLGNM_" inactivation was "_$S(+DGRESULT:"filed successfully.",1:"not filed successfully."))
 ;
 Q
 ;
OPT ; List of options to mark out of order
 ;/DGPF BACKGROUND PROCESSING/Patient Record Flag Background
 ;/DGPF ENABLE DIVISIONS/Record Flag Enable Divisions
 ;/DGPF LOCAL TO NATIONAL CONVERT/Convert Local HRMH PRF to National
 ;/DGPF MANUAL QUERY/Record Flag Manual Query
 ;/DGPF PRF TRANSFER REQUESTS/Record Flag Transfer Requests
 ;/DGPF PRINCIPAL INVEST REPORT/Assignments by Principal Investigator Report
 ;/DGPF RECORD FLAG ASSIGNMENT/Record Flag Assignment
 ;/DGPF RECORD FLAG MANAGEMENT/Record Flag Management
 ;/DGPF RECORD REFRESH/Record Flag Data Refresh
 ;/DGPF TRANSMISSION ERRORS/Record Flag Transmission Errors
 ;/DGPF TRANSMISSION MGMT/Record Flag Transmission Mgmt
 ;//;
 ; Note reporting options are left enabled
 ;
FAIL ;
 W !!?4,"Unable to find option: ",OPT,"  ",OPTNM
 Q
 ;
