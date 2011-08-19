ENWOD1 ;(WASH ISC)/DLM/DH-Formatted Work Order Display ;1.28.97
 ;;7.0;ENGINEERING;**35**;Aug 17, 1993
 ;  Expects DA as work order IEN
ST N X S ENDSTAT=32 F X=1:1:33 S EN(X)=""
FDAT G:'$D(^ENG(6920,DA,0)) EXIT S X(0)=^(0) S ENWO=$P(X(0),U,1),EN(2)=$P(X(0),U,2),EN(3)=$P(X(0),U,3),EN(4)=$P(X(0),U,4),EN(5)=$P(X(0),U,5) S:$E(ENWO,1,3)="PM-" ENDSTAT=35.2
 I EN(3)]"" S EN(3)=$$EXTERNAL^DILFD(6920,2,"",EN(3))
 I EN(4)=+EN(4),$D(^ENG("SP",EN(4),0)) S EN(4)=$P(^(0),U)
FDAT1 I $D(^ENG(6920,DA,1)) S X(1)=^(1),EN(10)=$P(X(1),U,1),EN(7)=$P(X(1),U,2),EN(8)=$P(X(1),U,3),EN(9)=$P(X(1),U,4)
 I $D(^ENG(6920,DA,2)) S X(2)=^(2),EN(11)=$P(X(2),U,1),EN(1)=$P(X(2),U,2),EN(13)=$P(X(2),U,3) D SSH
 I EN(13)]"" S EN(13)=$$EXTERNAL^DILFD(6920,17,"",EN(13))
FDAT3 I $D(^ENG(6920,DA,3)) S X(3)=^(3),EN(22)=$P(X(3),U),EN(16)=$P(X(3),U,2),EN(21)=$P(X(3),U,4),EN(15)=$P(X(3),U,5),EN(19)=$P(X(3),U,6),EN(20)=$P(X(3),U,7),EN(14)=$P(X(3),U,8)
 I EN(14) S EN(17)=$$GET1^DIQ(6914,EN(14),53)
 S EN(18)=$$GET1^DIQ(6920,DA,21.9)
 I $D(^ENG(6920,DA,4)) S X(4)=^(4),EN(12)=$P(X(4),U,1),EN(23)=$P(X(4),U,2),EN(29)=$P(X(4),U,4) I ENDSTAT=32 S EN(6)=$P(X(4),U,3)
FDAT5 I $D(^ENG(6920,DA,5)) S X(5)=^(5),EN(31)=$P(X(5),U,2),EN(26)=$P(X(5),U,3),EN(27)=$P(X(5),U,4),EN(25)=$P(X(5),U,5),EN(28)=$P(X(5),U,6),EN(32)=$P(X(5),U,7) S:ENDSTAT=35.2 EN(6)=$P(X(5),U,8)
ACT I $D(^ENG(6920,DA,8)) D
 . F I=0:0 S I=$O(^ENG(6920,DA,8,I)) Q:I'>0!($L(EN(24))=8)  S J=$P(^ENG(6920,DA,8,I,0),U),EN(24)=EN(24)_$P(^ENG(6920.1,J,0),U,2)
 I EN(25)]"",$D(^DIC(6921,EN(25),0)) S EN(25)=$P(^(0),U,1)
MTEC S (EN(30,1),EN(30,2))="" I $D(^ENG(6920,DA,7,0)) S ENJ=101 D MTECH
 I EN(6)]"" S EN(6)=$$EXTERNAL^DILFD(6920,ENDSTAT,"",EN(6))
 I EN(10)]"",$D(^VA(200,EN(10),0)) S EN(10)=$P(^(0),U)
SSH I EN(11)]"",$D(^DIC(6922,EN(11),0))>0 S EN(11)=$P(^DIC(6922,EN(11),0),U)
 Q
 ;
MTECH F ENTNX=0:0 S ENTNX=$O(^ENG(6920,DA,7,ENTNX)) Q:ENTNX'>0  D
 . S EN(ENJ)=$P(^(ENTNX,0),U),EN(ENJ,1)=$P(^(0),U,2),EN(ENJ,2)=$P(^(0),U,3)
 . S:EN(ENJ,2)]"" EN(ENJ,2)=$S($D(^DIC(6922,EN(ENJ,2),0)):$P(^(0),U,1),1:"") S ENJ=ENJ+1
 Q
EXIT ;
 K ENDSTAT
 Q
 ;ENWOD1
