DGPFRFR ;ALB/RBS - PRF ASSIGNMENTS DUE REVIEW REPORT ; 10/28/03 12:04pm
 ;;5.3;Registration;**425,555**;Aug 13, 1993
 ;
 ;This routine will be used for selecting sort parameters to produce
 ; the FLAGS DUE FOR REVIEW REPORT for Patient Record Flags.
 ;
 ;Selection options will provide the user with the ability to report
 ; by:
 ;  CATEGORY:
 ;    1  Category I (National)
 ;    2  Category II (Local)
 ;    3  BOTH
 ;  FLAG:
 ;    S  Single Flag
 ;    A  All Flags
 ;  BEGINING DATE:  FileMan date
 ;  ENDING DATE:    FileMan date
 ;
 ;-- no direct entry
 QUIT
 ;
EN ;Entry point
 ;-- user prompts for report selection sorts
 ;  Input: none
 ; Output: Report generated using user selected parameters
 ;
 N DGASK,DGRSLT,DGDIRA,DGDIRB,DGDIRO,DGDIRH
 N DGSORT,DGCAT,DGFIL,DGSEL,DGNOW,DGFIRST,DGBEG,DGEND
 N ZTSAVE,DGQ
 ;
 ;-- prompt for selection of a flag category
 S DGDIRA="Select Flag Category",DGDIRB=""
 S DGDIRH="Enter one of the category selections to report on"
 S DGDIRO="S^1:Category I (National);2:Category II (Local);3:Both"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 Q:(DGASK<1)
 S DGCAT=DGASK,DGSORT("DGCAT")=DGASK_U_$S(DGASK=1:"Category I (National)",DGASK=2:"Category II (Local)",DGASK=3:"Both",1:"")
 ;
 ;-- prompt for selection of a single flag or all flags
 S DGSEL=""
 ;default to (A)ll flags if user selects Both Category's
 I DGCAT=3 D
 . S DGSORT("DGFLAG")="A"
 ;
 D:DGCAT'=3  ;only prompt if user selects a Category I or II
 . S DGDIRA="Select to report on a (S)ingle flag or (A)ll flags"
 . S DGDIRB="Single Flag"
 . S DGDIRO="S^S:Single Flag;A:All Flags"
 . S DGDIRH="Enter one of the flag selections to report on"
 . S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 . Q:(DGASK=-1)
 . S DGSEL=DGASK
 . S DGSORT("DGFLAG")=DGASK
 Q:(DGASK=-1)
 ;
 ;-- prompt for selection of a record flag name - only if (S)ingle
 D:DGSEL="S"
 . S DGQ=0
 . S DGDIRA="Select Record Flag Name"
 . S DGDIRB=""
 . S DGDIRO=$S(DGCAT=1:"P^26.15,.01:EMZ",1:"P^26.11,.01:EMZ")
 . F  D  Q:DGQ
 . . S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO)
 . . I DGASK=-1 S DGQ=1 Q
 . . ;set data string = pointer value (5;DGPF(26.11,) ^ external name
 . . S DGFIL=DGASK_$S(DGCAT=1:";DGPF(26.15,",1:";DGPF(26.11,")
 . . ;if (S)ingle flag selected, check for any flag assignments
 . . I '$$ASGNCNT^DGPFLF6(DGFIL) D  Q
 . . . W !?2,">>> No Patient Record Flag Assignments have been found.  Select another flag.",*7
 . . ;a good one to report on
 . . S DGSORT("DGFLAG")=DGFIL_U_$$EXTERNAL^DILFD(26.13,.02,"F",DGFIL)
 . . S DGQ=1
 ;
 Q:(DGASK=-1)
 ;
 ;-- prompt for beginning date
 S DGNOW=$$DT^XLFDT()
 S DGFIRST=$P(+$O(^DGPF(26.13,"AFREV","")),".")  ;first review date
 I 'DGFIRST D  Q
 . W !?2,">>> No Patient Record Flag Assignments have been found.",*7
 . I $$ANSWER^DGPFUT("Enter RETURN to continue","","E")
 ;
 S DGDIRA="Select Beginning Date"
 S DGDIRB=""
 S DGDIRH="Enter the earliest Review Date to include in the report"
 S DGDIRO="D^::EX"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 Q:(DGASK=-1)
 S (DGSORT("DGBEG"),DGBEG)=DGASK
 ;
 ;-- prompt for ending date
 S DGDIRA="Select Ending Date"
 S DGDIRB=""
 S DGDIRH="Enter the latest Review Date to include in the report"
 S DGDIRO="D^::EX"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 Q:(DGASK=-1)
 S DGSORT("DGEND")=DGASK
 S DGSORT("DGNOW")=DGNOW
 ;
 K DGCAT,DGFIL,DGSEL,DGDIRA,DGDIRB,DGDIRO
 K DGASK,DGRSLT,DGNOW,DGFIRST,DGBEG
 ;
 ;-- prompt for device
 S ZTSAVE("DGSORT(")=""
 D EN^XUTMDEVQ("START^DGPFRFR1","Flags Due For Review Report",.ZTSAVE)
 D HOME^%ZIS
 Q
