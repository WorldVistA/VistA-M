DGPFHLQ ;ALB/RPM - PRF HL7 QRY/ORF PROCESSING ; 1/23/03
 ;;5.3;Registration;**425,650**;Aug 13, 1993;Build 3
 ;
BLDQRY(DGDFN,DGICN,DGROOT,DGHL) ;Build QRY~R02 Message/Segments
 ;
 ;  Input:
 ;    DGDFN - (required) Pointer to patient in PATIENT (#2) file
 ;    DGICN - (required) Patient's Integrated Control Number
 ;   DGROOT - (required) Closed root array or global name for segment
 ;            storage.
 ;     DGHL - (required) VistA HL7 environment array
 ;
 ;  Output:
 ;   Function Value - 1 on success, 0 on failure
 ;           DGROOT - array of HL7 segments on success
 ;
 N DGCNT   ;segment counter
 N DGDEM   ;pt. demographics array
 N DGQRD   ;formatted QRD segment
 N DGQRF   ;formatted QRF segment
 N DGRSLT  ;function value
 N DGSTR   ;field string
 ;
 S DGRSLT=0
 S DGCNT=0
 ;
 I +$G(DGDFN),+$G(DGICN),$G(DGROOT)]"" D
 . ;
 . ;get patient demographics
 . Q:'$$GETPAT^DGPFUT2(DGDFN,.DGDEM)
 . ;
 . ;build QRD
 . S DGSTR="1,2,3,4,7,8,9,10"
 . S DGQRD=$$QRD^DGPFHLQ1(DGDFN,DGICN,DGSTR,.DGHL)
 . Q:(DGQRD="")
 . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGQRD
 . ;
 . ;build QRF
 . S DGSTR="1,4,5"
 . S DGQRF=$$QRF^DGPFHLQ2($G(DGDEM("SSN")),$G(DGDEM("DOB")),DGSTR,.DGHL)
 . Q:(DGQRF="")
 . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGQRF
 . ;
 . S DGRSLT=1
 Q DGRSLT
 ;
BLDORF(DGROOT,DGHL,DGDFN,DGQRY,DGSEGERR,DGQRYERR) ;Build ORF~R04 Message/Segments
 ;
 ;  Input:
 ;     DGROOT - (required) Segment array
 ;       DGHL - (required) HL7 environment array
 ;      DGDFN - (required) Pointer to patient in PATIENT (#2) file
 ;      DGQRY - (required) Array of parsed QRY data
 ;   DGSEGERR - (optional) Array of errors encountered during QRY parsing
 ;   DGQRYERR - (optional) Error encountered during ICN to DFN conversion
 ;
 ;  Output:
 ;   Function Value - 1 on success, 0 on failure
 ;
 N DGACK     ;acknowledgment code (i.e. AA, AE)
 N DGAIENS   ;array of assignment IENS
 N DGCNT     ;segment counter
 N DGI       ;generic index
 N DGOBROOT  ;temporary storage of OBR/OBX segments
 N DGRSLT    ;function value
 N DGSEGSTR  ;formatted segment string
 N DGSTR     ;comma-delimited list of fields to include
 ;
 S DGRSLT=0
 S DGOBROOT=$NA(^TMP("DGPF OB",$J))
 K @DGOBROOT
 ;
 I $G(DGROOT)]"",$D(DGQRY) D
 . S DGCNT=0
 . S DGACK=$S($D(DGSEGERR):"AE",$D(DGQRYERR):"AE",1:"AA")
 . ;
 . ;build OBR/OBX segments for any Category I record flag assignments
 . I DGACK="AA",$$GETALL^DGPFAA($G(DGDFN),.DGAIENS,"",1) D
 . . ;
 . . ;build and temporarily store OBR/OBX segments
 . . Q:$$BLDALLOB(DGOBROOT,.DGAIENS,.DGHL)
 . . ;
 . . ;if we get here then the data retrieval failed
 . . S DGQRYERR=261130  ;unable to retrieve existing assignments
 . . S DGACK="AE"
 . . K @DGOBROOT
 . ;
 . ;build MSA segment
 . S DGSTR=$S($D(DGQRYERR):"1,2,6",1:"1,2")
 . S DGSEGSTR=$$MSA^DGPFHLU3(DGACK,DGHL("MID"),.DGQRYERR,DGSTR,.DGHL)
 . Q:(DGSEGSTR="")
 . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGSEGSTR
 . ;
 . ;build ERR segments for any segment parsing errors
 . I $D(DGSEGERR),'$$BLDERR^DGPFHLU4(DGROOT,.DGSEGERR,.DGHL,.DGCNT) Q
 . ;
 . ;build QRD segment
 . S DGSTR="1,2,3,4,7,8,9,10"
 . S DGSEGSTR=$$QRD^DGPFHLQ1($G(DGQRY("QID")),$G(DGQRY("ICN")),DGSTR,.DGHL)
 . Q:(DGSEGSTR="")
 . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGSEGSTR
 . ;
 . ;move any OBR/OBX segments into the message
 . S DGI=0
 . F  S DGI=$O(@DGOBROOT@(DGI)) Q:'DGI  D
 . . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=@DGOBROOT@(DGI)
 . ;
 . ;success
 . S DGRSLT=1
 ;
 ;cleanup
 K @DGOBROOT
 ;
 Q DGRSLT
 ;
BLDALLOB(DGROOT,DGAIENS,DGHL) ;build all OBRs and OBXs for a patient
 ;
 ;  Input:
 ;  DGROOT - (required) Closed root array or global name for segment
 ;            storage.
 ; DGAIENS - (required) Array of pointers to PRF ASSIGNMENT (#26.13) file
 ;    DGHL - (required) VistA HL7 environment array
 ;
 ;  Output:
 ;   Function Value - 1 on success, 0 on failure
 ;           DGROOT - array of HL7 segments on success
 ;
 N DGAIEN    ;single assignment IEN
 N DGCNT     ;segment counter
 N DGHIEN    ;single assignment history IEN
 N DGHIENS   ;array of assignment history IENs
 N DGOBRSET  ;OBR segment Set ID
 N DGOBXOK   ;OBX segment creation flag
 N DGOBXSET  ;OBX segment Set ID
 N DGPFA     ;assignment data array
 N DGPFAH    ;assignment history data array
 N DGRSLT    ;function value
 N DGSEGSTR  ;formatted segment string
 N DGSTR     ;comma-delimited list of fields to include
 N DGTROOT   ;closed root name of text array value
 ;
 S DGCNT=0
 S DGRSLT=0
 I $G(DGROOT)]"",$D(DGAIENS) D
 . S DGAIEN=0
 . S DGOBRSET=0
 . F  S DGAIEN=$O(DGAIENS(DGAIEN)) Q:'DGAIEN  D
 . . N DGHIENS  ;array of assignment history IENS
 . . N DGPFA    ;assignment data array
 . . ;
 . . ;get assignment details
 . . Q:'$$GETASGN^DGPFAA(DGAIEN,.DGPFA)
 . . ;
 . . ;get last assignment history for narrative observation date
 . . Q:'$$GETHIST^DGPFAAH($$GETLAST^DGPFAAH(DGAIEN),.DGPFAH)
 . . ;
 . . ;build OBR segment for this assignment
 . . S DGSTR="1,4,7,20,21"
 . . S DGOBRSET=DGOBRSET+1
 . . S DGSEGSTR=$$OBR^DGPFHLU1(DGOBRSET,.DGPFA,.DGPFAH,DGSTR,.DGHL)
 . . Q:(DGSEGSTR="")
 . . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGSEGSTR
 . . ;
 . . ;build narrative OBX segment for this assignment
 . . S DGOBXSET=0
 . . S DGTROOT="DGPFA(""NARR"")"
 . . Q:'$$BLDOBXTX^DGPFHLU2(DGROOT,DGTROOT,"N",.DGPFAH,.DGHL,.DGCNT,.DGOBXSET)
 . . ;
 . . ;get a list of all assignment histories
 . . Q:'$$GETALL^DGPFAAH(DGAIEN,.DGHIENS)
 . . ;
 . . ;loop through each assignment history entry
 . . S DGHIEN=0
 . . F  S DGHIEN=$O(DGHIENS(DGHIEN)) Q:'DGHIEN  D  Q:'DGOBXOK
 . . . N DGPFAH
 . . . S DGOBXOK=0
 . . . ;
 . . . ;get single assignment history record
 . . . Q:'$$GETHIST^DGPFAAH(DGHIEN,.DGPFAH)
 . . . ;
 . . . ;build status OBX segment for this history record
 . . . S DGSTR="1,2,3,5,11,14"
 . . . S DGOBXSET=DGOBXSET+1
 . . . S DGSEGSTR=$$OBX^DGPFHLU2(DGOBXSET,"S","",$P($G(DGPFAH("ACTION")),U,2),.DGPFAH,DGSTR,.DGHL)
 . . . Q:(DGSEGSTR="")
 . . . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGSEGSTR
 . . . ;
 . . . ;build review comment OBX segments for this history record
 . . . S DGTROOT="DGPFAH(""COMMENT"")"
 . . . Q:'$$BLDOBXTX^DGPFHLU2(DGROOT,DGTROOT,"C",.DGPFAH,.DGHL,.DGCNT,.DGOBXSET)
 . . . S DGOBXOK=1
 . . Q:'DGOBXOK
 . . S DGRSLT=1
 Q DGRSLT
