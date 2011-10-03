GMRCPX ;SLC/DCM - Select a new pharmacy patient for list manager consult tracking display ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
EN ; -- main entry point for GMRC PHARMACY SELECT PATIENT
 K GMRCQUT
 D ^GMRCSSP I $D(GMRCQUT) Q
 D AD^GMRCSLM1
 D INIT,HDR
 Q
 ;
HDR ; -- header code
 D HDR^GMRCSLM
 Q
 ;
INIT ; -- init variables and list array
 D INIT^GMRCPZ
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K GMRCWRD,GMRCWT,GMRCA,GMRCSNM,GMRCSSS,GMRCTX,GMRCQUIT,GMRCSTCK
 Q
 ;
EXPND ; -- expand code
 Q
 ;
