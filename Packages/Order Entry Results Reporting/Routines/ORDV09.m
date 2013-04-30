ORDV09 ; slc/dcm - OE/RR Report Extracts ;3/15/03  08:12
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**191,298**;Dec 17,1997;Build 14
 ;
CONSLT(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Consult Report
 I $L($T(GCPR^OMGCOAS1)) D  Q  ; Call if FHIE station 200
 . D GCPR^OMGCOAS1(DFN,"CONS",ORDBEG,ORDEND,ORMAX)
 . S ROOT=$NA(^TMP("ORDATA",$J))
 Q  ;Possible extract when VA Consult report is finalized.
CONX ;
 ;By Patient Name, Date and or Occurrence
 Q  ;Possible extract when VA Consult is finalized
 ;
FRMS(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Forms Report
 I $L($T(GCPR^OMGCOAS1)) D  Q  ; Call if FHIE station 200
 . D GCPR^OMGCOAS1(DFN,"FRMS",ORDBEG,ORDEND,ORMAX)
 . S ROOT=$NA(^TMP("ORDATA",$J))
 Q  ;
FRMX ;
 ;By Patient Name, Date and or Occurrence
 Q  ;Possible extract when VA Forms is finalized
 ;
FAMHX(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Family History Report
 I $L($T(GCPR^OMGCOAS1)) D  Q  ; Call if FHIE station 200
 . D GCPR^OMGCOAS1(DFN,"HISF",ORDBEG,ORDEND,ORMAX)
 . S ROOT=$NA(^TMP("ORDATA",$J))
 Q  ;
FAMHXX ;
 ;By Patient Name, Date and or Occurrence
 Q  ;Possible extract when VA Family History is finalized
 ;
SOCHX(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Social History Report
 I $L($T(GCPR^OMGCOAS1)) D  Q  ; Call if FHIE station 200
 . D GCPR^OMGCOAS1(DFN,"HISS",ORDBEG,ORDEND,ORMAX)
 . S ROOT=$NA(^TMP("ORDATA",$J))
 Q  ;
SOCHXX ;
 ;By Patient Name, Date and or Occurrence
 Q  ;Possible extract when VA Social History is finalized
 ;
MEDHX(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Other Past Medical History Report
 I $L($T(GCPR^OMGCOAS1)) D  Q  ; Call if FHIE station 200
 . D GCPR^OMGCOAS1(DFN,"HISO",ORDBEG,ORDEND,ORMAX)
 . S ROOT=$NA(^TMP("ORDATA",$J))
 Q  ;
MEDHXX ;
 ;By Patient Name, Date and or Occurrence
 Q  ;Possible extract when VA Other Past Medical History is finalized
 ;
QUEST(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Questionnaires Report
 I $L($T(GCPR^OMGCOAS1)) D  Q  ; Call if FHIE station 200
 . D GCPR^OMGCOAS1(DFN,"HQUE",ORDBEG,ORDEND,ORMAX)
 . S ROOT=$NA(^TMP("ORDATA",$J))
 Q  ;
QUESTX ;
 ;By Patient Name, Date and or Occurrence
 Q  ;Possible extract when VA Questionnaires is finalized
 ;
