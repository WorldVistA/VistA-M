PSDDWK ;BIR/JPW-Pharm Dispensing Worksheet ;6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;**59,69**;13 Feb 97;Build 13
 ;References to ^PSD(58.8, supported by DBIA2711
 ;References to ^PSDRUG( supported by DBIA #221
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,$D(^XUSEC("PSD TECH ADV",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"process/dispense narcotic supplies.",!!,"PSJ RPHARM, PSJ PHARM TECH or PSD TECH ADV security key required.",! K OK Q
 I $P($G(^VA(200,DUZ,20)),U,4)']"" N XQH S XQH="PSD ESIG" D EN^XQH Q
 I '$O(^PSD(58.85,0)) W $C(7),!!,"There are no pending request orders.",!! Q
 S (PSDNO,NOFLAG)=0
ASKD ;ask dispensing location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 I $P(PSDSITE,U,5) S OKD=1,NODED=^PSD(58.8,+PSDS,0) G SETD
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)=""M"":1,$P(^(0),""^"",2)=""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 ;set PSDS=disp.site,PSDM=ask mfg/lot#/exp.date,SITE=inpat.site,PSDAG=auto gen.disp.#s,PSDRG=using form 10-179,PSDGS=print green sheet
 S PSDS=+Y,PSDSN=$P(Y,"^",2),NODED=Y(0)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
SETD S PSDM=+$P(NODED,"^",5),PSDAG=+$P($G(^PSD(58.8,+PSDS,2)),"^")
 S PSDRG=+$P($G(^PSD(58.8,+PSDS,2)),"^",5),PSDGS=+$P($G(^PSD(58.8,+PSDS,2)),"^",6)
 I '$D(^PSD(58.85,"AW",+PSDS)) D MSG G END
ASKM ;ask method of dispensing - by worksheet or individual request
 K DA,DIR,DIRUT S DIR(0)="SOB^W:Worksheet;R:Individual Request",DIR("A")="Dispensing Method"
 S DIR("?",1)="Enter 'W' to dispense by last worksheet printed, enter 'R' to",DIR("?")="dispense by individual request, or '^' to quit"
 D ^DIR K DIR G:$D(DIRUT) END S ANS=Y
 S PSDOUT=0 N X,X1 D SIG^XUSESIG G:X1="" END D:ANS="R" REQ D:ANS="W" WK
 I 'NOFLAG D MSG
END K %,%H,%I,%ZIS,ACT,ALL,ANS,BAL,CNT,COMM,DA,DIC,DIE,DIR,DIROUT,DIRUT,DIWF,DIWL,DIWR,DR,DTOUT,DUOUT,EXP,EXPD,FLAG
 K LN,LOOP,LOT,MFG,MSG,NAOU,NAOUN,NBKU,NEW,NODE,NODED,NOFLAG,NPKG,NSITE,OK,OKD,ORD,ORDN,ORDS,ORDSN,PAT,PSDLCK
 K PRT,PSD,PSDAG,PSDAGN,PSDBY,PSDBYN,PSDDT,PSDG,PSDGS,PSDGSN,PSDIO,PSDLES,PSDM,PSDMN,PSDN,PSDNA,PSDNO,PSDOUT,PSDPN
 K PSDR,PSDRN,PSDREC,PSDRG,PSDRGN,PSDRN,PSDS,PSDSN,PSDT,PSDUZA,QTY,REQ,REQD,REQDT,SITE,STAT,TECH,TEXT,WORD,X,Y
 Q
WK ;compile worksheet dispensing data
 W !!,"Accessing worksheet information..."
 F PSD=0:0 S PSD=$O(^PSD(58.85,"AW",+PSDS,PSD)) Q:('PSD)!(PSDOUT)  D
 .F PSDN=0:0 S PSDN=$O(^PSD(58.85,"AW",+PSDS,PSD,PSDN)) Q:('PSDN)!(PSDOUT)  I $D(^PSD(58.85,PSDN,0)) D SET Q:PSDLCK  D:STAT<3&($D(^PSD(58.8,+$G(ORDS),1,+$G(PSDR)))) ^PSDDWK1,PSDLCK Q:PSDOUT  ;; PSD*3*59 ADDED PSDLCK
 Q
REQ ;dispense by individual request
 W !!,"Accessing worksheet information..."
 F PSD=0:0 S PSD=$O(^PSD(58.85,"AW",+PSDS,PSD)) Q:'PSD  F PSDN=0:0 S PSDN=$O(^PSD(58.85,"AW",+PSDS,PSD,PSDN)) Q:'PSDN  I $D(^PSD(58.85,PSDN,0)),$P(^(0),"^",7)<3 S NOFLAG=1
 Q:'NOFLAG
 K DA,DIC W ! S DIC=58.85,DIC(0)="QEA",DIC("A")="Select Request #: ",DIC("S")="I $P(^(0),""^"",2)=+PSDS,$P(^(0),""^"",7)<3" D ^DIC K DIC Q:Y<0  S PSDN=+Y D SET
 I PSDLCK W !!,"This request is currently being processed by ",$P(^VA(200,$P(^XTMP("PSDLCK",PSDN,0),"^",3),0),"^") G REQ  ;; PSD*3*59 LOCK MESSAGE
 I STAT>2 W !!,"The status of this request is "_$P($G(^PSD(58.82,STAT,0)),"^")_".",!,"You cannot edit this request using this option.",! G REQ
 D ^PSDDWK1,PSDLCK Q:PSDOUT  ;; PSD*3*59 ADDED PSDLCK
 G REQ
SET ;sets data for display/editing
 Q:'$D(^PSD(58.85,PSDN,0))  S NODE=^(0),(NSITE,PSDMN,PSDAGN,PSDRGN,PSDGSN)=0
 ;; PSD*3*59  LOCK RECORD
 S PSDLCK=0
 S STAT=+$P(NODE,"^",7) Q:STAT>2  S PSDRN=+$P(NODE,"^",5)
 L +^PSD(58.85,PSDN):0
 S:'$T PSDLCK=1 Q:PSDLCK
 S ^XTMP("PSDLCK",PSDN,0)=$$FMADD^XLFDT(DT,1,0,0,0)_"^"_DT_"^"_DUZ ;; END PSD*3*59
 S NAOU=+$P(NODE,"^",3),NAOUN=$S($P($G(^PSD(58.8,NAOU,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_NAOU)
 S PSDR=+$P(NODE,"^",4),PSDRN=$S($P($G(^PSDRUG(PSDR,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_PSDR)
 S ORDS=+$P(NODE,"^",2),ORDSN=$P($G(^PSD(58.8,+ORDS,0)),"^")
 S PSDUZA=+$P(NODE,"^",19)
 S REQ=+$P(NODE,"^",5),REQDT=$P(NODE,"^",18) I REQDT S Y=$E(REQDT,1,7) X ^DD("DD") S REQD=Y
 S QTY=$S($P(NODE,"^",17):$P(NODE,"^",17),1:$P(NODE,"^",6)),PSDPN=$P(NODE,"^",15),PSDT=$P(NODE,"^",14) I PSDT S Y=$E(PSDT,1,7) X ^DD("DD") S PSDDT=Y
 S ORD=+$P(NODE,"^",12),ORDN=$P($G(^VA(200,+ORD,0)),"^"),PSDBY=+$P(NODE,"^",13),PSDBYN="" I PSDBY S PSDBYN=$P($G(^VA(200,PSDBY,0)),"^")
 S PAT=$P($G(^PSD(58.85,PSDN,2)),U,3)
 I $D(^XUSEC("PSJ RPHARM",DUZ)),'PSDBY S PSDBY=DUZ,PSDBYN=$P($G(^VA(200,PSDBY,0)),"^")
 S (MFG,LOT,EXP,EXPD,NBKU,NPKG)=""
 I $D(^PSD(58.8,+ORDS,1,PSDR,0)) S MFG=$P(^(0),"^",10),LOT=$P(^(0),"^",11),EXP=$P(^(0),"^",12),NBKU=$P(^(0),"^",8),NPKG=+$P(^(0),"^",9) I EXP S Y=EXP X ^DD("DD") S EXPD=Y
 Q
MSG W $C(7),!!,"There are no pending CS requests for ",PSDSN,".",!
 W !,"Press <RET> to return to the menu" R X:DTIME W !!
 Q
PSDLCK ;; PSD*3*59 CLEAR LOCKS FOR THIS ORDER
 L -^PSD(58.85,PSDN)
 K ^XTMP("PSDLCK",PSDN),STAT
 Q
