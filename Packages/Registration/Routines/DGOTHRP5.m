DGOTHRP5 ;SLC/RED,RM - OTHD (OTHER THAN HONORABLE DISCHARGE) Reports ;April 03,2019@10:16
 ;;5.3;Registration;**952,977**;4/30/19;Build 177
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;IA's
 ;  10015 Sup   GETS^DIQ
 ;  10103 Sup   ^XLFDT: $$FMTE, $$NOW
 ;  10026 Sup   ^DIR
 ;  10063 Sup   ^%ZTLOAD
 ;  10104 Sup   $$CJ^XLFSTR
 ;  10024 Sup   WAIT^DICD
 ;  10112 Sup   $$SITE^VASITE
 ;  10003 Sup   %DT
 ;  10089 Sup   %ZISC
 ;
 Q  ; No direct access
 ;
EN ;entry point from Menu Option: DGOTH OTH-90 STATUS REPORTS
 N DGIEN33,NAME,PID,PROMPT,DGRTYP,DGRET,PAGE,DGDTFRM,DGDTTO,DGARR,DGERR,DGDIV,NAME,PID,ZTSK,DGDTFRMTO,DASH,DGREM,SET,EXIT
 N ZTSAVE   ;open array reference of input parameters used by tasking
 N ZTDESC   ;contains the free-text description of your task that you passed to the Program Interface
 N ZTQUEUED ;background execution
 N ZTREQ    ;post-execution
 N ZTSTOP
 N ZTRTN
 N ZTSK
 N VAUTD,Y  ; variables for DIVISION^VAUTOMA
 N DGSORT   ;array or report parameters
 N DGENCTR  ;array for the outpatient encounter
 N HERE
 ;check for database
 ;DG*5.3*977 OTH-EXT
 I '+$O(^DGOTH(33,"B","")) W !,$$CJ^XLFSTR(">>> No OTH-90 records have been found. <<<",80) D ASKCONT^DGOTHMG2 Q
 S DGRET=$NA(^TMP("DGOTHRP5",$J)) K @DGRET,DGSORT,VAUTD
 S (EXIT,DGIEN33,PAGE)=0
 W @IOF
 W !,"OTH 90-DAY PERIOD AUTHORIZATION REPORT"
 W !!,"This option generates a report that prints a listing of OTH-90 patients who"
 W !,"have an Outpatient Encounter with STATUS=CHECKED OUT for Clinic(s) associated"
 W !,"with the selected Division(s) within the user-specified date range in which"
 W !,"their 90-Day period of care has been APPROVED, PENDING or DENIED."
 S PROMPT="Please select OTH-90 Authorization report type",SET="S^1:Approved;2:Pending;3:Denied"
 S DGRTYP=$$SELECT(PROMPT,SET)
 I 'Y G OUT   ;quit if no selection
 I Y S DGRTYP=$S(Y=1:"APPROV",Y=2:"PEND",1:"DENIED")
 S DGDTFRMTO=$$DTFRMTO("Select dates")
 Q:DGDTFRMTO=0
 ;
 ;DG*5.3*977 OTH-EXT
 ;prompt user to select DIVISION
 W !!,"Please select divisions to include in the report"
 I '$$SELDIV^DGOTHRP1 Q
 ;DGSORT("DIVISION")=0 -- user only select one division
 ;DGSORT("DIVISION")=1 -- user select ALL division
 ;DGSORT("DIVISION")>1 -- user select multiple division but not all
 ;if user selected division is many or all but not one
 ;prompt user on how the report will be sorted
 I DGSORT("DIVISION")>0,'$$SORTRPT^DGOTHRP1 Q
 I DGSORT("DIVISION")=0 S DGSORT("REPORT")="1^Patient Name" ;default to sort report by divisions
 ;prompt for device
 W !
 S ZTSAVE("DGSORT(")=""
 S X="OTH-90 AUTHORIZATION REPORT"
 D EN^XUTMDEVQ("DQ^DGOTHRP5",X,.ZTSAVE)
 D HOME^%ZIS
 Q
 ;
DQ ;
 I $E(IOST)="C" D WAIT^DICD
 S HERE=$$SITE^VASITE ;extract the IEN and facility name
 N TRM S TRM=($E(IOST)="C")
 N DGDFN
 S DGDFN=""
 F  S DGDFN=$O(^DGOTH(33,"B",DGDFN)) Q:DGDFN=""  D
 . ; Start search logic here and then head to reports
 . S DGIEN33=$$HASENTRY^DGOTHD2(DGDFN)
 . K DGARR,DGERR D GETS^DIQ(33,DGIEN33_",",".01;.02;.06;.07;1*","EI","DGARR","DGERR")
 . Q:$D(DGERR)
 . Q:DGARR(33,DGIEN33_",",.02,"I")=0
 . ;DG*5.3*977 OTH-EXT
 . ;Patient's primary eligibility code is no longer EXPANDED MH CARE NON-ENROLLEE
 . Q:$$ISOTHD^DGOTHD(DGDFN)=0
 . ;Patient's current MH CARE TYPE is no longer OTH-90
 . Q:'$$ISOTH90^DGOTHRP2(DGDFN)
 . N NAME,PID,DGDIV S PID=$$GET1^DIQ(2,DGARR(33,DGIEN33_",",.01,"I"),".0905","E"),NAME=DGARR(33,DGIEN33_",",.01,"E")
 . D @DGRTYP
 D PRINT,OUT
 Q
 ;
APPROV ;Approved authorizations
 N DG90A,DGRES9,DG365,DGDATA
 D CLOCK^DGOTHINQ(DGIEN33)
 Q:'$D(DG90A(2))
 S DG365=$$LASTPRD^DGOTHUT1(DGIEN33)
 N DGPER S DGPER=1 F DGPER=2:1:$P(DG365,U,3) D
 . S DGDATA=$$GETAUTH^DGOTHUT1(DGIEN33,$P(DG365,U),DGPER),DGDIV=$P(DGDATA,U,9)
 . Q:$P(DGDATA,U,8)=""                                 ;Not authorized yet
 . I DGDIV="" S DGDIV="UNKN"
 . I $P(DGDATA,U,3)<DGDTFRM!($P(DGDATA,U,3)>DGDTTO) Q  ;Not within the date range
 . Q:'$$CHECKOE()  ;check if there any Outpatient Encounter entry for this patient
 . D BUILD
 Q
 ;
CHECKOE() ;check if there any Outpatient Encounter entry for this patient
 K DGENCTR
 D CHKTREAT^DGPPRP1(.DGENCTR,+DGDFN,DGDTFRM,DGDTTO,.VAUTD)
 Q $S('$D(DGENCTR):0,1:1)
 ;
BUILD ;Build data either by Division or Facility
 N DGDIVOE,DGSDT,TMPDIV
 S (DGDIVOE,DGSDT,TMPDIV)=""
 F  S DGDIVOE=$O(DGENCTR(DGDIVOE)) Q:DGDIVOE=""  D
 . F  S DGSDT=$O(DGENCTR(DGDIVOE,DGSDT)) Q:DGSDT=""  D
 . . S TMPDIV=$P(DGENCTR(DGDIVOE,DGSDT),U,2)
 . . I TMPDIV="" S TMPDIV=$S($P(^DG(40.8,DGDIVOE,0),U,2)="":"UNKNOWN",1:$P(^DG(40.8,DGDIVOE,0),U,2))
 . . I TMPDIV["UNKNOWN" S DGSORT("DIVISION",DGDIVOE,TMPDIV)=$P(DGENCTR(DGDIVOE,DGSDT),U)
 . . I 1[$P(DGSORT("REPORT"),U),'$D(@DGRET@(TMPDIV)) S @DGRET@(TMPDIV)=DGENCTR(DGDIVOE,DGSDT)
 . . I DGRTYP="APPROV" D
 . . . S @DGRET@(TMPDIV,NAME,DGPER)=NAME_U_PID_U_$$FMTE^XLFDT($P($P(DGDATA,U,4),"."),"5Z")_U_$$FMTE^XLFDT($P($P(DGDATA,U,5),"."),"5Z")_U_$$FMTE^XLFDT($P($P(DGDATA,U,3),"."),"5Z")_U_$P(DGDATA,U,8)
 . . I DGRTYP="PEND" D
 . . . S @DGRET@(TMPDIV,NAME)=NAME_U_PID_U_$$FMTE^XLFDT($P(DGRES9,U,2),"5Z")_U_DGREM
 . . I DGRTYP="DENIED" D
 . . . S @DGRET@(TMPDIV,NAME,SEQ)=NAME_U_PID_U_$$FMTE^XLFDT($P(DGRES,U,2),"5Z")_U_DGREAS
 Q
 ;
PEND ; Pending Requests
 Q:DGARR(33,DGIEN33_",",.07,"I")=""
 N DG90A,DGRES9 S DGRES9=$$GETPEND^DGOTHUT1(DGARR(33,DGIEN33_",",.01,"I"))
 Q:DGRES9<1
 S DGDIV=$P(DGRES9,U,5),DGREM=$$FMDIFF^XLFDT(DT,$P(DGRES9,U,2),1)
 I $P(DGRES9,U,2)<DGDTFRM!($P(DGRES9,U,2)>DGDTTO) Q    ;Not within the date range
 Q:'$$CHECKOE()  ;check if there any Outpatient Encounter entry for this patient
 D BUILD
 Q
 ;
DENIED ;Denied requests
 N SEQ,DGRES
 Q:'$D(^DGOTH(33,DGIEN33,3))
 N DGLDEN,DGDIV,DGREAS S DGLDEN=999,DGLDEN=$O(^DGOTH(33,DGIEN33,3,"B",DGLDEN),-1)
 F SEQ=1:1:DGLDEN D
 . S DGRES=$$GETDEN^DGOTHUT1(DGIEN33,SEQ)
 . Q:DGRES<1
 . I $P(DGRES,U,2)<DGDTFRM!($P(DGRES,U,2)>DGDTTO) Q       ;Not within the date range
 . Q:'$$CHECKOE()  ;check if there any Outpatient Encounter entry for this patient
 . S DGDIV=$P(DGRES,U,6),DGREAS=$P(DGRES,U,3)
 . D BUILD
 Q
 ; 
HDR ; Print page header
 S PAGE=$G(PAGE)+1
 W @IOF W ?15,"Other Than Honorable '",$S(DGRTYP="APPROV":"APPROVED",DGRTYP="PEND":"PENDING",1:"DENIED"),"' Authorizations",?70,"Page: ",PAGE
 W !?15,"Selected date range: ",$$FMTE^XLFDT(DGDTFRM,"5Z")," to ",$$FMTE^XLFDT(DGDTTO,"5Z"),!
 W "Facility: "_$P(HERE,U,2),?51,"Sorted By: ",$P(DGSORT("REPORT"),U,2),!
 F DASH=1:1:80 W "-"
 I DGRTYP="APPROV" D
 . W !,"Name",?23,"PID",?30,"Date Req.",?42,"Date Auth.",?54,"90-Day",?66,"Authorized By"
 . W !,?30,"Submitted",?42,"Received",?54,"Start DT",!
 I DGRTYP="PEND" W !,"Name",?33,"PID",?41,"Pending Auth.",?58,"# of Days Auth.",!,?41,"Request Date",?58,"is Pending",!
 I DGRTYP="DENIED" W !,"Name",?24,"PID",?31,"Date Request",?45,"Authorization Comment",!,?31,"Submitted",!
 F DASH=1:1:80 W "-"
 ;
 Q
 ;
PRINT ;Print out results
 N DGFAC,DGOLDIV,FACILITY,DGPTLIST,DGOEIEN
 S DGOLDIV=""
 K DGPTLIST
 I '$D(@DGRET) D HDR W !!," >>> No records were found using the report criteria.",! G OUT
 I 2[$P(DGSORT("REPORT"),U) D
 . D HDR
 . S DGFAC=0 F  S DGFAC=$O(@DGRET@(DGFAC)) Q:DGFAC=""!(EXIT)  D PRINT1 Q:EXIT
 E  D
 . S DGOEIEN="" F  S DGOEIEN=$O(DGSORT("DIVISION",DGOEIEN)) Q:DGOEIEN=""  D  Q:EXIT
 . . S DGFAC="" F  S DGFAC=$O(DGSORT("DIVISION",DGOEIEN,DGFAC)) Q:DGFAC=""  D  Q:EXIT
 . . . D HDR,DVISION
 . . . I '$D(@DGRET@(DGFAC)) D  Q
 . . . . W !," >>> No records were found for this Division.",!!
 . . . . I ($E(IOST,1,2)="C-")&(IO=IO(0)) S DIR(0)="E" D ^DIR K DIR D
 . . . . . I $D(DTOUT)!($D(DUOUT)) S EXIT=1 G OUT
 . . . D PRINT1
 Q:EXIT
 I $E(IOST,1,2)="C-" R !!?8,"End of the Report...Press Enter to Continue",X:DTIME W @IOF
 Q
 ;
 ;DG*5.3*977 OTH-EXT
DVISION ;
 W "Division: ",DGSORT("DIVISION",DGOEIEN,DGFAC)_" ("_DGFAC_")",!
 Q
 ;
PRINT1 ;Print out results
 N DGOLDNM,SEQ
 S DGOLDNM=""
 N NAME,DGPER
 S NAME="" F  S NAME=$O(@DGRET@(DGFAC,NAME)) Q:NAME=""  D
 . I DGRTYP="APPROV" D  Q
 . . S DGPER=0 F  S DGPER=$O(@DGRET@(DGFAC,NAME,DGPER)) Q:DGPER=""  D
 . . . I $Y+3>IOSL I ($E(IOST,1,2)="C-")&(IO=IO(0)) S DIR(0)="E" D ^DIR K DIR D
 . . . . I $D(DTOUT)!($D(DUOUT)) S EXIT=1 G OUT
 . . . . D HDR
 . . . . I 1[$P(DGSORT("REPORT"),U) D DVISION
 . . . . I DGOLDNM=NAME W !,$E(NAME,1,22),?23,$P(@DGRET@(DGFAC,NAME,DGPER),U,2)
 . . . I 'EXIT D
 . . . . ;do not display the patient's name twice is sort by facility is selected
 . . . . I 2[$P(DGSORT("REPORT"),U),$D(DGPTLIST(NAME,DGPER)) Q
 . . . . ;display the patient name and PID once only
 . . . . I DGOLDNM'=NAME W !,$E(NAME,1,22),?23,$P(@DGRET@(DGFAC,NAME,DGPER),U,2) S DGOLDNM=NAME
 . . . . W ?30,$P(@DGRET@(DGFAC,NAME,DGPER),U,3),?42,$P(@DGRET@(DGFAC,NAME,DGPER),U,4),?54,$P(@DGRET@(DGFAC,NAME,DGPER),U,5)
 . . . . W ?66,$E($P(@DGRET@(DGFAC,NAME,DGPER),U,6),1,14),!
 . . . I 2[$P(DGSORT("REPORT"),U),'$D(DGPTLIST(NAME,DGPER)) S DGPTLIST(NAME,DGPER)=""
 . I DGRTYP="PEND" D  Q
 . . I $Y+3>IOSL I ($E(IOST,1,2)="C-")&(IO=IO(0)) S DIR(0)="E" D ^DIR K DIR D
 . . . I $D(DTOUT)!($D(DUOUT)) S EXIT=1 G OUT
 . . . D HDR
 . . I 'EXIT D
 . . . ;do not display the patient's name twice is sort by facility is selected
 . . . I 2[$P(DGSORT("REPORT"),U),$D(DGPTLIST(NAME)) Q
 . . . W !,$E(NAME,1,30),?33,$P(@DGRET@(DGFAC,NAME),U,2),?41,$P(@DGRET@(DGFAC,NAME),U,3),?60,$J($P(@DGRET@(DGFAC,NAME),U,4),5)
 . . I 2[$P(DGSORT("REPORT"),U),'$D(DGPTLIST(NAME)) S DGPTLIST(NAME)=""
 . I DGRTYP="DENIED" D  Q
 . . S SEQ=0 F  S SEQ=$O(@DGRET@(DGFAC,NAME,SEQ)) Q:SEQ=""  D
 . . . I $Y+3>IOSL I ($E(IOST,1,2)="C-")&(IO=IO(0)) S DIR(0)="E" D ^DIR K DIR D
 . . . . I $D(DTOUT)!($D(DUOUT)) S EXIT=1 G OUT
 . . . . D HDR
 . . . I 'EXIT D
 . . . . ;do not display the patient's name twice is sort by facility is selected
 . . . . I 2[$P(DGSORT("REPORT"),U),$D(DGPTLIST(NAME,SEQ)) Q
 . . . . ;display the patient name and PID once only
 . . . . I DGOLDNM'=NAME W !,$E(NAME,1,22),?24,$P(@DGRET@(DGFAC,NAME,SEQ),U,2) S DGOLDNM=NAME
 . . . . W ?31,$P(@DGRET@(DGFAC,NAME,SEQ),U,3),?45,$E($P(@DGRET@(DGFAC,NAME,SEQ),U,4),1,35),!
 . . . I 2[$P(DGSORT("REPORT"),U),'$D(DGPTLIST(NAME)) S DGPTLIST(NAME,SEQ)=""
 Q:EXIT
 I 1[$P(DGSORT("REPORT"),U) I ($E(IOST,1,2)="C-")&(IO=IO(0)) S DIR(0)="E" W ! D ^DIR K DIR D
 . I $D(DTOUT)!($D(DUOUT)) S EXIT=1 G OUT W !
 Q
 ;
DTFRMTO(PROMPT)  ;Get from and to dates 
 N %DT,Y,X,DTOUT,OUT,DIRUT,DUOUT,DIROUT,STATUS,STDT,STATUS
 ;INPUT ;   PROMPT - Message to display prior to prompting for dates
 ;OUTPUT:     1^BEGDT^ENDDT - Data found
 ;            0             - User up arrowed or timed out
 ;If they want to show first available date for that set of Status, use this sub
INDT ;
 S OUT=0
 S DIR(0)="DO^"_DT_":"_DT_":EX"
 S %DT="AEX",%DT("A")="Starting date - From: "                               ;Enter Beginning Date: "
 W ! D ^%DT K %DT
 I Y<0 W !!,"No Date selected, quitting. ",!! Q OUT                          ;Quit if user time out or didn't enter valid date
 I Y>DT W !!,"Future dates are not allowed, please re-enter" K Y,%DT G INDT  ;Future dates not allowed
 S DGDTFRM=+Y
TODT S %DT="AEX",%DT("A")="  Ending date - TO: ",%DT("B")="T"         ; Get end date, default is "TODAY"
 D ^%DT K %DT
 ;Quit if user time out or didn't enter valid date
 I Y<0 W !!,"No Date selected, quitting. ",!! Q OUT
 I Y<DGDTFRM W !!,"Ending date must be greater than or equal to the start date",!! K Y,%DT G TODT
 S DGDTTO=+Y,OUT=1_U_DGDTFRM_U_DGDTTO
 ;Switch dates if Begin Date is more recent than End Date
 S:DGDTFRM>DGDTTO OUT=1_U_DGDTTO_U_DGDTFRM
 Q OUT
 ;
SELECT(PROMPT,SET) ; prompts for a report type
 ;INPUT:
 S DIR(0)=SET,DIR("A")=PROMPT,DIR("B")=1,DIR("?")="^D HELP^DGOTHRP5(1)",DIR("??")=DIR("?") D ^DIR K DIR
 Q:Y<0 OUT
 Q Y
 ;
OUT ; KILL RETURN ARRAY QUIT
 D ^%ZISC
 K @DGRET
 Q
 ;
 ;DG*5.3*977 OTH-EXT
HELP(DGSEL) ;OTH-90 Authorization Report help text
 I DGSEL=1 D
 . W !,"  Please ENTER:",!
 . D TEXT
 . W !,"    1 = That have been 'APPROVED' for an additional 90-Day"
 . W !,"        period of care."
 . W !,"    2 = Whose request for an additional 90-Day period of"
 . W !,"        care is waiting to be approved or denied."
 . W !,"    3 = Whose request for an additional 90-Day period of"
 . W !,"        care has been DENIED."
 Q
 ;
 ;DG*5.3*977 OTH-EXT
TEXT ;
 W !,"  If you wish to print a list(s) of OTH-90 MH Care"
 W !,"  patient who have an Outpatient Encounter with"
 W !,"  STATUS=CHECKED OUT for selected Division within"
 W !,"  the user-specified date range.",!
 Q
 ;
