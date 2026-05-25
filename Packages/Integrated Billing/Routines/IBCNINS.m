IBCNINS ;AITC/TAZ - NIGHTLY INSURANCE PROCESS ; 23-NOV-2020
 ;;2.0;INTEGRATED BILLING;**687,771,806,822**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ;Main Entry Point for Nightly Process
 ;
 ; Checking for non-human users
 D CHKPER
 ;
 ; Add Buffer Cleanup, Reject Duplicate entries - IB*806/CKB
 N IBNUM,IBQUAL,IBRUN
 ; Only run if the proxy user 'IB,BUFFER CLEANUP' exists
 I +$$FIND1^DIC(200,,"MX","IB,BUFFER CLEANUP") D
 . ;IBRUN=1 Run cleanup ; IBQUAL="A"=All/"N"=# of entries ; IBNUM=(IBQUAL=A)=""/(IBQUAL=N)=# of entries
 . S IBRUN=1,IBQUAL="A",IBNUM=""
 . D BUFCLN^IBJPI3(IBRUN,IBQUAL,IBNUM)
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
 ; Send Daily Buffer Report email - Summary Version from production sites only
 I $$PROD^XUPROD(1) D DBR^IBCNOR2
 ;
 ; IB*822/DTG check patient verify date for selected Insurance Co's.
 D DBR^IBCNERTC
 ;
ENQ ;Exit
 Q
 ;
 ;-------------------------------------------------------
CHKPER ;
 ; Check for the existence of the New Person (#200) entries listed below.
 ; Send a mailman message to "VHAeInsuranceRapidResponse@domain.ext" if any are missing.
 ; Entries to check: "INTERFACE,IB IIU", "INTERFACE,IB EIV", "AUTOUPDATE,IBEIV", "IB,BUFFER CLEANUP", "IB,AUTOINS FILEUPDATE"
 N IBAUTO,IBEIV,IBIIU,WKDT,IBMCT,MSG,MGRP,IBXMY
 N IBBUFCLN S IBBUFCLN=""  ;IB*806/DTG new var for IB Buffer Cleanup
 N IBBINSEL S IBBINSEL=""  ;IB*822/DTG for new selected insurance verify checks
 ;
 S IBIIU=+$$FIND1^DIC(200,,"MX","INTERFACE,IB IIU")
 S IBAUTO=+$$FIND1^DIC(200,,"MX","AUTOUPDATE,IBEIV"),IBEIV=+$$FIND1^DIC(200,,"MX","INTERFACE,IB EIV")
 S IBBUFCLN=+$$FIND1^DIC(200,,"MX","IB,BUFFER CLEANUP")  ; IB*806/DTG new var for IB Buffer Cleanup
 S IBBINSEL=+$$FIND1^DIC(200,,"MX","IB,AUTOINS FILEUPDATE")  ; IB*822/DTG new var for IB Selected Insurances
 ;I IBIIU,IBAUTO,IBEIV,IBBUFCLN Q  ; IB*806/DTG new var for IB Buffer Cleanup
 I IBIIU,IBAUTO,IBEIV,IBBUFCLN,IBBINSEL Q  ; IB*822/DTG new var for Pt policy verify date for selected Insurance Co's
 ;
 S WKDT=$$SITE^VASITE()
 S MSG(1)="Missing EIV New Person entries, for station "_$P(WKDT,U,3)_":"_$P(WKDT,U,2)
 S MSG(2)="-------------------------------------------------------------------------------"
 S IBMCT=2
 I 'IBIIU S MSG(IBMCT)="Entry for 'INTERFACE,IB IIU' is missing",IBMCT=IBMCT+1
 I 'IBAUTO S MSG(IBMCT)="Entry for 'AUTOUPDATE,IBEIV' is missing",IBMCT=IBMCT+1
 I 'IBEIV S MSG(IBMCT)="Entry for 'INTERFACE,IB EIV' is missing",IBMCT=IBMCT+1
 I 'IBBUFCLN S MSG(IBMCT)="Entry for 'IB,BUFFER CLEANUP' is missing",IBMCT=IBMCT+1
 I 'IBBINSEL S MSG(IBMCT)="Entry for 'IB,AUTOINS FILEUPDATE' is missing",IBMCT=IBMCT+1
 S MSG(IBMCT)="-------------------------------------------------------------------------------"
 S MGRP=$$MGRP^IBCNEUT5()
 ;
 ; Check for production account and made sure eInsurance mailgroup is self documenting
 I $$PROD^XUPROD(1) S IBXMY("VHAeInsuranceRapidResponse@domain.ext")=""
 D MSG^IBCNEUT5(MGRP,"Missing eInsurance New Person entries ("_$P(WKDT,U,3)_")","MSG(",,.IBXMY)  ;sends to postmaster if IBXMY is empty
 Q
