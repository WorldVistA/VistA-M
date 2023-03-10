PXRMP65E ;ISP/AGP - PATCH 65 EXCHANGE ENTRY;12/27/2021
 ;;2.0;CLINICAL REMINDERS;**65**;Feb 04, 2005;Build 438
 Q
EXARRAY(MODE,ARRAY) ;List of exchange entries used by delete and install
 ;MODE values: I for include in build, A for include action.
 N LN,MESSAGE
 S LN=0
 ;
 S LN=LN+1
 S ARRAY(LN,1)="VA-IM SMALLPOX READING"
 I MODE["I" S ARRAY(LN,2)="12/03/2018@18:42:27"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 ;S LN=LN+1
 ;S ARRAY(LN,1)="CPRSV32B IMMUNIZATION REMINDER DIALOGS"
 ;I MODE["I" S ARRAY(LN,2)="12/27/2021@16:48:51"
 ;I MODE["A" S ARRAY(LN,3)="O"
 ;
 S LN=LN+1
 S ARRAY(LN,1)="PXRM PDMP BUTTON"
 I MODE["I" S ARRAY(LN,2)="05/24/2021@13:55:47"
 I MODE["A" S ARRAY(LN,3)="O"
 ;
 I LN=1 S MESSAGE="There is "_LN_" Reminder Exchange entry to install."
 E  S MESSAGE="There are "_LN_" Reminder Exchange entries to install."
 I MODE="IA" D BMES^XPDUTL(MESSAGE)
 Q
 ;
