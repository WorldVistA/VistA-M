HLOUSR2 ;ALB/CJM -ListManager Screen for viewing message errors;12 JUN 1997 10:00 am ;07/27/2010
 ;;1.6;HEALTH LEVEL SEVEN;**126,134,137,138,147**;Oct 13, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
EN ;
 D WAIT^DICD
 D EN^VALM("HLO MESSAGE VIEWER")
 Q
 ;
SHOWLIST ;
 N PARMS,I,ERRCOUNT,SCREEN
 S (VALMBG,VALMCNT,I,ERRCOUNT,SCREEN)=0
 D CLEAN^VALM10
 S VALMBG=1
 I '$$ASKPARMS(.PARMS) S VALMBCK="" Q
 ;
 I PARMS("SCR") S SCREEN=$$GETSCRN(+PARMS("SCR"),.SCREEN)
 I PARMS("ALL") D
 .N APP
 .S APP=""
 .F  S APP=$O(^HLB("ERRORS",APP)) Q:APP=""  D  Q:ERRCOUNT>PARMS("MAX")
 ..N TIME,IEN
 ..S TIME=PARMS("START")
 ..Q:($O(^HLB("ERRORS",APP,TIME))="")
 ..S @VALMAR@($$I,0)="Application: "_APP
 ..D CNTRL^VALM10(VALMCNT,14,$L(APP),IOINHI,IOINORM)
 ..F  S TIME=$O(^HLB("ERRORS",APP,TIME)) Q:'TIME  Q:ERRCOUNT>PARMS("MAX")  S IEN="" F  S IEN=$O(^HLB("ERRORS",APP,TIME,IEN)) Q:IEN=""  D ADDTO(IEN,TIME,.SCREEN,.ERRCOUNT) Q:ERRCOUNT>PARMS("MAX")
 E  D
 .N APP
 .S APP=PARMS("APP")
 .N TIME,IEN
 .S TIME=PARMS("START")
 .Q:$O(^HLB("ERRORS",APP,TIME))=""
 .S @VALMAR@($$I,0)="Application: "_APP
 .D CNTRL^VALM10(VALMCNT,14,$L(APP),IOINHI,IOINORM)
 .F  S TIME=$O(^HLB("ERRORS",APP,TIME)) Q:'TIME  Q:ERRCOUNT>PARMS("MAX")  S IEN="" F  S IEN=$O(^HLB("ERRORS",APP,TIME,IEN)) Q:IEN=""  D ADDTO(IEN,TIME,.SCREEN,.ERRCOUNT) Q:ERRCOUNT>PARMS("MAX")
SHOW S VALMBCK="R"
 ;
 Q
ADDTO(IEN,TIME,SCREEN,ERRCOUNT) ;
 N NODE,MSG,LIST,SKIP
 Q:'$$STARTMSG^HLOPRS(.MSG,+IEN)
 ;S ERRCOUNT=ERRCOUNT+1
 ;application errors could be an error to a msg within a batch
 ;also, need to go to the ack msg to get the error text from the MSA segment
 ;
 N SUBIEN,MSA,ERRTEXT
 S (ERRTEXT,MSA)=""
 S SUBIEN=$P(IEN,"^",2)
 ;within batch?
 D:SUBIEN GETMSGB^HLOMSG1(.MSG,SUBIEN,.MSG)
 S ERRTEXT=MSG("STATUS","ERROR TEXT")
 I ERRTEXT="",MSG("ACK BY")]"",($$FINDMSG^HLOMSG1(MSG("ACK BY"),.LIST)=1) D
 .N MSG,SEG,FS,AIEN
 .S AIEN=+LIST(1),SUBIEN=$P(LIST(1),"^",2)
 .Q:'$$STARTMSG^HLOPRS(.MSG,AIEN)
 .I SUBIEN S MSG("BATCH","CURRENT MESSAGE")=SUBIEN,MSG("LINE COUNT")=0
 .; ** Start HL*1.6*138 PIJ **
 .;;F  Q:'$$HLNEXT^HLOMSG(.MSG,.SEG)  I $E(SEG(1),1,3)="MSA" S MSA=SEG(1),FS=$E(MSA,4),ERRTEXT=$P(MSA,FS,4) Q
 .F  Q:'$$HLNEXT^HLOMSG(.MSG,.SEG)  I $E(SEG(1),1,3)="MSA" S MSA=SEG(1),FS=$E(MSA,4) D  Q
 ..S ERRTEXT=$$ESCAPE^HLOPBLD(.MSG,$P(MSA,FS,4))
 .; ** End HL*1.6*138 **
 I ERRTEXT="",MSG("ACK BY")="" D
 .N FS
 .S FS=$E(MSG("HDR",1),4)
 .I $L(FS) S ERRTEXT=$P($G(MSG("STATUS","ACCEPT ACK MSA")),FS,4)
 I SCREEN,'$$SCREEN(ERRTEXT,.SCREEN) Q
 S ERRCOUNT=ERRCOUNT+1
 S @VALMAR@($$I,0)="  "_$$LJ(MSG("ID"),25)_$S(MSG("BATCH"):"BATCH   ",1:$$LJ($G(MSG("MESSAGE TYPE"))_"~"_$G(MSG("EVENT")),8))_$$LJ($$FMTE^XLFDT(MSG("DT/TM CREATED"),2),20)_$E(ERRTEXT,1,35)
 D CNTRL^VALM10(VALMCNT,3,25,IOINHI,IOINORM)
 I $L(ERRTEXT)>35 D
 .S @VALMAR@($$I,0)=$$RJ(" ",45)_$E(ERRTEXT,36,115)
 S:MSG("ID")]"" @VALMAR@("INDEX",MSG("ID"))=IEN
 Q
 ;
ASKPARMS(PARMS) ;
 K PARMS
 S PARMS("START")=$$ASKBEGIN("T-1")
 I 'PARMS("START") Q 0
 S PARMS("MAX")=$$ASKMAX()
 Q:'(PARMS("MAX")>-1) 0
 S PARMS("ALL")=$$ASKYESNO("Include ALL applications","YES")
 ;
 ; *** BEGIN HL*1.6*147 - RBN
 ; 
 ;I PARMS("ALL") Q 1
 I PARMS("ALL")="" Q 0
 ;S PARMS("APP")=$$ASKAPP()
 I 'PARMS("ALL") D  Q:PARMS("APP")="" 0
 . S PARMS("APP")=$$ASKAPP()
 S PARMS("SCR")=$$ASKSCR()
 ;
 ; ** END HL*1.6*147 - RBN
 ; 
 Q 1
 ;
ASKMAX()        ;
 N DIR
 S DIR(0)="N^1:30000:0"
 S DIR("A")="Maximum List Size"
 S DIR("B")=1000
 S DIR("?",1)="In case a large number of errors meet your search criteria, what are the"
 S DIR("?")="maximum number of errors to display? (30,000 maximum)"
 D ^DIR
 Q:$D(DTOUT)!$D(DUOUT) -1
 Q X-1
 ;
ASKAPP() ;
 D FULL^VALM1
 S VALMBCK="R"
 N DIR
 S DIR(0)="F^3:60"
 S DIR("A")="Receiving Application"
 S DIR("?")="Enter the full name of the application, or '^' to exit."
 D ^DIR
 I $D(DIRUT)!(Y="") Q ""
 Q Y
 ;
 ; *** BEGIN HL*1.6*147 - RBN
 ;
ASKSCR() ;
 D FULL^VALM1
 S VALMBCK="R"
 N DIR
 S DIR(0)="PO^779.11"
 S DIR("A")="Error Screen (optional)"
 S DIR("B")=""
 S DIR("?")="Enter the full name of the error screen.  This entry is optional"
 D ^DIR
 I $D(DIRUT)!'(Y>0) Q ""
 Q Y
 ;
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
STRTSTPQ ;
 ;action to start or stop a queue, either incoming or outgoing
 ;
 N STOP,INOROUT,QUE
 S VALMBCK="R"
 D FULL^VALM1
 ;ask if stop or start
 D  Q:STOP=""
 .N DIR
 .S DIR(0)="S^1:START;2:STOP"
 .S DIR("A")="Do you want to START or STOP a queue"
 .S DIR("B")="1"
 .D ^DIR
 .S STOP=$S(Y=1:0,Y=2:1,1:"")
 ;ask if in or out
 D  Q:INOROUT=""
 .N DIR
 .S DIR(0)="S^I:INCOMING;O:OUTGOING"
 .S DIR("A")="Do you want to "_$S(STOP:"stop",1:"start")_" an incoming queue or an outgoing queue"
 .S DIR("B")="I"
 .D ^DIR
 .S INOROUT=$S(Y="I":"IN",Y="O":"OUT",1:"")
 S QUE=$$ASKQUE(INOROUT)
 Q:QUE=""
 I STOP=$$STOPPED^HLOQUE(INOROUT,QUE) D
 .N C
 .I STOP D
 ..W !,"That queue is already stopped!"
 .E  W !,"That queue is not stopped!"
 .W !,IOINHI,"Hit any key to continue...",IOINORM
 .R *C:DTIME
 E  D
 .N C
 .D:STOP STOPQUE^HLOQUE(INOROUT,QUE)
 .D:'STOP STARTQUE^HLOQUE(INOROUT,QUE)
 .W !,"DONE!"
 .W !,IOINHI,"Hit any key to continue...",IOINORM
 .R *C:DTIME
 .D @HLRFRSH
 Q
 ;
ASKQUE(DIR) ;
 N QUEUE
AGAIN W !,"Enter the full, exact name of queue:"
 S QUEUE=""
 R QUEUE:60 I '$T Q ""
 I $E(QUEUE)="?" W !,"Each message is placed on a queue that has an arbitrary name up to 20",!,"characters long." I $$ASKYESNO("Would you like to see a list of the queues that currently exist","NO") D  G AGAIN
 .N SUB,QUE,QUIT,COUNT
 .K ^TMP($J,"HLO QUEUES")
 .S SUB=""
 .F  S SUB=$O(^HLB("QUEUE",DIR,SUB)) Q:SUB=""  D
 ..S QUE=""
 ..F  S QUE=$O(^HLB("QUEUE",DIR,SUB,QUE)) Q:QUE=""  S ^TMP($J,"HLO QUEUES",QUE)=""
 .S QUE=""
 .S IOSL=$G(IOSL,20)
 .S (COUNT,QUIT)=0
 .W !
 .F  S QUE=$O(^TMP($J,"HLO QUEUES",QUE)) Q:QUE=""  Q:QUIT  D
 ..W !,QUE
 ..S COUNT=COUNT+1
 ..I COUNT>(IOSL-3) D
 ...N Y
 ...D PAUSE^VALM1
 ...I 'Y S QUIT=1
 ...S COUNT=0
 .W !
 .K ^TMP($J,"HLO QUEUES")
 Q:$E(QUEUE)="?" ""
 Q:$E(QUEUE)="^" ""
 Q QUEUE
 ;
ASKBEGIN(DEFAULT) ;
 ;Description: Asks the user to enter a beginning date.
 ;Input: DEFAULT - the suggested default dt/time (optional)
 ;Output: Returns the date as the function value, or 0 if the user does not select a date
 ;
 ;
 N %DT
 S %DT="AEST"
 S %DT("A")="Enter the beginning date/time: "
 S %DT("B")=$$FMTE^XLFDT($S($L($G(DEFAULT)):DEFAULT,1:$$FMADD^XLFDT(DT,-1)))
 S %DT(0)="-NOW"
 Q:$D(DTOUT) 0
 D ^%DT
 I Y=-1 Q 0
 Q Y
 ;
ASKEND(BEGIN) ;
 ;Description: Asks the user to enter an ending date/time
 ;Input: BEGIN - the earliest date/time allowed
 ;Output: Returns the date as the function value, or 0 if the user does not select a date/time
 ;
 N %DT
 S %DT="AEST"
 S %DT("A")="Enter the ending date/time: "
 S %DT("B")="NOW"
 S %DT(0)=BEGIN
 Q:$D(DTOUT) 0
 D ^%DT
 I Y=-1 Q 0
 Q Y
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
HEADER ;
 Q
HELP ;
 N ARY
 S ARY(1)="An error screen allows you to specify what type of errors"
 S ARY(2)="appear in the error display. There are two types of screens:"
 S ARY(3)=""
 S ARY(4)="EXCLUDE screens allow you to specify what errors to exclude from the display."
 S ARY(5)=""
 S ARY(6)="INCLUDE screens allow you to specify what errors to include in the display."
 S ARY(7)=""
 S ARY(8)="With either type of screen, if a string on your list matches text within"
 S ARY(9)="the error message then the error is included or excluded from the"
 S ARY(10)="display, depending on the type of screen."
 D EN^DDIOL(.ARY)
 Q
 ;
GETSCRN(IEN,SCREEN) ;
 ;pass SCREEN by reference
 ;returns 1 on success, 0 on failure
 ;
 N NODE,TYPE,I,ERROR
 K SCREEN
 S NODE=$G(^HLD(779.11,IEN,0))
 S TYPE=$P(NODE,"^",5)
 I TYPE'=0,TYPE'=1 Q 0
 S SCREEN("TYPE")=$S(TYPE=0:"EXCLUDE",1:"INCLUDE")
 S SCREEN("IEN")=IEN
 S I=0
 F  S I=$O(^HLD(779.11,IEN,1,I)) Q:'I  S ERROR=$G(^HLD(779.11,IEN,1,I,0))  I ERROR'="" S SCREEN("ERRORS",I)=$P(ERROR,"^"),SCREEN("ERRORS",I,"PARTIAL")=+$P(ERROR,"^",2)
 Q 1
SCREEN(ERROR,SCREEN) ;
 ;Returns 1 if the ERROR should be added to the display based on the SCREEN
 ;
 I ERROR="" Q $S(SCREEN("TYPE")="EXCLUDE":1,1:0)
 ;
 N ADD,I,TEXT
 ;
 S I=0
 S ADD=$S(SCREEN("TYPE")="INCLUDE":0,1:1)
 ;
 F  S I=$O(SCREEN("ERRORS",I)) Q:'I  S TEXT=$G(SCREEN("ERRORS",I)) I $L(TEXT),$S(SCREEN("ERRORS",I,"PARTIAL"):ERROR[TEXT,1:TEXT=ERROR) S ADD=$S(SCREEN("TYPE")="INCLUDE":1,1:0) Q
 ;
 Q ADD
