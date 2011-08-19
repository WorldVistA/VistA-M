PXRMP20E ;SLC/PKR - Exchange inits for PXRM*2.0*20 ;04/01/2011
 ;;2.0;CLINICAL REMINDERS;**20**;Feb 04, 2005;Build 117
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-PROJECT ARCH VISN CONTRACT CARE PILOT ELIGIBILITY"
 I MODE["I" S ARRAY(LN,2)="04/01/2011@04:31:55"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
