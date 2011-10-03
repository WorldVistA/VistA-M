IBCICL ;DSI/JSR - IBCI CLAIMS MANAGER CLERK WORKSHEET ;6-MAR-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;; Program Description:
 ;  This routine is a ListManager routine envoked when the user is in
 ;  bill edit screen.
 ;  Clerk Mode is active under the following conditions:
 ;  1) When the user does not have IBCI Security Key
 ;  2) Only during the Bill Edit process -- part of core IB.
 ;  The data is extracted using ^IBCIWK which envokes this LM template.
 ;  The visual formating is done in ^IBCIMG.
EN ; -- main entry point
 D EN^VALM("IBCI CLAIMSMANAGER CLERK WK")
 Q
 ;
HDR ; -- header code
 D HDR^IBCIMG
 Q
 ;
INIT ; -- init variables and list array
 D INIT^IBCIMG
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D EXIT^IBCIMG
 Q
