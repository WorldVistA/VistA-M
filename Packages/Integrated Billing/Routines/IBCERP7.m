IBCERP7 ;AITC/KDM - HID   HCCH Payer ID Report ;5/4/2017
 ;;2.0;INTEGRATED BILLING;**577,592,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ; This report is a PAYER ID report based on the 277stat msg responses from the clearing house
 ; This report will give a snap shot view of what is on file at the time of running.
 ; The results may vary each running depending on the timing of transactions posted to the file   
 ; Refer to US976
 ; Called by IB BILLING SUPERVISOR MENU, Opt:SYST, Opt:HID
 ;
ENT ; Menu Option Entry Point
 N BEGDT,BEGIN,DT,END,ENDDT,HDR1,HDR2,HDR3,IBABEG,IBAEND,IBEOB,IBIFN,IBQUIT,LNTOT,MAX,PAGES,PGC,RNAME,U,Y
 N ASTERISK,CNT,DASH,EORMSG,LEGEND,NONEMSG,POP
 S (ASTERISK,IBQUIT)=0,RNAME="IBCERP7",LEGEND="'*' = No available fields to allow for an update in the insurance file"
 D DATES Q:IBQUIT  Q:'Y
 D DEVICE Q:POP  Q:IBQUIT
QUE ; Queued Entry Point
 K ^TMP(RNAME,$J)
 D GATHER
 D HDRINIT
 D HEADER Q:IBQUIT
 D PRINT
 D EXIT
 Q
DATES ;  Enter the from and to dates for this report
 ;
 N DIR
 W ! S DIR(0)="DA^:DT:EX",DIR("A")="Enter Earliest Date: ",DIR("B")=$$HTE^XLFDT($H-30),DIR("?")="Enter the earliest transaction date for the transaction report."
 D ^DIR K DIR Q:'Y  S IBABEG=+Y,BEGIN=Y(0),BEGDT=$$FMTE^XLFDT(IBABEG,2)
 ;
 W ! S DIR(0)="DA^"_+Y_":DT:EX",DIR("A")="Enter Latest Date: ",DIR("B")=$$FMTE^XLFDT(DT,1)
 ; DIR("?")="Enter the latest date for the transaction report."
 D ^DIR K DIR Q:'Y  S IBAEND=+Y,END=Y(0),ENDDT=$$FMTE^XLFDT(IBAEND,2)
 ;
 Q
 ;
DEVICE ; - Ask device
 ;
 N %ZIS,ZTDESC,ZTIO,ZTQUEUED,ZTRTN,ZTSAVE
 W !!!,"You will need a 132 column printer for this report",!
 S %ZIS="QM" D ^%ZIS S:POP IBQUIT=1 Q:POP
 I $D(IO("Q")) D  S IBQUIT=1 Q
 . S ZTRTN="QUE^IBCERP7",ZTDESC="HCCH Payer ID Report"
 . S ZTSAVE("BEGIN")=""
 . S ZTSAVE("END")=""
 . S ZTSAVE("IBABEG")=""
 . S ZTSAVE("IBAEND")=""
 . S ZTSAVE("BEGDT")=""
 . S ZTSAVE("ENDDT")=""
 . S ZTSAVE("RNAME")=""
 . S ZTSAVE("IBQUIT")=""
 . D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Your task number "_ZTSK_" has been queued.",1:"Unable to queue this job.")
 . K ZTSK D HOME^%ZIS
 . W !!! I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR    ;pause to see task no.
 U IO
 Q
 ;
GATHER ;GO GET THE INFO BASED ON THE DATES ENTERED
 ; uses ^DIC(36,"AEDIX",DATE,INSURANCE IEN,) to get data within date range.  
 ; If data is within date range sets up ^TMP($J file with all data needed for the report.
 ; ^DIC(36,"AEDIX",DATE,INSURANCE IEN ,EDI ID NUMBER,TYPE "P" OR "I")=EDI ID NUMBER ON FILE ;
 ;
 ;(If  EDI NUMBER ON FILE is null- it is considered  updated, not attempted)
 ;
 ;  Uses the insurance ien from Cross ref to extract the name, address, city, and state from the ^DIC(36,IEN)
 ;  Uses the Type from cross ref as the EDI PayerID for the report. For printing the I="Inst";P="Prof"
 ;  Uses the EDI ID NUMBER from Cross ref to be the NewValue on report.
 ;  Uses the EDI ID NUMBER ON FILE from cross ref to be the OldValue on report
 ;  If the EDI ID NUMBER ON FILE from cross ref is null- set the "updated" value for report to be "Yes", otherwise "No"
 ;
 ;
 N DATE,EDIONFILE,EDINO,IBADDRESS,IBCITY,IBNAME,IBSTATE,IBPIEN,LNCNT,TYPE
 S $P(DASH,"_",132)=""
 S U="^",LNTOT=0,PGC=1,MAX=IOSL
 S DATE=IBABEG-1
 F  S DATE=$O(^DIC(36,"AEDIX",DATE)) Q:DATE=""  Q:DATE>IBAEND  D
 . S IBPIEN="" F  S IBPIEN=$O(^DIC(36,"AEDIX",DATE,IBPIEN)) Q:IBPIEN=""  D
 .. S EDINO="" F  S EDINO=$O(^DIC(36,"AEDIX",DATE,IBPIEN,EDINO)) Q:EDINO=""  D
 ... S TYPE="" F  S TYPE=$O(^DIC(36,"AEDIX",DATE,IBPIEN,EDINO,TYPE)) Q:TYPE=""  D
 .... S EDIONFILE=$G(^DIC(36,"AEDIX",DATE,IBPIEN,EDINO,TYPE))
 .... I EDIONFILE["*" S ASTERISK=1
 .... S IBNAME=$$GET1^DIQ(36,IBPIEN,.01)
 .... S IBADDRESS=$$GET1^DIQ(36,IBPIEN,.111)
 .... S IBCITY=$$GET1^DIQ(36,IBPIEN,.114)
 .... S IBSTATE=$$GET1^DIQ(36,IBPIEN,.115,"I")
 .... S ^TMP(RNAME,$J,IBNAME,DATE,EDINO,TYPE)=IBPIEN_U_IBADDRESS_U_IBCITY_U_IBSTATE_U_EDIONFILE
 .... S LNTOT=LNTOT+1
 Q
 ;
PRINT ;  Print data
 ;  PGC=page ct,LNTOT=no of lines to be printed,LNCNT=when to page break
 ;  MAX=IOSL (device length)
 ;
 N ADDRESS,COMPADDR,CITY,DATE,EDINO,EDIONFILE,IEN,NAME,PID,PIDPOS,STATE,TYPE,UPDATE
 S EORMSG="*** END OF REPORT ***"
 S NONEMSG="* * * N O   D A T A   T O   P R I N T * * *"
 ;
 I '$D(^TMP(RNAME,$J)) W !!!,NONEMSG D END Q
 S NAME="" F  S NAME=$O(^TMP(RNAME,$J,NAME)) Q:NAME=""  D
 . S DATE="" F  S DATE=$O(^TMP(RNAME,$J,NAME,DATE)) Q:DATE=""  D
 .. S EDINO="" F  S EDINO=$O(^TMP(RNAME,$J,NAME,DATE,EDINO)) Q:EDINO=""  D
 ... S TYPE="" F  S TYPE=$O(^TMP(RNAME,$J,NAME,DATE,EDINO,TYPE)) Q:TYPE=""  Q:IBQUIT  D
 .... ;JWS;IB*2.0*592;added 'Dent' for Dental
 .... ;S PID=$S(TYPE="I":"Inst",TYPE="D":"Dent",1:"Prof")
 .... ;/vd - US3995 - IB*2*623 - Modified the above line.
 .... S PID=$S($E(TYPE,1)="I":"Inst",$E(TYPE,1)="D":"Dent",1:"Prof")
 .... S PIDPOS=$S($E(TYPE,2)=2:94,1:82)
 .... ;S NAME=$P(^TMP(RNAME,$J,DATE,IEN,EDINO,TYPE),U,1)
 .... S ADDRESS=$P(^TMP(RNAME,$J,NAME,DATE,EDINO,TYPE),U,2)
 .... S CITY=$P(^TMP(RNAME,$J,NAME,DATE,EDINO,TYPE),U,3)
 .... S STATE=$P(^DIC(5,$P(^TMP(RNAME,$J,NAME,DATE,EDINO,TYPE),U,4),0),U,2)
 .... S EDIONFILE=$P(^TMP(RNAME,$J,NAME,DATE,EDINO,TYPE),U,5)
 .... S UPDATE=$S(EDIONFILE="":"Yes",1:"No")
 .... I LNCNT>MAX D HEADER Q:IBQUIT
 .... ;/vd - US3995 - IB*2*623 Modified the following line.
 .... S COMPADDR=$E(ADDRESS,1,39-$L(CITY)-$L(STATE)-3)_" "_CITY_", "_STATE  ; modified IB*2.0*623 v25
 .... ;W !,$E(NAME,1,30),?33,$E(ADDRESS,1,35)," ",CITY,", ",STATE,?73,$$FMTE^XLFDT(DATE,2),?84,PID,?97,EDIONFILE,?109,EDINO,?121,UPDATE
 .... W !,$E(NAME,1,30),?32,COMPADDR,?72,$$FMTE^XLFDT(DATE,2),?PIDPOS,PID,?105,EDIONFILE,?115,EDINO,?125,UPDATE
 .... S LNCNT=LNCNT+1
 I LNCNT>MAX D HEADER
 Q:IBQUIT
END W !!!,?49,EORMSG,!!!
 I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR    ;pause at end of report
 Q
 ;
HDRINIT ; Initial setting
 ;
 S LNCNT=0
 I PGC=1,$E(IOST,1,2)["C-" W @IOF  ; refresh terminal screen on 1st hdr
 I 'LNTOT S PAGES=1
 I LNTOT,PGC=1 D
 . S LNCNT=0
 . S PAGES=LNTOT/(MAX-10) I PAGES<1 S PAGES=1
 . I PAGES["." S PAGES=$P(PAGES+1,".")    ; if more than one page set whole number
 S HDR1="Clearinghouse Payer ID Report"
 S HDR2=$$FMTE^XLFDT($$NOW^XLFDT,1)
 Q
 ;
HEADER ; Print Header info
 ;
 N DIR,DUOUT
 S LNCNT=0
 I PGC'=1 D  Q:IBQUIT
 . W !
 . I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR I $D(DUOUT) S IBQUIT=1 Q:IBQUIT
 . W @IOF   ; refresh terminal screen on hdr
 W !,HDR1,?43,HDR2,?98,"  Page: "_PGC_" of "_PAGES
 W !,"Timeframe: "_BEGDT_" thru "_ENDDT
 W !!
 ;/vd - US3995 IB*2*623 - The following was changed modified.
 ;W !,"Insurance Co",?33,"Address",?73,"Date",?84,"EDI-PayerID",?97,"OldValue",?109,"NewValue",?121,"Updated"
 W !,"Insurance Co",?32,"Address",?72,"Date",?82,"EDI-PayerID",?94,"CLM-OFC-ID",?105,"OldValue",?115,"NewValue",?125,"Updated"
 W:+ASTERISK !,LEGEND W !,DASH    ;vd - IB*2.0*623 - added legend for US3994.
 S LNCNT=LNCNT+10,PGC=PGC+1
 Q
EXIT() ;clean up and quit
 N ZTREQ
 ; Force a form feed at end of a printer report
 I $E(IOST,1,2)'["C-" W @IOF
 ; handle device closing before exiting
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP(RNAME,$J)
 K BEGIN,BEGDT,ENDDT,IBABEG,IBAEND,IBQUIT,IEN,LNCNT,Y
 Q
