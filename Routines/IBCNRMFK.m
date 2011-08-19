IBCNRMFK ;DAOU/DMK - Send HL7 e-Pharmacy MFK Message ;23-OCT-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description
 ;
 ; Send HL7 e-Pharmacy MFK Message
 ; (Application Acknowledgement)
 ;
 ; Required segments listed in order
 ; MSH (Message Header Segment)
 ; MSA (Message Acknowledgement Segment)
 ; MFI (Master File Identifier Segment)
 ; MFA (Master File Acknowledgement)
 ;
 ; Called by IBCNEHLI if all of the following are true:
 ; * File # (MFI Segment) = 365.12, 366.01, 366.02, or 366.03
 ; * Primary Key Value (MFE Segment) does not contain "IIV"
 ; * Segment ID (every segment) = MFE, ZCM, ZP0, ZPB, ZPL, ZPT, or ZRX
 ;
 ; Entry point
 ;
1000 ; Control MFK Message processing
 ;
 ; Possible future use
 ; Quit if no error to report
 ;I '$D(DATAMFK("ERROR")) Q
 ;
 N ERROR,MESSAGE
 K HLA("HLA")
 ;
 D MSA
 D MFI
 D MFA
 ;
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.ERROR)
 ;
 ; Error?
 I $D(ERROR) D ERROR
 ;
 K HLA("HLA")
 Q
 ;
ERROR ; Process error
 S MESSAGE(1)="Outgoing HL7 IIV Application Acknowledgment Message error"
 S MESSAGE(2)=ERROR
 D MESSAGE
 Q
 ;
MESSAGE ; Send message
 Q
 ;
MFA ; Create MFA Segment
 N SEGMENT
 ;
 ; Segment ID
 S $P(SEGMENT,HLFS,1)="MFA"
 ;
 ; MFE-1 Record-Level Event Code (from MFN Message)
 ; MAC = Activate
 ; MAD = Add
 ; MDC = Deactivate
 ; MDL = Delete
 ; MUP = Update
 S $P(SEGMENT,HLFS,2)=DATAMFK("MFE-1")
 ;
 ; Record-Level Error Return (relative to MFN Message)
 ; Piece 1 = ID
 ; S = Saved
 ; P = Previous (not saved)
 ; U = Undefined (not saved)
 ; and
 ; Piece 2 = Error Code (optional - if error)
 ; Format = "V"NNN where N = number (e.g. V128)
 I '$D(DATAMFK("ERROR")) S $P(SEGMENT,HLFS,5)="S"
 I $D(DATAMFK("ERROR")) S $P(SEGMENT,HLFS,5)=$S(DATAMFK("IEN")=-1:"U",1:"P")_$E(HLECH,1)_DATAMFK("ERROR")
 ;
 ; MFE-4 Primary Key Value (from MFN Message)
 S $P(SEGMENT,HLFS,6)=DATAMFK("MFE-4")
 ;
 ; MFE-5 Primary Key Value Type (from MFN Message)
 S $P(SEGMENT,HLFS,7)=DATAMFK("MFE-5")
 ;
 S HLA("HLA",3)=SEGMENT
 Q
 ;
MFI ; Create MFI Segment
 N SEGMENT
 ;
 ; Segment ID
 S $P(SEGMENT,HLFS,1)="MFI"
 ;
 ; MFI-1 Master File Identifier (from MFN Message)
 S $P(SEGMENT,HLFS,2)=DATAMFK("MFI-1")
 ;
 ; MFI-3 File-Level Event Code (from MFN Message)
 S $P(SEGMENT,HLFS,4)=DATAMFK("MFI-3")
 ;
 ; Response-Level Code
 ; NE = Never (send response Application Acknowledgement Message)
 S $P(SEGMENT,HLFS,7)="NE"
 ;
 S HLA("HLA",2)=SEGMENT
 Q
 ;
MSA ; Create MSA Segment
 N SEGMENT
 ;
 ; Segment ID
 S $P(SEGMENT,HLFS,1)="MSA"
 ;
 ; Acknowledgment Code (relative to MFN Message)
 ; AA = application acknowledgement accept
 ; AR = application acknowledgement reject
 S $P(SEGMENT,HLFS,2)=$S($D(DATAMFK("ERROR")):"AR",1:"AA")
 ;
 ; MSH-10 Message Control ID (from MFN Message)
 S $P(SEGMENT,HLFS,3)=HL("MID")
 ;
 S HLA("HLA",1)=SEGMENT
 Q
