DGPFHLU1 ;ALB/RPM - PRF HL7 BUILD OBR SEGMENT ; 2/18/03
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
 Q
 ;
OBR(DGSET,DGPFA,DGPFAH,DGFLD,DGHL) ;OBR Segment API
 ;This function wraps the data retrieval and segment creation APIs and
 ;returns a formatted OBR segment.
 ;
 ;  Input:
 ;     DGSET - (required) OBR segment Set ID
 ;     DGPFA - (required) Assignment data array
 ;    DGPFAH - (required) Assignment history data array
 ;     DGFLD - (optional) List of comma-separated fields (sequence #'s)
 ;             to include.  Defaults to all required fields (4).
 ;      DGHL - HL7 environment array
 ;
 ;  Output:
 ;   Function Value - OBR segment on success, "" on failure
 ;
 N DGOBR
 N DGVAL
 ;
 S DGOBR=""
 I $G(DGSET)>0,$D(DGPFA),$D(DGPFAH) D
 . S DGFLD=$$CKSTR^DGPFHLUT("4",DGFLD)  ;validate the field string
 . S DGFLD=","_DGFLD_","
 . I $$OBRVAL(DGFLD,DGSET,.DGPFA,.DGPFAH,.DGVAL) D
 . . S DGOBR=$$BLDSEG^DGPFHLUT("OBR",.DGVAL,.DGHL)
 Q DGOBR
 ;
OBRVAL(DGFLD,DGSET,DGPFA,DGPFAH,DGVAL) ;build OBR value array
 ;
 ;  Input:
 ;     DGFLD - (required) Fields string
 ;     DGSET - (required) OBR segment Set ID
 ;     DGPFA - (required) Assignment data array
 ;    DGPFAH - (required) Assignment history data array
 ;
 ;  Output:
 ;   Function Value - 1 on sucess, 0 on failure
 ;            DGVAL - OBR field array [SUB1:field, SUB2:repetition,
 ;                                    SUB3:component, SUB4:sub-component]
 ;
 N DGRSLT  ;function value
 N DGADT   ;assignment date
 N DGORIG  ;originating site
 N DGOWN   ;assignment owner
 ;
 S DGRSLT=0
 I $G(DGFLD)]"",+$G(DGSET)>0,+$G(DGPFA("FLAG"))>0,+$G(DGPFAH("ASSIGN"))>0 D
 . ;
 . ; seq 1 Set ID
 . I DGFLD[",1," D
 . . S DGVAL(1)=DGSET
 . ;
 . ; seq 2 Placer Order Number
 . I DGFLD[",2," D
 . ;
 . ; seq 3 Filler Order Number
 . I DGFLD[",3," D
 . ;
 . ; seq 4 Universal Service ID
 . I DGFLD[",4," D   ;required field
 . . S DGVAL(4,1,1)=+DGPFA("FLAG")         ;flag record# only, not IEN
 . . S DGVAL(4,1,2)=$P(DGPFA("FLAG"),U,2)  ;flag name
 . . S DGVAL(4,1,3)="VA085"                ;table name
 . ;
 . ; seq 5 Priority
 . I DGFLD[",5," D
 . ;
 . ; seq 6 Requested Date/time
 . I DGFLD[",6," D
 . ;
 . ; seq 7 Observation Date/Time
 . I DGFLD[",7," D
 . . S DGADT=$$FMTHL7^XLFDT(+$$GETADT^DGPFAAH(+DGPFAH("ASSIGN")))
 . . S DGVAL(7)=$S(DGADT>0:DGADT,1:"")
 . ;
 . ; seq 8 Observation End Date/Time
 . I DGFLD[",8," D
 . ;
 . ; seq 9 Collection volume
 . I DGFLD[",9," D
 . ;
 . ; seq 10 Collector Identifier
 . I DGFLD[",10," D
 . ;
 . ; seq 11 Specimen Action Code
 . I DGFLD[",11," D
 . ;
 . ; seq 12 Danger Code
 . I DGFLD[",12," D
 . ;
 . ; seq 13 Relevant Clinical Info
 . I DGFLD[",13," D
 . ;
 . ; seq 14 Specimen Received Date/Time
 . I DGFLD[",14," D
 . ;
 . ; seq 15 Specimen Source
 . I DGFLD[",15," D
 . ;
 . ; seq 16 Ordering Provider
 . I DGFLD[",16," D
 . ;
 . ; seq 17 Order Callback Phone Number
 . I DGFLD[",17," D
 . ;
 . ; seq 18 Placer field 1
 . I DGFLD[",18," D
 . ;
 . ; seq 19 Placer field 2
 . I DGFLD[",19," D
 . ;
 . ; seq 20 Filler field 1
 . I DGFLD[",20," D
 . . S DGOWN=+$G(DGPFA("OWNER"))
 . . S DGVAL(20)=$S(DGOWN>0:$$STA^XUAF4(DGOWN),1:"")
 . ;
 . ; seq 21 Filler Field 2
 . I DGFLD[",21," D
 . . S DGORIG=+$G(DGPFA("ORIGSITE"))
 . . S DGVAL(21)=$S(DGORIG>0:$$STA^XUAF4(DGORIG),1:"")
 . ;
 . ; seq 22 Results Rpt/Status Chng - Date/Time
 . I DGFLD[",22," D
 . ;
 . ; seq 23 Charge to Practice
 . I DGFLD[",23," D
 . ;
 . ; seq 24 Diagnostic Serv Sect ID
 . I DGFLD[",24," D
 . ;
 . ; seq 25 Result Status
 . I DGFLD[",25," D
 . ;
 . ; seq 26 Parent Result
 . I DGFLD[",26," D
 . ;
 . ; seq 27 Quantity/Timing
 . I DGFLD[",27," D
 . ;
 . ; seq 28 Result Copies To
 . I DGFLD[",28," D
 . ;
 . ; seq 29 Parent
 . I DGFLD[",29," D
 . ;
 . ; seq 30 Transportation Mode
 . I DGFLD[",30," D
 . ;
 . ; seq 31 Reason for Study
 . I DGFLD[",31," D
 . ;
 . ; seq 32 Principal Result Interpreter
 . I DGFLD[",32," D
 . ;
 . ; seq 33 Assistant Result Interpreter
 . I DGFLD[",33," D
 . ;
 . ; seq 34 Technician
 . I DGFLD[",34," D
 . ;
 . ; seq 35 Transcription
 . I DGFLD[",35," D
 . ;
 . ; seq 36 Scheduled Date/Time
 . I DGFLD[",36," D
 . ;
 . ; seq 37 Number of Sample Containers
 . I DGFLD[",37," D
 . ;
 . ; seq 38 Transport Logistics of Collected Sample
 . I DGFLD[",38," D
 . ;
 . ; seq 39 Collector's Comment
 . I DGFLD[",39," D
 . ;
 . ; seq 40 Transport Arrangement Responsibility
 . I DGFLD[",40," D
 . ;
 . ; seq 41 Transport Arranged
 . I DGFLD[",41," D
 . ;
 . ; seq 42 Escort Required
 . I DGFLD[",42," D
 . ;
 . ; seq 43 Planned Patient Transport Comment
 . I DGFLD[",43," D
 . ;
 . S DGRSLT=1
 I 'DGRSLT K DGVAL
 Q DGRSLT
