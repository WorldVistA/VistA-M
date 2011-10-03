PSAP41 ;BHM/DB - PRIME VENDOR CONVERSION ROUTINE ;3/30/04
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**41**; 10/24/97
 ;References to ^PSDRUG( are covered by IA #2095
 W !!,"This routine is only to be run prior to the first execution of the Drug",!,"Accountability upload utility used with the new prime vendor (McKesson).",!
ASK K DIR S DIR("A")="Is it safe to run this utility",DIR(0)="Y",DIR("B")="NO" D ^DIR W "  ",$S($G(Y)=1:"YES",$G(Y)="^":"^ Install Aborted",1:"NO")
 I $D(DIRUT) S (XPDQUIT,XPDABORT)=1 G DONE
 K DIR I $G(Y)'=1 W !!,"This utility can be run at anytime in the future from the programmer prompt",!,"by running the routine PSAP41.",! G DONE
DEV W ! K DIR S DIR(0)="DA^NOW::ERSX",DIR("A")="When do you want to run this utility? ",DIR("B")="NOW",DIR("?")="Complete date and time must be stated." D ^DIR I $D(DIRUT) W !!,"Incomplete information, try again" G ASK
 S ZTDTH=Y,ZTRTN="PSABGN^PSAP41",ZTDESC="DRUG ACCOUNTABILITY VSN CONVERSION",ZTIO="",PSADUZ=DUZ,ZTSAVE("PSADUZ")=""
 D ^%ZTLOAD I '$D(ZTSK) D HOME^%ZIS W !,"Task was not started properly.",! G DONE
 W !!,"Task Queued - Task Number: ",ZTSK,!!
 G DONE
PSABGN ;begin process
 S (PSADRG,PSACNT2)=0
1 S PSADRG=$O(^PSDRUG(PSADRG)) G MSG:PSADRG'>0 I '$D(^PSDRUG(PSADRG,1,0)) G 1
 S PSASYN=0
2 S PSASYN=$O(^PSDRUG(PSADRG,1,PSASYN)) G 1:PSASYN'>0 S PSADATA=$G(^PSDRUG(PSADRG,1,PSASYN,0))
 S PSAVEND=$P($G(PSADATA),"^",9),PSAVEND=$TR(PSAVEND,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I PSAVEND["AMERISOURCE" S DIE="^PSDRUG("_PSADRG_",1,",DA(1)=PSADRG,DA=PSASYN,DR="400///UNKNOWN" D ^DIE K DA,DR S PSACNT2=$G(PSACNT2)+1
 G 2
DONE K DIE,DA,DR,DIR,PSADRG,PSASYN,PSADATA,PSAVEND
Q Q
MSG S XMSUB="PSA*3*41 Pre-install routine completed"
 S ^TMP("PSA",$J,1,0)="The post Amerisource/Pre-McKesson conversion of synonym data has completed."
 S ^TMP("PSA",$J,2,0)=" ",^TMP("PSA",$J,3,0)="Synonym Vendor Stock Numbers converted: "_$G(PSACNT2)
 S XMY(PSADUZ)="",XMDUZ="Drug Accountability Pre-installation routine",XMTEXT="^TMP(""PSA"",$J,"
 D ^XMD K PSADUZ
 G DONE
