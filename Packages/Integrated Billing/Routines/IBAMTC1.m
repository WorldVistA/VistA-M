IBAMTC1 ;ALB/CPM - MEANS TEST NIGHTLY COMPILATION REPORT ; 14-NOV-91
 ;;2.0;INTEGRATED BILLING;**153**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 I '$D(IOF)!('$D(IOM))!('$D(IOSL)) Q
 ;
 ; Initialize control variables.
 S %H=+$H-1 D YMD^%DTC S Y=X D DD^%DT S IBYEST=Y
 D NOW^%DTC S Y=% D DD^%DT S IBNOW=Y
 S IBPAG=0,IBLINE="",$P(IBLINE,"-",IOM)=""
 ; - print all reports.
 D ERROR,INPT
 ; - kill variables and quit.
 K ^TMP($J,"IBAMTC"),IBCHK,IBI,IBID,IBRPT,IBNOW,IBYEST,IBPAG,IBLINE Q
 ;
 ;
ERROR ; Print the Error Report.
 S IBRPT="Error Report" D HDR
 I '$D(^TMP($J,"IBAMTC","E")) W !!,"No errors encountered during this compilation." Q
 ;
 S IBI="" F  S IBI=$O(^TMP($J,"IBAMTC","E",IBI)) Q:'IBI  S IBID=^(IBI) D
 . I $Y>(IOSL-5) D HDR
 . S IBDA=$O(^IBE(350.8,"AC",$S($P(IBID,"^")]"":$P(IBID,"^"),1:0),0))
 . W !!,"Error: ",$S($D(^IBE(350.8,+IBDA,0)):$P(^(0),"^",2),$P(IBID,"^")]"":$P(IBID,"^"),1:"Unknown Error")
 . W !,"Patient: ",$S($D(^DPT(+$P(IBID,"^",2),0)):$P(^(0),"^"),1:"No patient involved")
 . I $P(IBID,"^",3) W !,$P($T(TEXT+$P(IBID,"^",3)^IBAMTEL),";;",2,99)
 Q
 ;
INPT ; Print the Inpatient Report.
 S IBRPT="Inpatient Billing Report" D HDR
 I '$D(^TMP($J,"IBAMTC","I")) W !!,"No Inpatient charges billed or updated during this compilation." Q
 ;
 S (DFN,IBI)="" F  S DFN=$O(^TMP($J,"IBAMTC","I",DFN)) Q:'DFN  D
 . S IBCHK=1 F  S IBI=$O(^TMP($J,"IBAMTC","I",DFN,IBI)) Q:'IBI  D
 ..  I $Y>(IOSL-2) D HDR
 ..  S IBID=$G(^IB(+IBI,0)) W !
 ..  I IBCHK W $E($P($G(^DPT(+$P(IBID,"^",2),0)),"^"),1,24),?27,$E($P($G(^DPT(+$P(IBID,"^",2),0)),"^",9),6,9) S IBCHK=0
 ..  W ?35,$S($D(^IBE(350.1,+$P(IBID,"^",3),0)):$P($P(^(0),"^")," ",2,99),1:"Unknown")
 ..  W ?66,$$DAT1^IBOUTL($P(IBID,"^",14)),?80,$$DAT1^IBOUTL($P(IBID,"^",15))
 ..  W ?92,$J($P(IBID,"^",6),3)
 ..  W ?100,$S($P(IBID,"^",5)=10:$J("($"_$P(IBID,"^",7)_")",10),1:$J("$"_$P(IBID,"^",7),8))
 ..  W ?114,$P("INCOMPLETE^PENDING AR^BILLED^UPDATED^^^^ON HOLD^ERROR ENCOUNTERED^CANCELLED","^",$P(IBID,"^",5))
 Q
 ;
HDR S IBPAG=IBPAG+1
 W @IOF,"Means Test Charge Compilation through ",IBYEST,?(IOM-31),IBNOW,"   Page: ",IBPAG
 W !,IBRPT
 I $E(IBRPT)="E" W !,IBLINE Q
 W !,"PATIENT",?28,"SSN",?35,"CHARGE DESCRIPTION",?66,"BILL FROM     BILL TO     UNITS    TOT CHG      STATUS",!,IBLINE,!
 Q
 ;
 ;
BULL ; Send the Nightly Compilation Job Completion bulletin.
 S XMSUB="MEANS TEST NIGHTLY COMPILATION JOB COMPLETION"
 S %H=+$H-1 D YMD^%DTC S Y=X D DD^%DT S IBYEST=Y
 K IBT S IBDUZ=DUZ
 S IBT(1)="The Means Test Nightly Compilation Job has compiled charges for patients"
 S IBT(2)="through "_IBYEST_"."
 S IBT(3)=" "
 D NOW^%DTC S IBDATE=%,IBT(4)="The job was completed on "_$P($$DAT2^IBOUTL(IBDATE),"@")_" at "_$P($$DAT2^IBOUTL(IBDATE),"@",2)_"."
 S IBT(5)=" "
 S IBT(6)="There "_$S(IBCNT=1:"was ",1:"were ")_$S(IBCNT:IBCNT,1:"no")_" error"_$S(IBCNT=1:"",1:"s")_" encountered."
 I IBCNT S IBT(7)="(Separate bulletin"_$E("s",IBCNT>1)_$S(IBCNT=1:" has",1:" have")_" been sent.)"
 D MAIL^IBAERR1 ; find recipients and send bulletin
 K IBDATE,IBDUZ,IBT,IBYEST,XMDUZ,XMSUB,XMTEXT,XMY
 Q
