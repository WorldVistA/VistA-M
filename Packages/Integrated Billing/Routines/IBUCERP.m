IBUCERP ;EDE/LLB - IBUC VISIT EXCEPTION REPORT;09-MAR-23
 ;;2.0;INTEGRATED BILLING;**761**;21-MAR-94;Build 27
 ;; Per VHA Directive 6402, this routine should not be modified
 ;
 ;   IBQUIT = 1, if user entered "^" (Devices starting with "C-" only)
REPORT ;
 N SORT,IBFLTR,IBFLTRBY,IBQUIT,IBNAME,IBLSITNM,IBLSITNB,IBEXCEL
 S IBQUIT=0
 W @IOF
 W !,"Integrated Billing Urgent Care Exception Report"
 D ASKFLTR I $G(IBQUIT)=1 Q
 D ASKSORT I $G(SORT)<0!($G(IBQUIT)=1) Q
 S IBEXCEL=$$EXCEL^IBJD ; Asks if output is EXCEL format
 I IBEXCEL D EXCMSG ;Display EXCEL device recommendations
 D ASKDEV
 Q
 ;
REPORT1 ; Entry point for Report Generation
 D COLLECT
 D PRTRPT
 Q
 ;
ASKFLTR ; Ask what to filter by
 ; Use index on field 3.03 to display a list of sites that can be selected
 ; to filter by
 ; Loop asking for filter values until user <ENTER> with no value
 ; store values in temporary array to test against in the report.
 N CNT,Y,ARRAY
 N X,Y,IBJ,DIR,DA,DIRUT,DTOUT,DUOUT,DIROUT,IBCNTIT
 S IBFLTRBY="/"
 S IBFLTR=""
 K DIR
 S DIR("A")="Filter by Remote Site/Division (Y/N): "
 S DIR(0)="Y"
 S DIR("B")="NO"
 D ^DIR
 K DIR
 I $D(DUOUT) S IBQUIT=1 Q
 S IBFLTR=Y
 I '$G(Y) S IBFLTRBY="" Q
 ;ASK FOR INSTITUTION TO FILTER BY
 S CNT=0
 D DISPLST
 W !,"Select Site/Division from list above",!
 S IBCNTIT=0
 F  D GETINST Q:Y=""!($G(DUOUT))!($G(DTOUT))
 Q
 ;
DISPLST ;
 K ARRAY,IBNAME
 S IBNAME="" F  S IBNAME=$O(^IBUC(351.82,"ARS",IBNAME)) Q:IBNAME=""  D
 . S CNT=CNT+1
 . D GETS^DIQ(4,IBNAME_",",".01","EI","ARRAY")
 . S IBNAME(CNT)=IBNAME_"-"_ARRAY(4,IBNAME_",",.01,"E") W !,IBNAME,?6,ARRAY(4,IBNAME_",",.01,"E")
 Q
 ;
GETINST ;
 N X,IBJ,DIR,DA,VALID
 K DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT
 S DIR(0)="FOU"
 S DIR("A")="Enter Site/Division to filter by, <ENTER> for all, or ^ to exit"
 I IBCNTIT>0 S DIR("A")="Enter another Site/Division or <ENTER> to continue, or ^ to Exit report."
RPTASK ;
 D ^DIR
 ; Test for user entered nothing i.e. Y="" or timeout
 I $G(DUOUT) S IBQUIT=1 Q
 I $G(DTOUT)!(Y="") Q
 S Y=$$UP^XLFSTR(Y) ;Convert user response to upper case
 S VALID=$$TSTVALID() ; Test if the entry is in the list to select from
 I 'VALID W !,"INVALID SELECTION try again" G RPTASK
 S IBCNTIT=IBCNTIT+1
 S IBFLTRBY=IBFLTRBY_Y_"/"
 Q
 ;
TSTVALID() ; Checks if the enty is in the list of sites with exceptions
 N IBSTOP,IBCNT S IBSTOP=50000
 S IBSTOP=$O(IBNAME(IBSTOP),-1)
 S VALID=0
 F IBCNT=1:1:IBSTOP Q:VALID=1  I IBNAME(IBCNT)[Y S VALID=1,Y=IBNAME(IBCNT) Q
 Q VALID
 ;
ASKSORT ; Ask for sorting preferences
 N X,Y,IBJ,DIR,DA,DIRUT,DTOUT,DUOUT,DIROUT
 K DIR,Y(0)
 W ! S DIR(0)="SA^P:Patient;E:Exception Site;B:Bill Number"
 S DIR("A")="Sort by: (P)atient,(E)xception Site,(B)ill Number (P/E/B) "
 S DIR("B")="P"
 D ^DIR
 K DIR
 I $G(DUOUT) S IBQUIT=1 Q
 S SORT=$S(Y="P":"PAT",Y="B":"BN",Y="E":"ES",1:"PAT")
 I $G(DTOUT) K DIRUT,DUOUT,DTOUT S SORT="PAT"
 Q
 ;
COLLECT ;Collect data into ^TMP($J,"UCEXRPT",CNT)
 N EIN,CNT,IBES,IBBN,IBPAT,IBPATNM,IBESITE,IBRSN,IBESITEN,IBTES
 N ARRAY,IBRESN,IBTSITE,IBLSITE,IBVSTDT,IBLSTNUM,PH
 S CNT=0,EIN=""
 K ^TMP($J,"IBEXRPT")
 F  S EIN=$O(^IBUC(351.82,"AT",1,EIN)) Q:'EIN  D
 . S CNT=CNT+1
 . K ARRAY
 . D GETS^DIQ(351.82,EIN_",",".01;.02;.03;.05;.06;3.01;3.02;3.03","EI","ARRAY")
 . S IBPAT=ARRAY(351.82,EIN_",",.01,"I")
 . S IBPATNM=ARRAY(351.82,EIN_",",.01,"E")
 . I $E(IBPATNM,1,2)="ZZ" Q
 . S IBLSITE=ARRAY(351.82,EIN_",",.02,"E")
 . S IBLSTNUM=ARRAY(351.82,EIN_",",.02,"I")
 . S IBVSTDT=ARRAY(351.82,EIN_",",.03,"I") ;Visit Date
 . S IBBN=ARRAY(351.82,EIN_",",.05,"E")
 . I IBBN="" S IBBN=" "
 . S IBRESN=ARRAY(351.82,EIN_",",3.02,"E")
 . S IBESITE=ARRAY(351.82,EIN_",",3.03,"I")
 . S IBESITEN=ARRAY(351.82,EIN_",",3.03,"E")
 . I IBFLTRBY'="",(IBFLTRBY'="/"),(IBFLTRBY'="//")  S IBTSITE="/"_IBESITE_"-" I IBFLTRBY'[IBTSITE Q
 . S IBES="" ;Using Institution as Division since remote site Divison is unavailable
 . S IBES=$$GET1^DIQ(351.82,EIN,3.03) ;Pointer to site
 . S ^TMP($J,"IBEXRPT",CNT)=IBPAT_"/"_IBPATNM_U_$G(IBBN)_U_IBVSTDT_U_IBESITEN_U_IBRESN_U_IBESITE_U_IBLSTNUM_"-"_IBLSITE
 . ; Build index to ^TMP($J,"IBEXRPT" based on Sort Criteria
 . S PH="BLANK"
 . I SORT="PAT" S ^TMP($J,"IBEXRPT","INDX",PH,IBPATNM,CNT)=""
 . I SORT="BN" S ^TMP($J,"IBEXRPT","INDX",PH,IBBN,CNT)=""
 . I SORT="ES" D
 . . S IBTES=$S(IBESITEN'="":IBESITEN,1:" ")
 . . S ^TMP($J,"IBEXRPT","INDX",IBTES,IBPATNM,CNT)=""
 Q
 ;
PRTRPT ; Output report to screen
 N IBREC,LOOP1,LOOP2,LOOP3,TEMP,PG,IBQUIT,IBSL,CNT,IBSITE,IBFAC,IBFACNM
 S (IBQUIT,PG,CNT)=0,IBSL=IOSL
 D SITE^IBAUTL
 S IBFACNM=$$GET1^DIQ(4,IBFAC_",",.01,"E")
 W !
 D RPTHDR
 D COLHDR
 ; Loop through Temporary index to print report using selected sort.
 S LOOP1=""
 F  S LOOP1=$O(^TMP($J,"IBEXRPT","INDX",LOOP1)) Q:LOOP1=""!IBQUIT  D
 . S LOOP2=""
 . F  S LOOP2=$O(^TMP($J,"IBEXRPT","INDX",LOOP1,LOOP2)) Q:LOOP2=""!IBQUIT  D
 . . S LOOP3=""
 . . F  S LOOP3=$O(^TMP($J,"IBEXRPT","INDX",LOOP1,LOOP2,LOOP3)) Q:LOOP3=""!IBQUIT  D
 . . . S CNT=CNT+1
 . . . S IBREC=^TMP($J,"IBEXRPT",LOOP3)
 . . . I 'IBEXCEL W !,$E($P(IBREC,U,7),1,25),?27,$E($P($P(IBREC,U,1),"/",2),1,20),?50,$$FMTE^XLFDT($P(IBREC,U,3),"5DZ"),?62,$P(IBREC,U,2),?76,$P(IBREC,U,6)_"-"_$P(IBREC,U,4),?103,$E($P(IBREC,U,5),1,20)
 . . . I IBEXCEL W !,$E($P(IBREC,U,7),1,25),"^",$E($P($P(IBREC,U,1),"/",2),1,20),"^",$$FMTE^XLFDT($P(IBREC,U,3),"5DZ"),"^",$P(IBREC,U,2),"^",$P(IBREC,U,6)_"-"_$P(IBREC,U,4),"^",$E($P(IBREC,U,5),1,20)
 . . . I $O(^TMP($J,"IBEXRPT","INDX",LOOP1,LOOP2,LOOP3)) D CHKSTOP
 I IBQUIT Q
 I '$D(ZTQUEUED) D PAUSE(1) ;Only do PAUSE if not queued 
 Q
 ;
RPTHDR ; Prints the report header
 N PRTFLTBY,FBCNT,TEMP,ITEM,MAX
 S PG=PG+1
 I 'IBEXCEL W !,"Urgent Care Exception Report   ",$$FMTE^XLFDT(DT,"5DZ"),?72,"Page "_PG
 I IBEXCEL W !,"Urgent Care Exception Report   ","^",$$FMTE^XLFDT(DT,"5DZ")
 I 'IBEXCEL W !,"For Site: ",IBSITE,"  ",IBFACNM
 I IBEXCEL W !,"For Site: ","^",IBSITE,"  ",IBFACNM
 I IBFLTRBY'="" S PRTFLTBY="",TEMP=$E(IBFLTRBY,2,$L(IBFLTRBY)-1),MAX=$L(TEMP,"/") F FBCNT=1:1:MAX D
 . S ITEM=$P(TEMP,"/",FBCNT) S ITEM=$P(ITEM,"-",2)
 . S PRTFLTBY=PRTFLTBY_ITEM I FBCNT<MAX S PRTFLTBY=PRTFLTBY_"/"
 I 'IBEXCEL D
 . W !,"Filtered by: " I IBFLTRBY'="",(IBFLTRBY'="/"),(IBFLTRBY'="//") W PRTFLTBY
 . W "   ","Sorted by: ",$S(SORT="BN":"Bill Number",SORT="ES":"Exception Site/Division",1:"Patient"),!
 I IBEXCEL D
 . W !,"Filtered by:^" I IBFLTRBY'="",(IBFLTRBY'="/"),(IBFLTRBY'="//") W PRTFLTBY
 . W "^Sorted by:^",$S(SORT="BN":"Bill Number",SORT="ES":"Exception Site/Division",1:"Patient"),!
 Q
 ;
COLHDR ; Prints the header for the colums in the report. Report is 115 characters wide
 N S,V,IBI,DASH
 I 'IBEXCEL W !,"Division",?27,"Patient Name",?50,"Visit Dt",?62,"Bill Number",?76,"Exception Site",?103,"Reason"
 I IBEXCEL W !,"Division","^","Patient Name","^","Visit Dt","^","Bill Number","^","Exception Site","^","Reason"
 I 'IBEXCEL S DASH="",$P(DASH,"-",124)="" W !,DASH
 Q
 ;
ASKDEV ; Ask about output device and print the report (or run task)
 N %ZIS,POP
 W !!,"The report requires 132 columns."
 S %ZIS="QM"
 D ^%ZIS Q:POP  ; Quit and ask for device again if invalid entry.
 I IOSL<7 W !,"Screen length set to ",IOSL," cannot be less than 7." G ASKDEV
 ; If it was queued
 I $G(IO)="" S IBQUIT=1 Q
 I $D(IO("Q")) D RUNTASK Q
 U IO D REPORT1^IBUCERP ; Generate report directly
 D ^%ZISC ; Close the device
 Q
 ;
RUNTASK ; Start Taskman job
 N ZTRTN,ZTSK,IBVAR,ZTSAVE,ZTDESC
 S ZTRTN="REPORT1^IBUCERP",ZTDESC="IB Urgent Care Exception Report"
 F IBVAR="IBFLTRBY","SORT","ZTQUEUED" S ZTSAVE(IBVAR)=""
 D ^%ZTLOAD
 I $G(ZTSK) W !!,"This request has been queued.  The task number is "_ZTSK_"."
 E  W !!,"Unable to queue this job."
 K ZTQUEUED
 D HOME^%ZIS W !
 Q
 ;
CHKSTOP ;
 I CNT>=(IBSL-8) D
 . I '$D(ZTQUEUED) D PAUSE(0)
 . S CNT=0 ;Reset CNT if header prints
 . D RPTHDR
 . D COLHDR
 Q
 ;
PAUSE(IBEND) ;
 Q:$E(IOST,1,2)'["C-"
 N X,Y,IBJ,DIR,DA,DIRUT,DTOUT,DUOUT,DIROUT
 S $Y=0
 I $G(IBEND) W !,"End of the report."
 S DIR(0)="E"
 S DIR("A")="Type <Enter> to continue or '^' to exit"
 D ^DIR K DIR I $G(DUOUT) S IBQUIT=1 W @IOF Q
 W @IOF
 Q
 ;
EXCMSG ; - Displays the message about capturing to an Excel file format
 ;
 W !!?5,"To capture as an Excel format, it is recommended that you queue this"
 W !?5,"report to a spool device with margins of 256 and page length of 99999"
 W !?5,"(e.g. 0;256;99999). This should help avoid wrapping problems."
 W !!?5,"Another method would be to set up your terminal to capture the detail"
 W !?5,"report data. On some terminals, this can be done by invoking 'Logging'"
 W !?5,"or clicking on the 'Tools' menu above, then click on 'Capture Incoming "
 W !?5,"Data' to save to Desktop. To avoid undesired wrapping of the data saved"
 W !?5,"to the file, change the DISPLAY screen width size to 132 and you can"
 W !?5,"enter '0;256;99999' at the 'DEVICE:' prompt.",!
 Q
 ; ========================================================================
