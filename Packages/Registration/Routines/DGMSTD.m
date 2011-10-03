DGMSTD ; ALB/SCK - MST Status Display LM Interface ; 17-DEC-1998
 ;;5.3;Registration;**195,379**;Aug 13, 1993
 Q
 ;
EN ; -- main entry point for DGMST STATUS DISPLAY
 D EN^VALM("DGMST STATUS DISPLAY")
 Q
 ;
HDR ; -- header code
 N DFN,VA,VADM
 S DFN=$G(MSTDFN)
 D DEM^VADPT
 S VALMHDR(1)="MST Status Information for Patient: "_$$LOWER^VALM1(VADM(1))_"  ("_$P(VADM(2),U,2)_")"
 S VALMHDR(2)=" "
 D KVAR^VADPT
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("DGMST DISP",$J)
 N MSTIEN,MSTDT,DGX,VALMCNT,MST1,MSG,DGMST
 S VALMCNT=0
 ;
 ; Display message if no MST status history exists for patient
 I '$D(^DGMS(29.11,"C",MSTDFN)) D  Q
 . D SET("")
 . S MSG="No MST status history is available for this patient"
 . S DGX="",DGX=$$SETSTR^VALM1(MSG,DGX,5,70)
 . D SET(DGX),SET("")
 ;
 ; Retrieve MST status history for patient
 S MSTDT="",DGX=""
 F  S MSTDT=$O(^DGMS(29.11,"APDT",MSTDFN,MSTDT),-1) Q:'MSTDT  D
 . S MSTIEN="" F  S MSTIEN=$O(^DGMS(29.11,"APDT",MSTDFN,MSTDT,MSTIEN),-1) Q:'MSTIEN  D
 .. S DGMST=$G(^DGMS(29.11,MSTIEN,0))
 .. S DGX=$$SETFLD^VALM1($$FMTE^XLFDT($P(DGMST,U)),"","DATE")
 .. S DGX=$$SETFLD^VALM1($P(DGMST,U,3),DGX,"STATUS")
 .. S MST1=$$NAME^DGMSTAPI(+$P(DGMST,U,4))
 .. S DGX=$$SETFLD^VALM1($S(MST1]"":MST1,1:""),DGX,"PROVIDER")
 .. S MST1=$$NAME^DGMSTAPI(+$P(DGMST,U,5))
 .. S DGX=$$SETFLD^VALM1($S(MST1]"":MST1,1:""),DGX,"USER")
 .. S MST1=$$GET1^DIQ(4,(+$P(DGMST,U,6))_",",99)
 .. S DGX=$$SETFLD^VALM1($S(MST1]"":MST1,1:""),DGX,"SITE")
 .. D SET(DGX)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 ;S VALMBCK="R"
 K ^TMP("DGMST DISP",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SET(X) ;
 S VALMCNT=VALMCNT+1,^TMP("DGMST DISP",$J,VALMCNT,0)=X
 Q
