IBNCPDPV ;DALOI/SS - for ECME SCREEN VIEW PATIENT INSURANCE ;28-OCT-05
 ;;2.0;INTEGRATED BILLING;**276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; -- main entry point
 Q
INSVIEW ;
 D EN^VALM("IBCNS VIEW INS CO")
 S VALMBCK="R"
 Q
 ;
EN1(DFN) ;
 I $G(DFN)'>0 Q
 D EN
 Q
EN ; -- main entry point for IBNCPDP VIEW PAT INS
 D EN^VALM("IBNCPDP VIEW PAT INS")
 Q
 ;
HDR ; -- header code
 D HDR^IBCNSM4
 Q
 ;
INIT ; -- init variables and list array
 D INIT^IBCNSM4
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D FNL^IBCNSM4
 Q
 ;
EXPND ; -- expand code
 Q
 ;
