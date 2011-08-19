IBPEX ;ALB/AAS - PURGE MEDICATION CO-PAY EXEMPTIONS ; 12-NOV-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% I '$D(DT) D DT^DICRW
 I '$D(IOF) D HOME^%ZIS
 ;
 W @IOF,?15,"Purge Medication Copayment Exemptions",!!
 ;
 S DIR("?")="Enter the date through which you want to purge entries for the BILLING EXEMPTIONS file (354.1)"
 S DIR("?",1)="This must be a date at least one year in the past."
 S DIR("?",2)="This option will purge inactive exemptions whose exemption date is earlier"
 S DIR("?",3)="than this date and active exemptions older than one year before this date."
 S DIR(0)="D^2920101:"_(DT-10000)_":EX",DIR("A")="Purge Date"
 S Y=DT-10000 D D^DIQ S DIR("B")=Y
 D ^DIR K DIR
 I $D(DIRUT)!(Y'?7N) G END
 S IBPDT=Y
 ;
 W !!,"There is no output from this routine it just purges.",!
 S DIR(0)="Y",DIR("A")="Are you sure you want to purge now",DIR("B")="NO" D ^DIR K DIR
 I $D(DIRUT)!(Y'=1) G END
 ;
DEV S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBPEX",ZTSAVE("IB*")="",ZTDESC="IB Purge exemption entries" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G END
 U IO
 ;
DQ ; -- entry point for later
 ;    if exemption not active, not current, earlier than ibpdt
 ;         or
 ;    if active, not current, earlier that ibpdt-10000
 ;         then purge
 ;
 S (IBDT,IBPURG,IBPCNT,IBPAG)=0
 D NOW^%DTC S Y=% D D^DIQ S IBPDAT=Y
 F  S IBDT=$O(^IBA(354.1,"B",IBDT)) Q:'IBDT!(IBDT>IBPDT)  S IBDA=0 F  S IBDA=$O(^IBA(354.1,"B",IBDT,IBDA)) Q:'IBDA  D CHK,PURGE:IBPURG
 D HDR,REPORT
 G END
 ;
END Q:$D(ZTQUEUED)
 D ^%ZISC
 ;K IBPDT,IBPURG,DIR
 Q
 ;
CHK ; -- check entries
 W:'$D(ZTQUEUED) "."
 S IBPURG=0
 S X=$G(^IBA(354.1,IBDA,0)) G CHKQ:X=""
 S X1=$G(^IBA(354,$P(X,"^",2),0))
 ;
 ; -- quit if contains ar pass dates
 I $P(X,"^",14) G CHKQ
 ;
 ; -- quit if is current exemption
 I +X=$P(X1,"^",3) G CHKQ
 ;
 ; -- if active, older than purge date - 1 year
 I $P(X,"^",10),+X<(IBPDT-10000) S IBPURG=1
 ;
 ; -- if inactive, older than purge date
 I '$P(X,"^",10),+X<IBPDT S IBPURG=1
 ;
CHKQ Q
 ;
PURGE ; -- blow away the entry
 S DA=IBDA,DIK="^IBA(354.1," D ^DIK
 K DA,DIK
 S IBPCNT=IBPCNT+1
 Q
 ;
HDR ; -- simple header for 1 line report
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W "BILLING EXEMPTION PURGE REPORT",?IOM-30,IBPDAT," PAGE ",IBPAG
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
REPORT ; -- simple report
 I 'IBPCNT W !,"No exemption found that met purge criteria" G REPORTQ
 W !,"There were ",IBPCNT," entries purged from the billing exemption file"
REPORTQ ;
 Q
