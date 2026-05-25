PSOERBT2 ;ALB/RM - PSO ERX UTILITIES ;Jan 16, 2025@12:43:34
 ;;7.0;OUTPATIENT PHARMACY;**770**;DEC 16, 1997;Build 145
 ;
 ;
 Q  ;No Direct Call
 ;
LSTCHREQ(ERXIEN) ;Get last change erx change request date
 ;Input: ERXIEN   - Pointer to the ERX HOLDING QUEUE file (#52.49)
 ;Output: Last Change Request Submission Date (YYYMMDD) or ""
 N LSTCHREQ,CHERXIEN
 I '$G(ERXIEN) Q ""
 S (LSTCHREQ,CHERXIEN)="" F  S CHERXIEN=$O(^PS(52.49,ERXIEN,201,"B",CHERXIEN),-1) Q:'CHERXIEN!LSTCHREQ  D
 . I $$GET1^DIQ(52.49,CHERXIEN,.08,"I")="CR" S LSTCHREQ=$$GET1^DIQ(52.49,CHERXIEN,.03,"I")\1,FOUND=1
 Q LSTCHREQ
 ;
ISCMOPD(RXIEN) ;
 ; Input: RXIEN - Pointer to the PRESCRIPTION file (#52)
 ;Return: CMOP Indicatior - ">" CMOP dispense | "T" CMOP Loading for Transmission/Retransmission 
 Q:$G(RXIEN)=""
 N PSOCMOP
 S PSOCMOP=""
 I $D(^PSDRUG("AQ",$P(^PSRX(RXIEN,0),"^",6))) S PSOCMOP=">" ;cmop indicator
 N X S X="PSXOPUTL" X ^%ZOSF("TEST") K X I $T D
 . N DA S DA=+RXIEN D ^PSXOPUTL K DA
 . I $G(PSXZ(PSXZ("L")))=0!($G(PSXZ(PSXZ("L")))=2) S PSOCMOP="T"
 . K PSXZ
 Q $G(PSOCMOP)
 ;
GETLSTFL(RXIEN) ;get the last fill date
 ;Input : RXIEN - Pointer to the PRESCRIPTION file (#52)
 ;Output: PSOLF - Last Fill Date
 N RFLZRO,PSOLRD,PSOLF,PSORFG S PSOLRD=$P($G(^PSRX(+RXIEN,2)),"^",13),PSOLF=+$G(^(3))
 F PSOX=0:0 S PSOX=$O(^PSRX(+RXIEN,1,PSOX)) Q:'PSOX  D
 . S RFLZRO=$G(^PSRX(+RXIEN,1,PSOX,0))
 . I +RFLZRO=PSOLF,$P(RFLZRO,"^",16) S PSOLF=PSOLF_"^R"
 . S:$P(RFLZRO,"^",18)'="" PSOLRD=$P(RFLZRO,"^",18) I $P(RFLZRO,"^",16) S PSOLRD=PSOLRD_"^R"
 K PSOX
 I '$O(^PSRX(+RXIEN,1,0)),$P(^PSRX(+RXIEN,2),"^",15) S PSOLF=PSOLF_"^R",PSOLRD=PSOLRD_"^R"
 S PSOLF=PSOLF_$S($P(PSOLF,"^",2)="R":"R ",1:"  ")
 S PSOLRD=PSOLRD_$S($P(PSOLRD,"^",2)="R":"R ",1:"  ")
 Q $S($G(PSORFG):PSOLRD,1:PSOLF)
 ;
