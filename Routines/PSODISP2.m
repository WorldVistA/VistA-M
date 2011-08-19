PSODISP2 ;BHAM ISC/SAB - report of released scripts ; 03/29/93 16:49
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
 S (RXN,ND)=0,BDT=BEGDT-1 F  S BDT=$O(^PSRX("ADP",BDT)) Q:'BDT!(BDT>ENDDT)  F  S RXN=$O(^PSRX("ADP",BDT,RXN)) Q:'RXN  D
 .F  S ND=$O(^PSRX("ADP",BDT,RXN,ND)) Q:'ND!($G(^PSRX(RXN,0))']"")  S PAR=1,NODE=ND D  K LB,LBLP I $Y+4>IOSL D HD^PSODISP1
 ..I $P($G(^PSRX(RXN,"P",NODE,0)),"^",19),DUD Q
 ..I $P($G(^PSRX(RXN,"P",NODE,0)),"^",9)'=SITE Q
 ..I $P($G(^PSRX(RXN,"P",NODE,0)),"^",16)]"" Q
 ..S XY=$P(^PSRX(RXN,"STA"),"^") I (XY=3)!(XY=4)!(XY=13) Q
 ..I $P($G(^PSRX(RXN,"P",NODE,0)),"^",19) D   D CP1^PSODISP1
 ...W !,$P(^PSRX(RXN,0),"^"),?16,"Partial #"_NODE S Y=$P(^PSRX(RXN,"P",NODE,0),"^",19) X ^DD("DD") W ?29,$S(Y["@":$P(Y,"@"),1:Y),?50,"Yes"
 ..I '$P(^PSRX(RXN,"P",NODE,0),"^",19) D  Q:'$G(LBLP)  W !,$P(^PSRX(RXN,0),"^"),?16,"Partial #"_NODE,?50,"No" D CP1^PSODISP1 S UNREL=UNREL+1 K LBLP
 ...F LB=0:0 S LB=$O(^PSRX(RXN,"L",LB)) Q:'LB  I $P(^PSRX(RXN,"L",LB,0),"^",2)=(99-NODE) S LBLP=1
 Q
