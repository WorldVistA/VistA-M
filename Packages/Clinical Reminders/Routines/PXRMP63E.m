PXRMP63E ;SLC/PKR - Exchange inits for PXRM*2.0*63 ;01/28/2016
 ;;2.0;CLINICAL REMINDERS;**63**;Feb 04, 2005;Build 243
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PXRM*2.0*63 HEP C RISK SCREEN"
 I MODE["I" S ARRAY(LN,2)="03/09/2016@09:55:23"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PXRM*2.0*63 TDAP ZOSTER PNEUMO"
 I MODE["I" S ARRAY(LN,2)="03/07/2016@11:42:39"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
