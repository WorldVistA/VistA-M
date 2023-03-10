DGPOTEN ;SLC/RM/JC - POTENTIAL PRESUMPTIVE PSYCHOSIS REPORT ; Apr 1, 2021@12:54:25 pm
 ;;5.3;Registration;**1047**;Aug 13, 1993;Build 13
 ;
 Q
 ;
 ;Main entry point for PRESUMPTIVE PSYCHOSIS POTENTIAL REPORT option
MAIN ;
 N DGSORT   ;array of report parameters
 N ZTDESC,ZTQUEUED,ZTREQ,ZTSAVE,ZTSTOP
 W @IOF
 W "POTENTIAL PRESUMPTIVE PSYCHOSIS REPORT"
 W !!,"This option generates a list of patients who have been registered in"
 W !,"VistA using the Presumptive Psychosis 'workaround' since 38 U.S. Code"
 W !,"1702 was passed on 3/14/2013."
 W !!,"Registration/Eligibility staff can use this list to view patient"
 W !,"registrations to assign the Presumptive Psychosis Indicator found in"
 W !,"VistA screen 7, if applicable."
 W !!,"The default start date is the date the United State Code was put into"
 W !,"effect; however, you can select a later start date.",!
 W !,"You can also select a different end date for the report.  Default is TODAY.",!
 ;Prompt user for FROM Date of Eligibility Change
 I '$$DATEFROM Q
 ;Prompt user for TO Date of Eligibility Change
 I '$$DATETO Q
 ;prompt for device
 W !
 S ZTSAVE("DGSORT(")=""
 S X="POTENTIAL PRESUMPTIVE PSYCHOSIS PATIENT REPORT"
 D EN^XUTMDEVQ("START^DGPOTEN",X,.ZTSAVE)  ;JMC
 D HOME^%ZIS
 Q
 ;
START ; compile and print report
 I $E(IOST)="C" D WAIT^DICD
 N HERE S HERE=$$SITE^VASITE ;extract the IEN and facility name where the report is run
 N TRM S TRM=($E(IOST)="C")
 N DGPOTENLST ;temp data storage used for PP Potential report list
 N RECORD,IBOTHSTAT  ;JMC
 S DGPOTENLST=$NA(^TMP($J,"DGPPPOTEN")) ;contains all PP data to be displayed in the report
 S RECORD=$NA(^TMP($J,"DGPOTENREC")) ;contains all PP episodes of care data found in file #409.68,#52,#405,#45,#350,#399
 S IBOTHSTAT=$NA(^TMP($J,"DGPPIBPOTEN")) ;contains file #350,#399  ;JMC
 K @DGPOTENLST,@RECORD,@IBOTHSTAT  ;JMC
 D LOOP(.DGSORT,DGPOTENLST)
 D PRINTPP(.DGSORT,DGPOTENLST)
 K @DGPOTENLST,@RECORD,@IBOTHSTAT  ;JMC
 D EXIT
 Q
 ;
LOOP(DGSORT,DGPOTENLST) ;
 N DGDFN,VAUTD,SORTENCBY,CPT,DGPTNAME,DGPID,DGDOB,DGENCNT,DGPPWRK,DGPPCAT
 N VAEL,VADM,DGDOD,DATA,VA,DFN,I,I1,DGPPFLGRPT,DGPPREGDT,DGLASTEOC
 S SORTENCBY=0
 ;PP VA Workaround
 ; Registration Screen <7>
 ; - Patient Type: SC Veteran
 ; - Veteran : Yes
 ; - Service Connected: Yes
 ; - Service Connected %: 0%
 ; - Primary Elig Code: SC LESS THAN 50%
 ; - Other Elig Code(s): HUMANITARIAN EMERGENCY
 ; Registration Screen <5>
 ; - VHA DIRECTIVE 1029 WNR   (This is a Free text for insurance buffer entry)
 ; Registration Screen <11>
 ; - Select RATED DISABILITIES (VA):  9410
 ; - DISABILITY %: 0
 ; and/or with
 ; Registration Screen <7>
 ; - PP Indicator (SHRPE 1.0)
 ;Please Note:
 ; This report will not filter the facility/division of the episodes of care where the report is run
 ; It will display all facility/division regardless
 S VAUTD=1   ;All the divisions in the facility, since we are not prompting user to enter Division
 S DGPPFLGRPT=1 ;this flag will be used to determine which mumps code to execute in DGFSMOUT routine
 ;Loop through all PATIENT file #2
 S (DGDFN,CPT)=0 F  S DGDFN=$O(^DPT(DGDFN)) Q:'DGDFN  D
 . S CPT=CPT+1 W:'(CPT#60000) "." ;write . every 60,000 processed records
 . S DGPPCAT=$$PPINFO^DGPPAPI(DGDFN)
 . Q:$P(DGPPCAT,U)="Y"  ;patients with PP category will not be included into the report
 . S DGPPWRK=$$PPWRKARN^DGPPAPI(DGDFN) ;check if this patient is registered correctly using PP VA workaround settings
 . I $P(DGPPCAT,U)'="Y" S DGPPCAT="N"
 . I DGPPWRK="Y",DGPPCAT="N" D  ;if PP VA Workaround exist, extract episode of care/inpatient/bill charges/rx
 . . K @RECORD ;evaluate each patient one at a time
 . . S (DGENCNT,I1,I)=0
 . . S DGPTNAME=$$GET1^DIQ(2,DGDFN_",",.01,"E")
 . . S DGPID=$$GET1^DIQ(2,DGDFN_",",.0905,"I")
 . . S DGPPREGDT=$$GET1^DIQ(2,DGDFN_",",.097,"I") ;Vista Registration Entry
 . . S DGLASTEOC=$$LASTEOC(DGDFN)
 . . S DGDOD=$$GET1^DIQ(2,DGDFN_",",.351,"I")\1 ;date of death
 . . S DATA=DGPTNAME_U_DGPID_U_DGPPREGDT_U_DGLASTEOC_U_$S(+DGDOD<1:"N/A",1:DGDOD)
 . . I $G(DGLASTEOC)="NO DATA FOUND" Q  ;JMC  Prevents either out of range or no data found from appearing on report.
 . . S @DGPOTENLST@(DGPTNAME,DGDFN)=DATA
 Q
 ;
LASTEOC(DFN) ;extract all Episode of Care and Rx and return the most current Episode of Care for a patient
 N DGLASTEOC
 D CHKTREAT^DGFSMOUT(+DFN,DGSORT("DGBEG"),DGSORT("DGEND"),.VAUTD,0) ;check if there any past Outpatient Encounter entry in file #409.68
 D CHECKPTF^DGFSMOUT(DFN,DGSORT("DGBEG"),DGSORT("DGEND"),"DGPPIBPOTEN") ;check if there any Inpatient stay entry in file #405
 D CHECKIB^DGFSMOUT("DGPPIBPOTEN",DGSORT("DGBEG"),DGSORT("DGEND")) K ^TMP($J,"DGPPIBPOTEN") ;check if this patient has records in file #350 or file #399
 D CHECKRX^DGFSMOUT("DGPPRXPOTEN") ;check at file #52 if this patient has any RX not yet charged
 I $O(@RECORD@(""))="" S DGLASTEOC="NO DATA FOUND"
 E  D PPDATE
 I DGLASTEOC<DGSORT("DGBEG") S DGLASTEOC="NO DATA FOUND"
 I DGLASTEOC>DGSORT("DGEND") S DGLASTEOC="NO DATA FOUND"
 Q DGLASTEOC
 ;
PPDATE ;
 N DGDOS,DGSTATN,FILENO,CNT,PPDTARY
 S DGLASTEOC=0
 S DGDOS="" F  S DGDOS=$O(@RECORD@(DGDOS)) Q:DGDOS=""  D
 . S DGSTATN="" F  S DGSTATN=$O(@RECORD@(DGDOS,DGSTATN)) Q:DGSTATN=""  D
 . . S FILENO="" F  S FILENO=$O(@RECORD@(DGDOS,DGSTATN,FILENO)) Q:FILENO=""  D
 . . . S CNT="" F  S CNT=$O(@RECORD@(DGDOS,DGSTATN,FILENO,CNT)) Q:CNT=""  D
 . . . . I '$D(PPDTARY(DGDOS\1))="" S DGLASTEOC=DGDOS\1
 . . . . E  I DGLASTEOC<DGDOS\1 S DGLASTEOC=DGDOS\1
 Q
 ;
PRINTPP(DGSORT,DGPOTENLST) ;
 N DGPAGE,DDASH,DGQ,DGDFN,DGTOTAL,DGPRINT,DGOLD,DGSTATN,DGPTNAME,DGLSTEOC,DGDOD,DGDTOFREG
 S (DGQ,DGTOTAL,DGPAGE,DGPRINT,DGOLD)=0,$P(DDASH,"=",81)=""
 I $O(@DGPOTENLST@(""))="" D  Q
 . D HEADER,COLHEAD
 . W !!!," >>> No records were found using the report criteria.",!!
 . W ! D LINE
 . D ASKCONT(0)
 ; loop and print report
 D HEADER,COLHEAD
 S DGPTNAME="" F  S DGPTNAME=$O(@DGPOTENLST@(DGPTNAME)) Q:DGPTNAME=""  D  Q:DGQ
 . S DGDFN="" F  S DGDFN=$O(@DGPOTENLST@(DGPTNAME,DGDFN)) Q:DGDFN=""  D  Q:DGQ
 . . I $Y>(IOSL-4) W ! D PAUSE(.DGQ) Q:DGQ  D HEADER,COLHEAD
 . . S DGDTOFREG=$P(@DGPOTENLST@(DGPTNAME,DGDFN),U,3)
 . . W $E(DGPTNAME,1,30),?32,$P(@DGPOTENLST@(DGPTNAME,DGDFN),U,2),?39,$S(DGDTOFREG'="":$$FMTE^XLFDT(DGDTOFREG,"5Z"),1:"NONE ENTERED")
 . . S DGLSTEOC=$P(@DGPOTENLST@(DGPTNAME,DGDFN),U,4)
 . . I DGLSTEOC'?.N W ?53,DGLSTEOC
 . . E  W ?53,$$FMTE^XLFDT(DGLSTEOC,"5Z")
 . . S DGDOD=$P(@DGPOTENLST@(DGPTNAME,DGDFN),U,5)
 . . I DGDOD'?.N W ?69,DGDOD
 . . E  W ?69,$$FMTE^XLFDT(DGDOD\1,"5Z")
 . . W !
 . . S DGTOTAL=DGTOTAL+1
 . Q:DGQ
 Q:DGQ
 D LINE
 W !!,"Number of Unique Patients:  ",$J(DGTOTAL,5)
 W !!,"<< end of report >>"
 D ASKCONT(0) W @IOF
 Q
 ;
HEADER   ;Display header for the report
 ;
 N DGFACLTY,DGDTRNGE,DTPRNTD
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DGQ)=1 Q
 I TRM!('TRM&DGPAGE) W @IOF
 S DGPAGE=$G(DGPAGE)+1
 W "REPORT RUN DATE: ",$$FMTE^XLFDT($$NOW^XLFDT,"MP")
 W ?44,"DATE RANGE: ",$$FMTE^XLFDT(DGSORT("DGBEG"),"5Z")," TO ",$$FMTE^XLFDT(DGSORT("DGEND"),"5Z")
 W ! D LINE W !
 W ?(80-$L(ZTDESC))\2,$G(ZTDESC),?70,"Page: ",DGPAGE
 S DGFACLTY="FACILITY: "_$P(HERE,U,2)
 W !,?(80-$L(DGFACLTY))\2,DGFACLTY
 W ! D LINE W !
 Q
 ;
LINE     ;prints double dash line
 N LINE
 F LINE=1:1:80 W "="
 Q
 ;
COLHEAD  ;report column header
 W "PATIENT NAME",?32,"PID",?39,"REGISTRATION",?53,"LAST EPISODE",?69,"DATE OF"
 W !,?39,"DATE",?53,"OF CARE",?69,"DEATH"
 W ! D LINE W !
 Q
 ;
ASKCONT(FLAG) ; display "press <Enter> to continue" prompt
 N Z
 W !!,$$CJ^XLFSTR("Press <Enter> to "_$S(FLAG=1:"continue.",1:"exit."),20)
 R !,Z:DTIME
 Q
 ;
PAUSE(DGQ) ; pause screen display
 ; Input: 
 ; DGQ - var used to quit report processing to user CRT
 ; Output:
 ; DGQ - passed by reference - 0 = Continue, 1 = Quit
 ;
 I $G(DGPAGE)>0,TRM K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 DGQ=1
 Q
 ;
EXIT ;
 Q
 ;
DATEFROM() ;prompt for FROM Date of Service
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGBEGDT,DGSTRTDT
 S DGBEGDT=3130314 ;03/14/2013 - Presumptive Psychosis legislation date
 S DGDIRA=" Start with Date:  "
 S DGDIRB=$$FMTE^XLFDT(DGBEGDT)
 S DGDIRH="^D HELP^DGPPRRPT(1)"
 S DGDIRO="DA^"_DGBEGDT_":DT:EX"
 S DGASK=$$ANSWER(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGBEG")=$S(DGASK<DGBEGDT:DGBEGDT,1:DGASK)
 Q DGASK>0
 ;
DATETO() ;prompt for TO Date of Service
 N DGASK,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGDTEND
 S DGDIRA=" End with Date  :  "
 S DGDIRB="TODAY"
 S DGDIRH="^D HELP^DGPPRRPT(1)"
 S DGDTEND=DGSORT("DGBEG")
 S DGDIRO="DA^"_DGSORT("DGBEG")_":DT:EX"
 S DGASK=$$ANSWER(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I DGASK>0 S DGSORT("DGEND")=DGASK
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
 I $D(DGDIRA) M DIR("A")=DGDIRA
 I $G(DGDIRB)]"" S DIR("B")=DGDIRB
 I $D(DGDIRH) S DIR("?")=DGDIRH,DIR("??")=DGDIRH
 D ^DIR K DIR
 S Z=$S($D(DTOUT):-2,$D(DUOUT):-1,$D(DIROUT):-1,1:"")
 I Z="" S Z=$S(Y=-1:"",X="@":"@",1:$P(Y,U)) Q Z
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(X="@":"@",1:$P(Y,U))
 ;
