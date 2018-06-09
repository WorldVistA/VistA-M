IBCNEHLK ;DAOU/ALA - HL7 Acknowledgement Messages ;08-OCT-2002
 ;;2.0;INTEGRATED BILLING;**184,300,601**;21-MAR-94;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
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
 ; IB*2.0*601 - Added new logic for ACK tag.
ACK ; ACK Acknowledgement
 N IBCNHLP,HCT,MSA,MFI,MFA,CONTROL,HLFS
 K ^TMP("HLA",$J)
 S HCT=0
 S HLFS="|"
 ;
 D MSA S HCT=HCT+1,^TMP("HLA",$J,HCT)=$TR(MSA,"*","")
 D MFI S HCT=HCT+1,^TMP("HLA",$J,HCT)=$TR(MFI,"*","")
 D MFA S HCT=HCT+1,^TMP("HLA",$J,HCT)=$TR(MFA,"*","")
 ;
 D GENACK^HLMA1($$FIND1^DIC(101,,,"IBCNE IIV MFN IN","B"),HLMTIENS,$$FIND1^DIC(101,,,"IBCNE IIV TABLE","B"),"GM",1,.ERROR)
 K ^TMP("HLA",$J),HL,ERROR
 ;
 Q
MSA ; MSA Segment
 N DATA,CONTROL
 S CONTROL=$P($G(^TMP($J,"IBCNEHLI",1,0)),"|",10) ; Table Update Message Control ID
 S MSA="MSA"_HLFS_$G(IBACK)_HLFS_CONTROL
 Q
 ;
MFI ; MFI Segment
 S MFI=$G(^TMP($J,"IBCNEHLI",2,0)) ; Return this segment.
 S $P(MFI,HLFS,7)="NE"
 Q
MFA ; MFA Segment
 N I,ECODE,DATA,IDMFA
 S ECODE="",IDMFA=""
 F I=1:1 Q:'$D(^TMP($J,"IBCNEHLI",I,0))  D  Q:ECODE'=""
 .S DATA=^TMP($J,"IBCNEHLI",I,0)
 .I $P(DATA,"|")="MFE" S ECODE=$P(DATA,"|",2),IDMFA=$P(DATA,"|",5)
 S MFA="MFA"_HLFS_ECODE_HLFS_HLFS_HLFS_$S(IBACK="AA":"S",1:"U")_HLFS_IDMFA_HLFS_"CE"
 Q
MLMN ;  MailMan Message
 D TXT^IBCNEUT7("MSG")
 S MGRP=$$MGRP^IBCNEUT5()
 S XMSUB="IBCNE IIV MFN IN"
 D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
 K XMSUB,XMY,MSG,XMZ,XMDUZ
 Q
