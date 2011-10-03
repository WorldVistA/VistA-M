GMRCSTU ;SLC/DCM,dee - Statistic Utilities for C/RT ;09/26/02 10:16
 ;;3.0;CONSULT/REQUEST TRACKING;**1,7,29,30,43,61**;DEC 27, 1997;Build 2
 Q
 ;
GETDT(GMRCO) ;get the date that the consult/request was accepted by service
 N ND,GMRCDA
 S COMPLDT=9999999
 S ND=0 F  S ND=$O(^GMR(123,GMRCO,40,ND)) Q:ND?1A.E!(ND="")  D
 .S:$P(^GMR(123,GMRCO,40,ND,0),"^",2)=21 GMRCDA=$P(^(0),"^",1)
 .S:$P(^GMR(123,GMRCO,40,ND,0),"^",2)=1 GMRCDA(1)=$P(^(0),"^",1)
 .S:$P(^GMR(123,GMRCO,40,ND,0),"^",2)=15 GMRCDA(15)=$P(^(0),"^",3)
 .I $P(^GMR(123,GMRCO,40,ND,0),"^",2)=10,$P(^(0),"^",3)<COMPLDT S COMPLDT=$P(^(0),"^",3)
 S RCVDT=$S($D(GMRCDA)#2:GMRCDA,$D(GMRCDA(1)):GMRCDA(1),$D(GMRCDA(15)):GMRCDA(15),1:$P(^GMR(123,GMRCO,0),"^",1))
 Q
EN ;
 K ^TMP("GMRCSLIST",$J),GMRCQUT
 ;Get the service/grouper
 D ASRV^GMRCASV
 G:$D(GMRCQUT) KILL
 I '$O(^TMP("GMRCSLIST",$J,0)) S GMRCQUT=1 G KILL
 ;Get the date range
 D ^GMRCSPD
 G:$D(GMRCQUT) KILL
 Q
 ;
ENOR(RETURN,GMRCSRVC,GMRCDT1,GMRCDT2) ;Entry point for GUI interface.
 ;.RETURN:   This is the root to the returned temp array.
 ;GMRCSRVC:  Service for which consults are to be displayed.
 ;GMRCDT1:  Starting date or "ALL"
 ;GMRCDT2:  Ending date if not GMRCDT1="ALL"
 ;
 ;^TMP("GMRCSLIST",$J,n)=ien^name^parient ien^"+" if grouper^status
 ;  status is "" tracking and/or grouper
 ;            1  grouper only
 ;            2  tracking only
 ;            9  disabled
 ;
 N GMRCEDT1,GMRCEDT2,GMRCDG,GMRCHEAD,GMRCCT,GMRCGRP,VALMCNT,VALMBCK
 N GMRCWRIT
 S GMRCWRIT=0
 K ^TMP("GMRCR",$J,"PRL")
 S RETURN="^TMP(""GMRCR"",$J,""PRL"")"
 I '($D(GMRCSRVC)#2) S GMRCSRVC=1
 Q:'$D(^GMR(123.5,$G(GMRCSRVC),0))
 ;Build service array
 S GMRCDG=GMRCSRVC
 D SERV1^GMRCASV
 ;Get external form of date range
 I '($D(GMRCDT1)#2) S GMRCDT1="ALL"
 S:GMRCDT1="ALL" GMRCDT2=0
 D LISTDATE^GMRCSTU1(GMRCDT1,$G(GMRCDT2),.GMRCEDT1,.GMRCEDT2)
 G ODTSTR
 ;
ODT ;List Manager entry point
 N GMRCWRIT
 S GMRCWRIT=1
 D WAIT^DICD
 ;
ODTSTR ;Find the mean, standard deviation of how long to complete a consult from when it is accepted in the service to when it is complete
 N RCVDT,COMPLDT,INDEX,TEMPTMP,GROUPER,TAB
 N GMRCDG,GMRCDGT,GMRCDT,GMRCDTP
 N GMRCGRP,GMRCND,GMRCO,ND,X,X1,X2,X3,X4
 S GMRCDTP=GMRCDT2
 S GMRCDT2=GMRCDT2+1
 I '$O(^TMP("GMRCSLIST",$J,0)) S GMRCQUT=1 G KILL
 S INDEX=0
 F  S INDEX=$O(^TMP("GMRCSLIST",$J,INDEX)) Q:INDEX=""  D
 .S ND=$P(^TMP("GMRCSLIST",$J,INDEX),"^",1)
 .Q:$P(^TMP("GMRCSLIST",$J,INDEX),"^",5)=9
 .S ^TMP("GMRCSVC",$J,1,ND,"T")="0^0^0^0^0^0"
 .S ^TMP("GMRCSVC",$J,1,ND,"I")="0^0^0^0^0"
 .S ^TMP("GMRCSVC",$J,1,ND,"O")="0^0^0^0^0"
 .S ^TMP("GMRCSVC",$J,1,ND,"U")="0^0^0^0^0"
 .S ^TMP("GMRCSVC",$J,2,ND,"T")="0^0^0^0^0^0"
 .S ^TMP("GMRCSVC",$J,2,ND,"I")="0^0^0^0^0"
 .S ^TMP("GMRCSVC",$J,2,ND,"O")="0^0^0^0^0"
 .S ^TMP("GMRCSVC",$J,2,ND,"U")="0^0^0^0^0"
 S GMRCND=0
 S INDEX=""
 F  S INDEX=$O(^TMP("GMRCSLIST",$J,INDEX),-1) Q:INDEX=""  D
 .S ND=$P(^TMP("GMRCSLIST",$J,INDEX),"^",1)
 .Q:$P(^TMP("GMRCSLIST",$J,INDEX),"^",5)=9
 .Q:$P(^TMP("GMRCSVC",$J,1,ND,"T"),"^",2)>0
 .I $P(^TMP("GMRCSLIST",$J,INDEX),"^",5)'=1 D
 ..S GMRCDT=""
 ..F  S GMRCDT=$O(^GMR(123,"AE",ND,2,GMRCDT)) Q:GMRCDT=""  D
 ...S GMRCO=0
 ...F  S GMRCO=$O(^GMR(123,"AE",ND,2,GMRCDT,GMRCO)) Q:GMRCO=""  D  W:GMRCWRIT&'(GMRCND#25) "."
 ....D GETDT(GMRCO)
 ....I COMPLDT<9999999,$S(GMRCDT1="ALL":1,RCVDT'<GMRCDT1&(RCVDT'>GMRCDT2):1,1:0) D
 .....S X1=COMPLDT
 .....S X2=RCVDT
 .....D ^%DTC
 .....IF X=0 D
 ......S X=$$FMDIFF^XLFDT(COMPLDT,RCVDT,3)
 ......S X=+$P(X," ",2)/24
 ......S X3=$E(X,1,3)
 ......S X4=$E(X,4)
 ......S:X4>4 X3=X3+.01
 ......S X=X3
 .....S $P(^TMP("GMRCSVC",$J,1,ND,"T"),U)=$P(^TMP("GMRCSVC",$J,1,ND,"T"),U)+X
 .....S $P(^TMP("GMRCSVC",$J,1,ND,"T"),"^",2)=$P(^TMP("GMRCSVC",$J,1,ND,"T"),"^",2)+1
 .....S $P(^TMP("GMRCSVC",$J,1,ND,"T"),"^",3)=$P(^TMP("GMRCSVC",$J,1,ND,"T"),"^",3)+(X*X)
 .....I $P(^GMR(123,GMRCO,0),"^",18)="I" D
 ......S $P(^TMP("GMRCSVC",$J,1,ND,"I"),"^",1)=$P(^TMP("GMRCSVC",$J,1,ND,"I"),"^",1)+X
 ......S $P(^TMP("GMRCSVC",$J,1,ND,"I"),"^",2)=$P(^TMP("GMRCSVC",$J,1,ND,"I"),"^",2)+1
 ......S $P(^TMP("GMRCSVC",$J,1,ND,"I"),"^",3)=$P(^TMP("GMRCSVC",$J,1,ND,"I"),"^",3)+(X*X)
 .....E  I $P(^GMR(123,GMRCO,0),"^",18)="O" D
 ......S $P(^TMP("GMRCSVC",$J,1,ND,"O"),"^",1)=$P(^TMP("GMRCSVC",$J,1,ND,"O"),"^",1)+X
 ......S $P(^TMP("GMRCSVC",$J,1,ND,"O"),"^",2)=$P(^TMP("GMRCSVC",$J,1,ND,"O"),"^",2)+1
 ......S $P(^TMP("GMRCSVC",$J,1,ND,"O"),"^",3)=$P(^TMP("GMRCSVC",$J,1,ND,"O"),"^",3)+(X*X)
 .....E  D
 ......S $P(^TMP("GMRCSVC",$J,1,ND,"U"),"^",1)=$P(^TMP("GMRCSVC",$J,1,ND,"U"),"^",1)+X
 ......S $P(^TMP("GMRCSVC",$J,1,ND,"U"),"^",2)=$P(^TMP("GMRCSVC",$J,1,ND,"U"),"^",2)+1
 ......S $P(^TMP("GMRCSVC",$J,1,ND,"U"),"^",3)=$P(^TMP("GMRCSVC",$J,1,ND,"U"),"^",3)+(X*X)
 .....S GMRCND=GMRCND+1
 .D PARENTS^GMRCSTU1(ND,+$P(^TMP("GMRCSLIST",$J,INDEX),"^",3))
 S ND=0
STAT ;Do the statistics
 F  S ND=$O(^TMP("GMRCSVC",$J,2,ND)) Q:ND=""  D
 .I $P($G(^TMP("GMRCSVC",$J,1,ND,"T")),"^",1)>0 D DOSTAT^GMRCSTU1(1,ND)
 .I $P(^TMP("GMRCSVC",$J,2,ND,"T"),"^",1)>0 D DOSTAT^GMRCSTU1(2,ND)
 K ^TMP("GMRCR",$J,"PRL")
 S GMRCCT=0
 S GMRCDT2=GMRCDTP  ;reset date value to print report heading
 D LISTDATE^GMRCSTU1(GMRCDT1,GMRCDT2,.GMRCEDT1,.GMRCEDT2)
 S TAB=""
 S $P(TAB," ",40)=""
 S GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"PRL",GMRCCT,0)=$E(TAB,1,19)_"Consult/Request Completion Time Statistics"
 S GMRCCT=GMRCCT+1
 S TEMPTMP="FROM: "_GMRCEDT1_"   TO: "_GMRCEDT2
 S ^TMP("GMRCR",$J,"PRL",GMRCCT,0)=$E(TAB,1,40-($L(TEMPTMP)/2))_TEMPTMP
 S GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"PRL",GMRCCT,0)=""
 S INDEX=0
 S GROUPER=0
 S GROUPER(0)=0
 F  S INDEX=$O(^TMP("GMRCSLIST",$J,INDEX)) Q:INDEX=""  D
 .S ND=$P(^TMP("GMRCSLIST",$J,INDEX),"^",1)
 .Q:$P(^TMP("GMRCSLIST",$J,INDEX),"^",5)=9&'$D(^TMP("GMRCSVC",$J,2,ND))
 .F  Q:GROUPER(GROUPER)=$P(^TMP("GMRCSLIST",$J,INDEX),"^",3)  D
 ..;End of a group so print the group totals
 ..D SERVSTAT^GMRCSTU1(.GMRCCT,2,GROUPER(GROUPER),GROUPER(GROUPER))
 ..;pop grouper from stack
 ..S GROUPER=GROUPER-1
 .I $P(^TMP("GMRCSLIST",$J,INDEX),"^",4)="+" D
 ..;Start of a new group so print the group heading.
 ..S GMRCCT=GMRCCT+1
 ..S TEMPTMP="GROUPER: "_$P(^GMR(123.5,ND,0),"^",1)
 ..S:$P(^TMP("GMRCSLIST",$J,INDEX),"^",3)>0 TEMPTMP=TEMPTMP_"  in Group: "_$P(^GMR(123.5,$P(^TMP("GMRCSLIST",$J,INDEX),"^",3),0),"^",1)
 ..S ^TMP("GMRCR",$J,"PRL",GMRCCT,0)=$E(TAB,1,40-(($L(TEMPTMP)/2)+.5))_TEMPTMP
 ..S GMRCCT=GMRCCT+1
 ..S ^TMP("GMRCR",$J,"PRL",GMRCCT,0)=""
 ..;push new grouper on stack
 ..S GROUPER=GROUPER+1
 ..S GROUPER(GROUPER)=ND
 .Q:$P(^TMP("GMRCSLIST",$J,INDEX),"^",5)=1
 .Q:$P(^TMP("GMRCSLIST",$J,INDEX),"^",5)=9
 .D SERVSTAT^GMRCSTU1(.GMRCCT,1,ND,GROUPER(GROUPER))
 ;Now list the group totals for the current groups.
 F GROUPER=GROUPER:-1:1 D
 .;End of a group so print the group totals
 .D SERVSTAT^GMRCSTU1(.GMRCCT,2,GROUPER(GROUPER),GROUPER(GROUPER))
 ;Done building list.
 S VALMCNT=GMRCCT,VALMBCK="R"
KILL ;kill variables and exit
 S:$D(GMRCQUT) VALMBCK="Q"
 K ^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J)
 Q
PRNT ;print statistics to a printer
 ;Called from a List Manager action
 Q:'$D(^TMP("GMRCR",$J,"PRL",2,0))
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 D PRNTASK
 D PRNTIT("PRL","PRNTQ^GMRCSTU","CONSULT/REQUEST PACKAGE PRINT COMPLETION TIME STATISTICS FROM LIST MANAGER DISPLAY")
 Q
 ;
PRNTASK ;Ask for device
 N POP,%ZIS
 K GMRCQUT
 S POP=0
 S %ZIS="MQ"
 D ^%ZIS
 I POP D  Q
 .S GMRCMSG="Printer Busy. Try Again Later."
 .D EXAC^GMRCADC(GMRCMSG)
 .K GMRCMSG
 .S GMRCQUT=1
 Q
 ;
PRNTIT(TMPNAME,QUERTN,QUEDESC) ;Send list to printer
 N ANSWER,INDEX,DOLLARH,ZTRTN,ZTDESC
 I $D(IO("Q")) D  Q
 .S DOLLARH=$H
 .M ^XTMP("GMRCR","$"_$J,DOLLARH,"PRINT")=^TMP("GMRCR",$J,TMPNAME)
 .S ZTRTN=QUERTN
 .S ZTDESC=QUEDESC
 .S ZTSAVE("J")="$"_$J
 .S ZTSAVE("DOLLARH")=""
 .S ZTSAVE("TMPNAME")=""
 .S ZTSAVE("GMRCDG")=""
 .S ZTSAVE("GMRCDT1")=""
 .S ZTSAVE("GMRCDT2")=""
 .D ^%ZTLOAD,^%ZISC
 .K ZTSAVE
 .S VALMBCK="R"
 U IO
 S ANSWER=""
 S INDEX=""
 F  S INDEX=$O(^TMP("GMRCR",$J,TMPNAME,INDEX)) Q:INDEX=""  W ^TMP("GMRCR",$J,TMPNAME,INDEX,0),! I IOST["C-",$S($D(IOSL)#2:$Y>(IOSL-2),1:$Y>22) R "Press <ENTER> To Continue, '^' To Quit: ",ANSWER:DTIME Q:'$T!(ANSWER["^")  W @IOF
 I ANSWER'["^",IOST["C-",$Y>1 R !,"Press <ENTER> To Continue: ",ANSWER:DTIME
 U IO(0)
 D ^%ZISC
 S VALMBCK="R"
 Q
 ;
PRNTQ ;Print Queued report from ^XTMP global then kill off ^XTMP
 N INDEX
 U IO
 S INDEX=""
 F  S INDEX=$O(^XTMP("GMRCR",J,DOLLARH,"PRINT",INDEX)) Q:INDEX=""  W ^XTMP("GMRCR",J,DOLLARH,"PRINT",INDEX,0),!
 K ^XTMP("GMRCR",J,DOLLARH,"PRINT"),J,DOLLARH
 D ^%ZISC
 Q
