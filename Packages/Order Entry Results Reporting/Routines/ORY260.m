ORY260 ; SLC/STAFF - Patch OR*3.0*260 post init ;8/21/06  13:13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**260**;Dec 17, 1997;Build 26
POST ; post-init to patch OR*3.0*260
 ; fix any string formatted date/times in CR index
 ; remove Treatment type from graphing
 N DA,DIR,ORMSG,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE K DIR,ORMSG
 S ORMSG(1)="A task is being queued in the background to identify"
 S ORMSG(2)="any Start or Start dates where times have trailing zeros."
 S ORMSG(3)=""
 S ORMSG(4)="These indexes will be reset with the correct canonic"
 S ORMSG(5)="values by this background job. A mail message will be"
 S ORMSG(6)="sent to the initiator of this patch at completion."
 S ORMSG(7)=""
 S ORMSG(8)=""
 S ZTRTN="DQ^ORY260",ZTIO=""
 S ZTDESC="Clean up - Patch 260",ZTDTH=$H,ZTSAVE("DUZ")=""
 D ^%ZTLOAD
 S ORMSG(9)="The task number is "_$G(ZTSK)
 D MES^XPDUTL(.ORMSG) I '$D(ZTQUEUED) D
 . N DIR,Y
 . S DIR(0)="E",DIR("A")="Press return - installation is complete."
 . D ^DIR
 Q
 ;
DQ ; dequeued
 N BEGIN,CNT,DFN,ITEM,NODE,OK,START,STOP K ^TMP("ORPXRM",$J),^TMP("ORTXT",$J)
 S BEGIN=$$NOW^XLFDT
 S CNT=0
 S DFN=0
 F  S DFN=$O(^PXRMINDX(100,"PI",DFN)) Q:DFN<1  D
 . S ITEM=0
 . F  S ITEM=$O(^PXRMINDX(100,"PI",DFN,ITEM)) Q:ITEM<1  D
 .. S START=""
 .. F  S START=$O(^PXRMINDX(100,"PI",DFN,ITEM,START)) Q:START=""  D
 ... S STOP=""
 ... F  S STOP=$O(^PXRMINDX(100,"PI",DFN,ITEM,START,STOP)) Q:STOP=""  D
 .... S OK=1
 .... I START'=+START S OK=0
 .... I OK,$E(STOP)'="U",STOP'=+STOP S OK=0
 .... I OK Q
 .... S NODE=""
 .... F  S NODE=$O(^PXRMINDX(100,"PI",DFN,ITEM,START,STOP,NODE)) Q:NODE=""  D
 ..... S ^TMP("ORPXRM",$J,NODE)=DFN_U_ITEM_U_START_U_STOP
 ..... S CNT=CNT+1
 ..... ;W !,NODE,?20,$P($G(^OR(100,+NODE,0)),U,8),?35,$P($G(^OR(100,+NODE,0)),U,9),?55,START
 S ^TMP("ORTXT",$J,4)="-- "_CNT_" nodes to check --" ; overwrite on finish
 S ^TMP("ORTXT",$J,5)=" "
 S CNT=5
 S NODE=""
 F  S NODE=$O(^TMP("ORPXRM",$J,NODE)) Q:NODE=""  D
 . D FIX(NODE,.CNT)
 S ^TMP("ORTXT",$J,4)="-- "_(CNT-5)_" changes made --"
 K ^TMP("ORPXRM",$J)
 D TREMOVE("ORWG GRAPH VIEW") ; removes treatment type from graphing
 D MAIL(BEGIN)
 K ^TMP("ORTXT",$J)
 Q
 ;
FIX(NODE,CNT) ;
 N DA,DATE1,DATE2,DFN,DIE,DR,ITEM,LINE,START,STOP,VALUES,ZERO
 S VALUES=$G(^TMP("ORPXRM",$J,NODE))
 S DFN=$P(VALUES,U)
 S ITEM=$P(VALUES,U,2)
 S DATE1=$P(VALUES,U,3)
 S DATE2=$P(VALUES,U,4)
 K ^PXRMINDX(100,"PI",DFN,ITEM,DATE1,DATE2,NODE)
 K ^PXRMINDX(100,"IP",ITEM,DFN,DATE1,DATE2,NODE)
 S DIE="^OR(100,"
 S DA=+NODE
 S ZERO=$G(^OR(100,DA,0))
 S START=+$P(ZERO,U,8) I START=0 S START="@"
 S STOP=+$P(ZERO,U,9) I STOP=0 S STOP="@"
 S DR=""
 I START'=DATE1 S DR="21///"_START
 I START="@",$P(ZERO,U,8)="" S DR=""
 I STOP'=DATE2 D
 . I STOP="@",$E(DATE2)="U" Q
 . I $L(DR) S DR=DR_";22///"_STOP Q
 . S DR="22///"_STOP Q
 I '$L(DR) Q
 S LINE="Node: "_NODE
 I DR["21///" S LINE=LINE_"; Start: "_DATE1_" -> "_START
 I DR["22///" S LINE=LINE_"; Stop: "_DATE2_" -> "_STOP
 D ^DIE
 S CNT=CNT+1
 S ^TMP("ORTXT",$J,CNT)=LINE
 Q
 ;
TREMOVE(PARAM) ;
 N ENTITY,INST,LINES,OK,VALUES K LINES,VALUES
 D XENVAL^ORWGAPIX(.VALUES,PARAM)
 I '$L($O(VALUES(""))) Q
 S ENTITY=""
 F  S ENTITY=$O(VALUES(ENTITY)) Q:ENTITY=""  D
 . S INST=""
 . F  S INST=$O(VALUES(ENTITY,INST)) Q:INST=""  D
 .. D XGETWP^ORWGAPIX(.LINES,ENTITY,PARAM,INST)
 .. D FIXLINES(.LINES,.OK)
 .. I 'OK D FIXIT(.LINES,ENTITY,PARAM,INST)
 Q
 ;
FIXLINES(LINES,OK) ;
 N I,LINE,NLINE,NLINES,NNUM,NUM,PART K NLINES
 S OK=1,NNUM=0
 S NUM=0
 F  S NUM=$O(LINES(NUM)) Q:NUM<1  D
 . S LINE=$G(LINES(NUM,0))
 . I '$L(LINE) Q
 . S NLINE=LINE
 . I LINE["~9000010.15" D
 .. S NLINE="",OK=0
 .. F I=1:1:999 S PART=$P(LINE,"|",I) Q:PART=""  D
 ... I PART["~9000010.15" Q
 ... S NLINE=NLINE_PART_"|"
 . I NLINE="" Q
 . S NNUM=NNUM+1
 . S NLINES(NNUM,0)=NLINE
 I OK Q
 K LINES
 M LINES=NLINES
 Q
 ;
FIXIT(LINES,ENTITY,PARAM,INST) ;
 D XDEL^ORWGAPIX(ENTITY,PARAM,INST)
 I $L($O(LINES(""))) D XEN^ORWGAPIX(ENTITY,PARAM,INST,.LINES)
 Q
 ;
MAIL(BEGIN) ; -- Send completion message to user who initiated cleanup
 N TIMES,XMSUB,XMTEXT,XMDUN,XMDUZ,XMY,XMZ K XMY
 S XMDUZ="PATCH OR*3.0*260 CLEAN-UP",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S TIMES="Started: "_$$FMTE^XLFDT(BEGIN)_"; Completed: "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S ^TMP("ORTXT",$J,1)="Clean up for patch OR*3.0*260"
 S ^TMP("ORTXT",$J,2)=TIMES
 S ^TMP("ORTXT",$J,3)="Order Node Date Cleanup:"
 S XMTEXT="^TMP(""ORTXT"","_$J_","
 S XMSUB="PATCH OR*3.0*260 Clean Up COMPLETED"
 D ^XMD
 Q
