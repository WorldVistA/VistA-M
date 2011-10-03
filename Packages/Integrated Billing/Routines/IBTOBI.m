IBTOBI ;ALB/AAS - CLAIMS TRACKING BILLING INFORMATION PRINT ;27-OCT-93
 ;;2.0;INTEGRATED BILLING;**91,160,199,309,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% I '$D(DT) D DT^DICRW
 W !!,"Bill Preparation Report for a Single Visit"
 D END
 ;
PAT ; -- Select patient
 W !!
 S DIC="^DPT(",DIC(0)="AEQM"
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 D ^DIC K DIC I +Y<1 G END
 S DFN=+Y
 ;
VSIT ;
 ; -- get claims tracking visit entry
 D TRAC^IBTRV K IBY
 I '$G(IBTRN) G END
 ;
DEV ; -- select device, run option
 W !
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBTOBI",ZTSAVE("IB*")="",ZTSAVE("DFN")="",ZTDESC="IB - Bill Preparation Report" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G PAT
 ;
 U IO
 D ONE,END G PAT
 Q
DQ ; -- task man entry point
 D ONE
 ;
END ; -- Clean up
 W !
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K I,J,X,Y,DFN,%ZIS,VA,IBTRN,IBTRND,IBTRND1,IBPAG,IBHDT,IBDISDT,IBETYP,IBQUIT,IBTAG,DIRUT,DUOUT,IBCNT,IBI,IBJ,IBNAR,IBTNOD,IBTRCD1,IBTRTP,IBDA
 D KVAR^VADPT
 Q
ONE ; -- print one billing report from ct
 S IBPAG=0,IBHDT=$$HTE^XLFDT($H,1),IBQUIT=0
 D PID^VADPT
 S IBTRND=$G(^IBT(356,+IBTRN,0)),IBTRND1=$G(^(1))
 S IBETYP=$G(^IBE(356.6,+$P(IBTRND,"^",18),0))
 D HDR,SECT1,^IBTOBI1
 Q
 ;
HDR ; -- Print header for billing report
 Q:IBQUIT
 I '$D(VA("PID")) N I,J D PID^VADPT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,$S($D(IBCTHDR):IBCTHDR,1:"Bill Preparation Report"),?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !!,$E($P($G(^DPT(DFN,0)),"^"),1,25),?28,VA("PID"),?50,"DOB: ",$$FMTE^XLFDT($P($G(^DPT(DFN,0)),"^",3),1)
 W !,$$EXPAND^IBTRE(356,.18,$P(IBTRND,"^",18))," on ",$$FMTE^XLFDT($P(IBTRND,"^",6),1)
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
SECT1 ; -- Section 1 - Visit info Region / misc billing info
 N IBD
 W !," Visit Information "
 S IBD(1,1)="    Visit Type: "_$P(IBETYP,"^")
 S X=$P(IBETYP,"^",3) I 'X W !,"No Visit Selected" Q
 D @X
 D MBI
 S I=0 F  S I=$O(IBD(I)) Q:'I  W !,$G(IBD(I,1)),?44,$E($G(IBD(I,2)),1,36)
 W !?4,$TR($J(" ",IOM-8)," ","-"),!
 Q
1 ; -- visit region for admission or scheduled admission
 S IBDISDT=""
 I $P($G(^DGPM(+$P(IBTRND,"^",5),0)),"^",17) S VAINDT=+$G(^DGPM(+$P(IBTRND,"^",5),0)),IBDISDT=+$G(^DGPM(+$P($G(^DGPM(+$P(IBTRND,"^",5),0)),"^",17),0))
 I '$D(VAIN) S VA200="" D INP^VADPT
 I VAIN(7)="" S Y=$P(IBTRND,"^",6) D D^DIQ S $P(VAIN(7),"^",2)=Y
 S IBD(2,1)="Admission Date: "_$P(VAIN(7),"^",2)
 S IBD(3,1)="          Ward: "_$P(VAIN(4),"^",2)
 S IBD(4,1)="     Specialty: "_$P(VAIN(3),"^",2)
 S IBD(5,1)="Discharge Date: "_$$FMTE^XLFDT(IBDISDT,1)
 Q
2 ; -- visit region for  outpatient care
 N IBOE,IBOE0
 S IBOE=$P(IBTRND,"^",4),IBOE0=$$SCE^IBSDU(+IBOE)
 S IBD(2,1)="    Visit Date: "_$$DAT1^IBOUTL($P(IBTRND,"^",6),"2P")
 I +IBOE<1 S IBD(3,1)="  No Outpatient Encounter Found" Q
 S IBD(3,1)="        Clinic: "_$P($G(^SC(+$P(IBOE0,U,4),0)),"^")
 S IBD(4,1)="  Appt. Status: "_$$EXPAND^IBTRE(409.68,.12,$P(IBOE0,U,12))
 S IBD(5,1)="    Appt. Type: "_$$EXPAND^IBTRE(409.68,.1,$P(IBOE0,U,10))
 S IBD(6,1)="  Special Cond: "_$$ENCL^IBTRED(IBOE)
 Q
 ;
3 ; -- visit region for rx refill
 N PSONTALK,PSOTMP,PSORXN,PSOFILL
 S PSONTALK=1 ;PSORXN=+$P(IBTRND,"^",8),PSOFILL=+$P(IBTRND,"^",10)
 S X=+$P(IBTRND,"^",8)_"^"_+$P(IBTRND,"^",10) D EN^PSOCPVW
 ;if refill was deleted and EN^PSOCPVW doesn't return any data use IB API
 I '$D(PSOTMP) D PSOCPVW^IBNCPDPC(+$P(IBTRND,"^",2),+$P(IBTRND,"^",8),.PSOTMP)
 S IBD(2,1)="Prescription #: "_$G(PSOTMP(52,+$P(IBTRND,"^",8),.01,"E"))
 I $P(IBTRND,"^",10)=0 S IBD(3,1)="     Fill Date: "_$$FMTE^XLFDT(+$P(IBTRND,"^",6))
 I +$P(IBTRND,"^",10) S IBD(3,1)="   Refill Date: "_$$FMTE^XLFDT(+$P(IBTRND,"^",6))
 S IBD(4,1)="          Drug: "_$G(PSOTMP(52,+$P(IBTRND,"^",8),6,"E"))
 S IBD(5,1)="      Quantity: "_$J($G(PSOTMP(52,+$P(IBTRND,"^",8),7,"E")),8)
 S IBD(6,1)="   Days Supply: "_$J($G(PSOTMP(52,+$P(IBTRND,"^",8),8,"E")),8)
 S IBD(7,1)="          NDC#: "_$$GETNDC^PSONDCUT(+$P(IBTRND,"^",8),$P(IBTRND,"^",10))
 S IBD(8,1)="     Physician: "_$G(PSOTMP(52,+$P(IBTRND,"^",8),4,"E"))
 Q
 ;
4 ; -- Visit region for prosthetics
 D 4^IBTOBI4
 Q
 ;
MBI ; -- Misc. billing info
 S IBD(1,2)=" Visit Billable: "_$S('$P(IBTRND,"^",19):"YES",1:"NO-"_$$EXPAND^IBTRE(356,.19,$P(IBTRND,"^",19)))
 S IBD(2,2)=" Second Opinion: "_$S('$P(IBTRND,"^",14):"NOT REQUIRED",1:$S('$P(IBTRND,"^",15):"REQUIRED-NOT OBTAINED",1:"OBTAINED"))
 S IBD(3,2)=" Auto Bill Date: "_$$FMTE^XLFDT($P(IBTRND,"^",17),1)
 S IBD(4,2)="Special Consent: ROI "_$S('$P(IBTRND,"^",31):"NOT DETERMINED",1:$$EXPAND^IBTRE(356,.31,$P(IBTRND,"^",31)))
 S IBD(5,2)="Special Billing: "_$$EXPAND^IBTRE(356,.12,$P(IBTRND,"^",12))
 Q
 ;
