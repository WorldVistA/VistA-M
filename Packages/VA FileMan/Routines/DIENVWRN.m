DIENVWRN ;IRMFO-SF/FM STAFF-ENVIRONMENT CHECK ROUTINE ;10:10 AM  28 Apr 2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**147**
 ;
 ; Check XPDENV 0 = Loading; 1 = Installing
 I 'XPDENV D  Q  ; Loading Distribution - No Check
 . ; Make sure exported routines are registered in ROUTINE(#9.8) file
 . ; Edit FOR loop
 . N ROU,ZDATE,%,%H,%I,X
 . D NOW^%DTC
 . S ZDATE=%
 . F ROU="DDS10","DIA2","DICA3","DICN0","DIEF1","DIEFW","DIET","DILF" D
 .. N IEN S IEN=$O(^DIC(9.8,"B",ROU,0))
 .. I 'IEN D
 ... N FDA,DIERR,ZERR,IEN
 ... S IEN="+1,"
 ... S FDA(9.8,IEN,.01)=ROU
 ... S FDA(9.8,IEN,1)="R"
 ... S FDA(9.8,IEN,7.4)=ZDATE
 ... D UPDATE^DIE("","FDA","IEN")
 ... Q
 .. Q
 . D CLEAN^DILF
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
