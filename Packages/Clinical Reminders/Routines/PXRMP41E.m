PXRMP41E ;SLC/PKR - Exchange inits for PXRM*2.0*41 ;09/14/2015
 ;;2.0;CLINICAL REMINDERS;**41**;Feb 04, 2005;Build 223
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PXRM*2.0*41 TELEDERM TEMPLATES"
 I MODE["I" S ARRAY(LN,2)="10/28/2015@14:22:02"
 I MODE["A" S ARRAY(LN,3)="I"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
