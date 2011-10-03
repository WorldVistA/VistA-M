PSDNSTK ;BIR/JPW-Inactivate Stocked Drugs ; 8 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 W !!,?5,"You may inactivate a Stocked Drug for a single NAOU,",!,?5,"or enter ^ALL  to inactivate the Drug in ALL NAOUs.",!
 K DA,DIC,PSDOUT F  Q:$D(PSDOUT)  W ! S ALL=1,DIC=58.8,DIC(0)="QEA",DIC("A")="Select NAOU: ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$P(^(0),""^"",2)'=""P""" D ^DIC K DIC Q:Y<0&(X'="^ALL")  D:X'="^ALL" INACT1 I ALL D ASK Q:$D(PSDOUT)
END K %,%DT,%H,%I,ALL,ANS1,ANS2,CNT,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,NAOU,NAOUN,PSDOUT,PSDR,PSDRN,PSDT,QUE,RDT,X,XMDUZ,XMSUB,XMTEXT,XMY,Y
 K ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,^TMP("PSDMSG",$J)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
INACT1 ;inactivate a drug for a single NAOU
 S NAOU=+Y,NAOUN=$P(Y,"^",2),ALL=0
 I '$D(^PSD(58.8,NAOU,1,0)) W !!,"There are no stocked drugs for this NAOU!!",!! Q
LOOP K DA,DIC S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,NAOU,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***"""
 W ! S DIC="^PSD(58.8,"_NAOU_",1,",DA(1)=+NAOU,DIC(0)="QEAM" D ^DIC K DIC I $D(DTOUT)!$D(DUOUT) S PSDOUT=1 Q
 Q:Y<0  S PSDR=+Y K DA,DIE,DR S DA(1)=+NAOU,DIE="^PSD(58.8,"_NAOU_",1,",DA=+PSDR,DR="13;I X="""" S Y=""@1"";14;I X'=""O"" S Y=""@1"";14.5;@1" D ^DIE K DIE I $D(Y)!$D(DTOUT) S PSDOUT=1 Q
 S PSDRN=$P($G(^PSDRUG(+PSDR,0)),"^")
 I $P($G(^PSD(58.8,+NAOU,1,+PSDR,0)),"^",14) W !!,PSDRN," is now INACTIVE.",!! G LOOP
 W !!,"This "_PSDRN_" is ACTIVE on "_NAOUN_".",!!
 G LOOP
ASK ;ask inactivation date and reason
 ;clashed with CMOP W ! K DA,DIR,DIRUT S DIR(0)="50,.01O",DIR("A")="Select DRUG",DIR("?")="Enter the DRUG you wish to inactivate in all NAOUs." D ^DIR K DIR I $D(DIRUT) S PSDOUT=1 Q
 K DA,DIC S DIC=50,DIC("S")="I $P($G(^(2)),""^"",3)[""N""",DIC(0)="AQEOM",DIC("A")="Select DRUG: " D ^DIC K DIC S:Y<0 PSDOUT=1 Q:$G(PSDOUT)  S PSDR=+Y,PSDRN=$P(Y,"^",2),(ANS1,ANS2)=""
 W !! K DA,DIR,DIRUT S DIR(0)="58.8001,13" D ^DIR K DIR I $D(DIRUT)!'Y S PSDOUT=1 Q
 S PSDT=Y K DA,DIR,DIRUT,DTOUT,DUOUT S DIR(0)="58.8001,14" D ^DIR K DIR I $D(DUOUT)!$D(DTOUT) S PSDOUT=1 Q
 S ANS1=Y G:ANS1'="O" QUE K DA,DIR,DIRUT,DTOUT,DUOUT S DIR(0)="58.8001,14.5" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S PSDOUT=1 Q
 S ANS2=Y
QUE ;asks queueing information
 S QUE=0 W !! K DA,DIR,DIRUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to queue this job",DIR("?",1)="To queue this job to run at a later time and free up your terminal now,"
 S DIR("?")="accept the default, enter 'N' to run immediately or '^' to quit." D ^DIR K DIR I $D(DIRUT) S PSDOUT=1 W $C(7),!!,"The DRUG you selected will not be inactivated.",!! Q
 I 'Y W !!,"Inactivating now..." G START
 S QUE=1 W !!,"You will be notified by MailMan when the job is completed. ",!!
 S ZTIO="",ZTRTN="START^PSDNSTK",ZTDESC="CS PHARM MASS DRUG INACTIVATION" S (ZTSAVE("PSDR"),ZTSAVE("PSDRN"),ZTSAVE("ANS1"),ZTSAVE("ANS2"),ZTSAVE("QUE"),ZTSAVE("PSDT"),ZTSAVE("PSDSITE"))="" D ^%ZTLOAD K ZTSK Q
START ;
 S CNT=0 F NAOU=0:0 S NAOU=$O(^PSD(58.8,NAOU)) Q:'NAOU  I $P($G(^PSD(58.8,NAOU,0)),"^",3)=+PSDSITE,$P($G(^PSD(58.8,NAOU,0)),"^",2)'="P",$D(^PSD(58.8,NAOU,1,PSDR,0)),$P(^(0),"^",14)="" D DIE S CNT=CNT+1
 I 'QUE W $C(7),!!,PSDRN_" has been inactivated in "_CNT_" NAOU(s).",! Q
MSG ;send mailman message with completed info
 K XMY,^TMP("PSDMSG",$J) D NOW^%DTC S Y=X X ^DD("DD") S RDT=Y S ^TMP("PSDMSG",$J,1,0)="CS PHARM DRUG Inactivation background job has run to completion."
 S ^TMP("PSDMSG",$J,2,0)="Run Date: "_RDT,^TMP("PSDMSG",$J,3,0)="",^TMP("PSDMSG",$J,4,0)="**  "_PSDRN_" has been inactivated as of "_RDT_" in "_CNT_" NAOU(s)."
 S XMSUB="CS PHARM MASS DRUG INACTIVATION SUMMARY",XMDUZ="CONTROLLED SUBSTANCES PHARMACY",XMTEXT="^TMP(""PSDMSG"",$J,",XMY(DUZ)="" S:'$D(XMY) XMY(.5)="" D ^XMD K XMY,^TMP("PSDMSG",$J)
 G END
DIE ;inactivate a Drug for NAOUs
 K DA,DIE,DR S DA(1)=+NAOU,DA=+PSDR,DIE="^PSD(58.8,"_NAOU_",1,",DR="13////"_PSDT_";14////"_ANS1_";14.5////"_ANS2 D ^DIE K DIE,DR
 Q
