XMR ;ISC-SF/GMB-SMTP Receiver (RFC 821) ;09/24/2003  12:25
 ;;8.0;MailMan;**22**;Jun 28, 2002
ENT ; INITIALIZE
 S ER=0
 S XMC("NOREQUEUE")=1
 D GET^XMCXT(0)
 I '$D(XMC("BATCH")) S XMC("BATCH")=0
 D OPEN^XML I ER!$G(POP) D  Q
 . D ^%ZISC:IO'=$G(IO(0)) W !,$C(7),$$EZBLD^DIALOG($S(ER:42227,1:37000)) ;Open failed / up-arrow out.
 S:'$D(XM) XM=""
 I XMC("BATCH") U IO
 E  D
 . X ^%ZOSF("EOFF")
 . S X=255
 . X ^%ZOSF("RM"),^%ZOSF("TYPE-AHEAD")
 S XMC("START")=$$TSTAMP^XMXUTIL1-.001
 D RECEIVE
 ;I $G(XMINST) D XMTFINIS^XMTDR(XMINST)
 Q
RECEIVE ; BEGINNING OF INTERPRETER
 ; The following variables are used in here only.  They are not
 ; 'new'd because this routine may be called recursively via the
 ; TURN command, which alternates sending and receiving.
 S XMC("DIR")="R"
 D KILL
 S XMEC=0,XMCONT="^HELP^NOOP^RSET^QUIT^VRFY^EXPN^STAT^CHRS^ECHO^"
 D DOTRAN^XMC1(42300,$$FMTE^XLFDT(DT,5)) ;Transcript Date: |1|
 S XMSTATE="^HELO^QUIT^"
 I 'XMC("BATCH") D
 . D BUFLUSH^XML
 . W:'$D(XMNO220) 220
 . H 2
 . S XMSG="220 "_$G(^XMB("NETNAME"))_" MailMan "_$P($T(XMR+1),";",3)_" ready" X XMSEN
 F  D  Q:ER!($G(XMCMD)="QUIT")!$G(XMC("QUIT"))
 . D DOTRAN^XMC1(42301) ;Waiting for input
 . S XMSTIME=300 X XMREC K XMSTIME Q:ER
 . S XMP=XMRG
 . F I=$C(9),"  " F  Q:XMP'[I  S XMP=$P(XMP,I,1)_" "_$P(XMP,I,2,999) ; strip tabs / extra blanks
 . S XMCMD=$$UP^XLFSTR($P(XMP," ")),XMP=$P(XMP," ",2,999)
 . Q:XMCMD=""
 . I XMSTATE_XMCONT'[(U_XMCMD_U) D ERRCMD Q
 . I $T(@XMCMD)="" S XMSG="502 Command not implemented" X XMSEN Q
 . D @XMCMD
 I $G(XMCMD)="QUIT"!ER,$G(XMZ) D ZAPIT^XMXMSGS2(.5,.95,XMZ)
 S:$G(XMINST) $P(^XMBS(4.2999,XMINST,3),U,1,6)="^^^^^"
 D KILL
 Q
KILL ;
 K I,X,XMC("HELO RECV"),XMCMD,XMCONT,XMEC,XMINSTR,XMNVFROM,XMP
 K XMREMID,XMRXMZ,XMRVAL,XMSTATE,XM2LONG,XMZ,XMZFDA,XMZIENS
 K XMERR,^TMP("XMERR",$J)
 Q
CHRS ;;Christen this domain syntax: CHRS <parent>,<child>
 N XMPARENT,XMCHILD,X,Y,DIC
 S XMPARENT=$P(XMP,",",1),XMCHILD=$P(XMP,",",2)
 S X=XMPARENT
 S DIC=4.2,DIC(0)="MF"
 D ^DIC
 I +Y'=$P(^XMB(1,1,0),U,3) S XMSG="550 Parent name does not match locally initialized parent name" X XMSEN Q
 S X=XMCHILD
 S DIC=4.2
 D ^DIC
 I +Y'=$P(^XMB(1,1,0),U,1) S XMSG="550 Child name does not match locally initialized domain name" X XMSEN Q
 S ^XMB("NETNAME")=$P(Y,U,2)
 S $P(^XMB(1,1,0),U,4)=DT
 S XMSG="250 Local domain "_$P(Y,U,2)_" successfully christened by parent "_XMPARENT X XMSEN
 Q
DATA ;;TEXT / ASSUMES VALID RECIPIENT
 D DATA^XMR3
 Q
ECHO ;;ECHO TEST
 S XMSG="314 Echo mode. Received messages will be echoed until a single period is received" X XMSEN Q:ER
 F  X XMREC Q:ER  Q:XMRG="."  S XMSG=XMRG X XMSEN Q:ER
 Q:ER
 S XMSG="250 End of echo mode" X XMSEN
 Q
EXPN ;;EXPAND MAILING LIST
 N XMIEN,XMPTR,XMCNT,XMNETNAM,Y,X,DIC
 S X=XMP
 I X["<" S X=$P($P(X,"<",2),">")
 I "^G.^g.^"[(U_$E(X,1,2)_U) S X=$E(X,3,999)
 S DIC="^XMB(3.8,",DIC(0)="MF"
 D ^DIC I Y<0 S XMSG="550 mail group not found" X XMSEN Q
 S XMIEN=+Y,XMCNT=0,XMNETNAM=^XMB("NETNAME"),XMPTR=""
 F  S XMPTR=$O(^XMB(3.8,XMIEN,1,"B",XMPTR)) Q:'XMPTR  D  Q:ER
 . Q:'$D(^VA(200,XMPTR,0))
 . S XMCNT=XMCNT+1
 . S XMSG="250 <"_$TR($$NAME^XMXUTIL(XMPTR),". ,","+_.")_"@"_XMNETNAM_">" X XMSEN
 I 'XMCNT S XMSG="250 No LOCAL members in group" X XMSEN Q:ER
 S XMSG="250 List SHOWS local members only, not member groups, remote members or distribution lists." X XMSEN
 Q
HELO ;;HELO COMMAND
 D HELO^XMR1
 Q
HELP ;;DISPLAY HELP MESSAGE
 D HELPME^XMR4
 Q
MAIL ;;START
 D:$D(XMRVAL) VALSET^XMR1(XMINST,.XMRVAL)
 D MAIL^XMR1
 Q
MESS ;;
 D MESS^XMR2
 Q
NOOP ;;NO OPERATION FOR TESTING
 S XMSG="250 OK" X XMSEN
 Q
QUIT ;;
 D:$D(XMRVAL) VALSET^XMR1(XMINST,.XMRVAL)
 S XMSG="221 "_$G(^XMB("NETNAME"))_" Service closing transmission channel" X XMSEN
 S XMC("QUIT")=1
 Q
RCPT ;;
 D RCPT^XMR1
 Q
RSET ;;RESET STATE TABLES
 N X,XMI,Y,DIC
 I $G(XMZ) D
 . I $D(^XMB(3.9,XMZ,0)),'$D(^XMB(3.9,XMZ,1,0)) D KILLMSG^XMXUTIL(XMZ)
 . I $D(^XMB(3.7,.5,2,.95,1,XMZ)) D ZAPIT^XMXMSGS2(.5,.95,XMZ)
 S XMSTATE="HELO^MAIL^"
 K XMZ,XMZFDA,XMZIENS,^TMP("XMY",$J),^TMP("XMY0",$J)
 S XMSG="250" X XMSEN Q
 Q
STAT ;;
 N K,I,J
 I $G(XMNVFROM)'="" S XMSG="211-Current reverse path is: "_XMNVFROM X XMSEN Q:ER
 I $G(XMINST)'="" S XMSG="211-Current sender is: "_$P(^DIC(4.2,XMINST,0),U) X XMSEN Q:ER
 S XMSG="211-Acceptable commands at the moment are: " X XMSEN Q:ER
 S XMSG="211-"
 S K=XMSTATE_XMCONT F I=1:1:$L(K,U) S J=$P(K,U,I) I J'="" S XMSG=XMSG_J_" "
 X XMSEN Q:ER
 I $D(XMZ),$O(^XMB(3.9,XMZ,2,0))>0 D  Q:ER
 . S J=0
 . S XMSG="211-Current text buffer is:" X XMSEN Q:ER
 . F  S J=$O(^XMB(3.9,XMZ,2,J)) Q:J'>0  S XMSG="211-"_J_"  "_^(J,0) X XMSEN Q:ER
 Q:ER
 I $O(^TMP("XMY",$J,""))'="" D  Q:ER
 . S J=""
 . S XMSG="211-Current recipients are: " X XMSEN Q:ER
 . F  S J=$O(^TMP("XMY",$J,J)) Q:J=""  S XMSG="211-"_$S('J:J,1:$$NAME^XMXUTIL(J)) X XMSEN Q:ER
 Q:ER
 S XMSG="211 OK" X XMSEN
 Q
TURN ;;
 D:$D(XMRVAL) VALSET^XMR1(XMINST,.XMRVAL)
 ;TURN AROUND PROTOCOL
 I $F("Yy",$P(^DIC(4.2,XMINST,0),U,16))>1 S XMSG="502 "_^XMB("NETNAME")_" has TURN disabled." X XMSEN Q
 I '$O(^XMB(3.7,.5,2,XMINST+1000,1,0)) S XMSG="502 "_^XMB("NETNAME")_" has no messages to export" X XMSEN Q
 I $P(^DIC(4.2,XMINST,0),U)'=$G(XMC("HELO RECV")) S XMSG="502 TURN command rejected." X XMSEN Q
 S XMSG="250 "_^XMB("NETNAME")_" has messages to export" X XMSEN Q:ER
 D KILL
 G SEND^XMS
VRFY ;;VERIFY USER EXISTS
 N XMNAME
 S XMINSTR("ADDR FLAGS")="X" ; Do not expand
 S XMNAME=$$LOOKUP^XMR1(XMP,.XMINSTR)
 K XMINSTR("ADDR FLAGS")
 Q:XMNAME=0
 S XMSG="250 "_XMNAME_" <"_$TR(Y,". ,","+_.")_"@"_^XMB("NETNAME")_">" X XMSEN
 Q
ERRCMD ;
 S XMEC=XMEC+1
 I XMEC>9 S ER=1,XMSG="500 too many errors or fatal error, closing channel"
 E  S XMSG="500 Syntax error, command ("_XMCMD_") out of sequence, or unrecognized command"
 X XMSEN
 Q
TST ;
 S XM="",XMC("BATCH")=0,XMC("DX")=1,XMCHAN="TEST"
 D OPEN^XML
 D RECEIVE
 D KILL^XMC
 Q
DECNET ; Task-Task Communications
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D R^XMCTRAP"
 E  S X="R^XMCTRAP",@^%ZOSF("TRAP")
 S (IO,I0(0))="SYS$NET",XMCHAN="DECNET" D DT^DICRW O IO U IO
 G ENT
