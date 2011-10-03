PSDADJIN ;B'ham ISC/LTL,JPW - Balance Initializer for NAOU ; 16 Feb 94
 ;;3.0; CONTROLLED SUBSTANCES ;**66**;13 Feb 97;Build 3
 I '$D(PSDSITE) D ^PSDSET G:'$D(PSDSITE) QUIT
 N D1,D2,DIC,DIE,DINUM,D0,D1,DLAYGO,DR,DIR,DIRUT,DTOUT,DUOUT,NODE,PSAC,PSDAT,PSDLOC,PSDLOCN,DA,PSDRUG,PSDRUGN,PSDS,PSDPKG,PSDBKU,PSAQ,PSDR,PSDREC,PSDT,X,Y,%,%H,%I
LOOK S DIC="^PSD(58.8,",DIC(0)="AEMQZ",DIC("A")="Select NAOU: ",DIC("S")="I $P($G(^(0)),U,3)=+PSDSITE,$P($G(^(0)),U,2)[""N"",'$P(^(0),""^"",7),$S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0)"
 D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<1) QUIT S PSDLOC=+Y,PSDLOCN=$P(Y,U,2),PSDS=+$P(Y(0),"^",4)
 I '+$P($G(^PSD(58.8,PSDLOC,2)),"^",5) W !!,"This NAOU does not maintain a perpetual inventory balance to initialize.",!! K PSDLOC,PSDLOCN,PSDS G LOOK
CHKD I '$O(^PSD(58.8,PSDLOC,1,0)) W !!,"There are no drugs in ",PSDLOCN G QUIT
 S DIR(0)="Y",DIR("A",1)="This option will set all balances to zero before initializing.",DIR("A")="Are you sure you want to proceed"
 D ^DIR K DIR G:Y'=1 QUIT
 W !!,"Give me a second to alphabetize.",!
 S PSDRUG=0,PSDRUGN=""
 F  S PSDRUG=$O(^PSD(58.8,PSDLOC,1,PSDRUG)) Q:'PSDRUG  D
 .Q:'$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,0))!($P($G(^PSDRUG(+PSDRUG,0)),"^")']"")
 .S PSDPKG=$P($G(^PSD(58.8,+PSDS,1,+PSDRUG,0)),"^",9),PSDBKU=$P($G(^(0)),"^",8)
 .S ^TMP("PSDB",$J,$P($G(^PSDRUG(+PSDRUG,0)),U),PSDRUG)=PSDPKG_"^"_PSDBKU,$P(^PSD(58.8,+PSDLOC,1,+PSDRUG,0),U,4)=0 K Y
 W @IOF
 F PSAC=1:1 S PSDRUGN=$O(^TMP("PSDB",$J,PSDRUGN)) Q:PSDRUGN']""  S PSDRUG=$O(^TMP("PSDB",$J,PSDRUGN,0)) D  G:$D(DIRUT) QUIT
 .Q:'$G(^PSD(58.8,PSDLOC,1,PSDRUG,0))
 .;S (PSD,PSD(1))=0
 .;F  S PSD=$O(^PSD(58.81,"AD",4,+PSDLOC,PSD)) S:$P($G(^PSD(58.81,+PSD,0)),U,5)=PSDRUG PSD(1)=1 Q:$G(PSD(1))!('PSD)
 .;Q:'$G(PSD(1))
 .S NODE=$G(^TMP("PSDB",$J,PSDRUGN,PSDRUG))
 .S DIE="^PSD(58.8,+PSDLOC,1,",DA(1)=PSDLOC,DA=PSDRUG
 .F  L +^PSD(58.8,+PSDLOC,1,+PSDRUG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .D NOW^%DTC S PSDAT=+%
 .W !!,PSDRUGN,!!,"Package Size: ",$P($G(NODE),"^"),"  Breakdown Unit: ",$P($G(NODE),"^",2),!
 .S DIR(0)="NA^0:999999:2",DIR("A")="Initial Balance: " D ^DIR K DIR
 .Q:$D(DIRUT)  S PSDREC=Y
 .S DR="3////"_PSDREC D ^DIE
 .S $P(^PSD(58.8,PSDLOC,1,PSDRUG,0),"^",17)=1
 .L -^PSD(58.8,+PSDLOC,1,+PSDRUG,0)
 .Q:$G(PSDREC)']""
MON .S:'$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,5,0)) ^(0)="^58.801A^^"
 .I '$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,5,$E(DT,1,5)*100,0)) S DIC="^PSD(58.8,+PSDLOC,1,+PSDRUG,5,",DIC(0)="LM",DLAYGO=58.8,(X,DINUM)=$E(DT,1,5)*100,DA(2)=PSDLOC,DA(1)=PSDRUG D ^DIC K DIC,DLAYGO
 .S DIE="^PSD(58.8,+PSDLOC,1,+PSDRUG,5,",DA(2)=PSDLOC,DA(1)=PSDRUG,DA=$E(DT,1,5)*100,DR="1////0;7////^S X=PSDREC" D ^DIE
 .W !!,"Updating beginning balance and transaction history.",!
TR .F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND .S PSDT=$P(^PSD(58.81,0),U,3)+1 I $D(^PSD(58.81,PSDT)) S $P(^PSD(58.81,0),U,3)=$P(^PSD(58.81,0),U,3)+1 G FIND
 .S DIC="^PSD(58.81,",DIC(0)="L",DLAYGO=58.81,(DINUM,X)=PSDT D ^DIC K DIC,DLAYGO L -^PSD(58.81,0)
 .S DIE="^PSD(58.81,",DA=PSDT,DR="1////11;2////^S X=PSDLOC;3////^S X=PSDAT;4////^S X=PSDRUG;5////^S X=PSDREC;6////^S X=DUZ;9////0;100////1" D ^DIE K DIE
 .S:'$D(^PSD(58.8,+PSDLOC,1,+PSDRUG,4,0)) ^(0)="^58.800119PA^^"
 .S DIC="^PSD(58.8,+PSDLOC,1,+PSDRUG,4,",DIC(0)="L",DLAYGO=58.8
 .S (X,DINUM)=PSDT,DA(2)=PSDLOC,DA(1)=PSDRUG D ^DIC K DIC,DA,DLAYGO,Y
REP S DIR(0)="Y",DIR("A")="Would you like a report of current balances"
 S DIR("B")="Yes" D ^DIR K DIR D:Y=1
 .S NAOU=PSDLOC,NAOUN=PSDLOCN D DEV^PSDBAN
QUIT K ^TMP("PSDB",$J) Q
