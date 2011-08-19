MAGGNTI3 ;WOIFO/GEK - Imaging interface to TIU. RPC Calls etc. ; 04 Apr 2002  2:37 PM
 ;;3.0;IMAGING;**46,59**;Nov 27, 2007;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;      
 Q
MOD(MAGRY,MAGDFN,MAGTIUDA,MAGADCL,MAGMODE,MAGES,MAGESBY,MAGTEXT) ; RPC [MAG3 TIU MODIFY NOTE]
 ;  RPC call to Modify an Existing Note by: 
 ;           Electronically Signing or
 ;           Administratively Closing the Note
 ;
 ;  - - -  Required  - - - 
 ;  MAGDFN   - Patient DFN
 ;  MAGTIUDA - IEN of TIU NOTE in file 8925
 ;  - - -  Optional  - - - 
 ;  MAGADCL  - 1 = Mark this Note as Administratively Closed
 ;  MAGMODE  - Mode of Admin Closure: "S" = Scanned Document "M" = Manual closure
 ;  MAGES    - The encrypted Electronic Signature
 ;  MAGESBY  - The DUZ of the Signer (Defaults to DUZ)
 ;  MAGTEXT  - Array of Text to add to the New Note. // NOT USED IN 3.0.59
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^"_$T(+0)
 S MAGDFN=$G(MAGDFN),MAGTIUDA=$G(MAGTIUDA)
 S MAGES=$G(MAGES),MAGADCL=$G(MAGADCL)
 S MAGESBY=$S($G(MAGESBY):MAGESBY,1:DUZ)
 S MAGMODE=$S($L($G(MAGMODE)):MAGMODE,1:"S")
 I '$$VALDATA^MAGGNTI2(.MAGRY,MAGDFN,MAGTIUDA) Q
 N MAGXT,I,CT,MAGMRC,X
 S CT=1,I=""
 ; We don't allow Editing/Adding of Text to an existing document.
 ; If Change Status to Admin Close. Then we Quit
 S MAGRY="1^"
 I MAGADCL="1" D  Q:'MAGRY
 . D ADMNCLOS^MAGGNTI2(.MAGTY,MAGDFN,MAGTIUDA,MAGMODE)
 . S MAGRY=$S('MAGTY:MAGTY,1:MAGRY_"Note is Administratively Closed.")
 . S ^TMP($J,"MAGGNTI1","MOD AFTER ADMNCLOS ")=MAGRY
 . Q:'MAGRY
 . ; Note has been E-Filed  Complete the Consult if one is attached.
 . D GET1405^TIUSRVR(.MAGMRC,MAGTIUDA)
 . S ^TMP($J,"MAGGNTI1","MOD MAGMRC")=$G(MAGMRC)
 . I (+MAGMRC>0)&(MAGMRC["GMR(123") D
 . . ;Use GRMC Call to 'Close' the consult. For AdminClos the Consult Status
 . . ;went from 'p' to 'pr'  this will change it to 'c' (complete).        
 . . S X=$$SFILE^GMRCGUIB(+MAGMRC,10)
 . . Q
 . Q
 ;
 ; if caller sent esignature to Sign this Addendum.
 I $L(MAGES) D  Q:'MAGRY
 . D SIGN(.MAGTY,MAGDFN,MAGTIUDA,MAGES,MAGESBY)
 . S MAGRY=$S('MAGTY:MAGTY,1:MAGRY_"Note is Signed.")
 . Q
 Q
SIGN(MAGRY,MAGDFN,MAGTIUDA,MAGES,MAGESBY) ;RPC [MAG3 TIU SIGN RECORD]
 ; RPC Call to 'Sign' a Note.  
 ; - - - Required - - - 
 ; MAGDFN    - DFN of Patient.
 ; MAGTIUDA  - TIUDA - IEN of TIU Note file 8925
 ; MAGES     - The encrypted Electronic Signature
 ; MAGESBY   - The DUZ of the Signer (Defaults to DUZ)
 ; 
 N RY
 S MAGDFN=$G(MAGDFN),MAGTIUDA=$G(MAGTIUDA),MAGES=$G(MAGES),MAGESBY=$G(MAGESBY,DUZ)
 I '$$VALDATA^MAGGNTI2(.MAGRY,MAGDFN,MAGTIUDA) Q
 ;
 ; Calling TIU SIGN RECORD
 D SIGN^TIUSRVP(.RY,MAGTIUDA,MAGES)
 ;   on success   RY = 0
 ;   on error RY = error code ^ < message >
 I +RY S MAGRY="0^"_$TR(RY,"^","~")
 E  S MAGRY="1^Success: Note has been Signed."
 Q
ERR ; ERROR TRAP
 N ERR S ERR=$$EC^%ZOSV
 S MAGRY="0^ETRAP: "_ERR
 D @^%ZOSF("ERRTN")
 Q
