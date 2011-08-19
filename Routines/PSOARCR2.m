PSOARCR2 ;BHAM ISC/LGH - rx retrieve ; 07/07/92
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
RXP ;
 W !!,"Rx: ",$P(RX(0),"^"),?14,"DRUG: ",?20,$P(RX(0),"^",6),?65,"TRADE NAME: ",$P(RX(3),"^",12)," ",?96,"QTY: ",$P(RX(0),"^",7),"     ",$P(RX(0),"^",8)," DAY SUPPLY"
 W !?7,"SIG: ",$P(RX(0),"^",10),!?4,"LATEST: ",$P(RX(3),"^"),?37,"# OF REFILLS: ",$P(RX(0),"^",9),"  REMAINING: ",$P(RX(3),"^",11),?70,"PROVIDER: ",$P(RX(0),"^",4)
 W !?4,"ISSUED: ",$P(RX(0),"^",13),?43,"CLINIC: ",$P(RX(0),"^",5),?71,"DIVISION: ",$P(RX(2),"^",9),!?4,"LOGGED: ",$P(RX(2),"^"),?42,"ROUTING: ",$P(RX(0),"^",11),?69,"CLERK CODE: ",$P(RX(0),"^",16)
 W !?3,"EXPIRES: ",$P(RX(2),"^",11),?46,"CAP: ",$P(RX(3),"^",10),?73,"STATUS: ",$P(RX(0),"^",15)
 W !,?4,"FILLED: ",$P(RX(2),"^",2),?24,"PHARMACIST: ",$P(RX(2),"^",3),?59,"VERIFYING PHARMACIST: ",$P(RX(2),"^",10),?103,"LOT #: ",$P(RX(2),"^",4)
 W !,?3,"  NEXT: ",$P(RX(3),"^",2),?43,"COPAY TYPE: ",$P($G(RX("IB")),"^"),?73,"COPAY TRANSACTION #: ",$P($G(RX("IB")),"^",2)
 I $P(RX(3),"^",7)]"" W !?3,"REMARKS: ",$P(RX(3),"^",7)
REFILL I $D(RX("1,1")) S HEAD="REFILL",A="1,1" D HEAD,REFILL1 F  S A=$O(RX(A)) Q:+A'>0!(A'["1,")  D REFILL1
CMOPA I $D(RX("4,1")) S HEAD="CMOP EVENT",A="4,1" D HEAD,CMOP1 F  S A=$O(RX(A)) Q:+A'>0!(A'["4,")  D CMOP1
CMOPB I $D(RX("5,1")) S HEAD="CMOP LOT#/EXPIRATION DATE",A="5,1" D HEAD,CMOP2 F  S A=$O(RX(A)) Q:+A'>0!(A'["5,")  D CMOP2
PARTIAL I $D(RX("P,1")) S TYPE="P" S HEAD="PARTIAL FILLS",A="P,1" D HEAD,REFILL1 F  S A=$O(RX(A)) Q:$P(A,",")'="P"  D REFILL1
LABEL I $D(RX("L,1")) S TYPE="L" S HEAD="LABEL",A="L,1" D HEAD,LABEL1 F  S A=$O(RX(A)) Q:$P(A,",")'="L"  D LABEL1
ACT I $D(RX("A,1")) S TYPE="A" S HEAD="ACTIVITY",A="A,1" D HEAD,ACTI F  S A=$O(RX(A)) Q:$P(A,",")'="A"  D ACTI
 W !
 K RX,HEAD,XX,REA,A,TYPE,REF,STAT Q
REFILL1 W !,$P(A,",",2),?10,$P(RX(A),"^"),?25,$P(RX(A),"^",4),?35,$P(RX(A),"^",2),?45,$P(RX(A),"^",6),?50,$P(RX(A),"^",5),?70,$P(RX(A),"^",9)
 I $P(RX(A),"^",16)]"" W !?4,"RETURNED TO STOCK:  "_$P(RX(A),"^",16)
 I $P(RX(A),"^",18)]"" W !?4,"RELEASED:  "_$P(RX(A),"^",18)
 I $P(RX(A),"^",20)]"" W "     COPAY BILLING #:  ",$P(RX(A),"^",20)
 W !?5,"REMARKS: ",$P(RX(A),"^",3)
 Q
CMOP1 W !,$P(A,",",2),?3,$P(RX(A),"^")_"-"_$P(RX(A),"^",2)
 W ?22,$J($P(RX(A),"^",3),3),?30,$P(RX(A),"^",4)
 W ?40,$P($G(RX(A)),"^",9),?52,$E($P($G(RX(A)),"^",10),1,20),?74,$E($P($G(RX(A)),"^",11),1,20)
 W ?98,$S($P(RX(A),"^",8)]"":$P(RX(A),"^",8),$P(RX(A),"^",5)]"":"CAN DT/REASON:  "_$P(RX(A),"^",5),1:"")
 Q
CMOP2 W !,$P(A,",",2),?3,$J($P(RX(A),"^"),40),?51,$J($P(RX(A),"^",2),10),?71,$J($P(RX(A),"^",3),3)
 Q
ACTI S XX=$P(RX(A),"^",2),STAT=$P(^DD(52.3,.02,0),"^",3),XX=XX_":",REA=$S(XX=":":"UNKNOWN",1:$P($P(STAT,XX,2),";")),XX=$P(RX(A),"^",4),REF=$S(XX=0:"ORIGINAL",XX>0:"REFILL # "_XX,1:"UNKNOWN")
 W !,$P(A,",",2),?6,$P(RX(A),"^"),?20,REA,?40,REF,?55,$P(RX(A),"^",3),?75,$P(RX(A),"^",5) Q
LABEL1 S XX=$P(RX(A),"^",2),REF=$S(XX=0:"ORIGINAL",XX>0:"REFILL # "_XX,1:"UNKNOWN")
 W !,$P(A,",",2),?6,$P(RX(A),"^"),?20,REF,?33,$P(RX(A),"^",4),?65,$P(RX(A),"^",3) Q
HEAD ;
 W !!,HEAD_" LOG"
 I (A="1,1")!(A="P,1") W !,"#",?10,"FILL DATE",?25,"QTY",?37,"ROUTING",?50,"LOT#",?60,"PHARMACIST",?92,"DIVISION"
 I A="A,1" W !,"#",?6,"DATE",?20,"REASON",?40,"RX REF",?55,"INITIATOR",?75,"COMMENT"
 I A="L,1" W !,"#",?6,"DATE",?20,"REFERENCE",?33,"PRINTED BY",?65,"COMMENT"
 I A="4,1" W !,"#",?5,"TRANS #",?20,"RX REF",?30,"STATUS",?40,"SHIP DATE",?52,"CARRIER",?76,"PACKAGE ID",?100,"REMARKS"
 I A="5,1" W !,"#",?25,"LOT #",?49,"EXPIRATION DATE",?70,"RX REF"
 W !,"==================================================================================================="
 Q
