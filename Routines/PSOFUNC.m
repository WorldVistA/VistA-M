PSOFUNC ;BHAM ISC/DRI - functions moved from the psf global ;10/26/92 11:49
 ;;7.0;OUTPATIENT PHARMACY;**146,223,249,251**;DEC 1997;Build 202
STAT ;gets status of rx
 S ST0=+$P(RX0,"^",15) I ST0<12,$O(^PS(52.5,"B",J,0)),$D(^PS(52.5,+$O(^(0)),0)),'$G(^("P")) S ST0=5
 I ST0<12,$P(RX2,"^",6)<DT S ST0=11
 S ST=$P("Error^Active^Non-Verified^Refill^Hold^Non-Verified^Suspended^^^^^Done^Expired^Discontinued^Deleted^Discontinued By Provider^Discontinued (Edit)^Provider Hold^","^",ST0+2),$P(RX0,"^",15)=ST0
 Q
CUTDATE ;calculates exp/cancel cutoff date in PSODTCUT
 S X1=DT,X2=-120 D C^%DTC S PSODTCUT=X,PSOPRPAS=$P($G(PSOPAR),"^",7) Q
 ;
FIXEXPDT ;calculate expiration date on rx's missing them
 F J=0:0 S J=$O(^PSRX(J)) Q:'J  I $D(^(J,0))#2 S RX0=^(0),RX2=$S($D(^(2))#2:^(2),1:"") D ^PSOEXDT:'$P(RX2,"^",6)
 Q
 ;
INP526 ;input transform for drug field (#6) in prescription file (#52)
 ;
 S PSODFN=+$P(^PSRX(DA,0),"^",2) F I=0:0 S I=$O(^PS(55,PSODFN,"P",I)) Q:'I  S RX=+^(I,0) I RX'=DA,$D(^PSRX(RX,0)),+$P(^(0),"^",6)=X,'$P(^("STA"),"^") S XS=X,X2=$P(^(0),"^",13),X1=$P(^PSRX(DA,0),"^",13) D ^%DTC D:X<180 INP5261 Q:'$D(X)  S X=XS
 Q
INP5261 D EN^DDIOL("Duplicate Drug in Rx #"_$P(^PSRX(RX,0),"^")_" . Discontinue? (Y/N): ","","$C(7),?10") R ZX:DTIME
 I ZX["^" D EN^DDIOL("NO UP ARROW ALLOWED","","!") S ZX="?"
 I ZX["?" D EN^DDIOL("Enter Y to discontinue this Prescription","","!") D EN^DDIOL(" ","","!") G INP5261
 S ZX=ZX?1"Y".E I ZX S $P(^PSRX(RX,"STA"),"^")=12,$P(^PSRX(RX,3),"^",5)=DT D CAN^PSOTPCAN(RX) D EN^DDIOL("     Discontinued") Q
 K X,XS,ZS Q
