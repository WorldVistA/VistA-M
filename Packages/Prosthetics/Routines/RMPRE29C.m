RMPRE29C ;PHX/JLT,RVD-EDIT 2319 ;10/2/03  13:04
 ;;3.0;PROSTHETICS;**150**;Feb 09, 1996;Build 10
 ;
 ;Used to carve out edting of Vendor, Quantity and Cost
 ;uses DBIA # 1995 & 1997.
 W ! S DIC="^RMPR(660,",DIC(0)="AEMQZ",DIC("A")="Select PATIENT: "
 S DIC("W")="D EN^RMPRD1",RMEND=0
 S DIC("S")="I ($P(^(0),U,6)!($P(^(0),U,26)'="""")),($P(^(0),U,13)'=11)" W !
 D ^DIC G:+Y'>0 EXIT L +^RMPR(660,+Y,0):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" G EXIT
 S DIE=DIC,(RMPRDA,DA)=+Y
 S R1(0)=$G(^RMPR(660,RMPRDA,0)),R1(1)=$G(^(1)),R1("AM")=$G(^("AM"))
 S RMTOTCOS=$P(R1(0),U,16)
 ;
 S DR="7;5;14" D ^DIE
 I RMTOTCOS'=$P(^RMPR(660,DA,0),U,16) S DR="35////^S X=DUZ;36////^S X=DT" D ^DIE
 I $D(DTOUT)!('$G(Y))!($D(DUOUT))
 L -^RMPR(660,RMPRDA,0)
 K DIR W ! S DIR(0)="Y",DIR("A")="Would You like to Edit another Entry (Y/N) " D ^DIR
 G:'$D(DTOUT)&(Y>0) RMPRE29C
EXIT ;
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 K DIC,DIE,DIR,%,X,Y
 Q
