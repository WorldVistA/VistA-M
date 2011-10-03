LA7UTL03 ;HOIFO/BH - Surgical Pathology Query Utility ; 3/11/03 10:45am       
        ;;5.2;AUTOMATED LAB INSTRUMENTS;**69**;Sep 27, 1994
 ;
 ;
SPATH(LRDFN,IEN,RET,ERR) ; Returns data for a given SP Encounter
 ;
 ; Input:
 ;
 ; LRDFN - Patient Lab DFN                        (Required)
 ; IEN   - IEN of SP entry                        (Required)
 ; RET   - Array reference for passing back data  (Required)
 ; ERR   - Error array to pass back               (Not required)
 ;
 ; Output:
 ;
 ; '0' - If the API encountered an Error along with @ERR array
 ;
 ; '1' - if the API ran successfully and the following data if it exists
 ;   
 ;   Specimen field .01 of file 63.812.
 ;   @RET("SPEC",ien of Specimen entry)=Specimen Data
 ;   
 ;   Clinical History field .01 of sub file 63.813.
 ;   @RET("CHIS",ien of the Clinical History entry)=Clinical His.
 ;   
 ;   Pre Operative Diagnosis field .01 of sub file 63.814.
 ;   @RET@("PREDX",ien of the Pre. Op. Diagnosis entry)=Pre Op Diag.
 ;
 ;   Operative Diagnosis field .01 of sub file 63.815.
 ;   @RET@("OPERDX",ien of the Op. Diagnosis entry)=Op Diag.
 ;
 ;   Post Operative Diagnosis field .01 of sub file 63.816.
 ;   @RET@("POSTDX,ien of the Post. Op Diagnosis entry)=Pst. Op Diag.
 ;
 ;   Gross Description field .01 of sub file 63.81.
 ;   @RET@("GROSSD",ien of the Gross Description entry)=Gross Desc.
 ;
 ;   Microscopic Description field .01 of sub file 63.811.
 ;   @RET@("MICROD",ien of the Microspc. Description entry)=Micro Desc.
 ;
 ;   Surgical Pathology field .01 of sub file 63.802.
 ;   @RET@("SURGP",ien of the Surgical Path. entry)=Surgical Path.
 ;
 ;   ICD field .01 of sub file 63.88.
 ;   @RET@("ICD9",ien of the ICD9 entry)=ICD9
 ;
 K @RET
 K @ERR
 I $G(LRDFN)="" D  Q 0
 . I $G(ERR)'="" S @ERR@("-1")="No Lab DFN." Q
 ;
 I $G(IEN)="" D  Q 0
 . I $G(ERR)'="" S @ERR@("-1")="No Surgical Pathology record IEN." Q
 ;
 I $G(RET)="" D  Q 0
 . I $G(ERR)'="" S @ERR@("-1")="No results array reference passed." Q
 ;
 ;
 N QUIT
 D SPECIMEN
 I 'QUIT D HISTORY
 I 'QUIT D PDIAG
 I 'QUIT D OPDIAG
 I 'QUIT D POSTDIAG
 I 'QUIT D GROSSD
 I 'QUIT D MICROD
 I 'QUIT D SURGPATH
 I 'QUIT D ICD
 I QUIT Q 0
 Q 1
 ;
 ;
SPECIMEN ;
 N SPIENS,SPIEN,SPECIMEN S SPIEN="0",QUIT=0
 F  S SPIEN=$O(^LR(LRDFN,"SP",IEN,.1,SPIEN)) Q:'SPIEN!(QUIT)  D
 . Q:QUIT
 . S SPIENS=SPIEN_","_IEN_","_LRDFN_","
 . S SPECIMEN=$$GET1^DIQ(63.812,SPIENS,.01,"I")
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
 F  S CHIEN=$O(^LR(LRDFN,"SP",IEN,.2,CHIEN)) Q:'CHIEN!(QUIT)  D
 . Q:QUIT
 . S CHIENS=CHIEN_","_IEN_","_LRDFN_","
 . S HISTORY=$$GET1^DIQ(63.813,CHIENS,.01,"I")
 . I $G(DIERR) D  Q 
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Clinical History data)."
 . . S QUIT=1
 . I HISTORY="" Q
 . S @RET@("CHIS",CHIEN)=HISTORY
 Q
 ;
PDIAG N PDIENS,PDIEN,PREOPDX S PDIEN="0"
 F  S PDIEN=$O(^LR(LRDFN,"SP",IEN,.3,PDIEN)) Q:'PDIEN!(QUIT)  D
 . Q:QUIT
 . S PDIENS=PDIEN_","_IEN_","_LRDFN_","
 . S PREOPDX=$$GET1^DIQ(63.814,PDIENS,.01,"I")
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
 F  S ODIEN=$O(^LR(LRDFN,"SP",IEN,.4,ODIEN)) Q:'ODIEN!(QUIT)  D
 . Q:QUIT
 . S ODIENS=ODIEN_","_IEN_","_LRDFN_","
 . S OPERDX=$$GET1^DIQ(63.815,ODIENS,.01,"I")
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
 F  S PSDIEN=$O(^LR(LRDFN,"SP",IEN,.5,PSDIEN)) Q:'PSDIEN!(QUIT)  D
 . Q:QUIT
 . S PSDIENS=PSDIEN_","_IEN_","_LRDFN_","
 . S POSTDX=$$GET1^DIQ(63.816,PSDIENS,.01,"I")
 . I $G(DIERR) D  Q
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Post Operative Diagnosis data)."
 . . S QUIT=1
 . I POSTDX="" Q
 . S @RET@("POSTDX",PSDIEN)=POSTDX
 Q
 ;
 ;- Gross Description Data
GROSSD N GDIENS,GDIEN,GROSSD S GDIEN="0"
 F  S GDIEN=$O(^LR(LRDFN,"SP",IEN,1,GDIEN)) Q:'GDIEN!(QUIT)  D
 . Q:QUIT
 . S GDIENS=GDIEN_","_IEN_","_LRDFN_","
 . S GROSSD=$$GET1^DIQ(63.81,GDIENS,.01,"I")
 . I $G(DIERR) D  Q
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Gross Description data)."
 . . S QUIT=1
 . I GROSSD="" Q
 . S @RET@("GROSSD",GDIEN)=GROSSD
 Q
 ;
MICROD ; Microscopic Description
 N MDIENS,MDIEN,MICROD S MDIEN="0"
 F  S MDIEN=$O(^LR(LRDFN,"SP",IEN,1.1,MDIEN)) Q:'MDIEN!(QUIT)  D
 . Q:QUIT
 . S MDIENS=MDIEN_","_IEN_","_LRDFN_","
 . S MICROD=$$GET1^DIQ(63.811,MDIENS,.01,"I")
 . I $G(DIERR) D  Q
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Microscopic Description data)."
 . . S QUIT=1
 . I MICROD="" Q
 . S @RET@("MICROD",MDIEN)=MICROD
 Q
 ;
SURGPATH ; - Surgical Pathology
 N SGIENS,SGIEN,SURGP S SGIEN="0"
 F  S SGIEN=$O(^LR(LRDFN,"SP",IEN,1.4,SGIEN)) Q:'SGIEN!(QUIT)  D
 . Q:QUIT
 . S SGIENS=SGIEN_","_IEN_","_LRDFN_","
 . S SURGP=$$GET1^DIQ(63.802,SGIENS,.01,"I")
 . I $G(DIERR) D  Q
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (Surgical Pathology data)."
 . . S QUIT=1
 . I SURGP="" Q
 . S @RET@("SURGP",SGIEN)=SURGP
 Q
 ;
ICD ; - Get ICD Data
 N ICDIENS,ICDIEN,ICD9 S ICDIEN="0"
 F  S ICDIEN=$O(^LR(LRDFN,"SP",IEN,3,ICDIEN)) Q:'ICDIEN!(QUIT)  D
 . Q:QUIT
 . S ICDIENS=ICDIEN_","_IEN_","_LRDFN_","
 . S ICD9=$$GET1^DIQ(63.88,ICDIENS,.01,"E")
 . I $G(DIERR) D  Q
 . . K @RET
 . . I $G(ERR)'="" S @ERR@("-1")="Fileman Error within GET1 call (ICD9 data)."
 . . S QUIT=1
 . I ICD9="" Q
 . S @RET@("ICD9",ICDIEN)=ICD9
 Q
 ;
