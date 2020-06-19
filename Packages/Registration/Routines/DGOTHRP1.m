DGOTHRP1 ;SLC/RED,RM - OTHD (OTHER THAN HONORABLE DISCHARGE) Reports ;May 9,2018@05:08
 ;;5.3;Registration;**952,977**;May 9, 2018;Build 177
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Last Edited: SHRPE/RED,RM - August 21, 2019 09:00
 ;
 ; ICR#   TYPE       DESCRIPTION
 ;-----   ----       -------------------------------
 ; 10103  Sup        ^XLFDT - [$$FMTE^XLFDT, $$NOW^XLFDT]
 ; 10015  Sup        ^DIQ
 ; 10086  Sup        HOME^%ZIS
 ; 10063  Sup        ^%ZTLOAD
 ;  1519  Sup        EN^XUTMDEVQ
 ; 10089  Sup        ^%ZISC
 ; 10026  Sup        ^DIR
 ; 10112  Sup        $$SITE^VASITE
 ; 10024  Sup        WAIT^DICD
 ;   664  Cont. Sub  DIVISION^VAUTOMA
 ;   417  Cont. Sub  DG has approval for direct global read of File #40.8
 ;  3546  Cont. Sub  DG has approval for direct global read of "AD" index of FILE #40.8
 ;   402  Cont. Sub  DG has approval for direct global read of "ADFN" index of FILE #409.68
 ;
 Q  ; No Direct access
 ; Menu text: Other Than Honorable MH Status Report
EN ; CALLED BY - DG OTH MH STATUS REPORT - menu option
 N ZTSAVE   ;open array reference of input parameters used by tasking
 N ZTDESC   ;contains the free-text description of your task that you passed to the Program Interface.
 N ZTQUEUED ;background execution
 N ZTREQ    ;post-execution
 N ZTSTOP
 N ZTRTN
 N ZTSK
 N DGOUT,DGSORT,VAUTD
 ;
 W @IOF
 W !,"OTHER THAN HONORABLE MH STATUS REPORT",!
 W !,"This option generates a report that displays a list(s) of Patients who had"
 W !,"EXPANDED MH CARE NON-ENROLLEE primary eligibility assigned, changed from"
 W !,"being EXPANDED MH CARE NON-ENROLLEE who have an Outpatient Encounter with"
 W !,"with STATUS=CHECKED OUT for Clinic(s) associated with the selected Division(s)"
 W !,"within the user-specified date range.",!
 ;check for database
 ;DG*5.3*977 OTH-EXT
 I '+$O(^DGOTH(33,"B","")) W !,$$CJ^XLFSTR(">>> No OTH-90 Records have been found. <<<",80) D ASKCONT^DGOTHMG2 Q
 ;
 K DGSORT,VAUTD
 ;prompt for OTH MH status report type that user wish to print
 I '$$STATUS Q
 ;prompt for beginning date
 W !
 I '$$DATEBEG Q
 ;prompt for ending date
 I '$$DATEEND Q
 W !
 ;DG*5.3*977 OTH-EXT
 ;prompt user to select DIVISION
 W !,"Please select divisions to include in the report"
 I '$$SELDIV Q
 ;DGSORT("DIVISION")=0 -- user only select one division
 ;DGSORT("DIVISION")=1 -- user select ALL division
 ;DGSORT("DIVISION")>1 -- user select multiple division but not all
 ;if user selected division is many or all but not one
 ;prompt user on how the report will be sorted
 I DGSORT("DIVISION")>0,'$$SORTRPT Q
 I DGSORT("DIVISION")=0 S DGSORT("REPORT")="1^Patient Name" ;default to sort report by divisions
 ;
 S DGOUT=$NA(^TMP($J,"DGOTHRP1")) K @DGOUT      ;Set and kill tmp global for report
 ;prompt for device
 W !
 S ZTSAVE("DGSORT(")=""
 S X="OTHER THAN HONORABLE MH STATUS REPORT"
 D EN^XUTMDEVQ("STAT^DGOTHRP1",X,.ZTSAVE)
 D HOME^%ZIS
 Q
 ;
STATUS() ;prompt for OTH MH status report type that user wish to print
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Select OTH MH status you wish to print"
 S DGDIRB=3
 S DGDIRH="^D HELP^DGOTHRP1(1)"
 S DGDIRO="SO^1:Activated "_$$STAT2()_";2:Inactivated "_$$STAT2()_";3:Both"
 S DGASK=$$ANSWER^DGOTHRPT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("OTHSTAT")=DGASK_U_$S(DGASK=1:"Activated "_$$STAT2(),DGASK=2:"Inactivated "_$$STAT2(),1:"Both (Activated/Inactivated)")
 Q DGASK>0
 ;
STAT2() ;
 Q "OTH MH Status"
 ;
DATEBEG() ;prompt for beginning date
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGBEGDT,DONE
 S DGDIRA="Start with Date"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGOTHRP1(2)"
 S DGDIRO="DO^:DT:EX"
 S DONE=0
 F  D  Q:DONE
 . ;keep prompting until user enter a valid entry
 . S DGASK=$$ANSWER^DGOTHRPT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 . I DGASK="" W !!," A date is required. Enter '^' to exit.",! S DONE=0 Q
 . I DGASK>0 S DGSORT("DGBEG")=DGASK,DONE=1
 . I DGASK<0 S DONE=1
 Q DGASK>0
 ;
DATEEND() ;prompt for ending date
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DONE
 S DGDIRA=" End with Date: "
 S DGDIRB=$$FMTE^XLFDT(DT)
 S DGDIRH="^D HELP^DGOTHRP1(3)"
 S DGDIRO="DOA^"_DGSORT("DGBEG")_"::EX"
 S DONE=0
 F  D  Q:DONE
 . ;keep prompting until user enter a valid entry
 . S DGASK=$$ANSWER^DGOTHRPT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 . I DGASK>0,DGASK<DGSORT("DGBEG") W !!," Ending date must be after beginning date",! S DONE=0 Q
 . I DGASK>0 S DGSORT("DGEND")=DGASK,DONE=1
 . I DGASK<0 S DONE=1
 Q DGASK>0
 ;
 ;DG*5.3*977 OTH-EXT
SELDIV() ;prompt for DIVISION
 N DIV,FAC,Y,DIVCNT,INS
 I '$D(^DG(40.8,+$O(^DG(40.8,0)),0)) D  Q 0
 . W !!,*7,"***WARNING...MEDICAL CENTER DIVISION FILE IS NOT SET UP",!
 ;get division
 D DIVISION^VAUTOMA
 Q:Y<0 Y>0
 S DGSORT("DIVISION")=VAUTD
 S DIVCNT=0
 I VAUTD=0 D
 . S DIV=0 F  S DIV=$O(VAUTD(DIV)) Q:DIV'>0  D
 . . S FAC=$$STA^XUAF4($$GET1^DIQ(40.8,DIV_",",.07,"I"))
 . . I $G(FAC)="" S FAC=$$GETDIV(DIV)
 . . S DGSORT("DIVISION",DIV,FAC)=$G(VAUTD(DIV))
 . . S DIVCNT=DIVCNT+1
 . ;if user selects only one division
 . ;leave the DGSORT("DIVISION")=0 as is
 . I DIVCNT>1 S DGSORT("DIVISION")=DIVCNT
 E  D
 . S INS="" F  S INS=$O(^DG(40.8,"AD",INS)) Q:INS=""  D
 . . S DIV="" F  S DIV=$O(^DG(40.8,"AD",INS,DIV)) Q:DIV=""  D
 . . . S FAC=$$STA^XUAF4($$GET1^DIQ(40.8,DIV_",",.07,"I"))
 . . . I $G(FAC)="" S FAC=$$GETDIV(DIV)
 . . . S DGSORT("DIVISION",DIV,FAC)=$$GET1^DIQ(40.8,DIV_",",.01,"E")
 Q 1
 ;
 ;DG*5.3*977 OTH-EXT
GETDIV(X) ;get division for one or many but not all
 ;Input X=ien medical center division
 ;Output Y=division number 3-6 characters
 N Y S Y=""
 Q:X="" Y
 S Y=$P($G(^DG(40.8,X,0)),"^",2) ;Get station/facility number
 Q Y
 ;
 ;DG*5.3*977 OTH-EXT
SORTRPT() ;prompt user how the report will be sorted
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DONE
 S DGDIRA="Sort Report By"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGOTHRP1(4)"
 S DGDIRO="SO^1:Division;2:Facility"
 S DONE=0
 F  D  Q:DONE
 . ;keep prompting until user enter a valid entry
 . S DGASK=$$ANSWER^DGOTHRPT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 . I DGASK="" W !!," Report Sort is required. Enter '^' to exit." S DONE=0 Q
 . I DGASK>0 S DGSORT("REPORT")=DGASK_U_$S(DGASK=1:"Division",1:"Patient Name"),DONE=1
 . I DGASK<0 S DONE=1
 Q DGASK>0
 ;
STAT ; Entry point if Queued
 N DGDFN,DGCNT,TMPARY,DGARR,DGOTHIST,DGERR,DGPID,DGRET
 N CNT,DGELIG,DGPEDT,DGOTHSTAT,DGIEN33,OTH90,DGPTNAME
 I $E(IOST)="C" D WAIT^DICD
 N HERE S HERE=$$SITE^VASITE ;extract the IEN and facility name
 N TRM S TRM=($E(IOST)="C")
 S DGDFN=""
 F  S DGDFN=$O(^DGOTH(33,"B",DGDFN)) Q:DGDFN=""  D
 . K DGARR,DGOTHIST,DGERR,DGPID,OTH90,DGPTNAME
 . S DGIEN33=$$HASENTRY^DGOTHD2(DGDFN)
 . S DGCNT=0
 . D GETS^DIQ(33,DGIEN33_",",".01;.02;2*","IE","DGARR","DGERR")
 . Q:$D(DGERR)
 . S OTH90=$$CROSS^DGOTHINQ(DGIEN33,.DGOTHIST)
 . Q:$P(OTH90,U,4)=""                                   ;No history on file
 . S DGPTNAME=DGARR(33,DGIEN33_",",.01,"E")
 . S CNT="" F  S CNT=$O(DGOTHIST(DGIEN33,CNT)) Q:CNT=""  D
 . . K DGELIG,DGPEDT
 . . S DGELIG=$P(DGOTHIST(DGIEN33,CNT),U)
 . . S DGPEDT=$P(DGOTHIST(DGIEN33,CNT),U,2)
 . . I '$$CHKDATE(DGPEDT,.DGSORT) Q
 . . I 1[$P(DGSORT("OTHSTAT"),U),DGARR(33,DGIEN33_",",.02,"I")>0 D BUILD
 . . I 2[$P(DGSORT("OTHSTAT"),U),DGARR(33,DGIEN33_",",.02,"I")<1 D BUILD
 . . I 3[$P(DGSORT("OTHSTAT"),U) D BUILD
 ;print/display the report
 D DSPLY1
 D EXIT
 Q
 ;
BUILD ;
 ;check if there any Outpatient Encounter entry for this patient
 ;DG*5.3*977 OTH-EXT
 K DGRET
 D CHKTREAT^DGPPRP1(.DGRET,+DGDFN,DGSORT("DGBEG"),DGSORT("DGEND"),.VAUTD)
 Q:'$D(DGRET)
 S DGPID=$$SSN^DGOTHRP2(DGDFN)
 S DGOTHSTAT=$S(DGELIG="OTH-90"!(DGELIG="OTH-EXT"):"Active",1:"Inactive")
 S DGCNT=DGCNT+1
 N DGDIV,DGSDT,TMPDIV
 S (DGDIV,DGSDT,TMPDIV)=""
 F  S DGDIV=$O(DGRET(DGDIV)) Q:DGDIV=""  D
 . F  S DGSDT=$O(DGRET(DGDIV,DGSDT)) Q:DGSDT=""  D
 . . S TMPDIV=$P(DGRET(DGDIV,DGSDT),U,2)
 . . I TMPDIV="" S TMPDIV=$S($P(^DG(40.8,DGDIV,0),U,2)="":"UNKNOWN",1:$P(^DG(40.8,DGDIV,0),U,2))
 . . I TMPDIV["UNKNOWN" S DGSORT("DIVISION",DGDIV,TMPDIV)=DGRET(DGDIV,DGSDT)
 . . I 1[$P(DGSORT("REPORT"),U) D BYDIV
 . . E  D BYFAC
 Q
 ;
 ;DG*5.3*977 OTH-EXT
BYDIV ;Build data for report display by DIVISION
 ;
 I '$D(@DGOUT@(TMPDIV,DGPTNAME,DGSDT)) S @DGOUT@(TMPDIV,DGPTNAME,DGSDT)=DGRET(DGDIV,DGSDT)
 S @DGOUT@(TMPDIV,DGPTNAME,DGSDT,DGCNT)=DGDFN_U_DGPID_U_DGPEDT_U_DGOTHSTAT_U_DGELIG
 Q
 ;
 ;DG*5.3*977 OTH-EXT
BYFAC ;Build data for report display by FACILITY 
 I '$D(@DGOUT@(DGPTNAME,TMPDIV,DGSDT)) S @DGOUT@(DGPTNAME,TMPDIV,DGSDT)=DGRET(DGDIV,DGSDT)
 S @DGOUT@(DGPTNAME,TMPDIV,DGSDT,DGCNT)=DGDFN_U_DGPID_U_DGPEDT_U_DGOTHSTAT_U_DGELIG
 Q
 ;
CHKDATE(DGPEDT,DGSORT) ;
 ;Input:
 ;DGMHPEDT - OTH MH Status Primary Eligibility change date
 ;DGSORT - Report parameters
 ;
 ;Output:
 ;Return 1 if Primary Eligibility change date falls within the user-specified date range
 ;Otherwise, 0
 ;check if this patient had at least one active/inactive status in its OTH life cycle
 ;within the user-specified date range
 Q DGSORT("DGBEG")<=DGPEDT&(DGPEDT<=DGSORT("DGEND"))
 ;
DSPLY1 ;Print/Display Report
 N DGPAGE,DDASH,DGQ,SUB1,SUB2,SUB3,SUB4,DGSTR,DGCNT
 N DGOLD,DGOLD1,DGOLD2,DGFAC,DGDIV
 S (DGQ,DGPAGE)=0,$P(DDASH,"-",81)=""
 I $O(@DGOUT@(""))="" D  Q
 .D PRTHDR
 .W !!," >>> No records were found using the report criteria.",!
 .D ASKCONT^DGOTHMG2
 .Q
 ; loop and print/display report
 S (DGSTR,DGCNT,DGOLD,DGOLD1,DGOLD2)=""
 S (SUB1,SUB2,SUB3,SUB4)=""
 I 1[$P(DGSORT("REPORT"),U) D
 .D PRTHDR
 .S DGDIV="" F  S DGDIV=$O(DGSORT("DIVISION",DGDIV)) Q:DGDIV=""  D  Q:DGQ
 ..S DGFAC="" F  S DGFAC=$O(DGSORT("DIVISION",DGDIV,DGFAC)) Q:DGFAC=""  D  Q:DGQ
 ...I '$D(@DGOUT@(DGFAC)) D  Q
 ....D PAUSE^DGOTHRP2(.DGQ) Q:DGQ  D PRTHDR W !
 ....W "Division: ",DGSORT("DIVISION",DGDIV,DGFAC)_" ("_DGFAC_")",!
 ....W !," >>> No records were found for this division.",!!
 ....S DGOLD=DGFAC
 ....Q
 ...I DGOLD1'=SUB1 D PAUSE^DGOTHRP2(.DGQ) Q:DGQ  D PRTHDR W !
 ...D DSPLY2(DGFAC)
 ...Q
 ..Q
 .Q:DGQ
 .W !,"<END OF REPORT>"
 .Q
 I 2[$P(DGSORT("REPORT"),U) D
 . D PRTHDR
 . S SUB1="" F  S SUB1=$O(@DGOUT@(SUB1)) Q:SUB1=""  D  Q:DGQ
 . . D DSPLY2(SUB1)
 . Q:DGQ
 . W !,"<END OF REPORT>"
 Q:DGQ
 D ASKCONT^DGOTHMG2
 Q
 ;
DSPLY2(SUB1) ;
 S SUB2=""  F  S SUB2=$O(@DGOUT@(SUB1,SUB2)) Q:SUB2=""  D  Q:DGQ
 . S SUB3="" F  S SUB3=$O(@DGOUT@(SUB1,SUB2,SUB3)) Q:SUB3=""  D  Q:DGQ
 . . S SUB4="" F  S SUB4=$O(@DGOUT@(SUB1,SUB2,SUB3,SUB4)) Q:SUB4=""  D  Q:DGQ
 . . . K DGSTR
 . . . S DGSTR=$G(@DGOUT@(SUB1,SUB2,SUB3,SUB4))
 . . . I $Y>(IOSL-4) D PAUSE^DGOTHRP2(.DGQ) Q:DGQ  D
 . . . . D PRTHDR W !
 . . . . D DIVHDR($S(1[$P(DGSORT("REPORT"),U):1,1:2))
 . . . . I 1[$P(DGSORT("REPORT"),U) D DIVHDR1(1) Q
 . . . I 1[$P(DGSORT("REPORT"),U) D PRNTDIV
 . . . I 2[$P(DGSORT("REPORT"),U) D PRNTFAC
 . . Q:DGQ
 . Q:DGQ
 Q
 ;
 ;DG*5.3*977 OTH-EXT
PRNTDIV ;Print/Display Report by Division
 I DGOLD1'=SUB1 D
 . D DIVHDR(1),DIVHDR1(1)
 I DGOLD1=SUB1,DGOLD'=$P(DGSTR,U) D DIVHDR1(1)
 ;do not display again the history of the patient if:
 ; 1. Division remains the same
 ; 2. The same patient
 I DGOLD1=SUB1,DGOLD2'=SUB3 Q
 W ?29,$$FMTE^XLFDT($P(DGSTR,U,3),"5Z"),?41,$P(DGSTR,U,4),?51,$E($P(DGSTR,U,5),1,28),!
 Q
 ;
 ;DG*5.3*977 OTH-EXT
DIVHDR(NXTPGE) ;Display Division header
 I NXTPGE=1 W "Division: ",$P(@DGOUT@(SUB1,SUB2,SUB3),U)," (",SUB1,")",!
 I NXTPGE>1 D
 . W $E(SUB1,1,20),?22,$P(DGSTR,U,2)
 . S DGOLD=$P(DGSTR,U),DGOLD1=SUB1,DGOLD2=SUB3
 Q
 ;
 ;DG*5.3*977 OTH-EXT
DIVHDR1(RPTSRT) ;
 W !,$S(RPTSRT=1:$E(SUB2,1,20),1:$E(SUB1,1,20)),?22,$P(DGSTR,U,2)
 S DGOLD=$P(DGSTR,U),DGOLD1=SUB1,DGOLD2=SUB3
 Q
 ;
 ;DG*5.3*977 OTH-EXT
PRNTFAC ;Print/Display Report by Facility
 I $P(DGSTR,U)'=DGOLD D DIVHDR1(2)
 ;do not display again the history of the patient if:
 ; 1. Division remains the same
 ; 2. The same patient
 I $P(DGSTR,U)=DGOLD,DGOLD2'=SUB3 Q
 W ?29,$$FMTE^XLFDT($P(DGSTR,U,3),"5Z"),?41,$P(DGSTR,U,4),?51,$E($P(DGSTR,U,5),1,28),!
 Q
 ;
PRTHDR ;Print/Display Page Header
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1 Q
 N DGFACLTY
 I TRM!('TRM&DGPAGE) W @IOF
 S DGPAGE=$G(DGPAGE)+1
 S DGFACLTY="Facility: "_$P(HERE,U,2)
 W !,?80-$L(ZTDESC)\2,$G(ZTDESC),?71,"Page:",?77,DGPAGE
 W !,?80-$L(DGFACLTY)\2,DGFACLTY
 W !,"Status    :",?12,$P($G(DGSORT("OTHSTAT")),U,2),?46,"Sorted By: ",?58,$P($G(DGSORT("REPORT")),U,2)
 W !,"Date Range:",?12,$$FMTE^XLFDT(DGSORT("DGBEG"),"5Z")_" TO "_$$FMTE^XLFDT(DGSORT("DGEND"),"5Z")
 W ?46,"Printed  :",?58,$$FMTE^XLFDT($$NOW^XLFDT,"MP")
 W !,DDASH
 W !,"PATIENT NAME",?22,"PID",?29,"OTH MH PE",?41,"OTH MH",?51,"Eligibility"
 W !,?29,"Change DT",?41,"Status",?59
 W !,DDASH
 Q
 ;
EXIT ;
 K @DGOUT
 Q
 ;
 ;DG*5.3*977 OTH-EXT
HELP(DGSEL) ;
 ;
 ; Input: DGSEL - prompt var for help text word selection
 ; Output: none
 ;
 I X'="?",X'="??" W !," Not a valid date."
 I DGSEL=1 D
 . W !," Please Enter:",!
 . W !," 1 Activated OTH MH Status"
 . W !,"   If you wish to display a list(s) of patients whose Primary Eligibility"
 . W !,"   was SET TO EXPANDED MH CARE NON-ENROLLEE during selected timeframe,"
 . W !,"   treated in selected division(s))"
 . W !," "
 . W !," 2 Inactivated OTH MH Status"
 . W !,"   If you wish to display a list(s) of patients whose Primary Eligibility"
 . W !,"   was CHANGED FROM being EXPANDED MH CARE NON-ENROLLEE during selected"
 . W !,"   timeframe, treated in selected division(s))."
 . W !," "
 . W !," 3 Both"
 . W !,"   If you wish to display a list(s) of patients whose Primary Eligibility"
 . W !,"   was either set to EXPANDED MH CARE NON-ENROLLEE or changed from being"
 . W !,"   EXPANDED MH CARE NON-ENROLLEE during selected timeframe, treated in"
 . W !,"   selected division(s)."
 I DGSEL=2 D
 . W !," Start Date is today's date, T-(number of days) or a specific date "
 . W !," from the past.",!," Start date cannot be a future date."
 I DGSEL=3 W !," End date must be greater than or equal to the start date."
 I DGSEL=4 D
 . W !," Please Enter:",!
 . W !," 1 Divisions"
 . W !,"   Report output is sorted by Division, sorted first numerically,"
 . W !,"   then alphabetically, then by Patient Name."
 . W !," "
 . W !," 2 Facility"
 . W !,"   Report output will display list(s) of patients treated in the Facility"
 . W !,"   or any Divisions, during selected range, then sorted by Patient Name."
 Q
 ;
 ;END OF DGOTHRP1
