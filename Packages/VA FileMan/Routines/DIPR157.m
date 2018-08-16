DIPR157 ;O-OIFO/GMB-Functions: Delete SETDATA. Add DUPLICATED ;03/27/2008
 ;;22.0;VA FileMan;**157**;Mar 30, 1999;Build 7
 ;Per VHA Directive 2004-038, this routine should not be modified.
ENV ; Environmental Check
 N DELFUNC,ADDFUNC
 D BMES^XPDUTL("Perform Environment Check...")
 D CHKSTOP
 D INIT
 I $D(DELFUNC) D CHKDEL
 I $D(ADDFUNC) D CHKADD
 D BMES^XPDUTL("Finished Environment Check.")
 Q
CHKDEL ;
 D BMES^XPDUTL("Checking Function(s) to be deleted from FUNCTION file ^DD(""FUNC""...")
 N IEN
 S IEN=0
 F  S IEN=$O(DELFUNC(IEN)) Q:'IEN  D
 . S DELFUNC=DELFUNC(IEN,0)
 . D BMES^XPDUTL("...Checking for function "_DELFUNC_" at IEN "_IEN)
 . I '$D(^DD("FUNC",IEN)) D  Q
 . . D MES^XPDUTL("...Already deleted.")
 . I $D(ADDFUNC(IEN,0)),$G(^DD("FUNC",IEN,0))=ADDFUNC(IEN,0) D  Q
 . . D MES^XPDUTL("...Already deleted.")
 . I '$$OKFUNC(.DELFUNC,IEN) D  Q
 . . D MES^XPDUTL("...Something's not right. Notify SD&D.")
 . . S XPDQUIT=2
 . D MES^XPDUTL("...Looks OK. We'll delete it in the Post-Init.")
 Q
CHKADD ;
 D BMES^XPDUTL("Checking Function(s) to be added to FUNCTION file ^DD(""FUNC""...")
 N IEN
 S IEN=0
 F  S IEN=$O(ADDFUNC(IEN)) Q:'IEN  D
 . S ADDFUNC=ADDFUNC(IEN,0)
 . D BMES^XPDUTL("...Checking for function "_ADDFUNC_" at IEN "_IEN)
 . I $D(^DD("FUNC",IEN)) D  Q
 . . D MES^XPDUTL("...Found something at that IEN. Checking it out.")
 . . I $D(DELFUNC(IEN,0)),$G(^DD("FUNC",IEN,0))=DELFUNC(IEN,0) D  Q
 . . . D MES^XPDUTL("...It's "_DELFUNC(IEN,0)_". We'll replace it with "_ADDFUNC_" in the Post-Init.")
 . . I '$$OKFUNC(.ADDFUNC,IEN) D  Q
 . . . S XPDQUIT=2
 . . . D MES^XPDUTL("...Something's not right. Notify SD&D.")
 . . D MES^XPDUTL("...Looks OK - "_ADDFUNC_" is already there.")
 . D MES^XPDUTL("...It's not there. We'll add it in the Post-Init.")
 Q
POSTINIT ; Post-Init
 N COUNT,DELFUNC,ADDFUNC
 D BMES^XPDUTL("Beginning Post-Installation...")
 S COUNT=0
 D INIT
 I $D(DELFUNC) D DELFUNC
 I $D(ADDFUNC) D ADDFUNC
 D END
 D BMES^XPDUTL("Finished Post-Installation.")
 Q
INIT ;
 ; Delete the following function(s):
 S DELFUNC(57,0)="SETDATA"
 S DELFUNC(57,1)="S X1=X"
 S DELFUNC(57,3)=2
 S DELFUNC(57,9)="SETS FIRST ARGUMENT EQUAL TO THE SECOND ARGUMENT"
 ;
 ; Add the following function(s):
 S ADDFUNC(57,0)="DUPLICATED"
 S ADDFUNC(57,1)="S X=X"
 S ADDFUNC(57,3)=1
 S ADDFUNC(57,9)="Takes as argument the name of a CROSS-REFERENCED field.  Returns BOOLEAN value, 1=field value is duplicated in another entry, """"=field value is unique"
 Q
DELFUNC ;
 D BMES^XPDUTL("Deleting Function(s) from FUNCTION file ^DD(""FUNC""...")
 N IEN
 S IEN=0
 F  S IEN=$O(DELFUNC(IEN)) Q:'IEN  D
 . S DELFUNC=DELFUNC(IEN,0)
 . D BMES^XPDUTL("...Checking for function "_DELFUNC_" at IEN "_IEN)
 . I '$D(^DD("FUNC",IEN)) D  Q
 . . I $D(^DD("FUNC","B",DELFUNC,IEN)) K ^(IEN)
 . . D MES^XPDUTL("...Already deleted.")
 . I $D(ADDFUNC(IEN,0)),$G(^DD("FUNC",IEN,0))=ADDFUNC(IEN,0) D  Q
 . . I $D(^DD("FUNC","B",DELFUNC,IEN)) K ^(IEN)
 . . D MES^XPDUTL("...Already deleted.")
 . I '$$OKFUNC(.DELFUNC,IEN) D  Q
 . . D MES^XPDUTL("...Something's not right. Notify SD&D.")
 . D MES^XPDUTL("...Deleting Function "_DELFUNC_" ...")
 . K ^DD("FUNC",IEN)
 . K ^DD("FUNC","B",DELFUNC,IEN)
 . D MES^XPDUTL("...Deleted.")
 . S COUNT=COUNT-1
 Q
ADDFUNC ;
 D BMES^XPDUTL("Adding Function(s) to FUNCTION file ^DD(""FUNC""...")
 N IEN,I
 S IEN=0
 F  S IEN=$O(ADDFUNC(IEN)) Q:'IEN  D
 . S ADDFUNC=ADDFUNC(IEN,0)
 . D BMES^XPDUTL("...Checking for function "_ADDFUNC_" at IEN "_IEN)
 . I $D(^DD("FUNC",IEN)) D  Q
 . . D MES^XPDUTL("...Found something at that IEN. Checking it out.")
 . . I '$$OKFUNC(.ADDFUNC,IEN) D  Q
 . . . D MES^XPDUTL("...Something's not right. Notify SD&D.")
 . . D MES^XPDUTL("...Looks OK - "_ADDFUNC_" is already there.")
 . D MES^XPDUTL("...Adding Function "_ADDFUNC_" ...")
 . S I=""
 . F  S I=$O(ADDFUNC(IEN,I)) Q:I=""  S ^DD("FUNC",IEN,I)=ADDFUNC(IEN,I)
 . S ^DD("FUNC","B",ADDFUNC,IEN)=""
 . D MES^XPDUTL("...Added.")
 . S COUNT=COUNT+1
 Q
OKFUNC(FUNC,IEN) ; Check existing Function
 N I,OK
 S I="",OK=1
 F  S I=$O(^DD("FUNC",IEN,I)) Q:I=""  I ^(I)'=$G(FUNC(IEN,I)) D
 . S OK=0
 . I I=9 D MES^XPDUTL("...Node "_I_" does not match expected value.") Q
 . D MES^XPDUTL("...Node "_I_"='"_NODEI_"' - Expected: '"_$G(FUNC(IEN,I))_"'")
 Q:'OK 0
 S I=""
 F  S I=$O(FUNC(IEN,I)) Q:I=""  I $G(^DD("FUNC",IEN,I))'=FUNC(IEN,I) D
 . S OK=0
 . I I=9 D MES^XPDUTL("...Node "_I_" does not match expected value.") Q
 . D MES^XPDUTL("...Node "_I_"='"_$G(^DD("FUNC",IEN,I))_"' - Expected: '"_FUNC(IEN,I)_"'")
 Q OK
END ;
 Q:'COUNT  ; Count piece doesn't need updating
 ; Update 4th piece of Zeroth node
 L +^DD("FUNC",0):5 S $P(^(0),U,4)=$P(^DD("FUNC",0),U,4)+COUNT I  L -^DD("FUNC",0)
 Q
CHKSTOP ;
  ; Check XPDENV 0 = Loading; 1 = Installing
 I 'XPDENV Q  ; Loading Distribution - No Check
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
 S X=+$G(^%ZIS(14.5,"LOGON",$P(Y,"^",2)))
 I 'X D
 . W $C(7)
 . D BMES^XPDUTL("* Warning Logons are NOT Inhibited!")
 Q
