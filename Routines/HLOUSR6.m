HLOUSR6 ;OAK/RBN -ListManager screen for reporting outbound queues;12 JUN 1997 10:00 am ;07/02/2010
 ;;1.6;HEALTH LEVEL SEVEN;**138,146,147**;Oct 13, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
EN ; Created list of outbound queues.
 N HLRFRSH,OLDRFRSH
 S OLDRFRSH=$G(HLRFRSH)
 D WAIT^DICD
 D EN^VALM("HLO DISPLAY OUT-GOING QUEUES")
 S HLRFRSH=OLDRFRSH
 I $L(HLRFRSH) D @HLRFRSH
 S VALMBCK="R"
 Q
 ;
INIT ; -- init variables and list array
 D OUTQUE
 D HDR
 D SHOW^VALM
 S VALMBCK="R"
 Q
 ;
HDR ; Header info. for the outbound queue display.
 N COUNT,LINK,QUE,FROM,TIME,STATUS,TEMP,DIR,TODAY,LIST,HLSCREEN
 S HLRFRSH="OUTQUE^HLOUSR6"
 S HLSCREEN="HLO Outbound Queues"
 S VALM("TITLE")="HLO Outbound Queues"
 S VALMSG="Outgoing Queues *down links !stopped queues"
 ;;; START HL*1.6*147  RBN - Commmented the next line out - prevents list from scrolling.
 ;S VALMCNT=16
 ;;; End HL*1.6*147
 S VALMBG=1
 S VALMDDF("COL 1")="COL1^1^80^"
 K VALMDDF("COL 2"),VALMDDF("COL 3"),VALMDDF("COL 4"),VALMDDF("COL 5")
 Q
 ;
OUTQUE ;
 N LINK,TOP,COUNT,LINE
 F LINE=1:1:16 D SET^VALM10(LINE,"")
 S VALMCNT=0
 S HLRFRSH="OUTQUE^HLOUSR6"
 S VALMAR="^TMP(""HLO OUTBOUND QUEUES"",$J)"
 S VALMBCK="R"
 S VALMDDF("COL 1")="COL 1^2^20^ Link^H"
 ;
 ;**p147 start cjm
 ;S VALMDDF("COL 2")="COL 2^28^20^Queue^H"
 S VALMDDF("COL 2")="COL 2^26^20^Queue/Priority^H"
 ;**P147 END CJM
 ;
 S VALMDDF("COL 3")="COL 3^50^20^Count^H"
 S VALMDDF("COL 4")="COL 4^65^20^Top Message^H"
 K VALMDDF("COL 5")
 D CHGCAP^VALM("COL 1"," Link")
 S LINK=""
 F  S LINK=$O(^HLC("QUEUECOUNT","OUT",LINK)) Q:LINK=""  D
 .N COUNT,QUE,SHOW
 .S SHOW=LINK
 .I $D(^HLTMP("FAILING LINKS",SHOW)) S SHOW="*"_SHOW
 .S (TOP,QUE)=""
 .F  S QUE=$O(^HLC("QUEUECOUNT","OUT",LINK,QUE)) Q:QUE=""  D
 ..S COUNT=$G(^HLC("QUEUECOUNT","OUT",LINK,QUE))
 ..Q:COUNT<1
 ..S VALMCNT=VALMCNT+1
 ..S TOP=$$GETTOP()
 ..I $E(SHOW)="*" D
 ...S @VALMAR@(VALMCNT,0)=$$LJ(SHOW,20)_$$CJ($S($$STOPPED^HLOQUE("OUT",QUE):"!",1:"")_QUE_"/"_$$GETPRTY^HLOQUE(QUE,LINK),21)_"   "_$$RJ(COUNT,10)_$$RJ(TOP,20),SHOW="   "
 ...D CNTRL^VALM10(VALMCNT,1,1,IOBON,IOBOFF)
 ..E  S @VALMAR@(VALMCNT,0)=$$LJ(SHOW,20)_$$CJ($S($$STOPPED^HLOQUE("OUT",QUE):"!",1:"")_QUE_"/"_$$GETPRTY^HLOQUE(QUE,LINK),21)_"   "_$$RJ(COUNT,10)_$$RJ(TOP,20),SHOW="   "
 S VALMBCK="R"
 Q
 ;
CJ(STRING,LEN) ;
 Q $$CJ^XLFSTR($E(STRING,1,LEN),LEN)
LJ(STRING,LEN) ;
 Q $$LJ^XLFSTR($E(STRING,1,LEN),LEN)
RJ(STRING,LEN) ;
 Q $$RJ^XLFSTR($E(STRING,1,LEN),LEN)
 ;
CLEAN ; Clean up before leaving
 K ^TMP("HLO OUTBOUND QUEUES",$J)
 Q
 ;
GETTOP() ; Get top message in queue
 N TOP,QUIT
 S (TOP,QUIT)=0
 F  S TOP=$O(^HLB("QUEUE","OUT",LINK,QUE,TOP)) Q:'TOP  D  Q:QUIT
 .N NODE
 .S NODE=$G(^HLB(TOP,0))
 .I NODE="" K ^HLB("QUEUE","OUT",LINK,QUE,TOP) Q
 .S TOP=$P(NODE,"^",1),QUIT=1
 Q TOP
 ;
DELTOP ; Deletes the top message on a queue
 N CONF,HLOLNAM,HLOQNAM,LOCERR,TOP,LINKNAME,PORT,ERROR
 S VALMBCK="R"
 D OWNSKEY^XUSRB(.CONF,"HLOMGR",DUZ)
 I CONF(0)'=1 D  Q
 . W !,"**** You are not authorized to use this option ****" D PAUSE^VALM1
 ;**P146 START CJM
 ;S LOCERR=$$GETLNK^HLOAPI5()
 ;Q:($G(LOCERR)="Q")
 ;I $G(LOCERR)=-1 W !,"Sorry, that was an invalid link" D PAUSE^VALM1 Q
 S LINKNAME=$$ASKLINK^HLOUSR
 I LINKNAME="" W !,"Sorry, that is are no messages pending on that link." D PAUSE^VALM1 Q
 D
 .N PORT2
 .S ERROR=0
 .S PORT=$O(^HLB("QUEUE","OUT",LINKNAME_":"))
 .I ($P(PORT,":")'=LINKNAME) S PORT="" Q
 .S PORT2=$O(^HLB("QUEUE","OUT",LINKNAME_":"_$P(PORT,":",2)))
 .I ($P(PORT2,":")'=LINKNAME) S PORT=$P(PORT,":",2) Q
 .S PORT=$$ASKPORT^HLOUSRA(LINKNAME)
 .I 'PORT S ERROR=1
 Q:ERROR
 S HLOLNAM=LINKNAME_":"_PORT
 ;S LOCERR=$$GETQUE^HLOAPI5()
 ;I $G(LOCERR)="Q" Q
 ;I $G(LOCERR)=-1 W !,"Sorry, that was an invalid queue" D PAUSE^VALM1 Q
 S HLOQNAM=$$ASKQUE(HLOLNAM)
 Q:HLOQNAM=""
 L +^HLB("QUEUE","OUT",HLOLNAM,HLOQNAM):5 D
 .I '$T W !,"That queue is currently locked, please try again later." D PAUSE^VALM1 Q
 .D
 ..S TOP=$O(^HLB("QUEUE","OUT",HLOLNAM,HLOQNAM,""))
 ..I 'TOP W !,"There are no messages pending on that queue!" D PAUSE^VALM1 Q
 ..Q:'$$ASKYESNO^HLOUSR2("Are you SURE you want to dequeue MsgID: "_$$MSGID^HLOPRS(TOP),"NO")
 ..;Q:$$VERIFY^HLOQUE1()=-1
 ..D DEQUE^HLOQUE(HLOLNAM,HLOQNAM,"OUT",TOP)
 ..D OUTQUE
 ..;
 .L -^HLB("QUEUE","OUT",HLOLNAM,HLOQNAM)
 ;K ^HLB("QUEUE","OUT",HLOLNAM,HLOQNAM,TOP)
 ;S ^HLC("QUEUECOUNT","OUT",HLOLNAM,HLOQNAM)=^HLC("QUEUECOUNT","OUT",HLOLNAM,HLOQNAM)-1
 ;S:^HLC("QUEUECOUNT","OUT",HLOLNAM,HLOQNAM)<0 ^HLC("QUEUECOUNT","OUT",HLOLNAM,HLOQNAM)=0
 ;D OUTQUE
 ;**P146 END CJM
 Q
 ;
 ;
 ;**P146 START CJM
ASKQUE(LINK) ;
 ;Input: LINK=<link>:<port>
 ;Ouput: function returns the queue name, or "" if not selected
 N X,QUE,Y,DUOUT,DEFAULT
 S DIR(0)="F"
 S DIR("A")="Enter queue name "
 S DEFAULT=$O(^HLB("QUEUE","OUT",LINK,""))
 I DEFAULT="" S DEFAULT="DEFAULT"
 S DIR("B")=DEFAULT
 S DIR("?",1)="Enter the queue name as displayed in the HLO System Monitor"
 S DIR("?",2)="                 Outgoing Queue display."
 D ^DIR
 K DIR
 I $G(DUOUT)!(Y="") Q ""
 Q Y
 ;**P146 END CJM
