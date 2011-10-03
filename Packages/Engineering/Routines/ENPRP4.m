ENPRP4 ;(WIRMFO)/DH/SAB-Project Tracking Report ;6/12/97
 ;;7.0;ENGINEERING;**28**;Aug 17, 1993
 ;construction contract + P&H
CN ;construction contract
 N ENPHT,ENCOSAN,ENI,ENY
 F ENI=8,10,53,64,68 S ENY(ENI)=$G(^ENG("PROJ",ENDA,ENI))
 W !!,"CONST"
 W ?7,"Contract: " D W^ENPRP1($P(ENY(8),U),$P(ENY(64),U,11),"H")
 W ?50,"Add  #: "
 D W^ENPRP1($J($P(ENY(10),U),3),$J($P(ENY(64),U,21),3),"H")
 W ?63,"$: "
 D W^ENPRP1($J($FN($P(ENY(10),U,2),","),9),$J($FN($P(ENY(64),U,22),","),9),"H")
 W !,?7,"Original Award:"
 ; award date
 W ?33,"$" D W^ENPRP1($J($FN($P(ENY(8),U,2),","),10),$J($FN($P(ENY(64),U,12),","),10),"HA")
 W ?50,"Ded  #: "
 D W^ENPRP1($J($P(ENY(10),U,3),3),$J($P(ENY(64),U,23),3),"H")
 W ?63,"$: "
 D W^ENPRP1($J($FN($P(ENY(10),U,4),","),9),$J($FN($P(ENY(64),U,24),","),9),"H")
 W !,?9,$P($G(^ENG("PROJ",ENDA,9)),U)
 W ?50,"Net",?63,"$: "
 S ENCOSAN=$P(ENY(10),U,2)-$P(ENY(10),U,4)
 S ENCOSAN(0)=$P(ENY(64),U,22)-$P(ENY(64),U,24)
 D W^ENPRP1($J($FN(ENCOSAN,","),9),$J($FN(ENCOSAN(0),","),9),"H")
 W !,?50,"Extension (days): "
 D W^ENPRP1($P(ENY(53),U,3),$P(ENY(68),U,13),"HP")
PH ; P & H section
 W !,ENDL
 W !,"P & H OBLIGATIONS:"
 W ?21,"Labor (to date): ",?39
 D W^ENPRP1($J($FN($P(ENY(53),U),","),10),$J($FN($P(ENY(68),U,11),","),10),"HP")
 W !,?21,"Matrls (to date): ",?39
 D W^ENPRP1($J($FN($P(ENY(53),U,2),","),10),$J($FN($P(ENY(68),U,12),","),10),"HP")
 W !,?21,"TOTAL P&H: ",?39
 S ENPHT=$P(ENY(53),U)+$P(ENY(53),U,2)
 S ENPHT(0)=$P(ENY(68),U,11)+$P(ENY(68),U,12)
 D W^ENPRP1($J($FN(ENPHT,","),10),$J($FN(ENPHT(0),","),10),"H")
 Q  ;return to ENPRP1
 ;ENPRP4
