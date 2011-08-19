SCDXPRN ;ALB/MTC - PRINT ROUTINES;23-MAY-1996
 ;;5.3;Scheduling;**44**;AUG 13, 1993
 Q
TRANS ;-- This report will print the NPCDB Transmissions for a Date Range.
 ;   The date to perform the sort is the date the Encounter tranaction
 ;   was posted to file 409.73.
 ;
 W !!,"NPCDB Data Transmission Report."
 W !!,*7,"This report requires 132 columns.",!!
 S L="DATA TRANSMISSION REPORT",DIC="^SD(409.73,",FLDS="[SCDX NPCDB TRANSMISSION REPORT]",BY=".06"
 D EN1^DIP
 K DIC,L,BY,FLDS
 Q
 ;
ERROR ;-- This report will provide a listing of the errors that occured from
 ;   the transmission of the data to NPCDB.
 ;
 W !!,"NPCDB Data Error Report."
 W !!,*7,"This report requires 132 columns.",!!
 S L="ERROR TRANSMISSION REPORT",DIC="^SD(409.75,",FLDS="[SCDX TRANSMITTED ERROR LIST]",BY="10.01"
 D EN1^DIP
 K DIC,L,BY,FLDS
 Q
 ;
