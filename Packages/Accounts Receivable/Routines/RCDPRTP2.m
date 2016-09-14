RCDPRTP2 ;ALB/LDB - CLAIMS MATCHING REPORT ;1/26/01  3:16 PM
 ;;4.5;Accounts Receivable;**151,276,303**;Mar 20, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PRINT1 ;
 N REJECT
 I $Y>(IOSL-2) D PAUSE Q:$G(RCQ)  D HDR^RCDPRTP1,HDR1
 ; PRCA*4.5*276 - get EEOB indicator '%'and attach it to the bill number when applicable. Adjust report tabs to make room for EEOB indicator '%'.
 N RC430 S RC430=+$O(^PRCA(430,"B",""_$P(RCIBDAT,"^",4)_"",0))
 S RCEEOB=$$EEOB(RC430)
 ; #IA 6060 for $$BILLREJ^IBJTU6
 S REJECT=$S($$BILLREJ^IBJTU6($P($P(RCIBDAT,"^",4),"-",2)):"c",1:" ") ;PRCA*4.5*303 Add indicator for rejects
 W !,$S(RCTP=RCBILL:"*",$D(RCTP(RCTP)):"*",1:" "),$G(RCEEOB)_REJECT_$P(RCIBDAT,"^",4),?17,$P(RCIBDAT,"^",5),?24
 W $$STAT(RCTP),?31,$$DATE(+RCIBDAT),?42,$$DATE($P(RCIBDAT,"^",2))
 S Y=$S($G(RCTP(RCTP)):RCTP(RCTP),$G(^TMP("RCDPRTPB",$J,RCNAM,RCBILL)):^(RCBILL),1:"") I RCTP=RCBILL!($D(RCTP(RCTP))) W ?53,$$DATE(Y)
 S RCAMT=$P($G(^PRCA(430,+RCTP,0)),"^",3),RCAMT1=$P($G(^PRCA(430,+RCTP,7)),"^",7) W ?64,$J(RCAMT,9,2)
 W ?76,$J(RCAMT1,9,2) S RCAMT(0)=RCAMT(0)+RCAMT,RCAMT(1)=RCAMT(1)+RCAMT1
 W ?88,$E($P(RCIBDAT,"^",7),1,25)
 K RCTP(RCTP)
 Q
 ;
PRINT2  ; Print the detail line for a first party bill.
 I $Y>(IOSL-2) D PAUSE Q:$G(RCQ)  D HDR^RCDPRTP1,HDR2
 W !," ",$P(RCIBDAT,"^",4),?14,$P(RCIBDAT,"^",6)
 S RCIBFN=$P(RCIBDAT,"^",4) I RCIBFN S RCIBFN=$O(^PRCA(430,"B",RCIBFN,0))
 ; PRCA*4.5*276 - adjust report tabs to make room for EEOB indicator '%'.
 W ?36,$$STAT(RCIBFN),?42,$$DATE(+RCIBDAT),?54,$$DATE($P(RCIBDAT,"^",2))
 W ?66,$J($P(RCIBDAT,"^",5),9,2),?78,$P(RCIBDAT,"^",7)
 W ?87,$J($S($G(^PRCA(430,+RCIBFN,7)):+($P(^(7),"^")+$P(^(7),"^",2)+$P(^(7),"^",3)+$P(^(7),"^",4)+$P(^(7),"^",4)),1:0),9,2)
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
 ; PRCA*4.5*276 - adjust report tabs to make room for EEOB indicator '%'.
 W !!,"Bill #",?15,"P/S/T",?22,"Status",?30,"Bill From",?42,"Bill To",?53,"Posted",?63,"Amt Billed",?76,"Amt Paid",?88,"Payor"
 W !,"-------------",?15,"-----",?22,"------",?30,"---------",?42,"--------",?53,"--------",?63,"----------",?75,"----------",?88,"-----"
 Q
 ;
HDR2 ;
 W !!,"Associated First Party Charges:"
 W !,"==============================="
 ; PRCA*4.5*276 - adjust report tabs to make room for EEOB indicator '%'.
 W !," Bill #",?14,"Charge Type",?34,"Status",?42,"From/Fill",?54,"To/Rel",?65,"Amt Billed",?78,"On Hold",?87,"  Balance"
 W !,"-----------",?14,"----------------",?34,"------",?42,"---------",?54,"---------",?65,"----------",?78,"-------",?87," ----------"
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
 ;
EEOB(RCBILL) ; PRCA*4.5*276 - get EEOB indicator for a bill
 ; Interaction with IB file #361.1 covered by IA #4051.
 ; RCBILL is the IEN of the bill in files #399/#430 and must be valid,
 ; Exclude an EOB type of MRA when getting payment information. Return
 ; the EEOB indicator '%' if payment activity was found.
 ;
 N RCEEOB,RCVAL,Z
 I $G(RCBILL)=0 Q ""
 I '$O(^IBM(361.1,"B",RCBILL,0)) Q ""  ; no matching entry for bill
 I $P($G(^DGCR(399,RCBILL,0)),"^",13)=1 Q ""  ;avoid 'ENTERED/NOT REVIEWED' status
 ; handle both single and multiple bill entries in file #361.1
 S Z=0 F  S Z=$O(^IBM(361.1,"B",RCBILL,Z)) Q:'Z  D  Q:$G(RCEEOB)="%"
 . S RCVAL=$G(^IBM(361.1,Z,0))
 . S RCEEOB=$S($P(RCVAL,"^",4)=1:"",$P(RCVAL,"^",4)=0:"%",1:"")
 Q RCEEOB  ; EEOB indicator for 1st/3rd party payment on bill
