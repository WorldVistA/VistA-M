ENPL5C ;(WIRMFO)/LKG,SAB-FYFP REPORT: EQUIPMENT PAGE ;5/15/96
 ;;7.0;ENGINEERING;**11,23,28**;Aug 17, 1993
EQP ; Equipment Over $250K Page
 N ENC,ENDA,ENI,ENPN,ENPR,ENYR,ENY
 D HD
 F ENPR="LE","MA","MI","MM","NR" D  Q:END
 . S ENC(ENPR)=0
 . I $Y+8>IOSL D FT Q:END  D HD
 . D HDP
 . S ENYR=""
 . F  S ENYR=$O(^TMP($J,"E",ENPR,ENYR)) Q:ENYR=""  D  Q:END
 . . S ENPN=""
 . . F  S ENPN=$O(^TMP($J,"E",ENPR,ENYR,ENPN)) Q:ENPN=""  D  Q:END
 . . . S ENDA=$P(^TMP($J,"E",ENPR,ENYR,ENPN),U)
 . . . S ENI=0
 . . . F  S ENI=$O(^ENG("PROJ",ENDA,25,ENI)) Q:'ENI  D  Q:END
 . . . . I $Y+7>IOSL D FT Q:END  D HD,HDP W " (continued)"
 . . . . S ENY=$G(^ENG("PROJ",ENDA,25,ENI,0)) Q:ENY=""
 . . . . S ENC("LINE")=$P(ENY,U,2)*$P(ENY,U,3)+500\1000
 . . . . W !,?5,$P(ENPN,"-",2,3)
 . . . . W ?15,$E($P($G(^ENG("PROJ",ENDA,0)),U,3),1,30)
 . . . . W ?51,ENYR,?68,$P(ENY,U),?101,$P(ENY,U,4)
 . . . . W ?107,$J($P(ENY,U,2),3),?113,"$",$J($FN(ENC("LINE"),","),7)
 . . . . S ENC(ENPR)=ENC(ENPR)+ENC("LINE")
 . W !,?5,"TOTAL",?113,"$",$J($FN(ENC(ENPR),","),7)
 ;F ENI=$Y+6:1:IOSL W !
 F ENI=$Y+6:1:$S(IOSL>254:$Y+9,1:IOSL) W ! ; for long page length
 I ENFYB=0!(ENFYE="F") D
 . W !,?5,"Note: Equipment not included for projects in "
 . W:ENFYB=0 "current year (",ENFY,")"
 . I ENFYB=0,ENFYE="F" W " or "
 . W:ENFYE="F" "future years (>",ENFY+5,")"
 . W "."
 D FT
 Q
HD ; Page Header
 D FYFPHD^ENPL5A
 W !,?55,"EQUIPMENT OVER $250K LIST"
 W !!,?5,"PROJ #",?15,"TITLE",?48,"FUNDING YR"
 W ?68,"EQUIPMENT NAME",?100,"ADD/",?107,"QTY",?113,"TOT COST"
 W !,?48,"CONST/RENT",?100,"REPL",?113,"(in $000)"
 Q
HDP ; Program Header
 W !!,?5,$$EXTERNAL^DILFD(6925,155,"",ENPR)," PROJECTS:"
 Q
FT ; Page Footer
 S ENPG=ENPG+1 W !!,?64,"Page ",ENPG,?100,ENRDT
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR S:'Y END=1
 Q
WP ; part of detail page output
 W !!,?5,"SHORT DESCRIPTION:"
 K ^UTILITY($J,"W") S DIWL=27,DIWR=116,DIWF="W|",ENI=0
 F  S ENI=$O(^ENG("PROJ",ENDA,17,ENI)) Q:'ENI  S X=$G(^(ENI,0)) D ^DIWP
 D:$O(^ENG("PROJ",ENDA,17,0)) ^DIWW K DIWL,DIWR,DIWF
 W !,?5,"SHORT JUSTIFICATION:"
 K ^UTILITY($J,"W") S DIWL=27,DIWR=116,DIWF="W|",ENI=0
 F  S ENI=$O(^ENG("PROJ",ENDA,26,ENI)) Q:'ENI  S X=$G(^(ENI,0)) D ^DIWP
 D:$O(^ENG("PROJ",ENDA,26,0)) ^DIWW K ^UTILITY($J,"W"),DIWL,DIWR,DIWF
 Q
 ;ENPL5C
