PRCHEF ;ID/RSD,SF-ISC/TKW-EDIT ROUTINES FOR SUPPLY SYSTEM ;6/10/97 9:34
V ;;5.1;IFCAP;**107,202**;Oct 20, 2000;Build 27
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN80 ;DELETE A RECEIVING REPORT (CONT.FROM PRCHE)
 K PRCHNRQ D PO^PRCHE G:'$D(PRCHPO) Q^PRCHE
 I $P($G(^PRC(442,PRCHPO,23)),U,11)="S"!($P($G(^(23)),U,11)="P") W !!,?5,"Please create an adjustment voucher to delete",!,?5,"receiving reports for purchase card orders.",! G EN80
 I $P($G(^PRC(442,PRCHPO,23)),U,11)="D" W !!,?5,"Please create an adjustment voucher to delete",!,?5,"receiving reports for delivery orders.",! G EN80
 I X<25!(X>33) W $C(7)," Receiving Report cannot be deleted, please create an adjustment voucher." G EN80
 I '$O(^PRC(442,PRCHPO,11,0)) W !?3,"Order has no Receiving Reports !",$C(7) G EN80
 D LCK1^PRCHE G:'$D(DA) EN80 S:$P(^PRC(442,PRCHPO,0),U,2)=8 PRCHNRQ=1
 S DIC="^PRC(442,PRCHPO,11,",DIC(0)="QEANZ" D ^DIC I Y<0 L  G EN80
 I $P(Y(0),U,6)="Y" W !?3,"Receiving Report has already been processed by Fiscal.",!?3,"You must create an Adjustment Voucher to edit this Receiving Report.",! L  G EN80
 S (PRCHRPT,PRCHDPT)=+Y,(PRCHRD,PRCHDRD)=$P(Y(0),U,1),(PRCHRDEL,PRCHDTP)=1,PRCHEX=$P(Y(0),U,3)+$P(Y(0),U,5)
 D ^PRCHDP3,DEL^PRCHREC2 K PRCHRDEL I $D(PRCHRD) L  D Q^PRCHE G EN80
 ;S PRCHREC=$S($O(^PRC(442,PRCHPO,11,0)):1,1:0),X=$S($D(^PRC(442,PRCHPO,7)):$P(^(7),U,2),1:"")
 ;THE SUPPLY STATUS CODE HAS BEEN MOVED TO PRCHREC2 AS OF PRC*5.1*202
 G EN80
