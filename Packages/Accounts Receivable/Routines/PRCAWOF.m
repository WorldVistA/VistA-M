PRCAWOF ;WASH-ISC@ALTOONA,PA/RGY-AR WRITE-OFF REPORT ;8/23/95  9:00 AM
V ;;4.5;Accounts Receivable;**20*,104*;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 NEW BEG,DIR,DIROUT,DIRUT,DTOUT,DUOUT,END,IOS,X,Y,%DT,%ZIS,ZTSK
BEG ;
 W ! D NOW^%DTC S %DT(0)=-%,%DT="AEXP",%DT("A")="Starting Date: " D ^%DT G:Y<0 Q S BEG=Y
 S %DT="AEX",%DT("A")="  Ending Date: " D ^%DT G:Y<0 Q S END=Y
 I BEG>END W !!,*7,"*** Beginning date is Greater than or equal to Ending date ***",! G BEG
 S %ZIS="MQ" D ^%ZIS G:POP Q
 I $D(IO("Q")) S ZTRTN="DQ^PRCAWOF",ZTSAVE("BEG")="",ZTSAVE("END")="",ZTDESC="Write-Off Report" D ^%ZTLOAD G Q
 U IO D DQ
Q D ^%ZISC Q
DQ ;
 NEW DATE,DEBT,BILL,PAGE,PRI
 S (DEBT,PAGE)=0
 W:$E(IOST)="C" @IOF D HDR1
 F  S DEBT=$O(^PRCA(433,"ATD",DEBT)) Q:'DEBT  S PRI=1 F DATE=BEG-.0001:0 S DATE=$O(^PRCA(433,"ATD",DEBT,DATE)) Q:DATE>(END+.9999)!'DATE  F TRAN=0:0 S TRAN=$O(^PRCA(433,"ATD",DEBT,DATE,TRAN)) Q:'TRAN  D
 . I $G(^RCD(340,+DEBT,0))'["DPT" Q
 . I ","_$O(^PRCA(430.3,"AC",2,0))_","_$O(^PRCA(430.3,"AC",20,0))_","'[(","_$P($G(^PRCA(433,TRAN,1)),"^",2)_",") Q
 . I PRI F BILL=0:0 S BILL=$O(^PRCA(430,"C",DEBT,BILL)) Q:'BILL  D  Q:DEBT="Z"
 ..  I $P($G(^PRCA(430,BILL,0)),"^",8)'=$O(^PRCA(430.3,"AC",109,0)) G Q2
 ..  I PRI D:$Y+5>IOSL HDR G:DEBT="Z" Q2 W !,$P($G(^DPT(+$P(^RCD(340,DEBT,0),"^"),0)),"^") S X=$P(^(0),"^",9) W " (",$E(X,1,3),"-",$E(X,4,5),"-",$E(X,6,9),")" S PRI=0
 ..  D:$Y+5>IOSL HDR G:DEBT="Z" Q2
 ..  W !?5,"Bill # ",$P(^PRCA(430,BILL,0),"^") S X=$G(^PRCA(430,BILL,7)) W ?25,"Amt: ",$J($P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5),7,2)
 ..  F X=0:0 S X=$O(^PRCA(433,"C",BILL,X)) Q:'X  I ",9,29,8,10,11,"[(","_$P($G(^PRCA(433,X,1)),"^",2)_",") W ?45,$P(^PRCA(430.3,+$P(^PRCA(433,X,1),"^",2),0),"^") Q
 ..  W:'X ?40,"Unknown Type"
Q2 ..  Q
 . I DEBT="Z" G Q1
 . I PRI S DEBT=DEBT_.1 G Q1
 . D:$Y+5>IOS HDR G:DEBT="Z" Q1
 . W !?5,"Trans #: ",TRAN,?20,"Date: ",$$SLH^RCFN01(DATE) S X=$G(^PRCA(433,TRAN,3)) W ?40,"Amt: ",$J($P(X,"^")+$P(X,"^",2)+$P(X,"^",3)+$P(X,"^",4)+$P(X,"^",5),7,2)
 . W ?60,$P(^PRCA(430.3,+$P(^PRCA(433,TRAN,1),"^",2),0),"^")
Q1 . Q
 Q
HDR ;Print Header of report
 I $E(IOST)="C" R !!,"Press return to continue: ",X:DTIME S:'$T DTOUT=1 I X["^"!$D(DTOUT) S DEBT="Z" G Q3
 W @IOF
HDR1 ;
 S PAGE=PAGE+1
 W !!,"Payments Received for Patient Accounts with Written-off Bills",?IOM-($L(PAGE)+7),"Page: ",PAGE
 W !,"From ",$$SLH^RCFN01(BEG)," thru ",$$SLH^RCFN01(END) S X="Date: "_$$SLH^RCFN01(DT) W ?IOM-$L(X)-1,X,!
 S X="",$P(X,"-",80)="" W X,!
Q3 Q
