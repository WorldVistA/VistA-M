XULMUI ;IRMFO-ALB/CJM/SWO/RGG - KERNEL LOCK MANAGER ;10/24/2012
 ;;8.0;KERNEL;**608**;JUL 10, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 ;  ******************************************************************
 ;  *                                                                *
 ;  *  The Kernel Lock Manager is based on the VistA Lock Manager    *
 ;  *        developed by Tommy Martin.                              *
 ;  *                                                                *
 ;  ******************************************************************
 ;
 ;
REFRESH ;
 K @LOCKS,@IDX
 Q:'$$GETLOCKS^XULM(.XUPARMS)
 I $D(XUPARMS("LAST ACTION")) D
 .D @XUPARMS("LAST ACTION")
 E  D BYPAT
 Q
BYLOCK ; display user locks sorted by lock
 N LOCK,XUTOPIC
 S XUTOPIC="LOCK"
 S XUPARMS("LAST ACTION")="BYLOCK^XULMUI"
 S VALMCNT=0
 D CLEAN^VALM10
 S VALMBG=1
 S VALMSG="User Locks Sorted by Lock   ["_$S($L($G(XUPARMS("SELECTED NODE"))):$$LAST8(XUPARMS("SELECTED NODE")),1:"ALL NODES")_"]"
 D HDR("Lock",35,"Node",8,"User",13,"Patient",25)
 S LOCK=""
 F  S LOCK=$O(@LOCKS@(LOCK)) Q:LOCK=""  D
 .N NODE
 .S NODE=""
 .F  S NODE=$O(@LOCKS@(LOCK,NODE)) Q:NODE=""  Q:$D(XUPARMS("SELECTED NODE"))&'(NODE=$G(XUPARMS("SELECTED NODE")))  I '$G(@LOCKS@(LOCK,NODE,"SYSTEM")) D
 ..D NEWENTRY(LOCK,NODE,LOCK,35,$$LAST8(NODE),8,$P(@LOCKS@(LOCK,NODE,"OWNER"),"^",2),13,$$GETID(LOCK,NODE,2),25)
 ;
 S VALMBCK="R"
 Q
 ;
SYSTEM ; display system locks sorted by lock
 N LOCK
 I '$$KCHK^XUSRB("XULM SYSTEM LOCKS") D  Q 
 . W *7,!!!,?10,"***You are not authorized to view SYSTEM LOCKS***" H 5
 . S VALMBCK="R"
 S XUPARMS("LAST ACTION")="SYSTEM^XULMUI"
 S XUTOPIC="LOCK"
 S VALMCNT=0
 D CLEAN^VALM10
 S VALMBG=1
 S VALMSG="System Locks Sorted by Lock   ["_$S($L($G(XUPARMS("SELECTED NODE"))):$$LAST8(XUPARMS("SELECTED NODE")),1:"ALL NODES")_"]"
 D HDR("Lock",50,"Node",8,"User",15)
 S LOCK=""
 F  S LOCK=$O(@LOCKS@(LOCK)) Q:LOCK=""  D
 .N NODE
 .S NODE=""
 .F  S NODE=$O(@LOCKS@(LOCK,NODE)) Q:NODE=""  Q:$D(XUPARMS("SELECTED NODE"))&'(NODE=$G(XUPARMS("SELECTED NODE")))  I $G(@LOCKS@(LOCK,NODE,"SYSTEM")) D
 ..D NEWENTRY(LOCK,NODE,LOCK,50,$$LAST8(NODE),8,$P(@LOCKS@(LOCK,NODE,"OWNER"),"^",2),15)
 ;
 S VALMBCK="R"
 Q
 ;
GOTO ;Jumps to a location on the screen
 S VALMBG=$$ASKWHERE(XUTOPIC)
 S VALMBCK="R"
 Q
 ;
BYUSER ; display list sorted by user
 N LOCK,USER
 S XUPARMS("LAST ACTION")="BYUSER^XULMUI"
 S XUTOPIC="USER"
 D HDR("User",14,"Lock",33,"Node",8,"Patient",25)
 S VALMCNT=0
 S VALMBG=1
 D CLEAN^VALM10
 S VALMSG="User Locks Sorted by User Name   ["_$S($L($G(XUPARMS("SELECTED NODE"))):$$LAST8(XUPARMS("SELECTED NODE")),1:"ALL NODES")_"]"
 S USER=""
 ;
 F  S USER=$O(@IDX@("OWNER",USER)) Q:USER=""  D
 .S LOCK=""
 .F  S LOCK=$O(@IDX@("OWNER",USER,LOCK)) Q:LOCK=""  D
 ..N NODE
 ..S NODE=""
 ..F  S NODE=$O(@IDX@("OWNER",USER,LOCK,NODE)) Q:NODE=""  Q:$D(XUPARMS("SELECTED NODE"))&'(NODE=$G(XUPARMS("SELECTED NODE")))  Q:$G(@LOCKS@(LOCK,NODE,"SYSTEM"))  D
 ...D NEWENTRY(LOCK,NODE,$P(@LOCKS@(LOCK,NODE,"OWNER"),"^",2),14,LOCK,33,$$LAST8(NODE),8,$$GETID(LOCK,NODE,2),25)
 S VALMBCK="R"
 Q
 ;
BYPAT ; display list sorted by Patient
 N LOCK,USER,PAT
 S XUPARMS("LAST ACTION")="BYPAT^XULMUI"
 S XUTOPIC="PATIENT"
 D HDR("Patient",15,"Lock",33,"Node",8,"User",15)
 S VALMCNT=0
 S VALMBG=1
 D CLEAN^VALM10
 K @IDX@("FILE/ID")
 S VALMSG="User Locks Sorted by Patient Name   ["_$S($L($G(XUPARMS("SELECTED NODE"))):$$LAST8(XUPARMS("SELECTED NODE")),1:"ALL NODES")_"]"
 S LOCK=""
 F  S LOCK=$O(@LOCKS@(LOCK)) Q:LOCK=""  D
 .S NODE=""
 .F  S NODE=$O(@LOCKS@(LOCK,NODE)) Q:NODE=""  Q:NODE=""  Q:$D(XUPARMS("SELECTED NODE"))&'(NODE=$G(XUPARMS("SELECTED NODE")))  I '$G(@LOCKS@(LOCK,NODE,"SYSTEM")) D
 ..S PAT=$$GETID(LOCK,NODE,2) S:PAT="" PAT="{?}"
 ..S @IDX@("FILE/ID",PAT,LOCK,NODE)=""
 S PAT=""
 F  S PAT=$O(@IDX@("FILE/ID",PAT)) Q:PAT=""  D
 .S LOCK=""
 .F  S LOCK=$O(@IDX@("FILE/ID",PAT,LOCK)) Q:LOCK=""  D
 ..N NODE
 ..S NODE=""
 ..F  S NODE=$O(@IDX@("FILE/ID",PAT,LOCK,NODE)) Q:NODE=""  Q:$D(XUPARMS("SELECTED NODE"))&'(NODE=$G(XUPARMS("SELECTED NODE")))  D
 ...D NEWENTRY(LOCK,NODE,PAT,15,LOCK,33,$$LAST8(NODE),8,$P(@LOCKS@(LOCK,NODE,"OWNER"),"^",2),25)
 S VALMBCK="R"
 Q
 ;
SLCTFILE() ;Select a file reference to screen locks by
 D FULL^VALM1
 W !
 N NAME,FILE,I,FILES
 S (FILE,I)=0
 F  S FILE=$O(@IDX@("FILE",FILE)) Q:'FILE  D
 .S NAME=$P($G(^DIC(FILE,0)),"^")
 .I $L(NAME) D
 ..S I=I+1
 ..S FILES(I)=FILE
 ..W !,$$LJ("("_I_")",8),NAME," File (#"_FILE_")"
 I 'I D PAUSE^XULMU("There are no file references available!") Q 0
 W !
 S DIR(0)="NO^"_1_":"_I_":0"
 S DIR("A")="Select a file from the list: "
 I I>0 S DIR("B")=1
 S DIR("?")="Enter the number of an entry on the screen to select a file."
 D ^DIR
 ;
 I +Y Q $G(FILES(+Y))
 Q 0
 ;
BYFILE(FILE) ; Display locks that have a computable references to a particular file
 N LOCK,USER
 S XUPARMS("LAST ACTION")="BYFILE^XULMUI("_FILE_")"
 I FILE D
 .N FID
 .S XUTOPIC="PATIENT"
 .D CLEAN^VALM10
 .D HDR("Patient",15,"User",14,"Node",8,"LOCK",60)
 .S VALMSG="User Locks Related to the "_$P($G(^DIC(FILE,0)),"^")_" File"
 .K @IDX@("FILE/ID")
 .S VALMCNT=0
 .S VALMBG=1
 .S LOCK=""
 .F  S LOCK=$O(@IDX@("FILE",FILE,LOCK)) Q:LOCK=""  D
 ..N NODE S NODE=""
 ..F  S NODE=$O(@IDX@("FILE",FILE,LOCK,NODE)) Q:NODE=""  Q:$D(XUPARMS("SELECTED NODE"))&'(NODE=$G(XUPARMS("SELECTED NODE")))  S FID=$$GETID(LOCK,NODE,2) S:FID="" FID="?" S @IDX@("FILE/ID",FID,LOCK,NODE)=""
 .S FID=""
 .F  S FID=$O(@IDX@("FILE/ID",FID)) Q:FID=""  D
 ..S LOCK=""
 ..F  S LOCK=$O(@IDX@("FILE/ID",FID,LOCK)) Q:LOCK=""  D
 ...N NODE S NODE=""
 ...F  S NODE=$O(@IDX@("FILE/ID",FID,LOCK,NODE)) Q:NODE=""  Q:NODE=""  Q:$D(XUPARMS("SELECTED NODE"))&'(NODE=$G(XUPARMS("SELECTED NODE")))  D
 ....D NEWENTRY(LOCK,NODE,FID,15,$P(@LOCKS@(LOCK,NODE,"OWNER"),"^",2),14,$$LAST8(NODE),8,LOCK,60)
 S VALMBCK="R"
 Q
ASKWHERE(TOPIC) ;Asks the user where to jump to.
 N Y,DIR,DIRUT,RESPONSE,GOTO,WHERETO
 W !!,"Are you looking for a specific "_TOPIC_"?"
 W !,"If so, enter the "_TOPIC_", or the first few letters of "_TOPIC_"."
 S DIR("A")=TOPIC_": "
 S DIR(0)="FOA^1:45"
 D ^DIR
 I $D(DIRUT),(TOPIC'="LOCK")!(Y="^") Q VALMBG
 I TOPIC'="LOCK" S Y=$$UP^XLFSTR(Y)
 S WHERETO=Y
 I WHERETO="" Q 1
 S GOTO=$O(@VALMAR@("IDX1",WHERETO))
 I $E(GOTO,1,$L(WHERETO))'=WHERETO S GOTO=$O(@VALMAR@("IDX1",GOTO),-1)
 I $L(GOTO) D
 .S VALMBG=+$G(@VALMAR@("IDX1",GOTO))
 E  S VALMBG=1
 Q VALMBG
 ;
 ;
NEWENTRY(LOCK,NODE,COL1,W1,COL2,W2,COL3,W3,COL4,W4) ;
 N TEMP
 S:$G(COL1)="{?}" COL1=" "
 S:$G(COL2)="{?}" COL2=" "
 S:$G(COL3)="{?}" COL3=" "
 S:$G(COL4)="{?}" COL3=" "
 S @VALMAR@($$I,0)=$$RJ(VALMCNT,4)_" "_$$LJ($E(COL1,1,W1),W1)_"  "_$$LJ($E($G(COL2),1,$G(W2)),$G(W2))_"  "_$$LJ($E($G(COL3),1,$G(W3)),$G(W3))_"  "_$$LJ($E($G(COL4),1,$G(W4)),$G(W4))
 D CNTRL^VALM10(VALMCNT,1,5,IOINHI,IOINORM)
 S TEMP=$G(@VALMAR@("IDX1",COL1))
 I ('TEMP)!(VALMCNT<TEMP) S @VALMAR@("IDX1",COL1)=VALMCNT
 S @VALMAR@("IDX2",VALMCNT)=NODE_"|XULM|"_LOCK
 Q
 ;
GETID(LOCK,NODE,FILE) ;gets first ID for sorting purposes.
 ;
 N ID,TEMPLATE,VARS,FILES
 S TEMPLATE=$G(@LOCKS@(LOCK,NODE,"TEMPLATE"))
 Q:'TEMPLATE ""
 S FILES(FILE)=$G(@LOCKS@(LOCK,NODE,"FILES",FILE))
 Q:'FILES(FILE) ""
 M VARS=@LOCKS@(LOCK,NODE,"VARIABLES")
 D GETREFS^XULMLD(TEMPLATE,.FILES,.VARS)
 Q $S($D(FILES(FILE,1)):$P(FILES(FILE,1),":",2,5),1:"?")
 ;
ADDLINE(LINE) ;
 N LIN
 S LIN="    "_LINE
 D ADD(LINE)
 Q
ADD(LINE) ;
 S @VALMAR@($$I,0)=LINE
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 Q
SELECT ;
 N START,END,DIR,XULMLOCK,Y,XULMNODE,XULMEXIT
 S START=$G(@VALMAR@("IDX1",VALMBG),1)
 I START,$G(@VALMAR@("IDX1",(VALMBG-1)))=START,(START+1)'>VALMCNT S START=START+1
 S END=$G(@VALMAR@("IDX1",VALMBG+17))
 I 'END S END=VALMCNT
 I START,START=END S Y=START
 E  D
 .S DIR(0)="NO^"_START_":"_END_":0"
 .S DIR("A")="Select a lock: "
 .S DIR("?")="Enter the number of an entry on the screen to select a lock."
 .D ^DIR
 ;
 I +Y D
 .N X
 .S X=@VALMAR@("IDX2",+Y)
 .S XULMNODE=$P(X,"|XULM|")
 .S XULMLOCK=$P(X,"|XULM|",2)
 .S XUPARMS("KILL")=0
 .D EN^VALM("XULM DISPLAY SINGLE LOCK")
 .I $G(XUPARMS("KILL")),'$G(XULMEXIT) K XUPARMS("KILL") D REFRESH
 S VALMBCK=$S($G(XULMEXIT):"Q",1:"R")
 Q
 ;
 ;
SLCTNODE ;
 N NODE,DIR
 S NODE(0)=1,NODE(1)="ALL NODES"
 S NODE=""
 F  S NODE=$O(XUPARMS("REPORTING NODES",NODE)) Q:NODE=""  S NODE(0)=NODE(0)+1,NODE(NODE(0))=NODE
 D FULL^VALM1
 W !!,"You can display locks from all the nodes or a single node."
 F I=1:1:NODE(0) S DIR("A",I)="["_I_"]   "_NODE(I)
 S NODE(0)=NODE(0)+1
 S DIR("A",NODE(0))=" "
 S DIR(0)="NO^"_1_":"_NODE(0)_":0"
 S DIR("A")="Select a node"
 S DIR("?")="Enter a number to select a node."
 S DIR("B")=1
 D ^DIR
 I +Y D
 .I +Y=1 K XUPARMS("SELECTED NODE")
 .I +Y>1,+Y<NODE(0) S XUPARMS("SELECTED NODE")=$G(NODE(+Y))
 .D:$D(XUPARMS("LAST ACTION")) @XUPARMS("LAST ACTION")
 S VALMBCK="R"
 Q
 ;
 ;
LJ(STRING,LEN) ;
 Q $$LJ^XLFSTR(STRING,LEN)
RJ(STRING,LEN) ;
 Q $$RJ^XLFSTR(STRING,LEN)
 ;
I() ;
 S VALMCNT=VALMCNT+1
 Q VALMCNT
 ;
 ;
HELP ; -- help code
 N COUNT,LINE
 D CLEAR^VALM1
 F COUNT=1:1:19 S LINE=$T(HLPTEXT+COUNT) W !,$P(LINE,";",3,9)
 W !!!
 D:'$$PAUSE^XULMU
 .W @IOF
 .F COUNT=20:1:35 S LINE=$T(HLPTEXT+COUNT) W !,$P(LINE,";",3,9)
 .W !!!!!!
 .D PAUSE^XULMU
 D RE^VALM4
 Q
 ;
HDR(COL1,W1,COL2,W2,COL3,W3,COL4,W4) ;
 S VALMCAP="  #  "_$$LJ($G(COL1),W1)_"  "_$$LJ($G(COL2),$G(W2))_"  "_$$LJ($G(COL3),$G(W3))_"  "_$$LJ($G(COL4),$G(W4))_"                           "
 Q
 ;
OPTIONS ;Give options for how the lock list should be displayed.
 N DIR
 D FULL^VALM1
 S DIR(0)="S^1:Sort List by Patient Name;2:Sort List by User Name;3:Sort List by Lock;4:Screen List by File Reference"
 S DIR("A")="Select a display option: "
 ;S DIR("A",#)=""
 S DIR("B")=1
 S DIR("?",1)="   [1]  - Sorts the list of user locks by patient name."
 S DIR("?",2)=""
 S DIR("?",3)="   [2]  - Sorts the list of user locks by user name."
 S DIR("?",4)=""
 S DIR("?",5)="   [3]  - Sorts the list of user locks by the lock string."
 S DIR("?",6)=""
 S DIR("?",7)="   [4]  - Diplays only those user locks that reference the specific file"
 S DIR("?",8)="          that you select, sorted by patient name."
 S DIR("?",9)=" "
 S DIR("?")=" *System locks are not included in the display list."
 D ^DIR
 D
 .I Y=1 D BYPAT Q
 .I Y=2 D BYUSER Q
 .I Y=3 D BYLOCK Q
 .I Y=4 D  Q
 ..N FILE
 ..S FILE=$$SLCTFILE
 ..I FILE D BYFILE(FILE)
 S VALMBCK="R"
 ;
 ;
 ;
LAST8(STRING) ;
 I $L(STRING)>8,$L($G(XUPARMS("NODES",STRING,"SHORT NAME"))) Q $G(XUPARMS("NODES",STRING,"SHORT NAME"))
 N LEN
 S LEN=$L(STRING)
 Q $E(STRING,$S(LEN>8:LEN-7,1:1),LEN)
 ;
 ;;
HLPTEXT ;;
 ;;Select an action from the bottom of the screen. 
 ;;
 ;;Enter '??' to see additional actions that are available.
 ;;
 ;;SL - This action will prompt you to select a lock by its number on the list.
 ;;     It will then display additional information about the lock and the
 ;;     process that holds the lock. 
 ;;
 ;; 
 ;;GO  -This action asks where you want to go to on the list and then shifts
 ;;     the display to that location.
 ;;
 ;;
 ;;RL - This action will rebuild the list of locks displayed on the screen.
 ;;     Active locks usually change from moment to moment, but users of the
 ;;     Lock Manager are generally only interested in those locks that are
 ;;     being improperly held for prolonged periods of time.
 ;;
 ;;
 ;;SYS - This action will display only system locks.  System locks are
 ;;     those locks set by the Kernel, HL7, and other infrastructure packages.
 ;;
 ;;
 ;;
 ;;SS - This action provides several options for how the list locks should be
 ;;     displayed.  The options include sorting the list by patient name, sorting
 ;;     the list by the user name, sorting the list by the lock string, and
 ;;     screening the entries by lock reference, which means that only locks
 ;;     that relate to that specific file will be included in the display.
 ;;
 ;;
 ;;SN - This action allows the user to select either a single computer node or
 ;;     all the computer nodes.  If the user selects a single node then the display
 ;;     of locks will include only locks placed by processess running on that node.  
 ;;
 ;; 
 ;;
 ;;
 ;; 
ENDHELP ;;END
