PXRMP35E ;SLC/PKR - Exchange inits for PXRM*2.0*35 ;04/21/2015
 ;;2.0;CLINICAL REMINDERS;**35**;Feb 04, 2005;Build 206
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-LIFE-SUSTAINING TREATMENT PXRM*2.0*35"
 I MODE["I" S ARRAY(LN,2)="03/31/2016@08:43:14"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
