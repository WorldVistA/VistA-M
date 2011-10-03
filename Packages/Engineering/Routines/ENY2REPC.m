ENY2REPC ;;(WIRMFO)/DH-Y2K Detail by Man~Mod ;1.19.99
 ;;7.0;ENGINEERING;**61**;August 17, 1993
 ;
DEQDET ;
 I $D(ZTQUEUED) D
 . K ^TMP($J)
 . S %X="^XUTL(""ENY2"",DATE,",%Y="^TMP($J," D %XY^%RCR K DATE
 . N ESCAPE,ENY2K,DATE,MFG
 . K ^XUTL("ENY2")
 N MOD,PAGE,DATE,LINE,TOTAL,STATION
 S PAGE=0 D NOW^%DTC S Y=% X ^DD("DD") S DATE("PRNT")=$P(Y,":",1,2)
 S STATION("PARNT")=$P($G(^DIC(6910,1,0)),U,2)
 S STATION=STATION("PARNT")
 F J="COUNT","ACT","EST" S TOTAL(J)=0,TOTAL(STATION,J)=0 ; initialize
 K ^TMP($J,"ENY2")
 S DA=0 F  S DA=$O(^TMP($J,DA)) Q:'DA  D:$D(^ENG(6914,DA,0))
 . I '$D(ZTQUEUED) W:'(DA#100) "." ; activity indicator
 . S CAT=$P($G(^ENG(6914,DA,11)),U) S:CAT="" CAT="Null"
 . I ENSUP,"^FC^NA^"[(U_CAT_U) Q  ; suppress the 'don't cares'
 . I ALLSTN S STATION=$S($P($G(^ENG(6914,DA,9)),U,5)]"":$P(^(9),U,5),1:STATION("PARNT")) I '$D(TOTAL(STATION)) S TOTAL(STATION,"GRAND")=0 F J="COUNT","ACT","EST" S TOTAL(STATION,J)=0
 . S MFG(0)=$P($G(^ENG(6914,DA,1)),U,4)
 . I 'MFG(0),'$G(ENY2K("INC")) Q
 . I 'MFG(0) S MFG("E")="unknown"
 . E  S MFG("E")=$E($P(^ENG("MFG",MFG(0),0),U),1,25) S:MFG("E")="" MFG("E")=" "
 . S MOD=$P($G(^ENG(6914,DA,1)),U,2)
 . I MOD="",'$G(ENY2K("INC")) Q
 . I MOD="" S MOD("E")="unknown"
 . E  S MOD("E")=$S($L(MOD)<21:MOD,1:$E(MOD,1,19)_"*")
 . S EQ(0)=$P($G(^ENG(6914,DA,1)),U) S:EQ(0)="" EQ("E")="Null"
 . I EQ(0) S EQ("E")=$E($P($G(^ENG(6911,EQ(0),0)),U),1,20) S:EQ("E")="" EQ("E")="Null"
 . F J="EDATE","ADATE","ECOST","ACOST","ACTN" S ENY2K(J)=""
 . S EN=$G(^ENG(6914,DA,11)) I EN]"" D
 .. S Y=$P(EN,U,2) I Y>0 S ENY2K("EDATE")=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 .. S Y=$P(EN,U,10) I Y>0 S ENY2K("ADATE")=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 .. S ENY2K("ECOST")=$P(($P(EN,U,3)+.5),"."),ENY2K("ACOST")=$P(($P(EN,U,4)+.5),"."),ENY2K("ACTN")=$P(EN,U,6)
 . S ^TMP($J,"ENY2",STATION,MFG("E"),MOD("E"),EQ("E"),DA)=CAT_U_ENY2K("EDATE")_U_ENY2K("ADATE")_U_ENY2K("ECOST")_U_ENY2K("ACOST")_U_ENY2K("ACTN")
 . S TOTAL(STATION,"COUNT")=TOTAL(STATION,"COUNT")+1,TOTAL(STATION,"EST")=TOTAL(STATION,"EST")+ENY2K("ECOST"),TOTAL(STATION,"ACT")=TOTAL(STATION,"ACT")+ENY2K("ACOST")
 I '$D(^TMP($J,"ENY2")) D DETHDR W !!,"<There are no equipment records with outstanding Y2K issues>" Q
 S STATION=0 F  S STATION=$O(^TMP($J,"ENY2",STATION)) Q:STATION=""  S TOTAL("COUNT")=TOTAL("COUNT")+TOTAL(STATION,"COUNT"),TOTAL("EST")=TOTAL("EST")+TOTAL(STATION,"EST"),TOTAL("ACT")=TOTAL("ACT")+TOTAL(STATION,"ACT")
 ;
DETPRNT ; print the detail
 U IO
 I '$D(^TMP($J)) D DETHDR W !!,?15,"<Nothing to print>" D HOLD Q
 S STATION=0 F  S STATION=$O(^TMP($J,"ENY2",STATION)) Q:STATION=""!($G(ESCAPE))  D DETHDR D  D HOLD Q:$G(ESCAPE)  W @IOF
 . S MFG("E")=0,MOD("E")=0 F  S MFG("E")=$O(^TMP($J,"ENY2",STATION,MFG("E"))) Q:MFG("E")=""!($G(ESCAPE))  F  S MOD("E")=$O(^TMP($J,"ENY2",STATION,MFG("E"),MOD("E"))) Q:MOD("E")=""!($G(ESCAPE))  D  Q:$G(ESCAPE)
 .. S EQ("E")=0 F  S EQ("E")=$O(^TMP($J,"ENY2",STATION,MFG("E"),MOD("E"),EQ("E"))) Q:EQ("E")=""!($G(ESCAPE))  S DA=0 F  S DA=$O(^TMP($J,"ENY2",STATION,MFG("E"),MOD("E"),EQ("E"),DA)) Q:'DA!($G(ESCAPE))  S EN=^(DA) D
 ... I '$D(ZTQUEUED),IO'=IO(0),'(DA#50) U IO(0) W "." U IO ; activity indicator
 ... W !,MFG("E")_"~"_MOD("E")_" ",?42,EQ("E")_" ",?64,$J(DA,10),?75,$J($P(EN,U),4),?82,$P(EN,U,2),?93,$P(EN,U,3),?104,$J($P(EN,U,4),7),?114,$J($P(EN,U,5),7),?124,$P(EN,U,6)
 ... K ^TMP($J,"ENY2",STATION,MFG("E"),MOD("E"),EQ("E"),DA)
 ... S LINE=LINE+1 I (IOSL-LINE)'>6 D TRLR,HOLD Q:$G(ESCAPE)  D:$D(^TMP($J,"ENY2")) DETHDR
 . Q:$G(ESCAPE)  K X S $P(X,"-",130)="-" W !,X
 . W !,"COUNT",?64,$J(TOTAL(STATION,"COUNT"),10)
 . W !,"TOTALS",?103,"$"_$J(TOTAL(STATION,"EST"),7),?113,"$"_$J(TOTAL(STATION,"ACT"),7) S LINE=LINE+3
 . I ALLSTN,'$O(^TMP($J,"ENY2",STATION)) D
 .. W !,"COUNT FOR ALL STATIONS",?64,$J(TOTAL("COUNT"),10)
 .. W !,"TOTALS FOR ALL STATIONS",?103,"$"_$J(TOTAL("EST"),7),?113,"$"_$J(TOTAL("ACT"),7) S LINE=LINE+2
 . F  Q:(IOSL-LINE)'>5  W ! S LINE=LINE+1
 . D TRLR
 Q  ;return to ^eny2rep3 for exit
 ;
DETHDR ; header for Y2K detail
 W:$E(IOST,1,2)="C-"!(PAGE) @IOF S PAGE=PAGE+1,LINE=3
 W "Detailed Y2K Equipment Report "
 W $S(CRITER=1:"by EQUIPMENT CATEGORY",CRITER=2:"by CATEGORY STOCK NUMBER",CRITER=3:"by CMR",CRITER=4:"by SERVICE",CRITER=5:"by MANUFACTURER",CRITER=6:"by LOCAL ID",CRITER=7:"by RESPONSIBLE SHOP",1:"for ENTIRE EQUIP FILE")
 W " ("_$E(SORT,1,20)_")    "_DATE("PRNT")_"    "_$S('ALLSTN:"Consolidated",1:"Station: "_STATION)_"     Page: "_PAGE
 I ENSUP W !,"Equipment Records with Y2K Category of 'FC' or 'NA' are not being counted." S LINE=LINE+1
 W !,"Manufacturer~Model",?45,"Equipment Category",?67,"Entry #",?76,"Y2K   Est Date   Act Date   Est Cost  Act Cost  Action"
 K X S $P(X,"-",130)="-" W !,X
 Q
 ;
TRLR ; print legend at bottom
 K X S $P(X,"-",130)="-" W !,X
 W !,"Y2K:  FC=>Fully Compliant  NC=>Noncompliant  CC=>Conditionally Compliant  NA=>Not Applicable  Null=>No Y2K Information"
 W !,"ACTION (Noncompliant Only):  REP=>Replace  RET=>Retire  UPD=>Update to Full Compliance  USE=>Use Without an Update"
 W !
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"!($G(ESCAPE))
 W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME
 I '$T!($E(X)="^") S ESCAPE=1
 Q
 ;ENY2REPC
