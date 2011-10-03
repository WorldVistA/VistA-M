RMPR4EPC ;PHX/HNB -EDIT PURCHASE CARD TRANSACTION ;3/12/1996
 ;;3.0;PROSTHETICS;**3,15**;Feb 09, 1996
 I '$D(RMPR) D DIV4^RMPRSIT G:$D(X) EXIT
 W ! S DIC="^RMPR(664,",DIC(0)="AEMQZ",DIC("A")="Select PATIENT: "
 S DIC("W")="D EN2^RMPR4D1"
 S DIC("S")="I $D(^(4)) I ('$P(^(0),U,5)),($P(^(0),U,14)=RMPR(""STA""))" W !
 D ^DIC G:+Y'>0 EXIT L +^RMPR(664,+Y,0):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" G EXIT
 S (RMPRDA,DA)=+Y,DIE=DIC,DR="[RMPR4 PC]" D ^DIE
 S BO=0,BA=$P(^RMPR(664,RMPRDA,4),U,2)
 ;ba is bank authorization number
 F  S BO=$O(^RMPR(664,RMPRDA,1,BO)) Q:BO'>0  D
 .S R660=$P(^RMPR(664,RMPRDA,1,BO,0),U,13)
 .S $P(^RMPR(660,R660,4),U,2)=BA
 L -^RMPR(664,DA,0)
 W ! S DIR(0)="Y",DIR("A")="Would You like to Edit another Entry (Y/N) " D ^DIR
 G:'$D(DTOUT)&(Y>0) RMPR4EPC
EXIT ;common exit point
 K DIC,DIE,DIR,%,X,Y,BA,BO,DA,DR,DTOUT,DUOUT,R660,RMPRDA Q
