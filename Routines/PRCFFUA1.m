PRCFFUA1 ;WISC/SJG-ROUTINE TO PROCESS OBLIGATIONS ;4/27/94  11:30
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SC ; Display Obligation Data
 N LABEL S LABEL=$P(PO(0),U,2),PRCFA("IDES")=$S((LABEL=1)!(LABEL=2):"Purchase Order",LABEL=8:"Requisition",1:"Purchase Order")
 I '$D(IOF)!('$D(IOM)) S IOP="HOME" D ^%ZIS K POP
 W @IOF D HDR I $P(PRCFA("MOD"),U)="M" D ORG
 K II W !!?(IOM-37\2),PRCFA("IDES")_" - "_$P(PO(0),"^"),!!,"  COST CENTER: "_$P(PO(0),"^",5),?IOM\2-4,"CONTROL POINT: "_$P(PO(0),"^",3)
 W ! S II=0 F  S II=$O(^PRC(442,PRCFA("PODA"),22,II)) Q:(II="")!(II'>0)  D
 .N BOC,SHIP
 .S BOC=^PRC(442,PRCFA("PODA"),22,II,0),SHIP=+BOC
 .Q:'SHIP
 .W !,?$X+3,"BOC:  ",$P(BOC,U),?IOM\2,"AMOUNT: $ "_$J($P(BOC,U,2),10,2)
 D GENDIQ^PRCFFU7(442,+PO,13.05,"E","")
 I $G(PRCTMP(442,+PO,13.05,"E")) D
 .K MSG W !!
 .S MSG(1)="  ESTIMATED SHIPPING BOC:"
 .S MSG(2)="   "_$G(PRCTMP(442,+PO,13.05,"E"))
 .D EN^DDIOL(.MSG) K MSG
 .Q
 W !!,"Net Cost of Order: ",?30,"$",$J($P(PO(0),U,16),10,2)
 I $P(PRCFA("MOD"),U)="M" D PAUSE^PRCFFERU
 Q
CPBAL ; Display Control Point Offical's Balance
 D HDR
 W !!,"Net Cost of Order: ",?30,"$",$J($P(PO(0),U,16),10,2)
 D CPBAL^PRCFFMO1 I $D(PRCF("NOBAL")) K PRCF("NOBAL")
 I $P(PRC("PARAM"),"^",17)="Y" W !!,"Fiscal Status of Funds for Control Point" W !!,"Status of Funds Balance: ",?30,"$",$J($P(^PRC(420,PRC("SITE"),1,+$P(PO(0),U,3),0),U,7),10,2),!,"Estimated Balance:",?30,"$",$J($P(^(0),U,8),10,2)
 Q
HDR ; Display header
 I '$D(IOINHI) D HILO^PRCFQ
 D HDR^PRCFFER
 Q
ORG ; Display original info
 W !! K MSG S MSG(3)="The following information appears on the original and any previously amended"
 S MSG(4)=PRCFA("IDES") S:$D(^PRC(442,+PO,6)) MSG(4)=MSG(4)_"s" S MSG(4)=MSG(4)_":"
 I $G(PRCFA("RETRAN"))=1,$G(FISCEDIT)=1 S MSG(1)="These original values have been edited by Fiscal in this option!",MSG(2)="  "
 D EN^DDIOL(.MSG) K MSG W !
 Q
GET ; Display amended BOC info
 D PAUSE^PRCFFERU,HDR S FILE=$$FILE^PRCFFUA()
 K MSG S MSG(1)="The following information appears on the amended "_PRCFA("IDES")
 S MSG(2)="as listed in the DESCRIPTION OF MODIFICATION:"
 W ! D EN^DDIOL(.MSG) W ! K MSG
GETAMD I FILE=443.6 D  Q
 .S D0=$S($D(PRCHPO):PRCHPO,1:D0),D1=$S($D(PRCHAM):PRCHAM,1:D1)
 .Q:'$D(^PRC(443.6,D0,6,D1))  S PRCHD0=^(D1,0),PRCHD1=^(1),PRCHDP0=^PRC(443.6,D0,0),PRCHDP1=^PRC(443.6,D0,1)
 .S PRCHDAV=$S($P(PRCHD0,U,8)="Y":1,1:0),PRCHLC1=6,PRCHLC2=0
 .D ITEM^PRCHDAM
GETORG I FILE=442 D  Q
 .D:$D(^PRC(442,D0,6,PRCFAA,3))
 ..K ^UTILITY($J,"W") D START^PRCHDP5(D0,PRCFAA)
 ..W ! S J=0 F  S J=$O(^UTILITY($J,"W",1,J)) Q:'J  W !,?8,^(J,0)
 ..Q
 .D:$D(^PRC(442,D0,6,PRCFAA,2))
 ..K ^UTILITY($J,"W") S DIWL=1,DIWR=60
 ..S PRCHJ=0 F  S PRCHJ=$O(^PRC(442,D0,6,PRCFAA,2,PRCHJ)) Q:'PRCHJ  S X=^(PRCHJ,0) D DIWP^PRCUTL($G(DA))
 ..W ! S J=0 F  S J=$O(^UTILITY($J,"W",1,J)) Q:'J  W !?8,^(J,0)
 ..Q
 .Q
 Q
SF1 ; Line item roll-up into BOCs for amendment 
 N LOOP,LAST,LOOPVAL S (LOOP,LAST)=0
 I $G(PRCFA("RETRAN"))=1 D ^PRCFFUA2
 S %X="^PRC(442,PRCHPO,22,",%Y="^PRC(443.6,PRCHPO,22," D %XY^%RCR
 F  S LOOP=$O(^PRC(442,PRCHPO,22,LOOP)) Q:LOOP'>0  D
 .S LOOPVAL=$G(^PRC(442,PRCHPO,22,LOOP,0)),$P(LOOPVAL,U,2)=0
 .S ^PRC(442,PRCHPO,22,LOOP,0)=LOOPVAL I $P(LOOPVAL,U,3)'=991,$P(LOOPVAL,U,3)>LAST S LAST=$P(LOOPVAL,U,3)
 .Q
 S DA=PRCHPO D ^PRCHAMYC,^PRCHSF1
 K ^PRC(443.6,PRCHPO,22),%X,%Y
 Q
