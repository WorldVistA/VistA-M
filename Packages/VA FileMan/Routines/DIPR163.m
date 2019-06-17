DIPR163 ;O-OIFO/GMB-Envirocheck and Post Init ;2/23/2010
 ;;22.0;VA FileMan;**163**;Mar 30, 1999;Build 28
 ;Per VHA Directive 2004-038, this routine should not be modified.
ENV ; Environmental Check
 D BMES^XPDUTL("Perform Environment Check...")
 D CHKSTOP
 D BMES^XPDUTL("Finished Environment Check.")
 Q
POST ; Set DD changes to the PRINT TEMPLATE (#.4) file.
 S ^DD(.4,1815,1,0)="^.1^1^1"
 S ^DD(.4,1815,1,1,0)="^^^MUMPS"
 S ^DD(.4,1815,1,1,1)="Q"
 S ^DD(.4,1815,1,1,2)="D DELETROU^DIEZ($TR(X,U))"
 S ^DD(.4,"IX",1815)=""
 ; Set DD changes to the INPUT TEMPLATE (#.402) file.
 S ^DD(.402,1815,1,0)="^.1^1^1"
 S ^DD(.402,1815,1,1,0)="^^^MUMPS"
 S ^DD(.402,1815,1,1,1)="Q"
 S ^DD(.402,1815,1,1,2)="D DELETROU^DIEZ($TR(X,U))"
 S ^DD(.402,"IX",1815)=""
 S ^DD(.402,0,"ID","WRITED")="I $G(DZ)?1""???"".E N % S %=0 F  S %=$O(^DIE(Y,""%D"",%)) Q:%'>0  I $D(^(%,0))#2 D EN^DDIOL(^(0),"""",""!?5"")"
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
