PRCPPOU1 ;WISC/RFJ-receive purchase order (utilities)               ;06 Jan 94
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SELECTPO(PRCPINPT) ;  select purchase order
 N %,C,DIC,I,PRCPORDR,PRCPSCRN,X,Y
 S PRCPSCRN="I $D(^PRC(442,""G"",PRCPINPT,+Y)) S %=$P($G(^PRCD(442.3,+$G(^PRC(442,+Y,7)),0)),U,2) I ""^25^26^27^28^30^31^32^33^34^37^38^40^41^46^47^48^49^50^51^""[(""^""_%_""^"")"
 F  D  Q:$G(PRCPORDR)
 .   W !!,"Select PURCHASE ORDER: "
 .   R X:DTIME I '$T!(X["^")!(X="") S PRCPORDR=-1 Q
 .   I X["?" D  S PRCPORDR=0 Q
 .   .   S D="G",DIC="^PRC(442,",DIC(0)="QECM",DIC("W")="D DICW^PRCPPOU1",DIC("S")=PRCPSCRN
 .   .   D IX^DIC
 .   ;  lookup po in x
 .   S DIC="^PRC(442,",DIC(0)="EQMZ",DIC("S")=PRCPSCRN
 .   D ^DIC I Y<0 S PRCPORDR=0 Q
 .   S PRCPORDR=+Y
 Q PRCPORDR
 ;
 ;
PARTIAL(PRCPORDR)  ;  select partial date
 N %,C,DA,DIC,X,Y
 I '$D(^PRC(442,PRCPORDR,11,0)) S ^(0)="^442.11D^^"
 S DIC="^PRC(442,"_PRCPORDR_",11,",DA(1)=PRCPORDR,DIC(0)="QEAMZ",DIC("S")="I $P(^(0),U,16)="""""
 W ! D ^DIC
 Q +Y
 ;
 ;
DICW ;  write id for purchase order lookup
 N %,DATA
 S DATA=^PRC(442,+Y,0)
 W "  ",$P(DATA,U)
 S %=$P($G(^PRC(442,+Y,1)),"^",15) W:% "  ",$E(%,4,5),"-",$E(%,6,7),"-",$E(%,2,3)
 S %=$P($G(^PRCD(442.5,+$P(DATA,"^",2),0)),"^") W:%'="" "  ",%
 S %=$P($G(^PRCD(442.3,+$G(^PRC(442,+Y,7)),0)),"^")
 W !?7,$E(%,1,34),?45,"FCP: ",$P($P(DATA,"^",3)," ",1),"    $ ",$P(DATA,"^",15)
 Q
 ;
 ;
LINEITEM(PRCPORDR) ;  select line item
 N D0,DA,DIC,X,Y
 S DIC="^PRC(442,"_PRCPORDR_",2,",(DA(1),D0)=PRCPORDR,DIC(0)="QEAMZ",DIC("S")="I $D(^TMP($J,""PRCPPOLMCOS"",Y))"
 W ! D ^DIC
 Q +Y
