DGQEHLNT ;ALB/RPM - VIC REPLACEMENT HL7 BUILD NTE SEGMENT ; 10/20/05
 ;;5.3;Registration;**679**;Aug 13, 1993
 ;
 Q
 ;
NTE(DGREQ,DGFLD,DGHL) ;NTE Segment API
 ;This function wraps the data retrieval and segment creation APIs and
 ;returns a formatted NTE segment.
 ;
 ;  Input:
 ;     DGREQ - (required) VIC REQUEST data array
 ;     DGFLD - (optional) List of comma-separated fields (sequence #'s)
 ;             to include.  Defaults to all required fields (4).
 ;      DGHL - HL7 environment array
 ;
 ;  Output:
 ;   Function Value - NTE segment on success, "" on failure
 ;
 N DGNTE
 N DGVAL
 ;
 S DGNTE=""
 I $D(DGREQ) D
 . S DGFLD=","_DGFLD_","
 . I $$NTEVAL(DGFLD,.DGREQ,.DGVAL) D
 . . S DGNTE=$$BLDSEG^DGQEHLUT("NTE",.DGVAL,.DGHL)
 Q DGNTE
 ;
NTEVAL(DGFLD,DGREQ,DGVAL) ;build NTE value array
 ;
 ;  Input:
 ;     DGFLD - (required) Fields string
 ;     DGREQ - (required) VIC REQUEST data array
 ;
 ;  Output:
 ;   Function Value - 1 on sucess, 0 on failure
 ;            DGVAL - NTE field array [SUB1:field, SUB2:repetition,
 ;                                    SUB3:component, SUB4:sub-component]
 ;
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 I $G(DGFLD)]"",+$G(DGREQ("DFN"))>0 D
 . ;
 . ; seq 1 Set ID
 . I DGFLD[",1," D
 . ;
 . ; seq 2 Source of comment
 . I DGFLD[",2," D
 . ;
 . ; seq 3 Comment
 . I DGFLD[",3," D
 . . N DGENRST  ;enrollment status
 . . S DGENRST=$$STATUS^DGENA(DGREQ("DFN"))
 . . S DGVAL(3,1)="POW:"_$S($$ISENRPND^DGQEUT1(DGENRST):"P",1:$$GETPOW^DGQEUT1(DGREQ("DFN")))
 . . S DGVAL(3,2)="PH:"_$$GETPH^DGQEUT1(DGREQ("DFN"))
 . ;
 . ; seq 4 Comment type
 . I DGFLD[",4," D
 . ;
 . S DGRSLT=1
 I 'DGRSLT K DGVAL
 Q DGRSLT
