IBDFOSG ;ALB/MAF/AAS - SCANNED EF FOR OUTPATIENTS WITH BILLS GENERATED REPORT ;8/21/95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**29,51**;APR 24, 1997
 ;
 W !,?4,"** This option is OUT OF ORDER **" QUIT   ;Code set Versioning
 ;
% I '$D(DT) D DT^DICRW
 D END
 W !!,"Scanned Encounter Forms with Outpatient Bills Generated."
 S IBDFMUL=0 I $D(^DG(43,1,"GL")) S:$P(^DG(43,1,"GL"),"^",2)=1 IBDFMUL=1 D DIVISION^VAUTOMA G:Y=-1 END
 S VAUTC=1
 S IBDFDAT=$$HTE^XLFDT($H)
 ;
DATE ; -- select date
 W !! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 S IBDFBEG=IBBDT,IBDFEND=IBEDT
 ;
DEV ; -- select device, run option
 W !!,"You will need a 132 column printer for this report!",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) K ZTSK S ZTRTN="DQ^IBDFOSG",ZTSAVE("IB*")="",ZTSAVE("VA*")="",ZTDESC="IBD - Scanned Encounter Forms with Bill Generation" D ^%ZTLOAD K IO("Q") W !,$S($D(ZTSK):"Request Queued Task="_ZTSK,1:"Request Canceled") D HOME^%ZIS G END
 ;
 U IO
 S X=132 X ^%ZOSF("RM")
DQ D PRINT G END
 Q
 ;
END ; -- Clean up
 K ^TMP("CTOT",$J),^TMP("DTOT",$J),^TMP("GTOT",$J),^TMP("MCCR",$J),^TMP("IBD-BILL",$J),^TMP("IBD-PRINTED",$J),^TMP("IBD-ENTERED",$J) W !
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K X,Y,DFN,IBPAG,IBHDT,IBDT,IBBDT,IBEDT,IBQUIT,IBDFDVE
 K IBCNT,IBDFBEG,IBDFCLI,IBDFDA,IBDFDAT,IBDFDIV,IBDFEND,IBDFIFN,IBDFMUL,IBDFNODE,IBDFNUM,IBDFSA,IBDFT,IBDFTMP,IBDFTMP1,IBDFTMP2,IBDFTPRT
 K IBFLG1,IBFLG2,IBFLG3,IBFLG4,IBFLG5,IBFLG6,IBFLG7,IBFLG8,IBFLG9,IBMCNODE,IBMCSND,IBNAM,IBTSBDT,IBTSEDT
 K VAUTC,VAUTD
 Q
 ;
PRINT ; -- print one billing report
 ;    Data sorted into ^tmp arrays
 ;                    := ^tmp("mccr",$j) =
 ;    Clinic Totals   := ^tmp("ctot",$j,division,clinic)=
 ;    Division Totals := ^tmp("dtot",$j,division)       =
 ;    Grand Totals    := ^tmp("gtot",$j)                =
 ;
 S (IBPAG,IBDFDVE)=0,IBHDT=$$HTE^XLFDT($H,1),IBQUIT=0
 S IBTSBDT=IBBDT-.1,IBTSEDT=IBEDT+.9
 D QUIT
 D START^IBDFOSG1
 ;
PR D HDR
 I '$D(^TMP("MCCR",$J)) W !!,"No Data Meeting This Criteria for the Date Range Chosen",! Q
 N IBDFDV,IBDFCL,IBDNODE,IBDFTMP,IBDFPAT,IBDFPT,IBDFT
 S (IBDFDV,IBDFCL,IBDFPT)=0
 F IBDFDIV=0:0 S IBDFDV=$O(^TMP("CTOT",$J,IBDFDV)) Q:IBDFDV=""!(IBQUIT)  D
 .D DIVH
 .S IBDFCL=0
 .F IBDFCLI=0:0 S IBDFCL=$O(^TMP("CTOT",$J,IBDFDV,IBDFCL)) Q:IBDFCL=""  D ONECL I $O(^TMP("CTOT",$J,IBDFDV,IBDFCL))="" S IBDFDVE=1 D ONEDV
 ;
 ;  -- Print Totals Page
 S IBDFDVE=0
 Q:IBQUIT
 D HDR
 S (IBDFDV,IBDFCL,IBDFPT)=0
 S IBFLG4=1 ;1 := on division totals page
 F IBDFDIV=0:0 S IBDFDV=$O(^TMP("DTOT",$J,IBDFDV)) Q:IBDFDV']""!(IBQUIT)  D ONEDV
 Q:IBQUIT
 D DASH
 D LINE("GRAND TOTAL",^TMP("GTOT",$J))
 Q
 ;
ONECL ; -- Print one clinics data
 Q:IBQUIT
 Q:^TMP("CTOT",$J,IBDFDV,IBDFCL)="0^0^0^0^0^0^0^0^0"
 D LINE(IBDFCL,^TMP("CTOT",$J,IBDFDV,IBDFCL))
 Q
 ;
ONEDV ;  -- Print Division totals
 Q:IBQUIT
 I IOSL<($Y+5) D HDR Q:IBQUIT
 Q:^TMP("DTOT",$J,IBDFDV)="0^0^0^0^0^0^0^0^0"&('$D(IBFLG4))
 I IBDFDVE=1 D DASH S IBDFDVE=0
 D LINE(IBDFDV,^TMP("DTOT",$J,IBDFDV))
 Q
 ;
LINE(NAME,IBX) ;
 ; -- print detail line
 ;    input Name := text to be printed
 ;          ibx  ;= 9 piece global node containing data
 ;
 I IOSL<($Y+5) D HDR Q:IBQUIT
 W !,$E(NAME,1,25)
 W ?27,$J($P(IBX,"^",4),8)
 W ?39,$J($P(IBX,"^",3),8)
 W ?51,$J($P(IBX,"^",1),8)
 W ?63,$J($P(IBX,"^",2),8)
 S X=$S($P(IBX,"^",4)>0:$P(IBX,"^",5)/$P(IBX,"^",4),1:0)
 W ?75,$J(X,8,2) ;$J($E(X,1,8),8)
 W ?87,$J($P(IBX,"^",6),8)
 W ?99,$J($P(IBX,"^",7),8)
 W ?111,$J($P(IBX,"^",8),8)
 W ?123,$J($P(IBX,"^",9),8)
 Q
 ;
HDR ; -- Print header for billing report
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"Scanned Encounters with Bill Generation Data",?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !,"For Period beginning on ",$$FMTE^XLFDT(IBBDT,2)," to ",$$FMTE^XLFDT(IBEDT,2)
 W !,?53,"Visits",?65,"#Bills",?75,"Avg. Days",?114,"Total",?126,"Total"
 W !,"Clinic",?27,"#Scanned",?39,"#Insured",?53,"Billed",?64,"Printed",?75,"to Print",?87,"$ Billed",?100,"$ Recvd",?114,"Bills",?125,"Visits"
 W !,$TR($J(" ",IOM)," ","-")
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,IBQUIT=1 W !!,"....task stopped at user request" Q
 Q
 ;
 ;
QUIT K ^TMP("CTOT",$J),^TMP("DTOT",$J),^TMP("GTOT",$J),^TMP("MCCR",$J),^TMP("IBD-BILL",$J) W !
 Q
 ;
 ;
DASH W !,"------------------",?27,"--------",?39,"--------",?51,"--------",?63,"--------",?75,"--------",?87,"--------",?99,"--------",?111,"--------",?123,"--------"
 Q
 ;
DIVH ;  -- Write division header
 I IOSL<($Y+5) D HDR Q:IBQUIT
 Q:^TMP("DTOT",$J,IBDFDV)="0^0^0^0^0^0^0^0^0"
 W !!,?(IOM-$L(IBDFDV)+10/2),"DIVISION: ",IBDFDV,!
 Q
