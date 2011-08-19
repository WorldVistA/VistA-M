PSSCREAT ;BIR/RTR/WRT-Auto create Pharmacy Orderable Item File; 09/01/98 7:07
 ;;1.0;PHARMACY DATA MANAGEMENT;**8,15**;9/30/97
CHECK ; make sure file has not already been created"
 S PSSITE=+$O(^PS(59.7,0)) I $P($G(^PS(59.7,+PSSITE,80)),"^",2) W !!?3,"Orderable Item Auto-Create has ",$S($P(^(80),"^",2)=1:"already been queued,",1:"already been completed,")," no action taken!",! K PSSITE D  Q
 .K DIR S DIR("A")="Press RETURN to continue",DIR(0)="E" D ^DIR K DIR
 S $P(^PS(59.7,PSSITE,80),"^",2)=1
PRI K DIR W !!,"This job will create your Pharmacy Orderable Item File, and match IV Solutions,",!,"IV Additives, and Dispense Drugs to the Pharmacy Orderable Item File."
 S DIR("A",1)="Enter P to create your Pharmacy Orderable Item File first by Primary Drug",DIR("A",2)="Name, then by VA Generic Name",DIR("A",3)="Enter V to create the Pharmacy Orderable Item File by VA Generic Name only"
 S DIR("A",4)="",DIR("A")="Enter P or V"
 S DIR(0)="S^P:PRIMARY/VA GENERIC;V:VA GENERIC" D ^DIR K DIR I Y["^"!($D(DTOUT))!($D(DUOUT)) S $P(^PS(59.7,PSSITE,80),"^",2)="" G ENDTWO
 S PSOHOW=Y
 W !,"This job should be queued to run at night!",!
 D NOW^%DTC K %DT S %DT="FRAEX",%DT(0)=%,%DT("A")="QUEUE TO RUN AT WHAT TIME: " D ^%DT S PSOQTIME=Y I $D(DTOUT)!(Y=-1) W !!,"Try again later!",! S $P(^PS(59.7,PSSITE,80),"^",2)="" G ENDTWO
 S PSOMDUZ=DUZ,ZTIO="",ZTRTN="BEG^PSSCREAT",ZTDTH=PSOQTIME,ZTDESC="AUTO CREATE ORDERABLE ITEM FILE",ZTSAVE("PSCREATE")="",ZTSAVE("PSOHOW")="",ZTSAVE("PSOMDUZ")="",ZTSAVE("PSSITE")="" D ^%ZTLOAD W !!,"TASK QUEUED!",! G ENDTWO
BEG ;
 S PSCREATE=1
 I PSOHOW="P" D ^PSSSPD G START
 D IVADD^PSSSPD
START K ^TMP("PSSD",$J),^TMP("PSS",$J),^TMP("PSSADD",$J),^TMP("PSSOL",$J)
 F RRR=0:0 S RRR=$O(^PSDRUG(RRR)) Q:'RRR  S (FLAGONE,FLAGTWO)=0 D  D:$G(FLAGONE) MATCH D:$G(FLAGTWO) ADD
 .S NODE=$G(^PSDRUG(RRR,"ND")),SUPER=$P($G(^PSDRUG(RRR,2)),"^"),DA=$P($G(NODE),"^"),K=$P($G(NODE),"^",3),X=$$PSJDF^PSNAPIS(DA,K),DF1=X,DA=$P($G(NODE),"^"),X=$$VAGN^PSNAPIS(DA),GEN=X
 .I +SUPER Q
 .K ^TMP($J,"PSSIP") I +$P(NODE,"^"),+$P(NODE,"^",3) F VV=0:0 S VV=$O(^PSDRUG("AND",+NODE,VV)) Q:'VV  I +$P($G(^PSDRUG(VV,2)),"^"),$D(^PS(50.7,$P(^PSDRUG(VV,2),"^"),0)) D
 ..S OTH=$G(^PSDRUG(VV,"ND")) I +$P(OTH,"^"),+$P(OTH,"^",3),$G(DF1) S DA=$P($G(OTH),"^"),K=$P($G(OTH),"^",3),X=$$PSJDF^PSNAPIS(DA,K),DF2=X I $G(DF2) D
 ...I $G(DF1)=$G(DF2) S ^TMP($J,"PSSIP",VV)=$P(^PSDRUG(VV,2),"^")
 .S (COMM,COMMON)=0 I $O(^TMP($J,"PSSIP",0)) S COMM=1 S CC=$O(^TMP($J,"PSSIP",0)),SPRIM=^TMP($J,"PSSIP",CC) F WW=0:0 S WW=$O(^TMP($J,"PSSIP",WW)) Q:'WW  I SPRIM'=^TMP($J,"PSSIP",WW) S COMMON=1
 .I COMM,COMMON Q
 .I COMM,'COMMON S FLAGONE=1 Q
 .I +$P(NODE,"^"),+$P(NODE,"^",3),$G(GEN)'=0,$G(DF1) D
 ..I $L(GEN)<41 S SPNAME=GEN,SPNTR=$P(DF1,"^"),FLAGTWO=1 Q
END D ENDONE D DATE^PSSPOIM1 K RRR,STOP,^TMP($J,"PSSIP") D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
MATCH ;Match to an already existing Orderable Item
 S DA=RRR,DIE="^PSDRUG(",DR="2.1////"_SPRIM D ^DIE D ENDONE Q
ADD ;Create a new Orderable Item entry
 S STOP=0 F CHECK=0:0 S CHECK=$O(^PS(50.7,"ADF",SPNAME,SPNTR,CHECK)) Q:'CHECK!(STOP)  I CHECK,$P($G(^PS(50.7,CHECK,0)),"^",3)="" S STOP=1,DIE="^PSDRUG(",DA=RRR,DR="2.1////"_CHECK D ^DIE D ENDONE Q
 I STOP K STOP Q
 K DD,DO S X=SPNAME,DIC="^PS(50.7,",DIC(0)="L",DIC("DR")=".02////"_SPNTR D FILE^DICN I 'Y D ENDONE Q
 S SPIEN=+Y S DIE="^PSDRUG(",DA=RRR,DR="2.1////"_SPIEN D ^DIE
ENDONE K APP,CC,CHECK,COMM,COMMON,DA,DR,DIE,DIC,FLAGONE,FLAGTWO,NODE,OTH,PSDOS,PSOQTIME,SPIEN,SPNAME,SPNTR,SPRIM,SUPER,VV,WW Q
 ;
MAIL ;
 S PSSADATE=DT F TTTT=0:0 S TTTT=$O(^PS(50.7,TTTT)) Q:'TTTT  D
 .I '$P($G(^PS(50.7,TTTT,0)),"^",3) D
 ..S (PSSLTST,PSSIFLAG)=0 F JJJJ=0:0 S JJJJ=$O(^PSDRUG("ASP",TTTT,JJJJ)) Q:'JJJJ  S PSSIOU=$P($G(^PSDRUG(JJJJ,2)),"^",3) I PSSIOU["I"!(PSSIOU["O")!(PSSIOU["U") S PSSVARP=+$P($G(^PSDRUG(JJJJ,"I")),"^") D
 ...S:PSSVARP&(PSSVARP>PSSLTST) PSSLTST=PSSVARP I 'PSSVARP S PSSIFLAG=1
 .I '$P($G(^PS(50.7,TTTT,0)),"^",3),'$P($G(^(0)),"^",4),'PSSIFLAG K DIE S DIE="^PS(50.7,",DA=TTTT,DR=".04////"_$S('PSSLTST:PSSADATE,1:PSSLTST) D ^DIE K DIE
 .I $P($G(^PS(50.7,TTTT,0)),"^",3) D
 ..S (PSSLTST,PSSIFLAG)=0 F JJJJ=0:0 S JJJJ=$O(^PS(52.6,"AOI",TTTT,JJJJ)) Q:'JJJJ  I $D(^PS(52.6,JJJJ,0)) S PSSVARP=+$P($G(^("I")),"^") D
 ...S:PSSVARP&(PSSVARP>PSSLTST) PSSLTST=PSSVARP I 'PSSVARP S PSSIFLAG=1
 ..F JJJJ=0:0 S JJJJ=$O(^PS(52.7,"AOI",TTTT,JJJJ)) Q:'JJJJ  I $D(^PS(52.7,JJJJ,0)) S PSSVARP=+$P($G(^("I")),"^") D
 ...S:PSSVARP&(PSSVARP>PSSLTST) PSSLTST=PSSVARP I 'PSSVARP S PSSIFLAG=1
 .I $P($G(^PS(50.7,TTTT,0)),"^",3),'$P($G(^(0)),"^",4),'PSSIFLAG K DIE S DIE="^PS(50.7,",DA=TTTT,DR=".04////"_$S('PSSLTST:PSSADATE,1:PSSLTST) D ^DIE K DIE
 K PSSVARP,PSSIOU,PSSADATE,TTTT,JJJJ,PSSIFLAG,PSSLTST D ^PSSSYN K NUM,NUMB,POI,SYNO
 ;
 S XMDUZ="PHARMACY DATA MANAGEMENT PACKAGE",XMY(.5)="",XMY(PSOMDUZ)="",XMSUB="Pharmacy Orderable Item Auto-Create"
 S PSSATEXT(1)="The Pharmacy Orderable Item Auto-create has successfully run to",PSSATEXT(2)="Completion! You may now begin the manual matching process."
 S XMTEXT="PSSATEXT(" D ^XMD S:'$G(PSSITE) PSSITE=+$O(^PS(59.7,0)) S $P(^PS(59.7,PSSITE,80),"^",2)=2 Q
ENDTWO D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K PSOMDUZ,PSSITE Q
