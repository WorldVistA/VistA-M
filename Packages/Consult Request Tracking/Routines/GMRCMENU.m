GMRCMENU ;SLC/DCM - Select List Manager menu for user characteristics ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
EN ;Find user access characteristics and set up variables for menu's
 ;to be displayed by XQORM
 ;GMRCACTM=protocol name of action menu for user
 ;^TMP("GMRC",$J,"CURRENT","MENU") is the hijack protocol
 D EN^GMRCACTM
 S ^TMP("GMRC",$J,"CURRENT","MENU")=$O(^ORD(101,"B",GMRCACTM,0))_";ORD(101,"
 S XQORM("HIJACK")=^TMP("GMRC",$J,"CURRENT","MENU"),XQORM(0)="3AD"
 S GMRCOPT=""
 Q
