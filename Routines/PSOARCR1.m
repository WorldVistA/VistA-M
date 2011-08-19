PSOARCR1 ;BHAM ISC/LGH - Rx retrieve ; 07/07/92
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 U PSOAT W @%MT("REW")
 S PSOAPF=0
R D PSOAT R X:DTIME G END:X="" G:X'="!" R
PAR D PSOAT R X:DTIME G:'$T END G:$P(X,"^")=NM&($G(SS)=$P(X,"^",2)) PR G PAR
END I $D(PSOAT) U IO(0) S IOP=PSOAT D ^%ZIS D ^%ZISC K IOP
Q I $D(PSOAP) U IO(0) S IOP=PSOAP D ^%ZIS D ^%ZISC K IOP
 K PSOACPM,PSOACPL,PSOACPF,NM,T,PSOAP,PSOAT,^TMP($J,"ZRX"),A,DG,GD,I,PSOACDS,PSOAEOT,Y,RX,%MT,D,PSOAPF,PSOATNM,X,XX
 Q
PR ;patient read
 S T(1)=X D READT S T(2)=X,D=$P(T(2),"^",2),A=$P(T(2),"^",3),DG=$P(T(2),"^",4),GD=$P(T(2),"^",5)
 I D>"" F I=1:1:D D READT S T(2,I)=X
 I A>"" F I=1:1:A D READT S T(3,I)=X
 I DG>"" F I=1:1:DG D READT S T(4,I)=X
 I GD>"" F I=1:1:GD D READT S T(5,I)=X
 D:'PSOAPF DPR,HD1^PSOARCSV S PSOAPF=1 ;display demo info
RXR D READT G:(X="!")!(X="") END G:$P(X,"^",2)'=NM PAR G:X="" END
RXR2 I $P($G(X),"^",2)'=NM D READT G:($G(X)="!")!($G(X)="") END
 G:(X="!")!(X="")!($P(X,"^",2)'=NM) END S RX(0)=X D READT
 I (X["$$"),$P(X,"$$",1)["1," D NODE1
 I (X["$$"),$P(X,"$$",1)["4," D NODE4
 I (X["$$"),$P(X,"$$",1)["5," D NODE5
 S RX(2)=X D READT S RX(3)=X D READT
 I (X["$$"),$P(X,"$$",1)["A," D NODEA
 I (X["$$"),$P(X,"$$",1)["L," D NODEL
 I (X["$$"),$P(X,"$$",1)["P," D NODEP
 I (X["$$"),$P(X,"$$",1)["IB" S RX("IB")=$P(X,"$$",2) D READT
 I (X["$$"),$P(X,"$$",1)["C," S RX("C")=$P(X,"$$",2) D READT
 I (X["$$"),$P(X,"$$",1)["D," S RX("D")=$P(X,"$$",2) D READT
 I (X["$$"),$P(X,"$$",1)["S," S RX("S")=$P(X,"$$",2) D READT
RXR1 U PSOAP D ^PSOARCR2 D PAGE U PSOAT G RXR2
DPR U PSOAP W !!,NM,?55,"ID#: ",$P(T(1),"^",2),?75,"ELIG: ",$P(T(1),"^",3),!,$P(T(1),"^",4),?55,"DOB: ",$P(T(1),"^",5),?75,"PHONE: ",$P(T(1),"^",6)
 W !,$P(T(1),"^",7),!,$P(T(1),"^",8),"   ",$P(T(1),"^",9)
 I +$P(T(1),"^",10) W !,"CANNOT USE SAFETY CAPS." I +$P(T(1),"^",11) W ?40,"DIALYSIS PATIENT"
 I $P(T(2),"^")'="" W !,$P(T(2),"^")
 W !,"DISABILITIES: " G MA:D'>0
 F I=1:1:D W:($Y+$L(T(2,I))+1)>PSOACPM !?15 W T(2,I),","
MA W !!,"REACTIONS: ",$S(((A'>0)&(DG'>0)&(GD'>0)):"UNKNOWN",1:"")
 I A>0 F I=1:1:A W:($Y+$L(T(3,I))+1)>PSOACPM !?15 W T(3,I),","
 I DG>0 F I=1:1:DG W:($Y+$L(T(4,I))+1)>PSOACPM !?15 W T(4,I),","
 I GD>0 F I=1:1:GD W:($Y+$L(T(5,I))+1)>PSOACPM !?15 W T(5,I),","
 K T Q
PAGE Q:$Y'>(PSOACPL-22)
 D HD1^PSOARCSV Q 
PSOAT ;check for eot, return psoaeot=1 if found
 U PSOAT S PSOAEOT=0 X ^%ZOSF("EOT") I Y D EOT S PSOAEOT=1
 U PSOAT Q
EOT U IO(0) W !!?5,"** End of tape detected **",!?5,"After current tape rewinds, mount next tape" U PSOAT W @%MT("REW")
READ U IO(0) W !?5,"Type <CR> to continue" R XX:DTIME I '$T W $C(7) G READ
 W !!,"continuing" S PSOATNM=PSOATNM+1
 Q
NODE1 S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 F  D READT Q:($P(X,"^")'["$")!($P(X,"$$",1)'["1,")  S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 Q
NODE4 S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 F  D READT Q:($P(X,"^")'["$")!($P(X,"$$",1)'["4,")  S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 Q
NODE5 S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 F  D READT Q:($P(X,"^")'["$")!($P(X,"$$",1)'["5,")  S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 Q
NODEA S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 F  D READT Q:($P(X,"^")'["$$")!($P(X,"$$",1)'["A,")  S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 Q
NODEL S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 F  D READT Q:($P(X,"^")'["$")!($P(X,"$$",1)'["L,")  S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 Q
NODEP S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 F  D READT Q:($P(X,"^")'["$$")!($P(X,"$$",1)'["P,")  S XX=$P(X,"$$",1) S RX(XX)=$P(X,"$$",2)
 Q
READT D PSOAT R X:DTIME G:'$T END G END:X="" Q
