IBARXEC5 ;ALB/AAS - RX COPAY EXEMPTION CONVERSION REPORT PRINT ; 14-JAN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ;
PRINT ; -- Print report
 S IBPAG=0,IBQUIT=0 D NOW^%DTC S Y=% D D^DIQ S IBPDAT=Y
 K IBBCNT
 D HDR
 I '$D(^TMP("IBCONV",$J)) W !,"No Charges Canceled due to Income Exemption in date range." Q
 S IBNAM="",(IBPCNT,IBTAMT,IBTCNT)=0
 F  S IBNAM=$O(^TMP("IBCONV",$J,IBNAM)) Q:IBNAM=""!(IBQUIT)  D
 .S DFN=0 F  S DFN=$O(^TMP("IBCONV",$J,IBNAM,DFN)) Q:'DFN!(IBQUIT)  S IBPCNT=IBPCNT+1 D
 ..S (IBBCNT,IBAMT,IBN)=0 F  S IBN=$O(^TMP("IBCONV",$J,IBNAM,DFN,IBN)) D:IBN="" SUB Q:'IBN!(IBQUIT)  S X2=^(IBN) D ONE
 ;
 D:'IBQUIT SUM
 K ^TMP("IBCONV",$J)
 Q
 ;
ONE ; -- print one line
 I ($Y+5)>IOSL D PAUSE^IBOUTL,HDR:'IBQUIT
 W ! I 'IBBCNT W $E(IBNAM,1,20),?22,$P(X2,"^",2) S ERR="" D ERR I ERR]"" W ?36,ERR,!
 ;
 S N=$G(^IB(IBN,0)),N1=$G(^(1)) ; new copay nodes
 S O=$G(^IB(+$P(N,"^",9),0)),O1=$G(^(1)) ; original copay nodes
 S IBBCNT=IBBCNT+1,IBAMT=IBAMT+$P(N,"^",7),IBTAMT=IBTAMT+$P(N,"^",7),IBTCNT=IBTCNT+1
 ;
 W ?36,$$DAT1^IBOUTL($P(O1,"^",2))
 ;
 S Y=+$P($P($P(O,"^",4),";",2),":",2)
 W $J($P($P(O,"^",8),"-"),9),$S(+Y:"/"_Y,1:"")
 W ?57,$$DAT1^IBOUTL($P(N1,"^",2)),?68,+N,?81,$P(N,"^",11),?97,"$",$P(N,"^",7)
 Q
 ;
HDR ; -- print header
 I $D(IBCONVER)!($G(IBQUIC))!(IBPAG)!($E(IOST,1,2)="C-") W @IOF
 S IBPAG=IBPAG+1
 W "Rx Copay Income Exemption Report",?(IOM-35)
 W $P(IBPDAT,"@")," ",$P(IBPDAT,"@",2),"  Page ",IBPAG
 W !,"Charges Canceled ",$S(IBBDT=IBEDT:"on "_$$DAT1^IBOUTL(IBBDT),1:"from "_$$DAT1^IBOUTL(IBBDT)_" to "_$$DAT1^IBOUTL(IBEDT))
 W !,"                                                         Cancel     Cancel       Original"
 W !,"Name                     Pt. ID      Rx Date  Rx/Refill  Date       IB Number    Bill No.      Amount"
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
SUB ; -- write sub totals
 W !,?85,"--------------"
 W !,?85,"Count  =  ",$J(IBBCNT,4)
 W !,?85,"Amount = $",$J(IBAMT,4),!
 Q
 ;
SUM ; -- print final summary
 W !!?40,"======================================="
 W !?40,"    Total Patient Count =  ",$J(IBPCNT,7)
 W !?40,"    Total Rx Count      =  ",$J(IBTCNT,7)
 W !?40,"    Total Dollar amount = $",$J(IBTAMT,7)
 Q
 ;
ERR ; -- see if any errors
 N DJ S DJ=""
 F  S DJ=$O(^TMP("IB-ERROR",DJ)) Q:DJ=""  S ERR=$G(^TMP("IB-ERROR",DJ,DFN)) Q:ERR]""
 Q
