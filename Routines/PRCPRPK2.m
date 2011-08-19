PRCPRPK2 ;WISC/RFJ-packaging discrepancy report (print errors)      ;04 Oct 91
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
 ;  ^tmp($j,"prcprpkg",nsn,itemda,error)=data where error=1-6
 ;  ^tmp($j,"prcprpkg",nsn,itemda,7,vendor,suberror)=data
 ;  ^tmp($j,"prcprpkg",nsn,itemda,8,transaction,suberror)=data
PRINT ;  print errors
 N %,%H,%I,D,ERROR,ITEMDA,NOW,NSN,PAGE,PRCPFLAG,PSDATA,SCREEN,SUBERROR,TRANDA,VENDA,VENDATA,X,Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S NSN="" F  S NSN=$O(^TMP($J,"PRCPRPKG",NSN)) Q:NSN=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRPKG",NSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 . I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 . W !!,NSN,?19,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,25),?47,"[#",ITEMDA,"]",?55,$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA," per "),11)
 . S ERROR=0 F  S ERROR=$O(^TMP($J,"PRCPRPKG",NSN,ITEMDA,ERROR)) Q:'ERROR!($G(PRCPFLAG))  D
 . . I $Y>(IOSL-7) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 . . I ERROR<7!(ERROR>14) D DISPLAY(ERROR,^TMP($J,"PRCPRPKG",NSN,ITEMDA,ERROR)) Q
 . . I ERROR=7 D  Q
 . . . W !?3,"VENDOR (m=MAND)",?20,"[#V]",?27,"UNIT per PUR",?41,"UNIT per REC",?55,"CONV FACT",?71,"LAST COST"
 . . . S VENDA=0 F  S VENDA=$O(^TMP($J,"PRCPRPKG",NSN,ITEMDA,ERROR,VENDA)) Q:'VENDA!($D(PRCPFLAG))  D
 . . . . I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 . . . . S VENDATA=$G(^PRC(441,ITEMDA,2,VENDA,0))
 . . . . S PSDATA=$$GETVEN^PRCPUVEN(PRCP("I"),ITEMDA,VENDA_";PRC(440,",1)
 . . . . W ! W:$P($G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),"^",12)=VENDA ?1,"m" W ?3,$E($P($G(^PRC(440,VENDA,0)),"^"),1,15),?20,"[#",+VENDA,"]",?27,$J($$UNITVAL^PRCPUX1($P(VENDATA,"^",8),$P(VENDATA,"^",7)," per "),11)
 . . . . W ?41,$J($$UNITVAL^PRCPUX1($P(PSDATA,"^",3),$P(PSDATA,"^",2)," per "),11),?55,$J($P(PSDATA,"^",4),9),?71,$J($P(VENDATA,"^",2),9)
 . . . . S SUBERROR="" F  S SUBERROR=$O(^TMP($J,"PRCPRPKG",NSN,ITEMDA,7,VENDA,SUBERROR)) Q:SUBERROR=""!($G(PRCPFLAG))  D
 . . . . . D DISPLAY(7+SUBERROR,^TMP($J,"PRCPRPKG",NSN,ITEMDA,7,VENDA,SUBERROR))
 . . . . . I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 . . I ERROR=8 D
 . . . I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 . . . W !?3,"TRANSACTION",?28,"VENDOR",?50,"UNIT per REC",?65,"CF",?71,"QTY OUTST"
 . . . S TRANDA=0 F  S TRANDA=$O(^TMP($J,"PRCPRPKG",NSN,ITEMDA,8,TRANDA)) Q:'TRANDA!($G(PRCPFLAG))  S D=$G(^PRCP(445,PRCP("I"),1,ITEMDA,7,TRANDA,0)) I D'="" D
 . . . . I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 . . . . W !?3,$P($G(^PRCS(410,+TRANDA,0)),"^"),?28,$E($P($G(^PRC(440,+$P($G(^PRCS(410,+TRANDA,3)),"^",4),0)),"^"),1,20)
 . . . . W ?50,$J($$UNITVAL^PRCPUX1($P(D,"^",4),$P(D,"^",3)," per "),11),?65,$J($P(D,"^",5),2),?70,$J($P(D,"^",2),10)
 . . . . S SUBERROR="" F  S SUBERROR=$O(^TMP($J,"PRCPRPKG",NSN,ITEMDA,8,TRANDA,SUBERROR)) Q:SUBERROR=""!($G(PRCPFLAG))  D
 . . . . . D DISPLAY(8+SUBERROR,^TMP($J,"PRCPRPKG",NSN,ITEMDA,8,TRANDA,SUBERROR))
 . . . . . I $Y>(IOSL-6) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 I '$G(PRCPFLAG) D END^PRCPUREP
 Q
 ;
 ;
DISPLAY(V1,V2)     ;  process and display error message
 N P1,P2,P3,X
 S P1=$P(V2,"^"),P2=$P(V2,"^",2),P3=$P(V2,"^",3)
 S X=$P($TEXT(ERRORS+V1),";",4,9)
 I X["P1" S X=$P(X,"P1")_P1_$P(X,"P1",2)
 I X["P2" S X=$P(X,"P2")_P2_$P(X,"P2",2)
 I X["P3" S X=$P(X,"P3")_P3_$P(X,"P3",2)
 S X(1)=X D DISPLAY^PRCPUX2(4,80,.X)
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"PACKAGING DISCREPANCY REPORT FOR ",PRCP("IN"),?(80-$L(%)),%,!,"NSN",?19,"DESCRIPTION",?47,"[#MI]",?55,"UNIT per ISSUE",! S %="",$P(%,"-",81)="" W %
 Q
 ;
 ;
ERRORS ;;  error codes
 ;;1;Mandatory Source P1 not defined as a vendor in the item master file.
 ;;2;Unit of Purchase (P1) for mandatory source vendor P2 in item master file needs to be correctly entered.
 ;;3;Whse inventory point unit of issue (P1) should equal unit of purchase (P2) for mandatory source vendor P3 in the item master file.
 ;;4;Primary inventory point mandatory source P1 should equal mandatory source P2 from the item master file.
 ;;5;Primary inventory point mandatory source P1 needs to be added as a procurement source in the inventory point.
 ;;6;Primary inventory point unit of receipt (P1) for mandatory source P2 should equal the unit of purchase (P3) from the item master file.
 ;;7;Unit of purchase (P1) in item master file needs to be correctly entered.
 ;;8;Vendor needs to be added as a procurement source in the inventory point.
 ;;9;Unit of receipt (P1) should equal the unit of purchase (P2) from the item master file.
 ;;10;Vendor needs to be removed as a procurement source.
 ;;11;P1
 ;;12;Outstanding transaction unit of receipt (P1) should equal unit of purchase (P2).
 ;;13;
 ;;14;
 ;;15;NSN needs to be defined.
 ;;16;SKU (P1) should equal warehouse unit of issue (P2).
