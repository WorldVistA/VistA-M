PSDPGS1 ;BIR/JPW-Print Green Sheet (VA FORM 10-2638 ) (cont'd) ; 3 Mar 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8,46**;13 Feb 97
 ;Y2K compliance** display 4 digit year on va forms
START ;loop through transactions
 ;second call to %ZIS to restore variables for open execute
 I $D(ZTQUEUED) S IOP=ION D ^%ZIS U IO
 ;get ready for bar codes and formatting
 N PSD10,PSD12,PSDL,A7BAR0,A7BAR1
 D A7BAR
 S PSD10=$P($G(^%ZIS(2,+$G(IOST(0)),5)),U),PSD12=$P($G(^(5)),U,2)
 S PSDL=$P($G(^%ZIS(2,+$G(IOST(0)),12.16)),U)
 S PSDL(1)=$P($G(^%ZIS(2,+$G(IOST(0)),12.15)),U)
 I PSD12']""!(PSD10']"")!(PSDL']"")!(PSDL(1)']"") W !!,"The device you selected is not set up for green sheets, please contact IRM.",!! Q
 K ^TMP("PSDPGS",$J)
 S PSDCNT=1
 I ANS="R" S PSD1="" F  S PSD1=$O(PSD1(PSD1)) Q:PSD1=""  D LOOP
 I ANS="R" G PRINT
 I ANS="N",$D(PSDG) F PSD=0:0 S PSD=$O(PSDG(PSD)) Q:'PSD  F PSDN=0:0 S PSDN=$O(^PSI(58.2,PSD,3,PSDN)) Q:'PSDN  I $D(^PSD(58.8,PSDN,0)),'$P(^(0),"^",7),$P(^(0),"^",3)=+PSDSITE S NAOU(PSDN)="",CNT=CNT+1
 I ANS="N",$D(ALL) F PSD=0:0 S PSD=$O(^PSD(58.8,PSD)) Q:'PSD  I $D(^PSD(58.8,PSD,0)),$P(^(0),"^",2)="N",$P(^(0),"^",3)=+PSDSITE S NAOU(+PSD)=""
 S LOOP=$S(PRT:2,1:3)
 F STAT=LOOP-.99:0 S STAT=$O(^PSD(58.81,"AD",STAT)) Q:'STAT!(STAT>3)  F PSD=0:0 S PSD=$O(^PSD(58.81,"AD",STAT,PSD)) Q:'PSD  F PSDA=0:0 S PSDA=$O(^PSD(58.81,"AD",STAT,PSD,PSDA)) Q:'PSDA  D SET
PRINT ;print green sheet
 I '$D(^TMP("PSDPGS",$J)) W !,"*** SORRY NO GREEN SHEETS TO PRINT ***",! G END
 S PSDPN="" F  S PSDPN=$O(^TMP("PSDPGS",$J,PSDPN)) Q:PSDPN=""  D
 .S NODE=^TMP("PSDPGS",$J,PSDPN),NAOUN=$P(NODE,"^"),PSDBYN=$P(NODE,"^",5),PSDT=$P(NODE,"^",6),ORDN=$P(NODE,"^",7)
 .I ORDN]"",ORDN'="UNKNOWN" S ORDN=$P(ORDN,",")_","_$E($P(ORDN,",",2))
 .I PSDBYN]"",PSDBYN'="UNKNOWN" S PSDBYN=$P(PSDBYN,",")_","_$E($P(PSDBYN,",",2))
 .S PSDDT="" I PSDT S Y=PSDT X ^DD("DD") S PSDYR=$P(Y,",",2),PSDYR=$E(PSDYR,1,4) S PSDDT=$E(PSDT,4,5)_"/"_$E(PSDT,6,7)_"/"_PSDYR
 .W:$Y @IOF,@PSD12 W ?33,NAOUN,"  ",$P($G(^DPT(+$P(NODE,U,9),0)),U)
 .I $D(A7PRT) W $C(13),?70,@A7BAR1,@PSD10,PSDPN,@A7BAR0,@PSD12
 .W @PSDL,!?6,"CONTROLLED SUBSTANCE ADMINISTRATION RECORD",?54
 .W "Pharmacy Dispensing # ",@PSD10,PSDPN,@PSD12,!?6
 .W "Drug: ",@PSD10,$P(NODE,U,2),@PSD12,?60,"Exp: ",$P(NODE,U,4),?78
 .W "Qty: ",@PSD10,$P(NODE,U,3),@PSD12,!?6
 .W "Lot#",$P(NODE,U,8),?21,"Ord by: ",$E(ORDN,1,20)
 .W ?45,"Disp by: ",$E(PSDBYN,1,20),?70,"Date: ",PSDDT,@PSDL(1),!?7
 .S $P(LN,"_",80)="" W LN,@PSDL,!?6
 .W "| DATE   TIME     NAME OF PATIENT      DOSE  BALANCE  ADMINISTERED BY           |"
 .F LINE=1:1:30 W !?6,"|________|_____|_______________________|_____|______|___________________________|"
 .W !?6,"Above Drug Received:      Date__________ R.N. Sign_______________________________"
 .W !?6,"Above Drug Administered:  Date__________ R.N. Sign_______________________________"
 .W !?6,"Entries Reviewed:         Date__________ R.PH. Sign______________________________",!?6
 .W @PSDL(1),"Drug: ",@PSD10,$P(NODE,U,2),@PSD12,?60
 .W "Pharmacy Dispensing # ",@PSD10,PSDPN,@PSD12,!?6
 .W "Automated VA FORM 10-2638"
END K %ZIS,ALL,ANS,ASK,C,CNT,D,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,EXP,EXPD,IOP,JJ,LINE,LOOP,LOT,NAOU,NAOUN,NODE,NODE1
 K OK,ORD,ORDN,POP,PRT,PSD,PSD1,PSDA,PSDBY,PSDBYN,PSDCPI,PSDCNT,PSDDT,PSDEV,PSDG,PSDN,PSDOUT,PSDPN,PSDR,PSDRN,PSDS,PSDSN,PSDT,PSDYR
 K QTY,SEL,SITE,STAT,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDPGS",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
LOOP S PSDPN=$P(PSD1(PSD1),",",PSDCNT),PSDCNT=PSDCNT+1 I PSDPN="" S PSDCNT=1 Q
 S PSDA=$O(^PSD(58.81,"D",PSDPN,0)),PSD=+$P($G(^PSD(58.81,+PSDA,0)),"^",18) D SET
 G LOOP
 Q
SET ;set data for printing
 Q:'$D(^PSD(58.81,+PSDA,0))  Q:+$P($G(^PSD(58.81,+PSDA,0)),"^",3)'=+PSDS
 Q:+$P($G(^PSD(58.8,+PSD,2)),"^",5)&('$P($G(^PSD(58.8,+PSDS,1,+$P($G(^PSD(58.81,+PSDA,0)),U,5),7)),U,3))&('$P($G(^PSD(58.81,+PSDA,9)),U))
 Q:+$P($G(^PSD(58.81,+PSDA,"CS")),"^",4)
 I ANS="N" Q:'$D(NAOU(+PSD))
 S NODE=^PSD(58.81,+PSDA,0) Q:+$P(NODE,"^",11)>3
 S NAOUN=$S($P($G(^PSD(58.8,+PSD,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S PSDR=+$P(NODE,"^",5),PSDRN=$S($P($G(^PSDRUG(PSDR,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S PSDPN=$S($P(NODE,"^",17)]"":$P(NODE,"^",17),1:"UNKNOWN"),PSDT=$P(NODE,"^",4)
 S QTY=$P(NODE,"^",6) I $D(^PSD(58.81,PSDA,4)),+$P(^(4),"^",3) S QTY=$P(^(4),"^",3)
 S LOT=$P(NODE,"^",14),EXP=$P(NODE,"^",15),EXPD="" I EXP S Y=$E(EXP,1,7) X ^DD("DD") S EXPD=Y
 S (PSDBY,PSDBYN,ORD,ORDN)=""
 I $D(^PSD(58.81,PSDA,1)) S NODE1=^(1),PSDBY=$P(NODE1,"^"),ORD=$P(NODE1,"^",7)
 S:ORD ORDN=$S($P($G(^VA(200,ORD,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S:PSDBY PSDBYN=$S($P($G(^VA(200,PSDBY,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ^TMP("PSDPGS",$J,PSDPN)=NAOUN_"^"_PSDRN_"^"_QTY_"^"_EXPD_"^"_PSDBYN_"^"_PSDT_"^"_ORDN_"^"_LOT_U_$P($G(^PSD(58.81,PSDA,9)),U)
 K DA,DIE,DR S DA=PSDA,DIE=58.81,DR="103////1" D ^DIE K DA,DIE,DR
 Q
A7BAR ;DALISC/JRR set up vars to print barcode on green sheet
 ;This subroutine added by James Reed, Dallas ISC, 9/8/95
 K A7PRT ;Var will be defined if bar code logic was set up in device file
 F JJ=0,1 S @("A7BAR"_JJ)="" I $D(^%ZIS(2,^%ZIS(1,IOS,"SUBTYPE"),"BAR"_JJ)) S @("A7BAR"_JJ)=^("BAR"_JJ)
 I A7BAR1]"",A7BAR0]"" S A7PRT=1 ;okay to print bar code
