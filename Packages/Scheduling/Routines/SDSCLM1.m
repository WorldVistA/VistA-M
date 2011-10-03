SDSCLM1 ;ALB/JAM/RBS - ASCD Encounter Detail LISTMAN ; 3/7/07 11:38am
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 Q
EN ; -- main entry point for SDSC DETAIL
 D EN^VALM("SDSC DETAIL")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=" "
 Q
 ;
INIT ; -- init variables and list array
 S VALMCNT=+$G(SDLN)
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 ;
 K VALMHDR,VALMCNT
 K ^TMP("SDSCLST",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
