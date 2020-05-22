IBUCMM1 ;WOIFO/AAT-IBUC VISIT SUMMARY/DETAIL REPORT;30-JUL-02
 ;;2.0;INTEGRATED BILLING;**663,671**;21-MAR-94;Build 13
 ;; Per VHA Directive 6402, this routine should not be modified
 Q
 ;
 ; Prints report to the current device
 ;
 ; Input:
 ;   IBBDT - Beginning date
 ;   IBEDT - Ending date
 ; Output:
 ;   IBQUIT = 1, if user entered "^" (Devices starting with "C-" only)
REPORT ;
 ;
 ;Clear the temp global in case the process didn't finish the last time it ran.
 K ^TMP($J,"IBUCMMNM")
 ;
 ;Gather the data into the Temp global
 D GETDATA(IBBDT,IBEDT)
 ;
 ;Print the report
 D PRSUM
 ;
 ;Clean up and exit 
 K ^TMP($J,"IBUCMM")  ; Kill the temporary global node
 K ^TMP($J,"IBUCMMNM")  ; Kill the temporary global node
 S:$D(ZTQUEUED) ZTREQ="@" ; for Taskman
 Q
 ;
GETDATA(IBBDT,IBEDT) ;Gather the data for the report
 ;
 N IBNEW,IBLP,IBIEN,IBDATA,IBDFN,IBSITE,IBSTAT,IBYR,IBMN,IBCSITE,IBCTX
 ;
 ;Get the current site's ID, and then re-initializing IBSITE for future use.
 D SITE^IBAUTL S IBCSITE=IBSITE,IBSITE=""
 ; Initialize loop to start date
 S IBLP=0   ;initial starting value
 S:+$G(IBBDT)>0 IBLP=+$G(IBBDT)-1   ; use beginning date if defined
 ;Loop through the "VD" index to gather
 F  S IBLP=$O(^IBUC(351.82,"VD",IBLP)) Q:'IBLP  Q:IBLP>IBEDT  D
 . S IBIEN=0
 . F  S IBIEN=$O(^IBUC(351.82,"VD",IBLP,IBIEN)) Q:'IBIEN  D
 . . ;
 . . S IBNEW=0
 . . S IBDATA=$G(^IBUC(351.82,IBIEN,0)),IBYR=$E(IBLP,1,3)+1700,IBMN=$E(IBLP,1,5)
 . . I (IBCA="C"),($P(IBDATA,U,2)'=IBCSITE) Q
 . . S IBDFN=$P(IBDATA,U),IBSITE=$P(IBDATA,U,2),IBSTAT=$P(IBDATA,U,4),IBCTX=IBSTAT+1
 . . S IBNM=$$GET1^DIQ(2,IBDFN_",",.01,"E")
 . . Q:IBNM=""
 . . ;# visits by a patient in a given month (for the total and the code)
 . . S:'$D(^TMP($J,"IBUCMM",IBYR,IBMN,IBNM,IBDFN)) IBNEW=1
 . . S $P(^TMP($J,"IBUCMM",IBYR,IBMN,IBNM,IBDFN),U)=+$P($G(^TMP($J,"IBUCMM",IBYR,IBMN,IBNM,IBDFN)),U)+1
 . . S $P(^TMP($J,"IBUCMM",IBYR,IBMN,IBNM,IBDFN),U,IBCTX)=+$P($G(^TMP($J,"IBUCMM",IBYR,IBMN,IBNM,IBDFN)),U,IBCTX)+1
 . . ;# visits in a given month
 . . S $P(^TMP($J,"IBUCMM",IBYR,IBMN),U)=+$P($G(^TMP($J,"IBUCMM",IBYR,IBMN)),U)+1
 . . S $P(^TMP($J,"IBUCMM",IBYR,IBMN),U,IBCTX)=+$P($G(^TMP($J,"IBUCMM",IBYR,IBMN)),U,IBCTX)+1
 . . S:IBNEW $P(^TMP($J,"IBUCMM",IBYR,IBMN),U,6)=+$P($G(^TMP($J,"IBUCMM",IBYR,IBMN)),U,6)+1
 . . ;# visits in a given year
 . . S $P(^TMP($J,"IBUCMM",IBYR),U)=+$P($G(^TMP($J,"IBUCMM",IBYR)),U)+1
 . . S $P(^TMP($J,"IBUCMM",IBYR),U,IBCTX)=+$P($G(^TMP($J,"IBUCMM",IBYR)),U,IBCTX)+1
 . . I '$D(^TMP($J,"IBUCMMNM",IBDFN)) D
 . . . S ^TMP($J,"IBUCMMNM",IBDFN)=""
 . . . S ^TMP($J,"IBUCMMNM")=$G(^TMP($J,"IBUCMMNM"))+1
 Q
 ;
PRSUM ; Print report from the temp. global
 N IBLINE,IBPAG,IBTOT,IBD,IBTY,IBDA,IBY,IBCHG,IBSAV,IBSEQ,IBMON,X,X2,X3,Y,%,IBYR
 N IBTOT,IBTOTF,IBTOTC,IBTOTN,IBTOTV
 D NOW^%DTC S IBDTH=$$FMTE^XLFDT($E(%,1,12))
 S IBLINE="",$P(IBLINE,"=",IOM+1)="",(IBPAG,IBTOT,IBTOTC,IBTOTF,IBTOTN,IBTOTV,IBQUIT,IBCHG)=0
 D:'IBEXCEL HDR
 D:IBEXCEL EXHDR
 I '$D(^TMP($J,"IBUCMM")) W !!,"No Urgent Care Visits found within the specified period" D PAUSE(1) Q
 ; - first, print detail lines
 F IBMON=$E(IBBDT,1,5):1:$E(IBEDT,1,5)  D  Q:IBQUIT
 . D:'IBEXCEL CHKSTOP Q:IBQUIT
 . S IBYR=$E(IBMON,1,3)+1700
 . S IBY=$G(^TMP($J,"IBUCMM",IBYR,IBMON))
 . ;
 . Q:$G(IBY)=""
 . ;If EXCEL Output, display with ^ delim
 . I IBEXCEL D
 . . W !,$$MON($E(IBMON,4,5))_" "_(1700+$E(IBMON,1,3)),U,+$P(IBY,U,1),U,+$P(IBY,U,2),U,+$P(IBY,U,3),U,+$P(IBY,U,4),U,+$P(IBY,U,5),U,+$P(IBY,U,6)
 . ;
 . ; Otherwise print in screen format
 . I 'IBEXCEL D
 . . W !,$$MON($E(IBMON,4,5)),?10,1700+$E(IBMON,1,3)
 . . W ?34,$J(+$P(IBY,U,1),5)     ;# visits
 . . W ?43,$J(+$P(IBY,U,2),5)     ;# free visits
 . . W ?52,$J(+$P(IBY,U,3),5)     ;# charged Visits
 . . W ?62,$J(+$P(IBY,U,4),5)     ;# not counted Visits
 . . W ?72,$J(+$P(IBY,U,5),5)     ;# visit only Visits
 . . W ?83,$J(+$P(IBY,U,6),5)     ;# # Unique Patients
 . S IBTOT=IBTOT+$P(IBY,U,1),IBTOTF=IBTOTF+$P(IBY,U,2),IBTOTC=IBTOTC+$P(IBY,U,3),IBTOTN=IBTOTN+$P(IBY,U,4),IBTOTV=IBTOTV+$P(IBY,U,5)
 . I IBSD="D" D PRDET(IBYR,IBMON)
 Q:IBQUIT
 D TOTALS
 ;
 ;Write Unique Patient Definition
 W !!,"*The total unique patient number only counts a patient once for the period",!,"of the report."
 D PAUSE(1)
 Q
 ;
PRDET(IBYR,IBMON) ; Print the details of the summary
 ;
 N IBDFN,IBNM
 S IBNM=""
 F  S IBNM=$O(^TMP($J,"IBUCMM",IBYR,IBMON,IBNM)) Q:IBNM=""  D
 . S IBDFN=0
 . F  S IBDFN=$O(^TMP($J,"IBUCMM",IBYR,IBMON,IBNM,IBDFN)) Q:'IBDFN  D
 . .D CHKSTOP Q:IBQUIT
 . .S IBDATA=$G(^TMP($J,"IBUCMM",IBYR,IBMON,IBNM,IBDFN))
 . . ;
 . . ;Excel Format
 . . I IBEXCEL D  Q
 . . . W !,$$GET1^DIQ(2,IBDFN_",",.01,"E"),U,+$P(IBDATA,U,1),U,+$P(IBDATA,U,2),U,+$P(IBDATA,U,3),U,+$P(IBDATA,U,4),U,+$P(IBDATA,U,5)
 . . ;
 . . ;Screen format
 . . W !?3,$$GET1^DIQ(2,IBDFN_",",.01,"E")
 . . W ?34,$J(+$P(IBDATA,U,1),5)
 . . W ?43,$J(+$P(IBDATA,U,2),5)     ;# free visits
 . . W ?52,$J(+$P(IBDATA,U,3),5)     ;# charged Visits
 . . W ?62,$J(+$P(IBDATA,U,4),5)     ;# Removed Visits
 . . W ?72,$J(+$P(IBDATA,U,5),5)     ;# Visit On Visits
 Q
TOTALS ; Print the totals.
 N IBI,X
 ;
 ;MS Excel format
 I IBEXCEL D  Q
 . W !,"REPORT TOTALS",U,IBTOT,U,IBTOTF,U,IBTOTC,U,IBTOTN,U,IBTOTV,U,$G(^TMP($J,"IBUCMMNM"))
 ;
 ; screen format
 W ! F IBI=1:1:88 W "-"
 W !,"REPORT TOTALS",?34,$J(IBTOT,5),?43,$J(IBTOTF,5),?52,$J(IBTOTC,5),?62,$J(IBTOTN,5),?72,$J(IBTOTV,5),?82,$J($G(^TMP($J,"IBUCMMNM")),6)
 Q
 ;
 ;Number format
FORMAT(IBNUM,IBDIG,IBFRM) ;  Comma format the number
 N X,X1,X3
 S X=IBNUM,X3=IBDIG
 D COMMA^%DTC
 Q X
 ;
CHKSTOP I $Y>(IOSL-5) D PAUSE(0) Q:IBQUIT  D HDR
 Q
 ;
HDR ; Print header.
 N IBI,IBHDR,IBH,IBH1,IBFACNM,IBH2
 I $E(IOST,1,2)["C-"!(IBPAG) W @IOF,*13
 S IBHDR=$S(IBSD="S":"SUMMARY",1:"DETAIL")
 S IBH="URGENT CARE VISIT TRACKING "_IBHDR_" REPORT"
 S IBPAG=IBPAG+1 W ?(122-$L(IBH)\2),IBH
 S IBH1="FOR ALL SITES"
 I IBCA="C" D
 . S IBFACNM=$$GET1^DIQ(4,IBFAC_",",.01,"E")
 . S IBH1="FOR "_IBFACNM
 W !,?(122-$L(IBH1)\2),IBH1
 S IBH2="From "_$$DAT(IBBDT)_" through "_$$DAT(IBEDT)
 W !,?(122-$L(IBH2)\2),IBH2
 W ?IOM-36,IBDTH,?IOM-9,"Page: ",IBPAG
 W !!,?33,"TOTAL",?60,"REMOVED",?71,"VISITS",?80,"UNIQUE"
 W !," MONTH",?10,"YEAR",?33,"VISITS",?44,"FREE",?51,"BILLED",?60,"VISITS",?71,"ONLY",?80,"PATIENTS"
 W ! F IBI=1:1:88 W "-"
 Q
 ;
EXHDR ; Print Excel version of the header.
 W !,"MONTH/YEAR",U,"TOTAL VISITS",U,"FREE",U,"BILLED",U,"REMOVED VISITS",U,"VISITS ONLY",U,"UNIQUE PATIENTS"
 Q
 ;
STAT() ; Display bill number or status
 N IBSTAT S IBSTAT=$G(^IBE(350.21,+$P(IBZ,U,5),0))
 Q $S($P(IBSTAT,U,6):$$HLD(+$P(IBZ,U,5)),$P(IBZ,U,5)=99:"Converted",$P(IBZ,U,11)]"":$P($P(IBZ,U,11),"-",2),$P(IBSTAT,U,5):"Cancelled",1:"Pending")
 ;
HLD(STAT) ; Return an 'on hold' status string
 Q "Hold "_$S(STAT=20:"Rate",STAT=21:"Rev",1:"Ins")
 ;
PAUSE(IBEND) ;
 Q:$E(IOST,1,2)'["C-"
 N IBJ,DIR,DIRUT,DTOUT,DUOUT,DIROUT,Y
 W !! ;F IBJ=$Y:1:(IOSL-4) W !
 S DIR(0)="E"
 I $G(IBEND) S DIR("A")="End of the report. Enter RETURN to continue or '^' to exit"
 D ^DIR K DIR I $G(DUOUT) S IBQUIT=1 W @IOF Q
 I $G(IBEND) W @IOF
 Q
 ;
DAT(IBDT) ; Convert FM date to (mm/dd/yy) format.
 Q $$FMTE^XLFDT(IBDT,"2MZ")
 ;
MON(IBMON) I (IBMON<1)!(IBMON>12) Q ""
 Q $P("JANUARY FEBRUARY MARCH APRIL MAY JUNE JULY AUGUST SEPTEMBER OCTOBER NOVEMBER DECEMBER"," ",IBMON)
 ;
