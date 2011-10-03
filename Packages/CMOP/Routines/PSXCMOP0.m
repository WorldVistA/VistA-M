PSXCMOP0 ; BIR/WRT-DISPLAY & Review NDF (LOOP) matches for CMOP ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 S PSXFL=0,PSXF=0,PSXEND=0 D BEGIN,COMPLETE^PSXCMOP1,DONE
 Q
BEGIN K ^TMP($J,"PSXCMOP"),^TMP($J,"PSXANS") D TEXT,NO1^PSXCMOP1 S:'$D(^TMP($J,"PSXCMOP")) PSXEND=1 Q:PSXEND  D PICK Q:PSXFL  Q:PSXF
 Q
DONE K PSXMM,PSXB,PSXGN,PSXVAP,PSXVP,PSXCMOP,PSXZERO,PSXD,PSXFL,NDA,NUM,PSXDA,PSXDN,PSXDP,PSXDU,PSXDUP,PSXF,PSXG,PSXGN,PSXLM,PSXLOC,PSXM,PSXODE,PSXOU,WAS,DA,RRF,^TMP($J,"PSXCMOP"),^TMP($J,"PSXANS"),X,Y,PSXNO,PSXBT,PRICE,PSXNOW
 K PSXNDF,PSXVAPN,PSXIDENT,PSXEND,PSXLAST,PSXNEXT,ONCE,RTC
 Q
PICK F PSXMM=1:1 S PSXF=0 D PICK1^PSXCMOP  Q:PSXFL  Q:PSXF  Q:PSXBT
 Q
TEXT W !!,"This option allows you to choose entries from your drug file and helps you",!,"review your NDF matches and mark individual entries to send to CMOP.",!
 W !,"If you mark the entry to transmit to CMOP, it will replace your Dispense Unit",!,"with the VA Dispense Unit. In addition, you may overwrite the local drug name"
 W !,"with the VA Print Name and the entry will remain uneditable.",! S PSXBT=0
 Q
DISPLAY Q:PSXFL=1  W @IOF W !,?3,"VA Print Name: ",PSXM,?55,"VA Dispense Unit: ",PSXDU
 S PSXD=^PSDRUG(PSXDA,"ND") W !!!,?5,"Local Drug Generic Name: ",PSXLOC,!?15,"VA Drug Class: ",$P(^PS(50.605,$P(PSXD,"^",6),0),"^",1)
 W !!,?18,"ORDER UNIT: " I $D(^PSDRUG(PSXDA,660)) S PSXODE=^PSDRUG(PSXDA,660) I $P(PSXODE,"^",2) S PSXOU=$P(PSXODE,"^",2) I $D(^DIC(51.5)),$D(^DIC(51.5,PSXOU)) W ?28,$S('$D(PSXOU):"",1:$P(^DIC(51.5,PSXOU,0),"^",1))
 W !,?2,"DISPENSE UNITS/ORDER UNITS: ",$S('$D(PSXODE):"",1:$P(PSXODE,"^",5)),!,?15,"DISPENSE UNIT: ",$S('$D(PSXODE):"",1:$P(PSXODE,"^",8)),!,"  PRICE PER DISPENSE UNIT: ",$S('$D(PSXODE):"",1:$P(PSXODE,"^",6))
 W:PSXNO !!,"** This entry has been previously marked NOT to transmit to CMOP **" D MARK^PSXCMOP  Q:PSXFL
 Q
SYN S:'$D(^PSDRUG(WAS,1,0)) ^PSDRUG(WAS,1,0)="^50.1A^0^0" I '$D(^PSDRUG("C",PSXM,WAS)) S PSXNOW=$P(^PSDRUG(WAS,1,0),"^",3)+1,^PSDRUG(WAS,1,PSXNOW,0)=PSXM,^PSDRUG("C",PSXM,WAS,PSXNOW)="" D SYN1
 Q
SYN1 S $P(^PSDRUG(WAS,1,0),"^",3)=PSXNOW,$P(^PSDRUG(WAS,1,0),"^",4)=$P(^PSDRUG(WAS,1,0),"^",4)+1
 Q
