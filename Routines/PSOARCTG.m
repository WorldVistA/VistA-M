PSOARCTG ;BHAM ISC/LGH - gather tape info ; 07/07/92
 ;;7.0;OUTPATIENT PHARMACY;**10**;DEC 1997
AC S DFN=DA,TA=$S($D(PSOAT):1,1:0) K T D ADD^VADPT,DEM^VADPT,ELIG^VADPT
 S I=$P($G(VADM(3)),"^")
 S T(1)=$G(VADM(1))_"^"_$P($G(VADM(2)),"^")_"^"_$P($G(VAEL(1)),"^",2)
 S T(1)=T(1)_"^"_$G(VAPA(1))_"^"_$S(I:$E(I,4,5)_"-"_$E(I,6,7)_"-"_(1700+$E(I,1,3)),1:"UNKNOWN")_"^"_$S($G(VAPA(8)):VAPA(8),1:"")
 S T(1)=T(1)_"^"_$G(VAPA(4))_"^"_$P($G(VAPA(5)),"^",2)_"^"_$G(VAPA(6))_"^"
 I $D(^PS(55,DFN,0)),+$P(^(0),"^",2) S T(1)=T(1)_1_"^" S:+$P(^(0),"^",4) T(1)=T(1)_1
 S T(2)="" I $D(^PS(55,DFN,1)),^(1)]"" S T(2)=T(2)_^(1)
 S T(2)=T(2)_"^^^^",PSLC=0 G MA:'$D(^DPT(DFN,.17)) G MA:$P(^(.17),"^",2)'="I" S TZ=1 G MA:'$D(^DPT(DFN,.372))
 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:+I'>0  S I1=$S($D(^(I,0)):^(0),1:""),PSDIS=$S($D(^DIC(31,+I1,0)):^(0),1:""),PSPRCNT=$P(I1,"^",2),T(2,TZ)=PSDIS_"^"_PSPRCNT,TZ=TZ+1
 S T(2)=$P(T(2),"^")_"^"_(TZ-1)_"^"_$P(T(2),"^",3,99)
MA S GMRA="0^0^111" D ^GMRADPT
 G END:'$G(GMRAL) S TZ=1 F I1=0:0 S I1=$O(GMRAL(I1)) Q:'I1  S T(3,TZ)=$P($G(GMRAL(I1)),"^",2),TZ=TZ+1
 S T(2)=$P(T(2),"^",1,2)_"^"_(TZ-1)_"^"_$P(T(2),"^",4,99)
END D KVA^VADPT K GMRAL,TZ,SC
Q Q
CMOP ;Called by ACT+1^PSOARX  Prints CMOP Data for "Display Archived Rx's"
 F Z1=0:0 S Z1=$O(^PSRX(DA,4,Z1)) Q:(+$G(Z1)<1)  S ZZ1=^(Z1,0) D
 .I $Y'>(PSOACPL-20),(Z1=1) D C1
 .D:$Y>(PSOACPL-20) HD1,C1
 .S Y=$P($G(ZZ1),"^",5) I Y X ^DD("DD") S $P(ZZ1,"^",5)=$P(Y,"@") K Y
 .S ZST=+$P($G(ZZ1),"^",4) I $G(ZST)]"" S $P(ZZ1,"^",4)=$S(ZST=0:"TRANS",ZST=1:"DISP",ZST=2:"RETRANS",ZST=3:"NOT DISP",1:"UNKNOWN")
 .W !,Z1,?3,$P(ZZ1,"^")_"-"_$P(ZZ1,"^",2)
 .W ?22,$J($P(ZZ1,"^",3),3),?30,$P(ZZ1,"^",4)
 .S ZZ2=$G(^PSRX(DA,4,Z1,1)) I $G(ZZ2)]"" D
 ..S Y=$P(ZZ2,"^",2) I $G(Y)]"" X ^DD("DD") S $P(ZZ2,"^",2)=$P(Y,"@") K Y
 ..W ?40,$P(ZZ2,"^",2),?52,$E($P(ZZ2,"^",3),1,20),?74,$E($P(ZZ2,"^",4),1,20) K ZZ2
 .W ?96,$S($P(ZZ1,"^",8)]"":"NDC "_$P(ZZ1,"^",8),$P(ZZ1,"^",5)]"":"CAN DT/REASON "_$P(ZZ1,"^",5)_"  "_$E($G(^PSRX(DA,4,Z1,1)),1,20),1:"")
 K ZZ1,Z1,ZST,ZZ2
 F Z1=0:0 S Z1=$O(^PSRX(DA,5,Z1)) Q:'Z1  S ZZ1=^(Z1,0) D
 .I $Y'>(PSOACPL-20),(Z1=1) D C2
 .D:$Y>(PSOACPL-20) HD1,C2
 .S Y=$P($G(ZZ1),"^",2) I Y X ^DD("DD") S $P(ZZ1,"^",2)=Y
 .W !,Z1,?5,$P(ZZ1,"^"),?51,$J($P(ZZ1,"^",2),12),?71,$J($P(ZZ1,"^",3),3)
 K Z1,ZZ1,ZST
 Q
C1 W !!,"CMOP EVENT LOG"
 W !,"#",?5,"TRANS #",?20,"RX REF",?30,"STATUS",?40,"SHIP DATE",?52,"CARRIER",?76,"PACKAGE ID",?100,"REMARKS"
 W ! F I=1:1:120 W "="
 Q
C2 W !!,"CMOP LOT#/EXPIRATION DATE LOG"
 W !,"#",?15,"LOT #",?49,"EXPIRATION DATE",?70,"RX REF"
 W ! F I=1:1:80 W "="
 Q
HD1 W @PSOACPF,?(66-($L(PSOACDS)\2)),PSOACDS,?112,$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3),?122,"PAGE ",PSOAPG S PSOAPG=PSOAPG+1 W !
