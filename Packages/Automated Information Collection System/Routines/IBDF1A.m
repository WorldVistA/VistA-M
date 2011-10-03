IBDF1A ;ALB/CJM - ENCOUNTER FORM (prints for a single patient);NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**29**;APR 24, 1997
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
 S (IBPM,IBQUIT)=0,DFN=""
 D CLINIC G:IBQUIT EXIT
 I WITHDATA D  G:IBQUIT EXIT
 .D PATIENT Q:IBQUIT
 .D NOW
 .D WHCHFORM
 I 'WITHDATA D FORM G:IBQUIT EXIT
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
 K IBQUIT,IBFORM,IBCLINIC,DFN,IBAPPT,IBTYPE,X,Y,I,^TMP("IB",$J),^TMP("IBDF",$J),^TMP("DFN",$J),^TMP("RPT",$J)
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
PATIENT ;gets the patient to print the form for
 S DIR(0)="P^2:EM",DIR("A")="PATIENT NAME" D ^DIR K DIR I $D(DIRUT)!(+Y<1)!('(+Y)) S IBQUIT=1 Q
 S DFN=+Y
 Q
DEVICE ;
 I $D(ZTQUEUED) Q
 W !,$C(7),"** Encounter Forms require a page size of 80 lines and 132 columns. **"
 K %IS,%ZIS,IOP S %ZIS="MQ" D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) D
 .S ZTRTN="QUEUED^IBDF1A",(ZTSAVE("WITHDATA"),ZTSAVE("IB*"),ZTSAVE("DFN"),ZTSAVE("FORMS"))=""
 .S ZTDESC="IBD - PRINT ENCOUNTER FORM" D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS S IBQUIT=1 Q
 U IO
 Q
CLINIC ;asks the user for the clinic
 K DA,DIR S DIR(0)="409.95,.01O",DIR("A")="PRINT AN ENCOUNTER FORM FOR WHICH CLINIC? " D ^DIR K DIR,DA I $D(DTOUT)!$D(DUOUT)!(+Y<0)!('(+Y)) S IBQUIT=1 Q
 S IBCLINIC=+Y
 Q
NOW ;sets IBAPPT to NOW
 N %,%H,%I,X
 D NOW^%DTC
 S IBAPPT=%
 Q
WHCHFORM ;
 I 'IBCLINIC D ASKFORM Q
 K DIR S DIR(0)="S^1:SELECT ANY FORM;2:USE CLINIC SETUP;",DIR("A")="Do you want to Select a form or Use the form(s) defined by the clinic setup?" D ^DIR K DIR I $D(DIRUT)!(+Y<0) S IBQUIT=1 Q
 S IBPM=0,FORMS=""
 I Y=1 D  Q:IBQUIT
 .D ASKFORM
 E  I Y=2 S FORMS=$$FORMS^IBDF1B2(IBCLINIC,DFN,IBAPPT),IBPM=1
 I '$P(FORMS,"^"),IBPM,'$$IFOTHR^IBDF1B5(IBCLINIC,"FOR EVERY APPOINTMENT"),'$$IFOTHR^IBDF1B5(IBCLINIC,"ONLY FOR EARLIEST APPOINTMENT") D ERROR2 S IBQUIT=1 Q
 Q
ASKFORM ;asks to select single form
 K DIC S DIC("S")="I '$P(^(0),U,7)",DIC=357,DIC(0)="AEQ",DIC("A")="Enter form to print: "
 D ^DIC K DIC I ($D(DTOUT)!$D(DUOUT)!(+Y<0)) S IBQUIT=1 Q
 S FORMS=+Y
 Q
