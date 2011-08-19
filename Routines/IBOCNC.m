IBOCNC ;ALB/ARH - CPT USAGE IN CLINICS (USER) ; 1/23/92
 ;;Version 2.0 ; INTEGRATED BILLING ;**31**; 21-MAR-94
 ;
 ;count of procedures used in clinics and bills
 ;if the sort is by clinic or procedure:
 ;loops through the Schduling Visits (409.5) file for 900 stop code entries ("AP" x-ref)
 ;for every 900 stop code entry, if each of the following conditions are ment then adds the stop code's procedures (409.5,10,21-25) to the report
 ;    - outpt visit DATE/TIME (405.9,.01) within the date range entered by the user
 ;    - ASSOCIATED CLINIC (409.5,10,3), checks if chosen by user
 ;    - for each clinic chosen, checks that the clinics DIVISION (44,3.5) was chosen
 ;
 ;if the report is sorted by procedure the count of procedures found on bills (399,304 and 399,51-53,57-59) within the date range given by the user are also added to the report
 ;
EN ;get parameters (date and clinic) then run the report
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOCNC" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBOCNC-1" D T0^%ZOSV ;start rt clock
 D HOME^%ZIS S IBHDR="CLINIC CPT USAGE REPORT" W @IOF,?29,IBHDR,!!
 S DIR("?",1)="For the choosen date range and clinics:"
 S DIR("?",2)="""C"" - produces a count of procedures used, by clinic."
 S DIR("?",3)="""P"" - provides a total count of all procedures used"
 S DIR("?",4)="      including the total count used in billing."
 S DIR("?")="""D"" - same report as ""P"" plus the full procedure description."
 S DIR("0")="SO^C:CLINIC;P:PROCEDURE;D:PROCEDURE WITH EXTENDED DESCRIPTION;",DIR("A")="Sort report by" D ^DIR K DIR G:$D(DIRUT) EXIT S IBSRT=$S(Y="C":0,Y="P":1,1:2)
 D BDT^IBOUTL G:Y<0!(IBBDT="")!(IBEDT="") EXIT
 ;find division then clinic - can select all or some clinics for all/some divisions
 D DIVISION^VAUTOMA G:$D(VAUTD)<11&(VAUTD=0) EXIT
 S VAUTNI=2 D CLINIC^VAUTOMA G:$D(VAUTC)<11&(VAUTC=0) EXIT
DEV ;get the device
 W !!,"This report requires 132 columns."
 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="FIND^IBOCNC1",ZTDESC=IBHDR,ZTSAVE("IB*")="",ZTSAVE("VAU*")="" D ^%ZTLOAD K IO("Q"),ZTSK G EXIT
 U IO D ^IBOCNC1 D ^%ZISC
 ;
EXIT ;clean up and quit
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOCNC" D T1^%ZOSV ;stop rt clock
 D HOME^%ZIS
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K IBBDT,IBEDT,IBSRT,IBHDR,VAUTC,VAUTD,VAUTNI,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 Q
