XMUT5 ;ISC-SF/GMB-Check Background Filer (local delivery queues) ;02/12/2003  07:42
 ;;8.0;MailMan;**10,2**;Jun 28, 2002
 ;(WASH ISC)/CAP
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; CHECK    XMMGR-CHECK-BACKGROUND-FILER
CHECK ;
 N XMTEXT
 ;* Latest Delivery shows last user with message in mailbox.
 ;Meaningful for new messages, possibly meaningful for (f) forwarded messages.
 ;Not meaningful and not shown for responses.
 D BLD^DIALOG(36222,"","","XMTEXT(""*"")","F")
 D BLD^DIALOG(36219,"","","XMTEXT(""M"")","F")
 D BLD^DIALOG(36220,"","","XMTEXT(""R"")","F")
 I $D(ZTQUEUED)!($E($G(IOST),1,2)'="C-") D DISPLAY Q
 F  D DISPLAY D  Q:'(Y!$D(DTOUT))
 . W !
 . N DIR,X,DTIME
 . S DTIME=5
 . S DIR(0)="Y",DIR("A")=$$EZBLD^DIALOG(36210) ; Refresh
 . S DIR("B")=$$EZBLD^DIALOG(39054) ; YES
 . D BLD^DIALOG(36211,"","","DIR(""?"")")
 . ;Answer YES if you want the display refreshed.
 . ;Answer NO if you don't.
 . ;If you don't answer, the display will be refreshed every five seconds.
 . D ^DIR
 Q
DISPLAY ;
 N XMQLIST,M,R,XMTSTAMP,XMPARM
 W !!,$$EZBLD^DIALOG(36212,$$FMTE^XLFDT($$NOW^XLFDT,5)),! ; Delivery Queue Status as of
 S M=$G(^XMBPOST("STATS","M")),R=$G(^("R"))
 I M+R>0 D
 . S XMPARM(1)=M+R,XMPARM(2)=M,XMPARM(3)=R
 . W !,$$EZBLD^DIALOG(36213,.XMPARM) ; Deliveries COMPLETED since last 1/2 hour: _M+R_ (_M_ Msg, _R_ Resp)
 D GO^XMUT5B
 D GETQ^XMKPLQ(.XMQLIST)
 S XMPARM(1)=$S(XMQLIST("M")="":1,1:$L(XMQLIST("M"),",")+1)
 S XMPARM(2)=$S(XMQLIST("R")="":1,1:$L(XMQLIST("R"),",")+1)
 W !,$$EZBLD^DIALOG(36214,.XMPARM) ; Number of delivery queues: |1| Message and |2| Response
 S XMTSTAMP=$O(^XMBPOST("BOX",0))
 I XMTSTAMP W !,$$EZBLD^DIALOG(36215,$$WAITIME(XMTSTAMP)) ; Waiting time for items to be put in the delivery queues:
 E  W !,$$EZBLD^DIALOG(36216) ; Nothing waiting to be put in the delivery queues.
 I M("T")+R("T")<1 W !!,$$EZBLD^DIALOG(36217) ; Nothing in the delivery queues.
 E  D
 . W !,$$EZBLD^DIALOG(36218,M("T")+R("T")) ; Items currently waiting in delivery queues:
 . I M("T")>0 D SHOWQ("M",.M,XMQLIST("M"))
 . I R("T")>0 D SHOWQ("R",.R,XMQLIST("R"))
 . I M("T") D MSG^DIALOG("SWM","",80,"","XMTEXT(""*"")")
 D SHOWFILR
 Q
SHOWQ(XMGROUP,Q,XMQLIST) ;
 D MSG^DIALOG("SWM","",80,"","XMTEXT(XMGROUP)")
 N I,XMCNT
 S XMCNT=0
 F I=1:1:10 I Q("O",I) D
 . S XMCNT=XMCNT+1
 . W !,$J(I,2),"  ",$$QRANGE(XMQLIST,I)
 . W ?17,$J(+Q("O",I),7),?27,$J($P(Q("O",I),U,3),8),?39,$J($$WAITIME($P(Q("O",I),U,2)),12),$J($P(Q("O",I),U,4),16),$J($P(Q("O",I),U,5),3),$J($P(Q("O",I),U,6),9)
 I XMCNT>1 W !,?3,$$EZBLD^DIALOG(36221),?17,$J(+Q("T"),7),?27,$J($P(Q("T"),U,3),8),?39,$J($$WAITIME($P(Q("T"),U,2)),12) ; Summary
 Q
SHOWFILR ;
 N XMSTATUS,I
 D STATUS^XMKPL(.XMSTATUS)
 W !!,$$EZBLD^DIALOG(36224) ; Background filer status:
 I $D(XMSTATUS)<10 D
 . W $$EZBLD^DIALOG(36225) ; ALL Background Delivery jobs are RUNNING.
 E  D
 . I $P(^XMB(1,1,0),U,16) D
 . . N XMTEXT ; The Background Filers have been shut down.
 . . D BLD^DIALOG(36226,"","","XMTEXT","F")
 . . D MSG^DIALOG("SWM","",80,"","XMTEXT")
 . W !
 . S I=""
 . F  S I=$O(XMSTATUS(I)) Q:I=""  W !,XMSTATUS(I)
 Q
QRANGE(XMQLIST,I) ; Queue range
 I XMQLIST="" Q "(...)"
 I I=1 Q "<"_+XMQLIST
 I I>$L(XMQLIST,",") Q $P(XMQLIST,",",I-1)_"+"
 Q $P(XMQLIST,",",I-1)_"-"_($P(XMQLIST,",",I)-1)
WAITIME(X) ;
 N XMDIFF,XMWAIT
 S XMDIFF=$$TSTAMP^XMXUTIL1-X
 S XMWAIT=""
 S:XMDIFF'<86400 XMWAIT=(XMDIFF\86400)_" "
 S:XMDIFF#86400 XMWAIT=XMWAIT_(XMDIFF#86400\3600)_":"_$E(XMDIFF#3600\60+100,2,3)_":"_$E(XMDIFF#60+100,2,3)
 Q XMWAIT
