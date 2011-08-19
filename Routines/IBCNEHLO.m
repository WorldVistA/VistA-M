IBCNEHLO ;DAOU/ALA - Outgoing HL7 messages ;17-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,300**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program passes the HL7 protocol (variable IBCNHLP - defined by
 ;  the calling routine) to INIT^HLFNC2, which loads protocol specific
 ;  variables needed to generate an HL7 message into the HL array.
 ;  In addition, the protocol IEN is set using the extrinsic function,
 ;  $$HLP^IBCNEHLU.
 ;
 ;  Input Parameters
 ;    IBCNHLP = Protocol Name
 ;
 ;
INIT ;  Initialization for HL7
 D INIT^HLFNC2(IBCNHLP,.HL)
 S HLFS=HL("FS"),HLECH=$E(HL("ECH"),1),HL("SAF")=$P($$SITE^VASITE,U,2,3)
 ; S HLEID=$$HLP^IBCNEHLU(IBCNHLP)
 Q
 ;
