XMCB ;ISC-SF/GMB- Batch Message Transmission ;08/28/2003  10:11
 ;;8.0;MailMan;**22**;Jun 28, 2002
 ; Was (WASH ISC)/THM
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; TAPEOUT  XMS-SEQ-TRANSMIT     (was BAT^XMS)
 ; TAPEIN   XMR-SEQ-RECEIVE      (was BAT^XMR)
 ; GLBOUT   XMR-UCI-SEND         (was TASKER^XMS)
 ; GLBIN    XMR-UCI-RCV          (was TASKER^XMR)
 Q
TAPEOUT ; Write messages to tape.
 ; (Transmit them to another site via tape.)
 N XMC,XMCHAN,XMINST,XMSITE,XMABORT,ER
 S XMABORT=0,XMCHAN="TAPE",ER=0,XMC("BATCH")=1
 D ASKINST^XMCXU(.XMINST,.XMSITE,.XMABORT,"M") Q:XMABORT
 D OPEN^XML Q:$G(ER)!$G(POP)
 D OUTDO
 D KL^XMC
 Q
TAPEIN ; Read messages from tape.
 ; (Receive them from another site via tape.)
 N XM,XMC,XMCHAN,ER
 S ER=0,(XMC("BATCH"),XMC("TURN"))=1,XMCHAN="T-IN"
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D R^XMCTRAP"
 E  S X="R^XMCTRAP",@^%ZOSF("TRAP")
 D ENT^XMR
 U IO(0) D ^%ZISC
 W:'$D(ZTQUEUED) !,$$EZBLD^DIALOG(42257,+$G(XMC("R"))) ;Messages received: |1|
 G KL1^XMC
 Q
GLBOUT ; Write messages to a global.
 ; (Transmit them to another UCI via the global.)
 W $C(7),!!
 I '$D(^%ZISL(4.281,0)) W !!,$$EZBLD^DIALOG(42250) Q  ;File 4.281 is not set up properly.
 N XMTEXT
 D BLD^DIALOG(42251,"","","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 ;  ******* I M P O R T A N T *******"
 ;This option transmits messages from one UCI to another via ^%ZISL(4.281.
 ;Each UCI must be running MailMan, and file 4.281 must be translated and
 ;accessible from both UCIs.  In the two-step process, the messages are
 ;written to the global from one UCI, and read from it in the other.
 ;
 ;Invoke this option on the sending UCI, and select the domain whose
 ;messages are to be transmitted.  (The domain name must be the exact
 ;name of the domain of the receiving UCI - no synonyms.)  The messages
 ;are written to file 4.281 and deleted from the transmit queue.
 ;
 ;Log on to the receiving UCI and invoke the receiver.  It will read all
 ;messages in file 4.281 which were sent to it (it can't read any
 ;messages sent to any other domain), and queue them to be delivered.
 ;The messages will then be deleted from file 4.281.
 N XMC,XMCHAN,XMLINE,XMFDA,XMIEN,XMIENS,XMABORT,XMINST,XMSITE,XMTASK,ER,Y
 S XMCHAN="TASKER",(XMABORT,XMLINE)=0
 D ASKINST^XMCXU(.XMINST,.XMSITE,.XMABORT,"M") Q:XMABORT
 D GET^XML Q:$G(ER)!$G(POP)
 S XMFDA(4.281,"+1,",.01)=^XMB("NETNAME")
 D UPDATE^DIE("","XMFDA","XMIEN")
 S XMTASK=XMIEN(1)
 D OUTDO
 S XMIENS=XMTASK_","
 S XMFDA(4.281,XMIENS,1)=XMSITE
 D FILE^DIE("","XMFDA")
 D KL^XMC
 Q
OUTDO ;
 N XM,XMDUZ
 U IO(0)
 S XM="",(XMC("BATCH"),XMC("TURN"))=1,XMREC="Q"
 D GET^XMCXT(0)
 W !,$$EZBLD^DIALOG(42252) ;Dumping messages now
 U IO
 D ENTER^XMS
 D XMTFINIS^XMTDR(XMINST)
 U IO(0)
 I $D(XMC("S")) W $C(7)," ... ",$$EZBLD^DIALOG(42253,XMC("S")) ;Messages dumped: |1|
 X XMCLOSE
 Q
GLBIN ; Read messages from a global.
 ; (Receive them from another UCI via the global.)
 N XM,XMC,XMCHAN,XMDUZ,XMTASK,XMNETNAM,XMSITE,XMABORT,XMI,XMIREC,XMCNT,Y
 S XM=$S($D(ZTQUEUED):"",1:"D")
 S XMNETNAM=^XMB("NETNAME"),XMABORT=0,XMCHAN="TASK-IN"
 D GET^XML Q:$G(ER)
 I XM["D" D  Q:XMABORT
 . D GET^XMCXT(0)
 . D DOTRAN^XMC1(42254,XMNETNAM) ;Receive messages for |1|
 . D PAGE^XMXUTIL(.XMABORT)
 S (XMI,XMCNT)=0
 F  S XMI=$O(^%ZISL(4.281,"C",XMNETNAM,XMI)) Q:'XMI  D  Q:ER
 . S XMIREC=$G(^%ZISL(4.281,XMI,0)) Q:XMIREC=""
 . Q:$P(XMIREC,U,2)'=XMNETNAM
 . S XMSITE=$P(XMIREC,U,1)
 . S XMIREC=$G(^%ZISL(4.281,XMI,"T",1,0)) Q:XMIREC'?1"HELO ".E
 . S XMCNT=XMCNT+1
 . I XM["D" D DOTRAN^XMC1(42255,XMI,XMSITE) ;Loading entry #|1| from |2|
 . S XMTASK=XMI,ER=0,XMLINE=.999,(XMC("BATCH"),XMC("TURN"),XMQUIET)=1
 . D RECEIVE^XMR Q:ER
 . N DA,DIK
 . S DA=XMTASK,DIK="^%ZISL(4.281," D ^DIK
 I XM["D" D
 . I XMCNT D DOTRAN^XMC1(42257,XMC("R")) Q  ;Messages received: |1|
 . D DOTRAN^XMC1(42256,XMNETNAM) ;No entries found in file 4.281 for |1|
 D KL^XMC
 Q
