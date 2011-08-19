DGPFAA3 ;ALB/RPM - PRF ASSIGNMENT API'S CONTINUED ; 3/28/03
 ;;5.3;Registration;**425,650**;Aug 13, 1993;Build 3
 ;
 Q  ;no direct entry
 ;
NOTIFYDT(DGFLG,DGRDT) ;calculate the notificaton date
 ;
 ;  Input:
 ;    DGFLG - (required) pointer to PRF LOCAL FLAG (#26.11) file or 
 ;            PRF NATIONAL FLAG (#26.15) file
 ;    DGRDT - (required) review date in FM format
 ;
 ;  Output:
 ;   Function Value - notification date in FM format on success, 0 on
 ;                    failure.
 ;
 N DGFLGA   ;flag file data array
 N DGNDT    ;function value
 ;
 S DGNDT=0
 I $G(DGFLG)]"",+$G(DGRDT)>0 D
 . ;
 . ;Retrieve the flag data array
 . Q:'$$GETFLAG^DGPFUT1(DGFLG,.DGFLGA)
 . ;
 . ;must have a review frequency
 . Q:(+$G(DGFLGA("REVFREQ"))=0)
 . ;
 . ;determine notification date
 . S DGFLGA("NOTIDAYS")=$G(DGFLGA("NOTIDAYS"),0)
 . S DGRDT=+$$FMTH^XLFDT(DGRDT)
 . S DGNDT=+$$HTFM^XLFDT(DGRDT-DGFLGA("NOTIDAYS"))
 ;
 Q DGNDT
 ;
GETRDT(DGFLG,DGADT) ;calculate the review date
 ;
 ;  Input:
 ;    DGFLG - (required) pointer to PRF LOCAL FLAG (#26.11) file or 
 ;            PRF NATIONAL FLAG (#26.15) file
 ;    DGADT - (required) assignment date in FM format
 ;
 ;  Output:
 ;   Function Value - review date in FM format on success, 0 on failure
 ;
 N DGFLGA   ;flag file data array
 N DGRDT  ;function value
 ;
 S DGRDT=0
 I $G(DGFLG)]"",+$G(DGADT)>0 D
 . ;
 . ;Retrieve the flag data array
 . Q:'$$GETFLAG^DGPFUT1(DGFLG,.DGFLGA)
 . ;
 . ;must have a review frequency
 . Q:(+$G(DGFLGA("REVFREQ"))=0)
 . ;
 . ;determine review date
 . S DGADT=+$$FMTH^XLFDT(DGADT)
 . S DGRDT=+$$HTFM^XLFDT(DGADT+DGFLGA("REVFREQ"))
 ;
 Q DGRDT
 ;
LOCK(DGAIEN) ;Lock assignment record.
 ;
 ; This function is used to prevent another process from editing a
 ; patient's record flag assignment.
 ;
 ;  Input:
 ;   DGAIEN - IEN of record in the PRF ASSIGNMENT (#26.13) file
 ;
 ; Output:
 ;  Function Value - Returns 1 if the lock was successful, 0 otherwise
 ;
 I $G(DGAIEN) L +^DGPF(26.13,DGAIEN):10
 ;
 Q $T
 ;
UNLOCK(DGAIEN) ;Unlock assignment record.
 ;
 ; This procedure is used to release the lock created by $$LOCK.
 ;
 ;  Input:
 ;   DGAIEN - IEN of record in the PRF ASSIGNMENT (#26.13) file
 ;
 ; Output: None
 ;
 I $G(DGAIEN) L -^DGPF(26.13,DGAIEN)
 ;
 Q
 ;
STOHL7(DGPFA,DGPFAH,DGEROOT) ;store a valid assignment from HL7 message
 ; This function files an assignment if the originating site is 
 ; authorized to update an existing record and if the action is valid for
 ; the status of an existing record. 
 ;
 ;  Input:
 ;    DGPFA - (required) array of assignment values to be filed (see
 ;            $$GETASGN^DGPFAA for valid array structure)
 ;   DGPFAH - (required) array of assignment history values to be filed
 ;            (see $$STOHIST^DGPFAAH for valid array structure)
 ;  DGEROOT - (optional) closed root array name (i.e. "DGERROR") for
 ;            error dialog returned from BLD^DIALOG. If not passed, error
 ;            dialog is returned in ^TMP("DIERR",$J) global.
 ;
 ;  Output:
 ;   Function Value - Returns 1 on sucess, 0 on failure
 ;        DGEROOT() - error output array from BLD^DIALOG
 ;
 N DGDFN
 N DGFLG
 N DGORIG
 N DGACT
 N DGMSG
 N DGRSLT
 N DIERR  ;var returned from BLD^DIALOG
 ;
 S DGDFN=+$G(DGPFA("DFN"))
 S DGFLG=$G(DGPFA("FLAG"))
 S DGORIG=+$G(DGPFA("SNDFAC"))
 S DGACT=+$G(DGPFAH("ACTION"))
 ;
 S DGRSLT=0
 ;
 D  ;drops out of block on failure
 . ;
 . ;check input params
 . I DGDFN'>0 D BLD^DIALOG(261110,,,DGEROOT,"F") Q
 . I DGFLG']"" D BLD^DIALOG(261111,,,DGEROOT,"F") Q
 . I DGORIG'>0 D BLD^DIALOG(261125,,,DGEROOT,"F") Q
 . I DGACT'>0 D BLD^DIALOG(261118,,,DGEROOT,"F") Q
 . ;
 . ;new assignment action
 . I DGACT=1,'$$ADDOK^DGPFAA2(DGDFN,DGFLG,DGEROOT) Q
 . ;
 . ;all other actions
 . I DGACT'=1,'$$HL7EDTOK(DGDFN,DGFLG,DGORIG,DGACT,DGEROOT) Q
 . ;
 . ;file the assignment and history
 . I '$$STOALL^DGPFAA(.DGPFA,.DGPFAH,.DGMSG)!($D(DGMSG)) D  Q
 . . D BLD^DIALOG(261120,,,DGEROOT,"F")
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
 ;
HL7EDTOK(DGDFN,DGFLG,DGORIG,DGACT,DGEROOT) ;Is site allowed to edit assignment?
 ; This function acts as wrapper for $$EDTOK and $$ACTIONOK for edits
 ; that originate from PRF HL7 message processing.
 ;
 ;  Supported DBIA #2171:  This DBIA is used to access the KERNEL
 ;                         INSTITUTION (#4) file API PARENT^XUAF4.
 ;
 ;  Input:
 ;    DGDFN - IEN of patient in PATIENT (#2) file
 ;    DGFLG - IEN of patient record flag in PRF NATIONAL FLAG (#26.15)
 ;            file or PRF LOCAL FLAG (#26.11) file. [ex: "1;DGPF(26.15,"]
 ;   DGORIG - IEN of originating site in INSTITUTION (#4) file
 ;    DGACT - Assignment edit action in internal format
 ;            [1:NEW ASSIGNMENT,2:CONTINUE,3:INACTIVATE,4:REACTIVATE,5:ENTERED IN ERROR]
 ;  DGEROOT - (optional) closed root array name (i.e. "DGERROR") for
 ;            error dialog returned from BLD^DIALOG. If not passed, error
 ;            dialog is returned in ^TMP("DIERR",$J) global.
 ;
 ;  Output:
 ;   Function value - 1 if authorized, 0 if not authorized
 ;          DGEROOT() - error output array from BLD^DIALOG
 ;
 N DGIEN    ;pointer to PRF ASSIGNMENT (#26.13) file
 N DGPFA    ;assignment data array
 N DGFARRY  ;flag data array
 N DGOWNER  ;IEN of owner site in INSTITUTION (#4) file
 N DGRSLT   ;function value
 N DIERR    ;var returned from BLD^DIALOG
 ;
 ;init error output array if passed
 S DGEROOT=$G(DGEROOT)
 I DGEROOT]"" K @DGEROOT
 ;
 S DGACT=+$G(DGACT)
 S DGDFN=+$G(DGDFN)
 S DGFLG=$G(DGFLG)
 S DGORIG=+$G(DGORIG)
 S DGRSLT=0
 ;
 D  ;drops out of block on failure
 . ;
 . ;check input params
 . I DGDFN'>0 D BLD^DIALOG(261110,,,DGEROOT,"F") Q
 . I DGACT'>0 D BLD^DIALOG(261118,,,DGEROOT,"F") Q
 . I DGORIG'>0 D BLD^DIALOG(261125,,,DGEROOT,"F") Q
 . I DGFLG']"" D BLD^DIALOG(261111,,,DGEROOT,"F") Q
 . ;
 . ;retrieve existing assignment data
 . S DGIEN=$$FNDASGN^DGPFAA(DGDFN,DGFLG)
 . I '$$GETASGN^DGPFAA(DGIEN,.DGPFA) D  Q
 . . D BLD^DIALOG(261102,,,DGEROOT,"F")
 . ;
 . ;SENDING FACILITY be the OWNER or parent of the OWNER
 . S DGOWNER=+$G(DGPFA("OWNER"))
 . I DGORIG'=DGOWNER,DGORIG'=+$$PARENT^DGPFUT1(DGOWNER) D  Q
 . . D BLD^DIALOG(261116,,,DGEROOT,"F")
 . ;
 . ;quit if flag STATUS is INACTIVE
 . I $$GETFLAG^DGPFUT1($P($G(DGPFA("FLAG")),U),.DGFARRY)
 . I '+$G(DGFARRY("STAT")) D  Q
 . . D BLD^DIALOG(261113,,,DGEROOT,"F")
 . ;
 . ;quit if no TIU PN TITLE IEN is found for the record flag
 . I '+$P($G(DGFARRY("TIUTITLE")),U) D  Q
 . . D BLD^DIALOG(261114,,,DGEROOT,"F")
 . ;
 . ;ACTION must be valid for current assignment STATUS
 . Q:('$$ACTIONOK^DGPFAA2(.DGPFA,DGACT,DGEROOT))
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
