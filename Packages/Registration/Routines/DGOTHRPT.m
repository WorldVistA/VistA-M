DGOTHRPT ;SLC/RM - OTHD (OTHER THAN HONORABLE DISCHARGE) APIs ;April 27,2018@21:08
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;     Last Edited: SHRPE/RM - May 02, 2018 15:50
 ;
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  -------------------------------
 ; 10010  Sup  EN1^DIP
 ; 10006  Sup  ^DIC
 ; 10086  Sup  HOME^%ZIS
 ; 10103  Sup  ^XLFDT:$$FMTE, $$NOW, $$FMADD
 ; 1519   Sup  EN^XUTMDEVQ
 ; 10026  Sup  ^DIR
 Q
 ;
 ;Entry point for DG OTH 90-DAY PERIOD option
 ;B3S1
REPORT1 ;
 ;This subroutine will be used for selecting sort parameters
 ;to display all active OTH patients
 ;
 ;Reports can be sorted by:
 ; 1) Name
 ; 2) Period
 ; 3) Days Remaining
 ;
 ;The following reporting sort array will be built by user prompts:
 ; DGSORT("DGBEG") = BEGINNING DATE (internal FileMan date)
 ; DGSORT("DGEND") = ENDING DATE (internal FileMan date)
 ; DGSORT("DGSRTBY") = SORT BY
 ; DGSORT("DGSTATUS") = OTH Patient Status to report on
 ; 1^Active Period
 ;
 ; prompts for report selection sorts
 ; Input: none
 ; Output: Report generated using user selected parameters
 ;
 N DGFIRST  ;first OTH patient DFN
 N DGSEL    ;help text var
 N DGSORT   ;array or report parameters
 N ZTSAVE   ;open array reference of input parameters used by tasking
 N ZTDESC   ;contains the free-text description of your task that you passed to the Program Interface.
 N ZTQUEUED ;background execution
 N ZTREQ    ;post-execution
 N ZTSTOP
 ;
 ;check for database
 S DGFIRST=$P(+$O(^DGOTH(33,"B","")),",") ;first OTH DFN
 I 'DGFIRST D  Q
 . W !?2,">>> No OTH-90 Record have been found.",*7
 . I $$ANSWER("Enter RETURN to continue","","E")
 ;
 W @IOF
 W !,"OTH 90-DAY PERIOD STATUS TRACKING REPORT"
 W !!,"This option generates a report that prints a listing of all OTH-90 patients"
 W !,"with ACTIVE or EXPIRED 90-Day period of care for a selected date range."
 W !,"Those OTH-90 patients that have been adjudicated, entered in error, or the"
 W !,"Expanded MH Care Type is changed from OTH-90 to a different factor type,"
 W !,"will not be displayed in this report."
 ;prompt for OTH-90 status user wish to print
 I '$$STATUS Q
 ;prompt for beginning date
 I '$$DATEBEG Q
 ;
 ;prompt for ending date
 I '$$DATEEND Q
 ;
 ;prompt sort by:
 ; 1) Patient Name
 ; 2) Period
 ; 3) Days Remaining
 I 13[$P(DGSORT("DGSTATUS"),U),'$$SORTBY Q
 I 2[$P(DGSORT("DGSTATUS"),U) S DGSORT("DGSRTBY")="1^Sort by Patient Name"
 ;
 ;prompt for device
 W !
 S ZTSAVE("DGSORT(")=""
 S X="OTH 90-DAY PERIOD STATUS TRACKING REPORT"
 D EN^XUTMDEVQ("START^DGOTHRP2",X,.ZTSAVE)
 D HOME^%ZIS
 Q
 ;
STATUS() ;prompt OTH-90 STATUS
 ; 1) Active 90-Day Period
 ; 2) Expired 90-Day Period
 ; 3) Both (Active and Expired Period)
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 W !
 S DGDIRA="Select 90-Day period status you wish to print"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGOTHRPT(3)"
 S DGDIRO="SO^1:Active 90-Day Period;2:Expired 90-Day Period;3:Both (Active and Expired)"
 S DGASK=$$ANSWER(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGSTATUS")=DGASK_U_$S(DGASK=1:"Active 90-Day Period",DGASK=2:"Expired 90-Day Period",DGASK=3:"Both (Active and Expired)",1:"")
 Q DGASK>0
 ;
DATEBEG() ;prompt for beginning date
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGBEGDT
 W !
 S DGDIRA="Enter Beginning Date"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGOTHRPT(1)"
 S DGBEGDT=$$FMADD^XLFDT(DT,-90)
 S DGDIRO="DO^"_DGBEGDT_":"_DT_":EX"
 S DGASK=$$ANSWER(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGBEG")=DGASK
 Q DGASK>0
 ;
DATEEND() ;prompt for ending date
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGDTEND
 W !
 S DGDIRA="Enter Ending Date"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGOTHRPT(2)"
 S DGDTEND=$$FMADD^XLFDT(DGSORT("DGBEG"),364)
 S DGDIRO="DO^"_$$FMADD^XLFDT(DT,1)_":"_DGDTEND_":EX"
 S DGASK=$$ANSWER(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGEND")=DGASK
 Q DGASK>0
 ;
SORTBY() ;prompt for sort by
 ; 1) Patient Name
 ; 2) Period
 ; 3) Days Remaining
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 W !
 S DGDIRA="Print Report Sorted By"
 S DGDIRB=""
 S DGDIRH="Enter one of the sorts selections to report on"
 S DGDIRO="SO^1:Sort by Patient Name;2:Sort by 90-Day Period;3:Sort by Days Remaining"
 S DGASK=$$ANSWER(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGSRTBY")=DGASK_U_$S(DGASK=1:"Sort by Patient Name",DGASK=2:"Sort by 90-Day Period",DGASK=3:"Sort by Days Remaining",1:"")
 Q DGASK>0
 ;
ANSWER(DGDIRA,DGDIRB,DGDIR0,DGDIRH) ;
 ; Input
 ; DGDIR0 - DIR(0) string
 ; DGDIRA - DIR("A") string
 ; DGDIRB - DIR("B") string
 ; DGDIRH - DIR("?") string
 ; Output
 ; Function Value - Internal value returned from ^DIR or -1 if user
 ; up-arrows, double up-arrows or the read times out.
 N X,Y,Z,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 I $D(DGDIR0) S DIR(0)=DGDIR0
 I $D(DGDIRA) S DIR("A")=DGDIRA
 I $G(DGDIRB)]"" S DIR("B")=DGDIRB
 I $D(DGDIRH) S DIR("?")=DGDIRH,DIR("??")=DGDIRH
 D ^DIR
 S Z=$S($D(DTOUT):-2,$D(DUOUT):-1,$D(DIROUT):-1,1:"")
 I Z="" S Z=$S(Y=-1:"",X="@":"@",1:$P(Y,U)) Q Z
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(X="@":"@",1:$P(Y,U))
 ;
HELP(DGSEL) ;provide extended DIR("?") help text.
 ;
 ; Input: DGSEL - prompt var for help text word selection
 ; Output: none
 ;
 I X'="?",X'="??" W !,"  Not a valid date.",!
 N X S X=$S(DGSEL=1:"earliest",DGSEL=2:"latest",1:0)
 I DGSEL=1 D
 . W !,"  Beginning Date cannot be more than 90 days from today."
 . W !,"  Beginning Date cannot be a future date."
 I DGSEL=2 D
 . W !,"  Ending Date is today's date + 1 day. The latest ending date was "
 . W !,"  calculated by adding 364 days from the Beginning Date entered by the user. "
 I DGSEL=3 D  Q
 . W !,"  Please Enter:",!
 . W !,"    1 = If you wish to print all OTH-90 MH Care patient with"
 . W !,"        ACTIVE 90-Day period.",!
 . W !,"    2 = If you wish to print all OTH-90 Care patient whose"
 . W !,"        90-Day period has been EXPIRED or ZERO days remaining.",!
 . W !,"    3 = If you wish to print BOTH ACTIVE and EXPIRED 90-Day period",!
 W !!,"  Enter the "_X_" date to include in the report."
 W !,"  Please enter a date from the specified date range displayed."
 Q
 ;
CALRNGE(DGSORT,Q,M) ;calculate date range by month
 I 4[$P(DGSORT("DGMON"),U) D
 . S DGMON=$E(DGSORT("DGFSCL"),1,3)-$S($P(DGSORT("DGQTR"),U)=1:1,1:0)
 . S DGMON=DGMON_$S($P(DGSORT("DGMON",M),U,2)<=9:"0"_$P(DGSORT("DGMON",M),U,2),1:$P(DGSORT("DGMON",M),U,2))_"00"
 I 5[$P(DGSORT("DGMON"),U) D
 . S DGMON=$E(DGSORT("DGFSCL"),1,3)-$S($G(Q)=1:1,1:0)
 . S DGMON=DGMON_$S($P(DGSORT("DGMON",Q,M),U,2)<=9:"0"_$P(DGSORT("DGMON",Q,M),U,2),1:$P(DGSORT("DGMON",Q,M),U,2))_"00"
 S DGMON=$$MONTH(DGMON)
 Q DGMON
 ;
MONTH(DGRRDT) ; Pass in a date (default = today's date)
 ; this function returns the first and last dates of the month
 N DGRRMST,DGRRMND
 S:'$D(DGRRDT) DGRRDT=DT
 S DGRRMST=$E(DGRRDT,1,5)_"01"
 S DGRRMND=$$SCH^XLFDT("1M(1)",DGRRMST)\1
 Q DGRRMST_U_DGRRMND
 ;
