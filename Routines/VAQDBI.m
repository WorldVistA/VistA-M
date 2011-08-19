VAQDBI ;ALB/JRP - EXTRACT DATA SEGMENTS ;22-MAR-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
EXTRACT(TRANPTR,ROOT) ;EXTRACT DATA SEGMENTS CONTAINED IN A PDX TRANSACTION
 ;INPUT  : TRANPTR - Pointer to VAQ - TRANSACTION FILE
 ;         ROOT - Where to store the information (full global reference)
 ;                Defaults to ^TMP("VAQ",$J)
 ;OUTPUT : 0 - Success
 ;        -1^Error_Text - Error
 ;NOTES  : Segments returning Extraction Arrays will be stored in
 ;          ROOT(Segment_Abbreviation,"VALUE",File,Field,Sequence_Number)
 ;          ROOT(Segment_Abbreviation,"ID",File,Field,Sequence_Number)
 ;         Segments returning Display Arrays will be stored in
 ;          ROOT(Segment_Abbreviation,"DISPLAY",Line_Number,0)
 ;       : Deletion of the output array before calling this routine
 ;         is the responsibility of the calling application.
 ;
 ;CHECK INPUT
 S TRANPTR=+$G(TRANPTR)
 Q:('TRANPTR) "-1^Pointer to VAQ - TRANSACTION file not passed"
 Q:('$D(^VAT(394.61,TRANPTR))) "-1^Transaction did not exist"
 S ROOT=$G(ROOT)
 S:(ROOT="") ROOT="^TMP(""VAQ"","_$J_")"
 ;DECLARE VARIABLES
 N SEGABB,ERROR,X,SEG,TMP,Y,TMPROOT,PATPTR
 ;CHECK RELEASE STATUS
 S TMP=+$P($G(^VAT(394.61,TRANPTR,0)),"^",5)
 Q:('TMP) "-1^Transaction has not been processed yet"
 S X=$P($G(^VAT(394.85,TMP,0)),"^",1)
 ;RELEASE STATUS DOES NOT REQUIRE EXTRACTION OF DATA
 Q:((X'="VAQ-RSLT")&(X'="VAQ-UNSOL")) 0
 Q:('$D(^VAT(394.61,TRANPTR,"SEG"))) "-1^Transaction did not contain any data segments"
 ;GET POINTER TO PATIENT FILE
 S PATPTR=+$P($G(^VAT(394.61,TRANPTR,0)),"^",3)
 Q:('PATPTR) "-1^Transaction did not contain pointer to PATIENT file"
 S ERROR=0
 S SEG=""
 ;LOOP THROUGH EACH DATA SEGMENT CONTAINED IN TRANSACTION
 F  D  Q:((ERROR)!('SEG))
 .S SEG=$O(^VAT(394.61,TRANPTR,"SEG","B",SEG))
 .Q:('SEG)
 .;GET SEGMENT ABBREVIATION
 .S SEGABB=$P($G(^VAT(394.71,SEG,0)),"^",2)
 .Q:(SEGABB="")
 .;MAKE SEGMENT ABBREVIATION NEXT SUBSCRIPT IN ROOT
 .S TMP=$P(ROOT,"(",1)
 .S X=$P(ROOT,"(",2)
 .S Y=$P(X,")",1)
 .S:(Y="") TMPROOT=TMP_"("_$C(34)_SEGABB_$C(34)_")"
 .S:(Y'="") TMPROOT=TMP_"("_Y_","_$C(34)_SEGABB_$C(34)_")"
 .S X=$$SEGXTRCT(TRANPTR,PATPTR,TMPROOT,SEG)
 Q 0
SEGXTRCT(TRAN,DFN,ROOT,SEGPTR,OFFSET) ;EXTRACT A DATA SEGMENT
 ;INPUT  : TRAN - Pointer to VAQ - TRANSACTION file
 ;         DFN - Pointer to PATIENT file (who to extract)
 ;         ROOT - Where to store the information (full global reference)
 ;         SEGPTR - Pointer to VAQ - DATA SEGMENT file (what to extract)
 ;         OFFSET - Where to begin inserting lines (defaults to 0)
 ;                  Only used for Display Arrays
 ;OUTPUT : 0 - Success (Extraction Array)
 ;         n - Success; number of lines in display (Display Array)
 ;        -1^Error_Text - Error
 ;       : If TRAN is passed
 ;           The patient pointer of the transaction will be used
 ;           Encryption will be based on the transaction
 ;           Time & Occurrence limits will be based on the transaction
 ;         If DFN is passed
 ;           Encryption will be based on the site parameter
 ;           Time & Occurrence limits will be based on the site parameter
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
 Q:($G(ROOT)="") "-1^Where to store information not passed"
 S SEGPTR=+$G(SEGPTR)
 Q:('SEGPTR) "-1^Pointer to VAQ - DATA SEGMENT file not passed"
 S OFFSET=+$G(OFFSET)
 ;DECLARE VARIABLES
 N X,Y,TIMLIM,OCCLIM,NODE,TMP
 ;SET TIME & OCCURRENCE LIMITS BASED ON PARAMETER FILE
 ;  DEFAULT TO 1 YEAR & 10 OCCURRENCES IF NOT THERE
 I ('TRAN) D
 .S TMP=+$O(^VAT(394.81,0))
 .I ('TMP) S TIMLIM="1Y",OCCLIM=10 Q
 .S NODE=$G(^VAT(394.81,TMP,"LIMITS"))
 .S TIMLIM=$P(NODE,"^",1)
 .S:(TIMLIM="") TIMLIM="1Y"
 .S OCCLIM=$P(NODE,"^",2)
 .S:('OCCLIM) OCCLIM=10
 ;SET TIME & OCCURRENCE LIMITS BASED ON TRANSACTION
 I (TRAN) D
 .S TIMLIM=""
 .S OCCLIM=""
 .S TMP=+$O(^VAT(394.61,TRAN,"SEG","B",SEGPTR,""))
 .I (TMP) D
 ..S NODE=$G(^VAT(394.61,TRAN,"SEG",TMP,0))
 ..S TIMLIM=$P(NODE,"^",2)
 ..S OCCLIM=$P(NODE,"^",3)
 ;GET EXTRACTION METHOD
 S Y=$G(^VAT(394.71,SEGPTR,"XRTN"))
 Q:(Y="") "-1^Could not determine extraction routine"
 ;EXTRACT INFORMATION
 X ("S X="_Y)
 Q X
