PRCSHH ; GENERATED FROM 'PRCS CP ITEMHIST-HDR' PRINT TEMPLATE (#1191) ; 10/27/00 ; (FILE 410, MARGIN=80)
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
 S I(0)="^PRCS(410,",J(0)=410
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W "                                ITEM HISTORY"
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W "Item Number: "
 W ?15 D WRITMN^PRCSP1A K DIP K:DN Y
 D N:$X>24 Q:'DN  W ?24 W "Description: "
 W ?39 D WRITMD^PRCSP1A K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>25 Q:'DN  W ?25 W "Qty.    Unit"
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>25 Q:'DN  W ?25 W "Prev.   of                                  Quantity"
 D N:$X>0 Q:'DN  W ?0 W "Date Ordered   PO Number Recd.   Purch.  Unit Cost      Total Cost    Ordered"
 D N:$X>0 Q:'DN  W ?0 W "_____________________________________________________________________________"
 D N:$X>0 Q:'DN  W ?0 W " "
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
