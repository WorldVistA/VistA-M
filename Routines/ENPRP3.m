ENPRP3 ;(WIRMFO)/DLM/DH/SAB-Project Tracking Report ;6/12/97
 ;;7.0;ENGINEERING;**18,28**;Aug 17, 1993
AE ;print A/E data block
 N ENAESAN,ENAEST,ENI,ENY
 F ENI=5,51,64,67 S ENY(ENI)=$G(^ENG("PROJ",ENDA,ENI))
 W !,"A/E",?7,"Contract: " D W^ENPRP1($P(ENY(5),U),$P(ENY(64),U),"H")
 W ?50,"Add #: "
 D W^ENPRP1($J($P(ENY(51),U,9),3),$J($P(ENY(67),U,9),3),"H")
 W ?63,"$: "
 D W^ENPRP1($J($FN($P(ENY(51),U,10),","),9),$J($FN($P(ENY(67),U,10),","),9),"H")
 W !,?7,"Original Award: "
 ;award date
 W ?33,"$" D W^ENPRP1($J($FN($P(ENY(5),U,9),","),9),$J($FN($P(ENY(64),U,9),","),9),"HA")
 W ?50,"Ded #: "
 D W^ENPRP1($J($P(ENY(51),U,11),3),$J($P(ENY(67),U,11),3),"H")
 W ?63,"$: "
 D W^ENPRP1($J($FN($P(ENY(51),U,12),","),9),$J($FN($P(ENY(67),U,12),","),9),"H")
 W !,?9,$P($G(^ENG("PROJ",ENDA,6)),U) ; a/e name
 S ENAESAN=$P(ENY(51),U,10)-$P(ENY(51),U,12)
 S ENAESAN(0)=$P(ENY(67),U,10)-$P(ENY(67),U,12)
 W ?50,"Net",?63,"$: " D W^ENPRP1($J($FN(ENAESAN,","),9),$J($FN(ENAESAN(0),","),9),"H")
 W !,?7,"Study:",?27
 D W^ENPRP1($J($FN($P(ENY(51),U,6),","),8),$J($FN($P(ENY(67),U,6),","),8),"HP")
 W !,?7,"Schematics:",?27
 D W^ENPRP1($J($FN($P(ENY(5),U,3),","),8),$J($FN($P(ENY(64),U,3),","),8),"HP")
 W !,?7,"Site Survey:",?27
 D W^ENPRP1($J($FN($P(ENY(5),U,10),","),8),$J($FN($P(ENY(64),U,10),","),8),"HP")
 W !,?7,"Design Development:",?27
 D W^ENPRP1($J($FN($P(ENY(51),U,7),","),8),$J($FN($P(ENY(67),U,7),","),8),"HP")
 W !,?7,"Const. Documents:",?27
 D W^ENPRP1($J($FN($P(ENY(5),U,4),","),8),$J($FN($P(ENY(64),U,4),","),8),"HP")
 W !,?7,"Site Visits:",?27
 D W^ENPRP1($J($FN($P(ENY(5),U,5),","),8),$J($FN($P(ENY(64),U,5),","),8),"HP")
 W !,?7,"Const. Period Svcs.:",?27
 D W^ENPRP1($J($FN($P(ENY(5),U,6),","),8),$J($FN($P(ENY(64),U,6),","),8),"HP")
 W !,?7,"Other:",?27
 D W^ENPRP1($J($FN($P(ENY(51),U,8),","),8),$J($FN($P(ENY(67),U,8),","),8),"HP")
 W !,?7,"Subtotal:",?27
 S ENAEST=$P(ENY(51),U,6)+$P(ENY(5),U,3)+$P(ENY(5),U,10)+$P(ENY(51),U,7)+$P(ENY(5),U,4)+$P(ENY(5),U,5)+$P(ENY(5),U,6)+$P(ENY(51),U,8)
 S ENAEST(0)=$P(ENY(67),U,6)+$P(ENY(64),U,3)+$P(ENY(64),U,10)+$P(ENY(67),U,7)+$P(ENY(64),U,4)+$P(ENY(64),U,5)+$P(ENY(64),U,6)+$P(ENY(67),U,8)
 D W^ENPRP1($J($FN(ENAEST,","),8),$J($FN(ENAEST(0),","),8),"HP")
 Q
 ;ENPRP3
