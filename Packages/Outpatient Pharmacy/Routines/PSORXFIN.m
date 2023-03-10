PSORXFIN ;BHAM ISC/TJL - VPS Productivity Report ;5/17/21  12:39
 ;;7.0;OUTPATIENT PHARMACY;**630**;JAN 2021;Build 26
 ;
EN ; entry point
 N I,X,Y,DATE,PSORUN,PSODESC,PSOSAVE
 N RXSTDT,RXENDDT,RANGE,PSOERR,QFLG
 S QFLG=0
 ; get today's date
 D NOW^%DTC S DATE=X,Y=$E(%,1,12) D DD^%DT S PSORUN=Y K %DT
 W !!,"This report prints a listing of people who finished the order in pharmacy"
 W !,"in the user-selected date range.",!
 D DATES Q:QFLG
 ;device selection
 S PSODESC="MbM-VPS Productivity Report"
 F I="PSODESC","RXSTDT","RXENDDT","RANGE" D
 . S PSOSAVE(I)=""
 D EN^XUTMDEVQ("PROCESS^PSORXFIN",PSODESC,.PSOSAVE)
 I POP W !!,"No device selected...exiting.",! Q
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 Q
DATES ; User inputs for date range
 N %DT,SRANGE,ERANGE,X,Y
 ;
RETRY S %DT="AEX",%DT("A")="Starting with Date: ",%DT(0)="-NOW" D ^%DT
 I Y<0 S QFLG=1 Q
 S RXSTDT=Y D DD^%DT S SRANGE=$$FMTE^XLFDT(Y,12)
 S %DT="AEX",%DT("A")="Ending with Date: ",%DT(0)="-NOW" D ^%DT
 I Y<0 S QFLG=1 Q
 I Y<RXSTDT D  G RETRY
 . W !!,"The ending date cannot be earlier than the starting date.",!
 S RXENDDT=Y D DD^%DT S ERANGE=$$FMTE^XLFDT(Y,12)
 S RANGE="Rx Orders finished from "_SRANGE_" through "_ERANGE
 Q
 ;
PROCESS ; entry point for queued report
 N ZTREQ
 S ZTREQ="@"
 S PSOERR=0 D EN1^PSORXFIN Q:PSOERR
 Q
EN1 ;
 N PAGENUM,FINISHDT,STOP
 K ^TMP("PSORXFIN",$J)
 S FINISHDT=RXSTDT-.1,RXENDDT=RXENDDT+.9999,(QFLG,PAGENUM,STOP)=0
 D HEADER I STOP D EXIT Q
 D GETDATA
 I ^TMP("PSORXFIN",$J,"GRAND TOTAL")=0 D  Q
 . W !
 . W !,?7,"***************************************************"
 . W !,?7,"*  Nothing to report for the selected time frame  *"
 . W !,?7,"***************************************************"
 . D WAIT
 D DETAIL I STOP D EXIT Q
 D TOTAL
 K ^TMP("PSORXFIN",$J)
 Q
 ;
GETDATA ; Get data
 N RXDA,RXOR1,FINIEN,FINNAME
 S ^TMP("PSORXFIN",$J,"GRAND TOTAL")=0
 F  S FINISHDT=$O(^PSRX("AFDT",FINISHDT)) Q:(FINISHDT>RXENDDT)!('FINISHDT)!(QFLG=1)  D
 . S RXDA=0
 . F  S RXDA=$O(^PSRX("AFDT",FINISHDT,RXDA)) Q:('RXDA)  D
 . . Q:'$D(^PSRX(RXDA,"OR1"))
 . . S RXOR1=$G(^PSRX(RXDA,"OR1"))
 . . S FINIEN=$P(RXOR1,"^",5)
 . . ; Get name of finisher
 . . S FINNAME=$$GET1^DIQ(200,+FINIEN,.01,"E")
 . . S:FINNAME="" FINNAME="ZZ^Missing from ^VA(200 :: DFN = "_FINIEN
 . . I '$D(^TMP("PSORXFIN",$J,FINNAME)) S ^TMP("PSORXFIN",$J,FINNAME)=0
 . . S ^TMP("PSORXFIN",$J,FINNAME)=^TMP("PSORXFIN",$J,FINNAME)+1
 . . S ^TMP("PSORXFIN",$J,"GRAND TOTAL")=^TMP("PSORXFIN",$J,"GRAND TOTAL")+1
 Q
 ;
HEADER ; Header and page control
 N LN
 W:$Y!($E(IOST)="C") @IOF S PAGENUM=PAGENUM+1
 S $P(LN,"-",80)=""
 W !,?1,"MbM-VPS Productivity Report",?51,"Run Date: ",PSORUN
 W !,?1,RANGE,?68,$$RJ^XLFSTR("Page: "_PAGENUM,11),!
 W !,?46,"Prescriptions"
 W !,?7,"Finishing Person",?48,"Finished"
 W !,LN
 Q
 ;
DETAIL ; Print detail line
 N RECORD,FCOUNT,NAME
 S RECORD="" F  S RECORD=$O(^TMP("PSORXFIN",$J,RECORD)) Q:(RECORD="")!(STOP)  D
 . S NAME=RECORD Q:NAME="GRAND TOTAL"
 . S:NAME["ZZ^" NAME=$P(NAME,"^",2,3)
 . S FCOUNT=^TMP("PSORXFIN",$J,RECORD)
 . W !,?7,NAME,?48,$$RJ^XLFSTR(FCOUNT,6)
 . I $Y>(IOSL-3) D WAIT Q:STOP  D HEADER
 Q
 ;
TOTAL ; Report totals
 N DASH
 S $P(DASH,"=",7)=""
 W !,?49,DASH
 W !?31,$$RJ^XLFSTR("Grand Total:  "_^TMP("PSORXFIN",$J,"GRAND TOTAL"),23)
 Q
 ;
WAIT ; End of page logic
 S STOP=0
 ;CRT - Prompt for continue
 I $E(IOST,1,2)="C-"&(IOSL'>24) D  Q
 . F  Q:$Y>(IOSL-3)  W !
 . N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 . S DIR(0)="E"
 . D ^DIR
 . S STOP=$S(Y'=1:1,1:0)
 ; Background task - check TaskMan
 S STOP=$$S^%ZTLOAD()
 I STOP D
 . W !,?7,"*********************************************"
 . W !,?7,"*  Printing of report stopped as requested  *"
 . W !,?7,"*********************************************"
 Q
EXIT ; Kill ^TMP Global
 K ^TMP("PSORXFIN",$J)
 Q
