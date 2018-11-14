DGPFRFA ;ALB/RBS - PRF FLAG ASSIGNMENT REPORT ; 7/26/05 3:41pm
 ;;5.3;Registration;**425,555,554,960**;Aug 13, 1993;Build 22
 ;     Last Edited: SHRPE/sgm - Jul 9, 2018 13:33
 ;
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  ----------------------------------------
 ; 1519  Sup   EN^XUTMDEVQ
 ; 2055  Sup   $$EXTERNAL
 ;10086  Sup   HOME^%ZIS
 ;
 ;This routine will be used for selecting sort parameters to produce
 ; the FLAG ASSIGNMENT REPORT for Patient Record Flags.
 ;
 ;  DGSORT(label) = value will store the user selected options
 ;  DGSORT("DGCAT") = 1^Category I (National)
 ;                    2^Category II (Local)
 ;                    3^Category I & II
 ;  DGSORT("DGOWN") = 1^Local Facility
 ;                    2^Other Facilities
 ;                    3^All Facilities
 ; DGSORT("DGSTAT") = 1^Active
 ;                    2^Inactive
 ; DGSORT("DGFLAG") = A^All Flags
 ;                    variable_pointer^flag name
 ;                       e.g., 1;DGPF(26.15,
 ;  DGSORT("DGBEG") = start date FM format
 ;  DGSORT("DGEND") =   end date FM format
 ;
 ;-- no direct entry
 QUIT
 ;
EN ;Entry point
 ;-- user prompts for report selection sorts
 ;  Input: none
 ; Output: Report generated using user selected parameters
 ;
 N X,Y,DGCAT,DGFIRST,DGSORT,ZTSAVE
 ;
 ;check for database
 S DGFIRST=$$DATA^DGPFUT7 I DGFIRST<1 Q
 ;
 ;-- prompt for selection of a flag category (I, II, Both)
 S DGCAT=$$CAT^DGPFUT7 Q:DGCAT<1  S DGSORT("DGCAT")=DGCAT
 ;
 ;-- prompt for selection of a single flag or all flags
 ;   list (A)ll flags if user selects Both Category's
 S DGSORT("DGFLAG")="A^All Flags"
 I DGCAT<3 D  I X=-1 Q
 . ;  ask for all or single flag
 . S X=$$FLAG^DGPFUT7 I X=-1 Q
 . S DGSORT("DGFLAG")=X I $E(X)="A" Q
 . ;  ask for single flag name
 . F  D  Q:+X
 . . N CAT S CAT=$S(+DGCAT=1:"I",1:"II")
 . . S X=$$ONEFLAG^DGPFUT7(CAT,1) I X=-1 Q
 . . I X>0 S DGSORT("DGFLAG")=X Q
 . . S X=0 W !?6,"Select another flag."
 . . Q
 . Q
 ;
 ;-- prompt for locally owned assignments or not ; DG*5.3*960
 I +DGSORT("DGCAT")=2 S DGSORT("DGOWN")="1^Local Facility"
 E  S X=$$OWNASGN^DGPFUT7 Q:X<1  S DGSORT("DGOWN")=X
 ;
 ;-- prompt for active/inactive ; DG*3.5*960
 S X=$$STATUS^DGPFUT7(0) Q:X<1  S DGSORT("DGSTAT")=X
 ;
 ;-- prompt for beginning date
 W ! S X=$$START^DGPFUT7(DGFIRST,DT) I X<1 Q
 S DGSORT("DGBEG")=X
 ;
 ;-- prompt for ending date
 S X=$$END^DGPFUT7(DGSORT("DGBEG"),DT) I X<1 Q
 S DGSORT("DGEND")=X
 ;
P ;-- prompt for device
 ;;WARNING: this report expects the device to support 132 column reports
 W !!,$TR($T(P+1),";"," "),!
 S ZTSAVE("DGSORT(")=""
 D EN^XUTMDEVQ("START^DGPFRFA1","Patient Record Flag Assignment Report",.ZTSAVE)
 D HOME^%ZIS
 Q
