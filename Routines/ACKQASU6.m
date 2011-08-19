ACKQASU6 ;HCIOFO/AG - New/Edit Visit Utilities  ;  04/01/99
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;
SETPRIM(ACKVIEN,ACKQPRV) ; add primary provider to A&SP Clinic Visit
 ; inputs: ACKVIEN - A&SP visit ien
 ;         ACKQPRV - provider ien from Quasar or null 
 ; outputs: 1^ - everything ok
 ;          0^xxxxxxx - update failed (reason=xxxxxx)
 ; NB. This function checks the visit date for the visit against the 
 ; activation and inactivation dates for the Provider. it therefore
 ; assumes that the visit date has already been filed.
 N ACKPRIM,ACKPRVN,ACKARR,ACKVD,ACKPACT,ACKPINA,ACKSTAT
 S ACKPRIM=""   ; return string
 ;
 S ACKPRVN=ACKQPRV
 ;
 ; if not found then set error message and exit
 I 'ACKPRVN D  G SETPRIMX
 . S ACKPRIM="0^Provider not defined for Audiology and Speech Pathology"
 ;
 ; if defined get status (clinician/fee basis/other provider/student)
 S ACKSTAT=$$GET1^DIQ(509850.3,ACKPRVN_",",.02,"I")
 ;
 ; if not a clinician or fee basis then not allowed as primary provider
 I ACKSTAT'="C",ACKSTAT'="F" D  G SETPRIMX
 . S ACKPRIM="0^Primary Provider must be a Clinician or Fee Basis Clinician"
 ;
 ; get the visit date and the provider activation/inactivation dates
 S ACKVD=$$GET1^DIQ(509850.6,ACKVIEN_",",.01,"I")
 S ACKPACT=$$GET1^DIQ(509850.3,ACKPRVN_",",.03,"I")
 S ACKPINA=$$GET1^DIQ(509850.3,ACKPRVN_",",.04,"I")
 ;
 ; if the provider is not active then set error and exit
 I (ACKPACT="")!(ACKPACT>ACKVD) D  G SETPRIMX
 . S ACKPRIM="0^Provider not Active on the Visit Date"
 ;
 ; if the provider is inactive then set error and exit
 I ACKPINA'="",ACKPINA<ACKVD D  G SETPRIMX
 . S ACKPRIM="0^Provider made Inactive prior to the Visit Date"
 ;
 ; all ok, then add the provider to the visit
 S ACKARR(509850.6,ACKVIEN_",",6)=ACKPRVN
 D FILE^DIE("","ACKARR","")
 S ACKPRIM="1^"  ; set return flag to OK
 ;
SETPRIMX ; exit point
 Q ACKPRIM
 ;
SETSCND(ACKVIEN,ACKQPRV) ; add secondary provider to A&SP Clinic Visit
 ; inputs: ACKVIEN - A&SP visit ien
 ;         ACKQPRV - provider ien from Quasar file or null
 ; outputs: 1^ - everything ok
 ;          0^xxxxxxx - update failed (reason=xxxxxx)
 ; NB. This function checks the visit date for the visit against the 
 ; activation and inactivation dates for the Provider. it therefore
 ; assumes that the visit date has already been filed.
 N ACKSCND,ACKPRVN,ACKARR,ACKVD,ACKPACT,ACKPINA,ACKSTAT
 S ACKSCND=""   ; return string
 ;
 S ACKPRVN=ACKQPRV
 ;
 ; if not found then set error message and exit
 I 'ACKPRVN D  G SETSCNDX
 . S ACKSCND="0^Provider not defined for Audiology and Speech Pathology"
 ;
 ; if found, get status (clinician/fee basis/other provider/student)
 S ACKSTAT=$$GET1^DIQ(509850.3,ACKPRVN_",",.02,"I")
 ;
 ; if not a clinician, fee basis or other provider then not allowed as second provider
 I ACKSTAT'="C",ACKSTAT'="F",ACKSTAT'="O" D  G SETSCNDX
 . S ACKSCND="0^Secondary Provider must be a Clinician, Fee Basis or Other Provider"
 ;
 ; get the visit date and the provider activation/inactivation dates
 S ACKVD=$$GET1^DIQ(509850.6,ACKVIEN_",",.01,"I")
 S ACKPACT=$$GET1^DIQ(509850.3,ACKPRVN_",",.03,"I")
 S ACKPINA=$$GET1^DIQ(509850.3,ACKPRVN_",",.04,"I")
 ;
 ; if the provider is not active then set error and exit
 I (ACKPACT="")!(ACKPACT>ACKVD) D  G SETSCNDX
 . S ACKSCND="0^Provider not Active on the Visit Date"
 ;
 ; if the provider is inactive then set error and exit
 I ACKPINA'="",ACKPINA<ACKVD D  G SETSCNDX
 . S ACKSCND="0^Provider made Inactive prior to the Visit Date"
 ;
 ; all ok, then add the provider to the visit
 S ACKARR(509850.66,"+1,"_ACKVIEN_",",.01)=ACKPRVN
 D UPDATE^DIE("","ACKARR","","")
 S ACKSCND="1^"  ; set return flag to OK
 ;
SETSCNDX ; exit point
 Q ACKSCND
 ;
SETSTUD(ACKVIEN,ACKQPRV) ; add student to A&SP Clinic Visit
 ; inputs: ACKVIEN - A&SP visit ien
 ;         ACKQPRV - provider ien from Quasar file or null
 ; outputs: 1^ - everything ok
 ;          0^xxxxxxx - update failed (reason=xxxxxx)
 ; NB. This function checks the visit date for the visit against the 
 ; activation and inactivation dates for the Provider. it therefore
 ; assumes that the visit date has already been filed.
 N ACKSTUD,ACKPRVN,ACKARR,ACKVD,ACKPACT,ACKPINA,ACKSTAT
 S ACKSTUD=""   ; return string
 ;
 S ACKPRVN=ACKQPRV
 ;
 ; if not found then set error message and exit
 I 'ACKPRVN D  G SETSTUDX
 . S ACKSTUD="0^Provider not defined for Audiology and Speech Pathology"
 ;
 ; if found, get status (clinician/fee basis/other provider/student)
 S ACKSTAT=$$GET1^DIQ(509850.3,ACKPRVN_",",.02,"I")
 ;
 ; if not a student then set error message and quit
 I ACKSTAT'="S" D  G SETSTUDX
 . S ACKSTUD="0^Provider must be defined as a Student in the A&SP Staff File."
 ;
 ; get the visit date and the provider activation/inactivation dates
 S ACKVD=$$GET1^DIQ(509850.6,ACKVIEN_",",.01,"I")
 S ACKPACT=$$GET1^DIQ(509850.3,ACKPRVN_",",.03,"I")
 S ACKPINA=$$GET1^DIQ(509850.3,ACKPRVN_",",.04,"I")
 ;
 ; if the provider is not active then set error and exit
 I (ACKPACT="")!(ACKPACT>ACKVD) D  G SETSTUDX
 . S ACKSTUD="0^Provider not Active on the Visit Date"
 ;
 ; if the provider is inactive then set error and exit
 I ACKPINA'="",ACKPINA<ACKVD D  G SETSTUDX
 . S ACKSTUD="0^Provider made Inactive prior to the Visit Date"
 ;
 ; all ok, then add the provider to the visit
 S ACKARR(509850.6,ACKVIEN_",",7)=ACKPRVN
 D FILE^DIE("","ACKARR","")
 S ACKSTUD="1^"  ; set return flag to OK
 ;
SETSTUDX ; exit point
 Q ACKSTUD
 ;
