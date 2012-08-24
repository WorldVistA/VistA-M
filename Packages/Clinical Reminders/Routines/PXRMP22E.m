PXRMP22E ;SLC/PKR - Exchange inits for PXRM*2.0*22 ;2/01/2012
 ;;2.0;CLINICAL REMINDERS;**22**;Feb 04, 2005;Build 160
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-TERATOGENIC MEDICATIONS ORDER CHECKS"
 I MODE["I" S ARRAY(LN,2)="04/27/2012@10:31:40"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
