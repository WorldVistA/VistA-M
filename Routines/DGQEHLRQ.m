DGQEHLRQ ;ALB/RPM - VIC REPLACEMENT HL7 BUILD RQD SEGMENT ;1/20/04
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
 Q
 ;
RQD(DGREQ,DGFLD,DGHL) ;RQD Segment API
 ;This function wraps the data retrieval and segment creation APIs and
 ;returns a formatted RQD segment.
 ;
 ;  Input:
 ;     DGREQ - (required) VIC REQUEST data array
 ;     DGFLD - (optional) List of comma-separated fields (sequence #'s)
 ;             to include.  Defaults to all required fields (4).
 ;      DGHL - HL7 environment array
 ;
 ;  Output:
 ;   Function Value - RQD segment on success, "" on failure
 ;
 N DGI
 N DGRQD
 N DGVAL
 ;
 S DGRQD=""
 I $D(DGREQ) D
 . S DGFLD=","_DGFLD_","
 . ;validate the field string - at least one of the three fields RQD-2,
 . ;RQD-3 or RQD-4 must be valued.
 . F DGI=2:1:4 I DGFLD[(","_DGI_",") D  Q
 . . I $$RQDVAL(DGFLD,.DGREQ,.DGVAL) D
 . . . S DGRQD=$$BLDSEG^DGQEHLUT("RQD",.DGVAL,.DGHL)
 Q DGRQD
 ;
RQDVAL(DGFLD,DGREQ,DGVAL) ;build RQD value array
 ;
 ;  Input:
 ;     DGFLD - (required) Fields string
 ;     DGREQ - (required) VIC REQUEST data array
 ;
 ;  Output:
 ;   Function Value - 1 on sucess, 0 on failure
 ;            DGVAL - RQD field array [SUB1:field, SUB2:repetition,
 ;                                    SUB3:component, SUB4:sub-component]
 ;
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 I $G(DGFLD)]"",+$G(DGREQ("DFN"))>0 D
 . ;
 . ; seq 1 Requisition Line Number
 . I DGFLD[",1," D
 . . S DGVAL(1)=1  ;always "1"
 . ;
 . ; seq 2 Item Code - Internal
 . I DGFLD[",2," D
 . ;
 . ; seq 3 Item Code - External  ;required
 . I DGFLD[",3," D
 . . S DGVAL(3)=$G(DGREQ("CARDID"))
 . Q:DGVAL(3)=""
 . ;
 . ; seq 4 Hospital Item Code
 . I DGFLD[",4," D
 . ;
 . ; seq 5 Requisition Quantity
 . I DGFLD[",5," D
 . ;
 . ; seq 6 Requisition Unit of Measure
 . I DGFLD[",6," D
 . ;
 . ; seq 7 Dept. Cost Center
 . I DGFLD[",7," D
 . ;
 . ; seq 8 Item Natural Account Code
 . I DGFLD[",8," D
 . ;
 . ; seq 9 Deliver To ID
 . I DGFLD[",9," D
 . ;
 . ; seq 10 Date Needed
 . I DGFLD[",10," D
 . ;
 . S DGRSLT=1
 I 'DGRSLT K DGVAL
 Q DGRSLT
