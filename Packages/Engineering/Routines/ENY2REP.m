ENY2REP ;;(WIRMFO)/DH-Y2K Activity Report ;8.27.98
 ;;7.0;ENGINEERING;**51,55**;August 17, 1993
ACT ; periodic activity report
 ; counts and totals of all entries and changes within a user specified
 ;  date range
 N %DT
 I $P($G(^DIC(6910,1,0)),U,2)']"" W !!,"There is no STATION NUMBER in your Engineering Init Parameters file.",!,"Can't proceed.",*7 Q
ACT1 S %DT="AEP",%DT("A")="Enter starting date: ",%DT(0)=-DT
 S Y=$E(DT,1,5)-1 S:$E(Y,4,5)="00" Y=($E(Y,1,3)-1)_12 S Y=Y_"01"
 X ^DD("DD") S %DT("B")=Y
 D ^%DT Q:Y'>0
 S Y=$P(Y,"."),ENDATE("STARTI")=Y X ^DD("DD") S ENDATE("STARTE")=Y
ACT2 S Y=$$EOM^ENUTL(ENDATE("STARTI")) X ^DD("DD") S %DT("B")=Y
 S %DT("A")="Enter stopping date: " K %DT(0)
 D ^%DT Q:Y'>0  S Y=$P(Y,"."),ENDATE("STOPI")=Y_".9" X ^DD("DD") S ENDATE("STOPE")=Y
 I ENDATE("STOPI")'>ENDATE("STARTI") W !!,"STOPPING DATE must follow the STARTING DATE",*7 G ACT2
 S X=$P($O(^ENG(6918,"C",ENDATE("STARTI"))),".") I X=""!(X>ENDATE("STOPI")) W !!,"There was no Y2K activity between "_ENDATE("STARTE")_" and "_ENDATE("STOPE")_".",!,*7 G ACT1
 I $P(ENDATE("STOPI"),".",2)="" S ENDATE("STOPI")=ENDATE("STOPI")_".99"
 S ENSTN=0
 I $P(^DIC(6910,1,0),U,10)!($D(^DIC(6910,1,3))) D  G:ENSTN="^" EXIT
 . S DIR(0)="Y",DIR("A")="Do you want a breakout by station",DIR("B")="NO"
 . S DIR("?",1)="If you say 'NO' you will obtain a single report for all your equipment,"
 . S DIR("?")="regardless of which station it belongs to."
 . D ^DIR K DIR I $D(DIRUT) S ENSTN="^" Q
 . S ENSTN=Y
 K IO("Q") S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DEQACT^ENY2REP" D  G EXIT
 . S ZTSAVE("EN*")=""
 . S ZTDESC="Y2K Activity Report (equipment)",ZTIO=ION
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
DEQACT K ^TMP($J)
 N DA,DATE,CAT,EN,TOTAL,STATION,ESCAPE,COST,COUNT,X
 D CNTACT,PRNTACT
 G EXIT
 ;
CNTACT ; store target population in ^TMP($J,"ENY2A",
 S DATE=ENDATE("STARTI")-.1 F  S DATE=$O(^ENG(6918,"C",DATE)) Q:DATE=""!(DATE>ENDATE("STOPI"))  S DA(1)=0 F  S DA(1)=$O(^ENG(6918,"C",DATE,DA(1))) Q:'DA(1)  D:$D(^ENG(6918,DA(1),0))
 . I '$D(ZTQUEUED),'(DA(1)#100) W "." ; activity indicator
 . S DA=$O(^ENG(6918,"C",DATE,DA(1),0)) Q:'$D(^ENG(6918,DA(1),1,DA,0))
 . S ^TMP($J,"ENY2A",DA(1),DATE)=$P(^ENG(6918,DA(1),1,DA,0),U,2)
 Q:'$D(^TMP($J))
 S STATION("PARNT")=$P(^DIC(6910,1,0),U,2)
 ;  initialization
 F J=0,"FC","CC","NC","NA" F K=0,"FC","CC","NC","NA" F L="COUNT","EST","ACT","REST","RACT" S ^TMP($J,"ENY2B",STATION("PARNT"),J,K,L)=0
 ; end initialization
 S DA=0,STATION=STATION("PARNT") F  S DA=$O(^TMP($J,"ENY2A",DA)) Q:'DA  D READ,WRITE K ^TMP($J,"ENY2A",DA) I '$D(ZTQUEUED),'(DA#100) W "."
 Q
 ;
READ ; extract Y2K activity from skeleton global by date
 S DATE("END")=$O(^TMP($J,"ENY2A",DA,9999999),-1),CAT("CHG")=$P(^TMP($J,"ENY2A",DA,DATE("END")),U) S:CAT("CHG")="" CAT("CHG")=0
 I $O(^TMP($J,"ENY2A",DA,DATE("END")),-1)="" D  Q
 . I $O(^ENG(6918,DA,1,"B",ENDATE("STARTI")),-1)="" S CAT("ENT")=CAT("CHG"),CAT("CHG")=0
 . E  S CAT("ENT")=0
 S DATE("BEGIN")=$O(^TMP($J,"ENY2A",DA,ENDATE("STARTI"))),CAT("ENT")=$P(^TMP($J,"ENY2A",DA,DATE("BEGIN")),U)
 I $O(^ENG(6918,DA,1,"B",DATE("BEGIN")),-1)]"" S CAT("ENT")=0
 Q
 ;
WRITE ; build global from which report will be drawn (^TMP($J,"ENY2B",)
 I ENSTN S STATION=$S($P($G(^ENG(6914,DA,9)),U,5)]"":$P(^(9),U,5),1:STATION("PARNT")) D:'$D(^TMP($J,"ENY2B",STATION))
 . F J=0,"FC","NC","CC","NA" F K=0,"FC","NC","CC","NA" F L="COUNT","EST","ACT","REST","RACT" S ^TMP($J,"ENY2B",STATION,J,K,L)=0
 S ^TMP($J,"ENY2B",STATION,CAT("ENT"),CAT("CHG"),"COUNT")=^TMP($J,"ENY2B",STATION,CAT("ENT"),CAT("CHG"),"COUNT")+1,EN=$G(^ENG(6914,DA,11))
 I CAT("ENT")=0 D  Q
 . I CAT("CHG")="FC" D CCST Q
 . I CAT("CHG")="NC" D NCST Q
 . I CAT("CHG")="CC" D CCST Q
 I CAT("ENT")="FC" D  Q
 . I CAT("CHG")="FC" D CCST Q
 . I CAT("CHG")="NC" D NCST Q
 . I CAT("CHG")="CC" D CCST Q
 I CAT("ENT")="NC" D  Q
 . I CAT("CHG")="NC" D NCST Q
 . I CAT("CHG")=0 D NCST Q
 . I CAT("CHG")="FC" D CCST Q
 . I CAT("CHG")="CC" D CCST Q
 I CAT("ENT")="CC" D  Q
 . I CAT("CHG")="CC" D CCST Q
 . I CAT("CHG")=0 D CCST Q
 . I CAT("CHG")="FC" D CCST Q
 . I CAT("CHG")="NC" D NCST Q
 Q
 ;
CCST ;  store Y2K compliance costs
 ;  loc var en contains node 11
 S ^TMP($J,"ENY2B",STATION,CAT("ENT"),CAT("CHG"),"EST")=^TMP($J,"ENY2B",STATION,CAT("ENT"),CAT("CHG"),"EST")+$P($P(EN,U,3),".")
 S:CAT("CHG")="FC" ^TMP($J,"ENY2B",STATION,CAT("ENT"),CAT("CHG"),"ACT")=^TMP($J,"ENY2B",STATION,CAT("ENT"),CAT("CHG"),"ACT")+$P($P(EN,U,4),".")
 Q
 ;
NCST ;  store replacement costs
 ;  loc var en contains node 11
 I '$D(COUNT(STATION,CAT("ENT"),CAT("CHG"),"EST")) S COUNT(STATION,CAT("ENT"),CAT("CHG"),"EST")=0
 I '$D(COUNT(STATION,CAT("ENT"),CAT("CHG"),"ACT")) S COUNT(STATION,CAT("ENT"),CAT("CHG"),"ACT")=0
 I $P(EN,U,6)="REP" D
 . S COST("REST")=$P($P($G(^ENG(6914,DA,2)),U,3),".") S:COST("REST")="" COST("REST")=0 S:COST("REST") COUNT(STATION,CAT("ENT"),CAT("CHG"),"EST")=COUNT(STATION,CAT("ENT"),CAT("CHG"),"EST")+1
 . S COST("RACT")=0,X=$O(^ENG(6914,"AO",DA,0)) I X,$P($G(^ENG(6914,X,2)),U,4)'>ENDATE("STOPI") D
 .. S COST("RACT")=$P($P($G(^ENG(6914,X,2)),U,3),".") S:COST("RACT")="" COST("RACT")=0 S:COST("RACT") COUNT(STATION,CAT("ENT"),CAT("CHG"),"ACT")=COUNT(STATION,CAT("ENT"),CAT("CHG"),"ACT")+1
 . F J="REST","RACT" S ^TMP($J,"ENY2B",STATION,CAT("ENT"),CAT("CHG"),J)=^TMP($J,"ENY2B",STATION,CAT("ENT"),CAT("CHG"),J)+COST(J)
 Q
 ;
PRNTACT ;  print the hard copy
 U IO
 N PAGE,LINE
 D NOW^%DTC S Y=% X ^DD("DD") S DATE("PRNT")=$P(Y,":",1,2),PAGE=0
 W:$E(IOST,1,2)="C-" @IOF
 S STATION=0 F  S STATION=$O(^TMP($J,"ENY2B",STATION)) Q:STATION=""!($G(ESCAPE))  D HEADR D  Q:$G(ESCAPE)  D HOLD Q:$G(ESCAPE)
 . F J="COUNT","EST","ACT","REST","RACT","ECNT","ACNT" S TOTAL(J)=0
 . S TOTAL=0 F J=0,"FC","NC","CC","NA" F K=0,"FC","NC","CC","NA" Q:$G(ESCAPE)  I '(J=0&(K=0)),^TMP($J,"ENY2B",STATION,J,K,"COUNT")>0 D  Q:$G(ESCAPE)
 .. W ! W:J'=0 ?3,J W:K'=0 ?11,K W ?17,$J(^TMP($J,"ENY2B",STATION,J,K,"COUNT"),5),?24,"$" W:^("EST")>0 $J(^("EST"),8) W ?35,"$" W:^("ACT")>0 $J(^("ACT"),8)
 .. W ?46,"$" W:^TMP($J,"ENY2B",STATION,J,K,"REST")>0 $J(^("REST"),8)_"("_COUNT(STATION,J,K,"EST")_")" W ?62,"$" W:^("RACT")>0 $J(^("RACT"),8)_"("_COUNT(STATION,J,K,"ACT")_")"
 .. S TOTAL("COUNT")=TOTAL("COUNT")+^TMP($J,"ENY2B",STATION,J,K,"COUNT"),TOTAL("EST")=TOTAL("EST")+^("EST"),TOTAL("ACT")=TOTAL("ACT")+^("ACT"),TOTAL=TOTAL+1
 .. S TOTAL("REST")=TOTAL("REST")+^TMP($J,"ENY2B",STATION,J,K,"REST"),TOTAL("RACT")=TOTAL("RACT")+^("RACT")
 .. S LINE=LINE+1 I (IOSL-LINE)'>2 D HOLD D:'$G(ESCAPE) HEADR
 . Q:$G(ESCAPE)
 . I 'TOTAL W !!,?10,"<No activity to report>" Q
 . W !,X
 . I $D(COUNT(STATION,"NC",0)) S TOTAL("ECNT")=TOTAL("ECNT")+$G(COUNT(STATION,"NC",0,"EST")),TOTAL("ACNT")=TOTAL("ACNT")+$G(COUNT(STATION,"NC",0,"ACT"))
 . I $D(COUNT(STATION)) F J=0,"FC","NC","CC","NA" I $D(COUNT(STATION,J,"NC")) S TOTAL("ECNT")=TOTAL("ECNT")+$G(COUNT(STATION,J,"NC","EST")),TOTAL("ACNT")=TOTAL("ACNT")+$G(COUNT(STATION,J,"NC","ACT"))
 . W !,"  TOTALS",?17,$J(TOTAL("COUNT"),5),?24,"$"_$J(TOTAL("EST"),8),?35,"$"_$J(TOTAL("ACT"),8),?46,"$"_$J(TOTAL("REST"),8) W:$G(TOTAL("ECNT")) "("_TOTAL("ECNT")_")" W ?62,"$"_$J(TOTAL("RACT"),8) W:$G(TOTAL("ACNT")) "("_TOTAL("ACNT")_")"
 Q
 ;
HEADR ; page header
 W:PAGE>0 @IOF S PAGE=PAGE+1,LINE=5
 W "Y2K Net Activity Report from "_ENDATE("STARTE")_" to "_ENDATE("STOPE"),?70,"Page: "_PAGE
 W !,"  "_$S('ENSTN:"Consolidated ("_STATION("PARNT")_")",1:"Station: "_STATION),?50,"Printed: "_DATE("PRNT")
 W !,"  Entry  Change  Count    Est Y2K   Act Y2K    Est Repl(Cnt)   Act Repl(Cnt)"
 K X S $P(X,"-",79)="-" W !,X,!
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
 K J,K,X,ENSTN,ENDATE
 Q
 ;ENY2REP
