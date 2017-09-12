PRC51111 ;VMP/TJH  ; Pre Install routine for PRC*5.1*111 ; 07/31/2007
 ;;5.1;IFCAP;**111**;Oct 20, 2000;Build 1
 ;
 Q  ; Do Not Enter at routine label
 ;
EN ; Entry point.
GTR ; PRCPLO GREATER THAN RANGE, reset from 90 to 270
 N PRCP3,PRCPZ
 D BMES^XPDUTL("Resetting 'Stock on Hand Report Greater Than Range' to 270...")
 S PRCP3=$$GET^XPAR("SYS","PRCPLO GREATER THAN RANGE",1,"Q") ; GETS EXISTING VALUE
 I PRCP3=270 D BMES^XPDUTL("Range already set to 270, no action taken.") G GTRX
 S PRCP3=270
 D EN^XPAR("SYS","PRCPLO GREATER THAN RANGE",1,PRCP3,.PRCPZ)
 I PRCPZ D  G GTRX ; error trap
 . D BMES^XPDUTL("Range not set.  Reason: "_$P(PRCPZ,"^",2))
 . D MES^XPDUTL("Please use CLO SYSTEM PARAMETERS option to set manually.")
 D BMES^XPDUTL("Range changed successfully to "_PRCP3_".")
GTRX ; end of Greater Than Range subroutine
 ;
 Q
