RMPREPDT ;HINES/HNC  SUSPENSE PROCESSING DETAIL DISPLAY ; 25-JAN-2000
 ;;3.0;PROSTHETICS;**45**;Feb 09, 1996
EN ; -- main entry point for RMPR DETAILED DISPLAY
 D ^%ZISC
 K ^TMP("GMRCR",$J)
 S GMRCOER=2
 S RMPROER=$P(^RMPR(668,DA,0),U,15)
 I RMPROER="" W !!!,"Nothing to Display, Manual Suspense." H 3 Q
 ;field 20 ien to file 123
 ;create tmp array TMP(GMRCR,$J,DT)
 K DA
 D DT^GMRCSLM2(RMPROER)
 S VALMCNT=$O(^TMP("GMRCR",$J,"DT",""),-1)
 ;
 D EN^VALM("RMPR DETAILED DISPLAY")
 Q
 ;
ENP ;main entry point for Print Consultation Sheet
 S RMPROER=$P(^RMPR(668,DA,0),U,15)
 I RMPROER="" W !!!,"Nothing to Display, Manual Suspense." H 3 Q
 D EN^GMRCP5(RMPROER)
 K RMPROER
 Q
HDR ; -- header code
 ;N VA,VADM
 ;S DFN=RMPRDFN
 ;D DEM^VADPT
 S VALMHDR(1)="Detailed Display"
 ;S VALMHDR(2)="Open/Pending/Closed Suspense for "_$$LOWER^VALM1(VADM(1))_"  ("_$P(VADM(2),U,2)_")"
 ;D KVAR^VADPT
 Q
 ;
INIT ; -- init variables and list array
 ;
 Q
 ;
 ;
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 ;NOT XUSCLEAN
 K ^TMP("GMRCR",$J)
 D FULL^VALM1
 S VALMBCK="R"
 Q
 ;
EXPND ; -- expand code
 Q
 ;
