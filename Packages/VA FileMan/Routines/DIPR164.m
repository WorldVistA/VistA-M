DIPR164 ;O-OIFO/GMB-Correct LABEL DD node ;6/28/2009
 ;;22.0;VA FileMan;**164**;Mar 30, 1999;Build 20
 ;Per VHA Directive 2004-038, this routine should not be modified.
ENV ; Environmental Check
 D BMES^XPDUTL("Perform Environment Check...")
 D CHKSTOP
 D BMES^XPDUTL("Finished Environment Check.")
 Q
CHKSTOP ;
 ; Check XPDENV 0 = Loading; 1 = Installing
 Q:'XPDENV  ; Loading Distribution - No Check
 ;
 ;
INSCHK ; Do Checks During Install Only
 W $C(7)
 D MES^XPDUTL("** Although Queuing is allowed - it is HIGHLY recommended that ALL Users and")
 D MES^XPDUTL("VISTA Background jobs be STOPPED before installation of this patch.  Failure")
 D MES^XPDUTL("to do so may result in 'source routine edited' error(s). Edits will be")
 D MES^XPDUTL("lost and record(s) may be left in an inconsistent state, for example,")
 D MES^XPDUTL("not all Cross-Referencing completed; which in turn may cause FUTURE")
 D MES^XPDUTL("VistA/FileMan Hard Errors or corrupted Data. **")
 ;
TMCHK ; Check to see if TaskMan is still running
 S X=$$TM^%ZTLOAD
 I X,'$D(^%ZTSCH("WAIT")) D
 . W $C(7)
 . D BMES^XPDUTL("* Warning TaskMan Has NOT Been Stopped or Placed in a WAIT State!")
 ;
LINH ; Check to see if Logons are Inhibited
 D GETENV^%ZOSV  ; $P(Y,"^",2) = Installing Volume
 Q:$G(^%ZIS(14.5,"LOGON",$P(Y,"^",2)))
 W $C(7)
 D BMES^XPDUTL("* Warning Logons are NOT Inhibited!")
 Q
POSTINIT ; Post-Init
 D BMES^XPDUTL("Beginning Post-Installation...")
 I $P(^DD(0,.01,0),U,2)="RF" D
 . D MES^XPDUTL("  The DD has already been changed to prevent ^ in LABELS. No action taken.")
 E  D
 . D MES^XPDUTL("  I am changing piece 2 of ^DD(0,.01,0) from 'R' to 'RF' to prevent ^ in LABELs.")
 . S $P(^DD(0,.01,0),U,2)="RF"
 D BMES^XPDUTL("  I am saving routine DIDTC as %DTC.")
 N SCR,%S,%D,ZTOS
 S SCR="I 1",ZTOS=$$OSNUM^ZTMGRSET,%S="DIDTC",%D="%DTC" D MOVE^ZTMGRSET
 D MES^XPDUTL("Finished Post-Installation.")
 Q
