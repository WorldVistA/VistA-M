DGPFRAL ;ALB/RBS - PRF ACTION NOT LINKED REPORT ; 7/26/05 3:18pm
 ;;5.3;Registration;**554**;Aug 13, 1993
 ;
 ;This routine will be used for selecting sort parameters to produce
 ;the DGPF ACTION NOT LINKED REPORT for Patient Record Flags.
 ;
 ; Selection options will provide the ability to report by:
 ;  CATEGORY
 ;  BEGINNING DATE
 ;  ENDING DATE
 ;
 ; The following reporting sort array will be built by user prompts:
 ;  DGSORT("DGCAT") = CATEGORY
 ;                      1^Category I (National)
 ;                      2^Category II (Local)
 ;                      3^Both
 ;  DGSORT("DGBEG") = BEGINNING DATE  (internal FileMan date)
 ;  DGSORT("DGEND") = ENDING DATE     (internal FileMan date)
 ;
 ;-- no direct entry
 QUIT
 ;
EN ;Entry point
 ;-- user prompts for report selection sorts
 ;  Input: none
 ; Output: Report generated using user selected parameters
 ;
 N DGASK   ;return value from $$ANSWER^DGPFUT call
 N DGCAT   ;flag category to report on
 N DGDIRA  ;DGDIRA - DIR("A") string
 N DGDIRB  ;DGDIRB - DIR("B") string
 N DGDIRH  ;DGDIRH - DIR("?") string
 N DGDIRO  ;DGDIR0 - DIR(0) string
 N DGFIRST ;first assignment date
 N DGSEL   ;help text var
 N DGSORT  ;array or report parameters
 N ZTSAVE  ;open array reference of input parameters used by tasking
 ;
 S DGFIRST=$P(+$O(^DGPF(26.14,"D","")),".")    ;first assignment date
 I 'DGFIRST D  Q
 . W !?2,">>> No Patient Record Flag Assignments have been found.",*7
 . I $$ANSWER^DGPFUT("Enter RETURN to continue","","E")  ;pause
 ;
 ;-- prompt for selection of a flag category
 S DGDIRA="Select Flag Category"
 S DGDIRB=""
 S DGDIRH="Enter one of the category selections to report on"
 S DGDIRO="S^1:Category I (National);2:Category II (Local);3:Both"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 Q:(DGASK<1)
 S DGCAT=DGASK,DGSORT("DGCAT")=DGASK_U_$S(DGCAT=1:"Category I (National)",DGCAT=2:"Category II (Local)",DGCAT=3:"Both",1:"")
 ;
 ;-- prompt for beginning date
 S DGDIRA="Select Beginning Date"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGPFRAL(1)"
 S DGDIRO="D^"_DGFIRST_":DT:EX"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 Q:(DGASK=-1)
 S DGSORT("DGBEG")=DGASK
 ;
 ;-- prompt for ending date
 S DGDIRA="Select Ending Date"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGPFRAL(2)"
 S DGDIRO="D^"_DGSORT("DGBEG")_":DT:EX"
 S DGASK=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 Q:(DGASK=-1)
 S DGSORT("DGEND")=DGASK
 ;
 K DGCAT,DGDIRA,DGDIRB,DGDIRO,DGDIRH,DGASK,DGFIRST
 ;
 ;-- prompt for device
 S ZTSAVE("DGSORT(")=""
 D EN^XUTMDEVQ("START^DGPFRAL1","Assignment Action Not Linked to a Progress Note Report",.ZTSAVE)
 D HOME^%ZIS
 Q
 ;
HELP(DGSEL) ;provide extended DIR("?") help text.
 ;
 ;  Input: DGSEL - prompt var for help text word selection
 ; Output: none
 ;
 W !,"  Enter the "_$S(DGSEL=1:"earliest",1:"latest")_" Assignment Action Date to include in the report."
 W !,"  Please enter a date from the specified date range displayed."
 Q
