DI156ENV ;IRMFO-SF/FM STAFF-ENVIRONMENT CHECK ROUTINE ;12:08 PM  8 Jun 2007
 ;;22.0;VA FileMan;**156**;Mar 30, 1999;Build 1
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Check XPDENV 0 = Loading; 1 = Installing
 I 'XPDENV D  Q  ; Loading Distribution - No Check
 . Q
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
 S X=+$G(^%ZIS(14.5,"LOGON",$P(Y,"^",2)))
 I 'X D
 . W $C(7)
 . D BMES^XPDUTL("* Warning Logons are NOT Inhibited!")
 Q
