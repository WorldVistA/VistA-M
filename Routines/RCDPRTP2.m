RCDPRTP2 ;ALB/LDB - CLAIMS MATCHING REPORT ;1/26/01  3:16 PM
 ;;4.5;Accounts Receivable;**151**;Mar 20, 1995
 ;
PRINT1 ;
 I $Y>(IOSL-2) D PAUSE Q:$G(RCQ)  D HDR^RCDPRTP1,HDR1
 W !,$S(RCTP=RCBILL:"*",$D(RCTP(RCTP)):"*",1:" "),$P(RCIBDAT,"^",4),?14,$P(RCIBDAT,"^",5),?20
 W $$STAT(RCTP),?26,$$DATE(+RCIBDAT),?35,$$DATE($P(RCIBDAT,"^",2))
 S Y=$S($G(RCTP(RCTP)):RCTP(RCTP),$G(^TMP("RCDPRTPB",$J,RCNAM,RCBILL)):^(RCBILL),1:"") I RCTP=RCBILL!($D(RCTP(RCTP))) W ?46,$$DATE(Y)
 S RCAMT=$P($G(^PRCA(430,+RCTP,0)),"^",3),RCAMT1=$P($G(^PRCA(430,+RCTP,7)),"^",7) W ?57,$J(RCAMT,9,2)
 W ?68,$J(RCAMT1,9,2) S RCAMT(0)=RCAMT(0)+RCAMT,RCAMT(1)=RCAMT(1)+RCAMT1
 W ?83,$E($P(RCIBDAT,"^",7),1,25)
 K RCTP(RCTP)
 Q
 ;
PRINT2  ; Print the detail line for a first party bill.
 I $Y>(IOSL-2) D PAUSE Q:$G(RCQ)  D HDR^RCDPRTP1,HDR2
 W !," ",$P(RCIBDAT,"^",4),?14,$P(RCIBDAT,"^",6)
 S RCIBFN=$P(RCIBDAT,"^",4) I RCIBFN S RCIBFN=$O(^PRCA(430,"B",RCIBFN,0))
 W ?30,$$STAT(RCIBFN),?35,$$DATE(+RCIBDAT),?47,$$DATE($P(RCIBDAT,"^",2))
 W ?56,$J($P(RCIBDAT,"^",5),9,2),?69,$P(RCIBDAT,"^",7)
 W ?77,$J($S($G(^PRCA(430,+RCIBFN,7)):+($P(^(7),"^")+$P(^(7),"^",2)+$P(^(7),"^",3)+$P(^(7),"^",4)+$P(^(7),"^",4)),1:0),9,2)
 Q
 ;
 ;
PRINT3 ; Print patient detail information.
 I $Y>(IOSL-5) D PAUSE Q:$G(RCQ)  D HDR^RCDPRTP1
 S RCNAM1=^TMP("RCDPRTPB",$J,RCNAM)
 W !!,RCLINE
 W !,"NAME: ",$P(RCNAM,"^")," (",$E($P(RCNAM1,"^",3),6,9)_")"
 W !,"Prim. Elig: ",$P(RCNAM1,"^",2)
 W ?44,"DOB: ",$P(RCNAM1,"^")
 W ?61,"RX COVERAGE: ",$S('$G(^TMP("IBRBT",$J,RCBILL)):"NO",1:"YES")
 W !,RCLINE
 Q
 ;
HDR1    ;
 W !!,"Third Party Bills: * -> bill for which payment was posted"
 W !,"============================="
 W !!," Bill #",?12,"P/S/T",?19,"Status",?26,"Bill From",?36,"Bill To",?46,"Posted",?57,"Amt Billed",?69,"Amt Paid",?83,"Payor"
 W !,"-------",?12,"-----",?19,"------",?26,"---------",?36,"-------",?46,"------",?57,"---------",?69,"--------",?83,"-----"
 Q
 ;
HDR2 ;
 W !!,"Associated First Party Charges:"
 W !,"==============================="
 W !," Bill #",?14,"Charge Type",?28,"Status",?35,"From/Fill",?47,"To/Rel",?56,"Amt Billed",?69,"On Hold",?77," Balance"
 W !,"------",?14,"-----------",?28,"------",?35,"---------",?47,"-------",?56,"----------",?69,"-------",?77,"-----------"
 Q
 ;
STAT(RCIBFN) ;AR Status
 I '$G(RCIBFN) Q ""
 N RCSTAT
 S RCSTAT=$P($G(^PRCA(430,+RCIBFN,0)),"^",8),RCSTAT=$P($G(^PRCA(430.3,+RCSTAT,0)),"^",2)
 Q RCSTAT
 ;
DATE(X) ; Convert FileMan date to mm/dd/yy
 Q $S($G(X):$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")
 ;
 ;
PAUSE ; Page break.
 I $E(IOST,1,2)'="C-" Q
 N RCX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 I IOSL<100 F RCX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S RCQ=1
 Q
