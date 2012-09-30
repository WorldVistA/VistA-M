TIUPS211 ; SLC/JER - Post-install Routine for Patch TIU*1*211 ; 4/5/06
 ;;1.0;TEXT INTEGRATION UTILITIES;**211**;Jun 20, 1997;Build 26
MAIN ; main subroutine
 N TIUDOMDA,SUCCESS S SUCCESS=0
 D BMES^XPDUTL("Invoking VUID Seeding Process...")
 S SUCCESS=$$GETIEN^HDISVF09("TIU",.TIUDOMDA)
 I 'SUCCESS D  Q
 . D BMES^XPDUTL("Domain ""TIU"" not found...Exiting Post-install.")
 D EN^HDISVCMR(TIUDOMDA,"")
 D BMES^XPDUTL("Process successfully queued!")
 Q
