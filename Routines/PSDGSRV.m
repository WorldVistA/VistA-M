PSDGSRV ;BIR/JPW-Review and Complete Green Sheet ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;**28,30,71**;13 Feb 97;Build 29
 ;References to ^PSDRUG( are covered by DBIA221
 ;Reference to PSD(58.8 supported by DBIA # 2711
 ;Reference to PSD(58.81 supported by DBIA # 2808
 ;Reference to VA(200 supported by DBIA # 10060
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,$D(^XUSEC("PSD TECH ADV",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to complete",!,?12,"Green Sheets.  PSJ RPHARM, PSJ PHARM TECH or PSD TECH ADV security",!?12,"key required.",! K OK Q
 I $P($G(^VA(200,DUZ,20)),U,4)']"" N XQH S XQH="PSD ESIG" D EN^XQH Q
 N X,X1 D SIG^XUSESIG Q:X1=""
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) GS
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
GS ;select green sheet #
 W !!,"Complete a Green Sheet" S PSDUZ=DUZ,PSDUZN=$P($G(^VA(200,PSDUZ,0)),"^")
 W ! K DA,DIC S DIC("A")="Select the Green Sheet #: ",DIC("S")="I $P(^(0),""^"",3)=+PSDS,$P(^(0),""^"",11)<10!($P(^(0),U,11)=13)!($P(^(0),U,11)=12)",DIC=58.81,DIC(0)="QEASZ",D="D"
 D IX^DIC K DIC G:Y<0 END S PSDA=+Y,NODE=Y(0)
 S STAT=+$P(NODE,"^",11),PSDPN=$P(NODE,"^",17),STATN="" I STAT S STATN=$P($G(^PSD(58.82,STAT,0)),"^")
 I (STAT<4)!(STAT>8)!(STAT=7)&(STAT'=13)&(STAT'=12) W !!,"This order has a status of "_$S(STATN]"":STATN,1:"UNKNOWN")_".",! D MSG G END
 I STAT=4 D QUES G:NOK GS
 S ORD=+$P(NODE,"^",20),NAOU=+$P(NODE,"^",18),PSDR=+$P(NODE,"^",5),PSDRN=$P($G(^PSDRUG(PSDR,0)),"^"),(COMP,OCOMP)=+$P(NODE,"^",12),QTY=+$P(NODE,"^",6)
 S CPBY=+$P($G(^PSD(58.81,PSDA,1)),"^",14)
 I $D(^PSD(58.81,PSDA,4)),+$P(^(4),"^",3) S QTY=$P(^(4),"^",3)
 S NBKU=$P($G(^PSD(58.8,+PSDS,1,+PSDR,0)),"^",8)
START ;start processing
 S PSDOUT=0
 W ! K DA,DIC S DIC=58.83,DIC(0)="QEA",DIC("A")="Select Completion Status: " S:COMP DIC("B")=COMP S:'$D(^XUSEC("PSJ RPHARM",PSDUZ))&'$D(^XUSEC("PSD TECH ADV",PSDUZ)) DIC("S")="I $S(Y=2:0,Y=3:0,1:1)"
 D ^DIC K DIC I Y<0 G END
 S COMP=+Y,CSTAT=$S(COMP=1:7,COMP=2:7,COMP=3:7,1:8)
 ;perpetual inventory?
 S:$G(COMP)=1&($P($G(^PSD(58.8,$G(NAOU),2)),U,5))&('$P($G(^PSD(58.8,+PSDS,1,+PSDR,7)),U,3)) CSTAT=13
 K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Is this OK",DIR("?",1)="Answer 'YES' to update the status",DIR("?")="or 'NO' to select another status."
 S DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT) END I 'Y G START
 I (COMP=3)!(COMP=2) G ^PSDGSRV1
UPDATE ;up 58.81
 W !!,"Accessing Green Sheet information...",!
 D NOW^%DTC S (RECDT,Y)=+%
 ;
 ;PSD*3*30 (DAVE B) added next part to reset global if user
 ;up-arrows or times out.
 S PSD10=$P($G(^PSD(58.81,PSDA,0)),"^",11) ;Order Status
 S PSD11=$P($G(^PSD(58.81,PSDA,0)),"^",12) ;Completion Status
 S NURSE=$P($G(^PSD(58.81,PSDA,1)),"^",10)
 K DA,DIE,DR S DA=PSDA,DIE=58.81,DR="I NURSE S Y=22;29;22////"_+$E(RECDT,1,12)_";33////"_PSDUZ_";10////"_CSTAT_";11////"_COMP_";I X'=6 S Y=""@1"";72;@1"
 D ^DIE K DA,DIE,DR S PSDDT=$P($G(^PSD(58.81,PSDA,0)),"^",19)
 I $D(Y)!$D(DTOUT) W $C(7),!!,"*** THIS GREEN SHEET HAS NOT BEEN COMPLETED ***",!!,"The status remains "_STATN,! D  S PSDOUT=1 G END
 .;PSD*3*28 (Dave B. 19jun00) If up-arrowed on a referred, remove
 .;completion status that was set in PSD(58.8
 .K DR S DIE=58.81,DA=PSDA,DR="I NURSE S Y=22///@"_";29///@"_";33///@"_";10///"_$S($G(PSD10)'="":$G(PSD10),1:"@")_";11///"_$S($G(PSD11)'="":$G(PSD11),1:"@") D ^DIE
ORDER ;update drug balance & order info in 58.8 
 W !!,"Updating your records now..."
 K DA,DIE,DR S DA=ORD,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,",DR="10////"_CSTAT_";11////"_COMP_";12////"_PSDDT D ^DIE K DA,DIE,DR
 I STAT=8 W "completion log..." S TYPE=4 D ^PSDCOR3
 W "done.",!!
 S STAT=$P($G(^PSD(58.81,PSDA,0)),"^",11) W ?2,"*** The status of your Green Sheet #"_PSDPN_" *** ",!
 S CSTAT=$P($G(^PSD(58.81,PSDA,0)),"^",12) W ?6,$S($P($G(^PSD(58.82,STAT,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN"),!,?6,$P($G(^PSD(58.83,CSTAT,0)),"^")
 G GS
END K %,%DT,%H,%I,C,COMP,CPBY,CSTAT,D,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT
 K NAOU,NBKU,NODE,NOK,NURSE,OCOMP,OK,ORD,PSDA,PSDDT,PSDEV,PSDOUT,PSDPN,PSDR,PSDRN,PSDS,PSDSN,PSDUZ,PSDUZN,QTY,RECD,RECDT,STAT,STATN,SUB,TYPE,X,Y
 Q
QUES ;ask ok if still active
 S NOK=0
 W ! K DA,DIR,DIRUT S DIR(0)="Y",DIR("A",1)="This Green Sheet is still ACTIVE on the NAOU.",DIR("A")="Do you want to continue"
 S DIR("?",1)="Answer 'YES' to continue completing this Green Sheet",DIR("?")="or 'NO' to abort processing and select another Green Sheet."
 D ^DIR K DIR I $D(DIRUT) S NOK=1 G MSG
 Q:Y
 I 'Y S NOK=1
MSG W !!,"** No action taken. **",!
 Q
