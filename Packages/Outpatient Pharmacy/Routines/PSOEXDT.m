PSOEXDT ;BHAM ISC/SAB - set exp. date and determine rx status ; 10/24/92 13:24
 ;;7.0;OUTPATIENT PHARMACY;**23,73,222**;DEC 1997;Build 12
 ;
 ;External reference ^PS(55 supported by DBIA 2228
 ;External reference ^PSDRUG( supported by DBIA 221
 ; this program sets the expiration date of an rx.  the zeroeth node is
 ; held in rx0, and the second node is held in rx2.  the variable 'j' is
 ; the internal number in the prescription file (^psrx).
 ;
A S CS=0,RFLS=$P(RX0,"^",9),DYS=$P(RX0,"^",8),X1=$P(RX0,"^",13),X2=DYS*(RFLS+1)\1,PSODEA=$P(^PSDRUG($P(RX0,"^",6),0),"^",3)
 F DEA=1:1 Q:$E(PSODEA,DEA)=""  I $E(+PSODEA,DEA)>1,$E(+PSODEA,DEA)<6 S $P(CS,"^")=1 S:$E(+PSODEA,DEA)=2 $P(CS,"^",2)=1
 S X2=$S($G(CLOZPAT)=2&(RFLS):28,$G(CLOZPAT)=1&(RFLS):14,DYS=X2:X2,CS:184,1:366) I X1']"" S X1=DT,X2=-1
 D C^%DTC S EX=$P(X,".") I +$G(PSORXED("RX1")),+$G(PSORXED("RX1"))>EX S EX=+$G(PSORXED("RX1"))
 ;K ^PSRX("AG",$P(^PSRX(J,2),"^",6),J)
 S $P(^PSRX(J,2),"^",6)=EX,RX2=^(2)
 S Y=$S($D(^PSRX(J,2)):^(2),1:""),X="" F ZII=1:1:10 S X=X_$P(Y,"^",ZII)_"^"
 K EX,X1,X2,DYS,RFLS,CS,PSODEA,DEA Q
STAT ;
 ;this entry point is call from dd(55.03,2,0).  this field is a computed 
 ;field that helps determine the status of rxs found in the pharmacy
 ;patient file.  the status will be returned in the variable st.
 Q:'$D(^PSRX(J,0))!('$P($G(^PSRX(J,0)),"^",2))
 S PSOJ=J,DFN=+$P($G(^PSRX(J,0)),"^",2)
 D:$P($G(^PS(55,DFN,0)),"^",6)'=2 EN^PSOHLUP(DFN) S J=PSOJ
B S ST0=+^PSRX(J,"STA") I ST0<12,$D(^PS(52.5,"B",J)) S ZII=$O(^(J,0)) I 'ZII,$D(^PS(52.5,ZII,0)),'$G(^("P")) S ST0=5
 D A:'$P(RX2,"^",6) I DT>$P(RX2,"^",6),((ST0<12)!(ST0>13)) S ST0=11
 S ST=$P("ERROR^ACTIVE^NON-VERIFIED^REFILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^^EXPIRED^DISCONTINUED^DELETED^DISCONTINUED^DISCONTINUE (EDIT)^PROVIDER HOLD^","^",ST0+2)
 S RX0=$P(RX0_"^^^^^^^","^",1,14)_"^"_ST0_"^"_$P(RX0,"^",16,99)
 K PSOJ,DFN Q
