LA7UTL02 ;HOIFO/BH - Cytopathology Query Utility ; 10/28/03 8:40am
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**69**;Sep 27, 1994
CYPATH(LRDFN,IEN,RET,ERR) ; Returns data for a Cytopathology Encounter
 ;
 ; Input:
 ;
 ; LRDFN - Patient Lab DFN                        (Required)
 ; IEN   - IEN of CY entry                        (Required)
 ; RET   - Array reference for passing back data  (Required)
 ; ERR   - Error array to pass back               (Not required)
 ;
 ; Output:
 ;
 ; '0' - If the API encountered an Error along with @ERR array
 ;
 ; '1' - if the API ran successfully and the following data if it exists
 ;
 ;   Visit Date field .01 and Accession Number field .06 of file 63.09.
 ;   @RET("DEMO",ien of visit)=Visit Date^Accession Number
 ;
 ;   Specimen field .01 of sub file 63.902.
 ;   @RET("SPEC",ien of Specimen entry)=Specimen Data
 ;
 ;   Clinical History field .01 of sub file 63.913.
 ;   @RET("CHIS",ien of the Clinical History entry)=Clinical His.
 ;
 ;   Pre Operative Diagnosis field .01 of sub file 63.914.
 ;   @RET@("PREDX",ien of the Pre. Op. Diagnosis entry)=Pre Op Diag.
 ;
 ;   Operative Diagnosis field .01 of sub file 63.905. 
 ;   @RET@("OPERDX",ien of the Op. Diagnosis entry)=Op Diag.
 ;
 ;   Post Opertive Diagnosis field .01 of sub file 63.906.
 ;   @RET@("POSTDX,ien of the Post. Op Diagnosis entry)=Pst. Op Diag.
 ;
 ;   Cytopathology Diagnosis field .01 of sub file 63.903. 
 ;   @RET@("CYTODX",ien of the Cytopathology Diagnosis entry)=Cyto Dx
 ;
 ;   Microscopic Examination field .01 of sub file 63.911.
 ;   @RET@("MICRO",ien of the Microscopic Examination entry)=Micro. Exam
 ;
 ;   ICD field .01 of sub file 63.901.
 ;   @RET@("ICD9",ien of Cyto ien entry)=ICD9 (external)
 ;
 ; ---------------------------------------------------------------------
 ;
 K @RET
 K @ERR
 I $G(LRDFN)="" D  Q 0
 . I $G(ERR)'="" S @ERR@("-1")="No Lab DFN." Q
 ;
 I $G(IEN)="" D  Q 0
 . I $G(ERR)'="" S @ERR@("-1")="No Cytopathology record IEN." Q
 ;
 I $G(RET)="" D  Q 0
 . I $G(ERR)'="" S @ERR@("-1")="No results array reference passed." Q
 ;
 N QUIT
 D DEMO
 I 'QUIT D SPECIMEN
 I 'QUIT D HISTORY
 I 'QUIT D PDIAG
 I 'QUIT D OPDIAG
 I 'QUIT D POSTDIAG
 I 'QUIT D CYTOPATH
 I 'QUIT D MICRO
 I 'QUIT D ICD
 I QUIT Q 0
 Q 1
 ;
 ;
DEMO ; Get basic demographics
 N VDATE S QUIT=0
 S VDATE=$$GET1^DIQ(63.09,IEN_","_LRDFN,.01,"I")
 I VDATE=""!($G(DIERR)) S QUIT=1 Q
 S ANUM=$$GET1^DIQ(63.09,IEN_","_LRDFN,.06,"I")
 I $G(DIERR) S QUIT=1 Q
 S @RET@("DEMO",IEN)=VDATE_"^"_ANUM
 Q
 ;
 ;
SPECIMEN ;
 N SPIENS,SPIEN,SPECIMEN S SPIEN="0"
 F  S SPIEN=$O(^LR(LRDFN,"CY",IEN,.1,SPIEN)) Q:'SPIEN!(QUIT)  D
 . Q:QUIT
 . S SPIENS=SPIEN_","_IEN_","_LRDFN_","
 . S SPECIMEN=$$GET1^DIQ(63.902,SPIENS,.01,"I")
 . I $G(DIERR) D  Q 
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Specimen data)."
 . . S QUIT=1
 . I SPECIMEN="" Q
 . S @RET@("SPEC",SPIEN)=SPECIMEN
 Q
 ;
 ;
HISTORY N CHIENS,CHIEN,HISTORY S CHIEN="0"
 F  S CHIEN=$O(^LR(LRDFN,"CY",IEN,.2,CHIEN)) Q:'CHIEN!(QUIT)  D
 . Q:QUIT
 . S CHIENS=CHIEN_","_IEN_","_LRDFN_","
 . S HISTORY=$$GET1^DIQ(63.913,CHIENS,.01,"I")
 . I $G(DIERR) D  Q 
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Clinical History data)."
 . . S QUIT=1
 . I HISTORY="" Q
 . S @RET@("CHIS",CHIEN)=HISTORY
 Q
 ;
PDIAG N PDIENS,PDIEN,PREOPDX S PDIEN="0"
 F  S PDIEN=$O(^LR(LRDFN,"CY",IEN,.3,PDIEN)) Q:'PDIEN!(QUIT)  D
 . Q:QUIT
 . S PDIENS=PDIEN_","_IEN_","_LRDFN_","
 . S PREOPDX=$$GET1^DIQ(63.914,PDIENS,.01,"I")
 . I $G(DIERR) D  Q 
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Pre Operative Diagnosis data)."
 . . S QUIT=1
 . I PREOPDX="" Q
 . S @RET@("PREDX",PDIEN)=PREOPDX
 Q
 ;
 ;
OPDIAG N ODIENS,ODIEN,OPERDX S ODIEN="0"
 F  S ODIEN=$O(^LR(LRDFN,"CY",IEN,.4,ODIEN)) Q:'ODIEN!(QUIT)  D
 . Q:QUIT
 . S ODIENS=ODIEN_","_IEN_","_LRDFN_","
 . S OPERDX=$$GET1^DIQ(63.905,ODIENS,.01,"I")
 . I $G(DIERR) D  Q 
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Operative Diagnosis data)."
 . . S QUIT=1
 . I OPERDX="" Q
 . S @RET@("OPERDX",ODIEN)=OPERDX
 Q
 ;
 ;
POSTDIAG ;
 N PSDIENS,PSDIEN,POSTDX S PSDIEN="0"
 F  S PSDIEN=$O(^LR(LRDFN,"CY",IEN,.5,PSDIEN)) Q:'PSDIEN!(QUIT)  D
 . Q:QUIT
 . S PSDIENS=PSDIEN_","_IEN_","_LRDFN_","
 . S POSTDX=$$GET1^DIQ(63.906,PSDIENS,.01,"I")
 . I $G(DIERR) D  Q
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Post Operative Diagnosis data)."
 . . S QUIT=1
 . I POSTDX="" Q
 . S @RET@("POSTDX",PSDIEN)=POSTDX
 Q
 ;
CYTOPATH ; - Cyto Pathology
 N CYIENS,CYIEN,CYTODX S CYIEN="0"
 F  S CYIEN=$O(^LR(LRDFN,"CY",IEN,1.4,CYIEN)) Q:'CYIEN!(QUIT)  D
 . Q:QUIT
 . S CYIENS=CYIEN_","_IEN_","_LRDFN_","
 . S CYTODX=$$GET1^DIQ(63.903,CYIENS,.01,"I")
 . I $G(DIERR) D  Q
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Cytopathology diagnosis data)."
 . . S QUIT=1
 . I CYTODX="" Q
 . S @RET@("CYTODX",CYIEN)=CYTODX
 Q
 ;
MICRO ; - Microscopic Exam
 N MICIENS,MICEXAM,MICIEN S MICIEN="0"
 F  S MICIEN=$O(^LR(LRDFN,"CY",IEN,1.1,MICIEN)) Q:'MICIEN!(QUIT)  D
 . Q:QUIT
 . S MICIENS=MICIEN_","_IEN_","_LRDFN_","
 . S MICEXAM=$$GET1^DIQ(63.911,MICIENS,.01,"I")
 . I $G(DIERR) D  Q
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Cytopathology Microscopic Examination)"
 . . S QUIT=1
 . I MICEXAM="" Q
 . S @RET@("MICRO",MICIEN)=MICEXAM
 Q
 ;
 ;
ICD ; - Get ICD Data
 N ICDIENS,ICDIEN,ICD9 S ICDIEN="0"
 F  S ICDIEN=$O(^LR(LRDFN,"CY",IEN,3,ICDIEN)) Q:'ICDIEN!(QUIT)  D
 . Q:QUIT
 . S ICDIENS=ICDIEN_","_IEN_","_LRDFN_","
 . S ICD9=$$GET1^DIQ(63.901,ICDIENS,.01,"E")
 . I $G(DIERR) D  Q
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (ICD9 data)."
 . . S QUIT=1
 . I ICD9="" Q
 . S @RET@("ICD9",ICDIEN)=ICD9
 Q
 ;
