HLTPCK2 ;SF/RSD - Message Header Validation (TCP Link) ;09/13/2006
 ;;1.6;HEALTH LEVEL SEVEN;**19,59,120,133**;Oct 13, 1995;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified.
CHK(HDR,ARY,MSA) ;
 ;Validate Data in Header Segment (MSH, BHS or FHS) of an HL7 Message
 ; through TCP link.
 ;
 ;This entry point is a subroutine call with parameter passing that
 ;will return an array (ARY()) consisting of values extracted from
 ;the message header segment subscripted by the mnemonics for each of
 ;the message header fields and components.
 ;The message header can be multiple line longer than 255 characters.
 ;HDR is an array that is passed by reference.
 ;If an error is encountered during validation, the array parameter
 ;(ARY) will be set equal to two pieces, error #^error text.
 ;
 ;Required input parameters
 ;  HDR = Message header array, HDR(1,0)=segment (passed by reference)
 ;
 ;  ARY = The array in which the message header values will be
 ;          returned (passed by reference)
 ;
 ;Optional input parameter
 ;  MSA = A variable which contains the message acknowledgement values:
 ;          acknowledgement code^message control ID^text message. Passed
 ;          by reference so that Batch msg. can set this here.
 ;
 ;Check for required parameters
 N ERR S ERR=""
 I $D(HDR)<10 S ERR="7^"_$G(^HL(771.7,7,0))_" at CHK^HLTPCK2" G EXIT
 N ECH,HLN,FS,X,X1,X2
 S ARY="",ARY("Q")=""""""
 ;
 ;Validate field separator and encoding characters
 S (ARY("FS"),FS)=$E(HDR(1,0),4)
 I FS']"" S ERR="Field Separator Missing" G EXIT
 I FS?.C S ERR="Invalid Field Separator" G EXIT
 S (ARY("ECH"),ECH)=$$P(.HDR,2)
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
 M ARY("HDR")=HDR
 ;
 ;Validate Message Header Type
 S (ARY("TYPE"),X)=$$P(.HDR,1)
 S ARY("HDR-1")=X
 I X=""!("FHS,BHS,MSH"'[X) S ERR="Invalid Message Header" G EXIT
 ;
 ;Extract data from message header segment
 ; S ARY("SAN")=$$P(.HDR,3),ARY("SFN")=$$P(.HDR,4),ARY("RAN")=$$P(.HDR,5),ARY("RFN")=$$P(.HDR,6),ARY("DTM")=$$P(.HDR,7)
 S ARY("SAN")=$$P(.HDR,3)
 S ARY("SFN")=$$P(.HDR,4)
 S ARY("RAN")=$$P(.HDR,5)
 S ARY("RFN")=$$P(.HDR,6)
 S ARY("DTM")=$$P(.HDR,7)
 ;
 I X="BHS"!(X="FHS") D
 . ; S ARY("MID")=$$P(.HDR,11),X=$$P(.HDR,9),ARY("PID")=$P(X,$E(ECH),2)
 . ;
 . S ARY("MID")=$$P(.HDR,11)
 . ;
 . ; BHS-9, Batch name/ID/Type:
 . ; 2nd component: Processing ID <sub> Processing Mode
 . ; 3rd component: Message Type <sub> Event Type
 . ; 4th component: Version ID
 . ; 5th component: Accept Acknowledgment Type
 . ; 6th component: Application Acknowledgment Type
 . S X=$$P(.HDR,9)
 . S:X]"" ARY("HDR-9")=X
 . ; original implementation incorrectly treats repetition separator as
 . ; subcomponent separator
 . S ECH("SUB-COMPONENT")=ECH(2)
 . ; if subcomponent separator is correctly applied
 . ; patch HL*1.6*133
 . ; I X[ECH(4) S ECH("SUB-COMPONENT")=ECH(4)
 . I ECH(4)]"",X[ECH(4) S ECH("SUB-COMPONENT")=ECH(4)
 . ;
 . S ARY("PID")=$P(X,ECH(1),2)
 . ; patch HL*1.6*133
 . ; I ARY("PID")[ECH("SUB-COMPONENT") D
 . I ECH("SUB-COMPONENT")]"",ARY("PID")[ECH("SUB-COMPONENT") D
 .. ; 2nd sub-component is Processing mode
 .. S ARY("PMOD")=$P(ARY("PID"),ECH("SUB-COMPONENT"),2)
 .. ; first sub-component is Processing id
 .. S ARY("PID")=$P(ARY("PID"),ECH("SUB-COMPONENT"))
 . ;
 . ; S ARY("MTN")=$P($P(X,$E(ECH),3),$E(ECH,2)),ARY("ETN")=$P($P(X,$E(ECH),3),$E(ECH,2),2)
 . ;
 . S ARY("MTN")=$P(X,ECH(1),3)
 . ; 2nd sub-component is event type
 . ;
 . ; patch HL*1.6*133 start
 . S ARY("ETN")=""
 . ; S ARY("ETN")=$P(ARY("MTN"),ECH("SUB-COMPONENT"),2)
 . I ECH("SUB-COMPONENT")]"" D
 .. S ARY("ETN")=$P(ARY("MTN"),ECH("SUB-COMPONENT"),2)
 . ; 1st sub-component is message type
 . ; S ARY("MTN")=$P(ARY("MTN"),ECH("SUB-COMPONENT"))
 . I ECH("SUB-COMPONENT")]"" D
 .. S ARY("MTN")=$P(ARY("MTN"),ECH("SUB-COMPONENT"))
 . ; patch HL*1.6*133 end
 . ;
 . ; S ARY("VER")=$P(X,$E(ECH),4),ARY("ACAT")=$P(X,$E(ECH),5),ARY("APAT")=$P(X,$E(ECH),6)
 . S ARY("VER")=$P(X,ECH(1),4)
 . S:$P(X,ECH(1),5)]"" ARY("ACAT")=$P(X,ECH(1),5)
 . S:$P(X,ECH(1),6)]"" ARY("APAT")=$P(X,ECH(1),6)
 . ;
 . ; BHS-10, batch comment
 . ; first component: MSA-1, acknowledgment code
 . ; 2nd component: MSA-3, text message
 . ; S:$$P(.HDR,10)]"" MSA=$P($$P(.HDR,10),$E(ECH),1),$P(MSA,FS,2)=$$P(.HDR,12),$P(MSA,FS,3)=$P($$P(.HDR,10),$E(ECH),2)
 . ;
 . S X=$$P(.HDR,10)
 . I X]"" D
 .. S ARY("HDR-10")=X
 .. ; MSA-1, acknowledgment code: AA,AE,AR,CA,CE,or CR
 .. S MSA=$P(X,ECH(1),1)
 .. ; MSA-2 and BHS-12, reference batch control id
 .. S $P(MSA,FS,2)=$$P(.HDR,12)
 .. ; MSA-3, text message
 .. S $P(MSA,FS,3)=$P(X,ECH(1),2)
 . ;
 . ; Reference Batch Control ID
 . S:$$P(.HDR,12)]"" ARY("HDR-12")=$$P(.HDR,12)
 ;
 ; I $$P(.HDR,1)="MSH" D
 I ARY("HDR-1")="MSH" D
 . ; S ARY("MID")=$$P(.HDR,10),ARY("PID")=$$P(.HDR,11),ARY("MTN")=$P($$P(.HDR,9),$E(ECH)),ARY("ETN")=$P($$P(.HDR,9),$E(ECH),2),ARY("VER")=$$P(.HDR,12)
 . S ARY("MID")=$$P(.HDR,10)
 . S ARY("PID")=$$P(.HDR,11)
 . S X=$$P(.HDR,9)
 . S ARY("MTN")=$P(X,ECH(1))
 . S ARY("ETN")=$P(X,ECH(1),2)
 . ;
 . ; S:$P($$P(.HDR,9),$E(ECH),3)'="" ARY("MTN_ETN")=$P($$P(.HDR,9),$E(ECH),3)
 . S:$P(X,ECH(1),3)]"" ARY("MTN_ETN")=$P(X,ECH(1),3)
 . ;
 . I ARY("PID")[ECH(1) D
 .. ; 2nd component is Processing mode
 .. S ARY("PMOD")=$P(ARY("PID"),ECH(1),2)
 .. ; first component is Processing id
 .. S ARY("PID")=$P(ARY("PID"),ECH(1))
 . ;
 . S ARY("VER")=$$P(.HDR,12)
 . ;
 . ; fields 13 and 14
 . S:$$P(.HDR,13)]"" ARY("MSH-13")=$$P(.HDR,13)
 . S:$$P(.HDR,14)]"" ARY("MSH-14")=$$P(.HDR,14)
 . ;
 . ; S:$$P(.HDR,15)]"" ARY("ACAT")=$$P(.HDR,15) S:$$P(.HDR,16)]"" ARY("APAT")=$$P(.HDR,16) S:$$P(.HDR,17)]"" ARY("CC")=$$P(.HDR,17)
 . S:$$P(.HDR,15)]"" ARY("ACAT")=$$P(.HDR,15)
 . S:$$P(.HDR,16)]"" ARY("APAT")=$$P(.HDR,16)
 . S:$$P(.HDR,17)]"" ARY("CC")=$$P(.HDR,17)
 . ;
 . ; fields 18,19,20 and 21
 . S:$$P(.HDR,18)]"" ARY("MSH-18")=$$P(.HDR,18)
 . S:$$P(.HDR,19)]"" ARY("MSH-19")=$$P(.HDR,19)
 . S:$$P(.HDR,20)]"" ARY("MSH-20")=$$P(.HDR,20)
 . S:$$P(.HDR,21)]"" ARY("MSH-21")=$$P(.HDR,21)
 ;
 ;Invoke continuation routine to perform remaining validation checks
 D ^HLTPCK2A
EXIT ;
 ; patch HL*1.6*120
 ; the maximum length of field #773,22 (Error Message) is 200
 I ERR]"" D
 . S ERR=$E(ERR,1,200)
 . S ARY=$S('ERR:"13^"_ERR,1:ERR)
 ; patch HL*1.6*120 end
 Q
 ;
P(MSH,P) ;get piece P from MSH array (passed by ref.)
 N FS,I,L,L1,L2,X,Y
 S FS=$E(MSH(1,0),4),(L2,Y)=0,X=""
 F I=1:1 S L1=$L($G(MSH(I,0)),FS),L=L1+Y-1 D  Q:$L(X)!'$D(MSH(I,0))
 . S:L1=1 L=L+1
 . S:P'>L X=$P($G(MSH(I-1,0)),FS,P-L2)_$P($G(MSH(I,0)),FS,(P-Y))
 . S L2=Y,Y=L
 Q X
 ;
