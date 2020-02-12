DG53985E ;ALB/ARF - ENVIRONMENT CHECK FOR PATCH DG*5.3*985 ; 08-OCT-2019
 ;;5.3;REGISTRATION;**985**; 13-AUG-93;Build 15
 ;
 ;
EN ; This routine contains environmental checks which get executed
 ; before the DG*5.3*985 installation. It will check for entries in
 ; PREFERRED NAME(#.2405) in the PATIENT file (#2) that exceed 25 
 ; characters. If these entries exist the install will be aborted.
 ;
 ;  Input: Variables set by KIDS during environment check
 ;
 ; Output: XPDABORT - KIDS variable set to abort installation
 ; 
 W !!,">>> Beginning the Environment Checker"
 ;
 D CHK ;  check for PREFERRED NAME that is greater than 25 characters
 ;
 I $D(XPDABORT) W !!,">>> DG*5.3*985 Aborted in Environment Checker",! Q
 W !!,">>> Environment Checker Successful",!,">>> No PREFERRED NAME > 25 characters found",!
 Q
 ;
CHK ; Check for PREFERRED NAME entries greater than 25 characters
 ;
 N DGDFN,DGHDR,DGX,DGCNT
 S DGHDR=1,DGCNT=0
 S DGX="",$P(DGX,"=",78)=""
 W !!?5,"Checking for PREFERRED NAME field (#.2405) in PATIENT file(#2)",!
 W ?5,"for entries greater than 25 characters....",!
 ;
 S DGDFN=""
 F  S DGDFN=$O(^DPT(DGDFN)) Q:DGDFN=""  I $L($P($G(^DPT(DGDFN,.24)),U,5))>25 D
 . W:DGHDR=1 !,"PREFERRED NAME found that exceeds limit",!!,"DFN",?25,"FULL ICN",!,DGX,! S DGHDR=0,XPDABORT=1
 . W DGDFN,?25,$$GETICN^MPIF001(DGDFN),!
 . S DGCNT=DGCNT+1
 I '$D(XPDABORT) Q
 ; At least one PREFERRED NAME is greater than 25 characters
 W !!,DGCNT_" record(s) found in the PATIENT (#2) file with a PREFERRED NAME(#.2405)"
 W !,"field value exceeding 25 characters, installation aborted."
 ;
 Q
