IBCNINS ;AITC/TAZ - NIGHTLY INSURANCE PROCESS ;11/23/20 12:46p.m.
 ;;2.0;INTEGRATED BILLING;**687**;21-MAR-94;Build 88
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ;Main Entry Point for Nightly Process
 ;
 ; Checking for non-human users
 D CHKPER
 ;
 ; Process Nightly IIU Cleanup if IIU is Nationally Enabled.
 I $$GET1^DIQ(350.9,"1,",53.01,"I")="Y" D NIGHT^IBCNIUHL
 ;
 ; Purge IIU File (#365.19) honoring the parameters in file (#350.9)
 D EN^IBCNIUK
 ;
 ; Process Nightly eIV Process
 D EN^IBCNEDE
 ;
ENQ ;Exit
 Q
 ;
 ;-------------------------------------------------------
CHKPER ;
 ; Check for the existence of the New Person (#200) entries listed below.
 ; Send a mailman message to "VHAeInsuranceRapidResponse@domain.ext" if any are missing.
 ; Entries to check: "INTERFACE,IB IIU", "INTERFACE,IB EIV", "AUTOUPDATE,IBEIV"
 N IBAUTO,IBEIV,IBIIU,WKDT,IBMCT,MSG,MGRP,IBXMY
 ;
 S IBIIU=+$$FIND1^DIC(200,,"MX","INTERFACE,IB IIU")
 S IBAUTO=+$$FIND1^DIC(200,,"MX","AUTOUPDATE,IBEIV"),IBEIV=+$$FIND1^DIC(200,,"MX","INTERFACE,IB EIV")
 I IBIIU,IBAUTO,IBEIV Q
 ;
 S WKDT=$$SITE^VASITE()
 S MSG(1)="Missing EIV New Person entries, for station "_$P(WKDT,U,3)_":"_$P(WKDT,U,2)
 S MSG(2)="-------------------------------------------------------------------------------"
 S IBMCT=2
 I 'IBIIU S MSG(IBMCT)="Entry for 'INTERFACE,IB IIU' is missing",IBMCT=IBMCT+1
 I 'IBAUTO S MSG(IBMCT)="Entry for 'AUTOUPDATE,IBEIV' is missing",IBMCT=IBMCT+1
 I 'IBEIV S MSG(IBMCT)="Entry for 'INTERFACE,IB EIV' is missing",IBMCT=IBMCT+1
 S MSG(IBMCT)="-------------------------------------------------------------------------------"
 S MGRP=$$MGRP^IBCNEUT5()
 ;
 ; Check for production account and made sure eInsurance mailgroup is self documenting
 I $$PROD^XUPROD(1) S IBXMY("VHAeInsuranceRapidResponse@domain.ext")=""
 D MSG^IBCNEUT5(MGRP,"Missing eInsurance New Person entries ("_$P(WKDT,U,3)_")","MSG(",,.IBXMY)  ;sends to postmaster if IBXMY is empty
 Q
