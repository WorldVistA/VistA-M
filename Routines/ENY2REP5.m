ENY2REP5 ;;(WIRMFO)/DH-Overall Y2K Status by Man~Mod ;9.30.98
 ;;7.0;ENGINEERING;**51,55**;August 17, 1993
VIEW ; status of Y2K data base by manufacturer~model
 ; counts only, no costing information
 W @IOF,!!,?20,"** STATUS OF Y2K EQUIPMENT DATA BASE **"
 I $P($G(^DIC(6910,1,0)),U,2)']"" W !!,"There is no STATION NUMBER in your Engineering Init Paramaters file.",!,"Can't proceed.",*7 Q
 S ALLSTN=0
 I $P(^DIC(6910,1,0),U,10)!($D(^DIC(6910,1,3))) D
 . W !! S DIR(0)="Y",DIR("A")="Do you want a breakout by station",DIR("B")="NO"
 . S DIR("?",1)="If you say 'NO' you will obtain a single report for all your equipment,"
 . S DIR("?")="regardless of which station it belongs to."
 . D ^DIR K DIR I $D(DIRUT) S ALLSTN="^" Q
 . S ALLSTN=Y
 I ALLSTN=U K ALLSTN Q
 W !! S DIR(0)="YA",DIR("A")="Shall we ignore equipment records with no Y2K issues? ",DIR("B")="YES"
 S DIR("?",1)="Enter YES if you do not wish the counts to include equipment records for"
 S DIR("?")="which the Y2K CATEGORY is 'FC' or 'NA'."
 D ^DIR K DIR I $D(DIRUT) K ALLSTN Q
 S ENSUP=Y
 W !! K IO("Q") S %ZIS="QM" D ^%ZIS I POP K ALLSTN,ENSUP Q
 I $D(IO("Q")) S ZTRTN="VIEW1^ENY2REP5" D  K ALLSTN,ENSUP G EXIT
 . S ZTDESC="Y2K Equipment Snapshot",ZTIO=ION
 . S ZTSAVE("ALLSTN")="",ZTSAVE("ENSUP")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
VIEW1 K ^TMP($J)
 N MAN,MOD,CAT,PAGE,DATE,LINE,ESCAPE,TOTAL,STATION
 S PAGE=0 D NOW^%DTC S Y=% X ^DD("DD") S DATE("PRNT")=$P(Y,":",1,2)
 S STATION("PARNT")=$P($G(^DIC(6910,1,0)),U,2)
 S STATION=STATION("PARNT")
 S TOTAL(STATION,"GRAND")=0 F J=0,"FC","NC","CC","NA" S TOTAL(STATION,J)=0 ; initialize
 S MAN=0 F  S MAN=$O(^ENG(6914,"K",MAN)) Q:'MAN  S MAN("E")=$P($G(^ENG("MFG",MAN,0)),U) D:MAN("E")]""
 . S DA=0 F  S DA=$O(^ENG(6914,"K",MAN,DA)) Q:'DA  S MOD=$P($G(^ENG(6914,DA,1)),U,2) D:MOD]""
 .. I '$P(^ENG(6914,DA,1),U,4) K ^ENG(6914,"K",MAN,DA) S DA=$O(^ENG(6914,"K",MAN,DA),-1) Q  ;broken x-ref
 .. I "^4^5^"[(U_$P($G(^ENG(6914,DA,3)),U)_U) Q  ;inactive record
 .. S CAT=$P($G(^ENG(6914,DA,11)),U) S:CAT="" CAT=0
 .. I '$D(ZTQUEUED),'(DA#100) W "." ; activity indicator
 .. I ENSUP,"^FC^NA^"[(U_CAT_U) Q  ; suppress the 'don't cares'
 .. I ALLSTN S STATION=$S($P($G(^ENG(6914,DA,9)),U,5)]"":$P(^(9),U,5),1:STATION("PARNT")) D:'$D(TOTAL(STATION))
 ... S TOTAL(STATION,"GRAND")=0 F J=0,"FC","NC","CC","NA" S TOTAL(STATION,J)=0
 .. I '$D(^TMP($J,STATION,MAN("E"),MOD,CAT)) F J=0,"FC","NC","CC","NA" S ^TMP($J,STATION,MAN("E"),MOD,J)=0
 .. S ^TMP($J,STATION,MAN("E"),MOD,CAT)=^(CAT)+1,TOTAL(STATION,CAT)=TOTAL(STATION,CAT)+1
 .. S TOTAL(STATION,"GRAND")=TOTAL(STATION,"GRAND")+1
 ;
VIEWPRT ; print the snapshot
 U IO
 I '$D(^TMP($J)) D VIEWHDR W !!,?15,"<Nothing to print>" D HOLD G EXIT
 S STATION=0 F  S STATION=$O(^TMP($J,STATION)) Q:STATION=""  D VIEWHDR D  D:'$G(ESCAPE) HOLD Q:$G(ESCAPE)  W @IOF
 . S MAN("E")=0 S (MOD,ESCAPE)=0 F  S MAN("E")=$O(^TMP($J,STATION,MAN("E"))) Q:MAN("E")=""  S MAN("PRNT")=$E(MAN("E"),1,20) F  S MOD=$O(^TMP($J,STATION,MAN("E"),MOD)) Q:MOD=""!(ESCAPE)  S MOD("E")=$E(MOD,1,14) D
 .. W !,MAN("PRNT")_"~"_MOD("E"),?42 W:'ENSUP $J(^TMP($J,STATION,MAN("E"),MOD,"FC"),5) W ?48,$J(^TMP($J,STATION,MAN("E"),MOD,"NC"),5),?54,$J(^("CC"),5)
 .. W ?60 W:'ENSUP $J(^TMP($J,STATION,MAN("E"),MOD,"NA"),5) W ?66,$J(^TMP($J,STATION,MAN("E"),MOD,0),5)
 .. S TOTAL=0 F J=0,"FC","NC","CC","NA" S TOTAL=TOTAL+^TMP($J,STATION,MAN("E"),MOD,J)
 .. W ?72,$J(TOTAL,5)
 .. K ^TMP($J,STATION,MAN("E"),MOD)
 .. S LINE=LINE+1 I (IOSL-LINE)'>4 D HOLD Q:ESCAPE  D:$D(^TMP($J)) VIEWHDR
 . I '$G(ESCAPE) D
 .. K X S $P(X,"-",79)="-" W !,X
 .. W !,"TOTALS",?42 W:'ENSUP $J(TOTAL(STATION,"FC"),5) W ?48,$J(TOTAL(STATION,"NC"),5),?54,$J(TOTAL(STATION,"CC"),5),?60 W:'ENSUP $J(TOTAL(STATION,"NA"),5) W ?66,$J(TOTAL(STATION,0),5),?72,$J(TOTAL(STATION,"GRAND"),5)
 G EXIT
 ;
VIEWHDR ; header for Y2K snapshot
 W:$E(IOST,1,2)="C-"!(PAGE) @IOF S PAGE=PAGE+1,LINE=3
 W "Y2K Equipment Status - Counts Only   Printed: "_DATE("PRNT")_"   Page: "_PAGE
 I ENSUP W !,"Equipment Records with Y2K Category of 'FC' or 'NA' are not being counted." S LINE=LINE+1
 W !,"Manufacturer~Model  "_$S('ALLSTN:"(Consolidated: "_STATION("PARNT")_")",1:"(Station: "_STATION_")"),?45,"FC    NC    CC    NA  Null  TOTAL"
 K X S $P(X,"-",79)="-" W !,X
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"
 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
EXIT ;
 K ^TMP($J)
 D ^%ZISC,HOME^%ZIS
 I $D(ZTQUEUED) S ZTREQN="@"
 K J,K,X,ALLSTN,ENSUP
 Q
 ;ENY2REP5
