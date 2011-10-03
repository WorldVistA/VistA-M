IBARXEPV ;ALB/AAS - RX COPAY EXEMPTION VERIFY STATUS ; 02/12/2004
 ;;2.0;INTEGRATED BILLING;**262**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ; -- print/verify patients whose current exemption does not match
 ;    what is currently computed.
 I '$D(DT) D DT^DICRW
 S IBQUIT=0
 I '$D(IOF) D HOME^%ZIS
 W @IOF,"Verify Medication Copayment Exemption Status"
 W !! D DATE^IBOUTL
 I 'IBBDT!('IBEDT)!(IBEDT<IBBDT) G END
 ;
 ; -- update patient status
 W !
 S DIR("?")="Answer 'YES' if you want to automatically update patient status to the computed status, or 'NO' to print a report of discrepancies."
 S DIR(0)="Y",DIR("A")="Update Patient Status",DIR("B")="NO" D ^DIR K DIR S IBUP=+Y
 I $D(DIRUT) G END
 W !
 ;
DEV W !!,"You will need a 132 column printer for this report!",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBARXEPV",ZTSAVE("IB*")="",ZTDESC="IB Verify Medication Copayment exemption" D ^%ZTLOAD K ZTSK,IO("Q") D HOME^%ZIS G END
 I '$D(ZTQUEUED) W !,"HMMMM, LET ME THINK ABOUT THIS FOR A MINUTE"
 U IO
 ;
DQ ; -- entry point from task man to start comparison
 S (IBPCNT,IBPAG)=0,IBOK=1 D NOW^%DTC S Y=% D D^DIQ S IBPDAT=$P(Y,"@")_" "_$E($P(Y,"@",2),1,5)
 K ^TMP($J,"IBUNVER")
 ;
 ; -- look through inverse date x-ref
 S IBDT=IBBDT-.00001
 F  S IBDT=$O(^IBA(354.1,"B",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.9))  S IBDA=0 F   S IBDA=$O(^IBA(354.1,"B",IBDT,IBDA)) Q:'IBDA  D CHK I 'IBOK D UP:IBUP,SET
 D REPORT,PAUSE^IBOUTL:'IBQUIT
 G END
 ;
END K ^TMP($J,"IBUNVER")
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K DFN,DIR,DIRUT,DIC,DIE,DA,DR,X,Y
 K IBBDT,IBDA,IBDATA,IBDEPEN,IBDFN,IBDT,IBEDT,IBER,IBERR,IBEXREA,IBEXREAN,IBEXREAO,IBJ,IBMESS,IBNAM,IBOK,IBP,IBPAG,IBPCNT,IBPDAT,IBQUIT,IBUP
 Q
 ;
REPORT ; -- print report
 D HDR S IBDCNT=0
 I '$D(^TMP($J,"IBUNVER")) W !,"No discrepancies found in ",IBPCNT," exemptions checked." G REPORTQ
 ;
 S IBNAM=""
 F  S IBNAM=$O(^TMP($J,"IBUNVER",IBNAM)) Q:IBNAM=""!(IBQUIT)  S IBDFN="" F  S IBDFN=$O(^TMP($J,"IBUNVER",IBNAM,IBDFN)) Q:IBDFN=""!(IBQUIT)  S IBER=^(IBDFN) D LINE
 ;
 W !!,"There were ",IBDCNT," discrepancies found in ",IBPCNT," exemptions checked."
 ;
REPORTQ Q
 ;
LINE ; -- write each line
 S DFN=+IBDFN,IBDCNT=IBDCNT+1
 I $Y>(IOSL-5) D PAUSE^IBOUTL Q:IBQUIT  D HDR
 W !,$E(IBNAM,1,20),?22,$P(IBER,"^",8)
 S X=$P(IBER,"^",5) W ?39,$S(X=3:"Exemption incorrect",X=1!(X=2)!(X=5):"Not Current Status",X=4:"Name Missing",1:"Hmmmm")
 W ?61,$$DAT1^IBOUTL($P(IBER,"^",2))_" "_$E($P($G(^IBE(354.2,+IBER,0)),"^"),1,15)
 W ?88,$$DAT1^IBOUTL($P(IBER,"^",4))_" "_$E($P($G(^IBE(354.2,+$P(IBER,"^",3),0)),"^"),1,15)
 W ?115,$P(IBER,"^",6)
 Q
 ;
CHK ; -- check if current status = computed status
 S IBOK=1,IBMESS="Nothing Updated",IBERR=""
 S X=$G(^IBA(354.1,+IBDA,0)) G CHKQ:'$P(X,"^",10) ;not active skip
 S DFN=$P(X,"^",2)
 S Y=$G(^IBA(354,DFN,0)) I +X<$P(Y,"^",3) G CHKQ ;not current exemption
 ;
 N DGMT,CONV,CLN S (CLN,CONV)=0,DGMT=$$LST^DGMTU(DFN,+X,1)
 I $P(DGMT,U,5)=2 D  G:CONV CHKQ           ; skip Edb conv. tests
 .; Loop through the MT comments, Check for EDB converted test 
 .; No comments to check
 .Q:'$D(^DGMT(408.31,+DGMT,"C",1,0))
 .F  S CLN=$O(^DGMT(408.31,+DGMT,"C",CLN)) Q:'CLN!(CONV)  D
 ..I ^DGMT(408.31,+DGMT,"C",CLN,0)["Z06 MT via Edb" S CONV=1
 ;
 S IBPCNT=IBPCNT+1
 I '+Y S IBOK=0,IBERR=4
 S IBEXREAO=$P(X,"^",5)_"^"_+X ;current exemption
 I $P($G(^IBE(354.2,+IBEXREAO,0)),"^",5)=2010 G CHKQ ; hardships don't report
 I +X>$P(Y,"^",3) S IBOK=0,IBERR=1 ;most current exemption not in 354
 I $P(X,"^",5)'=$P(Y,"^",5) S IBOK=0,IBERR=2 ;Current exemption not in 354
 I $P(X,"^",4)'=$P(Y,"^",4) S IBOK=0,IBERR=5 ;current status in exemption not in 354
 S IBEXREAN=$$STATUS^IBARXEU1(DFN,DT)
 I +IBEXREAO'=+IBEXREAN S IBOK=0,IBERR=3
CHKQ Q
 ;
UP ; -- update current exemption status
 Q:IBOK
 S IBJOB=15,IBWHER=16
 I IBERR=4 D  G UPQ
 .S DIE="^IBA(354,",DA=DFN,DR=".01////"_DFN D ^DIE
 .K DIE,DA,DR,DIC
 .S IBMESS="Name Corrected"
UP1 N IBOLDAUT S IBOLDAUT=""
 ;
 ; -- if currently not auto exempt make sure not more recent autoexempt
 I $L($P($G(^IBE(354.2,+IBEXREAN,0)),"^",5))>2 D OLDAUT^IBARXEX1(IBEXREAN)
 S IBFORCE=$P(IBEXREAN,"^",2)
 D MOSTR^IBARXEU5($P(IBEXREAN,"^",2),+IBEXREAN)
 D ADDEX^IBAUTL6(+IBEXREAN,$P(IBEXREAN,"^",2),1,1,IBOLDAUT)
 S IBMESS="Updated"
UPQ K IBFORCE Q
 ;
SET ; -- set ^tmp node if not okay
 Q:IBOK
 S IBP=$$PT^IBEFUNC(DFN)
 S IBDFN=DFN
 I $D(^TMP($J,"IBUNVER",$P(IBP,"^"),DFN)) S IBDFN=DFN_"-"_IBPCNT
 S ^TMP($J,"IBUNVER",$P(IBP,"^"),IBDFN)=IBEXREAO_"^"_IBEXREAN_"^"_IBERR_"^"_IBMESS_"^"_IBP
 Q
 ;
HDR ; -- print header
 I IBPAG!($E(IOST,1,2)="C-") W @IOF
 S IBPAG=IBPAG+1
 W !,"Medication Copayment Exemption Problem Report",?(IOM-31),IBPDAT," Page ",IBPAG
 W !,"Patient",?22,"PT. ID",?39,"Error",?61,"Current Exemption",?88,"Computed Exemption",?115,"Action"
 W !,$TR($J(" ",IOM)," ","-")
 Q
