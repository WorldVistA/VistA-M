PRCPRDIS ;WISC/CC-supply station quantity discrepancy report ;4/00
V ;;5.1;IFCAP;**1,24**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$D(PRCP("DPTYPE")) S PRCP("DPTYPE")="S"
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="S" Q
 I $P($G(^PRCP(445,PRCP("I"),5)),"^",1)']"" Q
 ;
 N %,I,INVPT,PRCPINNM,X,XP,XH,Y
 S INVPT=PRCP("I"),PRCPINNM=$$INVNAME^PRCPUX1(INVPT)
 ;
 K X S X(1)="This report displays items whose on-hand quantity in "_PRCPINNM_" differs from the supply station's on-hand amount"
 D DISPLAY^PRCPUX2(40,79,.X)
 ;
 K X
 S Y=$P($G(^PRCP(445,PRCP("I"),6)),"^",1)
 I Y']"" S X(1)="No QOH information was ever received.  It is recommended you request a QOH update."
 I Y]"" D
 . X ^DD("DD")
 . S I=$P(Y,"@",1),Y=$P(Y,"@",2,99)
 . S X(1)="The Last QOH update was received on "_I
 . I Y]"" S X(1)=X(1)_" at "_Y_"."
 . S X(2)="If this date is too old, you may now request an update."
 D DISPLAY^PRCPUX2(2,40,.X)
 S XP="Do you want to request a refresh of the supply station QOH"
 S XH(1)="Enter YES to request the supply station send a QOH update to GIP,"
 S XH(2)="Enter NO to continue with the report using what has already been received,"
 S XH(3)="Enter '^' to exit."
 S %=$$YN^PRCPUYN(2) I '% Q
 I %'=1,%'=2 Q
 I %=1 D  Q
 . W !
 . D EN^DDIOL("Sending request...")
 . D EN^DDIOL("Please give GIP time to get the information before printing the report.")
 . D BLDSEG^PRCPHLQU(INVPT)
 ;
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 . S ZTDESC="Item discrepancy report",ZTRTN="PRINT^PRCPRDIS"
 . S ZTSAVE("PRCP*")=""
 W !!,"<*> please wait <*>"
 ;
PRINT N %,GIPCNT,INVPT,ITEM,NOW,PAGE,REFILL,SCREEN,SSCNT,X,Y
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S INVPT=PRCP("I")
 S ITEM=0
 F  S ITEM=$O(^PRCP(445,INVPT,1,ITEM)) Q:'+ITEM  D  I $D(PRCPFLAG) Q
 .  I $P($G(^PRCP(445,INVPT,1,ITEM,0)),"^",9)<1 Q  ; not a SS item
 .  S GIPCNT=$P($G(^PRCP(445,INVPT,1,ITEM,0)),"^",7)
 .  S SSCNT=$P($G(^PRCP(445,INVPT,1,ITEM,9)),"^",1)
 .  I 'GIPCNT,'SSCNT Q
 .  I GIPCNT=SSCNT Q
 .  I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .  ; W !,$J(ITEM,7),"  ",$P($G(^PRCP(445,INVPT,1,ITEM,6)),"^",1)
 .  ; W !,"GIP: ",$J(GIPCNT,7),"         SUPPLY STATION: ",$J(SSCNT,7)
 .  W $J(GIPCNT,7),"  ",$J(SSCNT,7)
 .  S Y=$P($G(^PRCP(445,INVPT,1,ITEM,9)),"^",2)
 .  I Y']"" W "                       "
 .  I Y]"" D
 . . X ^DD("DD")
 . . W $J(" ("_Y_")",23)
 . W "  ",$J(ITEM,7)," ",$E($P($G(^PRCP(445,INVPT,1,ITEM,6)),"^",1),1,32)
 . S REFILL=$$REFILLS(ITEM,INVPT) I REFILL]"" W !,?8,REFILL
 . W !
 ;
 I '$G(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC Q
 ;
REFILLS(ITEMDA,PRCPINPT) ; is the item refilled in an unposted order
 ; ITEMDA = DA of item
 ; PRCPINT = DA of inventory point
 ;
 N ORD,OUTORD,PRIMVN,REFILL,X
 S ORD=0,OUTORD=0,REFILL=""
 F  S ORD=$O(^PRCP(445.3,"AD",PRCPINPT,ORD)) Q:+ORD'>0  D
 . S X=^PRCP(445.3,ORD,0)
 . I $P(X,"^",10)]"",$P(X,"^",6)="R",$D(^PRCP(445.3,ORD,1,ITEMDA)),($P(X,"^",8))="R" D
 . . I $P(^PRCP(445.3,ORD,1,ITEMDA,0),"^",7) D
 . . . I OUTORD S REFILL=REFILL_"; "
 . . . I 'OUTORD S REFILL=REFILL_"unposted refills: " S OUTORD=1
 . . . S REFILL=REFILL_"ORD# "_$P(^PRCP(445.3,ORD,0),"^",1)
 . . . S PRIMVN=$P(X,"^",2)_";PRCP(445,"
 . . . S X=$$GETVEN^PRCPUVEN(PRCPINPT,ITEMDA,PRIMVN,1)
 . . . S X=$P(X,"^",4) ; pkg multiple (conversion factor)
 . . . I 'X S X=1
 . . . S REFILL=REFILL_"("_($P(^PRCP(445.3,ORD,1,ITEMDA,0),"^",7)*X)_")"
 Q REFILL
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"SUPPLY STATION QUANTITY DISCREPANCY REPORT",?(IOM-$L(%)),%
 W !,"FOR: ",PRCPINNM,!
 W !,?2,"GIP",?19,"SUPPLY STATION"
 W !,"QTY NOW      QTY (AS OF DATE and TIME)  ITEM NUMBER AND DESCRIPTION"
 ; W !,"ITEM NUMBER AND DESCRIPTION"
 ; W ?58,$J("STAND",6),$J("NORM",6),$J("UNIT",10),!,"DESCRIPTION",?29,"MI#",?35,"NSN",?50,$J("UNIT/IS",8),$J("REOPT",6),$J("STLVL",6),$J("COST",10)
 S %="",$P(%,"-",IOM+1)="" W !,%,!
 Q
