TIU182D ; SLC/MAM - Data, etc for Post-Install for TIU*1*182 ; 10/5/2004
 ;;1.0;Text Integration Utilities;**182**;Jun 20, 1997
 ;
SETDATA ; Set more data for DDEFS
 ; Basic data set in TIUEN182.  See rtn TIUEN182 for ordered list of
 ;DDEF Names and Types.
 ; -- Set Print Name, Owner, Status, National into FILEDATA node
 ;    of data array ^TMP("TIU182":
 N NUM S NUM=0
 F NUM=1:1:13 D
 . S ^TMP("TIU182",$J,"FILEDATA",NUM,.03)=$G(^TMP("TIU182",$J,"BASICS",NUM,"NAME")) ;Name node MUST exist.  Using $G to ease testing of fewer DDEFS.
 . S ^TMP("TIU182",$J,"FILEDATA",NUM,.06)="CLINICAL COORDINATOR"
 . S ^TMP("TIU182",$J,"FILEDATA",NUM,.07)="INACTIVE"
 . S ^TMP("TIU182",$J,"FILEDATA",NUM,.13)="YES"
 ; -- Set Document Class to ACTIVE:
 S ^TMP("TIU182",$J,"FILEDATA",1,.07)="ACTIVE"
 ; -- Set Exterior Type:
 S ^TMP("TIU182",$J,"FILEDATA",1,.04)="DOCUMENT CLASS"
 N NUM S NUM=0
 F NUM=2:1:13 S ^TMP("TIU182",$J,"FILEDATA",NUM,.04)="TITLE"
 ; -- Set Parent and Menu Text into DATA nodes of ^TMP("TIU182":
 ; -- Set PIEN node = IEN of parent if known, or if not,
 ;    set PNUM node = DDEF# of parent		 
 ;    Set Parent of Document Class to CLINICAL PROCEDURES Class:
 S ^TMP("TIU182",$J,"DATA",1,"PIEN")=$$CLASS^TIUCP
 N NUM
 F NUM=2:1:13 S ^TMP("TIU182",$J,"DATA",NUM,"PNUM")=1
 F NUM=1:1:13 S ^TMP("TIU182",$J,"DATA",NUM,"MENUTXT")=$P($T(MENUTXT+NUM),";;",2,99)
 ;
PRINT ; Print out results from message array ^TMP("TIU182MSG",$J
 N TIUCNT,TIUCONT
 I $D(ZTQUEUED) S ZTREQ="@" ; Tell TaskMan to delete Task log entry
 I $E(IOST)="C-" W @IOF,!
 S TIUCNT="",TIUCONT=1
 F  S TIUCNT=$O(^TMP("TIU182MSG",$J,TIUCNT)) Q:TIUCNT=""  D  Q:'TIUCONT
 . S TIUCONT=$$SETCONT Q:'TIUCONT
 . W ^TMP("TIU182MSG",$J,TIUCNT),!
PRINTX Q
 ;
STOP() ;on screen paging check
 ; quits TIUCONT=1 if cont. ELSE quits TIUCONT=0
 N DIR,Y,TIUCONT
 S DIR(0)="E" D ^DIR
 S TIUCONT=Y
 I TIUCONT W @IOF,!
 Q TIUCONT
 ;
SETCONT() ; D form feed, Set TIUCONT
 N TIUCONT
 S TIUCONT=1
 I $E(IOST)="C-" G SETX:$Y+5<IOSL
 I $E(IOST)="C-" S TIUCONT=$$STOP G SETX
 G:$Y+8<IOSL SETX
 W @IOF
SETX Q TIUCONT
 ;
MENUTXT ; -- List ordered 1-13 for menutext.  Cut off at 20 chars
 ;;Hist Procedures
 ;;Hist Cardiac Cathete
 ;;Hist Electrocardiogr
 ;;Hist Echocardiogram
 ;;Hist Electrophysiolo
 ;;Hist Holter Procedur
 ;;Hist Exercise Tolera
 ;;Hist Pre/Post Surger
 ;;Hist Endoscopic Proc
 ;;Hist Pulmonary Funct
 ;;Hist Hematology Proc
 ;;Hist Pacemaker Impla
 ;;Hist Rheumatology Pr
 Q
