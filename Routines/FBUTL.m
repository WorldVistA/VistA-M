FBUTL ;WCIOFO/SAB-FEE BASIS UTILITY ;4/8/2004
 ;;3.5;FEE BASIS;**16,78**;JAN 30, 1995
 Q
 ;
AUTH(FBDA,FBCUT) ; FEE Authorization extrinsic function
 ; Determines if the patient has any FEE authorizations on file.
 ; An optional date can be specified to determine if the patient has
 ;   any FEE authorizations in effect on or after the specified date.
 ; input
 ;    FBDA  - patient internal entry number (DFN)
 ;            of the PATIENT (#2) and FEE BASIS PATIENT (#161) file
 ;    FBCUT - (optional) cutoff date (fileman format)
 ;            Default: none
 ;            authorizations with a TO DATE prior to the
 ;            cutoff date (if specified) will not be considered.
 ; returns a value of 1 or 0
 ;   will be true (1) if patient has one or more FEE authorizations
 ;
 N FBDA1,FBRET,FBY0
 S FBCUT=$S($G(FBCUT)?7N:FBCUT,1:"")
 S FBRET=0 ; assume no authorizations will meet criteria
 ; reverse loop thru authorizations - stop when any one meets criteria
 S FBDA1=" " F  S FBDA1=$O(^FBAAA(FBDA,1,FBDA1),-1) Q:'FBDA1  D  Q:FBRET
 . Q:$P($G(^FBAAA(FBDA,1,FBDA1,"ADEL")),U)="Y"  ; ignore Austin Deleted
 . S FBY0=$G(^FBAAA(FBDA,1,FBDA1,0))
 . I FBCUT]"",$P(FBY0,U,2)<FBCUT Q  ; To Date before cutoff date
 . Q:$P(FBY0,U,3)=""  ; FEE Program required
 . ; passed all checks
 . S FBRET=1
 ;
 Q FBRET
 ;
AUTHL(FBDFN,FBSN,FBDT,FBAR) ; authorization list for patient
 ; Integration Agreement #4396
 ; This API returns authorization data for a specified patient.
 ; Authorizations that have been Austin Deleted will not be returned.
 ;
 ; input
 ;   FBDFN - patient DFN (File #2 internal entry number), required
 ;   FBSN  - station number, optional
 ;           If specified, the station number will be used to select
 ;           authorizations from the national Fee Replacement system.
 ;           Only authorizations whose issuing station Starts With this
 ;           parameter value will be returned. 
 ;           This parameter will not be evaluated until the API is
 ;           modified to obtain data from the fee replacement system.
 ;   FBDT  - cutoff date, optional, VA FileMan internal format
 ;           If specified, only authorizations whose To Date is
 ;           equal to or after the cutoff date will be returned.
 ;   FBAR  - name of output array, optional, default value "FBAUTH"
 ;           closed root, must not equal variables newed by this API
 ;           such as FBAR.
 ;           examples: "FBAUTH", "DGAUTH(12)", "^TMP($J)"
 ;           The array will be initialized by this API.
 ; output
 ;   returns string value
 ;     = count of authorizations in array
 ;   OR
 ;     = -1^exception number^exception text
 ;
 ;   If an exception did not occur, then the output array will contain 
 ;   authorization data subscripted by sequential canonic
 ;   numbers and a header node subscripted by 0.
 ;     array(0) = count of authorizations in array
 ;     array(#,"FDT") = authorization # From Date (internal format)
 ;     array(#,"TDT") = authorization # To Date (internal format)
 ;       OR
 ;   Example if "FBAUTH" used as array name
 ;     FBAUTH(0)=2
 ;     FBAUTH(1,"FDT")=3011021
 ;     FBAUTH(1,"TDT")=3011030
 ;     FBAUTH(2,"FDT")=3000101
 ;     FBAUTH(2,"TDT")=3031231
 ;   Note that additional subscripts may be added in the future to
 ;   provide more authorization data. The calling application should
 ;   kill the entire output array so any added subscripts will be
 ;   cleaned-up (e.g. K FBAUTH).
 ;   List of exceptions
 ;     101^Patient DFN not specified.
 ;     104^ICN could not be determined for the specified patient.
 ;     105^Array name conflicts with a variable in the API.
 ;     110^Database Unavailable.
 ;   The database unavailable exception will not occur until this API
 ;   is modified to obtain data from the fee replacement system.
 ;   However, calling applications should code to handle this exception
 ;   now so appropriate action will be taken once the data is moved from
 ;   the local VistA system to the remote fee replacement system.
 ;
 N FBC,FBDA,FBICN,FBRET,FBY
 ;
 S FBAR=$G(FBAR,"FBAUTH")
 S FBSN=$G(FBSN)
 S FBDT=$G(FBDT)
 S FBRET=""
 ;
 ; ensure input array name is not one of the newed variables.
 ; If conflict, then array will not be changed by this API.
 I "^FBDFN^FBAR^FBC^FBDA^FBDT^FBICN^FBRET^FBSN^FBY^"[(U_FBAR_U) S FBRET="-1^105^Array name conflicts with a variable in the API."
 ;
 ; initialize output array
 I FBRET'<0 K @FBAR
 ;
 ; check for required input
 I FBRET'<0,$G(FBDFN)="" S FBRET="-1^101^Patient DFN not specified."
 ;
 ; get patient ICN
 I FBRET'<0 D
 . I $$IFLOCAL^MPIF001(FBDFN) S FBRET="-1^104^ICN could not be determined for the specified patient." Q  ; must not be local ICN
 . S FBICN=$$GETICN^MPIF001(FBDFN) I FBICN<0 S FBRET="-1^104^ICN could not be determined for the specified patient." Q
 ;
 ; if optional date passed then check if valid value
 I FBRET'<0,FBDT'="" D
 . I FBDT'?7N S FBRET="-1^101^Valid date not specified." Q
 . I $$FMTHL7^XLFDT(FBDT)<0 S FBRET="-1^101^Valid date not specified." Q
 ;
 ; get authorization data
 I FBRET'<0 D
 . S FBC=0 ; initialize count/subscript of authorizations in output array
 . ; loop thru AUTHORIZATION multiple of file #161
 . S FBDA=0 F  S FBDA=$O(^FBAAA(FBDFN,1,FBDA)) Q:'FBDA  D
 . . Q:$P($G(^FBAAA(FBDFN,1,FBDA,"ADEL")),U)="Y"  ; skip Austin Deleted
 . . S FBY=$G(^FBAAA(FBDFN,1,FBDA,0))
 . . I FBDT,$P(FBY,U,2)<FBDT Q  ; skip if To Date before optional Cutoff
 . . ; increment count and store authorization data in array
 . . S FBC=FBC+1
 . . S @FBAR@(FBC,"FDT")=$P(FBY,U)
 . . S @FBAR@(FBC,"TDT")=$P(FBY,U,2)
 . ;
 . ; set return value and header node of output array
 . S FBRET=FBC
 . S @FBAR@(0)=FBC
 ;
 Q FBRET
 ;
 ;FBUTL
