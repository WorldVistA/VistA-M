RCRCVC ;ALB/CMS - RC VIEW REFERRAL CHECK LIST ; 02-SEP-1997
V ;;4.5;Accounts Receivable;**63**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ; -- main entry point for RCRC VIEW CHECKLIST
 N RCEXP,X,Y K DIR
 S DIR("A")="Expanded View ",DIR("B")="Yes",DIR(0)="Y" D ^DIR
 S RCEXP=+Y
 I $D(DIROUT)!$D(DTOUT)!$D(DUOUT)!$D(DIRUT) S RCOUT=1 G ENQ
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 D EN^VALM("RCRC VIEW CHECKLIST")
ENQ Q
 ;
HDR ; -- header code
 S VALMHDR(1)=""
 S VALMHDR(2)=""
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("RCRCVC",$J)
 D CHK^RCRCVCP(RCEXP)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("RCRCVC",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
