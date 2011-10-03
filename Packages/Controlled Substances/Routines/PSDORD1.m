PSDORD1 ;BIR/LTL-CS Order Entry Listing and Cancel pending; 19 Dec 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 D PRT S PSDC="D" F PSD=1:1:$G(PSD(2)) S PSDD=$G(PSDD)_PSD_","
 G:$G(PSDOUT) SKIP2
AC S DIR(0)="SA^A:Approve;D:Delete"
 S DIR("A")="Approve or Delete (A/D): "
 S DIR("?")="After selecting an action, you may select a range of orders."
 S DIR("B")="Approve" D ^DIR K DIR N PSDC S PSDC=Y
 G:$D(DIRUT) SKIP2
 I $G(PSD(2))=1 S PSDD="1," G SKIP
 S DIR(0)="L^1:"_$G(PSD(2)) W ! D ^DIR K DIR I $D(DIRUT) S PSDC="D" G SKIP2
 S PSDD=Y
SKIP I PSDC="D" S DIR(0)="Y",DIR("B")="No",DIR("A")="Are you sure you want to cancel request(s) #"_$E(PSDD,1,($L(PSDD)-1)) W ! D ^DIR K DIR G:$D(DIRUT) SKIP2 G:'Y AC G SKIP2
 N X,X1 D SIG^XUSESIG I X1="" S PSDC="D" G SKIP
SKIP2 S PSDD(1)=1 F  S PSDD(2)=$P(PSDD,",",PSDD(1)) Q:'PSDD(2)  S PSDD(1)=PSDD(1)+1 D
ORD .;update ord
 .S PSDR=+$O(PSDB(PSDD(2),0)),PSDA=+$O(PSDB(PSDD(2),PSDR,0))
 .S PSDQTY=$P($G(^PSD(58.8,+NAOU,1,+PSDR,3,+PSDA,0)),U,6)
 .I PSDC="A" D NOW^%DTC S PSDT=+$E(%,1,12),DIE="^PSD(58.8,+NAOU,1,+PSDR,3,",DA(2)=NAOU,DA(1)=PSDR,DA=PSDA,DR="1////"_PSDT_";10////1" D ^DIE K DIE,DA,DR D PHARM^PSDORD2 K PSDA(PSDR,PSDA) Q
 .D DEL^PSDORD2 K PSDA(PSDR,PSDA) S PSDOUT=0
END K DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,PSD,PSDOUT,PSDB,PSDD,X,Y
 Q
PRT ;displays list
 W @IOF,"Accessing pending requests for ",$P($G(^VA(200,DUZ,.1)),U,4),"...",!
 K ^UTILITY($J,"W")
 N X,DIWL,DIWR,DIWF S PSD=0,DIWL=1,DIWR=80,DIWF="W"
 F  S PSD=$O(^PSD(58.8,+PSDS,5,PSD)) Q:'PSD  S X=$G(^PSD(58.8,+PSDS,5,PSD,0)) D ^DIWP
 D ^DIWW
 W !,"The following request(s) may be approved or deleted:",!
 W !,"#  DATE ORDERED",?20,"DRUG",?72,"QUANTITY",!! S PSD=0
 F  S PSD=$O(PSDA(PSD)) Q:'PSD!($G(PSDOUT))  S PSD(1)=0 F  S PSD(1)=$O(PSDA(PSD,PSD(1))) Q:'PSD(1)  S PSD(2)=$G(PSD(2))+1,PSDB(PSD(2),PSD,PSD(1))="" D  Q:$G(PSDOUT)
 .S Y=$E($P(PSDA(PSD,PSD(1)),U,2),1,7) X ^DD("DD") W !,PSD(2),?3,Y,?16
 .W $P($G(^PSDRUG(PSD,0)),U),?72,$J($P(PSDA(PSD,PSD(1)),U,6),4)
 .I $Y+2>IOSL S DIR(0)="E" D ^DIR K DIR S:Y<1 PSDOUT=1 W @IOF
 Q
