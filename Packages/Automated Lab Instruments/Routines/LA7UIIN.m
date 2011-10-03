LA7UIIN ;DALISC/JRR - Process Incoming Univ Interface Messages ; 12/3/1997
 ;;5.2;LAB MESSAGING;**17,23,27**;Sep 27, 1994
 ;This routine processes all incoming messages for the 
 ;Universal Interface configuration.
 QUIT
 ;
EN L +^LAHM(62.48,"Z",LA76248):10 ;only one job should run at at time
 E  QUIT
 ;
LOOP F LA7LOOP=1:1:60 DO GETIN H 5 ;main loop, LA7LOOP reset in GETIN
 K LA7LOOP
 L -^LAHM(62.48,"Z",LA76248)
 I $D(ZTQUEUED) S ZTREQ="@"
 QUIT  ;quit main routine
 ;
GETIN ;Check the incoming queue for messages and then call LA7UIIN1 to
 ;process the message.
 Q:'$O(^LAHM(62.49,"Q",LA76248,"IQ",0))  ;check incoming queue
 S LA76249=0
 S LA7LOOP=1 ;reset timeout counter
 F  S LA76249=$O(^LAHM(62.49,"Q",LA76248,"IQ",LA76249)) Q:'LA76249  D
 . K TRAY,CUP,LWL,WL,LROVER,METH,LOG,IDENT,LADT,LAGEN,ISQN,IDE
 . L +^LAHM(62.49,LA76249):1 Q:'$T  ; Unable to get lock, messsage still building?.
 . D NXTMSG^LA7UIIN1
 . I $G(LA7INST)="" S LA7INST="UNKNOWN"
 . S DR="5////"_$P(LA7INST,"^")_"-I-"_$S($L(LA7UID):LA7UID,1:LA7AN) ; Set instrument name-message type-unique identifier or accession # as INSTRUMENT NAME.
 . I $P($G(^LAHM(62.49,LA76249,0)),"^",3)'="E" S DR=DR_";2////X" ;set status to purgeable
 . S DIE="^LAHM(62.49,",DA=LA76249
 . D ^DIE ;set status to purgeable
 . I $D(^LAHM(62.48,+$G(LA76248),20,"B",1)) D XQA^LA7UXQA(1,LA76248)
 . L -^LAHM(62.49,LA76249) ; Release lock.
 K ^TMP("LA7TREE",$J)
 QUIT  ;quit GETIN subroutine
 ;
QUE ;call here to queue this processing routine to run in the 
 ;background. Required variables are:
 ;LA76248=pointer to configuration in 62.48
 L +^LAHM(62.48,"Z",LA76248):1 ;see if already running
 E  L -^LAHM(62.48,"Z",LA76248) QUIT
 S ZTRTN="EN^LA7UIIN",ZTDTH=$H,ZTIO=""
 S ZTDESC="Processing Routine for "_$P(^LAHM(62.48,LA76248,0),"^")
 S ZTSAVE("LA76248")=LA76248
 D ^%ZTLOAD
 L -^LAHM(62.48,"Z",LA76248)
 K ZTDTH,ZTIO,ZTSAVE,ZTRTN,ZTSK
 QUIT  ;quit QUE subroutine call
