IBDFFRFT ;ALB/CMR - AICS Free Forms Tracking Entry ; 27-MAR-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**15,38**;APR 24, 1997
 ;
 ; -- modified 10/7/97 to allow background freeing via site parameter
 ;
FREEFT ; -- called to pass data from FT to PCE regardless of whether all
 ;    pages have been received.
 ;
 N FORMTYPE,IBFID,IBD,IBNODE,DFN,CLINIC,APPT,Y,PXCA,AUPNDAYS,AUPNDOB,AUPNDOD,AUPNPAT,AUPNSEX,CNT,ORVP,PXCAVSIT,RESULT,SDFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) D FULL^VALM1 S IBD=0 F  S IBD=$O(VALMY(IBD)) Q:'IBD!$D(DIRUT)  D
 .S IBFID=$P($G(^TMP("FRMIDX",$J,+IBD)),"^",2)
 .S IBNODE=$G(^IBD(357.96,+IBFID,0)) I IBNODE="" W !,"No Form Tracking record associated with entry #",IBD H 2 Q
 .I '$D(^XUSEC("IBD MANAGER",DUZ)) W !,"You must hold the IBD MANAGER key to free Forms Tracking entries" H 2 Q
 .I $P(IBNODE,"^",11)'=11 W !,"You may only pass data to PCE if the current status is PENDING PAGES" H 2 Q
 .S DFN=$P(IBNODE,"^",2),APPT=$P(IBNODE,"^",3),CLINIC=$P(IBNODE,"^",10)
 .;
 .; -- display ft data
 .W !!,"PATIENT: ",$P($G(^DPT(DFN,0)),"^"),"    APPT DATE/TIME: ",$$FMTE^XLFDT(APPT,2),!,"CLINIC:  ",$P($G(^SC(CLINIC,0)),"^"),!
 .;
 .; -- display page data
 .S I=0 F  S I=$O(^IBD(357.96,IBFID,9,I)) Q:'I  S IBNODE=$G(^IBD(357.96,IBFID,9,I,0)) W !?5,"Page ",$P(IBNODE,"^")," ",$S(+$P(IBNODE,"^",2):"Received",1:"Not Received")
 .W ! S DIR(0)="Y",DIR("A")="Okay to continue",DIR("B")="Y" D ^DIR K DIR Q:'Y
 .D SEND(IBFID)
 ;
 D EXIT1^IBDFFT,START^IBDFFT1
 S VALMBCK="R"
 Q
 ;
SEND(IBFID,ERRCNT) ; -- send all page data in forms tracking
 ;
 ; -- gather data from previously stored pages
 S I=0 F  S I=$O(^IBD(357.96,IBFID,10,I)) Q:'I  D ARYAD^IBDFBKR($G(^IBD(357.96,IBFID,10,I,0)))
 ;
 ; -- send data to pce
 W:'$D(ZTQUEUED) !,"Sending Data to PCE..."
 S RESULT=$$SEND^IBDF18E(IBFID,"","",.BUBBLES,.HANDPRNT,"",.PXCA,.DYNAMIC)
 W:'$D(ZTQUEUED) $S(RESULT:"Successfull",1:"Unsuccessful")
 ;
 ; -- process any returned errors/warnings
 I $D(PXCA("ERROR"))!($D(PXCA("WARNING"))) D
 .N I,J,ERR,LCNT,DIR,DIRUT,DUOUT
 .S LCNT=0,ERRCNT=$G(ERRCNT)+1
 .D EW^IBDFBK2(.ERR,.PXCA,.LCNT)
 .;
 .W:'$D(ZTQUEUED) !!!,"The following Error(s) occurred while validating data in PCE for: ",$P($G(^DPT(DFN,0)),"^")
 .Q:$D(ZTQUEUED)
 .S I=0 F  S I=$O(ERR(I)) Q:'I  W !?4,$E(ERR(I),1,75)  I $L(ERR(I))>75 W !?10,$E(ERR(I),76,140)
 .W !!
 Q
 ;
BCKGRND ; -- entry point for back ground job to process pending pages
 ;
 N DAYS,START,END
 S DAYS=+$P($G(^IBD(357.09,1,0)),"^",11)
 ;
 Q:'DAYS
 S ERRCNT=0
 S START=DAYS+7
 S START=$$FMADD^XLFDT(DT,-START)
 S END=$$FMADD^XLFDT(DT,-DAYS)+.24
 ;
B1 N CNT,ERRCNT,IBFID,STATUS
 F  S START=$O(^IBD(357.96,"D",START)) Q:'START!(START>END)  D
 .S IBFID=0
 .F  S IBFID=$O(^IBD(357.96,"D",START,IBFID)) Q:'IBFID  D
 ..S STATUS=$P($G(^IBD(357.96,IBFID,0)),"^",11)
 ..I STATUS=11 S CNT=$G(CNT)+1 D SEND(IBFID,.ERRCNT)
 ;
 D:$G(MANUAL) BULL
 I $D(ZTQUEUED),$G(MANUAL) S ZTREQ="@"
 Q
 ;
BULL ; -- add bulletin or something to let people know what was done
 ;    but only if they ask for it during testing.
 ;
 S IBD(1)="The background job to release pending pages has completed"
 S IBD(2)=""
 S IBD(3)="   Number of Forms Tracking Entries: "_+$G(CNT)
 S IBD(4)="  Number of Forms Generating Errors: "_+$G(ERRCNT)
 S XMSUB="AICS RELEASE PENDING PAGES"
 S XMDUZ="AICS PACKAGE",XMTEXT="IBD("
 K XMY S XMN=0
 S XMY(DUZ)=""
 D ^XMD
 K X,Y,IBD,XMDUZ,XMTEXT,XMY,XMSUB,XMN
 Q
 ;
MANUAL ; -- entry point for sending pending pages to PCE for a date range
 ;    get date range and do b1
 ;
 W !!,"Option to Manually send Encounter Forms in a Pending Pages Status in Forms"
 W !,"Tracking to PCE by Encounter date range.",!!
 ;
 S MANUAL=1
 S DAYS=+$P($G(^IBD(357.09,1,0)),"^",11)
 S HELP="Enter a START date.  This is an exact date and should be in the past."
 S START=$$ASKDT("Start Date: ","T-"_(60+DAYS),"AEPQX","",DT,.HELP,"D SHELP^IBDFFRFT")
 I START<1 G MQ
 S HELP="Enter the END date.  This must be after the start date an before today."
 S END=$$ASKDT("End Date: ","T-"_$S(DAYS:DAYS,1:15),"AEQX",START,DT,.HELP,"D EHELP^IBDFFRFT")
 I END<1!(END<START) G MQ
 S ZTRTN="B1^IBDFFRFT",ZTSAVE("START")="",ZTSAVE("END")="",ZTSAVE("DAYS")="",ZTSAVE("MANUAL")=""
 S ZTDESC="IBD-FREE FORMS TRACKING OF PENDING PAGES"
 S ZTIO=""
 W !!,"This option must be queued.  No Device is Necessary."
 W !,"A mail message will be sent when the process has completed.",!!
 D ^%ZTLOAD
MQ K X,Y,IBD,DAYS,START,END,MANUAL,HELP,ZTSK,ZTRTN,ZTSAVE,ZTSAVE,ZTDESC,ZTIO
 Q
 ;
EHELP ; -- help for the end date prompt
 W !,"Enter the END date.  This is an Encounter Date."
 W !,"This is the last date that forms that are in a Pending Pages Status in Forms"
 W !,"Tracking will be automatically sent to PCE for processing."
 Q
 ;
SHELP ; -- help for start date prompt
 W !,"Enter the START date.  This is an Encounter Date."
 W !,"This is the date that you want to start the process that sends forms that"
 W !,"are in a Pending Pages Status in Forms Tracking entries to PCE to start on."
 Q
 ;
ASKDT(QUES,DEFLT,PARAM,EARLY,LATEST,HELP,EXHELP) ; -- ask date questions
 N X,Y,DIR,DIRUT,DTOUT,DUOUT,IBQUIT
 S DIR(0)="DOA^"_$E($G(EARLY),1,7)_":"_$G(LATEST)_":"_$S($G(PARAM)'="":PARAM,1:"AEQRX")
 I $G(QUES)'="" S DIR("A")=QUES
 I $G(DEFLT)'="" S DIR("B")=DEFLT
 I $L($G(EXHELP)) S DIR("??")="^"_EXHELP
 I $D(HELP) M DIR("?")=HELP
 D ^DIR
 I $D(DIRUT),Y'="" S Y=-1 ;i y="" user typed "@"
 I $D(DTOUT)!($D(DUOUT)) S IBQUIT=1,Y=-1
 Q Y
