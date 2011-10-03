DIENVSTP ;IRMFO-SF/FM STAFF-ENVIRONMENT CHECK ROUTINE ;11/6/98  12:53
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Check XPDENV 0 = Loading; 1 = Installing
 I 'XPDENV Q  ; Loading Distribution - No Check
 ;
INSCHK ; Do Checks During Install Only
 S XPDNOQUE=1 ;prevents QUEUEING of a FM patch install
 ;
TMCHK ; Check to see if TaskMan is still running
 S X=$$TM^%ZTLOAD
 I X,'$D(^%ZTSCH("WAIT")) D
 . W $C(7)
 . D MES^XPDUTL("* Install Stopped Because TaskMan Has NOT Been Stopped!")
 . D MES^XPDUTL("     Transport Global Was NOT Unloaded!")
 . S XPDQUIT=2
 ;
LINH ; Check to see if Logons are Inhibited
 D GETENV^%ZOSV  ; $P(Y,"^",2) = Installing Volume
 S X=+$G(^%ZIS(14.5,"LOGON",$P(Y,"^",2)))
 I 'X D  Q  ; Bail Out of Install
 . W $C(7)
 . D BMES^XPDUTL("* Install Stopped Because Logon Were NOT Inhibited.")
 . D MES^XPDUTL("     Transport Global Was NOT Unloaded!")
 . S XPDQUIT=2
 Q
