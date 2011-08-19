PRCSES1 ;WISC/SAW/LJP/TKW-SUB-MODULES CALLED BY FIELDS IN CPA FILE CON'T ;  [12/11/98 2:25pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ITEM ;PR/DISP ITEM HIST
 Q:'$D(PRC("SITE"))  Q:'$D(PRC("CP"))  I $D(^PRCS(410,DA(1),3)),$P(^(3),"^",4),$D(^(2)),$P(^(2),"^")'="" S PRCSV=$P(^(3),"^",4)
 G ITEMH:'$D(PRCSV)
 S DIC="^PRC(441,",DIC(0)="EMNQZ",DIC("S")="I $D(^PRC(441,+Y,2,PRCSV))" D ^DIC I +Y'>0 K DIC,X Q
 S X=+Y I $D(^PRC(441,X,3)),$P(^PRC(441,X,3),"^")=1 W !,"This item is inactive!" K DIC,X Q
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),"^",12)=2 G ITS
 S X=+Y,%=$P(^PRC(441,X,0),"^",8) I %,%'=PRCSV,$D(^PRC(440,%,0)) W !,"Sorry, this item has a mandatory source.",!,"You must order this item from ",$P(^PRC(440,%,0),"^"),".",! K %,X,PRCSV Q
ITS W !,X,! S X=+Y,Z=^PRC(441,+Y,2,PRCSV,0),$P(^PRCS(410,DA(1),"IT",DA,0),"^",3)=$P(Z,"^",7),$P(^(0),"^",6)=$P(Z,"^",4),$P(^(0),"^",7)=$P(Z,"^",2),^(1,0)="^^1^1^"_$S($D(DT):DT,1:"")_"^^",^(1,0)=$P(Y(0),"^",2)
 S PRCSSUB=$S($D(^PRCD(420.1,+$S($D(^PRCS(410,DA(1),3)):$P(^(3),U,3),1:""),1,+$S($D(^PRC(441,+$S($D(^PRCS(410,DA(1),"IT",DA,0)):$P(^(0),U,5),1:""),0)):$P(^(0),U,10),1:""),0)):$P(^(0),U),1:"")
 I PRCSSUB S $P(^PRCS(410,DA(1),"IT",DA,0),U,4)=PRCSSUB
IT Q:'$D(^PRCS(410,DA(1),0))  I $P(^(0),U,4)=5 G EXIT
 W !,"Would you like to see the procurement history for this item" S %=2 D YN^DICN G EXIT:%=2!(%<0),IT:%=0
ITEM0 Q:'$D(Y(0))  S W1=0,W=$P(Y(0),U,2),W(1)=PRC("SITE")_$P(PRC("CP")," "),W(2)="",W(3)=0,PRCSX=X
 I $D(^PRC(441,X,4,W(1),1,"AC")) F I=0:1 S W(3)=$O(^PRC(441,X,4,W(1),1,"AC",W(3))) Q:W(3)'>0!(I=5)  S W(4)="" F J=0:1 S W(4)=$O(^PRC(441,X,4,W(1),1,"AC",W(3),W(4))) Q:'W(4)  S W(2)=W(2)_W(4)_U
NONE I W(2)="" W !,"A history for this item does not yet exist." G EXIT
 F K=1:1:5 S W(6)=$P(W(2),U,K) Q:W(6)=""  S W(5)=0,W(5)=$O(^PRC(442,W(6),2,"AE",X,W(5))) I W(5)'="" S W1=W1+1 D ITEM1
 I 'W1 S W(2)="" G NONE
EXIT I $D(PRCSV),$D(Z),$P(Z,"^",12) W $C(7),!,"NOTE: This item has a minimum order quantity of ",$P(Z,"^",12)
 I $D(PRCSV),$D(Z),$P(Z,"^",11) W $C(7),!,"NOTE: This item must be ordered in multiples of ",$P(Z,"^",11)
 I $D(PRCSV),$D(Z),$P(Z,"^",8) S Z(1)=$P(Z,"^",7),Z(1)=$S($D(^PRCD(420.5,+Z(1),0)):$P(^(0),"^",1),1:"") I Z(1)'="" W $C(7),!,"NOTE: This item has a packaging multiple/unit of purchase of ",$P(Z,"^",8)_"/"_Z(1)
 W ! K %,L,W,W1,DIC,PRCSV Q
ITEM1 I W1=1 W !,?34,"ITEM HISTORY"
 I W1=1 D NOW^%DTC S Y=$J(%,7,4) D DD^%DT W !,Y,?23,"Site: ",PRC("SITE"),?36,"Control point: ",PRC("CP") S X=PRCSX
 I W1=1 W !,"Item Number: ",X,?23,"Description: ",W,!!,?26,"Quantity",!,?26,"Previously",?38,"Unit of",?71,"Quantity"
 I W1=1 W !,"Date Ordered",?15,"PO Number",?26,"Received",?38,"Purchase",?48,"Unit Cost",?59,"Total Cost",?71,"Ordered",! S L="",$P(L,"_",IOM)="_" W L S L=""
 W ! I $D(^PRC(442,W(6),1)),$P(^(1),U,15)'="" S Y=$P(^(1),U,15) D DD^%DT W Y
 W ?15,$P(^PRC(442,W(6),0),U)
 I $D(^PRC(442,W(6),2,W(5),2)) S W(7)=^(2) W ?26,$J(+$P(^(2),U,8),8)
 I $D(^PRC(442,W(6),2,W(5),0)) S W(8)=^(0) W:+$P(W(8),U,3) ?38,$S($D(^PRCD(420.5,+$P(W(8),U,3),0)):$P(^(0),U),1:"")
 W:$D(W(8)) ?48,$J($P(W(8),U,9),9,2) W:$D(W(7)) ?59,$J($P(W(7),U),10,2) W:$D(W(8)) ?71,$J($P(W(8),U,2),8)
 I $P(^PRC(442,W(6),1),U) S W(8)=$P(^(1),U),W(8)=$S($D(^PRC(440,W(8),0)):$P(^(0),U),1:"") I W(8)'="" W !,"Vendor:   ",W(8)
 K W(7),W(8) Q
ITEMH ;ITEM FLD HELP PMPT
 I $D(^PRCS(410,DA(1),3)),$P(^(3),"^",4),$D(^(2)),$P(^(2),"^")'="" S PRCSV=$P(^(3),"^",4)
 I '$D(PRCSV) W !,"You must select a vendor before you may enter Procurement (UIR) Card items.",$C(7) Q
 S:$D(D) ZD=D S X="?",DIC="^PRC(441,",DIC(0)="EM",DIC("S")="I $D(^PRC(441,+Y,2,PRCSV))" D ^DIC S DIC=DIE S:$D(ZD) D=ZD
 K PRCSV,DIC(0),DIC("S"),ZD Q
OBL ;COMPUTE FLDS FOR 1358 ADJ
 G OBL^PRCSES2
