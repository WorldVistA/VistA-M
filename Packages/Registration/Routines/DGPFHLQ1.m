DGPFHLQ1 ;ALB/RPM - PRF HL7 BUILD QRD SEGMENT ; 02/02/03
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
 ;
QRD(DGQID,DGWHO,DGFLD,DGHL) ;QRD HL7 segment API
 ;This function wraps the data retrieval and segment creation APIs and
 ;returns a formatted QRD segment.
 ;
 ;  Input:
 ;    DGQID - (required) Query ID (DFN)
 ;    DGWHO - (required) Who Subject Filter (Integrated Control Number)
 ;    DGFLD - (optional) List of comma-separated fields (sequence #'s)
 ;            to include.  Defaults to all required fields (1-4,7-10).
 ;     DGHL - VistA HL7 environment array
 ;
 ; Output:
 ;  Function Value - QRD segment on success, "" on failure
 ;
 N DGQRD
 N DGVAL
 ;
 S DGQRD=""
 I $G(DGQID)>0,$G(DGWHO)]"" D
 . S DGFLD=$$CKSTR^DGPFHLUT("1,2,3,4,7,8,9,10",DGFLD)  ;validate fields
 . S DGFLD=","_DGFLD_","
 . I $$QRDVAL(DGFLD,DGQID,DGWHO,.DGVAL) D
 . . S DGQRD=$$BLDSEG^DGPFHLUT("QRD",.DGVAL,.DGHL)
 Q DGQRD
 ;
QRDVAL(DGFLD,DGQID,DGWHO,DGVAL) ;build QRD value array
 ;
 ;  Input:
 ;    DGFLD - Fields string
 ;    DGQID - Query ID (DFN)
 ;    DGWHO - Who Subject filter (ICN)
 ;    
 ;  Output:
 ;   Function Value - 1 on success, 0 on failure
 ;            DGVAL - QRD field array [SUB1:field, SUB2:repetition,
 ;                                    SUB3:component, SUB4:sub-component
 ;
 N DGRSLT
 ;
 S DGRSLT=0
 I $G(DGQID)>0,$G(DGWHO)]"",$G(DGFLD)]"" D
 . ;
 . ; seq 1 (required) Query Date/Time
 . I DGFLD[",1," D  Q:(+DGVAL(1)'>0)
 . . S DGVAL(1)=$$FMTHL7^XLFDT($$NOW^XLFDT())
 . ;
 . ; seq 2 (required) Query Format Code
 . I DGFLD[",2," D
 . . S DGVAL(2)="R"  ;always "R"ecord
 . ;
 . ; seq 3 (required) Query Priority
 . I DGFLD[",3," D
 . . S DGVAL(3)="I"  ;always "I"mmediate
 . ;
 . ; seq 4 (required) Query ID
 . I DGFLD[",4," D
 . . S DGVAL(4)=DGQID
 . ;
 . ; seq 5 (optional) Deferred Response Type
 . I DGFLD[",5," D
 . . S DGVAL(5)=""
 . ;
 . ; seq 6 (optional) Deferred Response Date/Time
 . I DGFLD[",6," D
 . . S DGVAL(6)=""
 . ;
 . ; seq 7 (required) Quantity Limited Request
 . I DGFLD[",7," D
 . . S DGVAL(7,1,1)=10
 . . S DGVAL(7,1,2)="RD"  ;records
 . ;
 . ; seq 8 (required) Who Subject Filter
 . I DGFLD[",8," D
 . . S DGVAL(8,1,1)=DGWHO
 . . S DGVAL(8,1,9,1)="USVHA"
 . . S DGVAL(8,1,9,2)=""
 . . S DGVAL(8,1,9,3)="L"
 . ;
 . ; seq 9 (required) What Subject Filter
 . I DGFLD[",9," D
 . . S DGVAL(9,1,1)="OTH"
 . . S DGVAL(9,1,2)="Other"
 . . S DGVAL(9,1,3)="HL0048"
 . ;
 . ; seq 10 (required) What Dept. Data Code
 . I DGFLD[",10," D
 . . S DGVAL(10,1,1)="PRFA"
 . . S DGVAL(10,1,2)="Patient Record Flag Assignments"
 . . S DGVAL(10,1,3)="L"
 . ;
 . ; seq 11 (optional) What Data Code Value Qual.
 . I DGFLD[",11," D
 . . S DGVAL(11)=""
 . ;
 . ; seq 12 (optional) Query Results Level
 . I DGFLD[",12," D
 . . S DGVAL(12)=""
 . ;
 . S DGRSLT=1
 I 'DGRSLT K DGVAL
 Q DGRSLT
