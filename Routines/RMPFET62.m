RMPFET62 ;DDC/KAW-CONTINUATION OF RMPFET [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
SEL ;;Select a line item from existing line item orders
 ;; input: RMPFX,RMPFMD,RMPFMC,RMPFHAT
 ;;output: RMPFY,Y1
 W !!,"Enter <E>dit, <D>elete" S SX="EeDd"
 S FL=1 D ADD I FL W ", <A>dd" S SX=SX_"Aa"
 D CAN^RMPFET0 I CN=1 W ", <C>ancel" S SX=SX_"Cc"
 W " or <RETURN> to continue: " K Y1
 D READ G SELE:$D(RMPFOUT)
SEL1 I $D(RMPFQUT) D  G SEL
 .W !!," Enter an <E> to edit an item,"
 .W !?8,"a <D> to delete an item"
 .W !?7,"an <A> to add an item or",!?8,"a <RETURN> to continue."
 .I SX["C" W !?8,"a <C> to cancel an item"
 .I RMPFMC>1 W !," If editing or deleting, enter the number of the item after the function choice",!?6,"(ex: E2)."
 .W !!,"A maximum of two aids may be ordered with a monaural fitting and"
 .W !,"a maximum of four aids may be ordered with a binaural fitting."
 G SELE:Y="" S Y1=$E(Y,1) I SX'[Y1 S RMPFQUT="" G SEL1
 I "Aa"[Y1 G SELE
 S Y2=$E(Y,2,99) I Y2,$D(RMPFMD(Y2)) S RMPFY=RMPFMD(Y2) G SELE
 I RMPFMC=1 S RMPFY=RMPFMD(1) G SELE
SEL2 W !!,"Select number of item: " D READ G SELE:$D(RMPFOUT)!(Y="")
SEL3 I $D(RMPFQUT) W !!,"Enter the number to the left of the item you wish to edit or <RETURN> to continue." G SEL2
 G SELE:Y="" I '$D(RMPFMD(Y)) S RMPFQUT="" G SEL2
 S RMPFY=RMPFMD(Y)
SELE K X,Y,Y2,I,CN,SX,FL Q
ADD S F=$P($G(^RMPF(791810,RMPFX,11)),U,1) G ADDE:F="" D ARRAY^RMPFDT2
 S (X,C)=0 F  S X=$O(RMPFO(X)) Q:'X  S C=C+1
 I F="M",C>1 S FL=0
 I F="B",C>3 S FL=0
ADDE K C,F,X Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
