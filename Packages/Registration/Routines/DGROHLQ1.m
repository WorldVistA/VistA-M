DGROHLQ1 ;DJH/AMA - ROM HL7 BUILD QRD SEGMENT ; 28 Apr 2004  4:31 PM
 ;;5.3;Registration;**533,572**;Aug 13, 1993
 ;
QRD(DGDFN,DGICN,DGFLD,DGHL,DGUSER) ;QRD HL7 segment API
 ;This function wraps the data retrieval and segment creation APIs
 ;and returns a formatted QRD segment.
 ;  Called from BLDQRY and BLDORF^DGROHLQ
 ;
 ;  Input:
 ;    DGDFN - (required) DFN
 ;    DGICN - (required) Integrated Control Number
 ;    DGFLD - (optional) List of comma-separated fields (sequence #'s)
 ;            to include.  Defaults to all required fields (1-4,7-10).
 ;     DGHL - VistA HL7 environment array
 ;   DGUSER - (optional) String of user data from New Person File
 ;               (SSN~Name~DUZ~Phone).  If this is populated, it means
 ;               this is the QRY to the LST.  If not, it's the ORF going
 ;               back to the Querying Site.     ;added in DG*5.3*572
 ;
 ; Output:
 ;  Function Value - QRD segment on success, "" on failure
 ;
 N DGQRD,DGVAL
 ;
 S DGQRD=""
 I $G(DGDFN)>0,$G(DGICN)]"" D
 . S DGFLD=$$CKSTR^DGROHLUT("1,2,3,4,5,6,7,8,9,10",DGFLD) ;validte flds
 . S DGFLD=","_DGFLD_","
 . I $$QRDVAL(DGFLD,DGDFN,DGICN,.DGVAL,$G(DGUSER)) D   ;DG*5.3*572 added DGUSER
 . . S DGQRD=$$BLDSEG^DGROHLUT("QRD",.DGVAL,.DGHL)
 Q DGQRD
 ;
QRDVAL(DGFLD,DGDFN,DGICN,DGVAL,DGUSER) ;build QRD value array
 ;
 ;  Input:
 ;    DGFLD - Fields string
 ;    DGDFN - DFN
 ;    DGICN - ICN
 ;   DGUSER - (optional) String of user data from New Person File
 ;               (SSN~Name~DUZ~Phone)   ;DG*5.3*572
 ;    
 ;  Output:
 ;   Function Value - 1 on success, 0 on failure
 ;            DGVAL - QRD field array [SUB1:field, SUB2:repetition,
 ;                                     SUB3:component, SUB4:sub-component]
 ;
 N DGRSLT
 ;
 S DGRSLT=0
 I $G(DGDFN)>0,$G(DGICN)]"",$G(DGFLD)]"" D
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
 . ; seq 4 (required) Identifying Information
 . ;DG*5.3*572 - if the QRY to the LST, send the QS DFN and User info
 . ;           - if the ORF back to the QS, just send the QS DFN
 . I DGFLD[",4," D
 . . S DGVAL(4)=DGDFN_$S($G(DGUSER):"~"_DGUSER,1:"")   ;DG*5.3*572
 . ;
 . ; seq 5 (optional) Deferred Response Type
 . ; Indicates version of ROM messages
 . I DGFLD[",5," D
 . . S DGVAL(5)="572"
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
 . ; seq 8 (required) ICN
 . I DGFLD[",8," D
 . . S DGVAL(8,1,1)=DGICN
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
 . . S DGVAL(10,1,1)="ROMDD"
 . . S DGVAL(10,1,2)="Register Once Messaging Demographic Data"
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
