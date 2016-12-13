IBNCPDRB ;ALB/CFS - ROI EXPIRATION REPORT ;21-SEP-15
 ;;2.0;INTEGRATED BILLING;**550**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
REPORT(RPTNAME,DATESEL,AIB,IBEXCEL) ;
 ; RPTNAME = Report name
 ; DATESEL = Earliest and Latest expiration dates selected by user (format: earliest^latest)
 ; AIB     = "A" - User chose to display Active statuses only
 ;           "I" - User chose to display on Inactive statuses only
 ;           "B" - User chose to display Active and Inactive statuses
 ; IBEXCEL = 1 if the user requested to print in EXCEL format; 0 otherwise
 N IBEDATE,IBLDATE,IBPAGE,CRT
 S RPTNAME=$G(RPTNAME),DATESEL=$G(DATESEL)
 S IBEDATE=$$FMTE^XLFDT($P(DATESEL,U),"5DZ")       ; Earliest expiration date selected.
 S IBLDATE=$$FMTE^XLFDT($P(DATESEL,U,2),"5DZ")     ; Latest expiration date selected.
 S CRT=$S(IOST["C-":1,1:0)  ; Screen variable.
 I IBEXCEL D EXCELHDR
 I 'IBEXCEL D HEADER
 D GETTMP
 Q
 ;
EXCELHDR ;
 ; Print headers in EXCEL format.
 W !,"Patient name^Date of Death^Effective Date^Expiration Date^Status^Date Added^Entered By^Insurance Name^Drug Name"
 Q
 ;
HEADER ;
 N DASH,NOW
 S DASH=""
 W @IOF
 S IBPAGE=$G(IBPAGE)+1
 S $P(DASH,"-",133)=""
 W !,RPTNAME,?119,"Page: ",?126,IBPAGE
 S NOW=$$NOW^XLFDT(),NOW=$$FMTE^XLFDT(NOW,1)
 W !,"Date Range: "_IBEDATE_" - "_IBLDATE,?101,"Run Date: "_NOW
 W !,"Status: ",$S(AIB="A":"Active ROIs",AIB="I":"Inactive ROIs",1:"All")
 W !,DASH
 W !,?23,"Date of",?33,"Eff.",?44,"Exp.",?60,"Date"
 W !,"Patient Name",?23,"Death",?33,"Date",?44,"Date",?55,"St",?60,"Added",?71,"Entered By"
 W ?90,"Insurance Name",?110,"Drug Name"
 W !,DASH
 Q
GETTMP ;
 ; Get the data from the scratch global.
 N ADDED,DATA,DOD,DRUGNAME,EXPDATE,EFFDATE,IBQ,INSNAME,PATNAME,SUB1,SUB2,SUB3
 N USERNAME
 S IBQ=0
 I '$D(^TMP("IBNCPDRA",$J)) D  Q
 . I 'IBEXCEL W !!,?51,"***** NO DATA TO REPORT *****",! S:CRT&'$D(ZTQUEUED) IBQ=$$PAUSE() Q
 . W !,"***** NO DATA TO REPORT *****",! S IBQ=$$PAUSE()
 S SUB1="" F  S SUB1=$O(^TMP("IBNCPDRA",$J,SUB1),-1) Q:SUB1=""!($G(IBQ))  D
 . S SUB2="" F  S SUB2=$O(^TMP("IBNCPDRA",$J,SUB1,SUB2)) Q:SUB2=""!($G(IBQ))  D
 .. S SUB3="" F  S SUB3=$O(^TMP("IBNCPDRA",$J,SUB1,SUB2,SUB3)) Q:SUB3=""!($G(IBQ))  D
 ... S DATA=^TMP("IBNCPDRA",$J,SUB1,SUB2,SUB3)
 ... S DOD=$$FMTE^XLFDT($P(DATA,U),"2DZ")        ; date of death
 ... S EFFDATE=$$FMTE^XLFDT($P(DATA,U,2),"2DZ")  ; effective date of ROI
 ... S STATUS=$P(DATA,U,3)                       ; "A" for Active; "I" for Inactive
 ... S ADDED=$$FMTE^XLFDT($P(DATA,U,4),"2DZ")    ; date added to Claims Tracking ROI file
 ... S USERNAME=$P(DATA,U,5)                     ; user who added the ROI entry
 ... S INSNAME=$P(DATA,U,6)                      ; insurance name
 ... S DRUGNAME=$P(DATA,U,7)                     ; drug name
 ... S EXPDATE=$$FMTE^XLFDT(SUB1,"2DZ")          ; expiration date of ROI
 ... S PATNAME=SUB2                              ; patient name
 ... I IBEXCEL D EXCELN(PATNAME,DOD,EFFDATE,EXPDATE,STATUS,ADDED,USERNAME,INSNAME,DRUGNAME) Q
 ... D WRTDATA(PATNAME,DOD,EFFDATE,EXPDATE,STATUS,ADDED,USERNAME,INSNAME,DRUGNAME) Q:$G(IBQ)
 I $G(IBQ) Q
 I 'IBEXCEL W !!,"*** END OF REPORT ***",!
 I CRT,'$D(ZTQUEUED) S IBQ=$$PAUSE()  ; Write the pause statement to screen only.
 Q
 ;
EXCELN(PATNAME,DOD,EFFDATE,EXPDATE,STATUS,ADDED,USERNAME,INSNAME,DRUGNAME) ;
 ; Display data in EXCEL format
 S STATUS=$S(STATUS="A":"Active",1:"Inactive")
 W !,PATNAME,"^",DOD,"^",EFFDATE,"^",EXPDATE,"^",STATUS,"^",ADDED,"^",USERNAME,"^",INSNAME,"^",DRUGNAME
 Q
 ;
WRTDATA(PATNAME,DOD,EFFDATE,EXPDATE,STATUS,ADDED,USERNAME,INSNAME,DRUGNAME) ;
 ; Display the data to screen or to ListMan Queued report depending on user request.
 W !,$E(PATNAME,1,21),?23,DOD,?33,EFFDATE,?44,EXPDATE
 W ?55,STATUS,?60,ADDED,?71,$E(USERNAME,1,16),?90,$E(INSNAME,1,17),?110,$E(DRUGNAME,1,22)
 I $Y>(IOSL-4) D
 . I CRT,'$D(ZTQUEUED) W ! S IBQ=$$PAUSE()  ; Write the pause statement to screen only. 
 . I $G(IBQ) Q  ; User chooses to exit report with "^".
 . D HEADER
 Q
 ;
PAUSE() ;
 ; Press RETURN to continue or '^' to exit.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,QUIT,X,Y
 S QUIT=0
 I IBEXCEL W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DIRUT) S QUIT=1
 Q QUIT
