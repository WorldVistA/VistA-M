IBATOP ;ALB/CPM-TRANSFER PRICING PATIENT LISTING ;21-MAR-99
 ;;2.0;INTEGRATED BILLING;**115,153,183,249**;21-MAR-94
 ;
EN ; Option entry point.
 ;
 W !!,"This report creates a listing of all Transfer Pricing patients for"
 W !,"specific networks or facilities.  Please enter all applicable networks"
 W !,"and facilities, specifying networks by VISN (i.e., 'VISN 1').",!
 ;
 ; - allow entry of network/facilities; quit if none entered
 Q:$$FAC^IBATUTL
 ;
 ; - set flag to determine if all facilities were entered
 S IBALL='$D(IBFAC)
 ;
 W !!,"This report requires only an 80 column printer.",!
 ;
 ; - select a device
 S %ZIS="QM" D ^%ZIS I POP G ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBATOP",ZTDESC="IB - TRANSFER PRICING PATIENT LISTING"
 .S ZTSAVE("IBALL")="" I $D(IBFAC) S ZTSAVE("IBFAC(")=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; Tasked entry point.
 ;
 K ^TMP("IBATOP",$J),IBARR,IBFACN,^TMP($J,"SDAMA301"),^TMP("IBDFN",$J)
 N IBARRAY,IBCOUNT,IBNDT
 ;
 ; - process the entire file if all patients were selected
 I IBALL D  G PRINT
 .S DFN=0 F  S DFN=$O(^IBAT(351.6,DFN)) Q:'DFN  S IBD=$G(^(DFN,0)) D
 ..;
 ..; - get the enrolled facility and find the associated network
 ..S IBSTN=+$$PPF^IBATUTL(DFN)
 ..;S IBSTN=+$P(IBD,"^",3)
 ..I '$D(IBARR(IBSTN)) D
 ...N X,Y
 ...S X=$$VISN^IBATUTL(IBSTN),Y=$$INST^IBATUTL(IBSTN)
 ...S:$P(Y,"^",2)="" $P(Y,"^",2)="<No Sta. #>"
 ...S IBARR(IBSTN)=+$P($P(X,"^",2)," ",2)_"^"_Y
 ...S IBFACN(IBSTN)=Y
 ..;
 ..; - set patient information
 ..D SET(+IBARR(IBSTN),IBSTN,DFN)
 ;
 ; - process patients from selected networks/facilities
 S IBX="" F  S IBX=$O(IBFAC(IBX)) Q:IBX=""  D
 .S IBSTN="" F  S IBSTN=$O(IBFAC(IBX,"C",IBSTN)) Q:IBSTN=""  D
 ..;
 ..; - get facility/network information
 ..S IBNET=+$P($P($$VISN^IBATUTL(IBSTN),"^",2)," ",2)
 ..S IBY=$$INST^IBATUTL(IBSTN)
 ..S:$P(IBY,"^",2)="" $P(IBY,"^",2)="<No Sta. #>"
 ..S IBFACN(IBSTN)=IBY
 ..;
 ..; - find all patients from the specific facility
 ..S DFN=0 F  S DFN=$O(^IBAT(351.6,"AD",IBSTN,DFN)) Q:'DFN  D
 ...D SET(IBNET,IBSTN,DFN)
 ;
PRINT ;
 ; now call scheduling to look up future appts
 S IBARRAY(1)=$$NOW^XLFDT_";9999999"
 S IBARRAY(3)="R;I;NT"
 S IBARRAY(4)="^TMP(""IBDFN"",$J,"
 S IBARRAY("SORT")="P"
 S IBARRAY("FLDS")=1
 S IBCOUNT=$$SDAPI^SDAMA301(.IBARRAY)
 ;
 ; Print the report.
 ;
 S (IBPAG,IBQ)=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 ;
 I '$D(^TMP("IBATOP",$J)) D HDR(0) W !!!,"There are no Transfer Pricing patients for the selected networks/facilities."  G ENQ
 ;
 S IBNET="" F  S IBNET=$O(^TMP("IBATOP",$J,IBNET)) Q:IBNET=""!(IBQ)  D
 .D PAUSE:IBPAG,HDR(IBNET)
 .S IBSTN="" F  S IBSTN=$O(^TMP("IBATOP",$J,IBNET,IBSTN)) Q:IBSTN=""!(IBQ)  D
 ..;
 ..I $Y>(IOSL-4) D PAUSE Q:IBQ  D HDR(IBNET)
 ..D DISFAC(IBSTN)
 ..;
 ..S IBNAM="" F  S IBNAM=$O(^TMP("IBATOP",$J,IBNET,IBSTN,IBNAM)) Q:IBNAM=""!(IBQ)  S IBXX=$G(^(IBNAM)) D
 ...;
 ...I $Y>(IOSL-2) D PAUSE Q:IBQ  D HDR(IBNET),DISFAC(IBSTN)
 ...;
 ...W !,$E($P(IBNAM,"@@"),1,20)," (",$P(IBXX,"^"),")"
 ...W ?28,$E($P(IBXX,"^",2),1,19),?49,$P(IBXX,"^",3),?55,$P(IBXX,"^",4)
 ...W ?61,$S($P(IBXX,"^",5):$$DAT1^IBOUTL($P(IBXX,"^",5)),1:"")
 ...S IBNDT=$O(^TMP($J,"SDAMA301",$P(IBNAM,"@@",2),0))
 ...I IBNDT S $P(IBXX,"^",6)=$S('$P(IBXX,"^",6):IBNDT,IBNDT<$P(IBXX,"^",6):IBNDT,1:$P(IBXX,"^",6))
 ...W ?71,$S($P(IBXX,"^",6):$$DAT1^IBOUTL($P(IBXX,"^",6)),1:"")
 ;
 I 'IBQ D PAUSE
 ;
ENQ K ^TMP("IBATOP",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IBPAG,IBD,IBQ,IBRUN,IBNET,IBSTN,IBNAM,IBXX,IBY
 K IBFAC,IBFACN,IBARR,IBALL,IBX,DFN,POP,X,Y,SDCNT
 Q
 ;
 ;
SET(IBNET,IBSTA,DFN) ; Create the temporary sort file.
 ;  Input:  IBNET  --  The network/VISN number
 ;          IBSTA  --  The Station number
 ;            DFN  --  Pointer to the patient in file #2
 ;
 N IBDFN,IBINS,IBMT,IBTXMT,VAEL,VAERR
 ;
 S IBDFN=$$PT^IBEFUNC(DFN)
 S IBINS=$$INSURED^IBCNS1(DFN),IBMT=$P($$LST^DGMTU(DFN),"^",4)
 S IBMT=$S(IBMT="C":"YES",IBMT="G":"GMT",IBMT="P":"PEN",IBMT="R":"REQ",1:"NO")
 S IBTXMT=$$TXMT(DFN)
 D ELIG^VADPT
 ;
 ; - set all patients to be included in array for next appt.
 I $$GETICN^MPIF001(DFN)>0 S ^TMP("IBDFN",$J,DFN)=""
 ;
 ; - set all patient data into the temporary file
 S ^TMP("IBATOP",$J,IBNET,IBSTA,$P(IBDFN,"^")_"@@"_DFN)=$P(IBDFN,"^",3)_"^"_$P(VAEL(1),"^",2)_"^"_IBMT_"^"_$S(IBINS:"YES",1:"NO")_"^"_IBTXMT
 Q
 ;
TXMT(DFN) ; Find the patient's last treatment date and next sched date
 ;  Input:   DFN  --  Pointer to the patient in file #2
 ; Output:   1^2, where
 ;                1 => last treatment date, or null
 ;                2 => next scheduled treatment date, or null
 ;                     (not including scheduling)
 ;
 N IBDT,IBLT,IBNEXT,IBQ,X,X1,X2
 S (IBLT,IBNEXT)=""
 ;
 ; - if current inpatient, set last treatment date to today
 I $G(^DPT(DFN,.105)) S IBLT=DT G TXMTN
 ;
 ; - get the last discharge date
 S IBLT=+$O(^DGPM("ATID3",DFN,"")) S:IBLT IBLT=9999999.9999999-IBLT\1
 S:IBLT>DT IBLT=DT
 ;
 ; - get the last registration date and compare to last treatment date
 S X=+$O(^DPT(DFN,"DIS",0)) I X S X=9999999-X\1 S:X>IBLT IBLT=X
 ;
 ; - get the last appointment or stop after last treatment date (if any)
 K ^TMP("DIERR",$J)
 I '$G(IBQ) D
 .D OPEN^SDQ(.IBQ) Q:'$G(IBQ)
 .D INDEX^SDQ(.IBQ,"PATIENT/DATE","SET")
 .D SCANCB^SDQ(.IBQ,"I $S($P(SDOE0,U,8)=2:1,$P(SDOE0,U,8)=1:$$APPT^IBATOP(SDOE0),1:0) S IBLT=SDOE0\1,SDSTOP=1","SET")
 ;
 D PAT^SDQ(.IBQ,DFN,"SET")
 D DATE^SDQ(.IBQ,IBLT+.000001,9999999,"SET")
 D ACTIVE^SDQ(.IBQ,"TRUE","SET")
 D SCAN^SDQ(.IBQ,"BACKWARD")
 D CLOSE^SDQ(.IBQ)
 K ^TMP("DIERR",$J)
 ;
TXMTN ; - find next scheduled treatment date
 S IBNEXT=""
 S X=0 F  S X=$O(^DGS(41.1,"B",DFN,X)) Q:'X  D  ;         sched adm
 .S X1=$G(^DGS(41.1,X,0))
 .S X2=$P(X1,"^",2)\1
 .Q:X2<DT  ;                 must be old scheduled adm
 .Q:$P(X1,"^",13)  ;         sched adm is cancelled
 .Q:$P(X1,"^",17)  ;         patient already admitted
 .I X2>IBNEXT S IBNEXT=X2
 ;
 Q IBLT_"^"_IBNEXT
 ;
APPT(SDOE0) ; Determine if appt associated with encounter is valid
 Q $S($P(SDOE0,U,12)=2:1,$P(SDOE0,U,12)=14:1,1:0)
 ;
 ;
PAUSE ; Page break
 Q:$E(IOST,1,2)'="C-"
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
HDR(IBNET) ; Write the detail report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !,"Transfer Pricing Patient Listing",?38,"Run Date: ",IBRUN,?72,"Page: ",IBPAG
 I $G(IBNET) W !,"Network: VISN ",IBNET
 W !?50,"MT",?55,"Act",?63,"Last",?71,"Nxt Sched"
 W !,"Patient Name/ID",?28,"Primary Eligibility",?49,"Stat"
 W ?55,"Ins",?63,"Seen",?71,"Visit/Adm"
 W !,$$DASH(IOM)
 Q
 ;
DISFAC(X) ; Display the station number and name.
 ;  Input:  X  --  The Station Number
 ; Variable input:  IBFACN array
 ;
 W !!?4,"Home Facility: ",$P(IBFACN(X),"^",2),"  ",$P(IBFACN(X),"^"),!
 Q
 ;
DASH(X) ; Return a dashed line.
 Q $TR($J("",X)," ","=")
