TIUPS137 ; SLC/MAM - After installing TIU*1*137;6/26/03
 ;;1.0;Text Integration Utilities;**137**;Jun 20, 1997
 ; Run this after installing patch 137.
 ;Use option: TIU137 DDEFS & RULES, ANATPATH
 ; External References
 ;   DBIA 10140  XREF^XQORM
 ;   DBIA 4119  MAIN^USRPS23
BEGIN ; Create DDEFS
 W !!,"This option creates Document Definitions, a User Class, and"
 W !,"Business Rules for Laboratory Reports."
 W ! K IOP S %ZIS="Q" D ^%ZIS I POP K POP Q
 I $D(IO("Q")) K IO("Q") D  Q
 .S ZTRTN="MAIN^TIUPS137"
 .S ZTDESC="Create DDefs, User Class, Rules for Laboratory Reports - TIU*1*137"
 .D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 .D HOME^%ZIS
 U IO D MAIN,^%ZISC
 Q
 ;
MAIN ; Create DDEFS for Laboratory Reports
 ; -- Check for dups created after the install but before this option:
 K ^XTMP("TIU137","DUPS"),^TMP("TIU137",$J)
 D SETXTMP^TIUEN137
 N TIUDUPS,TMPCNT,SILENT S TMPCNT=0
 S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)=""
 S TMPCNT=1,^TMP("TIU137",$J,TMPCNT)="         ***** Document Definitions for LABORATORY REPORTS *****"
 S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)=""
 S SILENT=1
 D TIUDUPS^TIUEN137(.TIUDUPS,SILENT)
 ; -- If potential duplicates exist, quit:
 I $G(TIUDUPS) D  G MAINX
 . S ^XTMP("TIU137","DUPS")=1
 . S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="Duplicate problem.  See description for patch TIU*1*137,"
 . S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="in the National Patch Module."
 ; -- Set file data, other data for DDEFS: 
 D SETDATA^TIU137D
 N NUM S NUM=0
 F  S NUM=$O(^XTMP("TIU137","BASICS",NUM)) Q:'NUM  D
 . N IEN,YDDEF,TIUDA
 . ; -- If DDEF was previously created by this patch,
 . ;    say so and quit:
 . S IEN=+$G(^XTMP("TIU137","BASICS",NUM,"DONE"))
 . I IEN D  Q
 . . S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)=^XTMP("TIU137","FILEDATA",NUM,.04)_" "_^XTMP("TIU137","BASICS",NUM,"NAME")
 . . S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="    was already created in a previous install."
 . . K ^XTMP("TIU137","FILEDATA",NUM)
 . . K ^XTMP("TIU137","DATA",NUM)
 . ; -- If not, create new DDEF:
 . S YDDEF=$$CREATE(NUM)
 . I +YDDEF'>0!($P(YDDEF,U,3)'=1) D  Q
 . . S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="Couldn't create a "_^XTMP("TIU137","FILEDATA",NUM,.04)_" named "_^XTMP("TIU137","BASICS",NUM,"NAME")_".",TMPCNT=TMPCNT+1
 . . S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="    Please contact National VistA Support for help."
 . S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)=^XTMP("TIU137","FILEDATA",NUM,.04)_" named "_^XTMP("TIU137","BASICS",NUM,"NAME")
 . S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="    created successfully."
 . S TIUDA=+YDDEF
 . ; -- File field data:
 . D FILE(NUM,TIUDA,.TMPCNT)
 . K ^XTMP("TIU137","FILEDATA",NUM)
 . ; -- Add item to parent:
 . D ADDITEM(NUM,TIUDA,.TMPCNT)
 . K ^XTMP("TIU137","DATA",NUM)
MAINX ;Exit
 S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)=""
 S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="                           *************"
 I '$G(^XTMP("TIU137","DUPS")) D MAIN^USRPS23
 D PRINT
 K ^TMP("TIU137",$J),^TMP("USR23",$J)
 Q
 ;
PRINT ; Print out results
 N TIUCNT,TIUCONT
 I $D(ZTQUEUED) S ZTREQ="@" ; Tell TaskMan to delete Task log entry
 I $E(IOST)="C" W @IOF,!
 S TIUCNT="",TIUCONT=1
 F  S TIUCNT=$O(^TMP("TIU137",$J,TIUCNT)) Q:TIUCNT=""  D  Q:'TIUCONT
 . S TIUCONT=$$SETCONT Q:'TIUCONT
 . W ^TMP("TIU137",$J,TIUCNT),!
 Q:'TIUCONT
 S TIUCNT=""
 F  S TIUCNT=$O(^TMP("USR23",$J,TIUCNT)) Q:TIUCNT=""  D  Q:'TIUCONT
 . S TIUCONT=$$SETCONT Q:'TIUCONT
 . W ^TMP("USR23",$J,TIUCNT),!
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
 I $E(IOST)="C" G SETX:$Y+5<IOSL
 I $E(IOST)="C" S TIUCONT=$$STOP G SETX
 G:$Y+8<IOSL SETX
 W @IOF
SETX Q TIUCONT
 ;
SERIAL ; Serialize Menu Items of Class Clinical Documents
 ;since it has a new item under it
 N DA,DIE,DR,X,Y,D,D0,DI,DQ
 ; -- Reset Sequence, Mnemonic for items of Clinical Docs:
 N TIUI,TIUFPRIV
 S (DA,TIUI)=0,DA(1)=38,TIUFPRIV=1
 S DIE="^TIU(8925.1,DA(1),10,"
 F  S DA=$O(^TIU(8925.1,38,10,DA)) Q:+DA'>0  D
 . S TIUI=TIUI+1,DR="2////^S X=TIUI;3////^S X=TIUI" D ^DIE
 ; -- Re-compile menu for Select CLINICAL DOCUMENTS Type(s),
 ;    under Multiple Patient Documents/Integrated Document Management.
 ;    Updates ^TIU(8925.1,38,99), which triggers ^XUTL update.
 N XQORM,X,Y,ORULT
 S XQORM="38;TIU(8925.1,"
 D XREF^XQORM
 Q
 ;
PARENT(NUM) ; Return IEN of parent new DDEF should be added to
 N PIEN,PNUM
 ; Parent node has form:
 ; -- PIEN node = IEN of parent if known, or if not,
 ;    PNUM node = DDEF# of parent
 ;^XTMP("TIU137","DATA",1,"PIEN")=38
 S PIEN=$G(^XTMP("TIU137","DATA",NUM,"PIEN"))
 ; -- If parent IEN is known, we're done:
 I +PIEN G PARENTX
 ; -- If not, get DDEF# of parent
 S PNUM=$G(^XTMP("TIU137","DATA",NUM,"PNUM"))
 I 'PNUM Q 0
 ; -- Get Parent IEN from "DONE" node, which was set
 ;    when parent was created:
 S PIEN=+$G(^XTMP("TIU137","BASICS",PNUM,"DONE"))
PARENTX Q PIEN
 ;
ADDITEM(NUM,TIUDA,TMPCNT)  ; Add DDEF to Parent; Set item fields
 N PIEN,MENUTXT,TIUFPRIV,TIUFISCR
 N DIE,DR
 S TIUFPRIV=1
 S PIEN=$$PARENT(NUM)
 I 'PIEN!'$D(^TIU(8925.1,PIEN,0))!'$D(^TIU(8925.1,TIUDA,0)) K PIEN G ADDX
 N DA,DIC,DLAYGO,X,Y
 N I,DIY
 S DA(1)=PIEN
 S DIC="^TIU(8925.1,"_DA(1)_",10,",DIC(0)="LX"
 S DLAYGO=8925.14
 ;S X="`"_TIUDA
 ; -- If TIUDA is say, x, and Parent has x as IFN in Item subfile,
 ;    code finds item x under parent instead of creating a new item,
 ;    so don't use "`"_TIUDA:
 S X=^XTMP("TIU137","BASICS",NUM,"NAME")
 ; -- Make sure the DDEF it adds is TIUDA and not another w same name:
 S TIUFISCR=TIUDA ; activates screen on fld 10, Subfld .01 in DD
 D ^DIC I Y'>0!($P(Y,U,3)'=1) K PIEN G ADDX
 ; -- Set Menu Text:
 S MENUTXT=$G(^XTMP("TIU137","DATA",NUM,"MENUTXT"))
 I $L(MENUTXT) D
 . N DA,DIE,DR
 . N D,D0,DI,DQ
 . S DA(1)=PIEN
 . S DA=+Y,DIE=DIC
 . S DR="4////^S X=MENUTXT"
 . D ^DIE
ADDX ; -- Tell user about adding to parent:
 I '$G(PIEN) D
 . S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="  Couldn't add entry to parent.  Please contact National VistA Support"
 . S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="    for help."
 E  S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="  Entry added to parent."
 ; -- If just added Class LR LABORATORY REPORTS to CLINICAL
 ;    DOCUMENTS, serialize menu items of CLIN DOC:
 I NUM=1 D SERIAL
 Q
 ;
FILE(NUM,TIUDA,TMPCNT) ; File fields for new entry TIUDA
 ; Files ALL FIELDS set in "FILEDATA" nodes of ^XTMP:
 ;   ^XTMP("TIU137","FILEDATA",NUM,Field#)
 N TIUFPRIV,FDA,TIUERR
 S TIUFPRIV=1
 M FDA(8925.1,TIUDA_",")=^XTMP("TIU137","FILEDATA",NUM)
 D FILE^DIE("TE","FDA","TIUERR")
 I $D(TIUERR) S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="  Problem filing data for entry. Please contact National VistA Support."
 E  S TMPCNT=TMPCNT+1,^TMP("TIU137",$J,TMPCNT)="  Data for entry filed successfully."
 Q
 ;
CREATE(NUM) ; Create new DDEF entry
 N DIC,DLAYGO,DA,X,Y,TIUFPRIV
 S TIUFPRIV=1
 ;S (DIC,DLAYGO)="^TIU(8925.1,"
 ;-- CACHE won't take global root for DLAYGO; use file number:
 S DIC="^TIU(8925.1,",DLAYGO=8925.1
 S DIC(0)="LX",X=^XTMP("TIU137","BASICS",NUM,"NAME")
 S DIC("S")="I $P(^(0),U,4)="_""""_^XTMP("TIU137","BASICS",NUM,"INTTYPE")_""""
 D ^DIC
 ; -- If DDEF was just created, set "DONE" node = IEN
 I $P(Y,U,3)=1 S ^XTMP("TIU137","BASICS",NUM,"DONE")=+$G(Y)
 Q $G(Y)
