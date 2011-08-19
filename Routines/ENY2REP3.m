ENY2REP3 ;;(WIRMFO)/DH-Y2K Detail by Man~Mod ;1.19.99
 ;;7.0;ENGINEERING;**51,55,61**;August 17, 1993
 ;
DET ; detailed snapshot of Y2K data base by manufacturer~model
 ; list can include all items or a user specified subset
 W @IOF,!!,?15,"** DETAILED REPORT OF Y2K EQUIPMENT DATA BASE **"
 I $P($G(^DIC(6910,1,0)),U,2)']"" W !!,"There is no STATION NUMBER in your Engineering Init Paramaters file.",!,"Can't proceed.",*7 Q
 N ALLSTN,ENSUP,CRITER,ESCAPE,ENY2K,DATE,CAT,CSN,CMR,SRVC,MFG,LOC,END,SHOP,SORT
 S ALLSTN=0
 I $P(^DIC(6910,1,0),U,1)!($D(^DIC(6910,1,3))) D  Q:ALLSTN="^"
 . W !! S DIR(0)="Y",DIR("A")="Do you want a breakout by station",DIR("B")="NO"
 . S DIR("?",1)="If you say 'NO' you will obtain a single report for all your equipment,"
 . S DIR("?")="regardless of which station it belongs to."
 . D ^DIR K DIR I $D(DIRUT) S ALLSTN="^" Q
 . S ALLSTN=Y
 Q:ALLSTN=U
 W !! S DIR(0)="YA",DIR("A")="Shall we ignore equipment records with no Y2K issues? ",DIR("B")="YES"
 S DIR("?",1)="Enter YES if you do not wish the counts to include equipment records for"
 S DIR("?")="which the Y2K CATEGORY is 'FC' or 'NA'."
 D ^DIR K DIR Q:$D(DIRUT)
 S ENSUP=Y
 W !!,"Shall we ignore equipment entries for which either the MANUFACTURER or the" S DIR("A")="MODEL field is null"
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("?",1)="Line items on a Detailed Y2K Report that do not contain both a MANUFACTURER"
 S DIR("?",2)="and a MODEL may be of limited value. Enter 'YES' at this point if you wish"
 S DIR("?")="to suppress them."
 D ^DIR K DIR Q:$D(DIRUT)
 S ENY2K("INC")='Y
 W !! S DIR(0)="SM^1:EQUIPMENT CATEGORY;2:CATEGORY STOCK NUMBER;3:CMR;4:SERVICE;5:MANUFACTURER;6:LOCAL ID;7:RESPONSIBLE SHOP;8:ENTIRE FILE"
 S DIR("A")="How should Equipment Records be selected",DIR("B")="EQUIPMENT CATEGORY"
 S DIR("?",1)="Unless you choose ENTIRE FILE, the system will look only at those equipment"
 S DIR("?")="records that match your selection criteria."
 D ^DIR K DIR Q:$D(DIRUT)
 S CRITER=Y
 I CRITER=1 N CAT D CAT1^ENY2K Q:$G(ESCAPE)  S SORT=CAT G DEV
 I CRITER=2 N CSN D CSN1^ENY2K Q:$G(ESCAPE)  S SORT=CSN G DEV
 I CRITER=3 N CMR D CMR Q:$G(ESCAPE)  S SORT=CMR G DEV
 I CRITER=4 N SRVC D SRVC Q:$G(ESCAPE)  S SORT=SRVC G DEV
 I CRITER=5 N MFG D MFG1^ENY2K Q:$G(ESCAPE)  S SORT=MFG G DEV
 I CRITER=6 N LOC,END D LOC1^ENY2K9 Q:$G(ESCAPE)  S SORT=LOC_"=>"_END G DEV
 I CRITER=7 N SHOP D SHOP Q:$G(ESCAPE)  S SORT=SHOP G DEV
 I CRITER=8 D  S SORT="ENTIRE FILE" G DEV
 . S DA=0 F  S DA=$O(^ENG(6914,DA)) Q:'DA  W:'(DA#200) "." I $D(^(DA,0)),"^4^5^"'[(U_$P($G(^(3)),U)_U) S ^TMP($J,DA)=""
 Q  ;error condition
 ;
CMR K ^TMP($J)
 S DIC="^ENG(6914.1,",DIC(0)="AEQM" D ^DIC I Y'>0 S ESCAPE=1 Q
 S CMR=$P(Y,U,2),CMR(0)=$P(Y,U)
 S (COUNT,DA)=0 F  S DA=$O(^ENG(6914,"AD",CMR(0),DA)) Q:'DA  I $D(^ENG(6914,DA,0)),"^4^5^"'[(U_$P($G(^(3)),U)_U) S COUNT=COUNT+1,^TMP($J,DA)=""
 I 'COUNT W !!,"There are no active equipment records in CMR "_CMR_"." G CMR
 W !!,"There are "_COUNT_" active equipment records in CMR "_CMR_".",!,"Do you wish to proceed?"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 S ENY2K("CONT")=Y I 'ENY2K("CONT") G CMR
 Q
 ;
SRVC K ^TMP($J)
 S DIC="^DIC(49,",DIC(0)="AEQM" D ^DIC I Y'>0 S ESCAPE=1 Q
 S SRVC=$P(Y,U,2),SRVC(0)=$P(Y,U)
 S (COUNT,DA)=0 F  S DA=$O(^ENG(6914,"AC",SRVC(0),DA)) Q:'DA  I $D(^ENG(6914,DA,0)),"^4^5^"'[(U_$P($G(^(3)),U)_U) S COUNT=COUNT+1,^TMP($J,DA)=""
 I 'COUNT W !!,"There are no active equipment entries assigned to "_SRVC_"." G SRVC
 W !!,"There are "_COUNT_" active equipment entries assigned to "_SRVC_".","Do you wish to proceed?"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 S ENY2K("CONT")=Y I 'ENY2K("CONT") G SRVC
 Q
 ;
SHOP K ^TMP($J)
 S DIC="^DIC(6922,",DIC(0)="AEQM" D ^DIC I Y'>0 S ESCAPE=1 Q
 S SHOP=$P(Y,U,2),SHOP(0)=$P(Y,U)
 S (COUNT,DA)=0 F  S DA=$O(^ENG(6914,DA)) Q:'DA  W:'(DA#100) "." I $D(^(0)),$P($G(^(11)),U,7)=SHOP(0),"^4^5^"'[(U_$P($G(^(3)),U)_U) S COUNT=COUNT+1,^TMP($J,DA)=""
 S DA=0 F  S DA=$O(^ENG(6914,"AB",SHOP(0),DA)) Q:'DA  I $D(^ENG(6914,DA,0)),"^4^5^"'[(U_$P($G(^(3)),U)_U) S COUNT=COUNT+1,^TMP($J,DA)=""
 I 'COUNT W !!,"There are no equipment entries assigned to "_SHOP_"." G SHOP
 W !!,"There are "_COUNT_" equipment entries assigned to "_SHOP_".",!,"Do you wish to continue?"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 S ENY2K("CONT")=Y I 'ENY2K("CONT") G SHOP
 Q
 ;
DEV W !! K IO("Q") S %ZIS="QM" D ^%ZIS G:POP EXIT
 I IOM<130 W !,"Sorry, but this report requires at least 130 columns.",*7 G DEV
 I $D(IO("Q")) S ZTRTN="DEQDET^ENY2REP3" D  G EXIT
 . S ZTDESC="Y2K Equipment Snapshot",ZTIO=ION
 . S ZTSAVE("ALLSTN")="",ZTSAVE("ENSUP")="",ZTSAVE("CRITER")=""
 . D NOW^%DTC S DATE=%,ZTSAVE("DATE")="",ZTSAVE("SORT")=""
 . S %X="^TMP($J,",%Y="^XUTL(""ENY2"",DATE," D %XY^%RCR
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
DEQDET ;
 D DEQDET^ENY2REPC
 G EXIT
 ;
HOLD Q:$E(IOST,1,2)'="C-"!($G(ESCAPE))
 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
EXIT ;
 K ^TMP($J)
 I '$D(ZTQUEUED) D ^%ZISC,HOME^%ZIS
 I $D(ZTQUEUED) K ALLSTN,ENSUP,CRITER,SORT S ZTREQN="@"
 K J,K,X
 Q
 ;ENY2REP3
