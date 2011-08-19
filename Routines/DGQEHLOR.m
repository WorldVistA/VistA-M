DGQEHLOR ;ALB/RPM - VIC REPLACEMENT HL7 BUILD ORC SEGMENT ; 2/23/04
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
 Q
 ;
ORC(DGREQ,DGFLD,DGHL) ;ORC Segment API
 ;This function wraps the data retrieval and segment creation APIs and
 ;returns a formatted ORC segment.
 ;
 ;  Input:
 ;     DGREQ - (required) VIC REQUEST data array
 ;     DGFLD - (optional) List of comma-separated fields (sequence #'s)
 ;             to include.  Defaults to all required fields (4).
 ;      DGHL - HL7 environment array
 ;
 ;  Output:
 ;   Function Value - ORC segment on success, "" on failure
 ;
 N DGORC
 N DGVAL
 ;
 S DGORC=""
 I $D(DGREQ) D
 . S DGFLD=$$CKSTR^DGQEHLUT("1",DGFLD)  ;validate the field string
 . S DGFLD=","_DGFLD_","
 . I $$ORCVAL(DGFLD,.DGREQ,.DGVAL) D
 . . S DGORC=$$BLDSEG^DGQEHLUT("ORC",.DGVAL,.DGHL)
 Q DGORC
 ;
ORCVAL(DGFLD,DGREQ,DGVAL) ;build ORC value array
 ;
 ;  Input:
 ;     DGFLD - (required) Fields string
 ;     DGREQ - (required) VIC REQUEST data array
 ;
 ;  Output:
 ;   Function Value - 1 on sucess, 0 on failure
 ;            DGVAL - ORC field array [SUB1:field, SUB2:repetition,
 ;                                    SUB3:component, SUB4:sub-component]
 ;
 N DGRSLT  ;function value
 N DGSTAT  ;temp value of DGREQ("CPRSTAT")
 ;
 S DGRSLT=0
 I $G(DGFLD)]"",+$G(DGREQ("DFN"))>0,$G(DGREQ("CARDID"))]"" D
 . ;
 . ; seq 1 Order Control
 . I DGFLD[",1," D   ;required field
 . . S DGSTAT=$G(DGREQ("CPRSTAT"))
 . . S DGVAL(1)=$S(DGSTAT="P":"RL",DGSTAT="C":"CA",DGSTAT="I":"CA",1:"")
 . Q:DGVAL(1)=""
 . ;
 . ; seq 2 Placer Order Number
 . I DGFLD[",2," D
 . ;
 . ; seq 3 Filler Order Number
 . I DGFLD[",3," D
 . ;
 . ; seq 4 Placer Group Number
 . I DGFLD[",4," D
 . ;
 . ; seq 5 Order Status
 . I DGFLD[",5," D
 . ;
 . ; seq 6 Response Flag
 . I DGFLD[",6," D
 . ;
 . ; seq 7 Quantity/Timing
 . I DGFLD[",7," D
 . ;
 . ; seq 8 Parent
 . I DGFLD[",8," D
 . ;
 . ; seq 9 Date/Time of Transaction
 . I DGFLD[",9," D
 . ;
 . ; seq 10 Entered By
 . I DGFLD[",10," D
 . ;
 . ; seq 11 Verified By
 . I DGFLD[",11," D
 . ;
 . ; seq 12 Ordering Provider
 . I DGFLD[",12," D
 . ;
 . ; seq 13 Enterer's Location
 . I DGFLD[",13," D
 . ;
 . ; seq 14 Call Back Phone Number
 . I DGFLD[",14," D
 . ;
 . ; seq 15 Order Effective Date/Time
 . I DGFLD[",15," D
 . ;
 . ; seq 16 Order Control Code Reason
 . I DGFLD[",16," D
 . ;
 . ; seq 17 Entering Organization
 . I DGFLD[",17," D
 . ;
 . ; seq 18 Entering Device
 . I DGFLD[",18," D
 . ;
 . ; seq 19 Action By
 . I DGFLD[",19," D
 . ;
 . S DGRSLT=1
 I 'DGRSLT K DGVAL
 Q DGRSLT
