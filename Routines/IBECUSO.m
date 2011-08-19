IBECUSO ;RLM/DVAMC - TRICARE PHARMACY BILLING OUTPUTS ; 21-AUG-96
 ;;2.0;INTEGRATED BILLING;**52,240,309,347**;21-MAR-94;Build 24
 ;
REJ ; Generate the Pharmacy Billing Reject report.
 ;
 ; - quit if there are no rejects
 I '$O(^IBA(351.52,0)) W !!,"There are no rejects to be printed." G REJQ
 ;
 ; - select a device
 S %ZIS="QM" D ^%ZIS G:POP REJQ
 I $D(IO("Q")) D  G REJQ
 .S ZTRTN="REJDQ^IBECUSO",ZTDESC="IB - LIST TRICARE PHARMACY BILLING REJECTS"
 .D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
REJDQ ; Tasked entry point.
 ;
 S (IBPAG,IBQ)=0 D REJHDR
 ;
 ; - print rejects
 S IBR=0 F  S IBR=$O(^IBA(351.52,IBR)) Q:'IBR  D  Q:IBQ
 .S IBR0=$G(^IBA(351.52,IBR,0)),IBR1=$G(^(1))
 .Q:'IBR0
 .;
 .S DFN=$$FILE^IBRXUTL(+IBR0,2),IBRXD=$$RXZERO^IBRXUTL(DFN,+IBR0)
 .Q:IBRXD=""
 .S IBFDT=$$FDT($P(IBR0,"^"))
 .;
 .; - display the prescription
 .I $Y>(IOSL-4) D PAUSE Q:IBQ  D REJHDR
 .D REJERR
 .;
 .; - display errors
 .F I=1:1 Q:$P(IBR1,",",I)=""  S IBERRP=$P(IBR1,",",I) Q:IBERRP=""  D  Q:IBQ
 ..I $Y>(IOSL-2) D PAUSE Q:IBQ  D REJHDR,REJERR
 ..S IBTXT=$$ERRTXT^IBECUS22(IBERRP)
 ..I IBTXT]"" W !?4,IBTXT
 ;
 ; - end-of-report pause
 D:'IBQ PAUSE
 ;
REJQ I '$D(ZTQUEUED) D ^%ZISC
 K IBFDT,IBPAG,IBQ,IBR,IBR0,IBR1,IBRXD,DFN,IBERRP,IBTXT
 Q
 ;
 ;
REJHDR ; Print the Reject report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !,$$DASH(),!,"Date: ",$$DAT1^IBOUTL(DT),?(IOM/2)-14,"IPS Unresolved Reject Report"
 W ?(IOM-10),"Page: ",IBPAG,!,$$DASH()
 Q
 ;
REJERR ; Write the prescription and name.
 W !!,"RX# ",$P(IBRXD,"^"),", filled on ",$$DAT1^IBOUTL(IBFDT)
 W " (",$E($P($G(^DPT(DFN,0)),"^"),1,17)," ",$P($G(^(0)),"^",9),")"
 W " rejected because:"
 Q
 ;
DASH() ; Return a dashed line.
 Q $TR($J("",IOM)," ","=")
 ;
PAUSE ; Page break
 Q:$E(IOST,1,2)'="C-"
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
 ;
 ;
 ;
TRN ; Generate the Pharmacy Billing Transmission Report
 ;
 ; - select dates
 K DIR S DIR(0)="D^2960101:"_DT,DIR("A")="Beginning Date:" D ^DIR G:$D(DIRUT) TRNQ S IBBEG=Y
 K DIR S DIR(0)="D^"_IBBEG_":"_DT,DIR("A")="Ending Date:" D ^DIR G:$D(DIRUT) TRNQ S IBEND=Y
 I IBBEG>IBEND W !,"Beginning data must be before ending date.",! G TRN
 ;
 ; - select a device
 S %ZIS="QM" D ^%ZIS G:POP TRNQ
 I $D(IO("Q")) D  G TRNQ
 .S ZTRTN="TRNDQ^IBECUSO",ZTDESC="IB - LIST TRICARE PHARMACY BILLING TRANSMISSIONS"
 .F I="IBBEG","IBEND" S ZTSAVE(I)=""
 .D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
TRNDQ ; Tasked entry point.
 ;
 S (IBPAG,IBQ)=0 D TRNHDR
 ;
 ; - print transactions
 S IBC=0 F  S IBC=$O(^IBA(351.5,IBC)) Q:'IBC  D  Q:IBQ
 .S IBCD=$G(^IBA(351.5,IBC,0)),IBCD2=$G(^(2)),IBCD5=$G(^(5)),IBCD6=$G(^(6))
 .Q:'IBCD
 .S IBD=$$FILE^IBRXUTL(+IBCD,101) I IBD="" S IBD=$$FILE^IBRXUTL(+IBCD,22)
 .I IBD<IBBEG Q
 .I IBD>IBEND Q
 .;
 .S IBDPT(0)=$G(^DPT($P(IBCD,"^",2),0)),IBRXD=$$RXZERO^IBRXUTL($P(IBCD,"^",2),+IBCD)
 .S IBFDT=$$FDT($P(IBCD,"^"))
 .;
 .I $Y>(IOSL-5) D PAUSE Q:IBQ  D TRNHDR
 .D TRNDAT
 .D ZERO^IBRXUTL(+$P(IBRXD,"^",6))
 .W !,"  Drug Name: ",$G(^TMP($J,"IBDRUG",+$P(IBRXD,"^",6),.01))
 .K ^TMP($J,"IBDRUG")
 .;
 .W !?5,"Status: ",$S($P(IBCD6,"^")]"":"Reversed",IBCD5]"":"Rejected",1:"Accepted")
 .;
 .; - display errors
 .I IBCD5]"" F I=1:1 S IBERRP=$P(IBCD5,",",I) Q:IBERRP=""  D  Q:IBQ
 ..I $Y>(IOSL-2) D PAUSE Q:IBQ  D TRNHDR,TRNDAT
 ..S IBTXT=$$ERRTXT^IBECUS22(IBERRP)
 ..I IBTXT]"" W !?4,IBTXT
 .Q:IBCD5]""
 .;
 .I $Y>(IOSL-3) D PAUSE Q:IBQ  D TRNHDR,TRNDAT
 .W !,$P(IBCD,"^",4),?15,$J($P(IBCD,"^",5),6),?25,$J($P(IBCD2,"^"),6),?35,$J($P(IBCD2,"^",2),6),?45,$J($P(IBCD2,"^",3),6),?55,$J($P(IBCD2,"^",5),6)
 .W !?15,$P(IBCD2,"^",6),?39,$P(IBCD2,"^",7)
 .;
 .I $P(IBCD6,"^",3)]"" F I=1:1 S IBERRP=$P($P(IBCD6,"^",3),",",I) Q:IBERRP=""  D  Q:IBQ
 ..I $Y>(IOSL-2) D PAUSE Q:IBQ  D TRNHDR,TRNDAT
 ..S IBTXT=$$ERRTXT^IBECUS22(IBERRP)
 ..I IBTXT]"" W !?4,IBTXT
 .;
 .I $P(IBCD6,"^")]"" D
 ..I $Y>(IOSL-1) D PAUSE Q:IBQ  D TRNHDR,TRNDAT
 ..W !,"Reversal Authorization # ",$P(IBCD6,"^"),?40,"Reversed by: ",$P($G(^VA(200,+$P(IBCD6,"^",2),0)),"^")
 ;
 ; - end-of-report pause
 D:'IBQ PAUSE
 ;
TRNQ I '$D(ZTQUEUED) D ^%ZISC
 K IBPAG,IBQ,IBR,IBR0,IBR1,IBRXD,DFN,IBERRP,IBTXT,IBBEG,IBEND
 K IBC,IBCD,IBCD2,IBCD5,IBCD6,IBDPT,IBD,IBFDT
 Q
 ;
TRNHDR ; Print the Transmission Report header.
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1
 W !,$$DASH(),!,"Date: ",$$DAT1^IBOUTL(DT),?(IOM/2)-16,"IPS Prescription Status Report"
 W ?(IOM-10),"Page: ",IBPAG
 W !?(IOM/2)-17 S Y=IBBEG X ^DD("DD") W Y," through " S Y=IBEND X ^DD("DD") W Y
 W !,"RX#",?15,"Fill Date",?27,"Patient Name",?62,"Patient SSN"
 W !,"NDC",?15,"AWP",?25,"Copay",?35,"Ing Cost",?45,"Fee Paid",?55,"Total PD"
 W !?15,"Auth. #",?39,"Message"
 W !,"Reject Failure Codes"
 W !,$$DASH(),!
 Q
 ;
TRNDAT ; Display basic description information.
 W !!,$P(IBRXD,"^"),?15,$$DAT1^IBOUTL(IBFDT)
 W ?27,$P(IBDPT(0),"^"),?62,$P(IBDPT(0),"^",9)
 Q
 ;
FDT(X) ; Find the Fill Date for the prescription.
 ;  Input:  X  --  1;2   where 1 :> pointer to the rx in file #52, and
 ;                             2 :> pointer to the re-fill in #52.1, or
 ;                                  0 if this is the original fill.
 N IBRXN,Y,DFN S Y=""
 I $G(X)="" G FDTQ
 S IBRXN=+X
 I $P(X,";",2) S Y=$$SUBFILE^IBRXUTL(IBRXN,$P(X,";",2),52,.01) G FDTQ
 S DFN=$$FILE^IBRXUTL(IBRXN,2),Z2=$$RXSEC^IBRXUTL(DFN,IBRXN),Z3=$$RX3^IBRXUTL(DFN,IBRXN)
 S Y=$S($P(Z2,"^",2):$P(Z2,"^",2),+Z3:+Z3,$P(Z2,"^",5):$P(Z2,"^",5),1:"")
FDTQ Q Y
 ;
AWP ;
 I '$D(^JADUTIL("AWP UPDATE")) W !,"No updates on file" Q
 W !,"Date         Quantity"
 S A="" F  S A=$O(^JADUTIL("AWP UPDATE",A)) Q:'A  D
 .I A<($P($H,",")-52) K ^JADUTIL("AWP UPDATE",A) Q
 .S %H=A D YMD^%DTC S Y=X X ^DD("DD")
 .W !,Y,"  ",^JADUTIL("AWP UPDATE",A)
 Q
 ;
 ;
 ;
REM ; Delete rejects.
 W !!,"Delete entry from IPS error file"
 W !,"Delete RX#: " R JADTA:DTIME Q:JADTA=""!(JADTA="^")
 I '$D(^JADREJ(JADTA)) W !,JADTA," is not in the error file." G REM
 K ^JADREJ(JADTA) W !,JADTA," has been deleted." G REM
 Q
