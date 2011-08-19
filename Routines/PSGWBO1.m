PSGWBO1 ;BHAM ISC/CML-Enter/Edit Actual Dispensed/Backorder Values - CONTINUED ; 09/27/89 13:57
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 ;
CHKQTY ;Check Qty. Dispensed for reasonable amount (2 X Stock Level)
 K QTYFLG Q:'$D(^PSI(58.1,PSGWDA,1,PSGDDA,0))  S STKLEV=$P(^(0),"^",2) I 'STKLEV K STKLEV Q
 I X'>(2*STKLEV) K STKLEV Q
 W *7,!!,"This quantity seems too high!  The normal Stock Level for this item is ",STKLEV
ASK W !?5,"Are you sure of this amount " S %=2 D YN^DICN I %=1 K STKLEV Q
 I %=0 W "   Enter 'YES' or 'NO'" G ASK
 S QTYFLG=1 K STKLEV Q
GETVAL S DIC("W")="W $P(^(0),""^"",8)"
 I $L(X)>1 S DIC(0)="QEM",X=$E(X,2,$L(X))
 E  S DIC(0)="QEAM"
 S DIC="^PSI(58.1,"_PSGWDA_",1," D ^DIC S DA=+Y K DIC Q:Y<0  D ALIGN Q
ALIGN ;Align on this item
 Q:'$D(^PSI(58.1,PSGWDA,1,+Y,0))  S K=^(0) D LOC S TYP=""
TYP S TYP=$O(^PSI(58.19,"AINV",PSGWIDA,PSGWDA,TPSG1,TPSG2,TPSG3,TYP)) I TYP="" W *7,"??",!!,"You may only 'up-arrow' to Items from this AOU",!,"that are included in this Inventory Date/Time!!",!!,"ITEM: ",TEMPDR S DA=-1,PSGDR=TEMPDR Q
 S PSG1=TPSG1,PSG2=TPSG2,PSG3=TPSG3
 I $D(^PSI(58.19,"AINV",PSGWIDA,PSGWDA,PSG1,PSG2,PSG3,TYP,PSGDR)) S PSGTYP=TYP,PSGDR=$E(PSGDR,1,$L(PSGDR)-1)_$E(" ",$E(PSGDR,$L(PSGDR))'=" ") Q
 E  G TYP
LOC ;Build item address
 S K1=$P(K,"^",8) F I=1:1:3 S @("TPSG"_I)=$S($P(K1,",",I)]"":$P(K1,",",I),1:" ")
 S PSGDR=$S($D(^PSDRUG(+K,0))#2:$P(^(0),"^",1),1:+K)
 Q
