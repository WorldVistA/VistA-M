ENPL5D ;(WIRMFO)/LKG,SAB-FYFP REPORT: PLAN SUMMARY PAGE ;5/15/96
 ;;7.0;ENGINEERING;**23,28**;Aug 17, 1993
PS N ENB,ENC,ENI,ENLD,ENLE,ENPR,ENX
 S $P(ENLD," ",10)="",ENLE=ENLD
 F ENI=1:1:6 S ENLD=ENLD_"    ---  ----------"
 F ENI=1:1:6 S ENLE=ENLE_"    ===  =========="
 I ENFYB'="F" F ENYR=ENFY+ENFYB:1:ENFY+$S(ENFYE="F":5,1:ENFYE) D SUBTOT
 I ENFYE="F" S ENYR="F" D SUBTOT
 D HD
 I ENFYB'="F" F ENYR=ENFY+ENFYB:1:ENFY+$S(ENFYE="F":5,1:ENFYE) D
 . W:$E(IOST,1,2)'="C-" !
 . W !,?5,"FY ",ENYR
 . S ENX="ENT(ENYR," D LN
 . I ENYR=ENFY W !,?5,ENLE,!
 . I ENYR=(ENFY+$S(ENFYE="F":5,1:ENFYE)) D
 . . W !,?5,ENLE,!,?5,"PLAN TOTAL" S ENX="ENB(" D LN W !
 I ENFYE="F" S ENYR="F" D
 . W:$E(IOST,1,2)'="C-" !
 . W !,?5,"FY FUTURE"
 . S ENX="ENT(ENYR," D LN
 . W !,?5,ENLE,!,?5,"PLAN+FUTURE" S ENX="ENC(" D LN
 D FT
 Q
SUBTOT ; add program totals for year (ENYR) to FYFP subtotals
 K ENT(ENYR,"C")
 F ENPR="MA","MI","MM","NR","LE" D
 . I "^MA^MI^MM^NR^"[(U_ENPR_U) D  ; const year total
 . . S $P(ENT(ENYR,"C"),U)=$P($G(ENT(ENYR,"C")),U)+$P($G(ENT(ENYR,ENPR)),U)
 . . S $P(ENT(ENYR,"C"),U,2)=$P($G(ENT(ENYR,"C")),U,2)+$P($G(ENT(ENYR,ENPR)),U,2)
 . Q:ENYR=ENFY
 . ; plan+future total
 . S $P(ENC(ENPR),U,1)=$P($G(ENC(ENPR)),U,1)+$P($G(ENT(ENYR,ENPR)),U,1)
 . S $P(ENC(ENPR),U,2)=$P($G(ENC(ENPR)),U,2)+$P($G(ENT(ENYR,ENPR)),U,4)
 . I "^MA^MI^MM^NR^"[(U_ENPR_U) D  ; const plan+future total
 . . S $P(ENC("C"),U,1)=$P($G(ENC("C")),U,1)+$P($G(ENT(ENYR,ENPR)),U,1)
 . . S $P(ENC("C"),U,2)=$P($G(ENC("C")),U,2)+$P($G(ENT(ENYR,ENPR)),U,4)
 . Q:ENYR="F"
 . ; plan total
 . S $P(ENB(ENPR),U,1)=$P($G(ENB(ENPR)),U,1)+$P($G(ENT(ENYR,ENPR)),U,1)
 . S $P(ENB(ENPR),U,2)=$P($G(ENB(ENPR)),U,2)+$P($G(ENT(ENYR,ENPR)),U,3)
 . I "^MA^MI^MM^NR^"[(U_ENPR_U) D  ; const plan total
 . . S $P(ENB("C"),U,1)=$P($G(ENB("C")),U,1)+$P($G(ENT(ENYR,ENPR)),U,1)
 . . S $P(ENB("C"),U,2)=$P($G(ENB("C")),U,2)+$P($G(ENT(ENYR,ENPR)),U,3)
 Q
LN ; cost line for ENX array
 W ?18,$J($P($G(@(ENX_"""MA"")")),U,2)+0,3)
 W ?23,"$",$J($FN($P($G(@(ENX_"""MA"")")),U),","),9)
 W ?37,$J($P($G(@(ENX_"""MI"")")),U,2)+0,3)
 W ?42,"$",$J($FN($P($G(@(ENX_"""MI"")")),U),","),9)
 W ?56,$J($P($G(@(ENX_"""MM"")")),U,2)+0,3)
 W ?61,"$",$J($FN($P($G(@(ENX_"""MM"")")),U),","),9)
 W ?75,$J($P($G(@(ENX_"""NR"")")),U,2)+0,3)
 W ?80,"$",$J($FN($P($G(@(ENX_"""NR"")")),U),","),9)
 W ?94,$J($P($G(@(ENX_"""C"")")),U,2)+0,3)
 W ?99,"$",$J($FN($P($G(@(ENX_"""C"")")),U),","),9)
 W ?113,$J($P($G(@(ENX_"""LE"")")),U,2)+0,3)
 W ?118,"$",$J($FN($P($G(@(ENX_"""LE"")")),U),","),9)
 Q
HD ; page header
 D FYFPHD^ENPL5A
 W !,?42,"PLAN SUMMARY BY PROGRAMS AND FISCAL YEARS (in $000)"
 W:$E(IOST,1,2)'="C-" !
 W !,?23,"MAJOR",?42,"MINOR",?58,"MINOR MISC",?81,"NRM"
 W ?96,"CONST TOTAL",?115,"LEASE TOTAL"
 W !,?18,"CNT",?26,"COST",?37,"CNT",?45,"COST",?56,"CNT",?64,"COST"
 W ?75,"CNT",?83,"COST",?94,"CNT",?102,"COST",?113,"CNT",?121,"COST"
 W !,?5,ENLD
 Q
FT ; page footer
 W:$E(IOST,1,2)'="C-" !!!!!,?5,"________________________"
 ;F ENI=$Y+9:1:IOSL W !
 F ENI=$Y+9:1:$S(IOSL>254:$Y+12,1:IOSL) W ! ; for long page length
 W !,?5,"PLAN and PLAN+FUTURE counts only include split year projects once and may not equal the sum of the year counts."
 W !,?5,"Lease column excludes Expedited leases."
 W:$E(IOST,1,2)'="C-" !
 S ENPG=ENPG+1 W !,?64,"Page ",ENPG,?100,ENRDT
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR S:'Y END=1
 Q
SUM ; add a project to year-program totals
 N ENFYAE,ENFYCO
 ; input variables
 ;   ENYR   year
 ;   ENPR   program
 ;   ENFY   current year of 5-Yr Plan
 ;   ENCST  oost in thousands
 ;   ENT(   (optional) current totals
 ;   for MA,MI,MM,NR programs
 ;     ENAE   true if funding year A/E in ENYR
 ;     ENCO   true if funding year Const in ENYR
 ; output variables
 ;   ENT(ENYR,ENPR array modified
 S $P(ENT(ENYR,ENPR),U)=$P($G(ENT(ENYR,ENPR)),U)+ENCST ; cost
 S $P(ENT(ENYR,ENPR),U,2)=$P($G(ENT(ENYR,ENPR)),U,2)+1 ; cnt
 S $P(ENT(ENYR,ENPR),U,3)=$P($G(ENT(ENYR,ENPR)),U,3)+1 ; plan cnt
 S $P(ENT(ENYR,ENPR),U,4)=$P($G(ENT(ENYR,ENPR)),U,4)+1 ; plan+future cnt
 Q:"^MA^MI^MM^NR^"'[(U_ENPR_U)  ; only check const. proj for split year
 S ENFYAE=$P($G(^ENG("PROJ",ENDA,5)),U,7)
 S ENFYCO=$P($G(^ENG("PROJ",ENDA,0)),U,7)
 I ENFYAE]"",ENFYCO]"",'(ENAE&ENCO) D  ; split year adjustments
 . I ENFYAE'<(ENFY+$S(ENFYB="F":6,ENFYB=0:1,1:ENFYB)),ENFYAE'>(ENFY+$S(ENFYE="F":5,1:ENFYE)),ENFYCO'<(ENFY+$S(ENFYB="F":6,ENFYB=0:1,1:ENFYB)),ENFYCO'>(ENFY+$S(ENFYE="F":5,1:ENFYE)) D  Q
 . . ; both in plan range (adjust count)
 . . S $P(ENT(ENYR,ENPR),U,3)=$P($G(ENT(ENYR,ENPR)),U,3)-.5
 . . S $P(ENT(ENYR,ENPR),U,4)=$P($G(ENT(ENYR,ENPR)),U,4)-.5
 . I ENFYAE>(ENFY+5)!(ENFYCO>(ENFY+5)),(ENFYAE'<(ENFY+$S(ENFYB="F":6,ENFYB=0:1,1:ENFYB))&(ENFYAE'>(ENFY+$S(ENFYE="F":5,1:ENFYE))))!(ENFYCO'<(ENFY+$S(ENFYB="F":6,ENFYB=0:1,1:ENFYB))&(ENFYCO'>(ENFY+$S(ENFYE="F":5,1:ENFYE)))) D  Q
 . . ; one in future years and one in plan range (adjust count)
 . . S $P(ENT(ENYR,ENPR),U,4)=$P($G(ENT(ENYR,ENPR)),U,4)-.5
 Q
 ;ENPL5D
