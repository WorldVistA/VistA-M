PSDRPGS ;BIR/JPW-Reprint Green Sheet (VA FORM 10-2638) ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;**69**;13 Feb 97;Build 13
 ;References to ^PSD(58.8, covered by DBIA2711
 ;
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,$D(^XUSEC("PSJ PHARM TECH",DUZ)):1,$D(^XUSEC("PSD TECH ADV",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"reprint Green Sheets.",!!,"PSJ RPHARM or PSJ PHARM TECH or PSD TECH ADV security key required.",! K OK Q
ASKD ;ask dispensing location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 I $P(PSDSITE,U,5) S PRT=+$P($G(^PSD(58.8,+PSDS,2)),"^",6),ASK=+$G(^(2.5)) G GS1
 W ! K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)",DIC("A")="Select Primary Dispensing Site: ",DIC("B")=$P(PSDSITE,U,4)
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),PRT=+$P($G(^PSD(58.8,+PSDS,2)),"^",6),ASK=+$G(^PSD(58.8,+PSDS,2.5)),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
GS1 ;ask gs # range
 W !!,"You may enter a Green Sheet # list and/or a Green Sheet # range.",!
 W "NOTE: This response must be a list or range, e.g., 1,3,5 or 2-4,8.",!
 K DA,DIR,DIRUT S DIR(0)="LOA^0:999999999",DIR("A")="Select Green Sheet #(s): "
 D ^DIR K DIR G:$D(DIRUT) END
 S PSD1="" F  S PSD1=$O(Y(PSD1)) Q:PSD1=""  S:$D(Y(PSD1)) PSD1(PSD1)=Y(PSD1) K Y(PSD1)
DEV ;ask device and queue info
 W $C(7),!!,"This report now prints on plain paper.",!,"Please check your printer before starting this report.",!!,"You may queue this report to print at a later time.",!!
 S PSDCPI=10
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",8),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 K %ZIS,IOP,IO("Q"),POP S %ZIS="Q",%ZIS("B")=PSDEV D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDRPGS2",ZTDESC="Reprint Green Sheets (VA FORM 10-2638)" D SAVE D ^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO G START^PSDRPGS2
END K %ZIS,ANS,ASK,C,CNT,D,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,EXP,EXPD,LINE,LOT,NAOU,NAOUN,NODE,NODE1,PSDW
 K OK,ORD,ORDN,POP,PRT,PSD,PSD1,PSDA,PSDBY,PSDBYN,PSDCNT,PSDDT,PSDEV,PSDOUT,PSDCPI,PSDPN,PSDR,PSDRN,PSDS,PSDSN,PSDT,PSDTR,PSDTRN,REPRINT,QTY,SITE,STAT,TRANS,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;save var
 S (ZTSAVE("ASK"),ZTSAVE("PSDS"),ZTSAVE("PSDSN"),ZTSAVE("PSDCPI"))="" S:$D(REPRINT) ZTSAVE("REPRINT")=""
 S ZTSAVE("PSD1(")=""
 Q
