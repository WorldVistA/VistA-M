IBCNRZP0 ;DAOU/DMK - Receive HL7 e-Pharmacy ZP0 Segment ;23-OCT-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description
 ;
 ; Receive HL7 e-Pharmacy ZP0 Segment
 ; 365.12 PAYER File Update
 ;
 ; Called by IBCNRHLT
 ;
 ; Entry point
 ;
1000 ; Control ZP0 Segment processing
 D INIT
 Q
 ;
INIT ; Initialize ZP0 Segment variables
 ; 365.12 PAYER File
 ;
 ; .01 = PAYER NAME
 S DATA(.01)=$G(IBSEG(5))
 ;
 ; Error?
 ; V110 = Payer Name Missing
 I $TR(DATA(.01)," ","")="" S ERROR="V110" Q
 ;
 ; .02 = VA NATIONAL ID
 S DATA(.02)=$G(IBSEG(4))
 ;
 ; Error?
 ; V105 = Payer ID Missing
 I $TR(DATA(.02)," ","")="" S ERROR="V105" Q
 ;
 ; .04 = DATE/TIME CREATED
 ; MAD = Add
 I IBCNACT="MAD",IEN=-1 S DATA(.04)=DATE("NOW")
 ;
 ; .05 = EDI ID NUMBER - PROF
 S DATA(.05)=$G(IBSEG(7))
 ;
 ; .06 = EDI ID NUMBER - INST
 S DATA(.06)=$G(IBSEG(6))
 Q
