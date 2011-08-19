VAQDBIP ;ALB/JRP - EXTRACTIONS DONE BY PDX;9-MAR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EXTRACT(TRAN,DFN,SEGMENT,ARRAY,OFFSET) ;EXTRACTIONS BY PDX
 ;INPUT  : TRAN - Pointer to VAQ - TRANSACTION file
 ;         DFN - Pointer to patient in PATIENT file
 ;         SEGMENT - Pointer to segment in VAQ - DATA SEGMENT file
 ;         ARRAY - Where to store information (full global reference)
 ;         OFFSET - Where to start adding lines (defaults to 0)
 ;                  Only used for Display Ready extract
 ;OUTPUT : n - Number of lines in display
 ;        -1^Error_Text - Error
 ;NOTES  : If TRAN is passed
 ;           The patient pointer of the transaction will be used
 ;           Encryption will be based on the transaction
 ;         If DFN is passed
 ;           Encryption will be based on the site parameter
 ;       : Pointer to transaction takes precedence over DFN ... if
 ;         TRAN>0 the DFN will be based on the transaction
 ;
 ;CHECK INPUT
 S TRAN=+$G(TRAN)
 S DFN=+$G(DFN)
 Q:(('TRAN)&('DFN)) "-1^Did not pass pointer to transaction or patient"
 I (TRAN) Q:('$D(^VAT(394.61,TRAN))) "-1^Did not pass valid pointer to VAQ - TRANSACTION file"
 I (TRAN) S DFN=+$P($G(^VAT(394.61,TRAN,0)),"^",3) Q:('DFN) "-1^Transaction did not contain pointer to PATIENT file"
 Q:('$D(^DPT(DFN))) "-1^Did not pass valid pointer to PATIENT file"
 Q:('$G(SEGMENT)) "-1^Did not pass pointer to VAQ - DATA SEGMENT FILE"
 Q:($G(ARRAY)="") "-1^Did not pass output array"
 S OFFSET=+$G(OFFSET)
 ;DECLARE VARIABLES
 N TMP,SEG
 ;GET SEGMENT ABBREVIATION
 S SEG=$P($G(^VAT(394.71,SEGMENT,0)),"^",2)
 Q:(SEG="") "-1^Segment pointer not valid"
 ;MEANS TEST SEGMENT
 Q:(SEG="PDX*MT") $$EXTRACT^VAQDBIM(TRAN,DFN,ARRAY,OFFSET)
 ;PDX MINIMUM PATIENT INFO SEGMENT
 Q:(SEG="PDX*MIN") $$MINXTRCT^VAQDBIP3(TRAN,DFN,ARRAY)
 ;PDX MEDICATION PROFILE (LONG) INFO SEGMENT
 Q:(SEG="PDX*MPL") $$RXXTRCT^VAQDBIP1(TRAN,DFN,ARRAY)
 ;PDX MEDICATION PROFILE (SHORT) INFO SEGMENT
 Q:(SEG="PDX*MPS") $$RXXTRCT^VAQDBIP1(TRAN,DFN,ARRAY)
 ;PDX MAS (REGISTRATION) INFO SEGMENT
 Q:(SEG="PDX*MAS") $$MASXTRCT^VAQDBIP4(TRAN,DFN,ARRAY)
 ;SEGMENT NOT EXTRACTED BY THIS ROUTINE
 Q "-1^Extraction of segment not supported"
 ;
GETSEQ(ARR,FLE,FLD) ;GET NEXT SEQUENCE NUMBER
 ;INPUT  : ARR - Where information is being stored (full global ref)
 ;         FLE - File [number] containing information
 ;         FLD - Field [number] where data is stored
 ;OUTPUT : Next sequence number in extraction array
 ;
 N SEQ
 F SEQ=0:1 Q:('$D(@ARR@("VALUE",FLE,FLD,SEQ)))
 Q SEQ
