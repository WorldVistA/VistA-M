RMPFEA1 ;DDC/KAW-APPROVE/DISAPPROVE ORDERS; [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
SEL ;;input:  RMPFS
 ;;output: RMPFX,RMPFM
 K RMPFX S RMPFM="I" S XX=$P(RMPFSYS,U,6)
 G SELE:'$D(RMPFS)
SEL1 W !!,"Select an order number" I XX W ", <M>ultiple Approval"
 W " or <RETURN> to exit: " D READ G END:$D(RMPFOUT)
SEL11 I $D(RMPFQUT) W !!,"Enter the number to the left of the order you wish to approve",!,"<RETURN> to continue." W:XX "  Enter an <M> to approve multiple orders." G SEL1
 G SELE:Y="" I XX,"Mm"[Y S RMPFM="M" G SELE
 I '$D(RMPFS(Y)) S RMPFQUT="" G SEL11
SEL2 S RMPFX=RMPFS(Y)
SELE K XX,Y Q
MULTI ;;input:  RMPFM
 ;;output:
 G END:RMPFM'="M"
 W !!,"Approve <A>ll orders, by <O>rdering Official, <T>ype of Order or",!,"Numbers of specific orders separated by commas. O// "
 D READ G END:$D(RMPFOUT)
MULTI1 I $D(RMPFQUT) D MSG G MULTI
 S:Y="" Y="O" I "AaOoTt"'[Y&(Y'?1N.E) S RMPFQUT="" G MULTI1
 I Y?1N.E  K RMPFS1 S CT=0 D SUB G MULTI1:$D(RMPFQUT),EXIT
 S Y=$E(Y,1),OR=$S("Aa"[Y:"A","Oo"[Y:"O",1:"T")
 D ORD:OR="O",TYP:OR="T" G END:Y=-1
 S (CT,RMPFX)=0
 F IK=1:1 S RMPFX=$O(^RMPF(791810,"AC",2,RMPFX)) Q:'RMPFX  S S0=$G(^RMPF(791810,RMPFX,0)) I $P(S0,U,15)=$O(^RMPF(791810.5,"C",RMPFMENU,0)),$P(S0,U,3)=2 D SUB1
EXIT W !!,CT," Orders Added to the Batch." D CONT^RMPFEA
END K JJ,KK,IK,OR,CT,Y,RMPFX,RMPFM,DI,I,DIE,DR,D0,DI,D,% Q
SUB F KK=1:1 S JJ=$P(Y,",",KK) Q:JJ=""  D  Q:$D(RMPFQUT)
 .I '$D(RMPFS(JJ)) S RMPFQUT="" Q
 .S RMPFS1(RMPFS(JJ))=""
 S RMPFX=0 F  S RMPFX=$O(RMPFS1(RMPFX)) Q:'RMPFX  D
 .Q:'$D(^RMPF(791810,RMPFX,0))  S RMPFHAT="",X=$P(^(0),U,2)
 .I X,$D(^RMPF(791810.1,X,0)) S RMPFHAT=$P(^(0),U,2)
 .D SET^RMPFEA2 S CT=CT+1
 Q
SUB1 Q:'$D(^RMPF(791810,RMPFX,0))  S S0=^(0),X=$P(S0,U,2),RMPFHAT=""
 I X,$D(^RMPF(791810.1,X,0)) S RMPFHAT=$P(^(0),U,2)
 I OR="O" Q:$P(S0,U,8)'=RMPFAD
 I OR="T" Q:$P(S0,U,2)'=RMPFTYP
 D SET^RMPFEA2 S CT=CT+1
 Q
ORD S DIC=200,DIC(0)="AEQM" D ^DIC Q:Y=-1  S RMPFAD=+Y Q
TYP S DIC=791810.1,DIC(0)="AEQM",DIC("S")="I '$P(^(0),U,7)"
 D ^DIC K DIC Q:Y=-1  S RMPFTYP=+Y Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
MSG W !!,"Enter an <A> to approve all pending orders"
 W !?6,"an <O> or <RETURN> to approve orders for one Ordering Official"
 W !?7,"a <T> to approve orders of one specific type"
 W !?6,"The numbers to the left of orders, separated by commas for specific orders"
 W !?6,"an <^> to exit." Q
