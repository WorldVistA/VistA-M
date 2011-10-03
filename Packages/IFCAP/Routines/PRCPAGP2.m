PRCPAGP2 ;WISC/RFJ-autogen primary or whse order (build, reports)   ;01 Dec 92
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CONT ;  continue auto-generation
 N DESCNSN,GNM,ITEMDA,PRCPDATA,PRCPRIL,PRCPRILN,TOTAL,VDA,VNM,Y
 ;
 D OPTIONAL^PRCPAGU1
 ;
 I $O(^TMP($J,"PRCPAG","OK",""))="" W !!,"NO ITEMS HAVE BEEN ORDERED !!"
 E  W !!,"<<< Creating repetitive item list ..." D
 .   S PRCPRIL=$$NEWRIL^PRCPAGPR(PRCP("I"),PRCPREPN) I 'PRCPRIL W !?5,"ERROR: UNABLE TO CREATE REPETITIVE ITEM LIST !" Q
 .   S PRCPRILN=$P(PRCPRIL,"^",2),PRCPRIL=+PRCPRIL,TOTAL=0 W "  Number: ",PRCPRILN
 .   W !,"<<< Locking  repetitive item list ..."
 .   L +^PRCS(410.3,PRCPRIL)
 .   D ADD^PRCPULOC(410.3,PRCPRIL,0,"Autogeneration")
 .   W !,"<<< Adding ",TOTITEMS," items to repetitive item list ..."
 .   S EACHONE=$$INPERCNT^PRCPUX2(TOTITEMS,"*",PRCP("RV1"),PRCP("RV0"))
 .   S NUMBER=0,VNM="" F  S VNM=$O(^TMP($J,"PRCPAG","OK",VNM)) Q:VNM=""  S VDA=0 F  S VDA=$O(^TMP($J,"PRCPAG","OK",VNM,VDA)) Q:'VDA  D
 .   .   S GNM="" F  S GNM=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM)) Q:GNM=""  S DESCNSN="" F  S DESCNSN=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM,DESCNSN)) Q:DESCNSN=""  D
 .   .   .   S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPAG","OK",VNM,VDA,GNM,DESCNSN,ITEMDA)) Q:'ITEMDA  S PRCPDATA=^(ITEMDA) D
 .   .   .   .   S NUMBER=NUMBER+1,LASTONE=$$SHPERCNT^PRCPUX2(NUMBER,EACHONE,"*",PRCP("RV1"),PRCP("RV0"))
 .   .   .   .   S Y=$$ADDITEM^PRCPAGPR(PRCPRIL,ITEMDA,$P(PRCPDATA,"^",11),VDA,$P(PRCPDATA,"^",14))
 .   .   .   .   I 'Y S ^TMP($J,"PRCPAG","ER",DESCNSN,ITEMDA)="UNABLE to add item to RIL: "_PRCPRILN Q
 .   .   .   .   S TOTAL=TOTAL+($P(PRCPDATA,"^",11)*$P(PRCPDATA,"^",14))
 .   .   S ^TMP($J,"PRCPAG","VO",VDA)=PRCPRILN
 .   D QPERCNT^PRCPUX2(+$G(LASTONE),"*",PRCP("RV1"),PRCP("RV0"))
 .   W !?10,"Total number of items : ",+$P($G(^PRCS(410.3,PRCPRIL,1,0)),"^",4),!?10,"Total cost (all items): $ ",$J(TOTAL,0,2) S $P(^PRCS(410.3,PRCPRIL,0),"^",2)=+$J(TOTAL,0,2)
 .   S PRCSDA=PRCPRIL D CHECK^PRCSRIE1 K PRCSDA
 .   W !!,"<<< Unlocking repetitive item list ..."
 .   L -^PRCS(410.3,PRCPRIL)
 .   D CLEAR^PRCPULOC(410.3,PRCPRIL,0)
 ;
 D REPORTS^PRCPAGU1
 Q
