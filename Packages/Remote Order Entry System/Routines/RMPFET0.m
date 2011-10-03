RMPFET0 ;DDC/KAW-SELECTION ORDER ACTIONS [ 11/06/97  4:53 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**20**;MAY 30, 1995
SELOPT ;; input: RMPFX,RMPFST,RMPFHAT,RMPFTYP
 ;;output: RMPFSEL
 F I=1:1 Q:$Y>20  W !
SELEN W !,"Enter" S FX="" K RMPFSEL Q:'RMPFST
 S SU=$P(^RMPF(791810.2,RMPFST,0),U,2)
 F I="I","P","E","F","D" I SU=I,RMPFTYP'=5 W " Number, <E>dit, <D>elete" S FX=FX_"EeDd" Q
SELOPT0 I RMPFTYP=5!(RMPFTYP=8) D ARRAY^RMPFDT2 D  K RMPFO
 .F I="I","P","E","F","D","S","B" I SU=I D
 ..I $P(^RMPF(791810,RMPFX,0),"^",9)>3010630 D
 ...W:FX'="" "," W " <A>djust" S FX=FX_"Aa"
 ..S (X,FL)=0
 ..F  S X=$O(RMPFO(X)) Q:'X  I $D(^RMPF(791810,RMPFX,101,X,90)),$P(^(90),U,9) S FL=1 Q
 ..I FL,RMPFTYP'=8 W:FX'="" "," W " <I>ssue" S FX=FX_"Ii"
 .S X=0
 .F  S X=$O(RMPFO(X)) Q:'X  S S0=^RMPF(791810,RMPFX,101,X,0),Y=$P(S0,U,18) I Y,$D(^RMPF(791810.2,Y,0)) S Y=$P(^(0),U,2) I "SEDF"[Y D CERT Q:FX["Rr"
 .I SU="C",FX'["A" S X=DT,Z=60 D PASTWKDY D
 ..S X=0
 ..F  S X=$O(RMPFO(X)) Q:'X  I $P(^(0),U,19)'="C" W:FX'="" "," W " <A>djust" S FX=FX_"Aa" Q
 I $O(^RMPF(791810,RMPFX,201,0)) W:FX'="" "," W " <M>essages" S FX=FX_"Mm"
 I $O(^RMPF(791810,RMPFX,301,0)) W:FX'="" "," W " A<U>thorized Aids" S FX=FX_"Uu"
 D CAN I CN W:FX'="" "," W " <C>ancel" S FX=FX_"Cc"
 I "CIX"[RMPFHAT W:FX'="" "," W:$X>69 ! W " <H>istory" S FX=FX_"Hh"
 I RMPFTP="P" W:FX'="" "," W:$X>69 ! W " E<X>tended" S FX=FX_"Xx"
 W:$X>69 ! W:FX'="" " or" W:$X>69 ! W " <RETURN>: "
 D READ G SELOPTE:$D(RMPFOUT) K RMPFF,CN
SELOPT1 I $D(RMPFQUT) D MSG K RMPFSEL G SELOPTE
 I Y="" D ^RMPFEA2:'$D(RMPFERR) G SELOPTE:$D(RMPFOUT) K RMPFX G SELOPTE
 I Y?1N.E,FX["Ee" S RMPFSEL=Y G NUM
 S RMPFSEL=$E(Y,1)
 I FX'[RMPFSEL S RMPFQUT="" G SELOPT1
 I "Ee"[RMPFSEL S RMPFSEL="E" G SELOPTE
 I "Hh"[RMPFSEL D ^RMPFDT7 G SELOPTE
 I "Mm"[RMPFSEL D ^RMPFDT4 G SELOPTE
 I "Dd"[RMPFSEL D DELETE^RMPFET1 G SELOPTE
 I "Ii"[RMPFSEL D ^RMPFET7 G SELOPTE:$D(RMPFOUT) D ^RMPFET2 G SELOPTE
 I "Rr"[RMPFSEL N RMPFSEL D DISP^RMPFET84 G SELOPTE
 I "Aa"[RMPFSEL D ^RMPFET8 G SELOPTE:$D(RMPFOUT) D ^RMPFET2 G SELOPTE
 I "Uu"[RMPFSEL D ^RMPFDT8 G SELOPTE
 I "Cc"[RMPFSEL D ^RMPFET82 G SELOPTE
 I "Xx"[RMPFSEL D ^RMPFDT9 G SELOPTE
NUM K RMPFQUT
 F I=1:1 S Z=$P(Y,",",I) Q:Z=""  D  G SELOPT1:$D(RMPFQUT)
 .I Z?1N.N,Z>0,Z<11 S RMPFSL(Z)="" Q
 .S RMPFQUT="" Q
 I $D(RMPFSL) D SUB^RMPFET5
SELOPTE K I,FX,Y,X,Z,SU,X1,X2,%Y,S0,A,FL
END K ID Q
CERT S A=$G(^RMPF(791810,RMPFX,101,X,90))
 I '$P(A,U,11),$P(S0,U,20) Q
 I '$P(A,U,9),"EDSF"[Y G CERT1
 I $P(A,U,9),"EDF"[Y G CERT1
 I $P(A,U,9),$P(S0,U,19)["R",$P(S0,U,20) G CERT1
 E  Q
CERT1 W:FX'="" "," W:$P(A,U,9) " Re-" W:'$P(A,U,9) " " W "Ce<R>tify" S FX=FX_"Rr" Q
CAN ;;Calculate if CANCEL ALLOWED
 ;; input: RMPFHAT,RMPFX
 ;;output: CN
 D ARRAY^RMPFDT2
 S CN=0 G CANE:"ICXZBDJQW"'[RMPFHAT
 I "ZBDJQW"[RMPFHAT D  G CANE
 .S X=0 F  S X=$O(RMPFO(X)) Q:'X  I RMPFO(X)=18!($P(^RMPF(791810,RMPFX,101,X,0),U,15)="C") S CN=1 Q
 S XX=0 F  S XX=$O(RMPFO(XX)) Q:'XX  D  Q:CN
 .I RMPFO(XX)=5!(RMPFO(XX)=17) S CN=1 Q
 .I RMPFHAT="I",RMPFO(XX)=8 S X=DT,Z=60 D PASTWKDY S ID=$P(^RMPF(791810,RMPFX,101,XX,0),U,8) I ID>Y S CN=1
CANE K X,XX,RMPFO Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
PASTWKDY Q:X'?7N
 ;returns a date Z workdays into the past
 N BD,DW,WK,%H S WK=0 S:'$G(Z) Z=5
W1 S X1=X,X2=-1 D C^%DTC,H^%DTC
 I %Y,%Y<6,'$D(^HOLIDAY(X)) S WK=WK+1
 I WK>Z S Y=X Q
 G W1
MSG W !!,"Enter " S CT=0
 F I=1:2 S X=$E(FX,I) Q:X=""  W:CT ! W ?6,$P($T(@X),";;",2) S CT=CT+1
 F I="I","P","E","D" I SU=I W !?6,"field numbers separated by commas to edit only those fields" Q
 W:FX'="" ! W ?6,"<RETURN> to continue.",!
 W !!!,"Type <RETURN> to continue: " D READ I '$D(RMPFOUT) S RMPFQUT=""
 K CT Q
E ;;<E> to edit all fields of the order
D ;;<D> to delete the entire order
M ;;<M> to view all messages for the order
H ;;<H> to view the order history
I ;;<I> to enter the issue date
A ;;<A> to make an adjustment
C ;;<C> to cancel the order
R ;;<R> to certify that the order was received
U ;;<U> to view a list of authorized hearing aids
X ;;<X> to view the extended information for this order
