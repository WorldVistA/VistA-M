DGNTAPI ;ALB/RPM - API's for N/T Radium Treatments ; 8/24/01 3:49pm
 ;;5.3;Registration;**397,423**;Aug 13, 1993
 Q
 ;
 ;
GETPRIM(DFN) ; Used to get the patient's primary record in the (#28.11) file.
 ;
 ;  Input:
 ;   DFN - IEN of patient in the PATIENT (#2) file
 ;
 ; Output:
 ;   Function Value - If successful, returns IEN of record in (#28.11) file, otherwise returns null on failure.
 ;
 Q:'$G(DFN) ""
 Q $O(^DGNT(28.11,"APR",DFN,1,0))
 ;
 ;
GETREC(DGIEN,DGNTAPA) ;  Used to obtain a record in the (#28.11) file.
 ;
 ;  Input:
 ;   DGIEN - IEN of record in the (#28.11) file
 ;   DGNTAPA - Array name of return values [Optional - Default DGNTARR]
 ;
 ; Output:
 ;  Function Value: Returns 1 on success, 0 on failure.
 ;  DGNTAPA() array, passed by reference.  If the function is successful
 ;  this array will contain the record.
 ;
 ;    subscript   field name
 ;    ---------   ----------
 ;    "DFN"       Patient
 ;    "IND"       NTR Indicator - internal^external
 ;    "STAT"      Screening Status - internal^external
 ;    "NTR"       NTR Treatment - internal^external
 ;    "AVI"       Military Aviator Pre 1/31/1955 - internal^external
 ;    "SUB"       Submarine Training Pre 1/1/65 - internal^external
 ;    "EDT"       Date/Time NTR Entered
 ;    "EUSR"      NTR Entered By
 ;    "PRIM"      NTR Primary Entry
 ;    "SUPER"     Date/Time Superseded
 ;    "VER"       Verification Method - internal^external
 ;    "VDT"       Date/Time Verified
 ;    "VUSR"      Verified By
 ;    "VSIT"      Site Verifying Documentation
 ;    "HNC"       Head/Neck CA DX - internal^external
 ;    "HDT"       Date/Time DX Verified
 ;    "HUSR"      DX Verified By
 ;    "HSIT"      Site Verifying DX
 ;
 N DGFDA,DGMSG
 ;
 I '$G(DGIEN) Q 0
 I '$D(^DGNT(28.11,DGIEN,0)) Q 0
 ;
 S DGNTAPA=$G(DGNTAPA)
 I DGNTAPA']"" S DGNTAPA="DGNTARR"
 ;
 ; Obtain record
 D GETS^DIQ(28.11,DGIEN_",","*","IE","DGFDA","DGMSG")
 S @DGNTAPA@("DFN")=$G(DGFDA(28.11,+DGIEN_",",.01,"I"))
 S @DGNTAPA@("IND")=$G(DGFDA(28.11,+DGIEN_",",.02,"I"))_"^"_$G(DGFDA(28.11,+DGIEN_",",.02,"E"))
 S @DGNTAPA@("STAT")=$G(DGFDA(28.11,+DGIEN_",",.03,"I"))_"^"_$G(DGFDA(28.11,+DGIEN_",",.03,"E"))
 S @DGNTAPA@("NTR")=$G(DGFDA(28.11,+DGIEN_",",.04,"I"))_"^"_$G(DGFDA(28.11,+DGIEN_",",.04,"E"))
 S @DGNTAPA@("AVI")=$G(DGFDA(28.11,+DGIEN_",",.05,"I"))_"^"_$G(DGFDA(28.11,+DGIEN_",",.05,"E"))
 S @DGNTAPA@("SUB")=$G(DGFDA(28.11,+DGIEN_",",.06,"I"))_"^"_$G(DGFDA(28.11,+DGIEN_",",.06,"E"))
 S @DGNTAPA@("EDT")=$G(DGFDA(28.11,+DGIEN_",",.07,"I"))
 S @DGNTAPA@("EUSR")=$G(DGFDA(28.11,+DGIEN_",",.08,"I"))
 S @DGNTAPA@("PRIM")=$G(DGFDA(28.11,+DGIEN_",",.09,"I"))
 S @DGNTAPA@("SUPER")=$G(DGFDA(28.11,+DGIEN_",",.1,"I"))
 S @DGNTAPA@("VER")=$G(DGFDA(28.11,+DGIEN_",",1.01,"I"))_"^"_$G(DGFDA(28.11,+DGIEN_",",1.01,"E"))
 S @DGNTAPA@("VDT")=$G(DGFDA(28.11,+DGIEN_",",1.02,"I"))
 S @DGNTAPA@("VUSR")=$G(DGFDA(28.11,+DGIEN_",",1.03,"I"))
 S @DGNTAPA@("VSIT")=$G(DGFDA(28.11,+DGIEN_",",1.04,"I"))
 S @DGNTAPA@("HNC")=$G(DGFDA(28.11,+DGIEN_",",2.01,"I"))_"^"_$G(DGFDA(28.11,+DGIEN_",",2.01,"E"))
 S @DGNTAPA@("HDT")=$G(DGFDA(28.11,+DGIEN_",",2.02,"I"))
 S @DGNTAPA@("HUSR")=$G(DGFDA(28.11,+DGIEN_",",2.03,"I"))
 S @DGNTAPA@("HSIT")=$G(DGFDA(28.11,+DGIEN_",",2.04,"I"))
 ;
 Q 1
 ;
GETCUR(DGDFN,DGNTAPIA) ; Retrieve current record
 ;This is a supported API (DBIA #3457)
 ;  Input:
 ;   DGDFN - IEN of patient in the PATIENT (#2) file
 ;   DGNTAPIA - Array name of return values [Optional - Default DGNTARR]
 ;
 ;  Output:
 ;    function result - IEN of current NTR HISTORY file (#28.11) record.
 ;    DGNTAPIA - Array of current NTR HISTORY file record field values.
 ;            See $$GETREC for documentation.
 ;            The node, "INTRP", a calculated free text intrepretation
 ;            is added to the array.
 ;
 N DGIEN
 ;
 I '$G(DGDFN) Q 0
 ;
 S DGNTAPIA=$G(DGNTAPIA)
 I DGNTAPIA']"" S DGNTAPIA="DGNTARR"
 ;
 S DGIEN=+$$GETPRIM(DGDFN)
 I $$GETREC(DGIEN,DGNTAPIA) D
 . S @DGNTAPIA@("INTRP")=$$INTERP^DGNTUT(DGNTAPIA)
 Q DGIEN
 ;
FILENTR(DFN,DGNUPD,DGXMIT) ; NTR HISTORY (#28.11) filer
 ; Callpoint to create a new NTR HISTORY FILE (#28.11) entry.
 ; Will also queue HL7 message for HEC database updates.
 ;
 ;  Input
 ;    DFN    - Patients DFN
 ;    DGNUPD - question response array
 ;      "NTR"  - NTR exposure code
 ;      "AVI"  - Military Aviator prior to 1/31/55
 ;      "SUB"  - Submarine Training prior to 1/1/65
 ;      "EDT"  - Date/Time entered
 ;      "EUSR" - Entered by
 ;      "VER"  - verification method
 ;      "VDT"  - Date/Time verified
 ;      "VUSR" - verified by
 ;      "VSIT" - Site verifying Documentation
 ;      "HNC"  - Head/Neck Cancer DX
 ;      "HDT"  - Date/Time diagnosis verified
 ;      "HUSR" - diagnosis verified by
 ;      "HSIT" - Site verifying DX
 ;    DGXMIT - flag to transmit update to the HEC
 ;             "0" - don't transmit, "1" - transmit [default]
 ;
 ;  Output
 ;    DGRSLT - Returns IEN of file (#28.11) entry if successful
 ;
 ;    If an error occurred during parameter validation, then:
 ;       DGRSLT = 0^Error Description
 ;
 ;    If an error occured during filing, then:
 ;       DGRSLT = 0^Error Code IEN
 ;                   (returned by UPDATE^DIE call)
 ;
 N DGRSLT,DGFDA,DGNERR
 S DFN=+$G(DFN)
 S DGXMIT=$S($G(DGXMIT)=0:0,1:1)
 S DGRSLT=0
 ;
 I DFN>0,$D(DGNUPD) D
 . S DGNUPD("DFN")=DFN
 . ;validate the input array parameter
 . I '$$VALID^DGNTAPI1(.DGNUPD,.DGNERR) D  Q
 . . S DGRSLT="0^"_$G(DGNERR)
 . I $$BLDFDA(DFN,.DGNUPD,.DGFDA) S DGRSLT=$$NEWNTR(.DGFDA)
 . Q:'DGRSLT
 . ;queue message to the HEC
 . I DGXMIT D AUTOUPD^DGENA2(DFN)
 ;
 Q DGRSLT
 ;
BLDFDA(DFN,DGNTUPD,DGBFDA) ;
 ;Build the field desription array
 ;  Input
 ;    DFN    - Patients DFN
 ;    DGNTUPD - question response array - refer to $$FILENTR
 ;    DGBFDA  - FDA name passed by reference
 ;
 ;  Output
 ;    DGBFDA - field array built by reference
 ;    DGRSLT - function return
 ;               1 - successful build
 ;               0 - nothing built
 ;
 N DGSTAT  ;screening status internal code
 N DGIENS  ;IENS string
 N DGRSLT  ;did anything get built
 ;
 S DGIENS="+1,"
 S DGRSLT=0
 S DGBFDA(28.11,DGIENS,.01)=DFN
 S DGBFDA(28.11,DGIENS,.04)=$P(DGNTUPD("NTR"),"^")
 S DGBFDA(28.11,DGIENS,.05)=$P(DGNTUPD("AVI"),"^")
 S DGBFDA(28.11,DGIENS,.06)=$P(DGNTUPD("SUB"),"^")
 S DGBFDA(28.11,DGIENS,.07)=$G(DGNTUPD("EDT"))
 S DGBFDA(28.11,DGIENS,.08)=$G(DGNTUPD("EUSR"))
 S DGBFDA(28.11,DGIENS,1.01)=$P(DGNTUPD("VER"),"^")
 S DGBFDA(28.11,DGIENS,1.02)=$G(DGNTUPD("VDT"))
 S DGBFDA(28.11,DGIENS,1.03)=$G(DGNTUPD("VUSR"))
 S DGBFDA(28.11,DGIENS,1.04)=$G(DGNTUPD("VSIT"))
 S DGBFDA(28.11,DGIENS,2.01)=$P(DGNTUPD("HNC"),"^")
 S DGBFDA(28.11,DGIENS,2.02)=$G(DGNTUPD("HDT"))
 S DGBFDA(28.11,DGIENS,2.03)=$G(DGNTUPD("HUSR"))
 S DGBFDA(28.11,DGIENS,2.04)=$G(DGNTUPD("HSIT"))
 ;indicator and status
 S DGSTAT=$$STATUS^DGNTUT(.DGNTUPD)  ;determine pending/verified status
 S DGBFDA(28.11,DGIENS,.02)=$S(DGSTAT=4!(DGSTAT=5):"Y",1:"N")
 S DGBFDA(28.11,DGIENS,.03)=DGSTAT
 S DGBFDA(28.11,DGIENS,.09)=1
 Q 1
 ;
NEWNTR(DGNFDA) ;Create new record
 ;  Input
 ;    DGNFDA - Field description array
 ;
 ;  Output
 ;    DGRSLT - 1=success
 ;             0=failed
 ;
 N DGERR,DGRSLT,DGNTIEN
 D UPDATE^DIE("","DGNFDA","DGNTIEN","DGERR")
 S DGRSLT=+$G(DGNTIEN(1))
 I $D(DGERR) D
 . S DGRSLT="0^"_$G(DGERR("DIERR",1))
 Q DGRSLT
 ;
 ;
UPDNTR(DGUFDA) ;Update existing record
 ;  Input
 ;    DGUFDA - Field description array
 ;
 ;  Output
 ;    DGRSLT - 1=success
 ;             0=failed
 ;
 N DGERR,DGRSLT
 S DGRSLT=0
 D FILE^DIE("K","DGUFDA","DGERR")
 I '$D(DGERR) S DGRSLT=1
 Q DGRSLT
