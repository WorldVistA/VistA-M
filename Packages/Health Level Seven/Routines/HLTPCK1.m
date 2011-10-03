HLTPCK1 ;AISC/SAW-Header Validation Routine (non-TCP link) ;09/13/2006
 ;;1.6;HEALTH LEVEL SEVEN;**8,36,59,120,133**;Oct 13, 1995;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified.
CHK(HDR,ARY,MSA) ;Validate Data in Header Segment (MSH, BHS or FHS) of
 ;an HL7 Message through non-TCP link
 ;
 ;This entry point is a subroutine call with parameter passing that
 ;will return an array (ARY()) consisting of values extracted from
 ;the message header segment subscripted by the mnemonics for each of
 ;the message header fields and components
 ;If an error is encountered during validation, the array parameter
 ;(ARY) will be set equal to two pieces, error #^error text
 ;
 ;Required input parameters:
 ;  HDR = Message header segment
 ;
 ;  ARY = The array in which the message header values will be
 ;          returned
 ;  Note:  The ARY parameter must be passed by reference
 ;
 ;Optional input parameter:
 ;  MSA = A variable which contains the message acknowledgement values:
 ;          acknowledgement code^message control ID^text message
 ;
 ;Check for required parameters
 N ERR S ERR=""
 I $G(HDR)']"" S ERR="7^"_$G(^HL(771.7,7,0))_" at CHK^HLTPCK1 entry point" G EXIT
 N ECH,HLN,FS,X,X1,X2
 S ARY="",ARY("Q")=""""""
 ;
 ;Validate field separator and encoding characters
 S (ARY("FS"),FS)=$E(HDR,4)
 I FS']"" S ERR="Field Separator Missing" G EXIT
 I FS?.C S ERR="Invalid Field Separator" G EXIT
 S (ARY("ECH"),ECH)=$P(HDR,FS,2)
 I ECH']"" S ERR="Encoding Characters Missing" G EXIT
 I ECH?.C S ERR="Invalid Encoding Characters" G EXIT
 ;
 ; patch HL*1.6*120 start
 ; patch HL*1.6*133
 ; escape and sub-component characters are optional
 ; I $L(ECH)'=4 S ERR="Invalid Encoding Characters" G EXIT
 I $L(ECH)<1 S ERR="Invalid Encoding Characters" G EXIT
 S ECH(1)=$E(ECH)
 S ECH(2)=$E(ECH,2)
 S ECH(3)=$E(ECH,3)
 S ECH(4)=$E(ECH,4)
 S ARY("HDR")=HDR
 S ARY("HDR-1")=$E(HDR,1,3)
 ;
 ;Validate Message Header Type
 ; I "FHS,BHS,MSH"'[$E(HDR,1,3) S ERR="Invalid Message Header Segment" G EXIT
 I "FHS,BHS,MSH"'[ARY("HDR-1") S ERR="Invalid Message Header" G EXIT
 ;
 ;Extract data from message header segment
 ; I $E(HDR,1,3)="BHS"!($E(HDR,1,3)="FHS") D
 I ARY("HDR-1")="BHS"!(ARY("HDR-1")="FHS") D
 . ;S ARY("DTM")=$P(HDR,FS,7),ARY("MID")=$P(HDR,FS,11),X=$P(HDR,FS,9),ARY("PID")=$P(X,$E(ECH),2),ARY("MTN")=$P($P(X,$E(ECH),3),$E(ECH,2)),ARY("ETN")=$P($P(X,$E(ECH),3),$E(ECH,2),2),ARY("VER")=$P(X,$E(ECH),4)
 . S ARY("DTM")=$P(HDR,FS,7)
 . S ARY("MID")=$P(HDR,FS,11)
 . S ARY("PID")=""
 . S ARY("MTN")=""
 . S ARY("ETN")=""
 . S ARY("VER")=""
 . ;
 . ; BHS-9, Batch name/ID/type:
 . ; 2nd component: Processing id <sub> Processing mode
 . ; 3rd component: message type <sub> event type
 . ; 4th component: version
 . S X=$P(HDR,FS,9)
 . I X]"" D
 .. S ARY("HDR-9")=X
 .. ; original implementation incorrectly treats repetition separator as
 .. ; subcomponent separator
 .. S ECH("SUB-COMPONENT")=ECH(2)
 .. ; if subcomponent separator is correctly applied
 .. ; patch HL*1.6*133
 .. ; I X[ECH(4) S ECH("SUB-COMPONENT")=ECH(4)
 .. I ECH(4)]"",X[ECH(4) S ECH("SUB-COMPONENT")=ECH(4)
 .. ;
 .. S ARY("PID")=$P(X,ECH(1),2)
 .. ; patch HL*1.6*133
 .. ; I ARY("PID")[ECH("SUB-COMPONENT") D
 .. I ECH("SUB-COMPONENT")]"",ARY("PID")[ECH("SUB-COMPONENT") D
 ... ; 2nd sub-component is Processing mode
 ... S ARY("PMOD")=$P(ARY("PID"),ECH("SUB-COMPONENT"),2)
 ... ; first sub-component is Processing id
 ... S ARY("PID")=$P(ARY("PID"),ECH("SUB-COMPONENT"))
 .. ;
 .. S ARY("MTN")=$P(X,ECH(1),3)
 .. ; 2nd sub-component is event type
 .. ;
 .. ; patch HL*1.6*133 start
 .. ; S ARY("ETN")=$P(ARY("MTN"),ECH("SUB-COMPONENT"),2)
 .. I ECH("SUB-COMPONENT")]"" D
 ... S ARY("ETN")=$P(ARY("MTN"),ECH("SUB-COMPONENT"),2)
 .. ; 1st sub-component is message type
 .. ; S ARY("MTN")=$P(ARY("MTN"),ECH("SUB-COMPONENT"))
 .. I ECH("SUB-COMPONENT")]"" D
 ... S ARY("MTN")=$P(ARY("MTN"),ECH("SUB-COMPONENT"))
 .. ; patch HL*1.6*133 end
 .. ;
 .. S ARY("VER")=$P(X,ECH(1),4)
 . ;
 . ; BHS-10, batch comment
 . ; S:$P(HDR,FS,10)]"" MSA=$P($P(HDR,FS,10),$E(ECH),1),$P(MSA,FS,2)=$P(HDR,FS,12),$P(MSA,FS,3)=$P($P(HDR,FS,10),$E(ECH),2)
 . ; first component: MSA-1, acknowledgment code
 . ; 2nd component: MSA-3, text message
 . ;
 . S X=$P(HDR,FS,10)
 . I X]"" D
 .. S ARY("HDR-10")=X
 .. ; MSA-1, acknowledgment code: AA,AE,AR,CA,CE,CR
 .. S MSA=$P(X,ECH(1),1)
 .. ; MSA-2 and BHS-12, reference batch control id
 .. S $P(MSA,FS,2)=$P(HDR,FS,12)
 .. ; MSA-3, text message
 .. S $P(MSA,FS,3)=$P(X,ECH(1),2)
 . ; Reference Batch Control ID
 . S:$P(HDR,FS,12)]"" ARY("HDR-12")=$P(HDR,FS,12)
 ;
 ; I $E(HDR,1,3)="MSH" D
 I ARY("HDR-1")="MSH" D
 . ;S ARY("DTM")=$P(HDR,FS,7),ARY("MID")=$P(HDR,FS,10),ARY("PID")=$P(HDR,FS,11),ARY("MTN")=$P($P(HDR,FS,9),$E(ECH)),ARY("ETN")=$P($P(HDR,FS,9),$E(ECH),2),ARY("VER")=$P(HDR,FS,12)
 . S ARY("DTM")=$P(HDR,FS,7)
 . S ARY("MID")=$P(HDR,FS,10)
 . S ARY("PID")=$P(HDR,FS,11)
 . S ARY("MTN")=$P($P(HDR,FS,9),ECH(1))
 . S ARY("ETN")=$P($P(HDR,FS,9),ECH(1),2)
 . S ARY("VER")=$P(HDR,FS,12)
 . ;
 . ; 2nd sub-component is Processing mode
 . I ARY("PID")[ECH(1) D
 .. S ARY("PMOD")=$P(ARY("PID"),ECH(1),2)
 .. ; first sub-component is Processing id
 .. S ARY("PID")=$P(ARY("PID"),ECH(1))
 . ;
 . ; S:$P($P(HDR,FS,9),$E(ECH),3)]"" ARY("MTN_ETN")=$P($P(HDR,FS,9),$E(ECH),3)
 .I $P($P(HDR,FS,9),ECH(1),3)]"" D
 .. S ARY("MTN_ETN")=$P($P(HDR,FS,9),ECH(1),3)
 . ;
 . ; fields 13 and 14
 . S:$P(HDR,FS,13)]"" ARY("MSH-13")=$P(HDR,FS,13)
 . S:$P(HDR,FS,14)]"" ARY("MSH-14")=$P(HDR,FS,14)
 . ;
 . ; S:$P(HDR,FS,15)]"" ARY("ACAT")=$P(HDR,FS,15) S:$P(HDR,FS,16)]"" ARY("APAT")=$P(HDR,FS,16) S:$P(HDR,FS,17)]"" ARY("CC")=$P(HDR,FS,17)
 . S:$P(HDR,FS,15)]"" ARY("ACAT")=$P(HDR,FS,15)
 . S:$P(HDR,FS,16)]"" ARY("APAT")=$P(HDR,FS,16)
 . S:$P(HDR,FS,17)]"" ARY("CC")=$P(HDR,FS,17)
 . ;
 . ; fields 18,19,20 and 21
 . S:$P(HDR,FS,18)]"" ARY("MSH-18")=$P(HDR,FS,18)
 . S:$P(HDR,FS,19)]"" ARY("MSH-19")=$P(HDR,FS,19)
 . S:$P(HDR,FS,20)]"" ARY("MSH-20")=$P(HDR,FS,20)
 . S:$P(HDR,FS,21)]"" ARY("MSH-21")=$P(HDR,FS,21)
 K:$G(MSA)']"" MSA
 ;
 S ARY("RAF")=$P(HDR,FS,6)  ; receiving facility
 S ARY("SAF")=$P(HDR,FS,4)  ; sending facility
 ;
 ;Invoke continuation routine to perform remaining validation checks
 D ^HLTPCK1A
 ;
EXIT ;
 ; the maximum length of field #772,22 (Error Message) is 200
 I ERR]"" D
 . S ERR=$E(ERR,1,200)
 . S ARY=$S('ERR:"13^"_ERR,1:ERR)
 ; patch HL*1.6*120 end
 Q
