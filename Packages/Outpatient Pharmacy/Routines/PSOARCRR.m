PSOARCRR ;BHAM ISC/LGH - Rx retrieve ; 07/07/92
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 U PSOAT W @%MT("REW")
 S PSOAPF=0
R D PSOAT R X:DTIME G END:X="" G:X'="!" R
PAR D PSOAT R X:DTIME G:'$T END G:$P(X,"^")=NM&($G(SS)=$P(X,"^",2)) PR G PAR
END I $D(PSOAT) U IO(0) S IOP=PSOAT D ^%ZIS D ^%ZISC K IOP
Q I $D(PSOAP) U IO(0) S IOP=PSOAP D ^%ZIS D ^%ZISC K IOP
 K PSOACPM,PSOACPL,PSOACPF,NM,T,RX,PSOAP,PSOAT,^TMP($J,"ZRX"),RA,RR,FFX,I,GD,DG,D,A
 Q
PR ;patient read
 S T(1)=X D PSOAT G:PSOAEOT PAR R X:DTIME G:'$T END S T(2)=X,D=$P(T(2),"^",2),A=$P(T(2),"^",3),DG=$P(T(2),"^",4),GD=$P(T(2),"^",5)
 I D>0 F I=1:1:D D PSOAT G:PSOAEOT PAR R X:DTIME G:'$T END S T(2,I)=X
 I A>0 F I=1:1:A D PSOAT G:PSOAEOT PAR R X:DTIME G:'$T END S T(3,I)=X
 I DG>0 F I=1:1:DG D PSOAT G:PSOAEOT PAR R X:DTIME G:'$T END S T(4,I)=X
 I GD>0 F I=1:1:GD D PSOAT G:PSOAEOT PAR R X:DTIME G:'$T END S T(5,I)=X
 D:'PSOAPF DPR,HD1^PSOARCSV S PSOAPF=1 ;DISPLAY DEMO INFO
RXR D PSOAT R X:DTIME G:'$T END G END:X="" I X="!" D PSOAT R X:DTIME G:'$T END G:$P(X,"^")'=NM END G PR
 S T(6)=X D PSOAT G:PSOAEOT PR R X:DTIME G:'$T END S T(10)=X D PSOAT G:PSOAEOT PR R X:DTIME G:'$T END S T(7)=X S RR=$P(T(7),"^",14),RA=$P(T(7),"^",15)
 I RR>0 F I=1:1:RR D PSOAT G:PSOAEOT PR R X:DTIME G:'$T END S T(8,I)=X
 I RA>0 F I=1:1:RA D PSOAT G:PSOAEOT PR R X:DTIME G:'$T END S T(9,I)=X
 D RXP W:$Y>(PSOACPL-15) @PSOACPF G RXR
DPR U PSOAP W @PSOACPF,!!,NM,?55,"ID#: ",$P(T(1),"^",2),?75,"ELIG: ",$P(T(1),"^",3),!,$P(T(1),"^",4),?55,"DOB: ",$P(T(1),"^",5),?75,"PHONE: ",$P(T(1),"^",6)
 W !,$P(T(1),"^",7),!,$P(T(1),"^",8),"   ",$P(T(1),"^",9)
 I +$P(T(1),"^",10) W !,"CANNOT USE SAFETY CAPS." I +$P(T(1),"^",11) W ?40,"DIALYSIS PATIENT"
 I $P(T(2),"^")'="" W !,$P(T(2),"^")
 W !,"DISABILITIES: " G MA:D'>0
 F I=1:1:D W:($Y+$L(T(2,I))+1)>PSOACPM !?15 W T(2,I),","
MA W !!,"REACTIONS: ",$S(((A'>0)&(DG'>0)&(GD'>0)):"UNKNOWN",1:"")
 I A>0 F I=1:1:A W:($Y+$L(T(3,I))+1)>PSOACPM !?15 W T(3,I),","
 I DG>0 F I=1:1:DG W:($Y+$L(T(4,I))+1)>PSOACPM !?15 W T(4,I),","
 I GD>0 F I=1:1:GD W:($Y+$L(T(5,I))+1)>PSOACPM !?15 W T(5,I),","
 Q
RXP U PSOAP W !!,"RX: ",$P(T(6),"^"),?20,$P(T(6),"^",2),?65,"TRADE NAME: ",$P(T(6),"^",3),?96,"QTY: ",$P(T(6),"^",4),"     ",$P(T(6),"^",5)," DAY SUPPLY"
 W !?7,"SIG: ",T(10),!?4,"LATEST: ",$P(T(6),"^",7),?37,"# OF REFILLS: ",$P(T(6),"^",8),"  REMAINING: ",$P(T(6),"^",9),?70,"PROVIDER:",$P(T(6),"^",10)
 W !?4,"ISSUED: ",$P(T(6),"^",11),?43,"CLINIC: ",$P(T(7),"^"),?71,"DIVISION: ",$P(T(7),"^",2),!?4,"LOGGED: ",$P(T(7),"^",3),?42,"ROUTING: ",$P(T(7),"^",4),?69,"CLERK CODE: ",$P(T(7),"^",5)
 W !?3,"EXPIRES: ",$P(T(7),"^",6),?46,"CAP: ",$P(T(7),"^",7),?73,"STATUS: ",$P(T(7),"^",8),!,?4,"FILLED: ",$P(T(7),"^",9),?24,"PHARMACIST: ",$P(T(7),"^",10),?56,"LOT #: ",$P(T(7),"^",11),?74,"QTY: ",$P(T(7),"^",12)
 I $P(T(7),"^",13)]"" W !?3,"REMARKS: ",$P(T(7),"^",13)
 G:RR'>0 ACT D HEAD
 F I=1:1:RR W !,I,?3,$P(T(8,I),"^"),?14,$P(T(8,I),"^",2),?27,$P(T(8,I),"^",3),?32,$P(T(8,I),"^",4),?40,$P(T(8,I),"^",5),?52,$P(T(8,I),"^",6),?70,$P(T(8,I),"^",7) W:$P(T(8,I),"^",8)'="" !?5,"REMARKS: ",$P(T(8,I),"^",8)
 W !
ACT Q:RA'>0  D H1 F I=1:2:RA D ACT1
 K T(9) Q
ACT1 W !,I,?3,$P(T(9,I),"^"),?14,$P(T(9,I),"^",2),?25,$P(T(9,I),"^",3),?35,$P(T(9,I),"^",4) G:'$D(T(9,I+1)) REM
 W ?60,I+1,?63,$P(T(9,I+1),"^"),?74,$P(T(9,I+1),"^",2),?85,$P(T(9,I+1),"^",3),?95,$P(T(9,I+1),"^",4)
REM W ! I $P(T(9,I),"^",5)]"" W ?5,"COMMENT: ",$P(T(9,I),"^",5)
 I $D(T(9,I+1)) W:$P(T(9,I+1),"^",5)]"" ?65,"COMMENT: ",$P(T(9,I+1),"^",5)
 Q
PSOAT ;check for eot, return psoaeot=1 if found
 U PSOAT S PSOAEOT=0 X ^%ZOSF("EOT") I Y D EOT S PSOAEOT=1
 U PSOAT Q
EOT U IO(0) W !!?5,"** End of tape detected **",!?5,"After current tape rewinds, mount next tape" U PSOAT W @%MT("REW")
READ U IO(0) W !?5,"Type <CR> to continue" R XX:DTIME I '$T W $C(7) G READ
 W !!,"continuing" S PSOATNM=PSOATNM+1
 Q
HEAD D:$Y>(PSOACPL-20) HD1^PSOARCSV
 W !,"#",?3,"LOG DATE",?14,"REFILL DATE",?27,"QTY",?32,"ROUTING",?40,"LOT #",?52,"PHARMACIST",?70,"DIVISION",! F I=1:1:79 W "="
 S FFX=0 Q
H1 D:$Y>(PSOACPL-20) HD1^PSOARCSV
 W !!,"ACTIVITY LOG:",!,"#",?3,"DATE",?14,"REASON",?25,"RX REF",?35,"SECURITY",?60,"#",?63,"DATE",?74,"REASON",?85,"RX REF",?95,"SECURITY",! F I=1:1:55 W "="
 W ?60 F I=1:1:60 W "="
 Q
