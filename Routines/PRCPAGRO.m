PRCPAGRO ;WISC/RFJ,DXH/VAC - autogenerate print suggested distribution order ; 2/19/07 12:46pm
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;*98 Modified to accommodate On-Demand items.
 Q
 ;
 ;
ORDER ;  print order to create
 ;  for ^tmp($j,"prcpag","ok",vendorname,vendorda,groupname,
 ;  xxx,itemda) where xxx equals whse:nsn;  prim or seco:descr
 N %,%H,%I,D,DESCNSN,GNM,ITEMDA,NOW,ODITEM,ORDER,PAGE,SCREEN,TOTCOST,VDA,VNM,X,Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO
 S VNM="" F  S VNM=$O(^TMP($J,"PRCPAG","OK",VNM)) Q:VNM=""!($G(PRCPFLAG))  S VDA=0 F  S VDA=$O(^TMP($J,"PRCPAG","OK",VNM,VDA)) Q:'VDA!($G(PRCPFLAG))  D
 . I PAGE>1 D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)
 . S TOTCOST=0,ORDER=$G(^TMP($J,"PRCPAG","VO",VDA)) S:ORDER="" ORDER="<< UNABLE TO CREATE ORDER >>" D H
 . S GNM="" F  S GNM=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM)) Q:GNM=""!($G(PRCPFLAG))  D
 .. I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 .. W !!?12,"GROUP CATEGORY: ",$S(GNM=" ":"<< NOT SPECIFIED >>",1:GNM)
 .. S DESCNSN="" F  S DESCNSN=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM,DESCNSN)) Q:DESCNSN=""!($G(PRCPFLAG))  D
 ... S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM,DESCNSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S D=^(ITEMDA) D
 .... S %=$$DESCR^PRCPUX1(PRCP("I"),ITEMDA)
 .... S ODITEM=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .... I PRCP("DPTYPE")="W" D
 ..... W !!,ITEMDA,?7 W:PRCP("DPTYPE")'="W" $E(%,1,35) W:PRCP("DPTYPE")="W" $E(%,1,20),?31,$$NSN^PRCPUX1(ITEMDA) W ?50,$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),9),$J($P(D,"^",12),9),$J($P(D,"^",15),6),$J($P(D,"^",16),6)
 .... I PRCP("DPTYPE")'="W" D
 ..... W !!,ITEMDA
 ..... I ODITEM="Y" W ?8,"D  "
 ..... I ODITEM'="Y" W ?8,"   "
 ..... W:PRCP("DPTYPE")'="W" $E(%,1,32) W:PRCP("DPTYPE")="W" $E(%,1,17)
 .... W ?31,$$NSN^PRCPUX1(ITEMDA) W ?50,$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),9),$J($P(D,"^",12),9),$J($P(D,"^",15),6),$J($P(D,"^",16),6)
 .... W !,$J("ONHAND",8),$J("+DUEIN",8),$J("-DUEOUT",8),$J("=AVAIL",8),$J("STAND",7),$J("OPTN",8),$J("LEVEL",8),$J("CONV",7),$J("ORDER",8),$J("UNIT$",10)
 .... W !,$J(+$P(D,"^"),8),$J(+$P(D,"^",2),8),$J(+$P(D,"^",3),8),$J(+$P(D,"^",4),8),$J(+$P(D,"^",5),7),$S($P(D,"^",7)="STA":"*",1:" "),$J(+$P(D,"^",6),7),$S($P(D,"^",7)="OPT":"*",1:" ")
 .... W $J(+$P(D,"^",8),7),$S($P(D,"^",9)="*":"*",1:" "),$J(+$P(D,"^",10),6),$J(+$P(D,"^",11),8),$J(+$P(D,"^",14),10,3)
 .... S TOTCOST=TOTCOST+$J($P(D,"^",11)*$P(D,"^",14),0,2)
 ....   I $Y>(IOSL-9) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H W !!?12,"GROUP CATEGORY: ",$S(GNM=" ":"<< NOT SPECIFIED >>",1:GNM)
 . I $G(PRCPFLAG) Q
 . I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$G(PRCPFLAG)  D H
 . W !!,"TOTAL COST OF ORDER: ",TOTCOST
 I $G(PRCPFLAG) Q
 D END^PRCPUREP
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"AUTO-GEN: SUGGESTED ORDERS FOR ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 W !?5,"ORDERING FROM ",$S(PRCP("DPTYPE")="S":"PRIMARY INVENTORY POINT",1:"VENDOR"),": ",VNM
 W !?5,$S(PRCP("DPTYPE")="S":"DISTRIBUTION ORDER",1:"REPETITIVE ITEM LIST")," NUMBER: ",ORDER
 W !?50,$J($S(PRCP("DPTYPE")="S":"SECONDARY",PRCP("DPTYPE")="P":"PRIMARY",1:"WHSE"),9),$J($S(PRCP("DPTYPE")="S":"PRIMARY",1:"VENDOR"),9),$J("ISSUE",6),$J("ISSUE",6)
 W !,"IM#"
 I PRCP("DPTYPE")="W" D
 . W ?7,"DESCRIPTION"
 I PRCP("DPTYPE")'="W" D
 . W ?8,"OD",?11,"DESCRIPTION"
 W:PRCP("DPTYPE") ?31,"NSN" W ?50,$J("UNIT/ISS",9),$J("UNIT/ISS",9),$J("MINIM",6),$J("MULT",6)
 S %="",$P(%,"-",81)="" W !,%
 Q
