PXRMHVET ; SLC/AGP - Clinical Reminders entry points. ; 03/03/2004
 ;;2.0;CLINICAL REMINDERS;**47**;Feb 04, 2005;Build 289
 ;Supports DBIA #4455.
 ;==========================================================
START(DFN,DISP) ;
 N NAME,REMIEN
 I $G(DISP)="" S DISP=0
 K ^TMP("PXRHM",$J)
 S REMIEN=0
 F  S REMIEN=$O(^PXD(811.9,"P",REMIEN)) Q:+REMIEN'>0  D
 . I $P($G(^PXD(811.9,REMIEN,0)),U,6)'=1 D MAIN^PXRM(DFN,REMIEN,DISP)
 Q
 ;
 ;==========================================================
HS(DFN,HVDISP) ;
 N NAME,NODE,REMIEN,STATUS
 K ^TMP("PXRHM",$J),^TMP("PXRMHV",$J)
 S REMIEN=0
 F  S REMIEN=$O(^PXD(811.9,"P",REMIEN)) Q:+REMIEN'>0  D
 .S NODE=$G(^PXD(811.9,REMIEN,0))
 . I $P(NODE,U,6)=1 Q
 . S NAME=$S($P(NODE,U,3)'="":$P(NODE,U,3),1:$P(NODE,U))
 . D MAIN^PXRM(DFN,REMIEN,$G(HVDISP))
 . S STATUS=$P($G(^TMP("PXRHM",$J,REMIEN,NAME)),U)
 . I STATUS=0!(STATUS=" ") S STATUS="UNKNOWN"
 . M ^TMP("PXRMHV",$J,STATUS,NAME,REMIEN)=^TMP("PXRHM",$J,REMIEN,NAME)
 K ^TMP("PXRHM",$J)
 Q
 ;
