ENY2REP9 ;(WIRMFO)/DH-Y2K Equipment w/o Y2K Category ;8.18.98
 ;;7.0;ENGINEERING;**51,55**;August 17, 1993
NULL ;  prints list of equipment with man and mod but no Y2K category
 W @IOF,!!,?17,"List of Active Equipment Records with MANUFACTURER"
 W !,?23,"and MODEL, but without a Y2K CATEGORY"
 N COUNT
 S COUNT("EQ")=$P(^ENG(6914,0),U,4),COUNT("Y2K")=$P($G(^ENG(6918,0)),U,4) S:COUNT("Y2K")="" COUNT("Y2K")=0
 I COUNT("Y2K")/COUNT("EQ")'>.5 D  Q:'Y
 . W !!,"From glancing at your data base, it appears that less than half of your",!,"equipment records have a Y2K CATEGORY of any kind on file."
 . W !!,"Are you sure this report is worth printing?",*7
 . S DIR(0)="Y",DIR("B")="NO"
 . D ^DIR K DIR S:$D(DIRUT) Y=0
 W ! K IO("Q") S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTRTN="LIST^ENY2REP9" D  Q
 . S ZTION=ION,ZTDESC="Y2K Null Item List"
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
LIST ;
 N DA,EN,MFG,MOD,LID,EC,SRVC,LOC,SN,DATE,PAGE,ESCAPE
 K ^TMP($J)
 S DA=0 F  S DA=$O(^ENG(6914,DA)) Q:'DA  I $D(^ENG(6914,DA,0)),$P($G(^(11)),U)="" D
 . I '$D(ZTQUEUED),'(DA#100) W "." ; activity indicator
 . S EN(1)=$G(^ENG(6914,DA,1)),MFG(0)=$P(EN(1),U,4)
 . Q:MFG(0)'>0  Q:'$D(^ENG("MFG",MFG(0),0))  S MFG=$E($P(^ENG("MFG",MFG(0),0),U),1,35)
 . S MOD=$P(EN(1),U,2) Q:MOD']""  S MOD=$P(EN(1),U,2)
 . S EC(0)=$P(EN(1),U),SN=$P(EN(1),U,3)
 . S EN(3)=$G(^ENG(6914,DA,3)) Q:"^4^5^"[(U_$P(EN(3),U)_U)  ; turn-ins
 . S SRVC(0)=$P(EN(3),U,2),LOC(0)=$P(EN(3),U,5),LID=$P(EN(3),U,7)
 . S ^TMP($J,MFG,MOD,DA)=LID_U_EC(0)_U_SRVC(0)_U_LOC(0)_U_SN
 ;
PRT ;  physical print
 U IO
 D NOW^%DTC S Y=% X ^DD("DD") S DATE("PRNT")=$P(Y,":",1,2),PAGE=0
 D HDR I '$D(^TMP($J)) W !!!,?20,"<Nothing to print>" G EXIT
 S MFG="" F  Q:$G(ESCAPE)  S MFG=$O(^TMP($J,MFG)) Q:MFG=""  S MOD="" F  Q:$G(ESCAPE)  S MOD=$O(^TMP($J,MFG,MOD)) Q:MOD=""  S DA=0 F  S DA=$O(^TMP($J,MFG,MOD,DA)) Q:'DA!($G(ESCAPE))  D
 . I '$D(ZTQUEUED),IO'=IO(0),'(DA#100) U IO(0) W "." U IO ; activity indicator
 . S EN=^TMP($J,MFG,MOD,DA),LID=$P(EN,U),EC(0)=$P(EN,U,2),SRVC(0)=$P(EN,U,3),LOC(0)=$P(EN,U,4),SN=$P(EN,U,5)
 . I EC(0)'>0 S EC=""
 . E  S EC=$S($D(^ENG(6911,EC(0),0)):$P(^(0),U),1:"")
 . I SRVC(0)'>0 S SRVC=""
 . E  S SRVC=$S($D(^DIC(49,SRVC(0),0)):$P(^(0),U),1:"")
 . I LOC(0)'?1.N S LOC=LOC(0)
 . E  S LOC=$S($D(^ENG("SP",LOC(0),0)):$P(^(0),U),1:"")
 . I IOM<96 D  Q
 .. W !!,DA,?10,$E(MFG,1,30),?41,$E(MOD,1,20),?62,LID
 .. W !,$E(EC,1,22),?23,$E(SRVC,1,20),?44,$E(LOC,1,15),?60,$E(SN,1,20)
 .. I (IOSL-$Y)'>4 D HOLD D:'$G(ESCAPE) HDR
 . W !!,DA,?11,MFG,?46,MOD,?76,LID
 . W !,$E(EC,1,22),?23,$E(SRVC,1,20),?44,LOC,?65,$E(SN,1,30)
 . I (IOSL-$Y)'>4 D HOLD D:'$G(ESCAPE) HDR
 G EXIT
 ;
HDR ;  header print
 W:$E(IOST,1,2)="C-"!(PAGE) @IOF S PAGE=PAGE+1
 I IOM<96 D  Q
 . W "Null Equipment List (MAN & MODEL but no Y2K)    "_DATE("PRNT")_"  Page: "_PAGE
 . W !,"ENTRY #",?15,"MANUFACTURER",?48,"MODEL",?64,"LOCAL ID"
 . W !,"EQUIPMENT CATEGORY",?25,"SERVICE",?45,"LOCATION",?62,"SERIAL NUMBER"
 . K X S $P(X,"-",79)="-" W !,X
 W "Null Equipment List (MANUFACTURER & MODEL, but no Y2K CATEGORY)    "_DATE("PRNT")_"  Page: "_PAGE
 W !,"ENTRY #",?18,"MANUFACTURER",?54,"MODEL",?78,"LOCAL ID"
 W !,"EQUIPMENT CATEGORY",?26,"SERVICE",?47,"LOCATION",?68,"SERIAL NUMBER"
 K X S $P(X,"-",95)="-" W !,X
 Q
 ;
HOLD I $E(IOST,1,2)="C-" W !!,"Press <RETURN> to continue, '^' to escape..." R X:DTIME I '$T!($E(X)="^") S ESCAPE=1
 Q
 ;
EXIT ;
 K ^TMP($J)
 D ^%ZISC,HOME^%ZIS
 I $D(ZTQUEUED) S ZTREQN="@"
 Q
 ;ENY2REP9
