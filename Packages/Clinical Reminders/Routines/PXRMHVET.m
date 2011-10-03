PXRMHVET ; SLC/AGP - Clinical Reminders entry points. ; 03/03/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
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
 N NAME,REMIEN,STATUS
 K ^TMP("PXRHM",$J),^TMP("PXRMHV",$J)
 S REMIEN=0
 F  S REMIEN=$O(^PXD(811.9,"P",REMIEN)) Q:+REMIEN'>0  D
 . I $P($G(^PXD(811.9,REMIEN,0)),U,6)'=1 D MAIN^PXRM(DFN,REMIEN,$G(HVDISP))
 S REMIEN=0 F  S REMIEN=$O(^TMP("PXRHM",$J,REMIEN)) Q:REMIEN'>0  D
 . S NAME="" F  S NAME=$O(^TMP("PXRHM",$J,REMIEN,NAME)) Q:NAME=""  D
 . . S STATUS=$P($G(^TMP("PXRHM",$J,REMIEN,NAME)),U)
 . . I STATUS=0 S STATUS="UNKNOWN"
 . . M ^TMP("PXRMHV",$J,STATUS,NAME,REMIEN)=^TMP("PXRHM",$J,REMIEN,NAME)
 K ^TMP("PXRHM",$J)
 Q
 ;
