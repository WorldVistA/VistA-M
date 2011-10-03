DGPFAA2 ;ALB/KCL - PRF ASSIGNMENT API'S CONTINUED ; 3/22/05
 ;;5.3;Registration;**425,554,650**;Aug 13, 1993;Build 3
 ;
 ;no direct entry
 QUIT
 ;
ADDOK(DGDFN,DGFLG,DGEROOT) ;This function will be used to determine if a flag may be assigned to a patient.
 ;
 ;  Input:
 ;   DGDFN - (required) IEN of patient in PATIENT (#2) file
 ;   DGFLG - (required) IEN of patient record flag in PRF NATIONAL
 ;           FLAG (#26.15) file or PRF LOCAL FLAG (#26.11) file
 ;           [ex: "1;DGPF(26.15,"]
 ; DGEROOT - (optional) closed root array name (i.e. "DGERROR") for error
 ;           dialog returned from BLD^DIALOG.  If not passed, error
 ;           dialog is returned in ^TMP("DIERR",$J) global.
 ;
 ; Output:
 ;  Function Value - returns 1 on success, 0 on failure
 ;       DGEROOT() - error output array from BLD^DIALOG
 ;
 N DGRSLT   ;function result
 N DGFARRY  ;contains flag array
 K DGFARRY
 N DIERR    ;var returned from BLD^DIALOG
 ;
 ;init error output array if passed
 S DGEROOT=$G(DGEROOT)
 I DGEROOT]"" K @DGEROOT
 ;
 S DGRSLT=0
 ;
 D  ;drops out of block on failure
 . ;
 . ;quit if DFN invalid
 . I '$G(DGDFN)!'$D(^DPT(+$G(DGDFN),0)) D  Q
 . . D BLD^DIALOG(261110,,,DGEROOT,"F")
 . ;
 . ;quit if flag ien invalid
 . I '$$TESTVAL^DGPFUT(26.13,.02,DGFLG) D  Q
 . . D BLD^DIALOG(261111,,,DGEROOT,"F")
 . ;
 . ;quit if flag already assigned to patient
 . I $$FNDASGN^DGPFAA(DGDFN,DGFLG) D  Q
 . . D BLD^DIALOG(261112,,,DGEROOT,"F")
 . ;
 . ;quit if flag STATUS is INACTIVE
 . I $$GETFLAG^DGPFUT1(DGFLG,.DGFARRY),('+$G(DGFARRY("STAT"))) D  Q
 . . D BLD^DIALOG(261113,,,DGEROOT,"F")
 . ;
 . ;quit if no TIU PN TITLE IEN is found for the record flag
 . I '+$P($G(DGFARRY("TIUTITLE")),U) D  Q
 . . D BLD^DIALOG(261114,,,DGEROOT,"F")
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
 ;
EDTOK(DGPFA,DGORIG,DGEROOT) ;This function will be used to determine if a flag assignment may be edited.
 ;
 ;  Input:
 ;    DGPFA - (required) array containing the flag assignment values
 ;   DGORIG - (optional) originating site [default = +$$SITE^VASITE()] 
 ;  DGEROOT - (optional) closed root array name (i.e. "DGERROR") for
 ;            error dialog returned from BLD^DIALOG.  If not passed,
 ;            error dialog is returned in ^TMP("DIERR",$J) global.
 ;
 ; Output:
 ;  Function Value - returns 1 on success, 0 on failure
 ;       DGEROOT() - error output array from BLD^DIALOG
 ;
 N DGRSLT   ;function result
 N DGFARRY  ;contains flag array
 K DGFARRY
 N DIERR    ;var returned from BLD^DIALOG
 ;
 ;init error output array if passed
 S DGEROOT=$G(DGEROOT)
 I DGEROOT]"" K @DGEROOT
 ;
 S DGRSLT=0
 ;
 D  ;drops out of block on failure
 . ;
 . ;quit if current site is not the owner site
 . I +$G(DGORIG)'>0 S DGORIG=+$$SITE^VASITE()
 . I +$G(DGPFA("OWNER"))'=DGORIG D  Q
 . . D BLD^DIALOG(261115,,,DGEROOT,"F")
 . ;
 . ;quit if flag STATUS is INACTIVE
 . I $$GETFLAG^DGPFUT1($P($G(DGPFA("FLAG")),U),.DGFARRY)
 . I '+$G(DGFARRY("STAT")) D  Q
 . . D BLD^DIALOG(261113,,,DGEROOT,"F")
 . ;
 . ;quit if no TIU PN TITLE is found for the record flag
 . I '+$P($G(DGFARRY("TIUTITLE")),U) D  Q
 . . D BLD^DIALOG(261114,,,DGEROOT,"F")
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
 ;
ACTIONOK(DGPFA,DGACT,DGEROOT) ;This function will be used to verify that an assignment edit ACTION is appropriate for the current assignment STATUS.
 ;
 ;  Input:
 ;    DGPFA - (required) assignment array data from current record
 ;    DGACT - Assignment edit action in internal format
 ;            [1:NEW ASSIGNMENT,2:CONTINUE,3:INACTIVATE,4:REACTIVATE,5:ENTERED IN ERROR]
 ; DGEROOT - (optional) closed root array name (i.e. "DGERROR") for
 ;           error dialog returned from BLD^DIALOG. If not passed, error
 ;           dialog is returned in ^TMP("DIERR",$J) global.
 ;
 ; Output:
 ;  Function Value - returns 1 on success, 0 on failure
 ;         DGEROOT() - error output array from BLD^DIALOG
 ;
 N DGRSLT   ;function result
 N DGSTAT   ;current assignment status
 N DIERR    ;var returned from BLD^DIALOG
 ;
 ;init error output array if passed
 S DGEROOT=$G(DGEROOT)
 I DGEROOT]"" K @DGEROOT
 ;
 S DGACT=+$G(DGACT)
 S DGSTAT=$P($G(DGPFA("STATUS")),U,1)
 S DGRSLT=0
 ;
 D  ;drops out of block on failure
 . ;
 . ;is ACTION valid?
 . I '$$TESTVAL^DGPFUT(26.14,.03,DGACT),'DGSTAT?1N D  Q
 . . D BLD^DIALOG(261118,,,DGEROOT,"F")
 . ;
 . ;must not CONTINUE inactive assignments
 . I DGACT=2,DGSTAT=0 D  Q
 . . D BLD^DIALOG(261121,,,DGEROOT,"F")
 . ;
 . ;must not INACTIVATE inactive assignments
 . I DGACT=3,DGSTAT=0 D  Q
 . . D BLD^DIALOG(261122,,,DGEROOT,"F")
 . ;
 . ;must not ENTERED IN ERROR inactive assignments
 . I DGACT=5,DGSTAT=0 D  Q
 . . D BLD^DIALOG(261123,,,DGEROOT,"F")
 . ;
 . ;must not REACTIVATE active assignments
 . I DGACT=4,DGSTAT=1 D  Q
 . . D BLD^DIALOG(261124,,,DGEROOT,"F")
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
 ;
CHGOWN(DGPFA,DGORIG,DGEROOT) ;This function is used to determine if a site is allowed to change ownership of a record flag assignment?
 ;
 ;  Input:
 ;    DGPFA - (required) array containing the flag assignment values
 ;   DGORIG - (optional) originating site [default = +$$SITE^VASITE()] 
 ;  DGEROOT - (optional) closed root array name (i.e. "DGERROR") for
 ;            error dialog returned from BLD^DIALOG.  If not passed,
 ;            error dialog is returned in ^TMP("DIERR",$J) global.
 ;
 ; Output:
 ;  Function Value - returns 1 on success, 0 on failure
 ;       DGEROOT() - error output array from BLD^DIALOG
 ;
 N DGRSLT   ;function result
 N DIERR    ;var returned from BLD^DIALOG
 ;
 ;init error output array if passed
 S DGEROOT=$G(DGEROOT)
 I DGEROOT]"" K @DGEROOT
 ;
 S:(+$G(DGORIG)'>0) DGORIG=(+$$SITE^VASITE())
 S DGRSLT=0
 ;
 D  ;drops out of block on failure
 . ;
 . ;ORIGINATING SITE must be OWNER and flag must be ACTIVE
 . Q:('$$EDTOK(.DGPFA,DGORIG,.DGEROOT))
 . ;
 . ;can't CHANGE OWNERSHIP for an INACTIVE assignment
 . I '+$G(DGPFA("STATUS")) D  Q
 . . D BLD^DIALOG(261117,,,DGEROOT,"F")
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
 ;
ROLLBACK(DGAIEN,DGPFOA) ;Roll back an assignment record
 ;
 ;  Input:
 ;    DGAIEN - IEN of assignment to roll back in the PRF ASSIGNMENT
 ;             (#26.13) file
 ;    DGPFOA - Assignment data array prior to record modification
 ;
 ;  Output:
 ;    Function value - 1 on successful rollback, 0 on failure
 ;
 N DGIENS
 N DGFDA
 N DGEROOT
 N DGRSLT   ;function result
 ;
 S DGRSLT=0
 I +$G(DGAIEN),$D(^DGPF(26.13,DGAIEN)),$D(DGPFOA) D
 . S DGIENS=DGAIEN_","
 . I $G(DGPFOA("DFN"))="@" D
 . . S DGFDA(26.13,DGIENS,.01)=DGPFOA("DFN")
 . . D FILE^DIE("","DGFDA","DGEROOT")
 . . I '$D(DGEROOT) S DGRSLT=1
 . E  D
 . . I $$STOASGN^DGPFAA(.DGPFOA,.DGEROOT),'$D(DGEROOT) S DGRSLT=1
 Q DGRSLT
