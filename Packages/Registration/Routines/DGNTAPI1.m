DGNTAPI1 ;ALB/RPM - API's for N/T Radium Treatment(part 2); 7/16/01 3:04pm
 ;;5.3;Registration;**397,423**;Aug 13, 1993
 Q
 ;
ENRUPD(DGDFN,DGHEC) ;
 ;This function is the entry point for HEC/Enrollment data updates
 ;via the Enrollment HL7 message upload.
 ;
 ;  Input:
 ;    DGDFN  - PATIENT file (#2) IEN
 ;    DGHEC  - update values array passed by reference
 ;      DGHEC("NTR") - Nose/Throat Radium
 ;      DGHEC("AVI") - Aviator?
 ;      DGHEC("SUB") - Submariner
 ;      DGHEC("VER") - Verification method
 ;      DGHEC("VDT") - Verification completion date/time
 ;      DGHEC("VSIT") - Verification site
 ;      DGHEC("HNC") - Head/Neck CA DX
 ;      DGHEC("HDT") - Head/Neck CA date/time
 ;      DGHEC("HSIT") - Site determining CA DX
 ;
 ;  Output:
 ;    function result 1-success, 0-failure
 ;
 N DGRSLT
 N DGX    ;generic index
 S DGRSLT=0
 S DGDFN=+$G(DGDFN)
 F DGX="NTR","AVI","SUB","VER","VDT","VSIT","HNC","HDT","HSIT" D
 . S DGHEC(DGX)=$G(DGHEC(DGX))
 I DGDFN>0,$D(^DPT(DGDFN)),DGHEC("NTR")]"",DGHEC("VDT")]"",$$CHANGE^DGNTUT(DGDFN,.DGHEC,1) D
 . S DGHEC("EUSR")=DUZ
 . S DGHEC("EDT")=$$NOW^XLFDT
 . S DGRSLT=$$FILENTR^DGNTAPI(DGDFN,.DGHEC,0)
 Q DGRSLT
 ;
ENRGET(DGDFN,DGENR) ;Entry point for Enrollment data retrieval from
 ;NOSE AND THROAT RADIUM HISTORY file (#28.11).
 ;
 ;  Input:
 ;   DGDFN - IEN of patient in the PATIENT (#2) file
 ;   DGENR - Array name of return values [Optional - Default DGNTARR]
 ;
 ;  Output:
 ;    function result - 1-complete record found, 0-incomplete record
 ;    DGENR - Array of current NTR HISTORY file record field values.
 ;           See $$GETREC^DGNTAPI for array specifications.
 ;
 N DGIEN
 N DGRSLT
 N DGX
 ;
 I '$G(DGDFN) Q 0
 ;
 S DGENR=$G(DGENR)
 I DGENR']"" S DGENR="DGNTARR"
 ;
 S DGRSLT=0
 S DGIEN=+$$GETPRIM^DGNTAPI(DGDFN)
 I ($$GETREC^DGNTAPI(DGIEN,DGENR)&($G(@DGENR@("VDT"))]"")) D
 . S DGRSLT=1
 . ;return only internal values
 . F DGX="IND","STAT","NTR","AVI","SUB","VER","HNC" D
 . . S @DGENR@(DGX)=$P(@DGENR@(DGX),"^")
 Q DGRSLT
 ;
GETSTAT(DGDFN) ;get the screening status
 ;
 ;  Input:
 ;    DGDFN - IEN of patient in the PATIENT (#2) file
 ;
 ;  Output:
 ;    function result - internal value of SCREENING STATUS field (#.03)
 ;
 N DGNT
 I +$G(DGDFN)>0,+$$GETCUR^DGNTAPI(DGDFN,"DGNT")
 Q (+$G(DGNT("STAT")))
 ;
FILEHNC(DGDFN) ;entry point for applications that need to complete the
 ;Head/Neck diagnosis question.  Only file an entry if the Screening
 ;Status is "3" - Pending Diagnosis.
 ;This API is supported by DBIA #3456
 ;
 ;  Input:
 ;    DGDFN - IEN of patient in the PATIENT (#2) file
 ;
 ;  Output:
 ;    function result - "0"-nothing filed, "1"-success
 ;
 N DGNT,DGRSLT
 S DGRSLT=0
 I +$G(DGDFN)>0,+$$GETCUR^DGNTAPI(DGDFN,"DGNT"),+$G(DGNT("STAT"))=3 D
 . S DGNT("HNC")="Y"
 . S DGNT("HDT")=$$NOW^XLFDT
 . S DGNT("HUSR")=DUZ
 . S DGNT("HSIT")=$$SITE^DGNTUT
 . S DGRSLT=$$FILENTR^DGNTAPI(DGDFN,.DGNT,1)
 Q DGRSLT
 ;
VALID(DGIP,DGERR) ;Validate input parameters before filing
 ;  Input
 ;    DGIP - array of input parameters to validate passed by reference
 ;    DGERR - error parameter passed by reference
 ; 
 ;  Output
 ;    function output - 0:invalid, 1:valid
 ;    DGERR - error message
 ;
 N DGVLD   ;function return value
 N DGFXR   ;node name to field xref array
 N DGREQ   ;array of required parameters
 N DGN     ;array node name
 N DGFILE  ;file number
 ;
 S DGVLD=1
 S DGN=""
 S DGFILE=28.11
 ;build field/node xref and required fields array
 D BLDARR(.DGFXR,.DGREQ)
 ;
 D  ;first invalid condition will exit block structure
 . ;check for required parameters
 . F  S DGN=$O(DGREQ(DGN)) Q:DGN=""  I $G(DGIP(DGN))']"" D  Q
 . . S DGVLD=0,DGERR=$$GET1^DID(DGFILE,DGFXR(DGN),,"LABEL")_" REQUIRED"
 . ;quit if any missing required parameters
 . Q:'DGVLD
 . ;check value validity
 . F  S DGN=$O(DGIP(DGN)) Q:DGN=""  I $D(DGFXR(DGN)),'$$TESTVAL(DGFILE,DGFXR(DGN),$P(DGIP(DGN),U)) D  Q
 . . S DGVLD=0,DGERR=$$GET1^DID(DGFILE,DGFXR(DGN),,"LABEL")_" NOT VALID"
 Q DGVLD
 ;
BLDARR(DGFLDA,DGREQA) ;Read in $T(XREF) lines and build name/field xref
 ;array and required fields array.
 ;  Input
 ;    DGFLDA - array name passed by reference
 ;    DGREQA - array name of required fields passed by reference
 ;
 ;  Output
 ;    DGFLDA - field array node xref
 ;    DGREQA - required fields array
 ;
 N DGOFF  ;offset value used with $T
 N DGLINE ;line retrieved by $T(XREF+offset)
 ;
 F DGOFF=1:1 S DGLINE=$T(XREF+DGOFF) Q:DGLINE=""  D
 . S DGFLDA($P(DGLINE,";",3))=$P(DGLINE,";",4)
 . I +$P(DGLINE,";",5) S DGREQA($P(DGLINE,";",3))=""
 Q
 ;
TESTVAL(DGFIL,DGFLD,DGVAL) ;Used to determine if a field value is valid
 ;
 ;  Input
 ;    DGFIL - file number
 ;    DGFLD - field number
 ;    DGVAL - field value to be validated
 ;    
 ;  Output
 ;    Function value:  1:field value is valid, 0:field value is invalid
 ;
 N DGVALEX  ;external value after conversion
 N DGRSLT   ;result of CHK^DIE
 N VALID    ;function result
 ;
 S VALID=1
 I DGVAL'="" D
 . S DGVALEX=$$EXTERNAL^DILFD(DGFIL,DGFLD,"F",DGVAL)
 . I DGVALEX="" S VALID=0 Q
 . ;
 . I $$GET1^DID(DGFIL,DGFLD,"","TYPE")'="POINTER" D
 . . D CHK^DIE(DGFIL,DGFLD,,DGVALEX,.DGRSLT) I DGRSLT="^" S VALID=0 Q
 Q VALID
 ;
XREF ;;array node name;field#;required param;description
 ;;DFN;.01;1;patient IEN
 ;;NTR;.04;1;NTR exposure code
 ;;AVI;.05;0;Military Aviator prior to 1/31/55
 ;;SUB;.06;0;Submarine Training prior to 1/1/65
 ;;EDT;.07;0;Date/Time entered
 ;;EUSR;.08;0;Entered by
 ;;VER;1.01;0;verification method
 ;;VDT;1.02;0;Date/Time verified
 ;;VUSR;1.03;0;verified by
 ;;VSIT;1.04;0;Site verifying Documentation
 ;;HNC;2.01;0;Head/Neck Cancer DX
 ;;HDT;2.02;0;Date/Time diagnosis verified
 ;;HUSR;2.03;0;diagnosis verified by
 ;;HSIT;2.04;0;Site verifying DX
