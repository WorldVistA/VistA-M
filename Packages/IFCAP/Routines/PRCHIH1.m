PRCHIH1 ; GENERATED FROM 'PRCH ITEM TXHIST-HDR' PRINT TEMPLATE (#1192) ; 10/27/00 ; (FILE 442, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 S I(0)="^PRC(442,",J(0)=442
 D N:$X>0 Q:'DN  W ?0 W "Item Number:"
 W ?14 W ITMNO K DIP K:DN Y
 D N:$X>24 Q:'DN  W ?24 W "Description:"
 W ?38 W ITMDESC K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " "
 S X=$G(^PRC(442,D0,0)) W ?3,$E($P(X,U,3),1,30)
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>24 Q:'DN  W ?24 W "Quantity"
 D N:$X>24 Q:'DN  W ?24 W "Previously  Unit of"
 D N:$X>71 Q:'DN  W ?71 W "Quantity"
 D N:$X>0 Q:'DN  W ?0 W "Date Ordered  PO Number Received    Purchase  Unit Cost  Total Cost     Ordered"
 D N:$X>0 Q:'DN  W ?0 W "------------ ---------- ----------- --------  ---------  ----------    --------"
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
