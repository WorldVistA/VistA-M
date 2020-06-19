DGOTHRPT ;SLC/RM - OTHD (OTHER THAN HONORABLE DISCHARGE) APIs ;April 27,2018@21:08
 ;;5.3;Registration;**952,977**;Aug 13, 1993;Build 177
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
 ;
 ;The following reporting sort array will be built by user prompts:
 ; DGSORT("DGBEG") = BEGINNING DATE (internal FileMan date)
 ; DGSORT("DGEND") = ENDING DATE (internal FileMan date)
 ; DGSORT("DGSRTBY") = SORT BY
 ; DGSORT("DGSTATUS") = OTH Patient Status to report on
 ;
 ; prompts for report selection sorts
 ; Input: none
 ; Output: Report generated using user selected parameters
 ;
 N DGSEL    ;help text var
 N DGSORT   ;array or report parameters
 N ZTSAVE   ;open array reference of input parameters used by tasking
 N ZTDESC   ;contains the free-text description of your task that you passed to the Program Interface.
 N ZTQUEUED ;background execution
 N ZTREQ    ;post-execution
 N ZTSTOP
 N ZTRTN
 N ZTSK
 N VAUTD,Y  ; variables for DIVISION^VAUTOMA
 ;
 ;check for database
 I '+$O(^DGOTH(33,"B","")) W !,$$CJ^XLFSTR(">>> No OTH-90 records have been found. <<<",80) D ASKCONT^DGOTHMG2 Q
 ;
 W @IOF
 W !,"OTH 90-DAY PERIOD TRACKING REPORT"
 W !!,"This option generates a report that prints a listing of all OTH-90 patients"
 W !,"with ACTIVE or EXPIRED 90-Day period of care and who have an Outpatient"
 W !,"Encounter with the STATUS=CHECKED OUT for Clinic(s) associated with the"
 W !,"selected Division(s) within the user-specified date range of the 90-Day period."
 W !,"Those OTH-90 patients that have been adjudicated, entered in error, or the"
 W !,"Expanded MH Care Type is changed from OTH-90 to a different factor type"
 W !,"will not be displayed in this report."
 K DGSORT,VAUTD
 ;prompt for OTH-90 status user wish to print
 I '$$STATUS Q
 ;prompt for beginning date
 I '$$DATEBEG Q
 ;
 ;prompt for ending date
 I '$$DATEEND Q
 ;
 ;DG*5.3*977 OTH-EXT
 ; select divisions to include
 W !!,"Please select divisions to include in the report:"
 I '$$SELDIV^DGOTHRP1 Q
 I DGSORT("DIVISION")>0,'$$SORTRPT^DGOTHRP1 Q
 I DGSORT("DIVISION")=0 S DGSORT("REPORT")="1^Division" ;default to sort report by divisions
 ;DG*5.3*977 OTH-EXT
 ;prompt sort by:
 ; 1) Patient Name
 ; 2) Period
 ; 3) Days Remaining
 I 2[$P(DGSORT("REPORT"),U) S $P(DGSORT("REPORT"),U,2)="Facility"
 I 13[$P(DGSORT("DGSTATUS"),U),'$$SORTBY Q
 I 2[$P(DGSORT("DGSTATUS"),U) S DGSORT("DGSRTBY")="1^Patient Name"
 ;
 ;prompt for device
 W !
 S ZTSAVE("DGSORT(")=""
 S X="OTH 90-DAY PERIOD TRACKING REPORT"
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
 W !
 S DIR(0)="NASO^1:3"
 S DIR("A")="Select OPTION: "
 S DIR("A",1)="Please select how you like to sort the data within each "_$P($G(DGSORT("REPORT")),U,2)_":"
 S DIR("A",2)="     Select one of the following:"
 S DIR("A",3)=" "
 S DIR("A",4)="          1         Sort by Patient Name"
 S DIR("A",5)="          2         Sort by 90-Day Period"
 S DIR("A",6)="          3         Sort by Days Remaining"
 S DIR("A",7)=" "
 S (DIR("?"),DIR("??"))="^D HELP^DGOTHRPT(4)"
 D ^DIR K DIR
 S DGASK=+Y
 I DGASK>0 S DGSORT("DGSRTBY")=DGASK_U_$S(DGASK=1:"Patient Name",DGASK=2:"90-Day Period",DGASK=3:"Days Remaining",1:"")
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
 I X'="?",X'="??",DGSEL'=4 W !,"  Not a valid date.",!
 N X S X=$S(DGSEL=1:"earliest",DGSEL=2:"latest",1:0)
 I DGSEL=1 D
 . W !,"  Beginning Date cannot be more than 90 days from today."
 . W !,"  Beginning Date cannot be a future date."
 I DGSEL=2 D
 . W !,"  Ending Date is today's date + 1 day. The latest ending date was "
 . W !,"  calculated by adding 364 days from the Beginning Date entered by the user. "
 I DGSEL=3 D  Q
 . W !,"  Please Enter:",!
 . W !,"    1 = If you wish to print all OTH-90 MH Care patient which"
 . W !,"        were being treated at the Division with an ACTIVE"
 . W !,"        90-Day period of care for a selected date range.",!
 . W !,"    2 = If you wish to print all OTH-90 Care patient whose"
 . W !,"        90-Day period has been EXPIRED or ZERO days remaining.",!
 . W !,"    3 = If you wish to print BOTH ACTIVE and EXPIRED 90-Day period",!
 I DGSEL=4 W !,"  Select sort criteria within each Division." Q
 W !!,"  Enter the "_X_" date to include in the report."
 W !,"  Please enter a date from the specified date range displayed."
 Q
 ;
 ;Entry point DG OTH STATISTICAL REPORT
 ;B3S2
ENSTAT ;
 N DGFIRST  ;first OTH patient DFN
 N DGSORT   ;array or report parameters
 N ZTSAVE   ;open array reference of input parameters used by tasking
 N ZTDESC   ;contains the free-text description of your task that you passed to the Program Interface.
 N ZTQUEUED ;background execution
 N ZTREQ    ;post-execution
 N ZTSTOP
 N ZTRTN
 N ZTSK
 N DGQMON
 N DGDTRNGE ;statistical report date range
 ;check for database
 S DGFIRST=$P(+$O(^DGOTH(33,"B","")),",") ;first OTH DFN
 I 'DGFIRST D  Q
 . W !?2,">>> No OTH-90 records were found.",*7
 . I $$ANSWER^DGOTHRPT("Enter RETURN to continue","","E")
 ;
 W @IOF
 W !,"OTH 90-DAY PERIOD STATISTICAL REPORT"
 W !!,"This option generates a report that prints a listing of all OTH-90 patients"
 W !,"with ACTIVE or EXPIRED 90-Day periods of care, have been adjudicated, entered"
 W !,"in error, or the Expanded MH Care Type is changed from OTH-90 to a different"
 W !,"Expanded MH Care Type."
 W !!,"The date displayed in the 'INACTIVATION DATE' column is the date the 90-Day"
 W !,"countdown clock has been inactivated. The 90-Day countdown is inactivated when"
 W !,"an OTH-90 patient has received adjudication, was inactivated due to data entry"
 W !,"error or the Expanded MH Care Type is changed from OTH-90.",!
 ;prompt for fiscal year
 I '$$FISCAL,'$D(DGSORT("DGFSCL")) Q
 ;
 ;prompt by Quarter or Fiscal Year (All Quarters)
 I DGSORT("DGFSCL")>0,'$$QRTRALL Q
 ;
 I 1234[$P(DGSORT("DGQTR"),U) D  Q:DGQMON<1
 . ;prompt month in the quarter or all quarters
 . S DGQMON=$$MQ(.DGSORT)
 . Q:DGQMON<1
 . D DTRANGE
 ;
 ;prompt for Fiscal Year (All Quarters)
 I 5[$P(DGSORT("DGQTR"),U) D FSCLYR
 ;prompt for device
 W !
 S ZTSAVE("DGSORT(")=""
 S X="OTH 90-DAY PERIOD STATISTICAL REPORT"
 D EN^XUTMDEVQ("START^DGOTHRP3",X,.ZTSAVE)
 D HOME^%ZIS
 Q
 ;
FISCAL() ;prompt for fiscal year
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,X
 W !
 S DGDIRA="Enter Fiscal Year"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGOTHRP3"
 S DGDIRO="DO^::AE"
 S DGASK=$$ANSWER(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I (+$E(DGASK,4,5))!(+$E(DGASK,6,7)) W ! S (X,DGASK)="" D HELP^DGOTHRP3 D FISCAL
 I DGASK>0 S DGSORT("DGFSCL")=DGASK
 Q DGASK>0
 ;
QRTRALL() ;prompt for statistical report to print
 ;
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGFYQ
 S DGDIRA="Select reporting period "
 S DGDIRB=""
 S DGDIRH="Enter one of the selections to report on"
 S DGDIRO="SO^1:FY Quarter 1 (Oct-Nov-Dec);2:FY Quarter 2 (Jan-Feb-Mar);3:FY Quarter 3 (Apr-May-Jun);4:FY Quarter 4 (Jul-Aug-Sep);5:Fiscal Year  (All Quarters)"
 S DGASK=$$ANSWER^DGOTHRPT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 S DGFYQ=$S(DGASK=1:"FY Quarter 1",DGASK=2:"FY Quarter 2",DGASK=3:"FY Quarter 3",DGASK=4:"FY Quarter 4",DGASK=5:"Fiscal Year (All Quarters)",1:"")
 I DGASK>0 S DGSORT("DGQTR")=DGASK_U_DGFYQ
 Q DGASK>0
 ;
MQ(DGSORT) ;prompt month in the quarter
 ;
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGFYQ,DGMIN,DGMAX,I,DGMON,DGCNT
 S DGDIRA="Select the month of the Quarter or All"
 S DGDIRB=""
 S DGDIRH="Enter one of the selections to report on"
 S DGMIN=$E($P($P($T(DATES+$P(DGSORT("DGQTR"),U)),";;",2),"^"),1,2)
 S DGMAX=$E($P($P($T(DATES+$P(DGSORT("DGQTR"),U)),";;",2),"^",2),1,2)
 S DGCNT=0
 F I=DGMIN:1:DGMAX D
 . S DGCNT=DGCNT+1
 . S DGMON(DGCNT)=$P($P($T(MONAME+I^DGOTHRP3),";;",2),"^",2)_U_I
 S DGDIRO="SO^1:"_$P(DGMON(1),U)_";2:"_$P(DGMON(2),U)_";3:"_$P(DGMON(3),U)_";4:All Months in the Quarter"
 S DGASK=$$ANSWER^DGOTHRPT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 D
 . S DGSORT("DGMON")=DGASK_U_$S(123[DGASK:DGMON(DGASK),1:"All Months in the Quarter")
 . I 123[DGASK S DGSORT("DGMON",$P(DGMON(DGASK),U,2))=DGMON(DGASK)
 . I 4[DGASK D
 . . F I=1:1:3 S DGSORT("DGMON",$P(DGMON(I),U,2))=DGMON(I)
 Q DGASK>0
 ;
DTRANGE ;calculate monthly date range
 ;print by monthly
 N I
 I 123[$P(DGSORT("DGMON"),U) D
 . S DGMON=$E(DGSORT("DGFSCL"),1,3)-$S($P(DGSORT("DGQTR"),U)=1:1,1:0)
 . S DGMON=DGMON_$S($P(DGSORT("DGMON"),U,3)<=9:"0"_$P(DGSORT("DGMON"),U,3),1:$P(DGSORT("DGMON"),U,3))_"00"
 . S DGMON=$$MONTH(DGMON)
 . S DGSORT("DGBEG")=$P(DGMON,U)
 . S DGSORT("DGEND")=$P(DGMON,U,2)
 E  D
 . ;all month in the quarter range
 . S DGSORT("DGBEG")=$E(DGSORT("DGFSCL"),1,3)-$S($P(DGSORT("DGQTR"),U)=1:1,1:0)_$P($P($T(DATES+$P(DGSORT("DGQTR"),U)),";;",2),"^")
 . S DGSORT("DGEND")=$E(DGSORT("DGFSCL"),1,3)-$S($P(DGSORT("DGQTR"),U)=1:1,1:0)_$P($P($T(DATES+$P(DGSORT("DGQTR"),U)),";;",2),"^",2)
 D MSG(.DGSORT)
 ;
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
FSCLYR ;calculate fiscal year date range
 N I,II,DGMIN,DGMAX
 S DGSORT("DGBEG")=$E(DGSORT("DGFSCL"),1,3)-1_$P($P($T(DATES+1),";;",2),"^")
 S DGSORT("DGEND")=$E(DGSORT("DGFSCL"),1,3)_$P($P($T(DATES+4),";;",2),"^",2)
 ;create S DGSORT("DGMON") array for the whole fiscal year
 S DGSORT("DGMON")=DGSORT("DGQTR")
 F I=1:1:4 D
 . K DGSORT("DGQTR")
 . S DGSORT("DGQTR")=I
 . S DGMIN=$E($P($P($T(DATES+$P(DGSORT("DGQTR"),U)),";;",2),"^"),1,2)
 . S DGMAX=$E($P($P($T(DATES+$P(DGSORT("DGQTR"),U)),";;",2),"^",2),1,2)
 . F II=DGMIN:1:DGMAX S DGSORT("DGMON",I,II)=$P($P($T(MONAME+II^DGOTHRP3),";;",2),"^",2)_U_II
 D MSG(.DGSORT)
 Q
 ;
MSG(DGSORT) ;
 S DGDTRNGE=$$FMTE^XLFDT(DGSORT("DGBEG"),5)_" TO "_$$FMTE^XLFDT(DGSORT("DGEND"),5)
 W !!,"Statistical Date Range Selected: ",$$FMTE^XLFDT(DGSORT("DGBEG"),1)," to ",$$FMTE^XLFDT(DGSORT("DGEND"),1)
 Q
 ;
DATES ;store date ranges for each quarter
 ;;1001^1231
 ;;0101^0331
 ;;0401^0630
 ;;0701^0930
 Q
 ;
MONTH(DGRRDT) ; Pass in a date (default = today's date)
 ; this function returns the first and last dates of the month
 N DGRRMST,DGRRMND
 S:'$D(DGRRDT) DGRRDT=DT
 S DGRRMST=$E(DGRRDT,1,5)_"01"
 S DGRRMND=$$SCH^XLFDT("1M(1)",DGRRMST)\1
 Q DGRRMST_U_DGRRMND
 ;
FY(DGRRDT) ; Pass in a date (default = today's date),
 ; and this function returns what FY we are in,
 ; followed by the FY start date and FY end date.
 ; ie. S X=$$FY^DGOTHST(3050208) results in X="FY 2005^3041000^3051000"
 N DGRRST,DGRRND
 S:'$D(DGRRDT) DGRRDT=DT
 S DGRRST=$E(DGRRDT,1,3)-($E(DGRRDT,4,5)<10)_"1000"
 S DGRRND=$E(DGRRST,1,3)+1_"1000"
 Q "FY "_(1701+$E(DGRRST,1,3))_U_DGRRST_U_DGRRND
 ;
