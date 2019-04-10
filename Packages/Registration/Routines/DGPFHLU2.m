DGPFHLU2 ;ALB/RPM - PRF HL7 BUILD OBX SEGMENT ; 2/20/03
 ;;5.3;Registration;**425,951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
OBX(DGSET,DGID,DGSUBID,DGVALUE,DGPFAH,DGFLD,DGHL) ;OBX Segment API
 ;This function wraps the data retrieval and segment creation APIs and
 ;returns a formatted OBX segment.
 ;
 ;  Input:
 ;     DGSET - (required) OBX segment Set ID
 ;      DGID - (required) Observation identifier code
 ;   DGSUBID - (optional) Observation Sub-ID
 ;   DGVALUE - (required) Observation value
 ;    DGPFAH - (required) Assignment history data array
 ;     DGFLD - (optional) List of comma-separated fields (sequence #'s)
 ;             to include.  Defaults to all required fields (3,11).
 ;      DGHL - HL7 environment array
 ;
 ;  Output:
 ;   Function Value - OBX segment on success, "" on failure
 ;
 N DGOBX
 N DGVAL
 ;
 S HLECH=DGHL("ECH"),HLFS=DGHL("FS")
 S DGOBX=""
 I $G(DGSET)>0,$G(DGID)?1A,$G(DGVALUE)]"" D
 . S DGFLD=$$CKSTR^DGPFHLUT("3,11",DGFLD)  ;required fields
 . S DGFLD=","_DGFLD_","
 . I $$OBXVAL(DGFLD,DGSET,DGID,DGSUBID,DGVALUE,.DGPFAH,.DGVAL) D
 . . S DGOBX=$$BLDSEG^DGPFHLUT("OBX",.DGVAL,.DGHL)
 Q DGOBX
 ;
OBXVAL(DGFLD,DGSET,DGID,DGSUBID,DGVALUE,DGPFAH,DGVAL) ;build OBX value array
 ;
 ;  Input:
 ;     DGFLD - (required) Fields string
 ;     DGSET - (required) OBX segment Set ID
 ;      DGID - (required) Observation identifier code
 ;   DGSUBID - (optional) Observation Sub-ID
 ;   DGVALUE - (required) Observation value, or DBRS data string in case of DBRS OBX segment
 ;    DGPFAH - (required) Assignment history data array
 ;
 ;  Output:
 ;   Function Value - 1 on success, 0 on failure
 ;            DGVAL - OBX field array [SUB1:field, SUB2:repetition,
 ;                                    SUB3:component, SUB4:sub-component]
 ;
 N DGRSLT   ;function value
 N DGTYPE   ;observation value type
 N DGIDSTR  ;observation identifier string
 N DGDAT    ;observation date
 N ACTION,DBRSSTAT
 ;
 S DGRSLT=0
 S ACTION=+$G(DGPFAH("ACTION"))
 I DGID="D" S DBRSSTAT=$P($P(DGVALUE,U,4),";")
 ;
 I $G(DGFLD)]"",+$G(DGSET)>0,$G(DGID)?1A,$G(DGVALUE)]"" D
 .; seq 1 Set ID
 .I DGFLD[",1," S DGVAL(1)=DGSET
 .; seq 2 Value Type
 .I DGFLD[",2," D
 ..S DGTYPE=$S(DGID="S":"ST",DGID="N":"TX",DGID="C":"TX",DGID="D":"TX",1:"") Q:(DGTYPE']"")
 ..S DGVAL(2)=DGTYPE
 ..Q
 .; seq 3 Observation Identifier
 .I DGFLD[",3," D  Q:'$D(DGVAL(3))   ;required field
 ..I DGID="D" S DGIDSTR="DBRS-"_$S(DBRSSTAT="D":"Delete",1:"Update")
 ..I DGID'="D" S DGIDSTR=$S(DGID="S":"Status",DGID="N":"Narrative",DGID="C":"Comment",1:"") Q:(DGIDSTR']"")
 ..S DGVAL(3,1,1)=DGID
 ..S DGVAL(3,1,2)=DGIDSTR
 ..S DGVAL(3,1,3)="L"
 ..Q
 .; seq 4 Observation Sub-ID (optional)
 .I DGFLD[",4," S DGVAL(4)=$S(+$G(DGSUBID)>0:DGSUBID,1:"")
 .; seq 5 Observation Value
 .I DGFLD[",5," D
 ..I DGID="D" S DGVAL(5,1)=$$ENCHL7^DGPFHLUT($P(DGVALUE,U)),DGVAL(5,2)=$$ENCHL7^DGPFHLUT($P(DGVALUE,U,2)) Q
 ..S DGVAL(5)=$$ENCHL7^DGPFHLUT(DGVALUE)
 ..Q
 .; seq 6 Units
 .I DGFLD[",6," S DGVAL(6)=""
 .; seq 7 Reference Range
 .I DGFLD[",7," S DGVAL(7)=""
 .; seq 8 Abnormal Flags
 .I DGFLD[",8," S DGVAL(8)=""
 .; seq 9 Probability
 .I DGFLD[",9," S DGVAL(9)=""
 .; seq 10 Nature of Abnormal Test
 .I DGFLD[",10," S DGVAL(10)=""
 .; seq 11 Observation Result Status
 .I DGFLD[",11," S DGVAL(11)="F"
 .; seq 12 Date last Obs Normal Values
 .I DGFLD[",12," S DGVAL(12)=""
 .; seq 13 User Defined Access Checks
 .I DGFLD[",13," S DGVAL(13)=""
 .; seq 14 Date/Time of the Observation
 .I DGFLD[",14," D
 ..S DGDAT=$$FMTHL7^XLFDT($S(DGID="D":$P($P(DGVALUE,U,3),";"),1:+$G(DGPFAH("ASSIGNDT"))))
 ..S DGVAL(14)=$S(DGDAT>0:DGDAT,1:"")
 ..Q
 .; seq 15 Producer's ID
 .I DGFLD[",15," S DGVAL(15)=""
 .; seq 16 Responsible Observer
 .I DGFLD[",16," S DGVAL(16)=""
 .; seq 17 Observation Method
 .I DGFLD[",17," S DGVAL(17)=""
 .; seq 23 Performing Organization Name
 .I DGFLD[",23," D
 ..I DGID="D" S DGVAL(23,1,3)=$$STA^XUAF4(+$P($P(DGVALUE,U,5),";")) Q
 ..S DGVAL(23,1,3)=$$STA^XUAF4(+$G(DGPFAH("ORIGFAC")))
 ..Q
 .;
 .S DGRSLT=1
 .Q
 I 'DGRSLT K DGVAL
 Q DGRSLT
 ;
BLDOBXTX(DGROOT,DGTXTA,DGID,DGPFAH,DGHL,DGSEG,DGSET) ;build OBX text segments
 ;
 ;  Input:
 ;     DGROOT - (required) Closed root array or global name for segment
 ;              storage
 ;     DGTXTA - (required) Closed root array containing text
 ;       DGID - (required) OBX segment Observation ID
 ;     DGPFAH - (required) Assignment history data array
 ;       DGHL - (required) VistA HL7 environment array
 ;      DGSEG - (optional) Previous segment # in DGROOT
 ;      DGSET - (optional) Previous OBX Set ID
 ;
 ;  Output:
 ;   Function Value - 1 on success, 0 on failure
 ;
 N DGI       ;generic counter
 N DGOBX     ;formatted OBX segment
 N DGOBXTX   ;array of pre-processed text lines
 N DGRSLT    ;function value
 N DGSTR     ;list of OBX segment fields to include
 ;
 S DGRSLT=0
 S DGSTR="1,2,3,5,11,14,23"
 I $G(DGROOT)]"",$G(DGTXTA)]"",$G(DGID)?1A,$D(DGPFAH) D
 . Q:'$$BLDTEXT^DGPFHLUT(DGTXTA,.DGHL,.DGOBXTX)
 . S DGSEG=$G(DGSEG,0)
 . S DGSET=$G(DGSET,0)
 . S DGI=0
 . F  S DGI=$O(DGOBXTX(DGI)) Q:'DGI  D  Q:(DGOBX="")
 . . S DGSET=DGSET+1
 . . S DGOBX=$$OBX^DGPFHLU2(DGSET,DGID,"",DGOBXTX(DGI),.DGPFAH,DGSTR,.DGHL)
 . . Q:(DGOBX="")
 . . S DGSEG=DGSEG+1,@DGROOT@(DGSEG)=DGOBX
 . Q:(DGOBX)=""
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
