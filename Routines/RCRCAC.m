RCRCAC ;ALB/CMS - RC TRANSACTION CODE LIST ; 02-SEP-1997
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ; -- main entry point for RCRC TRANSACTION CODE
 N VALMCNT
 ;D EN^VALM2($G(XQORNOD(0)))
 ;I $D(VALMY) S RCSELN=0 F  S RCSELN=$O(VALMY(RCSELN)) Q:'RCSELN  D
 D EN^VALM("RCRC ACTION CODE LIST")
ENQ Q
 ;
HDR ; -- header code
 S VALMHDR(1)=" "
 S VALMHDR(2)="Select RC Transaction Code"
 S XQORM("B")="TT"
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("RCRCAC",$J)
 D TCD^RCRCACP
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("RCRCAC",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;RCRCAC
