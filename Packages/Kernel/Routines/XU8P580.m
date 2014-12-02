XU8P580 ;O-OIFO/GMB-Delete OBJECT multiple from HELP FRAME file ;06/05/2012
 ;;8.0;KERNEL;**580**;Jul 10, 1995;Build 46
 ;
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
 D MES^XPDUTL("VISTA Background jobs be STOPPED before installation of this patch. Failure")
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
 ;
PRE ;Pre-Init
 D BMES^XPDUTL("Beginning Pre-Installation...")
 D BMES^XPDUTL("  I am deleting the cross-reference ""SAN"" for field #501.2 file #200.")
 K ^VA(200,"SAN")
 D BMES^XPDUTL("Finished Pre-Installation.")
 Q
 ;
POST ; Post-Init
 D BMES^XPDUTL("Beginning Post-Installation...")
 D BMES^XPDUTL("  I am deleting the OBJECT (#9.201) multiple from the HELP FRAME (#9.2) file.")
 D BMES^XPDUTL("  I am re-indexing ""ASAN"" cross-reference for field #501.2 file #200. ")
 N DIU
 S DIU=9.201,DIU(0)="DS" D EN^DIU2
 D REINDEX
 D BMES^XPDUTL("Finished Post-Installation.")
 Q
 ;
REINDEX ;Re-index xfer "ASAN"
 N DIK,DA
 S DIK="^VA(200,"
 S DIK(1)="501.2^ASAN"
 D ENALL^DIK
 Q
 ;
 ;END
 
