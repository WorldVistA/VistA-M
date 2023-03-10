IBCNBOE ;ALB/ARH - Ins Buffer: Employee Report ; 1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,528,602,702**;21-MAR-94;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ;get parameters then run the report
 ; IB*702/DTG start newed following variables
 N IBBA,IBBB,IBBC,IBBD,IBBEG,IBBEGEX,IBBENEX,IBBUFEM,IBBUFEME,IBBUFSD,IBBUFSM,IBBUFSMD,IBBUFSME,IBCHGDT
 N IBCO,IBCUR,IBCURFM,IBEDDT,IBEMPL,IBEND,IBHDR,IBL,IBLM,IBMONTH,IBOK,IBOUT,IBQUIT,IBSTDT,ZTQUEUED,ZTSTOP
 N IBX
 ; IB*702/DTG end newed following variables
 ;
 ; IB*702/DTG start put report header before first question
 I $G(IOF)="" D HOME^%ZIS
 S IBHDR="INSURANCE BUFFER EMPLOYEE REPORT" W !!,?25,IBHDR
 ;
 ; IB*702/DTG start Change for up-caret response
ENA ; allow for up-caret responses
 ; N IBX S IBX=$$WR Q:'IBX  I IBX=1 G ^IBCNBOF ; WHICH REPORT?  entered or processed
 S IBX=$$WR I 'IBX G EXIT  ; WHICH REPORT?  entered or processed
 I IBX=1 G ^IBCNBOF
 ;
 ;
 ; IB*702/DTG start not have form feed between first and second prompt
 ;K ^TMP($J) I $G(IOF)="" D HOME^%ZIS
 ;S IBHDR="INSURANCE BUFFER INSURANCE EMPLOYEE REPORT" W @IOF,!!,?17,IBHDR
 K ^TMP($J)
 ;S IBHDR="INSURANCE BUFFER INSURANCE EMPLOYEE REPORT" W !!,?17,IBHDR
 ; IB*702/DTG end put report header before first question
 ; IB*702/DTG end not have form feed between first and second prompt
 ;
 ; IB*702/DTG start remove verified from report
 W !!,"This report produces counts and time statistics for Insurance Employees that"
 ;W !,"have either Verified or Processed (Accept/Reject) an Insurance Buffer entry.",!!
 W !,"have Processed (Accept/Reject) an Insurance Buffer entry.",!!
 ; IB*702/DTG end remove verified from report
 ;
10 ; ask if all employees
 S IBEMPL=$$EMPL I IBEMPL="" G:$$STOP^IBCNINSU EXIT G ENA
 ;
 W !!
15 ; ask employee name
 I +IBEMPL W ! S IBEMPL=$$SELEMPL("Processes") W:IBEMPL !! I IBEMPL="" G:$$STOP^IBCNINSU EXIT G 10
 ;
 ; IB*702/DTG start change of question flow
 ;
 ; S IBBEG=$$DATES("Beginning") G:'IBBEG EXIT
 ; S IBEND=$$DATES("Ending",IBBEG) G:'IBEND EXIT  W !!
 ;
 ; S IBMONTH=$$MONTH^IBCNBOE G:IBMONTH="" EXIT  W !!
 ;
 ;get current month/year
 S IBCURFM=$E(DT,1,5),IBCUR=$$EXMON^IBCNBOA(IBCURFM)
 ;
20 ; ask if for month
 S IBMONTH=$$MONTH I IBMONTH="" G:$$STOP^IBCNINSU EXIT G 15:+IBEMPL,10
 S IBOK=$$MTHBASE^IBCNBOF(1)
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
 ; IB*702/DTG end change of question flow
 ;
30 ; ask type of report
 S IBOUT=$$OUT I IBOUT="" G:$$STOP^IBCNINSU EXIT  G 209
 ; IB*702/DTG start warn line length if excel
 I IBOUT="E" W !!,"To avoid undesired wrapping, please enter '0;256;999' at the 'DEVICE:' prompt.",!
 ; IB*702/DTG end warn line length if excel
 ;
DEV ;get the device
 N %ZIS,POP,ZTDESC,ZTRTN,ZTSAVE
 ;S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 S %ZIS="QM",%ZIS("A")="DEVICE: "
 D ^%ZIS
 I POP G:$$STOP^IBCNINSU EXIT  G 30
 ; IB*702/DTG start keep IOM at 80 if report
 I $E($G(IBOUT),1)="R" S IOM=80
 ; IB*702/DTG end keep IOM at 80 if report
 I $D(IO("Q")) S ZTRTN="RPT^IBCNBOE",ZTDESC=IBHDR,ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q") G EXIT
 U IO
 G RPT
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
 D PRINT(IBBEG,IBEND,IBEMPL,IBOUT)
 ;
EXIT K ^TMP($J),IBBA,IBBB,IBBC,IBBD,IBBEG,IBBEGEX,IBBENEX,IBBUFEM,IBBUFEME,IBBUFSD,IBBUFSM,IBBUFSMD,IBBUFSME,IBCHGDT
 K IBCO,IBCUR,IBCURFM,IBEDDT,IBEMPL,IBEND,IBHDR,IBL,IBLM,IBMONTH,IBOK,IBOUT,IBQUIT,IBSTDT,IBX
 Q:$D(ZTQUEUED)
 D ^%ZISC
 Q
 ;
SEARCH(IBBEG,IBEND,IBMONTH,IBEMPL) ; search/sort statistics for activity report
 N IBXST,IBXDT,IBBUFDA,IBB0,IBDATE,IBEMP,IBTIME,IBSTAT,IBDT2,IBVER,IBS3 S IBQUIT=""
 S IBBEG=$G(IBBEG)-.01,IBEND=$S('$G(IBEND):9999999,1:$P(IBEND,".")+.9)
 ;
 ; IB*702/DTG start remove verified from report
 ; F IBXST="A","R","V"  D  Q:IBQUIT
 F IBXST="A","R"  D  Q:IBQUIT
 . S IBXDT=IBBEG F  S IBXDT=$O(^IBA(355.33,"AFST",IBXST,IBXDT)) Q:'IBXDT!(IBXDT>IBEND)  D  S IBQUIT=$$STOP Q:IBQUIT
 .. S IBBUFDA=0 F  S IBBUFDA=$O(^IBA(355.33,"AFST",IBXST,IBXDT,IBBUFDA)) Q:'IBBUFDA  D
 ... ;
 ... S IBB0=$G(^IBA(355.33,IBBUFDA,0))
 ... ;
 ... ; verified
 ... ;I IBXST="V" S IBDATE=+$P(IBB0,U,10) I +IBDATE,IBDATE>IBBEG,IBDATE<IBEND D
 ...;. S IBEMP=+$P(IBB0,U,11) I +IBEMPL,IBEMPL'=IBEMP Q
 ...;. S IBTIME=$$FMDIFF^XLFDT(IBDATE,+IBB0,2),IBSTAT="VERIFIED",IBS3=1
 ...;. D SET(IBSTAT,IBEMP,$E(IBDATE,1,5),IBS3,IBTIME,IBB0,$G(IBMONTH))
 ...; IB*702/DTG end remove verified from report
 ... ;
 ... ; processed
 ... I IBXST="A"!(IBXST="R") S IBDATE=+$P(IBB0,U,5) I +IBDATE,IBDATE>IBBEG,IBDATE<IBEND D
 .... S IBEMP=+$P(IBB0,U,6) I +IBEMPL,IBEMPL'=IBEMP Q
 .... S IBVER=$P(IBB0,U,10),IBSTAT="UNKNOWN",IBS3=6
 .... S IBDT2=$S(+IBVER:+IBVER,1:+IBB0),IBTIME=$$FMDIFF^XLFDT(IBDATE,+IBDT2,2)
 .... ;
 .... ; IB*702/DTG start remove &V and V
 .... ;I $P(IBB0,U,4)="A" S IBS3=2,IBSTAT="ACCEPTED" I 'IBVER S IBS3=3,IBSTAT=IBSTAT_" (&V)"
 .... ;I $P(IBB0,U,4)="R" S IBS3=4,IBSTAT="REJECTED" I +IBVER S IBS3=5,IBSTAT=IBSTAT_" (V)"
 .... I $P(IBB0,U,4)="A" S IBS3=2,IBSTAT="ACCEPTED"
 .... I $P(IBB0,U,4)="R" S IBS3=4,IBSTAT="REJECTED"
 .... ; IB*702/DTG end remove &V and V
 .... D SET(IBSTAT,IBEMP,$E(IBDATE,1,5),IBS3,IBTIME,IBB0,$G(IBMONTH))
 ;
 Q
 ;
SET(STAT,IBEMP,IBDATE,S3,TIME,IBB0,IBMONTH) ;
 I +$G(IBMONTH) D SET1(IBSTAT,IBEMP,$E(IBDATE,1,5),S3,IBTIME,IBB0)
 D SET1(IBSTAT,IBEMP,99999,S3,IBTIME,IBB0)
 D SET1(IBSTAT,"~",99999,S3,IBTIME,IBB0)
 Q
 ;
SET1(STAT,S1,S2,S3,TIME,IBB0) ;
 ;
 D TMP("IBCNBOE",S1,S2,S3,TIME,STAT)
 D TMP("IBCNBOE",S1,S2,9,TIME,"TOTAL")
 ;
 Q:$E(STAT)'="A"
 ;
 D TMP1("IBCNBOEC",S1,S2,+$P(IBB0,U,7),+$P(IBB0,U,8),+$P(IBB0,U,9))
 Q
 ;
TMP(XREF,S1,S2,S3,TIME,NAME) ;
 S ^TMP($J,XREF,S1,S2,S3)=NAME
 S ^TMP($J,XREF,S1,S2,S3,"CNT")=$G(^TMP($J,XREF,S1,S2,S3,"CNT"))+1
 S ^TMP($J,XREF,S1,S2,S3,"TM")=$G(^TMP($J,XREF,S1,S2,S3,"TM"))+TIME
 I '$G(^TMP($J,XREF,S1,S2,S3,"HG"))!($G(^TMP($J,XREF,S1,S2,S3,"HG"))<TIME) S ^TMP($J,XREF,S1,S2,S3,"HG")=TIME
 I '$G(^TMP($J,XREF,S1,S2,S3,"LS"))!($G(^TMP($J,XREF,S1,S2,S3,"LS"))>TIME) S ^TMP($J,XREF,S1,S2,S3,"LS")=TIME
 ; IB*702/DTG start call set stubs for item entries.
 D TMPCHK(XREF,S1,S2,S3,TIME,NAME)
 ; IB*702/DTG end call set stubs for item entries.
 Q
 ;
 ; IB*702/DTG start set stubs for item entries.
TMPCHK(XREF,S1,S2,S3,TIME,NAME) ; check if not there set stub for all if one is set
 ; use S1 (emp) and S2 (date), S3  1, 2, 4, 9
 N IBBI
 F IBBI=2,4,9 I $G(^TMP($J,XREF,S1,S2,IBBI))="" D
 . S ^TMP($J,XREF,S1,S2,IBBI)=$P(",ACCEPTED,,REJECTED,,,,,TOTAL",",",IBBI)
 . S ^TMP($J,XREF,S1,S2,IBBI,"CNT")=""
 . S ^TMP($J,XREF,S1,S2,IBBI,"TM")=""
 . I $G(^TMP($J,XREF,S1,S2,IBBI,"HG"))="" S ^TMP($J,XREF,S1,S2,IBBI,"HG")=""
 . I $G(^TMP($J,XREF,S1,S2,IBBI,"LS"))="" S ^TMP($J,XREF,S1,S2,IBBI,"LS")=""
 Q
 ; IB*702/DTG end set stubs for item entries.
 ;
TMP1(XREF,S1,S2,IC,GC,PC) ;
 I +IC S ^TMP($J,XREF,S1,S2,"I")=$G(^TMP($J,XREF,S1,S2,"I"))+1
 I +GC S ^TMP($J,XREF,S1,S2,"G")=$G(^TMP($J,XREF,S1,S2,"G"))+1
 I +PC S ^TMP($J,XREF,S1,S2,"P")=$G(^TMP($J,XREF,S1,S2,"P"))+1
 S ^TMP($J,XREF,S1,S2,"CNT")=$G(^TMP($J,XREF,S1,S2,"CNT"))+1
 Q
 ;
 ;
 ;
PRINT(IBBEG,IBEND,IBEMPL,IBOUT) ;
 N IBXREF,IBLABLE,IBEMPN,IBS1,IBS2,IBS3,IBINS,IBGRP,IBPOL,IBCNT,IBIP,IBGP,IBPP,IBRDT,IBPGN,IBRANGE,IBLN,IBI
 ;
 ; IB*702/DTG start stop push of line on screen up
 N MAXCNT,CRT
 S MAXCNT=IOSL-8
 ; IB*702/DTG end stop push of line on screen up
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 S IBRANGE=$$FMTE^XLFDT(IBBEG)_" - "_$$FMTE^XLFDT(IBEND)
 S IBRDT=$$FMTE^XLFDT($J($$NOW^XLFDT,0,4),2),IBRDT=$TR(IBRDT,"@"," "),(IBLN,IBPGN)=0
 ; IB*702/DTG start Combine vars, no data check, end of report
 S IBXREF="IBCNBOE",IBS1=""
 ;
 D HDR:IBOUT="R",PHDL:IBOUT="E"
 I '$D(^TMP($J,IBXREF)) D  Q
 . W ! W:$G(IBOUT)="R" ?((IOM\2)-17) W "* * * N O  D A T A  F O U N D * * *",!
 . D EOR^IBCNBOF(IOM)
 . S IBI=$$PAUSE
 ;
 ;
 ; Excel output
 I IBOUT="E" D  S IBI=$$PAUSE Q
 . ;S IBXREF="IBCNBOE",IBS1="" F  S IBS1=$O(^TMP($J,IBXREF,IBS1)) Q:IBS1=""  D
 . F  S IBS1=$O(^TMP($J,IBXREF,IBS1)) D:IBS1="" EOR(132) Q:IBS1=""  D
 .. S IBS2=0 F  S IBS2=$O(^TMP($J,IBXREF,IBS1,IBS2)) Q:IBS2=""  D
 ... D GETLABL
 ... S IBS3="" F  S IBS3=$O(^TMP($J,IBXREF,IBS1,IBS2,IBS3)) Q:'IBS3  D PRTLN
 ... ;
 ... D GETOAC
 ... W U_IBINS_U_IBIP_"%"_U_IBGRP_U_IBGP_"%"_U_IBPOL_U_IBPP_"%"
 ;
 ; Report Section
 ;D HDR
 ;
 ;S IBXREF="IBCNBOE",IBS1="" F  S IBS1=$O(^TMP($J,IBXREF,IBS1)) Q:IBS1=""  D  Q:IBQUIT
 F  S IBS1=$O(^TMP($J,IBXREF,IBS1)) D:IBS1="" EOR(80) Q:IBS1=""  D  Q:IBQUIT
 . ;
 . ;S IBS2=0 F  S IBS2=$O(^TMP($J,IBXREF,IBS1,IBS2)) Q:IBS2=""  D:IBLN>(IOSL-15) HDR Q:IBQUIT  D  S IBLN=IBLN+8
 . S IBS2=0 F  S IBS2=$O(^TMP($J,IBXREF,IBS1,IBS2)) Q:IBS2=""  D:IBLN+8>MAXCNT HDR Q:IBQUIT  D  S IBLN=IBLN+8 ; IB*702/DTG
 .. D GETLABL
 .. W !,?(40-($L(IBLABLE)/2)),IBLABLE,!
 .. W !,?43,"AVERAGE",?56,"LONGEST",?68,"SHORTEST"
 .. W !,"STATUS",?22,"COUNT",?30,"PERCENT",?43,"# DAYS",?56,"# DAYS",?68,"# DAYS"
 .. W !,"-----------------------------------------------------------------------------"
 .. ;
 .. S IBS3="" F  S IBS3=$O(^TMP($J,IBXREF,IBS1,IBS2,IBS3)) Q:'IBS3  D PRTLN  S IBLN=IBLN+1
 .. ;
 .. D GETOAC
 .. W !!,?2,IBINS," New Compan",$S(IBINS=1:"y",1:"ies")," (",IBIP,"%), "
 .. W IBGRP," New Group/Plan",$S(IBGRP=1:"",1:"s")," (",IBGP,"%), "
 .. W IBPOL," New Patient Polic",$S(IBPOL=1:"y",1:"ies")," (",IBPP,"%)",!
 ;
 I 'IBQUIT S IBI=$$PAUSE
 Q
 ;
 ; IB*702/DTG start Combine parts for excel and report
 ;
GETLABL ; pick up common values for Excel and Report
 ;
 S IBLABLE=$S(IBS2=99999:"TOTALS",($E(IBBEG,1,5)<IBS2)&($E(IBEND,1,5)>IBS2):$$FMTE^XLFDT(IBS2_"00"),1:"")
 I IBLABLE="" D  ;<
 . S IBLABLE=$$FMTE^XLFDT($S($E(IBBEG,1,5)<IBS2:IBS2_"01",1:IBBEG))_" - "_$$FMTE^XLFDT($S($E(IBEND,1,5)>IBS2:$$SCH^XLFDT("1M(L)",IBS2_11),1:IBEND))
 . I $G(IBMONTH)&(IBLABLE["-") S IBLABLE=$$FMTE^XLFDT(IBS2_"00")
 S IBEMPN=$P($G(^VA(200,IBS1,0)),U,1)
 I IBOUT="R" S IBLABLE=IBEMPN_"  "_IBLABLE
 Q
 ;
GETOAC ; pick up items for IBCNBOEC
 ;
 S IBINS=+$G(^TMP($J,"IBCNBOEC",IBS1,IBS2,"I")),IBGRP=+$G(^TMP($J,"IBCNBOEC",IBS1,IBS2,"G"))
 S IBPOL=+$G(^TMP($J,"IBCNBOEC",IBS1,IBS2,"P")),IBCNT=+$G(^TMP($J,"IBCNBOEC",IBS1,IBS2,"CNT"))
 S (IBIP,IBGP,IBPP)=0 I IBCNT'=0 S IBIP=((IBINS/IBCNT)*100)\1,IBGP=((IBGRP/IBCNT)*100)\1,IBPP=((IBPOL/IBCNT)*100)\1
 Q
 ;
EOR(IBLE) ; write end of report
 I '$G(IBLE) S IBLE=80
 I IBLN>MAXCNT D HDR Q:IBQUIT
 W ! W:$G(IBOUT)="R" ?((IBLE\2)-10) W "*** END OF REPORT ***"
 Q
 ;
 ; IB*702/DTG end Combine parts for excel and report
 ;
PRTLN ; IB*702 Rewrote tag to print zeros for statuses with no counts
 N IBSTX,IBCNT,IBTM,IBHG,IBLS,IBTCNT
 ;
 N IBBA,IBBB,IBBC
 ;
 S IBSTX=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3))
 ;S IBCNT=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"CNT")) Q:'IBCNT  ;IB*702 removed quit
 S IBCNT=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"CNT"))
 S IBTM=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"TM"))
 S IBHG=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"HG"))
 S IBLS=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"LS"))
 ;S IBTCNT=$G(^TMP($J,IBXREF,IBS1,IBS2,9,"CNT")) Q:'IBTCNT  ;IB*702 removed quit
 S IBTCNT=$G(^TMP($J,IBXREF,IBS1,IBS2,9,"CNT"))
 ;
 ; Excel output
 I IBOUT="E" D  Q
 . W !,IBEMPN_U_IBLABLE_U_IBSTX_U_$FN(IBCNT,",")_U
 . S IBBA=$S((IBCNT'=""&(IBTCNT'="")):((IBCNT/IBTCNT)*100),1:0),IBBC=$$EXN^IBCNBOF(IBBA) W IBBC_"%"_U
 . S IBBA=$S(IBCNT'="":$$STD((IBTM/IBCNT)),1:0),IBBC=$$EXN^IBCNBOF(IBBA) W IBBC_U
 . S IBBA=$$STD(IBHG),IBBC=$$EXN^IBCNBOF(IBBA) W IBBC_U
 . S IBBA=$$STD(IBLS),IBBC=$$EXN^IBCNBOF(IBBA) W IBBC
 ;
 ; Report output
 W !,IBSTX,?20,$J($FN(IBCNT,","),7)
 S IBBA=$S((IBCNT'=""&(IBTCNT'="")):((IBCNT/IBTCNT)*100),1:0) W ?30,$J(IBBA,6,1),"%"
 S IBBA=$S(IBCNT'="":$$STD((IBTM/IBCNT)),1:0) W ?43,$J(IBBA,6,1)
 W ?56,$J($$STD(IBHG),6,1),?68,$J($$STD(IBLS),6,1)
 Q
 ;
STD(SEC) ; convert seconds to days
 N IBX,IBD,IBS,IBH,DAYS S DAYS="" G:'$G(SEC) STDQ
 S IBD=(SEC/86400),IBD=+$P(IBD,".")
 S IBS=SEC-(IBD*86400)
 S IBH=((IBS/60)/60),IBH=+$J(IBH,0,2)
 S DAYS=IBD+(IBH/24)
STDQ Q DAYS
 ;
HDR ;print the report header
 S IBQUIT=$$STOP Q:IBQUIT
 I IBPGN>0 S IBQUIT=$$PAUSE Q:IBQUIT
 S IBPGN=IBPGN+1,IBLN=5 I IBPGN>1!($E(IOST,1,2)["C-") W @IOF
 ; IB*702/DTG start change INSURANCE to INS
 ;W !,"INSURANCE BUFFER EMPLOYEE REPORT   ",IBRANGE," "
 W !,"INS BUFFER EMPLOYEE REPORT  ",IBRANGE," "
 ;W ?(IOM-22),IBRDT,?(IOM-7)," PAGE ",IBPGN,!
 W ?(IOM-23),IBRDT,?(IOM-8),"PAGE ",IBPGN,!
 I +$G(IBEMPL) W !,"EMPLOYEE:  ",$P($G(^VA(200,+IBEMPL,0)),U,1),!
 S IBI="",$P(IBI,"-",IOM+1)="" W IBI,!
 Q
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 N X
 ; IB*602/HN ; Add report headers to Excel Spreadsheets
 ;W !,"INSURANCE BUFFER EMPLOYEE REPORT^"_IBRANGE_"^"_$$FMTE^XLFDT($$NOW^XLFDT,1),!
 W !,"INS BUFFER EMPLOYEE REPORT^"_IBRANGE_"^"_$$FMTE^XLFDT($$NOW^XLFDT,1),!
 I +$G(IBEMPL) W "EMPLOYEE:  ",$P($G(^VA(200,+IBEMPL,0)),U,1),!
 ; IB*602/HN end  
 S X="EMPLOYEE^MONTH^STATUS^COUNT^PERCENT^AVERAGE # DAYS^LONGEST # DAYS^SHORTEST # DAYS^New Companies^"
 S X=X_"% New Companies^New Group/Plans^% New Group/Plans^New Patient Policies^% New Patient Policies"
 W X
 K X
 Q
 ; IB*702/DTG end change INSURANCE to INS
 ;
PAUSE() ;pause at end of screen if beeing displayed on a terminal
 N IBX,DIR,DIRUT,X,Y S IBX=0
 I $E(IOST,1,2)["C-" W !! S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DIRUT)) S IBX=1
 Q IBX
 ;
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
 ;
WR() ; which report
 ; IB*702/DTG start remove verified from report
 N DIR,X,Y,DIRUT,DUOUT,IBX S IBX=""
 ;S DIR("?")="Enter 'V' for a report based on employees that verify or process (accept/reject) buffer entries."
 S DIR("?")="Enter 'P' for a report based on employees that process (accept/reject) buffer entries."
 S DIR("?",5)="Enter 'E' for a report based on employees that create new buffer entries."
 S DIR("?",1)="This report may be printed for those employees that create Buffer entries,"
 ;S DIR("?",2)="primarily non-Insurance personnel or for those employees that verify and process"
 S DIR("?",2)="primarily non-Insurance personnel or for those employees that process"
 S DIR("?",3)="(accept/reject) Buffer entries, primarily Insurance Personnel."
 S DIR("?",4)=" "
 ;S DIR("A")="Include which Type of Employee",DIR(0)="SO^1:Entered By;2:Verified/Processed By" D ^DIR
 S DIR("A")="Include which Type of Employee",DIR(0)="SO^1:Entered By;2:Processed By"
 D ^DIR
 S IBX=$S(Y>0:+Y,1:"")
 Q IBX
 ; IB*702/DTG end remove verified from report
 ;
EMPL() ; print a single or all employees?
 N DIR,X,Y,DIRUT,DUOUT,IBX S IBX=""
 S DIR("?",1)="Report of activity in the Buffer file by Employee and date range."
 S DIR("?",2)="Enter 'S' to include only a single employee in the report."
 S DIR("?")="Enter 'A' to include all employees in the report."
 S DIR("A")="Include Selected or All Employees"
 S DIR("B")="All",DIR(0)="SO^A:All Employees;S:Selected Employee" D ^DIR
 S IBX=$S(Y="S":1,Y="A":0,1:"")
 Q IBX
 ;
SELEMPL(TYPE) ; get the name of an employee
 N DIC,X,Y,DTOUT,DUOUT,IBX S IBX=""
 S DIC("A")="Select an Employee that "_TYPE_" Buffer entries: "
 S DIC="^VA(200,",DIC(0)="AEMQ" D ^DIC S IBX=+Y I $D(DTOUT)!$D(DUOUT)!(Y<1) S IBX=""
 Q IBX
 ;
DATES(LABLE,IBBEG) ;
 N DIR,DIRUT,DTOUT,DUOUT,IBX,IBB,IBD,IBE,X,Y
 ; IB*702/DTG start update date prompt & "?" text
 S IBBEG=$G(IBBEG)
 S IBX="",IBB=$P($S(+$G(IBBEG):IBBEG,1:+$O(^IBA(355.33,"B",0))),"."),IBD=$S(+$G(IBBEG):DT,1:IBB)
 I IBBEG'="" S IBE="Beginning Date ("_$$FMTE^XLFDT(IBBEG)_")"
 I IBBEG="" W !! S IBE="date of the first Buffer entry ("_$$FMTE^XLFDT(IBB)_")"
DATES1 ;Repeat for ending date outside of range
 S DIR("?")="Enter the "_LABLE_" date to include in the report."
 S DIR("?",1)="Enter a date from the "_IBE_" to today."
 S DIR("A")=LABLE_" Date"
 S DIR(0)="DO^::EX" D ^DIR
 S IBX=Y
 I Y="" W *7,!,"Enter the "_LABLE_" Date or '^' to Quit.",! G DATES1
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT) S IBX=""
 I 'IBX G DATESX
 I (IBX<IBB) W *7,!,"Date cannot be less than the "_IBE_".",! G DATES1
 I (IBX>DT) W *7,!,"Date cannot be greater than Today.",! G DATES1
 ;
DATESX ;Exit Dates setup
 Q IBX
 ;
MONTH() ;
 N DIR,X,Y,DIRUT,DUOUT,IBX S IBX=""
 ; IB*702/DTG start update month prompt & "?" text
 S DIR("?")="include the current month. Enter '^' to quit"
 S DIR("?",1)="Answer YES if you'd like to see totals for previous months."
 S DIR("?",2)="Answer NO if you'd like to see data on a selected date range which may"
 S DIR("A")="Report Previous Completed Month(s)",DIR(0)="Y",DIR("B")="No" D ^DIR
 ; IB*702/DTG end update month prompt & "?" text
 S IBX=$S(Y=1:Y,Y=0:Y,1:"")
 Q IBX
 ;
OUT() ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) Q ""
 Q Y
