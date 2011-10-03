ENEWOD ;(WASH ISC)/DH-Display Electronic Work Order ;2.14.97
 ;;7.0;ENGINEERING;**21,35,38**;Aug 17, 1993
 ;
SEL S DIC="^ENG(6920,",DIC(0)="AEQM" D ^DIC S DA=+Y G:DA'>0 EXIT
 W:$E(IOST,1,2)="C-" @IOF
 D D F  D READ Q:ENX=""  D @ENX
 G SEL
 ;
D N X,EN,ENX,ENDSTAT,ENORIG
 S ENDSTAT=32 F X=1:1:24 S EN(X)=""
FDAT I $D(^ENG(6920,DA,0))>0 S EN(1)=$P(^(0),U),EN(2)=$P(^(0),U,2),EN(3)=$P(^(0),U,3),EN(4)=$P(^(0),U,4),EN(5)=$P(^(0),U,5) S:$E(EN(1),1,3)="PM-" ENDSTAT=35.2
 I EN(3)]"" S EN(3)=$$EXTERNAL^DILFD(6920,2,"",EN(3))
 I EN(4)=+EN(4),$D(^ENG("SP",EN(4),0)) S EN(4)=$P(^(0),U)
FDAT1 I $D(^ENG(6920,DA,1))>0 S EN(10)=$P(^(1),U),EN(7)=$P(^(1),U,2),EN(8)=$P(^(1),U,3),EN(9)=$P(^(1),U,4)
 I EN(10)]"",$D(^VA(200,EN(10),0)) S EN(10)=$P(^VA(200,EN(10),0),U)
 I $D(^ENG(6920,DA,2)) S EN(11)=$P(^(2),U),EN(12)=$P(^(2),U,3) D SSH
 I EN(12)]"" S EN(12)=$$EXTERNAL^DILFD(6920,17,"",EN(12))
FDAT3 I $D(^ENG(6920,DA,3)) S EN(21)=$P(^(3),U),EN(16)=$P(^(3),U,2),EN(20)=$P(^(3),U,4),EN(15)=$P(^(3),U,5),EN(18)=$P(^(3),U,6),EN(19)=$P(^(3),U,7),EN(14)=$P(^(3),U,8)
 S EN(17)=$$GET1^DIQ(6920,DA,21.9)
 I EN(20)]"",$D(^DIC(49,EN(20),0)) S EN(20)=$P(^(0),U)
 I $D(^ENG(6920,DA,4)) S EN(13)=$P(^(4),U) I ENDSTAT=32 S EN(6)=$P(^(4),U,3)
FDAT5 I $D(^ENG(6920,DA,5)) S EN(22)=$P(^(5),U,2),EN(23)=$P(^(5),U,7) I ENDSTAT=35.2 S EN(6)=$P(^(5),U,8)
 I EN(6)]"" S EN(6)=$$EXTERNAL^DILFD(6920,ENDSTAT,"",EN(6))
 D ^ENEWOD1
 I $E(IOST,1,2)="C-" W !! D HOLD^ENEWOD1
 Q
 ;
SSH I $D(^DIC(6922,EN(11),0))>0 S EN(11)=$P(^DIC(6922,EN(11),0),U)
 Q
READ ;  User interaction
 D HOME^%ZIS W !,"D(DISPLAY), P(PRINT): EXIT// " R ENX:DTIME Q:ENX=""
 S ENX=$E(ENX) I ENX'="D",ENX'="P" S ENX=""
 Q
 ;
P ;  Print abbreviated work order (electronic format)
 S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="PRT1^ENEWOD",ZTDESC="Print Electronic Work Order"
 . S ZTSAVE("EN*")="",ZTSAVE("DA")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
PRT1 U IO W:$E(IOST,1,2)="C-" @IOF
 D D
 W @IOF
 I $D(ZTQUEUED) S ZTREQ="@"
 N DA ; to protect DA when W.O. printed to P-MESSAGE
 D ^%ZISC
 Q
 ;
EXIT ;
 Q
 ;ENEWOD
