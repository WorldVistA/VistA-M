XMUT5Q1 ;(WASH ISC)/CAP-Delivery Queue Analysis (start/init) ;04/17/2002  12:02
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; OPTION   XMMGR-DELIVERY-STATS-COLL
 ;
 ;R array is for responses
 ;M array is for messages
 ;
 ;("T")=total
 ;("N")=Not queued last check
 ;("D")=[time stamped entries] = frequency ^ total time in queue
 ;("O",I)=Oldest message for grouping I -- Up to 10 groupings
 ;    1st piece is frequency, 2nd piece is time in queue
 ;
 ;Killing XMUT5NO causes the process to be tasked into background
 K XMUT5NO
 ;
 ;GET GROUPINGS INTERACTIVELY
0 K C S I=1 D GET^XMUT5Q Q:X[U  S C("MGROUPS")=X
 S I=2 D GET^XMUT5Q Q:X[U  S C("RGROUPS")=X
 G TASKED:$D(XMUT5NO)
 ;
1 W !!,"Run at 30-minute intervals !!",!!
 ;I X["?" W !,"This is the interval that backgroud tasks will be rescheduled.",!,"Long intervals may not pick up any data.  Short intervals are best,",!,"because the times collected may be off by as much as the interval for the"
 ;I  W !,"interval a message was in the queue for.  ENTER THE NUMBER OF SECONDS !"
 ;I  G 1
 ;I X'?1.N W "  Enter a time in seconds" G 1
 ;I X<300 W "  Intervals must be at least 5 minutes apart." G 1
 ;I X>1800 W "  Intervals must be less than 1/2 hour." G 1
 S XMUT5S=X
 ;
2 R !!,"How many times do you want to analyze the message delivery queue: 4//",X:DTIME I X="" S XMUT5F=0 G GO
 I X["?" W !,"The analysis will be automatically rescheduled this number of times." G 2
 I X'?1.N!(X>9999999) W $C(7),!,"Type in a number between 0 and 9999999." G 2
 S XMUT5F=X
 ;
TASKED ;Don't queue task if $D(XMUT5NO)
 G GO:$D(XMUT5NO)
 ;
 W !!,"I am queuing this job to run on the next half-hour.  It will run every half-hour",!,"on the hour until the task is deleted or it is stopped by setting",!,"^XMBPOST(""XMUT5STOP"")=1."
 K ^XMBPOST("XMUT5STOP") D ZTSK^XMUT5Q W !!,"QUEUED !!! TASK # "_ZTSK,!!
 Q
 ;
GO S %=$G(^XMB(1,1,6)) I $L(%) S C("MGROUPS")=$P(%,"^"),C("RGROUPS")=$P(%,"^",2)
GO2 ;
 ;
 ;Delete reschedule frequency just in case -- reschedules itself
 S (DIE,DIC)="^DIC(19,",DIC(0)="",X="XMMGR-DELIVERY-STATS-COLL" D ^DIC
 I Y>0 S DA=+Y,DR="202///@" D ^DIE
 K DIC,DR,DIE
 I '$D(ZTQUEUED) W !!,"Analysis of queue starts now !!!",!
 S XMUT5=1 K A,B,M,R,RSP G ZTSK0^XMUT5Q:$D(^XMBPOST("XMUT5STOP"))
 S (A,C,M,R)=0
 F I="A","N","D","T",1:1:10 S:'I M(I)=0,R(I)=0 S:I M("O",I)=0,R("O",I)=0
 S:'$D(XMUT5S) XMUT5S=1800 D ^XMUT5B
QUIT ;End process
 G QUIT^XMUT5Q
NOTASK ;Run in foreground once
 G NOTASK^XMUT5Q
OPTION ;
 D ^XMUT5B,REC^XMUT5Q
 I $D(ZTQUEUED) S ZTRTN="OPTION^XMUT5Q1" D GO^XMUT5Q S ZTREQ="@" Q
 W !!,"Stats collected.  If you would like them to be collected automatically",!
 W !,"every 1/2 hour, please schedule this option via TaskMan.",!!
 Q
