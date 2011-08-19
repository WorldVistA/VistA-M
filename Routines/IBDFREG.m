IBDFREG ;ALB/CJM - ENCOUNTER FORM (prints for a single patient);NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
MAIN(WITHDATA) ;
 ; -- prints encounter forms, either with patient data for a patient 
 ;    with no appointment (in which case it uses time of printing as
 ;    the appointment time) or without patient data (only if a form
 ;    is defined for the clinic for such use)
 ;    $G(WITDATA) if the form should be printed with data
 ;    0 if a blank form for use without patient data should be printed
 ;
 N IBF,FORMS,NODE,IBPM
 ;FORMS = list of forms in form^form^... format
 ;IBI is a counter used to parse FORMS
 ;IBPM=1 if forms defined in print manager should be printed
 N IBFLAG
 S IBFLAG=1
 S WITHDATA=+$G(WITHDATA)
 K ^TMP("IB",$J),^TMP("IBDF",$J)
 S (IBPM,IBQUIT)=0
 D CLINIC G:IBQUIT EXIT
 I WITHDATA D  G:IBQUIT EXIT
 .D NOW
 .D WHCHFORM
 D DEVICE G:IBQUIT EXIT
QUEUED ;
 ;input - DFN,IBAPPT,IBCLINIC
 N IBDEVICE
 ;
 D DEVICE^IBDFUA(0,.IBDEVICE)
 F IBF=1:1 S IBFORM=$P(FORMS,"^",IBF) Q:'IBFORM  D DRWFORM^IBDF2A(IBFORM,WITHDATA,.IBDEVICE)
 I WITHDATA,IBPM D PRNTOTHR^IBDF1B5(IBCLINIC,IBAPPT,DFN)
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 D KPRNTVAR^IBDFUA ;kills the screen and graphics parameters
 K IBQUIT,IBFORM,IBCLINIC,IBAPPT,IBTYPE,X,Y,I,^TMP("IB",$J),^TMP("IBDF",$J),^TMP("RPT",$J),^TMP("DFN",$J)
 Q
FORM ;gets the type of form to print from the clinic setup - sets FORMS
 N SETUP
 S SETUP=$O(^SD(409.95,"B",IBCLINIC,"")) I 'SETUP D ERROR S IBQUIT=1 Q
 S SETUP=$G(^SD(409.95,SETUP,0)) I SETUP="" D ERROR S IBQUIT=1 Q
 S FORMS=$P(SETUP,"^",5) I 'FORMS D ERROR S IBQUIT=1 Q
 Q
ERROR ;prints a message
 W !!,"There is no encounter form defined for this clinic that should print",!,"without patient data!",!
 Q
ERROR2 ;prints a message
 W !!,"There are no forms defined to print for this clinic!",!
 Q
DEVICE ;
 ; -- always ask with param as default
 S %ZIS("A")="Select Encounter Form PRINTER: "
 S %ZIS("B")=$P($G(^DG(43,1,0)),"^",48) S %ZIS="MQN",%ZIS("S")="I $E($P($G(^%ZIS(2,+$G(^%ZIS(1,Y,""SUBTYPE"")),0)),U),1,2)=""P-""" D ^%ZIS
 I POP S IBQUIT=1 Q
 S IBDFRION=ION
 ;
 ; -- ask only if parameter not defined
 ;I $P($G(^DG(43,1,0)),"^",48)="" S %ZIS="MQN" D ^%ZIS Q:POP S IBDFRION=ION
 ;
 I IO=IO(0)!($E(IOST,1,2)["C-") W !,"Queuing to a CRT not allowed!" S IBQUIT=1 Q
 S ZTRTN="QUEUED^IBDF1A",(ZTSAVE("WITHDATA"),ZTSAVE("IB*"),ZTSAVE("DFN"),ZTSAVE("FORMS"))="",ZTDTH=$H
 S ZTDESC="IBD - PRINT ENCOUNTER FORM" D ^%ZTLOAD
 ;W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 D HOME^%ZIS S IBQUIT=1 Q
 Q
CLINIC ;asks the user for the clinic
 K DIR S DIR(0)="409.95,.01O",DIR("A")="PRINT AN ENCOUNTER FORM FOR WHICH CLINIC? " D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!(+Y<0)!('(+Y)) S IBQUIT=1 Q
 S IBCLINIC=+Y
 Q
NOW ;sets IBAPPT to NOW
 N %,%H,%I,X
 D NOW^%DTC
 S IBAPPT=%
 Q
WHCHFORM ;
 S IBPM=0,FORMS=""
 S Y=2 S FORMS=$$FORMS^IBDF1B2(IBCLINIC,DFN,IBAPPT),IBPM=1
 I '$P(FORMS,"^"),IBPM,'$$IFOTHR^IBDF1B5(IBCLINIC,"FOR EVERY APPOINTMENT"),'$$IFOTHR^IBDF1B5(IBCLINIC,"ONLY FOR EARLIEST APPOINTMENT") D ERROR2 S IBQUIT=1 Q
 Q
 ;
WI(DFN,IBCLINIC,IBAPPT) ; -- procedure
 ; -- print encounter form for walk-ins (not tested)
 N DIR,IBQUIT,IBF,FORMS,NODE,IBPM,IBDFWI,WITHDATA
 S IBQUIT=0
 G:'$G(DFN) WIQ
 G:'$G(IBAPPT) WIQ
 ;
 S DIR(0)="Y",DIR("A")="DO YOU WANT TO PRINT AN ENCOUNTER FORM NOW"
 W ! D ^DIR K DIR G WIQ:$D(DIRUT)!(Y=0)
 ;
 I '$G(IBCLINIC) D CLINIC G:IBQUIT WIQ
 ;
 S (IBDFWI,WITHDATA)=1
 K ^TMP("IB",$J),^TMP("IBDF",$J)
 S (IBPM,IBQUIT)=0
 D WHCHFORM
 D DEVICE G:IBQUIT WIQ ;automatically queues form
 D QUEUED
WIQ Q
