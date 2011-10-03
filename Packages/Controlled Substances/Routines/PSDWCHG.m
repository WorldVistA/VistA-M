PSDWCHG ;BIR/JPW-CS Mass Ward (for Drug) Transfer ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S PSDUZ=DUZ
 W !!,"This routine will allow you to do a mass conversion of all drugs in an ",!,"active NAOU from an old Ward designation to a new Ward designation."
 W !!,"You may convert a single NAOU, several NAOUs, or enter ^ALL to convert",!,"all NAOUs.",!!
NAOU ;ask NAOU
 K DA,DIC
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",$P(^(0),""^"",3)=+PSDSITE" D ^DIC K DIC Q:Y<0  S NAOU(+Y)=""
 I '$D(NAOU)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,^("I")>DT:1,1:0),$P($G(^(0)),"^",2)="N",$P($G(^(0)),"^",3)=+PSDSITE S NAOU(PSD)=""
 G:'$D(NAOU) END
OLD ;asking for old (current) WARD (FOR DRUG)
 K DA,DIR,DIRUT S DIR(0)="PO^42:EM",DIR("A")="Select OLD WARD",DIR("?")="Enter the Ward that currently exists in the WARD (FOR DRUG) field." D ^DIR K DIR I (Y<0)!$D(DIRUT) G END
 S OLD=+Y,OLDN=$P(Y,"^",2)
NEW ;asking new (replacement) WARD (FOR DRUG)
 K DA,DIR,DIRUT S DIR(0)="PO^42:EM",DIR("A")="Select NEW WARD",DIR("?")="Enter the new Ward you wish to replace "_OLDN D ^DIR K DIR I $D(DIRUT)!(Y<0) W !,"No Action Taken",! G END
 S NEW=+Y,NEWN=$P(Y,"^",2)
QUE ;asks queueing information
 S QUE=0 W !! K DA,DIR,DIRUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to queue this job",DIR("?",1)="To queue this job to run at a later time and free up your terminal now,"
 S DIR("?")="accept the default, enter 'N' to run immediately or '^' to quit." D ^DIR K DIR I $D(DIRUT) W $C(7),!!,"The WARD change you selected will not be updated.",!! G END
 I 'Y W !!,"Converting WARD (for Drug) now..." G START
 S QUE=1 W !!,"You will be notified by MailMan when the job is completed.",!!
 S ZTIO="",ZTRTN="START^PSDWCHG",ZTDESC="CS MASS WARD CONVERSION" S (ZTSAVE("OLD"),ZTSAVE("OLDN"),ZTSAVE("NEW"),ZTSAVE("NEWN"),ZTSAVE("QUE"),ZTSAVE("PSDUZ"))="" S:$D(NAOU) ZTSAVE("NAOU(")="" D ^%ZTLOAD K ZTSK G END
START ;loop to update ward conversion
 K ^TMP("PSDWCHG",$J) S (CNTN,CNTD)=0
 F PSDRG=0:0 S PSDRG=$O(^PSD(58.8,"D",PSDRG)) Q:'PSDRG  F LOC=0:0 S LOC=$O(^PSD(58.8,"D",PSDRG,OLD,LOC)) Q:'LOC  I $D(NAOU(LOC)),$P($G(^PSD(58.8,LOC,0)),"^",2)'="P",$D(^PSD(58.8,LOC,1,PSDRG,0)) S ^TMP("PSDWCHG",$J,LOC,PSDRG)=""
 I $D(^TMP("PSDWCHG",$J)) F LOC=0:0 S LOC=$O(^TMP("PSDWCHG",$J,LOC)) Q:'LOC  S CNTN=CNTN+1 F PSDRG=0:0 S PSDRG=$O(^TMP("PSDWCHG",$J,LOC,PSDRG)) Q:'PSDRG  S CNTD=CNTD+1 D CHG
 K ^TMP("PSDWCHG",$J) D:QUE MSG
 I 'QUE W $C(7),!!,"Total Stock Drugs converted: ",CNTD,!,"Total NAOU(s) converted: ",CNTN,!
END K %,%H,%I,CNTD,CNTN,DA,DIC,DIE,DIR,DIR,DIRUT,DR,DTOUT,DUOUT,JJ,LOC,NAOU,NEW,NEWN,OLD,OLDN
 K PSD,PSDA,PSDOUT,PSDR,PSDRG,PSDUZ,QUE,RDT,SUB,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,^TMP("PSDWCHG",$J)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
CHG ;change wards
 K DA,DIK S DA(2)=LOC,DA(1)=PSDRG,DA=OLD,DIK="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",1," D ^DIK K DIK
 I '$D(^PSD(58.8,LOC,1,PSDRG,1,NEW,0)) K DA S DA(2)=LOC,DA(1)=PSDRG,DA=NEW,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",1,",DR=".01////"_NEW D ^DIE K DIE W:'QUE "."
 S SUB=0 F JJ=0:0 S JJ=$O(^PSD(58.8,LOC,1,PSDRG,1,JJ)) Q:'JJ  S SUB=SUB+1
 S $P(^PSD(58.8,LOC,1,PSDRG,1,0),"^",3,4)=NEW_"^"_SUB
 Q
MSG ;send mailman message with completed info
 K XMY,^TMP("PSDWCMSG",$J) D NOW^%DTC S Y=X X ^DD("DD") S RDT=Y S ^TMP("PSDWCMSG",$J,1,0)="CS PHARM Conversion background job has run to completion.",^TMP("PSDWCMSG",$J,2,0)="Run Date: "_RDT,^TMP("PSDWCMSG",$J,3,0)=""
 S ^TMP("PSDWCMSG",$J,4,0)="Old Ward: "_OLDN_" converted to New Ward: "_NEWN,^TMP("PSDWCMSG",$J,5,0)="Total number of NAOU(s) converted: "_CNTN
 S ^TMP("PSDWCMSG",$J,6,0)="Total number of Stock Drugs converted: "_CNTD
 S XMSUB="CS PHARM MASS WARD CONVERSION SUMMARY",XMTEXT="^TMP(""PSDWCMSG"",$J,",XMDUZ="CONTROLLED SUBSTANCES PHARMACY",XMY(PSDUZ)="" S:'$D(XMY) XMY(.5)="" D ^XMD K XMY,^TMP("PSDWCMSG",$J)
 Q
