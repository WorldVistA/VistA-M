XQSRV1 ;SEA/MJM - Server option utilities ;10/15/96  13:14
 ;;8.0;KERNEL;**50**;Jul 10, 1995
 ;
 ;File the message in POSTMASTER'S mailbox of option's name
 S XQSRV=$P(XQ220,U,7) S:XQSRV="" XQSRV=1
 I XQSRV S XMXX="S."_XQSOP,XMZ=XQMSG D SETSB^XMA1C
 ;
 ;Check for a resource
 S XQRES=$P(XQ220,U,8) I XQRES'="",($D(^%ZIS(1,XQRES,0))) S XQRES=$P(^(0),U)
 E  S XQRES=""
 ;
 I $D(XMFROM),XMFROM=+XMFROM,$D(^VA(200,+XMFROM,0)) S XMFROM=$P(^(0),U)
 I XQSUB["~U~" F XQI=0:0 Q:XQSUB'["~U~"  S XQSUB=$P(XQSUB,"~U~")_"^"_$P(XQSUB,"~U~",2,99)
 ;
TASK ;Set up task parameters and call Taskman
 S XQRTN="" S:$D(^DIC(19,+XQY,25)) XQRTN=^(25) S:XQRTN'["^" XQRTN="^"_XQRTN
 ;I XQMD="R"&'($D(^DIC(19,XQY,3.91,0))&($P(^(0),U,4)>0)) S X=$P(XQY0,U,8) X:$L(X) ^%ZOSF("PRIORITY") G ZTSK^XQSRV2 ;Just go do it!
 I XQMD="R"&'($P($G(^DIC(19,XQY,3.91,0)),U,4)>0) S X=$P(XQY0,U,8) X:$L(X) ^%ZOSF("PRIORITY") G ZTSK^XQSRV2
 I XQMD="R" S XQMD="Q" ;Must be queued if days/times are restricted
 ;
 S ZTPRI=$P(XQY0,U,8),ZTRTN="ZTSK^XQSRV2",ZTDESC="Server Request: "_$P(XQY0,U,2)_" Message #: "_XQMSG,ZTIO=XQRES
 S XQDAYS=$P(XQ220,U,9) S:(XQDAYS'>0) XQDAYS=14 S ZTKIL=$P($H,",")+XQDAYS_",00000" ;Retention time to save task in ZTSK
 S ZTSAVE("XQY")="",ZTSAVE("XQY0")="",ZTSAVE("XQ220")="",ZTSAVE("XQLTL")="",ZTSAVE("XQAUDIT")="",ZTSAVE("XQREPLY")="",ZTSAVE("XQSUP")="",ZTSAVE("XQNOUSR")=""
 S ZTSAVE("XQMSG")="",ZTSAVE("XQSUB")="",ZTSAVE("XQSND")="",ZTSAVE("XQRTN")="",ZTSAVE("XQSOP")="",ZTSAVE("XQMD")="",ZTSAVE("XQDATE")="",ZTSAVE("XQMB6")="",ZTSAVE("XQMB")=""
 S ZTSAVE("XMREC")="",ZTSAVE("XMFROM")="",ZTSAVE("XMCHAN")="",ZTSAVE("XMXX")="",ZTSAVE("XMZ")=""
 ;
 I XQMD="N" S ZTDTH=$H+2_",0" D ^%ZTLOAD,XQ^XUTMT S XQMB6="Server request for "_XQSOP_".  Task # "_ZTSK_" needs to be scheduled." G OUT
 I XQMD="Q" S X=XQLTL D
 .N Y S Y=+XQY D NEXT^XQ92 S XQX=X
 .I XQX="" S XQER="Scheduling Error: All days and times for the option "_XQSOP_" are prohibited."
 .I XQX'="" S (ZTDTH,XQDTH)=X D ^%ZTLOAD S XQMB6="Server request queued for "_XQDTH_" task # "_ZTSK
 G:(XQX'="") KILL^XQSRV2
 ;
OUT ;Trigger the bulletin, do the audit, and split.
 D:XQAUDIT AUDIT,AUDIT^XQSRV2
 G OUT^XQSRV2
 Q
 ;
AUDIT ;Enter the option audit data in Audit Log for Option File
 D GETENV^%ZOSV S XQVOL=$P(Y,U,2)
 F XQI=0:0 S XQLTL=XQLTL+.0000001 I '$D(^XUSEC(19,XQLTL,0))#2 L +^XUSEC(19,0) S $P(^(0),U,3,4)=XQLTL_"^"_($P(^XUSEC(19,0),U,4)+1) L -^XUSEC(19,0)  Q
 S ^XUSEC(19,XQLTL,0)=XQY_U_DUZ_U_$I_U_$J_U_U_XQVOL
 S ^XUSEC(19,XQLTL,1)=XQMSG_U_XMFROM
 S ^XUSEC(19,XQLTL,2)=XQSUB
 Q
 ;
REQUE ; Requeue a server option not previously queued due to some problem
 R !,"Message Number of Server message: ",XQMSG:DTIME Q:'$T!(XQMSG="")!(XQMSG[U)!(XQMSG'>0)
 I '$D(^XMB(3.9,XQMSG)) W !,$C(7),"Invalid MESSAGE NUMBER",! G REQUE
 F I=0:0 S I=$O(^XMB(3.9,XQMSG,1,I)) Q:I'>0  S XQ=^(I,0) I "S.s."[$E(XQ,1,2) S XQ=$P(XQ,U,1) Q
 I "S.s."'[$E(XQ,1,2) W !,$C(7),"MESSAGE is NOT a SERVER MESSAGE",! G REQUE
 S %DT="AET",%DT("A")="Date/time to run server program: ",%DT("B")="NOW" D ^%DT I Y>0 S ZTDTH=Y
 S X=$E(XQ,3,$L(XQ))_U_XQMSG S I=$P(^XMB(3.9,XQMSG,0),U,2),X=X_U_$S(I'>0:I,'$D(^VA(200,+I,0)):"UNKNOWN",1:$P(^(0),U,1))_U_$P(^XMB(3.9,XQMSG,0),U,1)
 G ^XQSRV
