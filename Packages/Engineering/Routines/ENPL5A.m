ENPL5A ;(WIRMFO)/LKG,SAB-FYFP REPORT: YEAR SUMMARY PAGE ;5/15/96
 ;;7.0;ENGINEERING;**3,11,23,28**;Aug 17, 1993
YS ; year summary page for ENYR
 N ENAE,ENCO,ENCST,ENCSTC,ENCSTCA,ENCSTD,ENCSTDA,ENDA,ENPN,ENPR,ENPRE,ENX
 D HD
 F ENPR="LE","MA","MI","MM","NR" D  Q:END
 . Q:$O(^TMP($J,"Y",ENYR,ENPR,""))']""
 . S ENPRE=$S(ENPR="LE":"LEASE",ENPR="MA":"MAJOR",ENPR="MI":"MINOR",ENPR="MM":"MI-MISC",ENPR="NR":"NRM",1:"")
 . W:$E(IOST,1,2)'="C-" !
 . S ENPN=""
 . F  S ENPN=$O(^TMP($J,"Y",ENYR,ENPR,ENPN)) Q:ENPN=""  D  Q:END
 . . S ENX=^TMP($J,"Y",ENYR,ENPR,ENPN)
 . . S ENDA=$P(ENX,U),ENAE=$P(ENX,U,2),ENCO=$P(ENX,U,3)
 . . I "^MA^MI^MM^NR^"[(U_ENPR_U) D
 . . . S ENX=$G(^ENG("PROJ",ENDA,19))
 . . . S ENCSTD=$P(ENX,U,10)+999\1000
 . . . S ENCSTC=$P(ENX,U,11)+999\1000
 . . . S ENCST=$S(ENAE:ENCSTD,1:0)+$S(ENCO:ENCSTC,1:0)
 . . I "^LE^"[(U_ENPR_U) D
 . . . S ENCST=$P($G(^ENG("PROJ",ENDA,55)),U,5)+999\1000
 . . I ENPR'="LE"!($P($G(^ENG("PROJ",ENDA,55)),U)'="EX") D SUM^ENPL5D
 . . I $Y+10>IOSL D FT Q:END  D HD
 . . W !
 . . W:ENMDA $$GET1^DIQ(6925,ENDA_",",176)
 . . W ?12,$P(ENPN,"-",2,3)
 . . W ?21,$E($P($G(^ENG("PROJ",ENDA,0)),U,3),1,30)
 . . W ?54,"$",$J($FN(ENCST,","),9)
 . . I "^MA^MI^MM^NR^"[(U_ENPR_U) D
 . . . I '(ENAE&ENCO) W $S(ENAE:" D",ENCO:" C",1:"")
 . . . ;S ENCSTDA=$P($G(^ENG("PROJ",ENDA,5)),U,2)+999\1000
 . . . ;S ENCSTCA=$P($G(^ENG("PROJ",ENDA,1)),U,1)+999\1000
 . . . ;I ENCSTDA>0&(ENCSTD'=ENCSTDA)!(ENCSTCA>0&(ENCSTC'=ENCSTCA)) W ?66,"!"
 . . W ?70,ENPRE
 . . W ?83,$E($$GET1^DIQ(6925,ENDA_",",158.1),1,20)
 . . ; W:$O(^ENG("PROJ",ENDA,20,0)) ?106,"YES"
 . . I ENYR'="F" D
 . . . W:ENPR="MA" ?111,$J($P($G(^ENG("PROJ",ENDA,24)),U,8),5)
 . . . W ?118,$$CD(ENDA)
 W !,?54,"----------"
 W !,?5,"TOTAL COST (Excluding Expedited Leases)",?54,"$",$J($FN($P($G(ENT(ENYR,"LE")),U)+$P($G(ENT(ENYR,"MA")),U)+$P($G(ENT(ENYR,"MI")),U)+$P($G(ENT(ENYR,"MM")),U)+$P($G(ENT(ENYR,"NR")),U),","),9)
 F ENI=$Y+10:1:$S(IOSL>254:$Y+13,1:IOSL) W ! ; for long page length
 ;F ENI=$Y+10:1:IOSL W !
 W !,?10,"Project Count"
 W "   LEASE (excludes Expedited) = ",$P($G(ENT(ENYR,"LE")),U,2)+0
 W "   MAJOR = ",$P($G(ENT(ENYR,"MA")),U,2)+0
 W "   MINOR = ",$P($G(ENT(ENYR,"MI")),U,2)+0
 W "   MINOR MISC = ",$P($G(ENT(ENYR,"MM")),U,2)+0
 W "   NRM = ",$P($G(ENT(ENYR,"NR")),U,2)+0
 D FT
 Q
HD ; page header
 D FYFPHD
 S ENX=$S(ENFY=ENYR:"CURRENT YEAR APPROVED",ENYR="F":"FUTURE YEARS",1:"BUDGET YEAR")
 S:ENFY+1<ENYR ENX=ENX_" PLUS "_$P("ONE^TWO^THREE^FOUR",U,ENYR-(ENFY+1))
 S ENX=ENX_" PROJECT LIST"
 S:ENYR'="F" ENX=ENX_" (FY "_ENYR_")"
 W !,?(125-$L(ENX)\2+5),ENX,!!
 W:ENMDA "DIVISION"
 W ?12,"PROJ #",?21,"TITLE",?56,"COST",?65,"*",?70,"PROGRAM"
 W ?83,"PROJECT" ;,?104,"DOMINO"
 W:ENYR'="F" ?111,"MCPS",?118,"CITED"
 W !,?54,"(in $000)",?83,"CATEGORY"
 W:ENYR'="F" ?111,"SCORE",?118,"DEFICIENCY"
 W !
 Q
FT ; page footer
 W !!,?5,"*    C = Construction dollars only    D = Design dollars only"
 S ENPG=$G(ENPG)+1 W !!,?64,"Page ",ENPG,?100,ENRDT
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR S:'Y END=1
 Q
FYFPHD ; FYFP Header
 W:$E(IOST,1,2)="C-"!ENPG @IOF
 W !,?56,"FIVE YEAR FACILITY PLAN",!,?ENPGHC,ENPGH
 Q
CD(ENDA) ; Cited Deficiencies Text Extrinsic Variable
 N ENCA,ENCD,ENI
 S ENCD="",ENI=0
 F  S ENI=$O(^ENG("PROJ",ENDA,21,ENI)) Q:'ENI  D
 . S ENCA=$$GET1^DIQ(6925.0164,ENI_","_ENDA_",","3:1")
 . I "^JCAHO^RSFPE^"[(U_ENCA_U) S $P(ENCD,",",ENCA="RSFPE"+1)=ENCA
 I $E(ENCD)="," S ENCD=$E(ENCD,2,99)
 I ENCD="",$O(^ENG("PROJ",ENDA,21,0)) S ENCD="OTHER"
 I ENCD="" S ENCD="NONE"
 Q ENCD
 ;ENPL5A
