IBCNRHLT ;DAOU/DMK - Receive HL7 e-Pharmacy MFN Message ;23-OCT-2003
 ;;2.0;INTEGRATED BILLING;**251,435,550**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Description
 ;
 ; Receive HL7 e-Pharmacy MFN Message
 ; Table Update
 ;
 ; Control processing of segments
 ;
 ; Required segments listed in order
 ; MSH (Message Header Segment)
 ; MFI (Master File Identifier Segment)
 ; MFE (Master File Entry Segment)
 ;
 ; Optional segments listed by file
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
 ; ZPP (366.03 PLAN File (Pharmacy) Update Segment)
 ; ZCM (366.0312 PLAN RX CONTACT MEANS Subfile Update Segment)
 ;
 ; * File # (MFI Segment) = 366.01, 366.02, or 366.03
 ; * Segment ID (every segment) = MFE, ZCM, ZPB, ZPL, ZPP, or ZPT
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
 I $O(^TMP($J,"BPSJHLI",HCT))]"" Q
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
 ; Update APPLICATION Subfile?
 I $D(DATAAP) D
 . S FIELDNO="" F  S FIELDNO=$O(DATAAP(FIELDNO)) Q:FIELDNO=""  D
 .. ;
 .. ; Convert "" to "@" to delete field value if necessary
 .. I APIEN'=-1,DATAAP(FIELDNO)="" S DATAAP(FIELDNO)="@"
 .. ;
 .. ; Convert HL7 special characters if necessary
 .. I DATAAP(FIELDNO)[$E(HLECH,3) S DATAAP(FIELDNO)=$$TRAN1^IBCNRHLU(DATAAP(FIELDNO))
 . S FIELDNO=3
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
 . S FIELDNO=$S(FILE["Pharmacy"&(FILENO=366.03):12,1:2)
 . I IBCNACT="MDL" D DELETECM Q
 . D FILECM
 Q
 ;
ADD ; Add File entry
 ; 366.01 NCPDP PROCESSOR File
 ; 366.02 PHARMACY BENEFITS MANAGER (PBM) File
 ; 366.03 PLAN File
 ;
 S IEN=$$ADD1^IBCNRFM1(FILENO,DATA(.01))
 Q
 ;
ADDAP ; Add APPLICATION Subfile entry
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
ZPP ; Process ZPP Segment
 D ^IBCNRZPP
 Q
 ;
ZPT ; Process ZPT Segment
 D ^IBCNRZPT
 Q
