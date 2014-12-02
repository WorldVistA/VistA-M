PXRMP24E ;SLC/PKR - Exchange inits for PXRM*2.0*24 ;05/09/2013
 ;;2.0;CLINICAL REMINDERS;**24**;Feb 04, 2005;Build 193
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-MH NO SHOW APPT CLINICS LL"
 I MODE["I" S ARRAY(LN,2)="10/05/2011@12:43:59"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-MHTC APPT STOP CODES AND EXCLUSION STOP"
 I MODE["I" S ARRAY(LN,2)="05/09/2013@11:28:49"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-MH HIGH RISK NO-SHOW FOLLOW-UP"
 I MODE["I" S ARRAY(LN,2)="12/06/2012@15:23:02"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-MH HIGH RISK NO-SHOW ADHOC RPT"
 I MODE["I" S ARRAY(LN,2)="12/06/2012@15:21:05"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-MHTC NEEDS ASSIGNMENT"
 I MODE["I" S ARRAY(LN,2)="12/06/2012@15:23:54"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
 ;
