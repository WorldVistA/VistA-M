XMUT5R2 ;(WASH ISC)/CAP-Daily Reports on mail deliveries ;04/17/2002  12:07
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; ACT     XMMGR-BKFILER-ACT
 ; ASK     XMMGR-BKFILER-EDIT-NORMALIZED
 ; GROUP   XMMGR-BKFILER-GROUP
 ; STAT    XMMGR-BKFILER-STAT
 ; TAB     XMMGR-BKFILER-TABBED-STATS
 ; WAIT    XMMGR-BKFILER-WAIT
0 ;
 N Y
 S XMA=$$FMADD^XLFDT(DT,-1)
 I '$D(ZTQUEUED) S XMA=$$DATE("RUN",$$FMTE^XLFDT(XMA,"2Z")) Q:XMA=""
 S XMB=XMA_".2359"
 S Y=DT D DD^%DT S XMD=Y
 Q
GO ;Call FileMan to produce report
 S XMC=$P(^XMB("NETNAME"),".")_" "_L
 I '$D(ZTQUEUED) W !!,"Calling FileMan template ..."
 ;
 ;XMA=Start Date FM format
 ;XMAH=Start Date $H format
 ;XMB=End Date FM format
 ;XMBH=End Date $H format
 S XMV=^%ZOSF("PROD")
 S:'$D(BY) BY=.01 S FR=XMA,TO=XMB,DIC="^XMBX(4.2998,"
 S:$D(ZTQUEUED) IOP=ZTIO D EN1^DIP
Q ;
 K BY,DIC,DIS,FLDS,FROM,TO,XMA,XMB,XMAH,XMBH,X,Y,Z,%ZIS,ZTRTN,ZTSAVE,ZTDTH
 I '$D(ZTQUEUED) K ZTSK
 Q
DATE(X,Z) ;Calculate Date - Ask Start and End Dates
 N DUOUT,DTOUT,XMA,DIR,Y S DIR(0)="D^::XEP",DIR("A")=X_" Date",DIR("B")=Z
D D ^DIR K DIRUT I $D(DUOUT)!$D(DTOUT) Q ""
 S XMA=Y I XMA'?7N.E D ^%DT X XMA=Y
 D NOW^%DTC I %-XMA<0 W !,$C(7)," No Future Dates !!!" G D
 Q XMA
ACT ;Active Users verses Deliveries Report
 D 0 Q:XMA=""  K BY
 S FLDS="[XMMGR-BKFILER-ACTIVE_USERS/DEL]",L="Active Users/Deliveries Report"
 G GO
GROUP ;Deliveries by group
 D 0 Q:XMA=""  K BY
 S FLDS="[XMMGR-BKFILER-DEL_BY_GROUP]",L="Deliveries by Group Report"
 G GO
QUEUE ;Queue Length
 D 0 Q:XMA=""  K BY
 S FLDS="[XMMGR-BKFILER-LENGTH_OF_QUEUES]",L="Length of Delivery Queues Report"
 G GO
WAIT ;Queue Wait
 D 0 Q:XMA=""  K BY
 S FLDS="[XMMGR-BKFILER-QUEUE-WAIT]",L="Active Users/Deliveries Report"
 G GO
STAT ;Statistics / Active Users, Deliveries, Queue Wait, Response Time
 D 0 Q:XMA=""  K BY
 S FLDS="[XMMGR-BKFILER-STATS-PLUS]",L="Statistics Report"
 G GO
TAB ;Statistics for download to graphics package
 D 0 Q:XMA=""  S BY="@.01"
 S FLDS="[XMMGR-BKFILER-STATS/TABBED]",L=""
 G GO
ASK ;Ask parameters
 N DIRUT F X=1:1:5 S A=$$ASS(X) Q:$D(DIRUT)  S $P(^XMB(1,1,7),",",X)=A
 Q
ASS(I) N DIR,X,Y,Z
 S X=$P("Active Users,Lines Displayed,Message & Response Deliveries,Queue Lengths,Response Time",",",I)
 S DIR(0)="N^.1:9999999999",DIR("A")="Enter normalized "_X,DIR("B")=$P($G(^XMB(1,1,7)),",",I)
 D ^DIR
 Q X
