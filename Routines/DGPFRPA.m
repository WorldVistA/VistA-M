DGPFRPA ;ALB/RBS - PRF PATIENT ASSIGNMENTS REPORT ; 5/11/04 3:35pm
 ;;5.3;Registration;**554**;Aug 13, 1993
 ;
 ;This routine will be used for selecting sort parameters to produce
 ; the DGPF PATIENT ASSIGNMENTS REPORT for Patient Record Flags.
 ;
 ; Selection options will provide the ability to report by:
 ;  PATIENT
 ;  STATUS (ASSIGNMENTS)
 ;
 ; The following reporting sort array will be built by user prompts:
 ;     DGSORT("DGDFN") = Patient IEN of (#2) file to report on
 ;  DGSORT("DGSTATUS") = Assignment Status to report on
 ;                         1^Active
 ;                         2^Inactive
 ;                         3^Both
 ;-- no direct entry
 QUIT
 ;
EN ;Entry point
 ;-- user prompts for report selection sorts
 ;  Input: none
 ; Output: Report generated using user selected parameters
 ;
 N DGASK    ;return value from $$ANSWER^DGPFUT call
 N DGDIRA   ;DGDIRA - DIR("A") string
 N DGDIRB   ;DGDIRB - DIR("B") string
 N DGDIRH   ;DGDIRH - DIR("?") string
 N DGDIRO   ;DGDIR0 - DIR(0) string
 N DGIEN    ;assignment ien
 N DGIENS   ;array of ien's of the patients assignment records
 N DGOK     ;ok flag for finding assignments to report on
 N DGPFA    ;assignment array
 N DGQ      ;quit flag
 N DGSORT   ;array or report parameters
 N SAVEXQY0 ;temp save var
 N ZTSAVE   ;open array reference of input parameters used by tasking
 ;
 ;-- prompt for patient to report on
 ; suppress display of Active Record Flags in DISPPRF^DGPFAPI
 ; save variable before temporarily deleting it so that the 
 ; code, Q:'$D(XQY0), in DISPPRF^DGPFAPI will suppress the display
 ;
 K SAVEXQY0
 I $D(XQY0) S SAVEXQY0=XQY0 K XQY0  ;save original
 ;
 D SELPAT^DGPFUT1(.DGASK)
 ;
 I $D(SAVEXQY0) S XQY0=SAVEXQY0 K SAVEXQY0  ;restore original
 ;
 Q:(DGASK<1)
 ; get all assignment ien's for the patient
 I '$$GETALL^DGPFAA(DGASK,.DGIENS) D  Q
 . W !?2,">>> Selected patient has no record flag assignments on file.",*7
 ;
 S DGSORT("DGDFN")=DGASK
 ;
 ;-- prompt for selection of the assignment status to report on
 S DGDIRA="Select Assignment Status to report on"
 S DGDIRB="Both"
 S DGDIRH="Enter one of the status selections to report on"
 S DGDIRO="S^1:Active;2:Inactive;3:Both"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 Q:(DGASK<1)
 S DGQ=0
 I DGASK'=3 D
 . S (DGIEN,DGOK)=0
 . F  S DGIEN=$O(DGIENS(DGIEN)) Q:'DGIEN  D  Q:(DGOK!DGQ)
 . . ;-get assignment
 . . K DGPFA
 . . I $$GETASGN^DGPFAA(DGIEN,.DGPFA),$P(DGPFA("STATUS"),U)=DGASK S DGOK=1 Q
 . Q:DGOK
 . S DGQ=1
 . W !?2,">>> Selected patient has no '"_$S(DGASK=1:"Active",1:"Inactive")_"' record flag assignments on file.",*7
 ;
 Q:DGQ
 S DGSORT("DGSTATUS")=DGASK_U_$S(DGASK=1:"Active",DGASK=2:"Inactive",DGASK=3:"Both",1:3)
 ;
 K DGASK,DGOK,DGQ,DGIEN,DGIENS,DGDIRA,DGDIRB,DGDIRO,DGDIRH
 ;
 ;-- prompt for device
 S ZTSAVE("DGSORT(")=""
 D EN^XUTMDEVQ("START^DGPFRPA1","Patient Assignments Report",.ZTSAVE)
 D HOME^%ZIS
 Q
