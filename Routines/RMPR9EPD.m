RMPR9EPD ;Hines IOFO/HNC - CPRS SUSPENSE DETAIL DISPLAY ;9/12/02  13:16
 ;;3.0;PROSTHETICS;**63,59**;Feb 09, 1996
EN(RESULTS,DA) ; -- main entry point for RMPR DETAILED DISPLAY
 K ^TMP("GMRCR",$J)
 S GMRCOER=2
 S RMPROER=$P(^RMPR(668,DA,0),U,15)
 I RMPROER="" G EXIT
 ;field 20 ien to file 123
 ;create tmp array TMP(GMRCR,$J,DT)
 K DA
 D DT^GMRCSLM2(RMPROER)
 S VALMCNT=$O(^TMP("GMRCR",$J,"DT",""),-1)
 S BA=0
 F  S BA=$O(^TMP("GMRCR",$J,"DT",BA)) Q:BA=""  D
 .S RESULTS(BA)=^TMP("GMRCR",$J,"DT",BA,0)
 G EXIT
 Q
 ;
ENP ;
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
 I '$D(RESULTS) S RESULTS(0)="Nothing to Display, Manual Suspense"
 K ^TMP("GMRCR",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
