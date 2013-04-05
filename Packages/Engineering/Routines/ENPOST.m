ENPOST ;(WASH ISC)/DH-PostInitialization Routine ;8-16-93
 ;;7.0;ENGINEERING;;Aug 17, 1993
 ;
EN I '$D(ENDATE) S %DT="",X="T" D ^%DT X ^DD("DD") S ENDATE=Y
 S ENX=$S($D(^%ZOSF("VOL")):^%ZOSF("VOL"),1:"ENG"),^ENG("VERSION",7.0,ENX,"DD")=ENDATE
 I $D(^ENG("VERSION"))#10=0 G EXIT
 ;Convert CMR official to pointer
 F DA=0:0 S DA=$O(^ENG(6914.1,DA)) Q:DA'>0  S X=$P(^ENG(6914.1,DA,0),U,2) I X]"",$D(^VA(200,"B",X)) S X=$O(^VA(200,"B",X,0)) S:X>0 $P(^ENG(6914.1,DA,0),U,2)=X
 S DIK="^ENG(""SP"",",DIK(1)=".01^AF" D ENALL^DIK K DIK
 I $E(^ENG("VERSION"))=7 G EXIT
 K ^ENG("WO","C"),^ENG("WO","E"),^ENG("WO","F"),^ENG("WO","G")
 K ^ENG("WO","H"),^ENG("WO","X")
 W !!,"Now re-building your Work Order File."
 F DA=0:0 S DA=$O(^ENG("WO",DA)) Q:DA'>0  D
 . Q:'$D(^ENG("WO",DA,0))  I $E(^ENG("WO",DA,0))="*" Q
 . I $D(^ENG("WO",DA,5)) S ENX=$P(^(5),U) I ENX>0 S $P(^(5),U)="" I $D(^ENG("ACT",ENX)) S ^ENG("WO",DA,8,0)="^6920.035PA^1^1",ENX(0)=$P(^ENG("ACT",ENX,0),U,2),^ENG("WO",DA,8,1,0)=ENX(0)
 . S %X="^ENG(""WO"",DA,",%Y="^ENG(6920,DA," D %XY^%RCR K ^ENG("WO",DA) W:'(DA#20) "."
 K ^ENG("WO")
 W !,"Now re-indexing Work Order File.  This could take awhile..."
 S DIU(0)=""
 S DIK="^ENG(6920," D IXALL^DIK
 K DIK
LOC ;Convert LOCATIONS from free text into pointers
 W !!,"Now converting LOCATIONS in your Equipment File"
 F DA=0:0 S DA=$O(^ENG(6914,DA)) Q:DA'>0  W:'(DA#30) "." D
 . I $D(^ENG(6914,DA,3)) S ENX=$P(^(3),U,5) I ENX]"" D
 .. S ENX1=$O(^ENG("SP","B",ENX,0)) I ENX1>0 D
 ... S $P(^ENG(6914,DA,3),U,5)=ENX1
 ... K ^ENG(6914,"D",ENX,DA)
 ... S ^ENG(6914,"D",ENX1,DA)=""
 W !!,"Now converting Work Order LOCATIONS"
 F DA=0:0 S DA=$O(^ENG(6920,DA)) Q:DA'>0  W:'(DA#30) "." D
 . Q:'$D(^ENG(6920,DA,0))  S ENX=$P(^(0),U,4) I ENX]"",ENX'=" " D
 .. S ENX1=$O(^ENG("SP","B",ENX,0)) I ENX1>0 D
 ... S $P(^ENG(6920,DA,0),U,4)=ENX1
 ... K ^ENG(6920,"C",ENX,DA)
 ... S ^ENG(6920,"C",ENX1,DA)=""
PROJ ;Convert data in File 6925
 W !!,"Now converting a few data elements in your existing construction projects."
 W !,"This shouldn't take very long."
 F DA=0:0 S DA=$O(^ENG("PROJ",DA)) Q:DA'>0  D  W:'(DA#20) "."
 . N STATION Q:'$D(^ENG("PROJ",DA,0))  S STATION=$P(^(0),"-") D:STATION]""
 .. S ENX=$O(^DIC(4,"D",STATION,0)) I ENX>0 S $P(^ENG("PROJ",DA,0),U,4)=ENX
 . I $D(^ENG("PROJ",DA,1)) S EN=^(1) D
 .. S EN1=$P(EN,U,3) I EN1]"" D
 ... S EN1(0)=$S(EN1="A/E":8,EN1="PP":9,EN1="WD":11,EN1="AA":13,EN1="CO":15,1:"")
 ... I EN1(0)'="" S $P(EN,U,3)=EN1(0)
 .. S EN2=$P(EN,U,4) I EN2]"" D
 ... S EN2(0)=$S(EN2="HCF":3,EN2="A/E":1,EN2="O/F":1,1:"")
 ... I EN2(0)'="" S $P(EN,U,4)=EN2(0)
 .. S EN3=$P(EN,U,5) I EN3]"" D
 ... S EN3(0)=$S(EN3="CONTR":1,EN3="P&H":2,EN3="8(a)":4,EN3="HCF":3,1:"")
 ... I EN3(0)'="" S $P(EN,U,5)=EN3(0)
 .. S $P(EN,U,9)=$P(EN,U,6),$P(EN,U,6)=""
 .. S ^ENG("PROJ",DA,1)=EN
 . I $D(^ENG("PROJ",DA,2)) D
 .. S $P(^ENG("PROJ",DA,50),U,2)=$P(^(2),U,2),$P(^(2),U,2)=""
 .. S $P(^ENG("PROJ",DA,50),U,3)=$P(^(2),U,3),$P(^(2),U,3)=""
 . I $D(^ENG("PROJ",DA,3)) D
 .. S $P(^ENG("PROJ",DA,50),U,17)=$P(^(3),U),$P(^(3),U)=""
 .. S $P(^ENG("PROJ",DA,50),U,18)=$P(^(3),U,2),$P(^(3),U,2)=""
 . I $D(^ENG("PROJ",DA,4)) S EN=^(4) D  S ^ENG("PROJ",DA,4)=EN
 .. S $P(EN,U,14)=$P(EN,U,5),$P(EN,U,5)=""
 .. S $P(EN,U,15)=$P(EN,U,6),$P(EN,U,6)=""
 W !,"Now re-indexing"
 S DIK="^ENG(""PROJ""," D IXALL^DIK
EXIT ;
 S ^ENG("VERSION")=7.0
 S %DT="T",X="N" D ^%DT,DD^%DT W !!,"Finished at ",Y,"."
 L  K ENDATE,ENX,ENX1,DA,%X,%Y,DIK,DIU
 K EN,EN1,EN2,EN3
 Q
 ;ENPOST
