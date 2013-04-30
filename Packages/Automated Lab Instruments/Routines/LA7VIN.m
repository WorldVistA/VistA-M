LA7VIN ;DALOI/JMC - Process Incoming Lab HL7 Messages ;11/17/11  15:38
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,67,74**;Sep 27, 1994;Build 229
 ;
 ; This routine processes incoming messages for various Lab HL7 configurations.
 Q
 ;
EN ; Only one process should run at a time
 ;
 ; Expects variable LA76248 = internal entry # of message configuration in LA7 MESSAGE PARAMETER file (#62.48)
 ;
 N DIQUIET,LA76249,LA7I,LA7INTYP,LA7LOOP,LA7X,LRQUIET
 ;
 ; Prevent FileMan from issuing any unwanted WRITE(s).
 S (DIQUIET,LRQUIET)=1
 ; Insure DT and DILOCKTM is defined
 D DT^DICRW
 ;
 L +^LAHM(62.48,"Z",LA76248):10
 E  S:$D(ZTQUEUED) ZTREQ="@" Q
 ;
 ; Setup DUZ array to 'non-human' user LRLAB,HL
 ; If user not found - send alert to G.LAB MESSAGING
 S LA7X=$P($G(^XTMP("LA7 PROXY","LRLAB,HL")),"^")
 I LA7X<1 D
 . S LA7X=$$FIND1^DIC(200,"","OQUX","LRLAB,HL","B","")
 . S ^XTMP("LA7 PROXY",0)=DT_"^"_DT_"^LAB HL7 PROXY USERS"
 . I LA7X>0 S ^XTMP("LA7 PROXY","LRLAB,HL")=LA7X
 I LA7X<1 D  Q
 . N MSG
 . S MSG="Lab Messaging - Unable to identify user 'LRLAB,HL' in NEW PERSON file"
 . D XQA^LA7UXQA(0,LA76248,0,0,MSG,"",0)
 . L -^LAHM(62.48,"Z",LA76248)
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
 ; Kill running flag
 K ^XTMP("LA7VIN",LA76248)
 ;
 ; Clean up taskman
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 ; Check TaskMan for scheduled lab option
 D CHECKTM
 ;
 ; Check if LAB MESSAGING mail group has active members
 D CHECKMG
 ;
 K LA76248
 K CENUM,DPF,ECHOALL,ER,IDE,IDT,LALCT,LANM,LAZZ,LINK,LRTEC,NOW,RMK,T,TC,TP,TSK,WDT
 Q
 ;
 ;
GETIN ; Check the incoming queue for messages and then call LA7VIN1 to process the message.
 ;
 ; LA7MSGPROCESSED is a counter of number of messages processed. Used to insure if volume of messages
 ;  being received results in the "IQ" not being empty that the processing routine to process
 ;  the information in LAH is periodically tasked for those interfaces (POC, etc) that have such a behavior.
 ;
 N LA7MSGPROCESSED
 S LA7MSGPROCESSED=0
 ;
 ; Update XTMP entry to let messaging know we're still running for this configuration.
 D XTMP
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
 . L +^LAHM(62.49,LA76249):DILOCKTM
 . I '$T H 5 Q
 . D NXTMSG^LA7VIN1
 . L -^LAHM(62.49,LA76249)
 . S LA7MSGPROCESSED=LA7MSGPROCESSED+1
 . I (LA7MSGPROCESSED#50)=0 D CHKPROC
 ;
 K ^TMP("LA7TREE",$J)
 ;
 D CHKPROC
 ;
 Q
 ;
 ;
CHKPROC ; Check if any processing routine need to be tasked to process info in LAH
 ;
 ; If point of care interface then task job(s) to process results in LAH.
 I LA7INTYP>19,LA7INTYP<30,$D(LA7INTYP("LWL")) D
 . I $G(ZTSTOP)=1 Q
 . S LA7I=0
 . F  S LA7I=$O(LA7INTYP("LWL",LA7I)) Q:'LA7I  D
 . . D QLAH(LA7I,"EN^LRVRPOC")
 . . K LA7INTYP("LWL",LA7I)
 ;
 Q
 ;
 ;
QUE ; Call here to queue this processing routine to run in the background.
 ; Required variables are:  LA76248 = pointer to configuration in 62.48
 ;
 ; Check if we recently tasked the processing routine for this configuration.
 ; Done to avoid repetitive locking attempts on each new message since the
 ; FileMan locking API uses a site-defined timeout which is usually 3 seconds
 ; but can be more. Slows down the interface if on each message we are waiting
 ; 3 or more seconds for the lock to find out if the processing routine is already
 ; running.
 N LA7X,LA7Y
 S LA7X=$H,LA7Y=$G(^XTMP("LA7VIN",LA76248))
 I $P(LA7X,",")=$P(LA7Y,","),($P(LA7X,",",2)-$P(LA7Y,",",2))<240 Q
 ;
 ; See if already running
 L +^LAHM(62.48,"Z",LA76248):DILOCKTM
 I '$T Q
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTRTN,ZTSK
 S ZTRTN="EN^LA7VIN",ZTDTH=$H,ZTIO=""
 S ZTDESC="Processing Routine for "_$P(^LAHM(62.48,LA76248,0),"^")
 S ZTSAVE("LA76248")=LA76248
 D ^%ZTLOAD
 ;
 D XTMP
 ;
 L -^LAHM(62.48,"Z",LA76248)
 ;
 Q
 ;
 ;
QLAH(LWL,ZTRTN) ; Call here to queue result processing routine to run in the background.
 ; Call with LWL = pointer to load list in file #68.2
 ;         ZTRTN = name of processing routine to task
 ;
 ;
 ; See if already running
 L +^LAH("Z",LWL):DILOCKTM
 I '$T Q
 L -^LAH("Z",LWL)
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTSK
 S ZTDTH=$H,ZTIO="",ZTDESC="Result Processing for "_$P(^LRO(68.2,LWL,0),"^")
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
 S MSG="Lab Messaging - Option LA7TASK NIGHTY is not scheduled in TaskMan^LA7-MESSAGE-CHECKTM"
 D XQA^LA7UXQA(0,LA76248,0,0,MSG,"",0)
 Q
 ;
 ;
CHECKMG ; Check if LAB MESSAGING mail group has active members.
 ;
 N XMERR,XQA,XQAID,XQAMSG
 ;
 ; See if mail group check has been done today
 I $P($G(^XTMP("LA7CHECKMG",0)),"^",2)=DT Q
 ;
 ; Set flag that we've check the membership today.
 S ^XTMP("LA7CHECKMG",0)=DT_"^"_DT_"^LAB HL7 CHECK LAB MESSAGING MAIL GROUP MEMBERS"
 ;
 K ^TMP("XMERR",$J)
 I $$GOTLOCAL^XMXAPIG("LAB MESSAGING") Q
 ;
 ; Mail group has no active members
 S XQAMSG="Lab Messaging - Mail group LAB MESSAGING has no active members"
 ; Delete previous alerts
 S XQAID="LA7-MESSAGE-CHECKMG"
 D DEL^LA7UXQA(XQAID)
 ;
 ; Send alert to holders of mail group LMI
 I $$GOTLOCAL^XMXAPIG("LMI") D  Q
 . S XQA("G.LMI")=""
 . D SETUP^XQALERT
 . K ^TMP("XMERR",$J)
 ;
 ; Neither LAB MESSAGING or LMI mail groups have active members - send alert to holders of LRLIASON security key
 S XQAMSG="Lab Messaging - Mail groups LAB MESSAGING and LMI have no active members"
 M XQA=^XUSEC("LRLIASON")
 D SETUP^XQALERT
 K ^TMP("XMERR",$J)
 ;
 Q
 ;
 ;
XTMP ; Set/update XTMP with current run time of this processing routine
 ;
 S ^XTMP("LA7VIN",0)=DT_"^"_DT_"^LAB HL7 PROCESS TASKING"
 S ^XTMP("LA7VIN",LA76248)=$H
 Q
