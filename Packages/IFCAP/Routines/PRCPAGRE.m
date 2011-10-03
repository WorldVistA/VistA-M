PRCPAGRE ;WISC/RFJ,DXH - autogen print error report ;10.5.99
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ERROR ;  print error report
 ;  from ^tmp($j,"prcpag","er",xxx,itemda) where xxx equals
 ;  whse:nsn;  prim or seco:description
 N %,%H,%I,DESCNSN,ERROR,ITEMDA,NOW,PAGE,SCREEN,X,Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S DESCNSN="" F  S DESCNSN=$O(^TMP($J,"PRCPAG","ER",DESCNSN)) Q:DESCNSN=""  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPAG","ER",DESCNSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S ERROR=^(ITEMDA) D
 .   W !!,ITEMDA,?7,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,55)
 .   I PRCP("DPTYPE")="W" W ?63,$$NSN^PRCPUX1(ITEMDA)
 .   F  W !?7,"-> ",$E(ERROR,1,69) S ERROR=$E(ERROR,70,200) S:$E(ERROR)=" " ERROR=$E(ERROR,2,200) I ERROR="" Q
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 I $G(PRCPFLAG) Q
 D END^PRCPUREP
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"AUTO-GEN ERRORS FOR ",$E(PRCP("IN"),1,20),?(82-$L(%)),%,!,"MI#",?7,"DESCRIPTION"
 I PRCP("DPTYPE")="W" W ?63,"NSN"
 S %="",$P(%,"-",81)="" W !,%
 Q
