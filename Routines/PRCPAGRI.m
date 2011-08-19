PRCPAGRI ;WISC/RFJ-autogen print items not on order                 ;01 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ITEMSNOT ;  print items not on order
 ;  for ^tmp($j,"prcpag","not",vendorname,vendorda,groupname,
 ;  xxx,itemda) where xxx equals whse:nsn;  prim or seco:descr
 N %,%H,%I,D,DESCNSN,GNM,ITEMDA,NOW,PAGE,SCREEN,VDA,VNM,X,Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO
 S VNM="" F  S VNM=$O(^TMP($J,"PRCPAG","NOT",VNM)) Q:VNM=""!($G(PRCPFLAG))  S VDA=0 F  S VDA=$O(^TMP($J,"PRCPAG","NOT",VNM,VDA)) Q:'VDA!($G(PRCPFLAG))  D
 .   I PAGE>1 D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)
 .   D H
 .   S GNM="" F  S GNM=$O(^TMP($J,"PRCPAG","NOT",VNM,VDA,GNM)) Q:GNM=""!($G(PRCPFLAG))  D
 .   .   I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 .   .   W !!?12,"GROUP CATEGORY: ",$S(GNM=" ":"<< NOT SPECIFIED >>",1:GNM)
 .   .   S DESCNSN="" F  S DESCNSN=$O(^TMP($J,"PRCPAG","NOT",VNM,VDA,GNM,DESCNSN)) Q:DESCNSN=""!($G(PRCPFLAG))  D
 .   .   .   S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPAG","NOT",VNM,VDA,GNM,DESCNSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S D=^(ITEMDA) D
 .   .   .   .   S %=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA)
 .   .   .   .   W !!,ITEMDA,?7 W:PRCP("DPTYPE")'="W" $E(%,1,35) W:PRCP("DPTYPE")="W" $E(%,1,20),?31,$$NSN^PRCPUX1(ITEMDA) W ?50,$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),9),$J($P(D,"^",12),9),$J($P(D,"^",15),6),$J($P(D,"^",16),6)
 .   .   .   .   W !,$J("ONHAND",8),$J("+DUEIN",8),$J("-DUEOUT",8),$J("=AVAIL",8),$J("STAND",7),$J("OPTN",8),$J("LEVEL",8),$J("CONV",7),$J("ORDER",8),$J("UNIT$",10)
 .   .   .   .   W !,$J(+$P(D,"^"),8),$J(+$P(D,"^",2),8),$J(+$P(D,"^",3),8),$J(+$P(D,"^",4),8),$J(+$P(D,"^",5),7),$S($P(D,"^",7)="STA":"*",1:" "),$J(+$P(D,"^",6),7),$S($P(D,"^",7)="OPT":"*",1:" ")
 .   .   .   .   W $J(+$P(D,"^",8),7),$S($P(D,"^",9)="*":"*",1:" "),$J(+$P(D,"^",10),6),$J(+$P(D,"^",11),8),$J(+$P(D,"^",14),10,3)
 .   .   .   .   I $Y>(IOSL-7) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H W !!?12,"GROUP CATEGORY: ",$S(GNM=" ":"<< NOT SPECIFIED >>",1:GNM)
 I $G(PRCPFLAG) Q
 D END^PRCPUREP
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"AUTO-GENERATION: ITEMS NOT ON SUGGESTED ORDERS",?(80-$L(%)),%
 W !?5,"FOR INVENTORY POINT: ",PRCP("IN")
 W !?5,"MANDATORY OR REQUESTED SOURCE: ",VNM
 W !?50,$J($S(PRCP("DPTYPE")="S":"SECONDARY",PRCP("DPTYPE")="P":"PRIMARY",1:"WHSE"),9),$J($S(PRCP("DPTYPE")="S":"PRIMARY",1:"VENDOR"),9),$J("ISSUE",6),$J("ISSUE",6)
 W !,"MI#",?7,"DESCRIPTION" W:PRCP("DPTYPE")="W" ?31,"NSN" W ?50,$J("UNIT/ISS",9),$J("UNIT/ISS",9),$J("MINIM",6),$J("MULT",6)
 S %="",$P(%,"-",81)="" W !,%
 Q
