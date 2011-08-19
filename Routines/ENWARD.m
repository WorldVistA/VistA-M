ENWARD ;(WASH ISC)/DH-Access to Electronic Work Orders ;1.6.97
 ;;7.0;ENGINEERING;**35**;Aug 17, 1993
WRDEDT ;Edit electronic work orders
 S DIC="^ENG(6920,",DIC(0)="AEQM",DIC("S")="I $D(^(1)),$P(^(1),U,1)=DUZ,$P(^(0),U,1)=$P(^(0),U,6)"
 W !! D ^DIC K DIC("S") S DA=+Y G:DA'>0 EXIT
 I $D(^ENG(6920,DA,5)),$P(^(5),U,2)]"" W !!,"This work order has been closed out.",*7 G WRDEDT
 L +^ENG(6920,DA):5 I '$T W !!,"This entry being edited by another user. Please try later.",*7 G WRDEDT
 N ENLOCK S ENLOCK=DA
 S DIE="^ENG(6920,",DR=$S($D(^DIE("B","ENZWOWARD")):"[ENZWOWARD]",1:"[ENWOWARD]")
 D ^DIE L -^ENG(6920,ENLOCK)
WRDEDT2 W !,"Print this work order" S %=2 D YN^DICN G:%=2 WRDEDT I %=0 W !,"Please answer 'Y'es or 'N'o." G WRDEDT2
 D P^ENEWOD
 G WRDEDT
 ;
WRDCK ;Display electronic work order
 D SEL^ENEWOD
 ;
EXIT K ENSHKEY,ENSHABR,DIC,DR,DA,ENA,ENDSTAT,ENWO
 K EN,ENB,ENORIG,ENX,ENNX
 Q
 ;ENWARD
