ENY2REP2 ;;(WIRMFO)/DH-Y2K Category Summary Report ;9.30.98
 ;;7.0;ENGINEERING;**51,55**;August 17, 1993
 ;
Y2KCAT ; snapshot of Y2K data base by manufacturer~model for a given 
 ; Y2K category
 W @IOF,!!,?20,"** SNAPSHOT OF Y2K EQUIPMENT DATA BASE **"
 W !,?22,"(Summary for a specific Y2K category)"
 I $P($G(^DIC(6910,1,0)),U,2)']"" W !!,"There is no STATION NUMBER in your Engineering Init Paramaters file.",!,"Can't proceed.",*7 Q
 S ALLSTN=0
 I $P(^DIC(6910,1,0),U,10)!($D(^DIC(6910,1,3))) D  I ALLSTN="^" K ALLSTN Q
 . W !! S DIR(0)="Y",DIR("A")="Do you want a breakout by station",DIR("B")="NO"
 . S DIR("?",1)="If you say 'NO' you will obtain a single report for all your equipment,"
 . S DIR("?")="regardless of which station it belongs to."
 . D ^DIR K DIR I $D(DIRUT) S ALLSTN="^" Q
 . S ALLSTN=Y
 S DIR(0)="SM^FC:FULLY COMPLIANT;CC:CONDITIONALLY COMPLIANT;NC:NON-COMPLIANT;NA:NOT APPLICABLE;NL:NULL",DIR("A")="Please select the Y2K CATEGORY for which you would like counts",DIR("B")="CC"
 S DIR("?",1)="FULLY COMPLIANT => Device will function properly in all respects on"
 S DIR("?",2)="     January 1, 2000 without user intervention."
 S DIR("?",3)="CONDITIONALLY COMPLIANT => Device requires user intervention to function"
 S DIR("?",4)="     properly in all respects on January 1, 2000. This may include a"
 S DIR("?",5)="     manufacturer software and/or hardware update or other one-time"
 S DIR("?",6)="     user action."
 S DIR("?",7)="NON-COMPLIANT => Device will not function properly on January 1, 2000 and"
 S DIR("?",8)="     no manufacturer remedy is available. Site must decide whether to"
 S DIR("?",9)="     retire, replace, renovate/upgrade, or retain and use this device."
 S DIR("?",10)="NOT APPLICABLE => There are no Y2K implications for this  device."
 S DIR("?")="NULL => No Y2K category has been entered for this device."
 D ^DIR K DIR I $D(DIRUT) K ALLSTN Q
 S CAT=Y,CAT("E")=Y(0)
 W !! K IO("Q") S %ZIS="QM" D ^%ZIS I POP K ALLSTN,CAT Q
 I $D(IO("Q")) S ZTRTN="Y2KCAT1^ENY2REP2" D  K ALLSTN,CAT G EXIT
 . S ZTDESC="Y2K Equipment Snapshot by Y2K Category"
 . S ZTSAVE("ALLSTN")="",ZTSAVE("CAT")="",ZTSAVE("CAT(""E"")")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
Y2KCAT1 K ^TMP($J)
 N MAN,MOD,PAGE,DATE,LINE,ESCAPE,TOTAL,STATION,DA,REPL,EST,ACT
 S PAGE=0 D NOW^%DTC S Y=% X ^DD("DD") S DATE("PRNT")=$P(Y,":",1,2)
 S STATION("PARNT")=$P($G(^DIC(6910,1,0)),U,2)
 S STATION=STATION("PARNT")
 F J="COUNT","EST","ACT" S TOTAL(STATION,J)=0 ; initialize
 S MAN=0 F  S MAN=$O(^ENG(6914,"K",MAN)) Q:'MAN  S MAN("E")=$P($G(^ENG("MFG",MAN,0)),U) D:MAN("E")]""
 . S DA=0 F  S DA=$O(^ENG(6914,"K",MAN,DA)) Q:'DA  S MOD=$P($G(^ENG(6914,DA,1)),U,2) D:MOD]""
 .. I '$D(ZTQUEUED),'(DA#100) W "." ; activity indicator
 .. Q:"^4^5^"[(U_$P($G(^ENG(6914,DA,3)),U)_U)  ; ck for turn-ins
 .. S EN=$G(^ENG(6914,DA,11))
 .. S CAT("DA")=$P(EN,U) S:CAT("DA")="" CAT("DA")="NL"
 .. Q:CAT("DA")'=CAT  ;not what we're counting
 .. I ALLSTN S STATION=$S($P($G(^ENG(6914,DA,9)),U,5)]"":$P(^(9),U,5),1:STATION("PARNT")) I '$D(TOTAL(STATION)) F J="COUNT","EST","ACT" S TOTAL(STATION,J)=0
 .. I '$D(^TMP($J,STATION,MAN("E"),MOD)) F J="COUNT","EST","ACT" S ^TMP($J,STATION,MAN("E"),MOD,J)=0
 .. S TOTAL(STATION,"COUNT")=TOTAL(STATION,"COUNT")+1,^TMP($J,STATION,MAN("E"),MOD,"COUNT")=^TMP($J,STATION,MAN("E"),MOD,"COUNT")+1
 .. I CAT="FC" D  Q
 ... S TOTAL(STATION,"EST")=TOTAL(STATION,"EST")+$P(EN,U,3),TOTAL(STATION,"ACT")=TOTAL(STATION,"ACT")+$P(EN,U,4)
 ... S ^TMP($J,STATION,MAN("E"),MOD,"EST")=^TMP($J,STATION,MAN("E"),MOD,"EST")+$P(EN,U,3),^("ACT")=^("ACT")+$P(EN,U,4)
 .. I CAT="CC" D  Q
 ... S TOTAL(STATION,"EST")=TOTAL(STATION,"EST")+$P(EN,U,3)
 ... S ^TMP($J,STATION,MAN("E"),MOD,"EST")=^TMP($J,STATION,MAN("E"),MOD,"EST")+$P(EN,U,3)
 .. I CAT="NC" D
 ... S ACT=0,EST=0,REPL=""
 ... I $P(EN,U,6)="REP" S EST=$P($G(^ENG(6914,DA,2)),U,3),REPL=$O(^ENG(6914,"AO",DA,0))
 ... I REPL,$D(^ENG(6914,REPL,2)) S ACT=$P(^(2),U,3)
 ... S TOTAL(STATION,"EST")=TOTAL(STATION,"EST")+EST,TOTAL(STATION,"ACT")=TOTAL(STATION,"ACT")+ACT
 ... S ^TMP($J,STATION,MAN("E"),MOD,"EST")=^TMP($J,STATION,MAN("E"),MOD,"EST")+EST,^("ACT")=^("ACT")+ACT
 .. Q
 ;
CATPRNT ; print the snapshot
 U IO W:$E(IOST,1,2)="C-" @IOF
 I '$D(^TMP($J)) D CATHDR W !!,?15,"<Nothing to print>" D HOLD G EXIT
 S STATION=0 F  S STATION=$O(^TMP($J,STATION)) Q:STATION=""!($G(ESCAPE))  D CATHDR D  D HOLD Q:$G(ESCAPE)  W @IOF
 . S MAN("E")=0 S (MOD,ESCAPE)=0 F  S MAN("E")=$O(^TMP($J,STATION,MAN("E"))) Q:MAN("E")=""  S MAN("PRNT")=$E(MAN("E"),1,30) F  S MOD=$O(^TMP($J,STATION,MAN("E"),MOD)) Q:MOD=""!(ESCAPE)  S MOD("E")=$E(MOD,1,20) D
 .. W !,MAN("PRNT")_"~"_MOD("E"),?51,$J(^TMP($J,STATION,MAN("E"),MOD,"COUNT"),4),?60,$J(^("EST"),8,2),?70,$J(^("ACT"),8,2)
 .. K ^TMP($J,STATION,MAN("E"),MOD)
 .. S LINE=LINE+1 I (IOSL-LINE)'>4 D HOLD Q:ESCAPE  I $D(^TMP($J)) W @IOF D CATHDR
 . Q:$G(ESCAPE)
 . K X S $P(X,"-",79)="-" W !,X
 . W !,"TOTALS",?50,$J(TOTAL(STATION,"COUNT"),5),?60,$J(TOTAL(STATION,"EST"),8,2),?70,$J(TOTAL(STATION,"ACT"),8,2)
 G EXIT
 ;
CATHDR ; header for Y2K snapshot
 S PAGE=PAGE+1,LINE=3
 W "Y2K Summary Snapshot for "_CAT("E")_"   "_DATE("PRNT")_" ",?70,"Page: "_PAGE
 W !,"Manufacturer~Model   "_$S('ALLSTN:"Consolidated",1:"Station: "_STATION),?50,"Count  Estimated $  Actual $"
 K X S $P(X,"-",79)="-" W !,X
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"!($G(ESCAPE))
 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
EXIT ;
 K ^TMP($J) D ^%ZISC,HOME^%ZIS
 I $D(ZTQUEUED) S ZTREQN="@"
 K EN,J,K,X,ALLSTN,CAT
 Q
 ;ENY2REP2
