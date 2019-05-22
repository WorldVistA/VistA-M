DGPFHLU1 ;ALB/RPM - PRF HL7 BUILD OBR SEGMENT ; 2/18/03
 ;;5.3;Registration;**425,951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
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
 S HLECH=DGHL("ECH"),HLFS=DGHL("FS")
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
 ;   Function Value - 1 on success, 0 on failure
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
 .; seq 1 Set ID
 .I DGFLD[",1," S DGVAL(1)=DGSET
 .; seq 4 Universal Service ID
 .I DGFLD[",4," D   ;required field
 ..S DGVAL(4,1,1)=+DGPFA("FLAG")                            ;flag ien
 ..S DGVAL(4,1,2)=$$ENCHL7^DGPFHLUT($P(DGPFA("FLAG"),U,2))  ;flag name
 ..S DGVAL(4,1,3)="VA085"                                 ;table name
 ..Q
 .; seq 7 Observation Date/Time
 .I DGFLD[",7," D
 ..S DGADT=$$FMTHL7^XLFDT(+$$GETADT^DGPFAAH(+DGPFAH("ASSIGN")))
 ..S DGVAL(7)=$S(DGADT>0:DGADT,1:"")
 ..Q
 .; seq 20 Filler field 1
 .I DGFLD[",20," D
 ..S DGOWN=+$G(DGPFA("OWNER"))
 ..S DGVAL(20)=$S(DGOWN>0:$$STA^XUAF4(DGOWN),1:"")
 ..Q
 .; seq 21 Filler Field 2
 .I DGFLD[",21," D
 ..S DGORIG=+$G(DGPFA("ORIGSITE"))
 ..S DGVAL(21)=$S(DGORIG>0:$$STA^XUAF4(DGORIG),1:"")
 ..Q
 .S DGRSLT=1
 .Q
 I 'DGRSLT K DGVAL
 Q DGRSLT
