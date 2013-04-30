PXRMP27E ;SLC/PKR - Exchange inits for PXRM*2.0*27 ;09/25/2012
 ;;2.0;CLINICAL REMINDERS;**27**;Feb 04, 2005;Build 188
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-HOMELESSNESS SCREENING"
 I MODE["I" S ARRAY(LN,2)="09/19/2012@14:33:18"
 I MODE["A" S ARRAY(LN,3)="M"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-HOMELESSNESS SCREENING DIALOG"
 I MODE["I" S ARRAY(LN,2)="09/19/2012@14:34:09"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-LIPID STATIN RX CVD/DM (VER1.0)"
 I MODE["I" S ARRAY(LN,2)="09/20/2012@12:34:17"
 I MODE["A" S ARRAY(LN,3)="M"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-GP LDL STATIN REMINDER NOT DUE"
 I MODE["I" S ARRAY(LN,2)="09/19/2012@18:12:26"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
