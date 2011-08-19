IBCNBLB ;BP/YMG - Ins Buffer: Eligibility/Benefit screen;14 Oct 09
 ;;2.0;INTEGRATED BILLING;**416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; entry point - IBCNB EXPAND BENEFITS action protocol
 N IEN365
 I '$G(IBBUFDA) G ENX
 S IEN365=$O(^IBCN(365,"AF",IBBUFDA,""),-1) I 'IEN365 W !!,"This entry does not have an associated eIV response." D PAUSE^VALM1 G ENX
 D EB^IBCNES(365.02,IEN365_",","A",1,"EIV EB DATA")
ENX ;
 S VALMBCK="R"
 Q
