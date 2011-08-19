PSDRPGS2 ;BIR/JPW,LTL,BJW-Reprint Green Sheet (VA FORM 10-2638) cont'd ; 3 Mar 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8,46**;13 Feb 97
 ;**Y2K compliance** display 4 digit year on va forms
START ;loop through transactions
 ;second call to %ZIS to restore varibles for open execute
 I $D(ZTQUEUED) S IOP=ION D ^%ZIS U IO
 ;get ready for bar codes and formatting
 N PSD10,PSD12,PSDL,A7BAR0,A7BAR1
 D A7BAR^PSDPGS1
 S PSD10=$P($G(^%ZIS(2,+$G(IOST(0)),5)),U),PSD12=$P($G(^(5)),U,2)
 S PSDL=$P($G(^%ZIS(2,+$G(IOST(0)),12.16)),U)
 S PSDL(1)=$P($G(^%ZIS(2,+$G(IOST(0)),12.15)),U)
 I PSD12']""!(PSD10']"")!(PSDL']"")!(PSDL(1)']"") W !!,"The device you selected is not set up for green sheets, please contact IRM.",!! Q
 S PSD=$P(PSDS,"^",2),PSDCNT=1
 S PSD1="" F  S PSD1=$O(PSD1(PSD1)) Q:PSD1=""  D LOOP
END K %ZIS,ANS,ASK,C,CNT,D,DA,DIC,DIE,DIR,DIROUT,DIRUT,DR,DTOUT,DUOUT,EXP,EXPD,LINE,LOT,NAOU,NAOUN,NODE,NODE1
 K OK,ORD,ORDN,POP,PRT,PSD,PSD1,PSDA,PSDBY,PSDBYN,PSDCNT,PSDDT,PSDEV,PSDOUT,PSDCPI,PSDPN,PSDR,PSDRN,PSDS,PSDSN,PSDT,PSDTR,PSDTRN,PSDYR,REPRINT,QTY,SITE,STAT,TRANS,Y,ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
LOOP S PSDPN=$P(PSD1(PSD1),",",PSDCNT),PSDCNT=PSDCNT+1 I PSDPN="" S PSDCNT=1 Q
 S PSDA=$O(^PSD(58.81,"D",PSDPN,0)) D SET
 G LOOP
 Q
SET ;set data for printing
 K TRANS,PSDTR S PSDOUT=0
 Q:'$D(^PSD(58.81,+PSDA,0))  S NODE=^PSD(58.81,+PSDA,0)
 Q:+$P(NODE,"^",3)'=+PSDS  I (+$P(NODE,"^",11)>4)&(+$P(NODE,"^",11)'=10)&(+$P(NODE,U,11)'=13) Q
 I +$P($G(^PSD(58.81,PSDA,"CS")),"^",4)  S REPRINT=1
 S PSD=+$P(NODE,"^",18)
 S NAOUN=$S($P($G(^PSD(58.8,+PSD,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S PSDR=$P(NODE,"^",5),PSDRN=$S($P($G(^PSDRUG(PSDR,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S PSDT=$P(NODE,"^",4)
 S QTY=$P(NODE,"^",6) I $D(^PSD(58.81,PSDA,4)),+$P(^(4),"^",3) S QTY=$P(^(4),"^",3)
 S LOT=$P(NODE,"^",14),EXP=$P(NODE,"^",15),EXPD="" I EXP S Y=$E(EXP,1,7) X ^DD("DD") S EXPD=Y
 S (PSDBY,PSDBYN,ORD,ORDN)=""
 I $D(^PSD(58.81,PSDA,1)) S NODE1=^(1),PSDBY=$P(NODE1,"^"),ORD=$P(NODE1,"^",7)
 S:ORD ORDN=$S($P($G(^VA(200,ORD,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S:PSDBY PSDBYN=$S($P($G(^VA(200,PSDBY,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S CNT=1,PSDTR(CNT)=+$O(^PSD(58.81,"AE",PSDA,0)) D:PSDTR(CNT)  G:PSDOUT PRINT
 .S TRANS=1
 .D SETT Q:PSDOUT
 .S NAOU=+$P($G(^PSD(58.81,PSDTR(CNT),0)),"^",18)
 .S:NAOU $P(PSDTR(CNT),"^",2)=$S($P($G(^PSD(58.8,+NAOU,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
PRINT ;print green sheet
 I ORDN]"",ORDN'="UNKNOWN" S ORDN=$P(ORDN,",")_","_$E($P(ORDN,",",2))
 I PSDBYN]"",PSDBYN'="UNKNOWN" S PSDBYN=$P(PSDBYN,",")_","_$E($P(PSDBYN,",",2))
 S PSDDT="" I PSDT S Y=PSDT X ^DD("DD") S PSDYR=$P(Y,",",2),PSDYR=$E(PSDYR,1,4) S PSDDT=$E(PSDT,4,5)_"/"_$E(PSDT,6,7)_"/"_PSDYR
 W:$Y @IOF,@PSD12
 W:$D(REPRINT) $C(13),?10,"* REPRINT *",$P($G(^DPT(+$P($G(^PSD(58.81,PSDA,9)),U),0)),U) I '$D(TRANS) W ?33,NAOUN
 W:$D(TRANS) "* Transferred to: ",$S($P(PSDTR(CNT),"^",2)]"":$P(PSDTR(CNT),"^",2),1:$P(PSDTR(CNT-1),"^",2))," *"
 I $D(A7PRT) W $C(13),?70,@A7BAR1,@PSD10,PSDPN,@A7BAR0,@PSD12
 W @PSDL,!?6,"CONTROLLED SUBSTANCE ADMINISTRATION RECORD",?54
 W "Pharmacy Dispensing # ",@PSD10,PSDPN,@PSD12,!?6
 W "Drug: ",@PSD10,PSDRN,@PSD12,?60,"Exp: ",EXPD,?78
 W "Qty: ",@PSD10,QTY,@PSD12,!?6
 W "Lot#",LOT,?21,"Ord by: ",$E(ORDN,1,20)
 W ?45,"Disp by: ",$E(PSDBYN,1,20),?70,"Date: ",PSDDT,@PSDL(1),!?7
 S $P(LN,"_",79)="" W LN,@PSDL,!?6
 W "| DATE   TIME     NAME OF PATIENT      DOSE  BALANCE  ADMINISTERED BY          |"
 F LINE=1:1:30 W !?6,"|_______|_____|_______________________|_____|______|___________________________|"
 ;W:ASK !
 W !?6,"Above Drug Received:      Date__________  R.N. Sign_____________________________"
 W !?6,"Above Drug Administered:  Date__________  R.N. Sign_____________________________"
 W !?6,"Entries Reviewed:         Date__________  R.PH. Sign____________________________",!?6
 W @PSDL(1),"Drug: ",@PSD10,PSDRN,@PSD12,?60
 W "Pharmacy Dispensing # ",@PSD10,PSDPN,@PSD12,!?6
 W "Automated VA FORM 10-2638"
 ;W @PSDL(1),"Drug: ",@PSD10,PSDRN,@PSD12,!?6
 ;W "Automated VA FORM 10-2638",?54,"Pharmacy Dispensing # ",@PSD10,PSDPN
 K DA,DIE,DR S DA=PSDA,DIE=58.81,DR="103////1" D ^DIE K DA,DIE,DR
 Q
SETT ;set trans naous
 S PSDTRN=+$O(^PSD(58.81,"AE",+PSDTR(CNT),0)) Q:'PSDTRN
 S NAOU=$P($G(^PSD(58.81,+PSDTRN,0)),"^",18) I 'NAOU S PSDOUT=1 Q
 S:NAOU $P(PSDTR(CNT),"^",2)=$S($P($G(^PSD(58.8,+NAOU,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 I $O(^PSD(58.81,"AE",+PSDTRN,0)) S CNT=CNT+1,PSDTR(CNT)=$O(^PSD(58.81,"AE",+PSDTRN,0)) G SETT
 Q
