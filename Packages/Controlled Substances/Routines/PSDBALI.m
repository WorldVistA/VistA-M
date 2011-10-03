PSDBALI ;BIR/JPW-Display/Print Drug Inv Sheet & Balance ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
 K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)"
 S DIC("A")="Select Primary Dispensing Site: "
 S DIC("B")=PSDSN
 D ^DIC K DIC G:Y<0 END
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
CHKD I '$O(^PSD(58.8,PSDS,1,0)) W !!,"There are no CS stocked drugs for your dispensing vault.",!! G END
SORT ;asks sort
 W ! K DA,DIR,DIRUT S DIR(0)="YO",DIR("A")="Do you wish to sort by Inventory Type",DIR("B")="NO"
 S DIR("?")="Answer YES to sort drugs by Inventory Type, NO or <RET> to sort by drug."
 D ^DIR K DIR G:$D(DIRUT) END S ASKN=Y
 W !!,?5,"You may select a single drug, several drugs,",!,?5,"or enter ^ALL to select all drugs.",!!
DRUG ;ask drug
 W ! K DA,DIC
 F  S DIC("W")="W:$P(^PSDRUG(Y,0),""^"",9) ""   N/F"" I $P(^PSD(58.8,PSDS,1,Y,0),""^"",14)]"""",$P(^(0),""^"",14)'>DT W $C(7),""   *** INACTIVE ***""",DA(1)=+PSDS,DIC(0)="QEAM",DIC="^PSD(58.8,"_PSDS_",1," D ^DIC K DIC Q:Y<0  D
 .S PSDR(+Y)=""
 I '$D(PSDR)&(X'="^ALL") G END
 I X="^ALL" S ALL=1
DEV ;sel device
 S Y=$P($G(^PSD(58.8,+PSDS,2)),"^",9),C=$P(^DD(58.8,24,0),"^",2) D Y^DIQ S PSDEV=Y
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")=PSDEV D ^%ZIS I POP W !!,"NO DEVICE SELECTED OR REPORT PRINTED!!",! G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDBALI",ZTDESC="CS PHARM Print Inv Sheet " D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;entry for compile
 K ^TMP("PSDBALI",$J)
 I $D(ALL) F PSD=0:0 S PSD=$O(^PSD(58.8,+PSDS,1,PSD)) Q:'PSD  I $D(^PSD(58.8,+PSDS,1,PSD,0)) S PSDR(+PSD)=""
 F PSD=0:0 S PSD=$O(PSDR(PSD)) Q:'PSD  I $D(^PSD(58.8,+PSDS,1,PSD,0)) S NODE=^(0) D
 .S PSDOK="" I +$P(NODE,"^",14),+$P(NODE,"^",14)'>DT Q:'+$P(NODE,"^",4)  S PSDOK="*"
 .S BAL=+$P(NODE,"^",4),DRUGN=$S($P($G(^PSDRUG(+PSD,0)),"^")]"":$P(^(0),"^"),1:"ZZ/"_PSD_" NAME MISSING"),SLVL=+$P(NODE,"^",3),EXP=$S(+$P(NODE,"^",12):+$P(NODE,"^",12),1:"")
 .I EXP S Y=EXP X ^DD("DD") S EXP=Y
 .I ASKN D LOOP Q
 .S ^TMP("PSDBALI",$J,DRUGN,PSD)=BAL_"^"_PSDOK_"^"_SLVL_"^"_EXP
PRINT ;prints data
 S (PG,PSDOUT)=0 D NOW^%DTC S Y=+$E(%,1,12) X ^DD("DD") S RPDT=Y
 K LN S $P(LN,"-",80)="" D HDR
 I '$D(^TMP("PSDBALI",$J)) W !!,?15,"**** NO STOCK BALANCE DATA AVAILABLE ****",!! G DONE
 I ASKN D PRINT^PSDBALI1 G DONE
 S PSDR="" F  S PSDR=$O(^TMP("PSDBALI",$J,PSDR)) Q:PSDR=""!(PSDOUT)  F PSD=0:0 S PSD=$O(^TMP("PSDBALI",$J,PSDR,PSD)) Q:'PSD  D  Q:PSDOUT
 .I $Y+6>IOSL W !,?10,"Inspector's Signature: ______________________________",! D HDR Q:PSDOUT
 .S NODE=^TMP("PSDBALI",$J,PSDR,PSD),BAL=+NODE,PSDOK=$P(NODE,"^",2),SLVL=$P(NODE,"^",3),EXP=$P(NODE,"^",4)
 .W !,PSDOK,?2,PSDR,?50,$J(BAL,6),?66,"___________",! W:SLVL ?5,"Stock Level: ",SLVL W:EXP]"" ?30,"Exp. Date: ",EXP W ! S LNUM=$Y
PRT ;
 I LNUM<IOSL-5 F JJ=LNUM:1:IOSL-5 W !
 W:'PSDOUT ?10,"Inspector's Signature: ______________________________",!
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %,%H,%I,%ZIS,ALL,ASKN,BAL,C,DA,DIC,DRUGN,DTOUT,DUOUT,EXP,JJ,LN,LNUM,NODE,PG,POP,PSD,PSDEV,PSDOK,PSDOUT,PSDR,PSDRN,PSDS,PSDSN,RPDT,SLVL,TYP,TYPN,X,Y
 K ^TMP("PSDBALI",$J),ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE S (ZTSAVE("PSDS"),ZTSAVE("PSDSN"),ZTSAVE("PSDSITE"),ZTSAVE("ASKN"))=""
 S:$D(ALL) ZTSAVE("ALL")="" S:$D(PSDR) ZTSAVE("PSDR(")=""
 Q
HDR ;header
 I $E(IOST,1,2)="C-",PG K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?12,"Inventory Sheet for ",PSDSN,?72,"Page: ",PG,!,?20,RPDT,!!
 W ?5,"DRUG",?46,"CURRENT BALANCE",?68,"ON-HAND",!,LN,!!
 Q
LOOP ;sets inv type
 I '$O(^PSD(58.8,+PSDS,1,+PSD,2,0)) S TYPN="ZZ** NO INVENTORY TYPE DATA **" D LOOP1
 F TYP=0:0 S TYP=$O(^PSD(58.8,+PSDS,1,+PSD,2,TYP)) Q:'TYP  S TYPN=$S($P($G(^PSI(58.16,+TYP,0)),"^")]"":$P(^(0),"^"),1:"TYPE NAME MISSING") D LOOP1
 Q
LOOP1 S ^TMP("PSDBALI",$J,TYPN,DRUGN,PSD)=BAL_"^"_PSDOK_"^"_SLVL_"^"_EXP
 Q
