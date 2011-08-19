IBCEXTR ;ALB/JEH - CLAIMS READY FOR EXTRACT MANAGEMENT SCREEN ;12/10/99
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-1994
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry point for Claims Ready for Extract Management
 D EN^VALM("IBCE EXTR STATUS MANAGEMENT")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Claims in need of rescue process"
 Q
 ;
INIT ; -- init variables and list array
 N DIR,DIROUT,DTOUT,DUOUT,DIRUT
 S IBPARAM=$P($G(^IBE(350.9,1,8)),U,10) ;Get EDI Site Param Setting
 I IBPARAM>0 D
 .W !!,"Your site parameters are set to allow EDI transmissions."
 .W !,"This function is not necessary."
 .S VALMQUIT=1 D PAUSE^VALM1
 I $G(VALMQUIT) G INITQ
 D BLD^IBCEXTR1
INITQ Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCERP6",$J),^TMP("IBCERP61",$J),IBPARAM
 D CLEAN^VALM10
 Q
 ;
EXPND ; -- expand code
 Q
 ;
