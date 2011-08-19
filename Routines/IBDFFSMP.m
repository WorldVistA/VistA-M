IBDFFSMP ;ALB/MAF   -- Print a sample of all encounter forms.  - Dec 12 1995@800
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
 S (IBDFFLG,IBQUIT)=0
 S (IBPM,WITHDATA)=1
 K ^TMP("IBFRMS",$J)
 ;
 ;  -- Ask patient name 
 D PATIENT G:IBQUIT EXIT
 ;
 ;  -- Loop thru Print Manager Clinic Setup to find active forms used by
 ;    clinics.
 S IBCLINIC="" F  S IBCLINIC=$O(^SD(409.95,"B",IBCLINIC)) Q:IBCLINIC']""  D
 .S SETUP=$O(^SD(409.95,"B",IBCLINIC,""))
 .S NAME=$P($G(^SC(IBCLINIC,0)),"^")
 .D SET
 I '$D(^TMP("IBFRMS",$J)) W !!,"There are no forms set up for clinics...",!! G EXIT
 D NOW^IBDF1A,DEVICE  ;sets IBAPPT to NOW
 G:IBQUIT EXIT
 I 'IBDFFLG U IO D QUEUED
 G EXIT
 ;
SET ;  -- Build list into array IBFORMS.  Make sure EF is one that is active
 ;     Will print form only once.
 I $O(^SD(409.95,"B",IBCLINIC,0)) D
 .S IBDFNODE=^SD(409.95,SETUP,0)
 .S IBQUIT=0
 .F X=2,3,4,5,6,8,9 S:$P(IBDFNODE,"^",X)&('$D(^TMP("IBFRMS",$J,+$P(IBDFNODE,"^",X)))) ^TMP("IBFRMS",$J,$P(IBDFNODE,"^",X))=IBCLINIC  ;Loop thru the clinic setup node to find the active EF.
 .Q
 Q
 ;
PATIENT ;  -- gets the patient to print the form for
 W !!
 S DIR(0)="P^2:EM",DIR("A")="Select PATIENT NAME for Samples" D ^DIR K DIR I $D(DIRUT)!(+Y<1)!('(+Y)) S IBQUIT=1 Q
 S DFN=+Y
 Q
 ;
QUEUED ;
 ;input - DFN,IBAPPT,IBCLINIC
 N IBDEVICE
 ;
 D DEVICE^IBDFUA(0,.IBDEVICE)
 S IBDSAMP=1 ;printing sample forms don't update forms tracking, print form in name/ssn block
 F IBFORM=0:0 S IBFORM=$O(^TMP("IBFRMS",$J,IBFORM)) Q:'IBFORM  D
 .S IBCLINIC=+$G(^TMP("IBFRMS",$J,IBFORM))
 .D DRWFORM^IBDF2A(IBFORM,WITHDATA,.IBDEVICE)
 ;
EXIT ;
 K IBDSAMP
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K ^TMP("IBFRMS",$J)
 D KPRNTVAR^IBDFUA ;kills the screen and graphics parameters
 K CLINIC,DFN,FORMS,IBAPPT,IBCLINIC,IBFORM,IBDFNODE,IBDFFLG,IBPM,IBQUIT,NAME,POP,SETUP,WITHDATA,X,Y,I
 Q
 ;
DEVICE ;
 I $D(ZTQUEUED) Q
 W !,$C(7),"** Encounter Forms require a page size of 80 lines and 132 columns. **"
 K %IS,%ZIS,IOP S %ZIS="MQ" D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) D
 .S ZTRTN="QUEUED^IBDFFSMP",(ZTSAVE("WITHDATA"),ZTSAVE("IB*"),ZTSAVE("DFN"),ZTSAVE("FORMS"))="",ZTSAVE("^TMP(""IBFRMS"",$J,")=""
 .S ZTDESC="IBD - PRINT SAMPLE ENCOUNTER FORM" D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .I $D(ZTSK) S IBDFFLG=1
 .D HOME^%ZIS S IBQUIT=1 Q
 Q
