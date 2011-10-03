DGROHLQ ;DJH/AMA - ROM HL7 QRY/ORF PROCESSING ; 28 Apr 2004  4:21 PM
 ;;5.3;Registration;**533,572**;Aug 13, 1993
 ;
BLDQRY(DGDFN,DGICN,DGROOT,DGHL,DGUSER) ;Build QRY~R02 Message/Segments
 ;Called from SNDQRY^DGROHLS
 ;  Input:
 ;    DGDFN - (required) Pointer to patient in PATIENT (#2) file
 ;    DGICN - (required) Patient's Integrated Control Number
 ;   DGROOT - (required) Closed root array or global name for segment storage
 ;     DGHL - (required) VistA HL7 environment array
 ;   DGUSER - (required) String of user data from New Person File (SSN~Name~DUZ~Phone)
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
 S (DGCNT,DGRSLT)=0
 ;
 I +$G(DGDFN),+$G(DGICN),$G(DGROOT)]"" D
 . ;
 . ;get patient demographics
 . Q:'$$GETPAT^DGROUT2(DGDFN,.DGDEM)
 . ;build QRD
 . S DGSTR="1,2,3,4,7,8,9,10"
 . S DGQRD=$$QRD^DGROHLQ1(DGDFN,DGICN,DGSTR,.DGHL,DGUSER)
 . Q:(DGQRD="")
 . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGQRD
 . ;
 . ;build QRF
 . S DGSTR="1,4,5"
 . S DGQRF=$$QRF^DGROHLQ2($G(DGDEM("SSN")),$G(DGDEM("DOB")),DGSTR,.DGHL)
 . Q:(DGQRF="")
 . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGQRF
 . ;
 . S DGRSLT=1
 Q DGRSLT
 ;
BLDORF(DGROOT,DGHL,DGDFN,DGQRY,DGSEGERR,DGQRYERR) ;Build ORF~R04 Message/Segments
 ;Called from SNDORF^DGROHLS
 ;  Input:
 ;     DGROOT - (required) Segment array, ^TMP("HLA",$J)
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
 N DGRSLT    ;function value
 N DGSEGSTR  ;formatted segment string
 N DGSTR     ;comma-delimited list of fields to include
 ;
 S DGRSLT=0
 ;
 I $G(DGROOT)]"",+$G(DGDFN)>0,$D(DGQRY) D
 . S DGCNT=0
 . ;
 . ;build MSA segment
 . S DGACK=$S($D(DGSEGERR):"AR",$D(DGQRYERR):"AE",1:"AA")
 . S DGSTR=$S(DGACK="AE":"1,2,6",1:"1,2")
 . I '$D(DGHL("MID")) S DGHL("MID")=+$G(DGHL("ICN"))
 . S DGSEGSTR=$$MSA^DGROHLU3(DGACK,DGHL("MID"),.DGQRYERR,DGSTR,.DGHL)
 . Q:(DGSEGSTR="")
 . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGSEGSTR
 . ;
 . ;build ERR segments for any segment parsing errors
 . I DGACK="AR",'$$BLDERR^DGROHLU4(DGROOT,.DGSEGERR,.DGHL,.DGCNT) Q
 . ;
 . ;build QRD segment
 . S DGSTR="1,2,3,4,5,7,8,9,10"
 . S DGSEGSTR=$$QRD^DGROHLQ1($G(DGQRY("DFN")),$G(DGQRY("ICN")),DGSTR,.DGHL)
 . Q:(DGSEGSTR="")
 . S DGCNT=DGCNT+1,@DGROOT@(DGCNT)=DGSEGSTR
 . ;
 . ;gather all of the patient data
 . N DGROFDA,DGX
 . S DGROFDA=$NA(^TMP("DGROFDA",$J)) K @DGROFDA
 . D DIQ^DGROHLU(.DGROFDA,2,DGDFN,.DGQRY)
 . ;
 . ;build FDA segment
 . K DGSEGSTR
 . D FDA^DGROHLU1(DGROFDA,.DGSEGSTR)
 . K @DGROFDA
 . ;
 . Q:'$D(DGSEGSTR)
 . S DGX=0 F  S DGX=$O(DGSEGSTR(DGX)) Q:'DGX  D
 . . S @DGROOT@(DGCNT+DGX)=DGSEGSTR(DGX)
 . ;
 . S DGRSLT=1
 Q DGRSLT
