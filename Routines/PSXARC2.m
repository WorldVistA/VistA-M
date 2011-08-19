PSXARC2 ;BIR/HTW-Rx Order Entry Screen for CMOP  [ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 D NOW^%DTC S Y=% X ^DD("DD")
 U PSXP W @PSXPIOF
 W ?10,"CMOP MASTER DATABASE ARCHIVE",?45,Y
 S REC=$P(REC,"|",2)
 W !,"ARCHIVE REPORT FOR TRANSMISSION # "_$P(REC,"^")
 W !,?8," by ",$P($G(^VA(200,DUZ,0)),"^")_"  on "_$P(Y,"@"),!!
 ;Print 552.1 data
 W !,$J("Status: ",15),$P(REC,"^",2)
 W ?40,$J("Trans D/T: ",15),$P(REC,"^",3)
 W !,$J("Received D/T: ",15),$P(REC,"^",4)
 W ?40,$J("Closed D/T: ",15),$P(REC,"^",5)
 W !,$J("Processed D/T: ",15),$P(REC,"^",6)
 W ?40,$J("Start Seq #: ",15),$P(REC,"^",7)
 W !,$J("End Seq #: ",15),$P(REC,"^",8)
 W ?40,$J("Total Orders: ",15),$P(REC,"^",9)
 W !,$J("Total Rx's: ",15),$P(REC,"^",10)
 W ?40,$J("Purge Status: ",15),$P(REC,"^",11)
 W !,$J("Retrans: ",15),$P(REC,"^",12)
 W ?40,$J("Orig Trans #: ",15),$P(REC,"^",13)
 W !,$J("Division: ",15),$P(REC,"^",14)
 W ?40,$J("Site Name: ",15),$P(REC,"^",15)
 W !,$J("Sender: ",15),$P(REC,"^",16)
COMM S $P(ZQ,"-",50)="",$P(ZQ1,"=",75)=""
 I '$D(COM) G LBL
 W !!,"Comments: "
 F ZX=0:0 S ZX=$O(COM(ZX)) Q:'ZX  W !,$P(COM(ZX),"|",2)
LBL I '$D(LBL) G ACK
 W !!,"LABEL LOG: "
 W !,"DATE PRINTED",?30,"PRINTED BY"
 W !,ZQ
 S ZX=0
L1 S ZX=$O(LBL(ZX)) G:($G(ZX)']"") ACK
 S LBL(ZX)=$P(LBL(ZX),"|",2)
 F ZXX=1:1 Q:$P($G(LBL(ZX)),"/",ZXX)']""  D
 .S ZDT=$P($P(LBL(ZX),"/",ZXX),"^"),ZNAME=$P($P(LBL(ZX),"/",ZXX),"^",2)
 .W !,ZDT,?30,ZNAME
 .K ZDT,ZNAME
 I $O(LBL(ZX))]"" G L1
 K ZX,ZXX
ACK Q:'$D(ACK)
 W !!,"Acknowledgement Text: "
 W !,$P(ACK,"|",2)
 Q
RX ;Print 552.4 data
 U PSXP
 I $G(PSXPIOST)'["C-",($Y>48) W @PSXPIOF
 W !!,"Rx #",?17,": ",$P(REC1,"^"),?35,"Fill #",?48,": ",$P(REC1,"^",12)
 W ?60,"Qty: ",$P(REC1,"^",13)
 W !,"Employee Name",?17,": ",$P(REC1,"^",6)
 W !,"Price/Disp Unit",?17,": ",$P(REC1,"^",11)
 W ?35,"Drug ID #",?48,": ",$P(REC1,"^",4)
 W !,"Release Status",?17,": ",$P(REC1,"^",2)
 W ?35,"Release Type",?48,": ",$P(REC2,"^")
 W !,"Rx Status",?17,": ",$P(REC1,"^",10)
 W ?35,"NDC",?48,": ",$P(REC1,"^",5)
 W !,"Carrier",?17,": ",$P(REC2,"^",5)
 W ?35,"Package ID #",?48,": ",$P(REC2,"^",6)
 W !,"Date Shipped",?17,": ",$P(REC2,"^",4)
 W !,"Processed D/T",?17,": ",$P(REC1,"^",7)
 W ?42,"Completed D/T: ",$P(REC1,"^",9)
 W !,"Remote Error Cond",?17,": ",$P(REC2,"^",2)
 W !,"Cancel Reason",?17,": ",$P(REC1,"^",3)
 I $G(LOT)']"" W !,ZQ1,! Q
LOT U PSXP S ZPC=1
L2 S ZL=$P($P(LOT,"/",ZPC),"^"),ZDT=$P($P(LOT,"/",ZPC),"^",2)
 I $G(ZL)']"",($G(ZDT))']"" K ZL,ZDT W !,ZQ1,! Q
 W !,"LOT #: ",$G(ZL),?35,"Expiration Date: ",$G(ZDT)
ELOT K ZL,ZDT S ZPC=ZPC+1
 G L2
