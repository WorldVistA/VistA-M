XMAI2 ;ISC-SF/GMB -Send a message if too many messages ;04/19/2002  12:41
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP/L.RHODE
 ; Entry points used by MailMan options (not covered by DBIA):
 ; ENTER   XMMGR-DISK-MANY-MESSAGE-MAINT
ENTER ;
 N XMMAX,XMSAVE,XMABORT,I
 S XMABORT=0
 D INIT(.XMMAX,.XMABORT) Q:XMABORT
 I $D(ZTQUEUED) D PROCESS Q
 F I="XMMAX" S XMSAVE(I)="" ;MailMan: Many Msg Maint Request
 D EN^XUTMDEVQ("PROCESS^XMAI2",$$EZBLD^DIALOG(36600),.XMSAVE)
 Q
INIT(XMMAX,XMABORT) ;
 S XMMAX=500 ; Threshold number of messages a user can own
 Q:$D(ZTQUEUED)
 N DIR,Y,DIRUT,XMTEXT
 W !
 ;This option sends a message to every user who has more than a
 ;certain number of messages in his or her mailbox, asking the user
 ;to terminate unnecessary messages.
 D BLD^DIALOG(36601,"","","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 W !
 S DIR(0)="N^10::"
 S DIR("A")=$$EZBLD^DIALOG(36602) ;Enter the 'many message' threshold
 S DIR("B")=XMMAX
 D BLD^DIALOG(36603,"","","DIR(""?"")") ;How many messages may a user have before MailMan sends a nastygram?
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 S XMMAX=Y
 W !
 ;Messages will be sent to owners of more than |1| messages.
 ;This option may take awhile - you may wish to queue it.
 D BLD^DIALOG(36604,XMMAX,"","XMTEXT","F")
 D MSG^DIALOG("WM","","","","XMTEXT")
 Q
PROCESS ; (Requires XMMAX)
 N XMUSER,XMCNT
 S XMUSER=.9999
 F  S XMUSER=$O(^XMB(3.7,XMUSER)) Q:XMUSER'>0  D
 . S XMCNT=$$TMSGCT^XMXUTIL(XMUSER)
 . D:XMCNT>XMMAX MESSAGE(XMUSER,XMCNT)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
MESSAGE(XMTO,XMCNT) ; Send message
 N XMPARM,XMINSTR
 S XMINSTR("FROM")=.5,XMINSTR("FLAGS")="I"
 S XMPARM(1)=XMCNT,XMPARM(2)=$$BMSGCT^XMXUTIL(XMTO,1)
 D TASKBULL^XMXBULL(.5,"XM TOO MANY MESSAGES",.XMPARM,"",XMTO,.XMINSTR)
 Q
