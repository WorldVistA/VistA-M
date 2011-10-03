BPSOSQC ;BHAM ISC/FCS/DRS/FLS - ECME background, Part 1 ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,3,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;External reference private DBIA 4303
 Q
 ;
 ; Function to return division linked to the prescription or refill
 ; Input
 ;   RX - Prescription IEN
 ;   RXR - Refill
 ; Returns
 ;   BPSDIV - Outpatient Site
GETDIV(RX,RXR)   ; Get Division from RX or Refill
 N BPSDIV
 I '$G(RX) Q ""
 I $G(RXR)="" Q ""
 I RXR S BPSDIV=$$RXSUBF1^BPSUTIL1(RX,52,52.1,RXR,8,"I")
 E  S BPSDIV=$$RXAPI1^BPSUTIL1(RX,20,"I")
 Q BPSDIV
