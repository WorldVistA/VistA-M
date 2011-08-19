XMS ;ISC-SF/GMB-SMTP Send ;07/11/2002  07:52
 ;;8.0;MailMan;;Jun 28, 2002
ENTER ; 
 ; Variables
 ; XMINST   Institution number
 ; XMSITE   Institution name
 ; XMIO     same as ZTIO
 D INIT
 ; Fall through...
SEND ;
 S XMC("DIR")="S"
 S:'$D(XMC("TURN")) XMC("TURN")=0
 D SYNCH Q:ER
 I $D(XMC("CHRISTEN")) D CHRISTN,TESTLNK Q
 I $D(XMC("TEST")) D TESTLNK Q
 D HELO(XMINST,XMSITE) L -^DIC(4.2,XMINST,0) Q:ER
 D PROCESS(XMINST,.XMB)
 D TURN(XMINST)
 D QUIT
 Q
INIT ;
 S ER=0
 S $P(^XMBS(4.2999,XMINST,3),U,6)=$E(IO,1,9)_" "_XMPROT
 S:'$D(XMC("START")) XMC("START")=$$TSTAMP^XMXUTIL1-.001
 I '$D(DT) D DT^DICRW
 S:'$D(XMC("BATCH")) XMC("BATCH")=0
 S XMTLER=0
 Q
SYNCH ; Recv: "220 REMOTE.MED.VA.GOV MailMan 8.0 ready"
 I XMC("BATCH") S XMC("MAILMAN")=+$P($T(XMS+1),";",3) Q
 S XMC("MAILMAN")=0
 N XMI,XMX
 F XMI=1:1:5 D  Q:ER  Q:$E(XMRG)=2
 . X XMREC Q:ER
 . S XMX=$P(XMRG," MailMan ",2)
 . I XMX>4,XMX[" ready" S XMC("MAILMAN")=+XMX
 . I $E(XMRG)'=2 S XMSG="NOOP" X XMSEN Q
 Q
HELO(XMINST,XMSITE) ;
 ; Send: "HELO LOCAL.MED.VA.GOV <security num>"
 ; Recv: "250 OK REMOTE.MED.VA.GOV <security num> [8.0,DUP,SER,FTP]"
 N XMINREC,XMSVAL,I
 S XMINREC=^DIC(4.2,XMINST,0)
 S XMSVAL=$P(XMINREC,U,15) ; Security code
 I XMSVAL L +^DIC(4.2,XMINST,0):0 E  D  Q
 . D ERTRAN^XMC1(42350) ;Domain file locked.
 S XMSG="HELO "_^XMB("NETNAME")_$S('XMSVAL:"",1:"<"_XMSVAL_">") X XMSEN
 I ER D ERTRAN^XMC1(42351,XMSG) Q  ;HELO SEND failed: |1|
 Q:XMC("BATCH")
 X XMREC I ER D ERTRAN^XMC1(42352) Q  ;HELO RECEIVE failed.
 I $E(XMRG)'=2 D  Q
 . D ERTRAN^XMC1(42353,^XMB("NETNAME"),XMSITE) ;|1| not recognized by |2|
 ;I $P(XMRG,"[",2)'="" S XMC("CAPABLE")=$P(XMRG,"[",2)
 F I=1:1:$L(XMRG," ") Q:$P(XMRG," ",I)["."
 S XMC("HELO SEND")=$P(XMRG," ",I)
 Q:'XMSVAL
 S XMSVAL=$P($P(XMRG,"<",2),">")
 I XMSVAL<1000000 D  Q
 . N XMPARM,XMINSTR
 . S XMSG="500 Invalid domain validation response" X XMSEN
 . S XMPARM(1)=XMSITE,XMINSTR("FROM")="POSTMASTER"
 . D TASKBULL^XMXBULL(.5,"XMVALBAD",.XMPARM,,,.XMINSTR)
 . S ER=1,ER("MSG")=XMSG
 ;Double set below prevents replicated ^DIC from
 ;going out of synch when link is down.
 S ^DIC(4.2,XMINST,0)=XMINREC,$P(XMINREC,U,15)=XMSVAL,^(0)=XMINREC
 Q
PROCESS(XMINST,XMB) ;
 N XMK,XMZ
 S XMK=XMINST+1000
 I '$$BMSGCT^XMXUTIL(.5,XMK) D  Q
 . D DOTRAN^XMC1(42358) ; There are no messages in the queue to send
 ; First send msgs the postmaster has flagged to go first
 ; (NETWORK MESSAGE FLAG) set to 1), then send rest.
 F  S XMZ=$$NEXT(XMK) Q:XMZ=""  D  Q:ER
 . L +^XMNET(XMINST,XMZ):0 E  D  Q
 . . S XMC("NOREQUEUE")=1
 . . D ERTRAN^XMC1(42354) ;Queue being transmitted by another job - Aborting now.
 . D SENDMSG^XMS1(XMK,XMZ,.XMB)
 . I '$D(^XMB(3.9,XMZ,1,"AQUEUE",XMINST)) D ZAPIT^XMXMSGS2(.5,XMK,XMZ) H 1
 . I ER,$G(ER("NONFATAL")) D
 . . K ER S ER=0
 . . I $D(^XMB(3.7,.5,2,XMK,1,XMZ,0)) D XP^XMXMSGS1(.5,XMK,XMZ,2) ; Set xmit priority LOW
 . . D RSET
 . L -^XMNET(XMINST,XMZ)
 Q
NEXT(XMK) ; Returns the next message (XMZ) in basket XMK to go out.
 ; The next XMZ flagged 'high-priority' is next.
 ; Barring that, the next 'regular-priority' XMZ is next.
 ; Barring that, the next 'low-priority' XMZ is next.
 ; If an XMZ was involved in the failure of the previous transmission,
 ; that XMZ will be 'low-priority'.
 N XMZ,XMOK
 S XMZ=$$NEXTPRI(XMK,1) Q:XMZ XMZ  ; Get next high priority msg, if any
 S (XMZ,XMOK)=0 ; Get next regular priority msg, if any
 F  S XMZ=$O(^XMB(3.7,.5,2,XMK,1,XMZ)) Q:'XMZ  D  Q:XMOK
 . Q:$D(^XMB(3.7,.5,2,XMK,1,"AC",2,XMZ))  ; Skip if low priority
 . S:$$NEXTOK(XMK,XMZ) XMOK=1 ; Check msg OK
 Q:XMZ XMZ
 Q $$NEXTPRI(XMK,2)  ; Get next low priority msg, if any
NEXTPRI(XMK,XMTPRI) ; Get the next high/low priority message
 N XMZ
 F  S XMZ=$O(^XMB(3.7,.5,2,XMK,1,"AC",XMTPRI,0)) Q:'XMZ  D  Q:XMZ
 . I '$D(^XMB(3.7,.5,2,XMK,1,XMZ,0)) D  Q
 . . K ^XMB(3.7,.5,2,XMK,1,"AC",XMTPRI,XMZ) ; msg not in bskt, kill xref
 . . S XMZ=0
 . I '$$NEXTOK(XMK,XMZ) S XMZ=0 ; Check msg OK
 Q XMZ
NEXTOK(XMK,XMZ) ; Ensure msg is in file 3.9 & still has recipients q'd 
 I $D(^XMB(3.9,XMZ,0)),$O(^XMB(3.9,XMZ,1,"AQUEUE",XMK-1000,0)) Q 1
 D ZAPIT^XMXMSGS2(.5,XMK,XMZ)
 Q 0
QUIT ;
 Q:$G(XMC("QUIT"))
 S XMSG="QUIT" X XMSEN Q:ER
 X XMREC
 S XMC("QUIT")=1
 Q
RSET ; Send: "RSET"
 ; Recv: "250"
 S XMSG="RSET" X XMSEN Q:ER!XMC("BATCH")
 X XMREC Q:ER
 I $E(XMRG)'=2 S ER=1
 Q
TURN(XMINST) ; Turn around channel
 ; Send: "TURN"
 ; Recv: "250 REMOTE.MED.VA.GOV has messages to export"
 ;   or: "502 REMOTE.MED.VA.GOV has no messages to export"
 Q:XMC("TURN")!XMC("BATCH")
 I $F("Yy",$P(^DIC(4.2,XMINST,0),U,16))>1 D  Q
 . D DOTRAN^XMC1(42355.1,XMSITE) ; TURN command disabled for |1|
 S XMC("TURN")=1
 N XMFDA,XMIENS
 S XMIENS=XMINST_","
 S XMFDA(4.2999,XMIENS,1)=$H
 S XMFDA(4.2999,XMIENS,25)=$S($D(ZTQUEUED):$G(ZTSK),1:"@") ; Task number
 D FILE^DIE("","XMFDA")
 S XMSG="TURN" X XMSEN Q:ER
 X XMREC Q:$E(XMRG)'="2"!ER
 D DOTRAN^XMC1(42355) ;Turning around receiver
 G RECEIVE^XMR ; Go into receive mode
 Q
CHRISTN ; Christen the remote domain
 S XMSG="CHRS "_XMC("CHRISTEN") X XMSEN Q:ER  X XMREC Q:ER
 Q
TESTLNK ; Test the link
 N XMSTIME,XMETIME,XMTLER,XMCHARS,XMUERR,XMLINES
 S XMSG="ECHO" X XMSEN I ER D TESTERR Q
 X XMREC I ER D TESTERR Q
 S XMSTIME=$$NOW^XLFDT
 D TESTIT(.XMLINES,.XMCHARS,.XMUERR,.XMTLER)
 S XMETIME=$$NOW^XLFDT
 D:ER TESTERR
 U IO(0)
 D TESTRSLT(XMSTIME,XMETIME,XMLINES,XMCHARS,XMUERR,XMTLER)
 Q
TESTERR ;
 S XMSG="****Physical link protocol error.  Unable to proceed" D TRAN^XMC1
 Q
TESTIT(XMLINES,XMCHARS,XMUERR,XMTLER) ;
 N I
 S (I,XMLINES,XMCHARS,XMUERR,XMTLER)=0
 F  S I=$O(^TMP("XMS",$J,"S",I)) Q:'I  S XMSG=^(I) D  Q:ER
 . S XMLINES=XMLINES+1
 . S XMCHARS=XMCHARS+$L(XMSG)
 . X XMSEN Q:ER  X XMREC Q:ER
 . Q:XMRG=XMSG
 . S XMUERR=XMUERR+1
 . U IO(0)
 . S XMSG="*****Sent:  "_XMSG D TRAN^XMC1
 . S XMSG="*****Rec'd: "_XMRG D TRAN^XMC1
 . U IO
 Q:ER
 S XMSG="." X XMSEN Q:ER  X XMREC
 Q
TESTRSLT(XMSTIME,XMETIME,XMLINES,XMCHARS,XMUERR,XMTLER) ;
 S XMSG=XMLINES_" Lines,"_XMCHARS_" characters transmitted." D TRAN^XMC1
 S XMSG="Errors detected: "_XMUERR_" unrecoverable, "_XMTLER_" recoverable."
 S XMSG=$J(XMCHARS/$$FMDIFF^XLFDT(XMETIME,XMSTIME,2),0,1)_" chars/sec effective transmission rate." D TRAN^XMC1
 Q
