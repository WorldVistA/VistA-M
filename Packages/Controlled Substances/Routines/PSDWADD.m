PSDWADD ;BIR/JPW-Add/Delete Ward (for Drug) ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S PSDUZ=DUZ
 W !!,"This option will allow you to add or delete a Ward (for Drug) assignment for",!,"all stock drugs in one or more ACTIVE NAOUs."
ASKAD ;ask for 'Add' or 'Delete'
 K DA,DIR,DIRUT S DIR(0)="SBO^A:ADD;D:DELETE",DIR("A")="Do you wish to ADD or DELETE?"
 S DIR("?",1)="Enter 'A' to ADD a Ward (for Drug), 'D' to DELETE a Ward (for Drug),",DIR("?")="or '^' to quit" D ^DIR K DIR G:$D(DIRUT) END S ANS=Y
 W !!,?5,"You may select a single NAOU, several NAOUs, or enter ^ALL to select all NAOUs.",!
NAOU ;ask NAOU
 K DA,DIC
 F  S DIC=58.8,DIC("A")="Select NAOU: ",DIC(0)="QEA",DIC("S")="I $S('$D(^(""I"")):1,'^(""I""):1,^(""I"")>DT:1,1:0),$P(^(0),""^"",2)=""N"",$P(^(0),""^"",3)=+PSDSITE" D ^DIC K DIC Q:Y<0  S NAOU(+Y)=""
 I '$D(NAOU)&(X'="^ALL") G END
 I X="^ALL" F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $S('$D(^PSD(58.8,PSD,"I")):1,'^("I"):1,^("I")>DT:1,1:0),$P($G(^(0)),"^",2)="N",$P($G(^(0)),"^",3)=+PSDSITE S NAOU(PSD)=""
 G:'$D(NAOU) END
WARD ;ask ward
 W ! S DIC=42,DIC(0)="QEAM",DIC("A")="Select WARD (for Drug) to "_$S(ANS="A":"add",1:"delete")_": " D ^DIC K DIC G:Y<0 END S PSDW=+Y,PSDWN=$P(Y,"^",2)
QUE ;asks queueing information
 S QUE=0 W !! K DA,DIR,DIRUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you want to queue this job",DIR("?",1)="To queue this job to run at a later time and free up your terminal now,"
 S DIR("?")="accept the default, enter 'N' to run immediately or '^' to quit." D ^DIR K DIR I $D(DIRUT) W ! G END
 I 'Y W !!,"Starting the WARD (for Drug) "_$S(ANS="A":"additions",ANS="D":"deletions")_"." G START
 S QUE=1 W !!,"You will be notified by MailMan when the job is completed.",!!
 S ZTIO="",ZTRTN="START^PSDWADD",ZTDESC="CS PHARM WARD (for Drug) ADD/DELETE" S (ZTSAVE("QUE"),ZTSAVE("PSDW"),ZTSAVE("ANS"),ZTSAVE("PSDWN"),ZTSAVE("PSDUZ"))=""
 S:$D(NAOU) ZTSAVE("NAOU(")="" D ^%ZTLOAD K ZTSK G END
START ;add or delete ward (for drug) data
 K ^TMP("PSDWADD",$J) S (CNTD,CNTN,OK)=0 D:ANS="A" ADD D:ANS="D" DEL D:QUE MSG
 I 'QUE W $C(7),!!,"WARD (for Drug) assignment of "_PSDWN_" has been ",$S(ANS="A":"added to",1:"deleted from"),":",!," => Total NAOU(s): "_CNTN_"   => Total Stock Drugs: "_CNTD
END K %,%H,%I,ANS,CNTD,CNTN,DA,DIC,DIE,DIK,DINUM,DIR,DIRUT,DR,PSDRG,DTOUT,DUOUT,PSDL,NAOU,OK,PSD,PSDUZ,QUE,RDT,PSDW,PSDWN
 K X,XMDUZ,XMSUB,XMTEXT,XMY,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK S:$D(ZTQUEUED) ZTREQ="@"
 Q
ADD ;add ward (for drug)
 F PSDL=0:0 S PSDL=$O(NAOU(PSDL)) S:OK CNTN=CNTN+1 Q:'PSDL  S OK=0 I $S('$D(^PSD(58.8,PSDL,"I")):1,'^("I"):1,^("I")>DT:1,1:0),$S($P($G(^(0)),"^",2)'="P":1,1:0) D
 .F PSDRG=0:0 S PSDRG=$O(^PSD(58.8,PSDL,1,PSDRG)) Q:'PSDRG  I '$D(^PSD(58.8,PSDL,1,PSDRG,1,PSDW,0)) D
 ..I '$D(^PSD(58.8,PSDL,1,PSDRG,1,0)) S ^(0)="^58.800115PA^^"
 ..K DA,DIC S (DA,DINUM)=PSDW,X="`"_PSDW,DA(1)=PSDRG,DA(2)=PSDL,DIC="^PSD(58.8,"_PSDL_",1,"_PSDRG_",1,",DIC(0)="LNX",DLAYGO=58.8 D ^DIC K DIC,DLAYGO S CNTD=CNTD+1,OK=1 W:'QUE "."
 Q
DEL ;delete ward (for drug)
 F PSDL=0:0 S PSDL=$O(NAOU(PSDL)) S:OK CNTN=CNTN+1 Q:'PSDL  S OK=0 I $S('$D(^PSD(58.8,PSDL,"I")):1,'^("I"):1,^("I")>DT:1,1:0),$S($P($G(^(0)),"^",2)'="P":1,1:0) D
 .F PSDRG=0:0 S PSDRG=$O(^PSD(58.8,PSDL,1,PSDRG)) Q:'PSDRG  I $D(^PSD(58.8,PSDL,1,PSDRG,1,PSDW,0)) D
 ..K DA,DIK,DR S DA(2)=PSDL,DA(1)=PSDRG,DA=PSDW,DIK="^PSD(58.8,"_DA(2)_",1,"_PSDRG_",1,",DR="15///@" D ^DIK K DIK S CNTD=CNTD+1,OK=1 W:'QUE "."
 Q
MSG ;send mailman message with completed info
 K XMY,^TMP("PSDWAMSG",$J) D NOW^%DTC S Y=X X ^DD("DD") S RDT=Y S ^TMP("PSDWAMSG",$J,1,0)="CS PHARM WARD (for Drug) "_$S(ANS="A":"ADDITION",1:"DELETION")_" background job has run to completion."
 S ^TMP("PSDWAMSG",$J,2,0)="Run Date: "_RDT,^TMP("PSDWAMSG",$J,3,0)=""
 S ^TMP("PSDWAMSG",$J,4,0)="WARD (for Drug) assignment of "_PSDWN_" has been "_$S(ANS="A":"Added to",1:"Deleted from")_":"
 S ^TMP("PSDWAMSG",$J,5,0)="=> Total NAOU(s): "_CNTN_"     => Total Stock Drugs: "_CNTD
 S XMSUB="CS PHARM MASS WARD (for Drug) "_$S(ANS="A":"ADDITION",1:"DELETION")_" SUMMARY",XMTEXT="^TMP(""PSDWAMSG"",$J,",XMDUZ="CONTROLLED SUBSTANCES PHARMACY",XMY(PSDUZ)=""
 S:'$D(XMY) XMY(.5)="" D ^XMD K XMY,^TMP("PSDWAMSG",$J)
 Q
