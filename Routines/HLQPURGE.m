HLQPURGE ;ALB/CJM/ -PURGING A LINK ;02/14/2011
 ;;1.6;HEALTH LEVEL SEVEN;**153**;Oct 13, 1995;Build 11
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ASKPURGE ;
 N LINKIEN,END,LINKNAME,QUIT
 S LINKIEN=$$ASKLINK
 ;W !,"LINKIEN=",LINKIEN
 Q:'LINKIEN
 S LINKNAME=$P($G(^HLCS(870,LINKIEN,0)),"^")
 I '$P($G(^HLCS(870,LINKIEN,0)),"^",15) W !!,LINKNAME_" must be shutdown before it can be cleared of pending messages!" Q
 S PROMPT="Are you sure you want to purge "_LINKNAME
 Q:'$$ASKYESNO(PROMPT,"NO")
 S QUIT=0
 ;;; Added the following instuctional message. - RBN
 W !!,"There are two purging options: ALL or Before a particular DT/TM",!
 S PROMPT="Do you want to purge all messages queued to that link"
 I '$$ASKYESNO(PROMPT,"NO") D  Q:QUIT
 .S PROMPT="Do you want to purge messages before a particular DT/TM"
 .I '$$ASKYESNO(PROMPT,"YES") W !,"Sorry, those are the only options!" S QUIT=1 QUIT
 .S END=$$ASKEND
 .I 'END S QUIT=1
 I '$G(END) S END=0
 D QPURGE(LINKIEN,END)
 S $P(^HLCS(870,LINKIEN,"OUT QUEUE FRONT POINTER"),"^")=0
 S $P(^HLCS(870,LINKIEN,"OUT QUEUE BACK POINTER"),"^")=$$COUNT(LINKIEN)
 Q
RESET ;Resets the counters for a TCP queue
 N LINKIEN,STATE
 S LINKIEN=$$ASKLINK
 Q:'LINKIEN
 S $P(^HLCS(870,LINKIEN,"OUT QUEUE FRONT POINTER"),"^")=0
 S $P(^HLCS(870,LINKIEN,"OUT QUEUE BACK POINTER"),"^")=$$COUNT(LINKIEN)
 S $P(^HLCS(870,LINKIEN,"IN QUEUE FRONT POINTER"),"^")=0
 S $P(^HLCS(870,LINKIEN,"IN QUEUE BACK POINTER"),"^")=$$COUNT(LINKIEN,"I")
 S STATE=$P(^HLCS(870,LINKIEN,0),U,5)
 I +STATE,$P(STATE," ",2)="server" S STATE="0 server"
 Q
 ;
QPURGE(LINKIEN,END) ;
 N MSGIEN,QUIT,DOTCNT,MSGCNT
 S (QUIT,MSGIEN,DOTCNT,DOTCNT,MSGCNT)=0
 I $D(^HLMA("AC","O",LINKIEN)) D
 . W !
 E  W !,"There are no messages to purge!" Q
 F  S MSGIEN=$O(^HLMA("AC","O",LINKIEN,MSGIEN)) Q:'MSGIEN  D  Q:QUIT
 .I END S QUIT=0 D  Q:QUIT
 ..N TIME,BODY
 ..S BODY=$P($G(^HLMA(MSGIEN,0)),"^")
 ..Q:'BODY
 ..S TIME=$P($G(^HL(772,BODY,0)),"^")
 ..I TIME>END S QUIT=1
 .;
 .; Added counter to decrease the number of dots printed - RBN
 .; Added counter to display the number of messages processed - RBN
 .; 
 .;W "."
 .;
 .I '(DOTCNT#1000) D
 ..W "."
 .S DOTCNT=DOTCNT+1
 .S MSGCNT=MSGCNT+1
 .K ^HLMA("AC","O",LINKIEN,MSGIEN)
 .S $P(^HLMA(MSGIEN,"P"),"^",1)="4"
 .S $P(^HLMA(MSGIEN,"P"),"^",2)=$$NOW^XLFDT
 .S $P(^HLMA(MSGIEN,"P"),"^",3)="Cancelled by application"
 .D PURGE(MSGIEN)
 W !,"DONE: "_MSGCNT_" messages processed."
 Q
 ;
PURGE(IEN) ;sets the AI x-ref on file 773 and the FAST PURGE DT/TM fields in file 772 and 773
 ;Input:  IEN is the ien of record in file 773
 ;
 Q:'$G(IEN)
 ;
 ;
 N NODE,WHEN,CHILD
 ;
 ;also not if DON'T PURGE field is set
 Q:$P($G(^HLMA(IEN,2)),"^")=1
 ;
 ;also not if this isn't the initial message
 S NODE=$G(^HLMA(IEN,0))
 I $P(NODE,"^",6),$P(NODE,"^",6)'=IEN Q
 ;
 ;This record can be purged via FAST PURGE
 ;determine the dt/tm the record can be purged
 S WHEN=$$NOW^XLFDT
 S WHEN=$$FMADD^XLFDT(WHEN,3)
 ;
 ;set the FAST PURGE DT/TM and x-ref, and do the same for file 772 record
 D SET(IEN,WHEN,+NODE)
 ;
 ;All the records in file 773 that point to this record (children) should be purged at the same time
 S CHILD=0
 F  S CHILD=$O(^HLMA("AF",IEN,CHILD)) Q:'CHILD  D:(CHILD'=IEN) SET(CHILD,WHEN,+$G(^HLMA(CHILD,0)))
 Q
 ;
SET(IEN773,WHEN,IEN772) ;sets FAST PURGE DT/TM for and the AI x~ref for both file 772 & 773
 ;Input:
 ;   IEN773 - ien of record to be purged in file 773
 ;   WHEN - date/time to purge
 ;   IEN772 - ien of corresponding record in file 772
 ;
 N OLDWHEN
 ;if the fast purge dt/tm changed, kill the old xref
 S OLDWHEN=$P($G(^HLMA(IEN773,2)),"^",2)
 I $L(OLDWHEN) K ^HLMA("AI",OLDWHEN,773,IEN773)
 ;
 ;set the FAST PURGE DATE
 S $P(^HLMA(IEN773,2),"^",2)=WHEN
 ;
 ;set the AI x-ref
 S ^HLMA("AI",WHEN,773,IEN773)=""
 ;
 ;do the same for the corresponding entry in file 772
 I IEN772,$D(^HL(772,IEN772,0)) D
 .;if the fast purge dt/tm changed, kill the old xref
 .S OLDWHEN=$P($G(^HL(772,IEN772,2)),"^",2)
 .I $L(OLDWHEN) K ^HLMA("AI",OLDWHEN,772,IEN772)
 .;set the FAST PURGE DATE
 .S $P(^HL(772,IEN772,2),"^",2)=WHEN
 .;
 .;set the AI x-ref
 .S ^HLMA("AI",WHEN,772,IEN772)=""
 Q
 ;
ASKYESNO(PROMPT,DEFAULT) ;
 ;Description: Displays PROMPT, appending '?'.  Expects a YES NO response
 ;Input:
 ;   PROMPT - text to display as prompt.  Appends '?'
 ;   DEFAULT - (optional) YES or NO.  If not passed, defaults to YES
 ;Output:
 ;  Function value: 1 if yes, 0 if no, "" if '^' entered or timeout
 ;
 N DIR,Y
 S DIR(0)="Y"
 S DIR("A")=PROMPT
 S DIR("B")=$S($G(DEFAULT)="NO":"NO",1:"YES")
 D ^DIR
 Q:$D(DIRUT) ""
 Q Y
 ;
ASKLINK() ;
 N DIC,TCP,X,Y,DTOUT,DUOUT
 S DIC=870
 S DIC(0)="AENQ"
 S TCP=$O(^HLCS(869.1,"B","TCP",0))
 S DIC("A")="Select a TCP link:"
 S DIC("S")="I $P(^(0),U,3)=TCP"
 D ^DIC
 I +Y'=-1,'$D(DTOUT),'$D(DUOUT) Q $P(Y,"^")
 Q ""
 ;
ASKEND() ;
 ;
 N %DT
 S %DT="AEST"
 S %DT("A")="Enter the ending date/time: "
 S %DT(0)="-NOW"
 Q:$D(DTOUT) 0
 D ^%DT
 I Y=-1 Q 0
 Q Y
COUNT(LINKIEN,DIR) ;
 N MSG,COUNT
 I $G(DIR)="" S DIR="O"
 S (MSG,COUNT)=0
 F  S MSG=$O(^HLMA("AC",DIR,LINKIEN,MSG)) Q:'MSG  S COUNT=COUNT+1
 Q COUNT
SHOWTCP ;
 N Q,H,F,NM,HDR,LINE,QUIT,CRT
 S QUIT=0
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 W @IOF
 S HDR(1)="Link(ien)       Dir/Dev/Auto    First Message      Count      State"
 S HDR(2)="=========       ============    ===============    =========  =========="
 D LINE(HDR(1))
 D LINE(HDR(2))
 F Q="I","O" D
 .S H=0
 .F  S H=$O(^HLMA("AC",Q,H)) Q:'H  Q:QUIT  D
 ..N NODE0
 ..S NODE0=$G(^HLCS(870,H,0))
 ..S F=$O(^HLMA("AC",Q,H,0))
 ..S NM=$P(NODE0,"^")
 ..S:NM="" NM="ORPHAN"
 ..S LINE=$$LJ(NM_"("_H_")",14)_"  "_$$LJ(Q_"/"_$$LJ($P(NODE0,"^",4),2)_"/"_$S($P(NODE0,"^",6):"  ",1:"No"),15)_" "_$$LJ($S($P($G(^HLMA(F,"P")),"^",1)'=1:"*",1:"")_F,18)_$$RJ($$COUNT(H,Q),10)_"   "_$P(NODE0,"^",5)
 ..D LINE(LINE)
 Q
 ;
PAUSE ;
 ;First scrolls to the bottom of the page, then does a screen pause.  Sets QUIT=1 if user decides to quit.
 ;
 D PAUSE2
 Q:QUIT
 W HDR(1),!,HDR(2)
 Q
PAUSE2 ;
 ;Screen pause without scrolling.  Sets QUIT=1 if user decides to quit.
 ;
 N DIR,X,Y
 S DIR(0)="E"
 D ^DIR
 I ('(+Y))!$D(DIRUT) S QUIT=1
 Q
 ;
LINE(LINE) ;Prints a line.
 ;
 I CRT,($Y>(IOSL-4)) D
 .D PAUSE
 .Q:QUIT
 .W @IOF
 .W HDR(1),!,HDR(2),!
 .W LINE
 ;
 E  I ('CRT),($Y>(IOSL-2)) D
 .W @IOF
 .W HDR(1),!,HDR(2)
 .W LINE
 E  W !,LINE
 Q
 ;
LJ(STRING,LEN) ;
 Q $$LJ^XLFSTR($E(STRING,1,LEN),LEN)
RJ(STRING,LEN) ;
 Q $$RJ^XLFSTR($E(STRING,1,LEN),LEN)
ONETCP ;Display one TCP link
 N IEN,DA,MSG,DIC,DIR,QUIT
 S QUIT=0
 S IEN=$$ASKLINK
 Q:'IEN
 Q:QUIT
 F DIR="I","O" D  Q:QUIT
 .S MSG=$O(^HLMA("AC",DIR,IEN,0))
 .I MSG D
 ..W @IOF,!!,"Count of messages on ",$S(DIR="I":"incoming",1:"outgoing")," queue: ",$$COUNT(IEN,DIR)
 ..W !!,"First pending message follows:",!
 ..S DIC="^HLMA("
 ..S DA=MSG
 ..D EN^DIQ
 ..D PAUSE2
 Q:QUIT
 W @IOF,!!,"Here is the TCP link:",!
 S DIC="^HLCS(870,"
 S DA=IEN
 D EN^DIQ
 Q
