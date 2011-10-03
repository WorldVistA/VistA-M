IBCNEHLK ;DAOU/ALA - HL7 Acknowledgement Messages ;08-OCT-2002
 ;;2.0;INTEGRATED BILLING;**184,300**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
MFK ;  MFN Acknowledgement
 S HCT=1
 ;  Loop through the message and find each segment for processing
 F  S HCT=$O(^TMP($J,"IBCNEHLI",HCT)) Q:HCT=""  D
 . D SPAR^IBCNEHLU
 . S SEG=$G(IBSEG(1))
 . ;
 . I SEG="MSA" D
 .. S ACK=$G(IBSEG(2)),MSGID=$G(IBSEG(3))
 .. ;
 .. I ACK="AE" S VMFN(350.9,"1,",51.22)=0
 .. I ACK="AA" S VMFN(350.9,"1,",51.22)=1
 ;
 D FILE^DIE("I","VMFN")
 ;
 K IBSEG,SEG,HCT,ACK,EVENT,HL,IBPRTCL,IDUZ,MSGID,SEGMT,TAG,VMFN
 Q
