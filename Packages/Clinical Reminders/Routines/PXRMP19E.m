PXRMP19E ;BP/WAT - Exchange inits for PXRM*2.0*19; ;04/20/17  13:49
 ;;2.0;CLINICAL REMINDERS;**19**;Feb 04, 2005;Build 187
 ;
 ;10141 ^XPDUTL
 ;====================================================
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="TIU TEMPLATE URL FIX"
 I MODE["I" S ARRAY(LN,2)="06/07/2016@06:18:01"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-HT EDUCATION TOPICS"
 I MODE["I" S ARRAY(LN,2)="03/01/2016@14:31:35"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-HT PROJECT"
 I MODE["I" S ARRAY(LN,2)="04/20/2017@13:43:30"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 I MODE="IA" D BMES^XPDUTL("There are "_LN_" Reminder Exchange entries to be installed.")
 Q
