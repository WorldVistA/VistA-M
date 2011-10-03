PSDEVOR ;BIR/BJW-Print Edit/Canc Ver Orders Report ; 9 Feb 98
 ;;3.0; CONTROLLED SUBSTANCES ;**8**;13 Feb 97
 ;**Y2K compliance**,"P" added to date input string
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 I '$D(^XUSEC("PSJ RPHARM",DUZ)) W !!,"Contact your Pharmacy Coordinator for access to print the Edit Verified",!,"Orders data.  PSJ RPHARM security key required.",!! Q
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: ",DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
CHKD I '$O(^PSD(58.8,PSDS,1,0)) W !!,"There are no CS stocked drugs for your dispensing vault.",!! G END
DATE W ! K %DT S %DT="AEPX",%DT("A")="Start with Date: " D ^%DT I Y<0 G END
 S PSDSD=Y D D^DIQ S PSDATE=Y,%DT("A")="End with Date: " D ^%DT I Y<0 G END
 I Y<PSDSD W !!,"The ending date of the range must be later than the starting date." G DATE
 S PSDED=Y D D^DIQ S PSDATE=PSDATE_"^"_Y,PSDSD=PSDSD-.0001,PSDED=PSDED+.9999
 W !!,"This report is designed for a 132 column format.",!,"You may queue this report to print at a later time.",!!
DEV ;sel device
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !!,"NO DEVICE SELECTED OR REPORT PRINTED!!",! G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDEVOR",ZTDESC="CS PHARM Edit/Canc Ver Ord" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;entry for compile
 K ^TMP("PSDEVOR",$J) S PSD1=12.99,PSD2=14.99
 F PSD=PSDSD:0 S PSD=$O(^PSD(58.81,"ACT",PSD)) Q:'PSD!(PSD>PSDED)  F PSDR=0:0 S PSDR=$O(^PSD(58.81,"ACT",PSD,PSDS,PSDR)) Q:'PSDR  D
 .F PSDTYP=PSD1:0 S PSDTYP=$O(^PSD(58.81,"ACT",PSD,PSDS,PSDR,PSDTYP)) Q:'PSDTYP!(PSDTYP>PSD2)  F PSDA=0:0 S PSDA=$O(^PSD(58.81,"ACT",PSD,PSDS,PSDR,PSDTYP,PSDA)) Q:'PSDA  D
 ..Q:'$D(^PSD(58.81,PSDA,0))  S NODE=^(0),PSDPN=$S($P(NODE,"^",17)]"":$P(NODE,"^",17),1:"UNKNOWN"),QTY=$P(NODE,"^",6)
 ..S PSDRN=$S($P($G(^PSDRUG(PSDR,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_PSDR_" NAME MISSING")
 ..I $D(^PSD(58.81,PSDA,4)),PSDTYP=14 S NQTY=$P(^(4),"^",3),MFG=+$P(^(4),"^",5),PHARM=$P(^(4),"^",2),PHARM=$P($G(^VA(200,+PHARM,0)),"^"),PHARM=$P(PHARM,",")_","_$E($P(PHARM,",",2)),ACT="EDIT"
 ..I $D(^PSD(58.81,PSDA,5)),PSDTYP=13 S PHARM=$P(^(5),"^",2),PHARM=$P($G(^VA(200,+PHARM,0)),"^"),PHARM=$P(PHARM,",")_","_$E($P(PHARM,",",2)),NQTY=0,MFG=0,ACT="CANC"
 ..S ^TMP("PSDEVOR",$J,PSD,PSDPN,PSDTYP)=PSDRN_"^"_ACT_"^"_PHARM_"^"_QTY_"^"_NQTY_"^"_MFG
PRINT ;prints data
 K LN S (PG,PSDOUT)=0,$P(LN,"-",132)="" D HDR
 I '$D(^TMP("PSDEVOR",$J)) W !!,?15,"**** NO VERIFIED ORDERS EDITED OR CANCELLED ****",!! G DONE
 F PSD=0:0 S PSD=$O(^TMP("PSDEVOR",$J,PSD)) Q:'PSD!(PSDOUT)  S NUM="" F  S NUM=$O(^TMP("PSDEVOR",$J,PSD,NUM)) Q:NUM=""!(PSDOUT)  F TYPE=0:0 S TYPE=$O(^TMP("PSDEVOR",$J,PSD,NUM,TYPE)) Q:'TYPE!(PSDOUT)  D
 .S DATE=$E(PSD,4,5)_"/"_$E(PSD,6,7)_"/"_$E(PSD,2,3),NODE=^TMP("PSDEVOR",$J,PSD,NUM,TYPE)
 .S MFG=$P(NODE,"^",6)
 .D:$Y+4>IOSL HDR Q:PSDOUT
 .W !,NUM,?10,$P(NODE,"^"),?53,$P(NODE,"^",2),?60,DATE,?70,$P(NODE,"^",4),?78,$P(NODE,"^",5),?90,$S(MFG:"FIELDS EDITED",1:"NOT EDITED"),?110,$P(NODE,"^",3)
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %,%DT,%H,%I,%ZIS,ACT,C,DA,DATE,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LN,MFG,NODE,NQTY,NUM
 K PG,PHARM,POP,PSD,PSD1,PSD2,PSDA,PSDATE,PSDED,PSDEV,PSDOUT,PSDPN,PSDR,PSDRN,PSDS,PSDSD,PSDSN,PSDTYP,QTY,TYPE,X,Y
 K ^TMP("PSDEVOR",$J),ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE S (ZTSAVE("PSDS"),ZTSAVE("PSDSN"))=""
 S (ZTSAVE("PSDSD"),ZTSAVE("PSDED"),ZTSAVE("PSDATE"))=""
 Q
HDR ;header
 I $E(IOST,1,2)="C-",PG K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?20,"Edited or Verified Orders for ",PSDSN,?115,"Page: ",PG,!,?20,"Date: ",$P(PSDATE,"^")," to ",$P(PSDATE,"^",2),!!
 W ?70,"ORIG",?78,"NEW",!
 W "DISP #",?10,"DRUG",?52,"ACTION",?62,"DATE",?70,"QTY",?78,"QTY",?86,"MFG/LOT #/EXP.DATE",?110,"PHARMACIST",!,LN,!!
 Q
