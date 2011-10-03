DGPFHLQ2 ;ALB/RPM - PRF HL7 BUILD QRF SEGMENT ; 02/02/03
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
 ;
QRF(DGSSN,DGDOB,DGFLD,DGHL) ;QRF HL7 segment API
 ;This function wraps the data retrieval and segment crateion APIs and
 ;returns a formatted QRF segment.
 ;
 ;  Input:
 ;    DGSSN - (required) Patient's Social Security Number
 ;    DGDOB - (required) Patient's Date of Birth in FileMan format
 ;    DGFLD - (optional) List of comma-separated fields (sequence #'s)
 ;            to include.  Defaults to all required fields (1).
 ;     DGHL - VistA HL7 environment array
 ;
 ; Output :
 ;  Function Value - QRF segment on success, "" on failure
 ;
 N DGQRF
 N DGVAL
 ;
 S DGQRF=""
 I $G(DGSSN),$G(DGDOB) D
 . S DGFLD=$$CKSTR^DGPFHLUT("1",DGFLD)  ;validate field string
 . S DGFLD=","_DGFLD_","
 . I $$QRFVAL(DGFLD,DGSSN,DGDOB,.DGVAL) D
 . . S DGQRF=$$BLDSEG^DGPFHLUT("QRF",.DGVAL,.DGHL)
 Q DGQRF
 ;
QRFVAL(DGFLD,DGSSN,DGDOB,DGVAL) ;build QRF field value array
 ;
 ;  Input:
 ;    DGFLD - (required) Fields string
 ;    DGSSN - (required) Patient's Social Security Number
 ;    DGDOB - (required) Patient's Date of Birth
 ;
 ;  Output:
 ;   Function Value - 1 on success, 0 on failure
 ;            DGVAL - QRF field array [SUB1:field, SUB2:repetition,
 ;                                    SUB3:component, SUB4:sub-component]
 ;
 N DGRSLT
 ;
 S DGRSLT=0
 I $G(DGFLD)]"",$G(DGSSN),$G(DGDOB) D
 . ;
 . ; seq 1 (required) Where Subj Filter
 . I DGFLD[",1," D
 . . S DGVAL(1)="PRF"
 . ;
 . ; seq 2 (optional) When Data Start Date/Time
 . I DGFLD[",2," D
 . . S DGVAL(2)=""
 . ;
 . ; seq 3 (optional) When Data End Date/Time
 . I DGFLD[",3," D
 . . S DGVAL(3)=""
 . ;
 . ; seq 4 (optional) What User Qualifier
 . I DGFLD[",4," D
 . . S DGVAL(4)=DGSSN
 . ;
 . ; seq 5 (optional) Other Query Subj Filter
 . I DGFLD[",5," D
 . . S DGVAL(5)=$$FMTHL7^XLFDT(DGDOB)
 . ;
 . ;- seq 6 (optional) Which Date/Time Qualifier
 . I DGFLD[",6," D
 . . S DGVAL(6)=""
 . ;
 . ; seq 7 (optional) Which Date/Time Status Qualifier
 . I DGFLD[",7," D
 . . S DGVAL(7)=""
 . ;
 . ; seq 8 (optional) Date/Time Selection Qualifier
 . I DGFLD[",8," D
 . . S DGVAL(8)=""
 . ;
 . ; seq 9 (optional) When Quantity/Timing Qualifier
 . I DGFLD[",9," D
 . . S DGVAL(9)=""
 . ;
 . S DGRSLT=1
 I 'DGRSLT K DGVAL
 Q DGRSLT
