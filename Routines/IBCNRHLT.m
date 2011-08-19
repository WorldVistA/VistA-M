IBCNRHLT ;DAOU/DMK - Receive HL7 e-Pharmacy MFN Message ;23-OCT-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description
 ;
 ; Receive HL7 e-Pharmacy MFN Message
 ; Table Update
 ;
 ; Control processing of segments
 ;
 ; Required segments listed in order
 ; MSH (Message Header Segment) (processed by IBCNEHLT)
 ; MFI (Master File Identifier Segment) (processed by IBCNEHLT)
 ; MFE (Master File Entry Segment)
 ;
 ; Optional segments listed by file
 ; ZP0 (365.12 PAYER File Update Segment)
 ;
 ; ZPT (366.01 NCPDP PROCESSOR File Update Segment)
 ; ZCM (366.012 NCPDP PROCESSOR CONTACT MEANS Subfile Update Segment)
 ;
 ; ZPB (366.02 PHARMACY BENEFITS MANAGER (PBM) File Update Segment)
 ; ZCM (366.022 PHARMACY BENEFITS MANAGER (PBM) CONTACT MEANS Subfile
 ;      Update Segment)
 ;
 ; ZPL (366.03 PLAN File Update Segment)
 ; ZCM (366.032 PLAN CONTACT MEANS Subfile Update Segment)
 ;
 ; ZRX (366.03 PLAN File (Pharmacy) Update Segment)
 ; ZCM (366.0312 PLAN RX CONTACT MEANS Subfile Update Segment)
 ;
 ; Called by IBCNEHLT if all of the following are true
 ; * File # (MFI Segment) = 365.12, 366.01, 366.02, or 366.03
 ; * Primary Key Value (MFE Segment) does not contain "IIV"
 ; * Segment ID (every segment) = MFE, ZCM, ZP0, ZPB, ZPL, ZPT, or ZRX
 ;
 ; Entry point
 ;
1000 ; Control processing
 I $D(ERROR) Q
 D @SEG
 ;
 ; Initialize MFK Message (Application Acknowledgement) variables
 I $D(ERROR) D  Q
 . S DATAMFK("ERROR")=ERROR
 . S DATAMFK("IEN")=IEN
 ;
 ; Quit if more segments
 I $O(^TMP($J,"IBCNEHLI",HCT))]"" Q
 ;
 ; Update File?
 I $D(DATA) D
 . S FIELDNO="" F  S FIELDNO=$O(DATA(FIELDNO)) Q:FIELDNO=""  D
 .. ;
 .. ; Convert "" to "@" to delete field value if necessary
 .. I IEN'=-1,DATA(FIELDNO)="" S DATA(FIELDNO)="@"
 .. ;
 .. ; Convert HL7 special characters if necessary
 .. I DATA(FIELDNO)[$E(HLECH,3) S DATA(FIELDNO)=$$TRAN1^IBCNRHLU(DATA(FIELDNO))
 . D FILE
 ;
 ; Update File?
 I $D(DATABPS) D
 . S FIELDNO="" F  S FIELDNO=$O(DATABPS(FIELDNO)) Q:FIELDNO=""  D
 .. ;
 .. ; Convert "" to "@" to delete field value if necessary
 .. I IEN'=-1,DATABPS(FIELDNO)="" S DATABPS(FIELDNO)="@"
 .. ;
 .. ; Convert HL7 special characters if necessary
 .. I DATABPS(FIELDNO)[$E(HLECH,3) S DATABPS(FIELDNO)=$$TRAN1^IBCNRHLU(DATABPS(FIELDNO))
 . ;
 . D FILEBPS
 ;
 ; Update APPLICATION Subfile?
 I $D(DATAAP) D
 . S FIELDNO="" F  S FIELDNO=$O(DATAAP(FIELDNO)) Q:FIELDNO=""  D
 .. ;
 .. ; Convert "" to "@" to delete field value if necessary
 .. I APIEN'=-1,DATAAP(FIELDNO)="" S DATAAP(FIELDNO)="@"
 .. ;
 .. ; Convert HL7 special characters if necessary
 .. I DATAAP(FIELDNO)[$E(HLECH,3) S DATAAP(FIELDNO)=$$TRAN1^IBCNRHLU(DATAAP(FIELDNO))
 . S FIELDNO=$S(FILENO=365.12:1,1:3)
 . D FILEAP
 ;
 ; Update CONTACT MEANS Subfile?
 I $D(DATACM) D
 . S FIELDNO="" F  S FIELDNO=$O(DATACM(FIELDNO)) Q:FIELDNO=""  D
 .. ;
 .. ; Convert "" to "@" to delete field value if necessary
 .. I CMIEN'=-1,DATACM(FIELDNO)="" S DATACM(FIELDNO)="@"
 .. ;
 .. ; Convert HL7 special characters if necessary
 .. I DATACM(FIELDNO)[$E(HLECH,3) S DATACM(FIELDNO)=$$TRAN1^IBCNRHLU(DATACM(FIELDNO))
 . S FIELDNO=$S(FILE["Pharmacy"&FILENO=366.03:12,1:2)
 . I IBCNACT="MDL" D DELETECM Q
 . D FILECM
 Q
 ;
ADD ; Add File entry
 ; 365.12 PAYER File
 ; 366.01 NCPDP PROCESSOR File
 ; 366.02 PHARMACY BENEFITS MANAGER (PBM) File
 ; 366.03 PLAN File
 ;
 S IEN=$$ADD1^IBCNRFM1(FILENO,DATA(.01))
 Q
 ;
ADDAP ; Add APPLICATION Subfile entry
 ; 365.121 PAYER APPLICATION Subfile
 ; 366.013 NCPDP PROCESSOR APPLICATION File
 ; 366.023 PHARMACY BENEFITS MANAGER (PBM) APPLICATION Subfile
 ; 366.033 PLAN APPLICATION Subfile
 ;
 S APIEN=$$ADD2^IBCNRFM1(FILENO,IEN,FIELDNO,AIEN)
 Q
 ;
ADDCM ; Add CONTACT MEANS Subfile entry
 ; 366.012  NCPDP PROCESSOR CONTACT MEANS Subfile
 ; 366.022  PHARMACY BENEFITS MANAGER (PBM) CONTACT MEANS Subfile
 ; 366.032  PLAN CONTACT MEANS Subfile
 ; 366.0312 PLAN RX CONTACT MEANS Subfile
 ;
 S CMIEN=$$ADD2^IBCNRFM1(FILENO,IEN,FIELDNO,DATACM(.01))
 Q
 ;
DELETECM ; Delete CONTACT MEANS Subfile entry
 ; 366.012  NCPDP PROCESSOR CONTACT MEANS Subfile
 ; 366.022  PHARMACY BENEFITS MANAGER (PBM) CONTACT MEANS Subfile
 ; 366.032  PLAN CONTACT MEANS Subfile
 ; 366.0312 PLAN RX CONTACT MEANS Subfile
 ;
 D DELETE2^IBCNRFM1(FILENO,IEN,FIELDNO,CMIEN)
 Q
 ;
FILE ; File data
 ; 365.12 PAYER File
 ; 366.01 NCPDP PROCESSOR File
 ; 366.02 PHARMACY BENEFITS MANAGER (PBM) File
 ; 366.03 PLAN File
 ;
 ; Add?
 I IEN=-1 D ADD
 ;
 ; Update
 D FILE1^IBCNRFM1(FILENO,IEN,.DATA)
 Q
 ;
FILEAP ; File APPLICATION Subfile data
 ; 365.121 PAYER APPLICATION Subfile
 ; 366.013 NCPDP PROCESSOR APPLICATION Subfile
 ; 366.023 PHARMACY BENEFITS MANAGER (PBM) APPLICATION Subfile
 ; 366.033 PLAN APPLICATION Subfile
 ;
 ; Add?
 I APIEN=-1 D ADDAP
 ;
 ; Update
 D FILE2^IBCNRFM1(FILENO,IEN,FIELDNO,APIEN,.DATAAP)
 Q
 ;
FILEBPS ; File data
 ; 90002312.92 BPS NCPDP FORMATS File
 ;
 N FILENO1
 S FILENO1=9002313.92
 ;
 ; Update Billing Payer Sheet Entry?
 S BPSIEN=DATA(10.07) I BPSIEN'="@" D
 . D FILE1^IBCNRFM1(FILENO1,BPSIEN,.DATABPS)
 ;
 ; Update Rebill Payer Sheet Entry?
 S BPSIEN=DATA(10.09) I BPSIEN'="@" D
 . D FILE1^IBCNRFM1(FILENO1,BPSIEN,.DATABPS)
 ;
 ; Update Reversal Payer Sheet Entry?
 S BPSIEN=DATA(10.08) I BPSIEN'="@" D
 . ;
 . ; 1.03 = Maximum RX's Per Claim
 . S DATABPS(1.03)=1
 . ;
 . ; 1.07 = Is A Reversal Format
 . S DATABPS(1.07)=1
 . ;
 . D FILE1^IBCNRFM1(FILENO1,BPSIEN,.DATABPS)
 Q
 ;
FILECM ; File CONTACT MEANS Subfile data
 ; 366.012  NCPDP PROCESSOR CONTACT MEANS Subfile
 ; 366.022  PHARMACY BENEFITS MANAGER (PBM) CONTACT MEANS Subfile
 ; 366.032  PLAN CONTACT MEANS Subfile
 ; 366.0312 PLAN RX CONTACT MEANS Subfile
 ;
 ; Add?
 I CMIEN=-1 D ADDCM
 ;
 ; Update
 D FILE2^IBCNRFM1(FILENO,IEN,FIELDNO,CMIEN,.DATACM)
 Q
 ;
MFE ; Process MFE Segment
 D ^IBCNRMFE
 Q
 ;
ZP0 ; Process ZP0 Segment
 D ^IBCNRZP0
 Q
 ;
ZCM ; Process ZCM Segment
 D ^IBCNRZCM
 Q
 ;
ZPB ; Process ZPB Segment
 D ^IBCNRZPB
 Q
 ;
ZPL ; Process ZPL Segment
 D ^IBCNRZPL
 Q
 ;
ZPT ; Process ZPT Segment
 D ^IBCNRZPT
 Q
 ;
ZRX ; Process ZRX Segment
 D ^IBCNRZRX
 Q
