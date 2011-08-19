HLOUSR5 ;OAK/RBN -ListManager screen for reporting sequence queues;12 JUN 1997 10:00 am ;07/10/2008
 ;;1.6;HEALTH LEVEL SEVEN;**138**;Oct 13, 1995;Build 34
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
EN ;
 K HLPARMS ;not newed so they'll be left for realtime mode
 N OLDRFRSH
 S OLDRFRSH=$G(HLRFRSH)
 D CLEAN^VALM10
 D FULL^VALM1
 S HLRFRSH="SEARCH^HLOUSR4(.HLPARMS)"
 I '$$ASK(.HLPARMS) S VALMBCK="R" Q
 D EN^VALM("HLO SEQUENCE QUEUES")
 S HLRFRSH=OLDRFRSH
 I $L(HLRFRSH) D @HLRFRSH
 Q
HDR ;
 S (HLSCREEN,VALMSG)="Outbound Queues"
 Q
 ;
SEARCH(HLPARMS) ;
 N MIN,LATEONLY,NS,QUE,ARY,COUNT,NOW,IEN,TIME,NODE
 S MIN=+$G(HLPARMS("MIN")),LATEONLY=+$G(HLPARMS("LATEONLY")),NS=$G(HLPARMS("NS"))
 S VALMCNT=0
 S NOW=$$NOW^XLFDT
 D CLEAN^VALM10
 ;
 S ARY="^HLB(""QUEUE"",""SEQUENCE"")"
 S QUE=NS
 D:$L(NS)  F  S QUE=$O(@ARY@(QUE)) Q:QUE=""  Q:'($E(QUE,1,$L(NS))=NS)  D
 .S NODE=$G(@ARY@(QUE))
 .S TIME=$P(NODE,"^",2)
 .I LATEONLY Q:'TIME  Q:TIME>NOW
 .S IEN=0
 .S COUNT=$S($L($P(NODE,"^")):1,1:0)
 .F  S IEN=$O(@ARY@(QUE,IEN)) Q:'IEN  S COUNT=COUNT+1
 .I MIN,COUNT<MIN,'(TIME&(TIME<NOW)) Q
 .D ADDTO(QUE,COUNT,NODE)
END S VALMBCK="R"
 ;
 Q
ADDTO(QUE,COUNT,NODE) ;
 N LINE,MSGID
 ;
 S MSGID=""
 I $P(NODE,"^") S MSGID=$P($G(^HLB(+NODE,0)),"^",1)
 S LINE=$$LJ(QUE,30)_$$RJ(COUNT,7)_"  "_$$LJ(MSGID,18)
 I $P(NODE,"^",2),$P(NODE,"^",2)<NOW S LINE=LINE_$$FMTE^XLFDT($P(NODE,"^",2),"2FM")_"  "_$S($P(NODE,"^",3):"YES",1:"NO")
 S @VALMAR@($$I,0)=LINE
 Q
 ;
LJ(STRING,LEN) ;
 Q $$LJ^XLFSTR(STRING,LEN)
 ;
RJ(STRING,LEN) ;
 Q $$RJ^XLFSTR(STRING,LEN)
 ;
I() ;
 S VALMCNT=VALMCNT+1
 Q VALMCNT
 ;
ASK(PARMS) ;
 N SUB
 F SUB="NS","MIN","LATEONLY" S PARMS(SUB)=""
 S PARMS("NS")=$$ASKQUE
 Q:(PARMS("NS")=-1) 0
 S PARMS("LATEONLY")=$$ASKYESNO^HLOUSR2("Include only queues that are late","NO")
 Q:(PARMS("LATEONLY")=-1) 0
 S PARMS("MIN")=$$ASKMIN
 Q:(PARMS("MIN")<0) 0
 Q 1
 ;
ASKMIN() ;
 N DIR
 S DIR(0)="N^1:999999:0"
 S DIR("A")="Minimum Queue Size"
 S DIR("B")=1
 S DIR("?",1)="If you would like to limit the report to include only the"
 S DIR("?")="longer queues then you must specify the minimum size to include."
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q X
ASKQUE() ;
 N DIR
 S DIR(0)="FO^0:40"
 S DIR("A")="Sequence Queue Namespace"
 S DIR("?")="Enter the namespace for the queues, or '^' to exit."
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q X
 ;
ADVANCE ;
 N DIR,QUE,MSG,RET
 S VALMBCK="R"
 S DIR(0)="FO^0:40"
 S DIR("A")="Sequence Queue"
 S DIR("?")="Enter the full name of the queue, or '^' to exit."
 D ^DIR K DIR
 Q:$D(DTOUT)!$D(DUOUT)
 S QUE=X
 Q:'$L(QUE)
 S MSG=$$PICKMSG^HLOUSR1()
 Q:'MSG
 S RET=$$ADVANCE^HLOQUE(QUE,MSG)
 I 'RET D
 .W !,"Sorry, that queue was not pending that message!" D PAUSE^VALM1
 E  D
 .W !,"The queue has been advanced!" D PAUSE^VALM1
 ;
 D SEARCH(.HLPARMS)
 Q
