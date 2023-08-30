MHVPRNA ;MHV/CFS - Prescription Renewal Check API; [02/08/2022 11:38am]
 ;;1.0;My HealtheVet;**74**;Aug 23 2005;Build 42
 ;;Per VA Directive 6402, this routine should not be modified
 ;
RENWCHK(PSODFN,PSORX) ;
 ; This API function checks if a prescription can be renewed or not.
 ; Input:  PSODFN (required) - Patient IEN Number
 ;         PSORX  (required) - Prescription Number
 ; Output: 0^Message - Cannot be renewed
 ;         1 - Can be renewed
 ;
 N DAT,PSDRGIEN,PSOCHKPR,PSODRG,PSODRUG0,PSOINDAT,PSOLC,PSONEWOI,PSOOCPRX,PSOOLPF
 N PSOOLPD,PSONOSIG,PSOREFIL,PSOSURX,RX0,ST,X1,X2
 I $G(PSODFN)="" Q "0^Patient DFN is required."
 I $G(PSORX)="" Q "0^Prescription ien is required."
 ;Check if the Provider can be assigned to a specific Prescription 
 S PSOCHKPR=$$CHKRXPRV^PSOUTIL(PSORX)
 I 'PSOCHKPR Q "0^"_$P(PSOCHKPR,"^",2)
 ;I '$D(^PSRX(PSORX,0)) Q "0^Prescription order not found."
 S RX0=^PSRX(PSORX,0),DAT=$$DT^XLFDT()
 I PSODFN'=$P(RX0,"^",2) Q "0^Prescription not ordered for patient."
 ;Check if drug is Clozapine. Cannot be renewed.
 S PSDRGIEN=$$GET1^DIQ(52,PSORX,6,"I") ; drug IEN
 I PSDRGIEN,$$GET1^DIQ(50,PSDRGIEN,17.5)="PSOCLO1" Q "0^Cannot renew a Clozapine order."
 ;Check of Titration RX.
 I $$TITRX^PSOUTL(PSORX)="t" Q "0^Cannot Renew a 'Titration Rx'."
 S PSOREFIL=$$LSTRFL^PSOBPSU1(PSORX) ;Get the latest refill
 I $$FIND^PSOREJUT(PSORX,PSOREFIL) Q "0^NOT ALLOWED! Rx has OPEN 3rd Party Payer Reject."
 ;Check for X-cept conjunction. X conjunction is no longer valid but is being screened out instead of removed for historical data.
 I $$CONJ^PSOUTL(PSORX) Q "0^Cannot be renewed - invalid Except conjunction."
 ;Check if orderable prescription has been inactivated.
 S PSODRG=+$P(^PSRX(PSORX,0),"^",6),ST=+^("STA")  ;PSODRG=IEN to drug file 52. ST=Status.
 S PSONEWOI=+$P($G(^PSDRUG(+$G(PSODRG),2)),"^")  ;Pharmacy orderable item.
 S PSOINDAT=$P($G(^PS(50.7,PSONEWOI,0)),"^",4)  ;Inactive date.
 I PSOINDAT,DAT>PSOINDAT Q "0^This Orderable Item has been Inactivated."
 I ST=5 S PSOSURX=$O(^PS(52.5,"B",PSORX,0)) I PSOSURX,$P($G(^PS(52.5,PSOSURX,0)),"^",7)="L" Q "0^Rx loading into a CMOP Transmission."
 S X1=DAT,X2=-120 D C^%DTC I $P($G(^PSRX(PSORX,2)),"^",6)<X Q "0^Prescription Expired more than 120 Days."
 S X1=DAT,X2=-120 D C^%DTC I $P($G(^PSRX(PSORX,3)),"^",5),$P($G(^(3)),"^",5)<X,ST=12 Q "0^Prescription Discontinued more than 120 Days."
 S PSOOCPRX=PSORX D CDOSE^PSORENW0 I $G(PSOOLPF) Q "0^Non-Renewable, invalid Dosage of "_$G(PSOOLPD)
 I PSONOSIG Q "0^Non-Renewable, missing signature."
 I $P($G(^PSDRUG(PSODRG,2)),"^",3)'["O" Q "0^Drug is No longer used by Outpatient Pharmacy."
 I $G(^PSDRUG(PSODRG,"I"))]"",DAT>$G(^("I")) Q "0^This Drug has been Inactivated."
 S PSODRUG0=^PSDRUG(PSODRG,0)
 I ($P(PSODRUG0,"^",3)[1)!($P(PSODRUG0,"^",3)[2)!($P(PSODRUG0,"^",3)["W") Q "0^Non-Renewable "_$S($P(PSODRUG0,"^",3)["A":"Narcotic Drug.",1:"Drug.")
 I $D(^PS(53,+$P(RX0,"^",3),0)),'$P(^(0),"^",5) Q "0^Non-Renewable Prescription."
 S PSOLC=$P(RX0,"^"),PSOLC=$E(PSOLC,$L(PSOLC)) I $A(PSOLC)'<90 Q "0^Max number of renewals (26) has been reached."
 I ST,ST'=2,ST'=5,ST'=6,ST'=11,ST'=12,ST'=14 Q "0^Prescription is in a Non-Renewable Status."
 I $P($G(^PSRX(PSORX,"OR1")),"^",4) Q "0^Duplicate Rx Renewal Request."
 I $O(^PS(52.41,"AQ",PSORX,0)) Q "0^Duplicate Rx Renewal Request."
 Q 1
