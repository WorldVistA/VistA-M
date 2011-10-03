IBCIBW ;DSI/JSR - IBCI CLAIMS MANAGER MGR WORKSHEET ;6-MAR-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;; Program Description
 ;  This routine is a ListManager routine envoked when the user
 ;  selects to view the error messages for a claim in browse mode only.
 ;  Browse Mode is active during the following conditions:
 ;  1) Test sending claims to CM
 ;  2) When user selects to print a ClaimsManager Worksheet.
 ;  The data is extracted using ^IBCIWK which envokes this LM template.
 ;  The visual formating is done in ^IBCIMG.
EN ; -- main entry point
 D EN^VALM("IBCI CLAIMSMANAGER WK BROWSE")
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
 K ^TMP("IBCIMG",$J),^TMP("IBCIMG1",$J)
 K ^TMP("IBCILM",$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
