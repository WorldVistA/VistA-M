DGY991PO ; ALB/CNF/CMF/GXT - UTILITY TO INACTIVATE CAT2 PRFS ; Feb 12, 2026@07:58:55
 ;;5.3;Registration;**991**;;Build 12
 ;
 ;  Use of $$CRNRSITE^VAFCCRNR supported by ICR #7346.
 ;
 Q
 ;
ENTRY ;
 N X I '$$CRNRSITE^VAFCCRNR($P($$SITE^VASITE(),U,3)) W !!,"*** CAN BE RUN ON CONVERTED SITES ONLY ***",! R !,"Press [RETURN] to continue",X:$G(DTIME,300) Q
 D CAT2,OUTOOM
 Q
 ;
CAT2 ;
 N FLGNM,FLG,DGPFLH,DGPFLF ;
 ;
 W !,"Inactivate Category II Patient Record Flags (Local patient record flags).",!!
 W "All patient assignments for category II flags will be inactivated.",!!
 ;
 ; Loop through active category II patient record flags"
 S MSG="PRF functionality inactivated after migration to Federal EHR"
 S FLGNM=""
 F  S FLGNM=$O(^DGPF(26.11,"ASTAT",1,FLGNM)) Q:FLGNM=""  D
 . S FLG=$O(^DGPF(26.11,"ASTAT",1,FLGNM,0)) Q:FLG=""
 . D DEACT(FLG,FLGNM,MSG)
 . Q
 ;
 Q
 ;
DEACT(FLG,FLGNM,MSG) ;Deactivate
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
 S DGPFLF("FLAG")=FLGNM ;flag description
 S DGPFLF("STAT")="0^INACTIVE" ;change to inactive
 ;
 ; setup remaining flag history array nodes for filing in 26.12
 S DGPFLH("FLAG")=FLGNM ;flag description
 S DGPFLH("ENTERDT")=$$NOW^XLFDT()      ;current date/time
 S DGPFLH("ENTERBY")=DUZ         ;current user
 S DGX="^^1^1^"_($P(DGPFLH("ENTERDT"),".",1))_"^"
 S DGPFLH("REASON",0)=DGX        ;reason array
 S DGPFLH("REASON",1,0)=MSG
 ;
 ; Inactivate the category II patient record flag which will also trigger
 ; inactivation of all active patient record flag assignment records in
 ; the PRF ASSIGNMENT (#26.13) file associated with this flag.
 ;
 ; file both the (#26.11) & (#26.12) entries
 S DGRESULT=$$STOALL^DGPFALF1(.DGPFLF,.DGPFLH,.DGERR)
 ;
 W "Local record flag "_FLGNM_" inactivation was "_$S(+DGRESULT:"filed successfully.",1:"not filed successfully."),!
 ;
 Q
 ;
OUTOOM ;
 N PXI,PXLINE,OPTION,TEXT
 F PXI=1:1 S PXLINE=$P($T(OPT+PXI),";;",2) Q:PXLINE=""  D
 . S OPTION=PXLINE
 . S TEXT="PRF functionality inactivated after migration to Federal EHR"
 . D OUT^XPDMENU(OPTION,TEXT)
 Q
 ; 
OPT ; List of options to mark out of order
 ;;DGPF BACKGROUND PROCESSING
 ;;DGPF ENABLE DIVISIONS
 ;;DGPF LOCAL TO NATIONAL CONVERT
 ;;DGPF MANUAL QUERY
 ;;DGPF PRF TRANSFER REQUESTS
 ;;DGPF PRINCIPAL INVEST REPORT
 ;;DGPF RECORD FLAG ASSIGNMENT
 ;;DGPF RECORD FLAG MANAGEMENT
 ;;DGPF RECORD REFRESH
 ;;DGPF TRANSMISSION ERRORS
 ;;DGPF TRANSMISSION MGMT
