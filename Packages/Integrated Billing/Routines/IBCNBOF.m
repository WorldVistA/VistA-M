IBCNBOF ;ALB/ARH - Ins Buffer: Employee Report (Entered) ; 1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,528,602,702**;21-MAR-94;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ;get parameters then run the report
 ;
 ; IB*702/DTG start not have form feed between first and second prompt
 ;S IBHDR="INSURANCE BUFFER EMPLOYEE REPORT" W @IOF,!!,?25,IBHDR
 ; IB*702/DTG start put report header before first question
 ;K ^TMP($J) I $G(IOF)="" D HOME^%ZIS
 ;S IBHDR="INSURANCE BUFFER EMPLOYEE REPORT" W !!,?25,IBHDR
 K ^TMP($J)
 ; IB*702/DTG end not have form feed between first and second prompt
 ;
 N IBBEGEX,IBBENEX,IBCO,IBCUR,IBCURFM,IBEDDT,IBOK,IBSTDT,IBBUFSM
 W !!,"This report produces a count of the number of entries added to the Buffer",!,"file for a specified date range sorted by employee.  Also included are",!,"sub-totals and percentages based on the current status of those entries."
 ;
10 ;ask if employee's
 S IBEMPL=$$EMPL^IBCNBOE I IBEMPL="" G:$$STOP^IBCNINSU EXIT G ENA^IBCNBOE
 W !!
 ;
15 ; ask employee name
 I +IBEMPL W ! S IBEMPL=$$SELEMPL^IBCNBOE("Enters/Creates") W:IBEMPL !! I IBEMPL="" G:$$STOP^IBCNINSU EXIT G 10
 ;
 ; IB*702/DTG start change of question flow
 ;
 ; S IBBEG=$$DATES^IBCNBOE("Beginning") G:'IBBEG EXIT
 ; S IBEND=$$DATES^IBCNBOE("Ending",IBBEG) G:'IBEND EXIT  W !!
 ;
 ; S IBMONTH=$$MONTH^IBCNBOE G:IBMONTH="" EXIT  W !!
 ;
 ;get current month/year
 S IBCURFM=$E(DT,1,5),IBCUR=$$EXMON^IBCNBOA(IBCURFM)
 ;
20 ; ask if for month
 S IBMONTH=$$MONTH^IBCNBOE I IBMONTH="" G:$$STOP^IBCNINSU EXIT G 15:+IBEMPL,10
 S IBOK=$$MTHBASE(1)
 I 'IBOK G:$$STOP^IBCNINSU EXIT G 15:+IBEMPL,10
 S IBBUFSM=$P(IBOK,U,2)
 ;
209 ; come here for dates if going back
 ;
 ; month dates
 I IBMONTH S (IBOK,IBCO)=0 D  I 'IBOK G:IBCO=2 EXIT G 20
 . D 22 I 'IBCO!(IBCO=2) Q
 . S IBOK=1
 ;
 ; daily dates
 I 'IBMONTH S (IBOK,IBCO)=0 D  I 'IBOK G:IBCO=2 EXIT G 20
 . D 25 I 'IBCO!(IBCO=2) Q
 . S IBOK=1
 ;
 W !!
 ;
 ;
 ; IB*702/DTG end change of question flow
 ;
30 ; ask report type
 ;S IBOUT=$$OUT^IBCNBOE G:IBOUT="" EXIT
 S IBOUT=$$OUT^IBCNBOE I IBOUT="" G:$$STOP^IBCNINSU EXIT  G 209
 ; IB*702/DTG start warn line length if excel
 I IBOUT="E" W !!,"To avoid undesired wrapping, please enter '0;256;999' at the 'DEVICE:' prompt.",!
 ; IB*702/DTG end warn line length if excel
 ;
DEV ;get the device
 N POP,ZTDESC,ZTRTN
 I IBOUT="R" W !,"Report requires 132 columns."
 ;S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 S %ZIS="QM",%ZIS("A")="DEVICE: "
 D ^%ZIS
 I POP G:$$STOP^IBCNINSU EXIT  G 30
 ; IB*702/DTG start keep IOM at 132 if report
 I $E($G(IBOUT),1)="R" S IOM=132
 ; IB*702/DTG end keep IOM at 132 if report
 I $D(IO("Q")) S ZTRTN="RPT^IBCNBOF",ZTDESC=IBHDR,ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q"),ZTSAVE G EXIT
 K %ZIS
 U IO
 G RPT
 ;
 ;
22 ; starting month ; IB*702
 ;
 ; starting date
 S IBCO=0,IBSTDT=$$IBSM^IBCNBOA("Beginning","")
 I 'IBSTDT S:$$STOP^IBCNINSU IBCO=2 Q
 S IBBEGEX=$P(IBSTDT,U,2),IBSTDT=$P(IBSTDT,U,1)
 S IBBEG=IBSTDT_"01"
 ;
23 ; ending month ; IB*702
 ;
 W !
 S IBEDDT=$$IBSM^IBCNBOA("Ending",IBSTDT)
 S IBBENEX=$P(IBEDDT,U,2),IBEDDT=$P(IBEDDT,U,1)
 I 'IBEDDT G:'$$STOP^IBCNINSU 22 S IBCO=2 Q
 S IBEND=$$LAST^IBAGMM(IBEDDT)
 S IBCO=1
 Q
 ;
25 ; starting date ; IB*702
 ;
 S IBBEG=$$DATES^IBCNBOE("Beginning") I 'IBBEG S:$$STOP^IBCNINSU IBCO=2 Q
 ;
26 ; ending date ; IB*702
 ;
 W !
 S IBEND=$$DATES^IBCNBOE("Ending",IBBEG) I 'IBEND G:'$$STOP^IBCNINSU 25 S IBCO=2 Q
 S IBCO=1
 Q
 ;
 ; IB*702/DTG end Change for up-caret response
 ;
RPT ; run report
 S IBQUIT=0
 ;
 D SEARCH(IBBEG,IBEND,IBMONTH,IBEMPL) G:IBQUIT EXIT
 D PRINT(IBBEG,IBEND,IBMONTH,IBEMPL,IBOUT)
 ;
EXIT K ^TMP($J),IBHDR,IBBEG,IBEND,IBMONTH,IBOUT,IBQUIT,IBEMPL
 Q:$D(ZTQUEUED)
 D ^%ZISC
 Q
 ;
SEARCH(IBBEG,IBEND,IBMONTH,IBEMPL) ; search/sort statistics for employee report
 N IBXDT,IBBUFDA,IBB0,IBXREF,IBS1,IBEMP
 S IBBEG=$G(IBBEG)-.01,IBEND=$S('$G(IBEND):9999999,1:$P(IBEND,".")+.9)
 ;
 S IBXDT=IBBEG F  S IBXDT=$O(^IBA(355.33,"B",IBXDT)) Q:'IBXDT!(IBXDT>IBEND)  D  S IBQUIT=$$STOP Q:IBQUIT
 . S IBBUFDA=0 F  S IBBUFDA=$O(^IBA(355.33,"B",IBXDT,IBBUFDA)) Q:'IBBUFDA  D
 .. ;
 .. S IBB0=$G(^IBA(355.33,IBBUFDA,0)),IBEMP=+$P(IBB0,U,2) I 'IBEMP Q
 .. I +IBEMPL,IBEMPL'=IBEMP Q
 .. ;
 .. I $G(IBMONTH) D SET("IBCNBOF",IBEMP,$E(+IBB0,1,5),$P(IBB0,U,4),+$P(IBB0,U,7),+$P(IBB0,U,8),+$P(IBB0,U,9))
 .. D SET("IBCNBOF",IBEMP,99999,$P(IBB0,U,4),+$P(IBB0,U,7),+$P(IBB0,U,8),+$P(IBB0,U,9))
 .. D SET("IBCNBOF","~",99999,$P(IBB0,U,4),+$P(IBB0,U,7),+$P(IBB0,U,8),+$P(IBB0,U,9))
 ;
 Q
 ;
SET(XREF,S1,S2,STAT,NC,NG,NP) ;
 S ^TMP($J,XREF,S1,S2,"CNT")=$G(^TMP($J,XREF,S1,S2,"CNT"))+1
 I STAT="E" S ^TMP($J,XREF,S1,S2,"EN")=$G(^TMP($J,XREF,S1,S2,"EN"))+1
 I STAT="R" S ^TMP($J,XREF,S1,S2,"RJ")=$G(^TMP($J,XREF,S1,S2,"RJ"))+1
 I STAT="A" S ^TMP($J,XREF,S1,S2,"AC")=$G(^TMP($J,XREF,S1,S2,"AC"))+1
 I +NC S ^TMP($J,XREF,S1,S2,"NC")=$G(^TMP($J,XREF,S1,S2,"NC"))+1
 I +NG S ^TMP($J,XREF,S1,S2,"NG")=$G(^TMP($J,XREF,S1,S2,"NG"))+1
 I +NP S ^TMP($J,XREF,S1,S2,"NP")=$G(^TMP($J,XREF,S1,S2,"NP"))+1
 Q
 ;
 ;
PRINT(IBBEG,IBEND,IBMONTH,IBEMPL,IBOUT) ;
 N IBXREF,IBS1,IBS2,IBRDT,IBPGN,IBRANGE,IBLN,IBI
 ;
 ; IB*702/DTG start stop push of line on screen up
 N MAXCNT,CRT
 I IOST["C-" S MAXCNT=IOSL-2
 E  S MAXCNT=IOSL-6
 ; IB*702/DTG end stop push of line on screen up
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 S IBRANGE=$$FMTE^XLFDT(IBBEG)_" - "_$$FMTE^XLFDT(IBEND)
 S IBRDT=$$FMTE^XLFDT($J($$NOW^XLFDT,0,4),2),IBRDT=$TR(IBRDT,"@"," "),(IBLN,IBPGN)=0
 ; IB*702/DTG start Combine vars, no data check, end of report
 S IBXREF="IBCNBOF",IBS1=""
 ;
 D HDR:IBOUT="R",PHDL:IBOUT="E"
 I '$D(^TMP($J,IBXREF)) D  Q
 . W ! W:$G(IBOUT)="R" ?((IOM\2)-17) W "* * * N O  D A T A  F O U N D * * *",!
 . D EOR(132)
 . S IBI=$$PAUSE
 ;
 ;S IBXREF="IBCNBOF",IBS1="" F  S IBS1=$O(^TMP($J,IBXREF,IBS1)) Q:IBS1=""  D  Q:IBQUIT ; /IB*702
 F  S IBS1=$O(^TMP($J,IBXREF,IBS1)) D:IBS1="" EOR(132) Q:IBS1=""  D  Q:IBQUIT
 . ; IB*702/DTG start stop push of line on screen up
 . ;I +$G(IBMONTH),(IBOUT="R") W ! S IBLN=IBLN+1
 . I +$G(IBMONTH),(IBOUT="R") D  Q:IBQUIT
 .. I IBLN+1>MAXCNT D HDR Q:IBQUIT
 .. I $G(IBLN)>5 W ! S IBLN=IBLN+1
 . ;
 . ;S IBS2=0 F  S IBS2=$O(^TMP($J,IBXREF,IBS1,IBS2)) Q:IBS2=""  D:IBLN>(IOSL-3)&(IBOUT="R") HDR Q:IBQUIT  D
 . S IBS2=0 F  S IBS2=$O(^TMP($J,IBXREF,IBS1,IBS2)) Q:IBS2=""  D  I IBQUIT Q
 .. I IBLN+1>MAXCNT&(IBOUT="R") D HDR Q:IBQUIT
 .. D PRTLN  S IBLN=IBLN+1
 .. ; IB*702/DTG end stop push of line on screen up
 ;
 ; IB*702/DTG end Combine vars, no data check, end of report
 ;
 I 'IBQUIT S IBI=$$PAUSE
 Q
 ;
 ; IB*702/DTG start Combine parts for excel and report
 ;
EOR(IBLE) ; write end of report
 I '$G(IBLE) S IBLE=80
 I IBLN+2>MAXCNT D HDR Q:IBQUIT
 W ! W:$G(IBOUT)="R" ?((IBLE\2)-10) W "*** END OF REPORT ***"
 Q
 ;
EXN(IBBN) ; round number by .05 return with 1st decimal
 N IBBW,IBBX,IBBR
 S IBBN=+$G(IBBN)
 S IBBW=$S($E(IBBN,1)="-":"-",1:"")
 S IBBX=IBBN+(IBBW_.05)
 S:$P(IBBX,".",1)="" IBBX="0"_"."_$P(IBBX,".",2)
 S IBBR=$P(IBBX,".",1)_"."_+($E($P(IBBX,".",2),1))
 Q IBBR
 ;
 ; IB*702/DTG end Combine parts for excel and report
 ;
PRTLN ; IB*702 Rewrote tag to print zeros for statuses with no counts
 N IBBA,IBBC,IBEMP,IBCNT,IBEN,IBAC,IBRJ,IBNC,IBNG,IBNP,DATM
 ;
 S IBEMP=$P($G(^VA(200,+IBS1,0)),U,1) I IBS1="~" S IBEMP="TOTAL"
 ;S IBCNT=$G(^TMP($J,IBXREF,IBS1,IBS2,"CNT")) Q:'IBCNT  ;IB*702 removed quit
 S IBCNT=$G(^TMP($J,IBXREF,IBS1,IBS2,"CNT"))
 S IBEN=$G(^TMP($J,IBXREF,IBS1,IBS2,"EN"))
 S IBAC=$G(^TMP($J,IBXREF,IBS1,IBS2,"AC"))
 S IBRJ=$G(^TMP($J,IBXREF,IBS1,IBS2,"RJ"))
 S IBNC=$G(^TMP($J,IBXREF,IBS1,IBS2,"NC"))
 S IBNG=$G(^TMP($J,IBXREF,IBS1,IBS2,"NG"))
 S IBNP=$G(^TMP($J,IBXREF,IBS1,IBS2,"NP"))
 ;S DATM=$S(IBS2=99999:"TOTAL",1:$$FMTE^XLFDT(IBS2_"00"))
 S DATM=$S((IBS2=99999&$G(IBMONTH)):"TOTAL",(IBS2=99999&'$G(IBMONTH)):"",1:$$FMTE^XLFDT(IBS2_"00"))
 ;
 ; Excel output
 I IBOUT="E" D  Q
 . W !,IBEMP_U_DATM_U_$FN(IBCNT,",")_U_$FN(IBEN,",")_U
 . S IBBA=$S((IBCNT'=""&(IBEN'="")):((IBEN/IBCNT)*100),1:0),IBBC=$$EXN(IBBA) W IBBC_"%"_U
 . W $FN(IBAC,",")_U
 . S IBBA=$S((IBCNT'=""&(IBAC'="")):((IBAC/IBCNT)*100),1:0),IBBC=$$EXN(IBBA) W IBBC_"%"_U
 . W U_$FN(IBRJ,",")_U
 . S IBBA=$S((IBCNT'=""&(IBRJ'="")):((IBRJ/IBCNT)*100),1:0),IBBC=$$EXN(IBBA) W IBBC_"%"_U
 . W $FN(IBNC,",")_U_$FN(IBNG,",")_U_$FN(IBNP,",")
 ;
 ; Report output
 W !,$E(IBEMP,1,15),?17,DATM,?25,$J($FN(IBCNT,","),7)
 W ?35,$J($FN(IBEN,","),7)
 S IBBA=$S((IBCNT'=""&(IBEN'="")):((IBEN/IBCNT)*100),1:0),IBBC=$$EXN(IBBA) W ?43,$J("("_IBBC_"%)",8)
 W ?54,$J($FN(IBAC,","),7)
 S IBBA=$S((IBCNT'=""&(IBAC'="")):((IBAC/IBCNT)*100),1:0),IBBC=$$EXN(IBBA) W ?62,$J("("_IBBC_"%)",8)
 W ?73,$J($FN(IBRJ,","),7)
 S IBBA=$S((IBCNT'=""&(IBRJ'="")):((IBRJ/IBCNT)*100),1:0),IBBC=$$EXN(IBBA) W ?81,$J("("_IBBC_"%)",8)
 W ?92,$J($FN(IBNC,","),7),?102,$J($FN(IBNG,","),7),?112,$J($FN(IBNP,","),7)
 Q
 ;
HDR ;print the report header
 S IBQUIT=$$STOP Q:IBQUIT
 I IBPGN>0 S IBQUIT=$$PAUSE Q:IBQUIT
 S IBPGN=IBPGN+1,IBLN=5 I IBPGN>1!($E(IOST,1,2)["C-") W @IOF
 ; IB*702/DTG start change INSURANCE to INS
 ;W !,"INSURANCE BUFFER (ENTERING) EMPLOYEE REPORT   ",IBRANGE," "
 W !,"INS BUFFER (ENTERING) EMPLOYEE REPORT  ",IBRANGE," "
 ;W ?(IOM-22),IBRDT,?(IOM-7)," PAGE ",IBPGN,!,?39,"NOT YET",?93,"NEW",?104,"NEW",?113,"NEW"
 W ?(IOM-24),IBRDT,?(IOM-9)," PAGE ",IBPGN
 W !,?39,"NOT YET",?93,"NEW",?104,"NEW",?113,"NEW"
 ;W !,"EMPLOYEE",?17,"MONTH",?27,"TOTAL",?39,"PROCESSED",?58,"ACCEPTED",?77,"REJECTED",?93,"INS CO",?104,"GROUP",?113,"POLICY",!
 W !,"EMPLOYEE" W:$G(IBMONTH) ?17,"MONTH" W ?27,"TOTAL",?39,"PROCESSED",?58,"ACCEPTED",?77,"REJECTED",?93,"INS CO"
 W ?104,"GROUP",?113,"POLICY",!
 S IBI="",$P(IBI,"-",IOM+1)="" W IBI
 Q
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 N X
 ; IB*602/HN ; Add report headers to Excel Spreadsheets 
 ;W !,"INSURANCE BUFFER (ENTERING) EMPLOYEE REPORT^"_IBRANGE_"^"_$$FMTE^XLFDT($$NOW^XLFDT,1),!
 W !,"INS BUFFER (ENTERING) EMPLOYEE REPORT^"_IBRANGE_"^"_$$FMTE^XLFDT($$NOW^XLFDT,1),!
 ; IB*602/HN end  
 ;S X="EMPLOYEE^MONTH^TOTAL^NOT YET PROCESSED^% NOT YET PROCESSED^ACCEPTED^% ACCEPTED^REJECTED^% REJECTED^NEW INS CO^NEW GROUP^NEW POLICY"
 S X="EMPLOYEE^"
 S:$G(IBMONTH) X=X_"MONTH"
 S X=X_"^TOTAL^NOT YET PROCESSED^% NOT YET PROCESSED^ACCEPTED^% ACCEPTED^REJECTED^% REJECTED^NEW INS CO^NEW GROUP^NEW POLICY"
 W X
 K X
 Q
 ; IB*702/DTG end change INSURANCE to INS
 ;
PAUSE() ;pause at end of screen if beeing displayed on a terminal
 N IBX,DIR,DIRUT,DUOUT,X,Y,LIN S IBX=0
 ; IB*702/DTG start stop push of line on screen up
 ;I $E(IOST,1,2)["C-" W !! S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DIRUT)) S IBX=1
 I $E(IOST,1,2)["C-" D
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-IBLN) W !
 . E  W !
 . S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DIRUT)) S IBX=1
 ; IB*702/DTG end stop push of line on screen up
 Q IBX
 ;
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
 ;
 ; IB*702/DTG start if month, get first and last allowed month and if month is allowed
MTHBASE(IBMONTH) ; set base var's for month year prompts
 ;
 N IBBA,IBBB,IBBC,IBBD,IBBF,IBBUFEM,IBBUFEME,IBBUFSD,IBBUFSM,IBBUFSME
 S (IBBEG,IBEND,IBSTDT,IBEDDT,IBCO,IBBUFSM,IBBUFSME,IBBUFEM,IBBUFEME,IBBUFSD)=""
 ;
 I 'IBMONTH Q ""
 S IBBUFSD=$O(^IBA(355.33,"B",0))
 I IBBUFSD D
 . ; check if first date is complete month
 . S IBBC=+$E(IBBUFSD,6,7),IBBB=$E(IBBUFSD,1,3) I IBBC'=1 D  ;<
 . . ; get first day of next month
 . . S IBBA=+$E(IBBUFSD,4,5)+1 S:$L(IBBA)=1 IBBA="0"_IBBA I IBBA>12 D
 . . . S IBBB=$E(IBBUFSM,1,3)+1,IBBA="01"
 . . S IBBD=IBBB_IBBA_"00.999999",IBBUFSD=$O(^IBA(355.33,"B",IBBD))
 I 'IBBUFSD D  Q 0
 . D EN^DDIOL("May Not run Month option since there is not a complete 'Month Year' ","","!")
 S IBBUFSM=$E(IBBUFSD,1,5)
 I IBBUFSM'="" S IBBUFSME=$$EXMON^IBCNBOA(IBBUFSM)
 I IBBUFSM'=""&((IBBUFSM=IBCURFM)!(IBBUFSM>IBCURFM)) D  Q 0
 . D EN^DDIOL("May Not run Month option since the buffer start is the current 'Month Year' "_IBCUR,"","!")
 ; get buffer ending month/year prior to current month/year
 S IBBUFEM=$O(^IBA(355.33,"B",(IBCURFM_"01.000000")),-1),IBBUFEM=$E(IBBUFEM,1,5)
 I IBBUFEM="" D EN^DDIOL("Incomplete ending buffer entries","","!") Q 0
 S IBBUFEME=$$EXMON^IBCNBOA(IBBUFEM)
 S IBBF=1_U_IBBUFSM
 Q IBBF
 ; IB*702/DTG end if month, get first and last allowed month and if month is allowed
 ;
