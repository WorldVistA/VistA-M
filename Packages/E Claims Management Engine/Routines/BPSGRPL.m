BPSGRPL ;BHAM ISC/BNT - ECME USER SCREEN GROUP PLAN ;01-NOV-07
 ;;1.0;E CLAIMS MGMT ENGINE;**7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Main entry from ECME User Screen - Further Research Menu
EN ;
 N BPSOP,BPRTN
 D FULL^VALM1
 S BPSOP=$$PROMPT^BPSSCRCV("S^EPLA:Edit PLAN APPLICATION Sub-file;MGP:Match Group Plan to a Pharmacy Plan;MMGP:Match Multiple Group Plans to a Pharmacy Plan","Select Group Plan menu Option","")
 I BPSOP="^" S VALMBCK="R" Q
 S BPRTN=$S(BPSOP="EPLA":"^IBCNRE4",BPSOP="MGP":"EN^IBCNRPMT",BPSOP="MMGP":"EN^IBCNRPM1",1:"")
 D:BPRTN]"" @BPRTN
 ;
 S VALMBCK="R"
 Q
 ;
EXIT Q
