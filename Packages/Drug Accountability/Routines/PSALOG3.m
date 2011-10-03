PSALOG3 ;BIR/LTL-Post Drug Procurement History - CONT'D;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;This routine contains the warehouse drug report. It is called by PSALOG2.
 ;
LOOP2 S PSAPG=0 D HEADER2
 S (PSA(33),PSA(55))=0
 F  S PSA(33)=$O(^TMP("PSAC",$J,PSA(33))) Q:'PSA(33)!(PSAOUT)  D:$Y+4>IOSL HEADER2 Q:PSAOUT  F  S PSA(55)=$O(^TMP("PSAC",$J,+PSA(33),PSA(55))) Q:'PSA(55)!($P($G(^TMP("PSAC",$J,+PSA(33),+PSA(55))),U)<PSA(44))  D
 .W !,$E($$DESCR^PRCPUX1($P($G(^TMP("PSAC",$J,+PSA(33),PSA(55))),U,2),PSA(55)),1,50)
 .S X=$P($G(^TMP("PSAC",$J,+PSA(33),PSA(55))),U),X2="2$"
 .D COMMA^%DTC W ?53,X,"(",$E($$INVNAME^PRCPUX1($P($G(^TMP("PSAC",$J,+PSA(33),PSA(55))),U,2)),1,20),")",!
 I $E(IOST,1,2)="C-",'PSAOUT W ! S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the option." D ^DIR
 K ^TMP("PSAC",$J) S PSAOUT=1 Q
HEADER2 I $E(IOST,1,2)'="P-",PSAPG S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 W:$Y @IOF S PSAPG=PSAPG+1 W !,"High Cost Items Over $",PSA(44),?57,"TOTAL $",?75,"PSAPG:",PSAPG,!,PSALN
 Q
