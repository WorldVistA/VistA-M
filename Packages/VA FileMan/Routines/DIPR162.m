DIPR162 ;O-OIFO/GMB-Correct NOW function ;8/31/2009
 ;;22.0;VA FileMan;**162**;Mar 30, 1999;Build 19
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
 D BMES^XPDUTL("  I am saving routine DIDT as %DT.")
 N SCR,%S,%D,ZTOS
 S SCR="I 1",ZTOS=$$OSNUM^ZTMGRSET,%S="DIDT",%D="%DT" D MOVE^ZTMGRSET
 N NOWX,TODAYX
 S NOWX("BEFORE")="S %=$P($H,"","",2),X=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100)"
 S NOWX("AFTER")="N %I,%H,% D NOW^%DTC S X=%"
 S TODAYX("BEFORE")="S X=DT"
 S TODAYX("AFTER")="N %I,%H,% D NOW^%DTC"
 I $G(^DD("FUNC",24,1))=NOWX("AFTER") D
 . D BMES^XPDUTL("  The NOW function has already been corrected. No action taken.")
 E  D
 . D BMES^XPDUTL("  I am changing ^DD(""FUNC"",24,1) to correct the NOW function.")
 . S ^DD("FUNC",24,1)=NOWX("AFTER")
 I $G(^DD("FUNC",25,1))=TODAYX("AFTER") D
 . D BMES^XPDUTL("  The TODAY function has already been corrected. No action taken.")
 E  D
 . D BMES^XPDUTL("  I am changing ^DD(""FUNC"",25,1) to correct the TODAY function.")
 . S ^DD("FUNC",25,1)=TODAYX("AFTER")
 D FIND
 D BMES^XPDUTL("Finished Post-Installation.")
 Q
FIND ; Find and replace NOW and TODAY code in triggers
 D BMES^XPDUTL("  I am finding and replacing all NOW and TODAY code in triggers.")
 N FILE,FLD,IEN,LINE,FLAG,CNT
 S (FILE,CNT)=0
 F  S FILE=$O(^DD(FILE)) Q:'FILE  D
 . S FLD=0
 . F  S FLD=$O(^DD(FILE,FLD)) Q:'FLD  D
 . . S IEN=0
 . . F  S IEN=$O(^DD(FILE,FLD,1,IEN)) Q:'IEN  D
 . . . S FLAG=0
 . . . I $G(^DD(FILE,FLD,1,IEN,"CREATE VALUE"))="NOW" D REPLACE("NOW","CREATE",1,.NOWX)
 . . . I $G(^DD(FILE,FLD,1,IEN,"CREATE VALUE"))="TODAY" D REPLACE("TODAY","CREATE",1,.TODAYX)
 . . . I $G(^DD(FILE,FLD,1,IEN,"DELETE VALUE"))="NOW" D REPLACE("NOW","DELETE",2,.NOWX)
 . . . I $G(^DD(FILE,FLD,1,IEN,"DELETE VALUE"))="TODAY" D REPLACE("TODAY","DELETE",2,.TODAYX)
 D BMES^XPDUTL("  I have replaced the NOW and TODAY code in "_CNT_" triggers.")
 Q
REPLACE(FUNC,VAL,NODE,CODE) ;
 N LINE,P1,P2,START,STOP
 S START=NODE-.00001,STOP=NODE+.39999,NODE=START
 F  S NODE=$O(^DD(FILE,FLD,1,IEN,NODE)) Q:'NODE!(NODE>STOP)  D
 . S LINE=$G(^DD(FILE,FLD,1,IEN,NODE))
 . Q:LINE'[CODE("BEFORE")
 . I 'FLAG D
 . . S FLAG=1
 . . S CNT=CNT+1
 . . D BMES^XPDUTL("  For TRIGGER at ^DD("_FILE_","_FLD_",1,"_IEN_", change:")
 . D MES^XPDUTL("  "_FUNC_" code in node "_NODE_")")
 . D MES^XPDUTL("    from: "_LINE)
 . S P1=$P(LINE,CODE("BEFORE"),1)
 . S P2=$P(LINE,CODE("BEFORE"),2)
 . S LINE=P1_CODE("AFTER")_P2
 . S ^DD(FILE,FLD,1,IEN,NODE)=LINE
 . D MES^XPDUTL("      to: "_LINE)
 Q
