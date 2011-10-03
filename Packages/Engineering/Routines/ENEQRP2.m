ENEQRP2 ;(WIRMFO)/DH/SAB-AGGREGATED REPAIR DATA BY CATEGORY ;10/21/1998
 ;;7.0;ENGINEERING;**35,59**;Aug 17, 1993
 Q
 ;
HD ;EQUIP HIST-EQUIPMENT TYPE
 W:'$D(ENDVTYP) @IOF,!! S DIC="^ENG(6911,",DIC(0)="AEQM" D ^DIC G:Y<0 EXIT S ENDA=+Y,ENDVTYP=$P(^ENG(6911,ENDA,0),U,1)
 I $O(^ENG(6914,"G",ENDA,0))="" W !!,"There is no equipment of type ",ENDVTYP,".",!!! G HD
 S DIR(0)="Y",DIR("A")="Include TURNED IN and LOST OR STOLEN Equipment"
 S DIR("B")="YES"
 S DIR("?",1)="Enter YES to include equipment with a USE STATUS of"
 S DIR("?",2)="TURNED IN or LOST OR STOLEN when repair statistics are"
 S DIR("?",3)="computed. If included, the age of this equipment will"
 S DIR("?",4)="be determined by comparing the Turn-In (or Disposition)"
 S DIR("?",5)="Date with the Acquisition Date."
 S DIR("?",6)=" "
 S DIR("?")="Enter YES or NO."
 D ^DIR K DIR G:$D(DIRUT) EXIT S ENINCL=Y
 D T,DEV^ENLIB G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="HD1^ENEQRP2",ZTDESC="Equipment History (Equip Category)"
 . S ZTSAVE("EN*")=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
HD1 K ^TMP($J) S (ENR,ENH,J,K,EN("A"),EN("P"),EN("R"),EN("V"),ENDAYS,ENAGE,END)=0 F I=1:1:5 S (E(I),EN(I))=""
 W:'$D(ZTQUEUED) !!,"compiling the data..."
HD12 S ENR=$O(^ENG(6914,"G",ENDA,ENR)) G:ENR="" HDP D:'$D(^ENG(6914,ENR,1)) ERR
 W:'$D(ZTQUEUED) "."
 S ENY2=$G(^ENG(6914,ENR,2)),ENY3=$G(^ENG(6914,ENR,3))
 I 'ENINCL,$P(ENY3,U)>3,$P(ENY3,U)<6 G HD12 ; skip per user response
 ; perform validity checks
 S ENL=0
 I $P(ENY2,U,4)="" S ENL=ENL+1,^TMP($J,ENR,ENL)="Acquisition Date missing."
 I $P(ENY3,U)>3,$P(ENY3,U)<6,$P(ENY3,U,3)="",$P(ENY3,U,11)="" S ENL=ENL+1,^TMP($J,ENR,ENL)="Date (Turn-In or Disposition) missing & Use Status "_$$EXTERNAL^DILFD(6914,20,"",$P(ENY3,U))_"."
 ; end date - preferentially use Turn-in else Disposition else Today
 S X1=$S($P(ENY3,U,3):$P(ENY3,U,3),$P(ENY3,U,11):$P(ENY3,U,11),1:ENNDATE)
 ; begin date - acquisition date
 S X2=$P(ENY2,U,4)
 D ^%DTC
 I X<0 S ENL=ENL+1,^TMP($J,ENR,ENL)="Equipment age is negative value."
 G:ENL HD12 ; item did not pass validity checks
 ;
 S J=J+1
 S ENDAYS=ENDAYS+X
 S ENH=0
HD2 S ENH=$O(^ENG(6914,ENR,6,ENH)) G:'ENH HD12 S K=K+1
 S B=^ENG(6914,ENR,6,ENH,0),C=$E($P((B),"-",2)),D=$S(C="R":"R",C="P":"P",C="V":"V",1:"A"),EN(D)=EN(D)+1
 S E(1)=$P(B,U,4),E(2)=$P(B,U,5),E(3)=$P(B,U,6),E(4)=$P(B,U,7),E(5)=E(2)+E(3)+E(4),EN(1)=EN(1)+E(1),EN(2)=EN(2)+E(2),EN(3)=EN(3)+E(3),EN(4)=EN(4)+E(4),EN(5)=EN(5)+E(5) G HD2
 ;
HDP ;PRINT
 S ENPG=0
 W:IO'=IO(0) !,"beginning report...",!
 U IO D RPTHD
 W !!,"Equipment Type: ",ENDVTYP,!,"Number of Units: ",J
 I J<1 W !!,"There is no equipment of this type! " G EXP
 I ENDAYS>1 S ENAGE=ENDAYS/365.25 W !,"Average Age: ",$J(ENAGE/J,4,2)," Years"
 E  W !,"Average Age: ** NOT ENTERED **"
 W !!,"EQUIPMENT COSTS",?23,"LABOR",?32,"MATERIAL",?46,"VENDOR",?59,"TOTAL",?71,"HOURS" W ! F I=1:1:76 W "-"
 W !,"PER ITEM",?20,$J((EN(2)/J),8,2),?32,$J((EN(3)/J),8,2),?44,$J((EN(4)/J),8,2),?56,$J((EN(5)/J),8,2),?68,$J(EN(1)/J,8,2)
 I ENAGE>0 S ENAJ=ENAGE/J W !,"PER YEAR",?20,$J((EN(2)/ENAJ),8,2),?32,$J((EN(3)/ENAJ),8,2),?44,$J((EN(4)/ENAJ),8,2),?56,$J((EN(5)/ENAJ),8,2),?68,$J((EN(1)/ENAJ),8,2)
 I ENAGE>0 W !,"PER ITEM PER YEAR",?20,$J((EN(2)/J/ENAJ),8,2),?32,$J((EN(3)/J/ENAJ),8,2),?44,$J((EN(4)/J/ENAJ),8,2),?56,$J((EN(5)/J/ENAJ),8,2),?68,$J((EN(1)/J/ENAJ),8,2)
 W !,"TOTAL",?20,$J(EN(2),8,2),?32,$J(EN(3),8,2),?44,$J(EN(4),8,2),?56,$J(EN(5),8,2),?68,$J(EN(1),8,2)
 W !!!,"VISITS",?20,"REPAIR",?32,"PMI",?40,"VENDOR",?50,"OTHER",?60,"TOTAL" W ! F I=1:1:65 W "-"
 W !,"PER ITEM",?20,$J((EN("R")/J),4,1),?30,$J((EN("P")/J),4,1),?40,$J((EN("V")/J),4,1),?50,$J((EN("A")/J),4,1),?60,$J((K/J),4,1)
 I ENAGE>0 W !,"PER YEAR",?20,$J((EN("R")/ENAJ),4,1),?30,$J((EN("P")/ENAJ),4,1),?40,$J((EN("V")/ENAJ),4,1),?50,$J((EN("A")/ENAJ),4,1),?60,$J((K/ENAJ),4,1)
 I ENAGE>0 W !,"PER ITEM PER YEAR",?20,$J((EN("R")/J/ENAJ),4,1),?30,$J((EN("P")/J/ENAJ),4,1),?40,$J((EN("V")/J/ENAJ),4,1),?50,$J((EN("A")/J/ENAJ),4,1),?60,$J((K/J/ENAJ),4,1)
 W !,"TOTAL",?20,$J(EN("R"),4,1),?30,$J(EN("P"),4,1),?40,$J(EN("V"),4,1),?50,$J(EN("A"),4,1),?60,$J(K,4,1)
EXP I $D(^TMP($J)) D  ; print exception list
 . I $Y+8>IOSL D RPTHD Q:END
 . D EXCPHD
 . S ENR=0 F  S ENR=$O(^TMP($J,ENR)) Q:'ENR  D  Q:END
 . . S ENL=0 F  S ENL=$O(^TMP($J,ENR,ENL)) Q:'ENL  D  Q:END
 . . . I $Y+4>IOSL D RPTHD Q:END  D EXCPHD
 . . . W !,ENR,?12,^TMP($J,ENR,ENL)
 I 'END,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
DONE K %,%DT,B,C,D,D1
 K E,EN,ENAGE,ENAJ,ENAK,END,ENDAYS,ENH,ENL,ENPG,ENR,ENY2,ENY3
 K I,J,K,O,R,X1,X2,Y,^TMP($J)
 D ^%ZISC
EXIT K DIC,DIROUT,DIRUT,DTOUT,DUOUT,ENDA,ENDVTYP,ENDATE,ENINCL,ENNDATE
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
ERR W !!,"NON-FATAL DATABASE ERROR..NODE ^ENG(6914,",ENR,",1) IS MISSING ...CHECK ASAP!",!,"....proceeding..",*7 H 3 Q
 ;
T S %DT="",X="T" D ^%DT S ENNDATE=Y X ^DD("DD") S ENDATE=Y K X,Y
 Q
RPTHD ; Header
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR K DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W ENDVTYP," Equipment Type History",?68,ENDATE
 Q
EXCPHD ; Exception List Header
 W !!,"The following equipment was not used when computing statistics"
 W !!,"Entry #",?12,"Reason"
 W !,"----------"
 W ?12,"----------------------------------------------------------------"
 Q
 ;ENEQRP2
