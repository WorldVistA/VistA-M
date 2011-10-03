IB20P213 ;ISP/TJH - ENVIRONMENT CHECK WITH PRE-INIT CODE ;04/24/2003
 ;;2.0;INTEGRATED BILLING;**213**;21-MAR-94
 ;
ENV ; environment check
 ; No special environment check at this time.
PRE ; set up check points for pre-init
 N %
 S %=$$NEWCP^XPDUTL("R0SC","R0SC^IB20P213")
 S %=$$NEWCP^XPDUTL("NAMES","NAMES^IB20P213")
 Q
 ;
R0SC ; add a new report type to file 361.2
 ; Name=R0SC ; Description=PROF. GOV'T PAYER EDITS
 ; Disposition=MAIL REPORT TO MAIL GROUP
 N IBA,IBERRM
 I $$FIND1^DIC(361.2,"","X","R0SC","B") D  Q
 . D BMES^XPDUTL("R0SC report already in file.  No action taken.")
 D BMES^XPDUTL("Adding R0SC report to file 361.2.")
 S IBA(361.2,"+1,",.01)="R0SC" ;    new report name
 S IBA(361.2,"+1,",.02)=1 ;         internal value 1 = Mail report to mail group
 S IBA(361.2,"+1,",.03)="PROF. GOV'T PAYER EDITS" ; description
 D UPDATE^DIE("","IBA","","IBERRM") ; file a new record
 I $D(IBERRM) D  Q  ; no reason for this to happen but just in case...
 . K IBA
 . S IBA(1)="WARNING:  Unable to add the R0SC report."
 . S IBA(2)="          The following error message was recorded."
 . S IBA(3)=IBERRM("DIERR",1,"TEXT",1)
 . D BMES^XPDUTL(.IBA)
 D COMPLETE
 Q
 ;
NAMES ; change names of reports per request from EDI group
 D BMES^XPDUTL("Filing new names for six of the Electronic Reports")
 N IBA,IBERRM,IBIEN,IBNA,IBRT
 S IBNA("R022")="PROV DAILY STATS ACCEPT/REJECT"
 S IBNA("R0EX")="INST. GOV'T PAYER EDITS"
 S IBNA("R0N9")="INST. GOV'T WEBMD EDITS"
 S IBNA("R0SA")="PROF. GOV'T WEBMD ACCEPTANCE"
 S IBNA("R0SR")="PROF. GOV'T WEBMD REJECTS"
 S IBNA("R0SS")="PROF. GOV'T WEBMD EDITS"
 S IBRT=0 F  Q:IBRT=""  D
 . S IBRT=$O(IBNA(IBRT)) Q:IBRT=""
 . S IBIEN=+$$FIND1^DIC(361.2,"","X",IBRT,"B")
 . I 'IBIEN D BMES^XPDUTL("Report "_IBRT_" not found.  No change made.") Q
 . S IBA(361.2,IBIEN_",",.03)=IBNA(IBRT)
 D FILE^DIE("","IBA","IBERRM")
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
