PSXLKUP ;BIR/BAB,HTW-Prescription Inquiry for Host Facility ;MAR 1,2002@16:11:17
 ;;2.0;CMOP;**23,32,47**;11 Apr 97
 ;;Reference to File #200 supported by DBIA #10060
EN ;
 S DIC("A")="Select Facility Batch Reference # :",DIC=552.4,DIC(0)="AEQMZ" D ^DIC K DIC Q:Y<0!($D(DTOUT))  S REF=+Y
 S BAT=+$G(^PSX(552.4,REF,0)) W !!,?2,"TRANSMITTED :" S Y=$P(^PSX(552.1,BAT,0),U,3) X ^DD("DD") W Y
 W ?40,"RECEIVED   : " S Y=$P(^PSX(552.1,BAT,0),U,4) X ^DD("DD") W Y
 W !,?40,"TO VENDOR  : " S Y=$P(^PSX(552.1,BAT,0),U,6) X ^DD("DD") W Y
 S DIC("A")="RX # :",DIC(0)="AEQMZ",DA(1)=REF,DIC="^PSX(552.4,"_DA(1)_",1," D ^DIC K DIC G:Y<0!($D(DTOUT)) EXIT S DA=+Y
 I $P($G(Y(0)),"^",14)=1 W ?25,"CONTROLLED SUBSTANCE"
 S QRY=+$P($G(Y(0)),U,8) I QRY>0  S QRYN=$O(^PSX(553.1,"B",QRY,0)) I QRYN>0 S Y=$P(^PSX(553.1,QRYN,0),U,4) X ^DD("DD")
 I QRY>0 W !?2,"REC'D FROM VENDOR  : ",Y
 W ! S IND=+$P(Y(0),"^",12) W !,?2,$S(IND=0:"ORIGINAL",IND>0:"REFILL #"_IND,1:"") K IND
 W ?18,"DRUG ID : ",$P(Y(0),"^",4),?40,"QTY : ",$P(Y(0),"^",13),?55,"COST : ",$P(Y(0),"^",11)
 S ST=$P(Y(0),U,10) W !!,?2,"RX STATUS : ",$S(ST=1:"RELEASED",ST=2:"RETURNED",ST=3:"PROCESSED",ST=4:"REJECTED",ST=5:"RECEIVED",1:"UNKNOWN") G:ST=5 EXIT
 S Y=$P(Y(0),U,9) X ^DD("DD") S TYP=+^PSX(552.4,DA(1),1,DA,2)
 W ?30,$S($P(Y(0),U,2)=1:"COMPLETED",$P(Y(0),U,2)=2:"CANCELED",1:"UNKNOWN")_" "_Y_"   "_$S(TYP=1:"AUTOMATED",TYP=2:"MANUAL",1:"")
 I $P(Y(0),U,2)=2 W !,?5,"CANCELLATION REASON : ",$P(Y(0),U,3)
 W !!,?2,"NDC : ",$S($P(Y(0),U,5)]"":$P(Y(0),U,5),1:"")
 W ?30,"BY EMPLOYEE : ",$$GET1^DIQ(200,$P(Y(0),U,6),.01)
 I $P(Y(0),U,7)>0 W !!,?2,"PROCESSED DT/TM : " S Y=$P(Y(0),U,7) X ^DD("DD") W Y
 I $P(Y(0),U,7)'>0 W !!
 I $G(QRY)>0 W ?50,"QUERY ID # ",QRY
 S RELTYPE=$P($G(^PSX(552.4,DA(1),1,DA,2)),"^")
 ;I $G(RELTYPE)]"" W !!,"  RELEASE TYPE:  ",$S(RELTYPE=2:"MANUAL",RELTYPE=1:"AUTOMATED",1:"UNKNOWN")
 S RER=$P($G(^PSX(552.4,DA(1),1,DA,2)),"^",2)
 I $G(RER)]"" W !!,"  REMOTE ERROR CONDITION:  "
 I  W $S(RER=1:"Release date already exists.",RER=2:"Rx entry missing.",RER=3:"Fill mismatch.",RER=4:"Transmission number mismatch.",RER=5:"No CMOP event multiple.",RER=6:"Fill does not exist",1:"UNKNOWN")
 S PSX=0 W ! F  S PSX=$O(^PSX(552.4,DA(1),1,DA,1,PSX)) Q:'PSX  D
 . S LOT=$P(^PSX(552.4,DA(1),1,DA,1,PSX,0),U),Y=$P(^(0),U,2) X ^DD("DD") W !,?10,"LOT # : ",LOT,?30,"EXP DATE : ",Y
 W !!,"  CARRIER: "_$P($G(^PSX(552.4,DA(1),1,DA,2)),"^",5),?25,"PACKAGE ID "_$P($G(^PSX(552.4,DA(1),1,DA,2)),"^",6)
 W !!,"  DATE SHIPPED: " S Y=$P($G(^PSX(552.4,DA(1),1,DA,2)),"^",4) X ^DD("DD") W Y
 G EXIT
LOT S LOT=$P(^PSX(552.4,DA(1),1,DA,1,PSX,0),U),Y=$P(^(0),U,2) X ^DD("DD") W !,?10,"LOT # : ",LOT,?30,"EXP DATE : ",Y
 Q
EXIT K DA,DIC,REF,X,Y,TYP,ST,IND,BAT,LOT,PSX,QRY,QRYN,QDT
 K REMOERR,RELTYPE,DUOUT,DTOUT,RER
 W !! G EN
