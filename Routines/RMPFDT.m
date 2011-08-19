RMPFDT ;DDC/KAW-PATIENT ORDER INFORMATION; [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
 W @IOF,!!,"PATIENT ORDER INFORMATION"
PAT W ! S DIC=2,DIC(0)="AEQM" D ^DIC G END:Y=-1 K DIC S DFN=+Y
ORDERS S (RMPFORD,RMPFTP)="P" D ^RMPFDS1 G END:$D(RMPFOUT),PAT:'RMPFCX
 D SEL G END:$D(RMPFOUT),RMPFSET:'$D(RMPFX)
 S RMPFHAT="",X=$P(^RMPF(791810,RMPFX,0),U,2) I X,$D(^RMPF(791810.1,X,0)) S RMPFHAT=$P(^(0),U,2)
ORDERS0 D ^RMPFDT1 G END:$D(RMPFOUT)
ORDERS1 D CONT G END:$D(RMPFOUT),ORDERS0:$D(RMPFX),RMPFSET
END K DFN,RMPFORD,RMPFTP,RMPFHAT,Y,RMPFCX,CN,RMPFOUT,RMPFQUT,RMPFX,RMPFO
 K DISYS,DIC,%,%Y,C,I,J,X,T,CM,L Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
CONT F I=1:1 Q:$Y>(IOSL-4)  W !
 W !,"Type <P>rint, E<X>tended"
 I $O(^RMPF(791810,RMPFX,201,0)) W ", <M>essages"
 I "CIX"[RMPFHAT W ", <H>istory"
 I $O(^RMPF(791810,RMPFX,301,0)) W ", <A>uthorized Aids"
 W:$X>65 ! W " or <RETURN> to continue: " D READ Q:$D(RMPFOUT)
CONT1 I $D(RMPFQUT) D MSG G CONT1:$D(RMPFQUT) Q
 I Y="" K RMPFX Q
 S Y=$E(Y,1) I "Mm"[Y D ^RMPFDT4 Q
 I "CIX"[RMPFHAT,"Hh"[Y D ^RMPFDT7 Q
 I "Aa"[Y D ^RMPFDT8 Q
 I "Xx"[Y D ^RMPFDT9 Q
 S:Y="p" Y="P" I Y'="P" K I Q
QUE W ! S %ZIS="QNP" D ^%ZIS G END:POP
 I IO=IO(0),'$D(IO("S")) D ^RMPFDT1 D QUEE G CONT
 I $D(IO("S")) S %ZIS="",IOP=ION D ^%ZIS G ^RMPFDT1
 S ZTRTN="^RMPFDT1",ZTSAVE("RMPF*")="",ZTIO=ION D ^%ZTLOAD
 D HOME^%ZIS W:$D(ZTSK) !!,"*** Request Queued ***" H 2
QUEE K %T,%ZIS,POP,ZTRTN,ZTSAVE,ZTIO,ZTSK Q
SEL ;;input:  RMPFS
 ;;output: RMPFX
 K RMPFX F I=1:1 Q:$Y>20  W !
 W !!!,"Enter the number of the order to view detail or <^> to exit. "
 D READ G SELE:$D(RMPFOUT)
S1 I $D(RMPFQUT) W !!,"Enter the number to the left of the order you wish to view or",!?5," an <^> to exit." G SEL
 G SELE:Y="" I '$D(RMPFS(Y)) S RMPFQUT="" G S1
 S RMPFX=RMPFS(Y)
SELE K RMPFS,Y,I Q
MSG W !!,"Enter <P> to print this screen"
 W:RMPFTP'="S" !?6,"<X> to view the Extended Information Screen"
 I $O(^RMPF(791810,RMPFX,201,0)) W !?6,"<M> to view messages for this order"
 I $P(^RMPF(791810,RMPFX,0),U,2)=2 W !?6,"<H> to view the history of this order"
 W !?6,"<RETURN> to continue."
 W !!,"Enter <RETURN> to continue." D READ
 Q
