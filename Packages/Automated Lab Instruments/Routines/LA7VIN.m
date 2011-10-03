LA7VIN ;DALOI/JMC - Process Incoming Lab HL7 Messages ; Jan 12, 2005
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,67**;Sep 27, 1994
 ; This routine processes incoming messages for various Lab HL7 configurations.
 Q
 ;
EN ; Only one process should run at a time
 N LA76249,LA7I,LA7INTYP,LA7LOOP,LA7X
 ;
 L +^LAHM(62.48,"Z",LA76248):10
 E  Q
 ;
 ; Setup DUZ array to 'non-human' user LRLAB,HL
 ; If user not found - send alert to G.LAB MESSAGING
 S LA7X=$$FIND1^DIC(200,"","OX","LRLAB,HL","B","")
 I LA7X<1 D  Q
 . N MSG
 . S MSG="Lab Messaging - Unable to identify user 'LRLAB,HL' in NEW PERSON file"
 . D XQA^LA7UXQA(0,LA76248,0,0,MSG,"",0)
 D DUZ^XUP(LA7X)
 ;
 ; Determine interface type
 S LA7INTYP=+$P(^LAHM(62.48,LA76248,0),"^",9)
 ;
 ; main loop, LA7LOOP reset in GETIN, if no messages for 5 minutes (60x5) then quit
 F LA7LOOP=1:1:60 D  Q:$G(ZTSTOP)
 . ; Check if task has been requested to stop
 . I $$S^%ZTLOAD("Idle - waiting for new messages to process") S ZTSTOP=1 Q
 . D GETIN H 5
 ;
 ; Release lock
 L -^LAHM(62.48,"Z",LA76248)
 ;
 ; Clean up taskman
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 ; Check TaskMan for scheduled lab option
 D CHECKTM
 ;
 K LA76248
 K CENUM,DPF,ECHOALL,ER,IDE,IDT,LALCT,LANM,LAZZ,LINK,LRTEC,NOW,RMK,T,TC,TP,TSK,WDT
 Q
 ;
 ;
GETIN ; Check the incoming queue for messages and then call LA7VIN1 to
 ; process the message.
 ;
 ; Check incoming queue
 Q:'$O(^LAHM(62.49,"Q",LA76248,"IQ",0))
 ;
 ; Reset timeout counter
 S LA7LOOP=1
 ;
 ; Get lock on message, quit if still building, process message then release lock.
 F  S LA76249=$O(^LAHM(62.49,"Q",LA76248,"IQ",0)) Q:'LA76249  D  Q:$G(ZTSTOP)
 . ; Check if task has been requested to stop
 . I $$S^%ZTLOAD("Processing msg #"_LA76249) S ZTSTOP=1 Q
 . L +^LAHM(62.49,LA76249):1
 . I '$T H 5 Q
 . D NXTMSG^LA7VIN1
 . L -^LAHM(62.49,LA76249)
 ;
 K ^TMP("LA7TREE",$J)
 ;
 ; If point of care interface then task job(s) to process results in LAH.
 I LA7INTYP>19,LA7INTYP<30,$D(LA7INTYP("LWL")) D
 . I $G(ZTSTOP)=1 Q
 . S LA7I=0
 . F  S LA7I=$O(LA7INTYP("LWL",LA7I)) Q:'LA7I  D
 . . D QLAH(LA7I)
 . . K LA7INTYP("LWL",LA7I)
 ;
 Q
 ;
 ;
QUE ; Call here to queue this processing routine to run in the background.
 ; Required variables are:  LA76248 = pointer to configuration in 62.48
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTRTN,ZTSK
 ;
 ; See if already running
 L +^LAHM(62.48,"Z",LA76248):1
 E  Q
 ;
 S ZTRTN="EN^LA7VIN",ZTDTH=$H,ZTIO=""
 S ZTDESC="Processing Routine for "_$P(^LAHM(62.48,LA76248,0),"^")
 S ZTSAVE("LA76248")=LA76248
 D ^%ZTLOAD
 ;
 L -^LAHM(62.48,"Z",LA76248)
 ;
 Q
 ;
 ;
QLAH(LWL) ; Call here to queue result processing routine to run in the background.
 ; Call with LWL = pointer to loadlist in file #68.2
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTRTN,ZTSK
 ;
 ; See if already running
 L +^LAH("Z",LWL):0
 E  Q
 L -^LAH("Z",LWL)
 ;
 S ZTRTN="EN^LRVRPOC",ZTDTH=$H,ZTIO=""
 S ZTDESC="Result Processing for "_$P(^LRO(68.2,LWL,0),"^")
 S ZTSAVE("LRLL")=LWL
 D ^%ZTLOAD
 ;
 ;
 Q
 ;
 ;
CHECKTM ; Check is LA7TASK NIGHTY is scheduled in TaskMan.
 ;
 N LA7TSK,LA7J,MSG,NOW,OK
 S (LA7TSK,OK)=0
 D OPTSTAT^XUTMOPT("LA7TASK NIGHTY",.LA7TSK)
 ;
 ; If scheduled check to see if for the future
 I LA7TSK>0 D
 . S LA7J=0,NOW=$$NOW^XLFDT
 . F  S LA7J=$O(LA7TSK(LA7J)) Q:'LA7J  I $P(LA7TSK(LA7J),"^",2)>NOW S OK=1 Q
 I OK Q
 ;
 ; Option is not scheduled - send alert to G.LAB MESSAGING
 S MSG="Lab Messaging - Option LA7TASK NIGHTY is not scheduled in TaskMan"
 D XQA^LA7UXQA(0,LA76248,0,0,MSG,"",0)
 Q
