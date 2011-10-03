ENSA9 ;(WASH ISC)/DH-MedTester Upload, Gen Regular WO ;4-10-94
 ;;7.0;ENGINEERING;**1,14**;Aug 17, 1993
NEWWO N SHOPKEY,CODE,NUMBER,DA,ENDA
 S SHOPKEY=ENSHKEY
 F EN1=0:0 S EN1=$O(^ENG(6920,"G",ENEQ,EN1)) Q:EN1'>0  I $D(^ENG(6920,EN1,2)),$P(^(2),U)=SHOPKEY,$E($P(^(0),U),1,3)'="PM-" Q:'$D(^(5))  Q:$P(^(5),U,2)=""
 I EN1>0 D  D XCPTN^ENSA2 Q
 . S NUMBER=$P(^ENG(6920,EN1,0),U)
 . S ENMSG(0,2)="Regular work order "_NUMBER_" is open."
 D WONUM^ENWONEW
 I NUMBER="" D XCPTN^ENSA2 Q
 S ENMSG(0,2)="Regular work order "_NUMBER_" has been generated."
 S DIE="^ENG(6920,",DR=".05///^S X=NUMBER;1///^S X=DT;2///^S X=""C"";6///^S X=PROBLEM;7.5////^S X=.5;9///^S X=ENSHKEY;16///^S X=ENTEC;17///^S X=""A"";18///^S X=ENEQ;32///^S X=""PENDING"""
 D ^DIE
 I ENTIME>0 D
 . S $P(^ENG(6920,DA,5),U,3)=ENTIME
 . S:$D(^ENG(6920,DA,7,1,0)) $P(^(0),U,2)=ENTIME
 . I ENTEC>0 D
 .. S ENW=$P($G(^ENG("EMP",ENTEC,0)),U,3)
 .. I ENW="" S ENW=$P($G(^DIC(6910,1,0)),U,4)
 .. I ENW>0 S X=ENW*ENTIME,X(0)=2 D ROUND^ENLIB S $P(^ENG(6920,DA,5),U,6)=+Y
 S ^ENG(6920,DA,8,0)="^6920.035PA^1^1",DIE="^ENG(6920,DA(1),8,",(ENDA,DA(1))=DA,DA=1,DR=".01///^S X=""GENERAL REPAIR (In-house)""" D ^DIE K DA,DIE S DA=ENDA,DIE="^ENG(6920,"
 I ENLOC]"" D
 . I $D(^ENG("SP","B",ENLOC)) S DR="3///^S X=ENLOC" D ^DIE Q
 . I ENLOC["E" D
 .. S ENLOC(0)=ENLOC F  S ENLOC(0)=$P(ENLOC(0),"E")_"e"_$P(ENLOC(0),"E",2,99) I $D(^ENG("SP","B",ENLOC(0)))!(ENLOC(0)'["E") Q
 .. I $D(^ENG("SP","B",ENLOC(0))) S DR="3///^S X=ENLOC(0)" D ^DIE
 .. Q
 D XCPTN^ENSA2
 Q
 ;ENSA9
