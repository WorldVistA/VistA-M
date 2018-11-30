PXRMP62E ;SLC/KCM - Exchange inits for PXRM*2.0*62 ;01/13/2016
 ;;2.0;CLINICAL REMINDERS;**62**;Feb 04, 2005;Build 23
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PXRM*2.0*62 PCL-5 INSTRUMENT"
 I MODE["I" S ARRAY(LN,2)="09/29/2016@12:57:54"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
