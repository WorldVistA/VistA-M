IBCNBOE ;ALB/ARH-Ins Buffer: Employee Report ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82**;21-MAR-94
 ;
EN ;get parameters then run the report
 N IBX S IBX=$$WR Q:'IBX  I IBX=1 G ^IBCNBOF ; WHICH REPORT?  entered or processed
 ;
 ;
 K ^TMP($J) D HOME^%ZIS S IBHDR="INSURANCE BUFFER INSURANCE EMPLOYEE REPORT" W @IOF,!!,?17,IBHDR
 W !!,"This report produces counts and time statistics for Insurance Employees that",!,"have either Verified or Processed (Accept/Reject) an Insurance Buffer entry.",!!
 ;
 S IBEMPL=$$EMPL G:IBEMPL="" EXIT  W !!
 ;
 I +IBEMPL S IBEMPL=$$SELEMPL("Verifies or Processes") G:IBEMPL="" EXIT  W !!
 ;
 S IBBEG=$$DATES("Beginning") G:'IBBEG EXIT
 S IBEND=$$DATES("Ending",IBBEG) G:'IBEND EXIT  W !!
 ;
 S IBMONTH=$$MONTH G:IBMONTH="" EXIT  W !!
 ;
DEV ;get the device
 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="RPT^IBCNBOE",ZTDESC=IBHDR,ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q") G EXIT
 U IO
 ;
RPT ; run report
 S IBQUIT=0
 ;
 D SEARCH(IBBEG,IBEND,IBMONTH,IBEMPL) G:IBQUIT EXIT
 D PRINT(IBBEG,IBEND,IBEMPL)
 ;
EXIT K ^TMP($J),IBHDR,IBBEG,IBEND,IBMONTH,IBQUIT,IBEMPL
 Q:$D(ZTQUEUED)
 D ^%ZISC
 Q
 ;
SEARCH(IBBEG,IBEND,IBMONTH,IBEMPL) ; search/sort statistics for activity report
 N IBXST,IBXDT,IBBUFDA,IBB0,IBDATE,IBEMP,IBTIME,IBSTAT,IBDT2,IBVER,IBS3 S IBQUIT=""
 S IBBEG=$G(IBBEG)-.01,IBEND=$S('$G(IBEND):9999999,1:$P(IBEND,".")+.9)
 ;
 F IBXST="A","R","V"  D  Q:IBQUIT
 . S IBXDT=IBBEG F  S IBXDT=$O(^IBA(355.33,"AFST",IBXST,IBXDT)) Q:'IBXDT!(IBXDT>IBEND)  D  S IBQUIT=$$STOP Q:IBQUIT
 .. S IBBUFDA=0 F  S IBBUFDA=$O(^IBA(355.33,"AFST",IBXST,IBXDT,IBBUFDA)) Q:'IBBUFDA  D
 ... ;
 ... S IBB0=$G(^IBA(355.33,IBBUFDA,0))
 ... ;
 ... ; verified
 ... I IBXST="V" S IBDATE=+$P(IBB0,U,10) I +IBDATE,IBDATE>IBBEG,IBDATE<IBEND D
 .... S IBEMP=+$P(IBB0,U,11) I +IBEMPL,IBEMPL'=IBEMP Q
 .... S IBTIME=$$FMDIFF^XLFDT(IBDATE,+IBB0,2),IBSTAT="VERIFIED",IBS3=1
 .... D SET(IBSTAT,IBEMP,$E(IBDATE,1,5),IBS3,IBTIME,IBB0,$G(IBMONTH))
 ... ;
 ... ; processed
 ... I IBXST="A"!(IBXST="R") S IBDATE=+$P(IBB0,U,5) I +IBDATE,IBDATE>IBBEG,IBDATE<IBEND D
 .... S IBEMP=+$P(IBB0,U,6) I +IBEMPL,IBEMPL'=IBEMP Q
 .... S IBVER=$P(IBB0,U,10),IBSTAT="UNKNOWN",IBS3=6
 .... S IBDT2=$S(+IBVER:+IBVER,1:+IBB0),IBTIME=$$FMDIFF^XLFDT(IBDATE,+IBDT2,2)
 .... ;
 .... I $P(IBB0,U,4)="A" S IBS3=2,IBSTAT="ACCEPTED" I 'IBVER S IBS3=3,IBSTAT=IBSTAT_" (&V)"
 .... I $P(IBB0,U,4)="R" S IBS3=4,IBSTAT="REJECTED" I +IBVER S IBS3=5,IBSTAT=IBSTAT_" (V)"
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
 Q
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
PRINT(IBBEG,IBEND,IBEMPL) ;
 N IBXREF,IBLABLE,IBS1,IBS2,IBS3,IBINS,IBGRP,IBPOL,IBCNT,IBIP,IBGP,IBPP,IBRDT,IBPGN,IBRANGE,IBLN,IBI
 ;
 S IBRANGE=$$FMTE^XLFDT(IBBEG)_" - "_$$FMTE^XLFDT(IBEND)
 S IBRDT=$$FMTE^XLFDT($J($$NOW^XLFDT,0,4),2),IBRDT=$TR(IBRDT,"@"," "),IBPGN=0
 D HDR
 ;
 S IBXREF="IBCNBOE",IBS1="" F  S IBS1=$O(^TMP($J,IBXREF,IBS1)) Q:IBS1=""  D
 . ;
 . S IBS2=0 F  S IBS2=$O(^TMP($J,IBXREF,IBS1,IBS2)) Q:IBS2=""  D:IBLN>(IOSL-15) HDR Q:IBQUIT  D  S IBLN=IBLN+8
 .. S IBLABLE=$S(IBS2=99999:"TOTALS",($E(IBBEG,1,5)<IBS2)&($E(IBEND,1,5)>IBS2):$$FMTE^XLFDT(IBS2_"00"),1:"")
 .. I IBLABLE="" S IBLABLE=$$FMTE^XLFDT($S($E(IBBEG,1,5)<IBS2:IBS2_1,1:IBBEG))_" - "_$$FMTE^XLFDT($S($E(IBEND,1,5)>IBS2:$$SCH^XLFDT("1M(L)",IBS2_11),1:IBEND))
 .. S IBLABLE=$P($G(^VA(200,IBS1,0)),U,1)_"  "_IBLABLE
 .. W !,?(40-($L(IBLABLE)/2)),IBLABLE,!
 .. W !,?43,"AVERAGE",?56,"LONGEST",?68,"SHORTEST"
 .. W !,"STATUS",?22,"COUNT",?30,"PERCENT",?43,"# DAYS",?56,"# DAYS",?68,"# DAYS"
 .. W !,"-----------------------------------------------------------------------------"
 .. ;
 .. S IBS3="" F  S IBS3=$O(^TMP($J,IBXREF,IBS1,IBS2,IBS3)) Q:'IBS3  D PRTLN  S IBLN=IBLN+1
 .. ;
 .. S IBINS=+$G(^TMP($J,"IBCNBOEC",IBS1,IBS2,"I")),IBGRP=+$G(^TMP($J,"IBCNBOEC",IBS1,IBS2,"G"))
 .. S IBPOL=+$G(^TMP($J,"IBCNBOEC",IBS1,IBS2,"P")),IBCNT=+$G(^TMP($J,"IBCNBOEC",IBS1,IBS2,"CNT"))
 .. S (IBIP,IBGP,IBPP)=0 I IBCNT'=0 S IBIP=((IBINS/IBCNT)*100)\1,IBGP=((IBGRP/IBCNT)*100)\1,IBPP=((IBPOL/IBCNT)*100)\1
 .. W !!,?2,IBINS," New Compan",$S(IBINS=1:"y",1:"ies")," (",IBIP,"%), "
 .. W IBGRP," New Group/Plan",$S(IBGRP=1:"",1:"s")," (",IBGP,"%), "
 .. W IBPOL," New Patient Polic",$S(IBPOL=1:"y",1:"ies")," (",IBPP,"%)",!
 ;
 S IBI=$$PAUSE
 Q
 ;
PRTLN ;
 N IBSTX,IBCNT,IBTM,IBHG,IBLS,IBTCNT
 ;
 S IBSTX=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3))
 S IBCNT=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"CNT")) Q:'IBCNT
 S IBTM=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"TM"))
 S IBHG=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"HG"))
 S IBLS=$G(^TMP($J,IBXREF,IBS1,IBS2,IBS3,"LS"))
 S IBTCNT=$G(^TMP($J,IBXREF,IBS1,IBS2,9,"CNT")) Q:'IBTCNT
 ;
 W !,IBSTX,?20,$J($FN(IBCNT,","),7),?30,$J(((IBCNT/IBTCNT)*100),6,1),"%",?43,$J($$STD((IBTM/IBCNT)),6,1),?56,$J($$STD(IBHG),6,1),?68,$J($$STD(IBLS),6,1)
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
 W !,"INSURANCE BUFFER EMPLOYEE REPORT   ",IBRANGE," "
 W ?(IOM-22),IBRDT,?(IOM-7)," PAGE ",IBPGN,!
 I +$G(IBEMPL) W !,"EMPLOYEE:  ",$P($G(^VA(200,+IBEMPL,0)),U,1),!
 S IBI="",$P(IBI,"-",IOM+1)="" W IBI,!
 Q
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
 N DIR,X,Y,DIRUT,DUOUT,IBX S IBX=""
 S DIR("?")="Enter 'V' for a report based on employees that verify or process (accept/reject) buffer entries."
 S DIR("?",5)="Enter 'E' for a report based on employees that create new buffer entries."
 S DIR("?",1)="This report may be printed for those employees that create Buffer entries,"
 S DIR("?",2)="primarily non-Insurance personnel or for those employees that verify and process",DIR("?",3)="(accept/reject) Buffer entries, primarily Insurance Personnel.",DIR("?",4)=" "
 S DIR("A")="Include which Type of Employee",DIR(0)="SO^1:Entered By;2:Verified/Processed By" D ^DIR
 S IBX=$S(Y>0:+Y,1:"")
 Q IBX
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
 N DIR,X,Y,DIRUT,DUOUT,IBX,IBB,IBD S IBX="",IBB=$P($S(+$G(IBBEG):IBBEG,1:+$O(^IBA(355.33,"B",0))),"."),IBD=$S(+$G(IBBEG):DT,1:IBB)
 S DIR("?")="Enter the "_LABLE_" date to include in the report."
 S DIR("?",1)="Enter a date from the date of the first Buffer entry to today."
 S DIR("A")=LABLE_" Date",DIR("B")=$$FMTE^XLFDT(IBD)
 S DIR(0)="DO^"_IBB_":"_DT_":EX" D ^DIR S IBX=Y I $D(DIRUT)!$D(DUOUT) S IBX=""
 Q IBX
 ;
MONTH() ;
 N DIR,X,Y,DIRUT,DUOUT,IBX S IBX=""
 S DIR("?")="Enter No if only totals for the date range should be reported."
 S DIR("?",1)="Enter Yes if the report should be broken down by month."
 S DIR("A")="Report By Month",DIR(0)="Y",DIR("B")="No" D ^DIR
 S IBX=$S(Y=1:Y,Y=0:Y,1:"")
 Q IBX
