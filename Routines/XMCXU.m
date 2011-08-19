XMCXU ;ISC-SF/GMB- Select Domains/Scripts ;04/17/2002  08:43
 ;;8.0;MailMan;;Jun 28, 2002
ASK(XMINST,XMSITE,XMB,XMABORT,XMSCREEN,XMOKTYPE) ;
 D ASKINST(.XMINST,.XMSITE,.XMABORT,.XMSCREEN) Q:XMABORT
 D ASKSCR(XMINST,XMSITE,.XMB,.XMABORT,.XMOKTYPE)
 Q
ASKINST(XMINST,XMSITE,XMABORT,XMSCREEN) ; Lookup domain, perhaps using screen
 N DIC,X,Y,D,XMCX,XMCXC,XMCXM
 S XMCXM=$$EZBLD^DIALOG(34007.2) ; msgs
 S XMCXC=$$EZBLD^DIALOG(42281)   ;* Closed *
 S DIC=4.2,DIC(0)="AEQM",D="B^C"
 S DIC("W")="S XMCX=($P(^(0),U,2)[""C"") W ?50,$J($$BMSGCT^XMXUTIL(.5,Y+1000),6),XMCXM W:XMCX ?65,XMCXC"
 I $G(XMSCREEN)'="" D
 . I $L(XMSCREEN)>1 S DIC("S")=XMSCREEN
 . I XMSCREEN="M" D
 . . N XMTEXT
 . . W !
 . . ;This option lets you select only those queues which have messages.
 . . ;If you can't select a queue, it either doesn't exist or it has no messages.
 . . D BLD^DIALOG(42282,"","","XMTEXT","F")
 . . D MSG^DIALOG("WM","","","","XMTEXT")
 . . W !
 . . S DIC("S")="I $O(^XMB(3.7,.5,2,Y+1000,1,0))"
 . . ;Select queue.  Only queues with messages are shown.
 . . D BLD^DIALOG(42283,"","","DIC(""?"")")
 D MIX^DIC1 I Y=-1 S XMABORT=1 Q
 S XMINST=+Y
 S XMSITE=$P(Y,U,2)
 Q
ASKSCR(XMINST,XMSITE,XMB,XMABORT,XMOKTYPE) ;
 D SCRIPT^XMKPR1(XMINST,XMSITE,.XMB,.XMOKTYPE)
 I 'XMB("SCR IEN") W !,$$EZBLD^DIALOG(42284) S XMABORT=1 Q  ;No valid script for this domain!
 D SCRIPT(XMINST,XMSITE,.XMB,.XMABORT) Q:XMABORT
 Q
SCRIPT(XMINST,XMSITE,XMB,XMABORT) ; Ask user to select the script.
 ; List valid entries.
 N I,XMREC,XMTEXT
 W !
 ;  #  Script Name       Type       Priority
 ; --  -----------       ----       --------
 D BLD^DIALOG(42285,"","","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 S I=0
 F  S I=$O(^DIC(4.2,XMINST,1,I)) Q:'I  S XMREC=^(I,0) W !,$J(I,3),?5,$P(XMREC,U),?30,$P(XMREC,U,4),?40,$J($P(XMREC,U,2),2) I $P(XMREC,U,7) W ?50,$$EZBLD^DIALOG(42286) ;* Out of Service *
 W !
 I $O(^DIC(4.2,XMINST,1,0))=XMB("SCR IEN"),+$O(^(XMB("SCR IEN")))=0 Q
 N DIC,X,Y
 S DIC="^DIC(4.2,XMINST,1,"
 S DIC(0)="AEQMNZ"
 S DIC("A")=$$EZBLD^DIALOG(42287) ;Select Script:
 S DIC("B")=XMB("SCR IEN")
 S DIC("W")="W ?30,$P(^(0),U,4),?40,$J($P(^(0),U,2),2) W:$P(^(0),U,7) ?60,$$EZBLD^DIALOG(42286)" ;* Out of Service *
 D ^DIC I Y=-1 S XMABORT=1 Q
 Q:+Y=XMB("SCR IEN")
 S (XMB("SCR IEN"),XMB("FIRST SCRIPT"))=+Y
 D INITSCR^XMKPR1(XMINST,XMSITE,.XMB)
 Q
CHKTSK(XMINST,XMCHOOSE,XMABORT) ;
 N XMTSK,XMTEXT,XMPARM
 S XMTSK=$$TSKEXIST^XMKPR(XMINST) Q:'XMTSK
 I +XMTSK=XMTSK D  Q
 . W !,$C(7) ;Task |1| is transmitting this domain's messages now.
 . D BLD^DIALOG(42288,XMTSK,"","XMTEXT","F")
 . D MSG^DIALOG("WM","","","","XMTEXT")
 . S XMABORT=1
 W !,$C(7) ;Task |1| is scheduled to transmit this domain's messages
 ;on |2|.
 S XMPARM(1)=+XMTSK,XMPARM(2)=$$HTE^XLFDT($P(XMTSK,U,2),5)
 D BLD^DIALOG(42288.1,.XMPARM,"","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 S XMTSK=+XMTSK
 N DIR,X,Y
 S DIR(0)="Y",DIR("B")=$$EZBLD^DIALOG(39053) ;NO
 D BLD^DIALOG($S(XMCHOOSE=1:42289,1:42289.1),XMTSK,"","DIR(""A"")")
 ;1: Do you want to kill task |1| and queue up a new one
 ;2: Do you want to kill task |1| before we play the script
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 I 'Y S:XMCHOOSE=1 XMABORT=1 Q
 D KILLTSK^XMKPR(XMINST,XMTSK)
 Q
