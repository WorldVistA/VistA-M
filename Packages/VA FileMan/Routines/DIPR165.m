DIPR165 ;O-OIFO/GMB-Save DIDT as %DT ;4MAY2011
 ;;22.0;VA FileMan;**165**;Mar 30, 1999;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified.
ENV ; Environmental Check
 D BMES^XPDUTL("Perform Environment Check...")
 D CHKSTOP
 D CHKOS
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
CHKOS ; Check to see if CACHE/OpenM entry exists
 D BMES^XPDUTL("I'm checking to ensure that entry 18, CACHE/OpenM,")
 D MES^XPDUTL("exists in the MUMPS OPERATING SYSTEM (#.7) file.")
 I $P($G(^DD("OS",18,0)),U,1)="CACHE/OpenM" D  Q
 . D MES^XPDUTL("...It does.")
 W $C(7)
 D MES^XPDUTL("...Error: ^DD(""OS"",18,0) should be CACHE/OpenM, but isn't.")
 D MES^XPDUTL("...Something's not right with IEN 18 of the MUMPS OPERATING SYSTEM (#.7) file.")
 D MES^XPDUTL("...Notify SD&D.")
 S XPDQUIT=2
 Q
POSTINIT ; Post-Init
 D BMES^XPDUTL("Beginning Post-Installation...")
 D BMES^XPDUTL("  I'm saving routine DIDT as %DT.")
 N SCR,%S,%D,ZTOS
 S SCR="I 1",ZTOS=$$OSNUM^ZTMGRSET,%S="DIDT",%D="%DT" D MOVE^ZTMGRSET
 D MES^XPDUTL("  I'm saving routine DIDTC as %DTC.")
 K SCR,%S,%D,ZTOS
 S SCR="I 1",ZTOS=$$OSNUM^ZTMGRSET,%S="DIDTC",%D="%DTC" D MOVE^ZTMGRSET
 D BMES^XPDUTL("  I'm checking the settings for CACHE/OpenM")
 D MES^XPDUTL("  in the MUMPS OPERATING SYSTEM (#.7) file.")
 N LINE
 S LINE=$G(^DD("OS",18,0))
 I $P(LINE,U,3,4)="250^15000",$P(LINE,U,7)=250 D
 . D MES^XPDUTL("  ...The settings are correct. No action taken.")
 E  D
 . I $P(LINE,U,3)'=250 D
 . . D MES^XPDUTL("  ...I'm changing the GLOBAL LENGTH (MAX) (#2) field from "_$S($P(LINE,U,3)="":"Null",1:$P(LINE,U,3))_" to 250.")
 . . S $P(LINE,U,3)=250
 . I $P(LINE,U,4)'=15000 D
 . . D MES^XPDUTL("  ...I'm changing the ROUTINE SIZE (MAX) (#3) field from "_$S($P(LINE,U,4)="":"Null",1:$P(LINE,U,4))_" to 15000.")
 . . S $P(LINE,U,4)=15000
 . I $P(LINE,U,7)'=250 D
 . . D MES^XPDUTL("  ...I'm changing the INDIVIDUAL SUBSCRIPT LENGTH (#7) field from "_$S($P(LINE,U,7)="":"Null",1:$P(LINE,U,7))_" to 250.")
 . . S $P(LINE,U,7)=250
 . S ^DD("OS",18,0)=LINE
 D BMES^XPDUTL("Finished Post-Installation.")
 Q
