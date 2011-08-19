XQ84 ;SEA/Luke - Menu Rebuild Utilities ;03/03/2003  09:19
 ;;8.0;KERNEL;**157,253**;Jul 10, 1995
 ;
 ;
SHOW ; Show what's in the global ^XUTL("XQ","REBUILDS")
 I '$D(^XUTL("XQ","REBUILDS")) W !,"  Sorry, there is no data in the global ^XUTL(""XQ"",""REBUILDS"") to show you.",! Q
 ;
 N %,XQI,XQNL,XQNI,XQNT
 N XQB,XQE,XQBY,XQTYPE,XQT,XQUCI,XQJ
 ;
 I '$D(IOF) D HOME^%ZIS
 W @IOF
 S XQNL=0 ;Line counter
 S XQNI=1 ;Item or occurance counter
 S XQNT=$S($D(IOSL):IOSL-4,1:18) ;Number of lines on the screen
 ;
 D TITLE
 D TOP
 ;
 S XQI=0
 F  Q:$D(DIRUT)  S XQI=$O(^XUTL("XQ","REBUILDS",XQI)) Q:XQI=""  D
 .S %=^XUTL("XQ","REBUILDS",XQI)
 .S XQBY=$P($P(%,U,3),","),XQBY=$E(XQBY,1,12)
 .S XQB=$P(%,U,1),XQE=$P(%,U,2),XQTYPE=$P(%,U,4),XQT=$P(%,U,5)
 .S XQUCI="  Location:  "_$P(%,U,6,8)
 .S XQJ="     Job #:  "_$P(%,U,9)
 .D WRITE
 .Q
 ;
 K DIRUT,DUOUT
 Q
 ;
WRITE ;Write an entry unless the screen is full
 I XQNL>XQNT D
 .D WAIT Q:$D(DIRUT)
 .W @IOF
 .S XQNL=0
 .D TOP
 .Q
 Q:$D(DIRUT)
 W !,XQNI,".",?4,XQB,?28,XQE,?51,XQBY,?60,XQTYPE,?71,XQT,!,XQUCI,XQJ,!
 S XQNL=XQNL+3,XQNI=XQNI+1
 Q
 ;
TOP ; Format the top of the page
 W !,?11,"Start",?35,"End",?53,"By",?59,"Type/Name",?72,"Task #",!
 S XQNL=XQNL+2
 Q
 ;
TITLE ;What is this all about?
 N %
 S %=$G(^XUTL("XQ","MICRO"))
 W ?36,"Recent Menu Rebuilds",!
 S XQNL=XQNL+2
 W ?14,$S(%>0:%,1:"No")_" instances of Micro Surgery since last rebuild."
 S XQNL=XQNL+2
 Q
 ;
WAIT ;That's a screen load hold it here for a minute
 N X,Y
 S DIR(0)="E" D ^DIR K DIR
 Q
 ;
 ;
USER ;Rebuild the menu trees of a specific user
 ;called by the option XQBUILDUSER
 N XUN,XQCNT,XQSEC,XQREACT,XQPRIM,XQFL
 S (XQCNT,XQSEC)=0
 ;
 S XUN=+$$LOOKUP^XUSER Q:XUN'>0
 S XQPRIM=$G(^VA(200,XUN,201)) I XQPRIM'>0 W !!,"No Primary Menu defined for this user." Q
 S XQCNT=1,XQREACT(XQCNT)=XQPRIM
 F  S XQSEC=$O(^VA(200,XUN,203,"B",XQSEC)) Q:XQSEC'=+XQSEC  D
 .Q:'$D(^DIC(19,XQSEC,0))  ;Error in Buffalo...old pointer?
 .I $P(^DIC(19,XQSEC,0),U,4)="M" S XQCNT=XQCNT+1,XQREACT(XQCNT)=XQSEC
 .Q
 ;
 M XQREACTS=XQREACT  ;Save the originals
 S XQCNTS=XQCNT
 ;
 S XQFL=$$FLAG(.XQREACT,.XQCNT)
 I XQFL=1 D
 .N DIR
 .S DIR(0)="Y"
 .S DIR("A")=" Are you sure you want to force a rebuild? "
 .S DIR("A",1)="               ***WARNING*** "
 .S DIR("A",2)=" Someone else may be rebuilding these trees right now."
 .S DIR("?")=" Enter 'Y' to force a rebuild, 'N' to quit."
 .D ^DIR
 .I Y=1 D
 ..M XQREACT=XQREACTS  ;Restore original list of menus
 ..S XQCNT=XQCNTS
 ..S XQFL=0
 ..Q
 .Q
 ;
 Q:XQFL  ;Flags are set, let's not mess with it.
 ;
 S DIR(0)="Y",DIR("A")=" Queue this rebuild? ",DIR("B")="Y"
 S DIR("?")=" Please enter 'Y'es or 'N'o."
 D ^DIR I Y=1 D
 .S ZTRTN="REACTQ^XQ84"
 .S ZTSAVE("XUN")=""
 .S ZTSAVE("XQREACT(")="",ZTSAVE("XQCNT")=""
 .S ZTIO="",ZTDTH=$H
 .S ZTDESC="Rebuild "_$P(^VA(200,XUN,0),U)_"'s menu trees (DUZ="_XUN_")"
 .D ^%ZTLOAD
 .I $D(ZTSK) W !!," Task number: ",ZTSK
 .Q
 K DIR,Y
 ;
 I '$D(ZTSK) D REACTQ W !!," Done."
 K ZTSK
 Q
 ;
REACT(XUN) ;From XUSERNEW, check trees for reactivated user
 ;
 N XQCNT,XQSEC,XQREACT,XQPRIM,XQCHAT
 S XQCHAT=1 I $D(XQUEUED)!$D(XWB) S XQCHAT=0 ;Anybody out there?
 S XQPRIM=$G(^VA(200,XUN,201)) I 'XQPRIM,'$D(XQQUE) W:XQCHAT !!,"** WARNING ** No Primary Menu defined." Q
 I (XQPRIM'=+XQPRIM)!($G(^DIC(19,XQPRIM,0))="") Q
 S (XQCNT,XQSEC)=0
 I XQPRIM,'$D(^DIC(19,"AXQ","P"_XQPRIM)),$P(^DIC(19,XQPRIM,0),U,4)="M" S XQCNT=XQCNT+1,XQREACT(XQCNT)="P"_XQPRIM
 F  S XQSEC=$O(^VA(200,XUN,203,"B",XQSEC)) Q:XQSEC'=+XQSEC  D
 .Q:'$D(^DIC(19,XQSEC,0))  ;Bad pointer don't use it
 .I '$D(^DIC(19,"AXQ","P"_XQSEC)),$P(^DIC(19,XQSEC,0),U,4)="M" S XQCNT=XQCNT+1,XQREACT(XQCNT)="P"_XQSEC
 .Q
 ;
 Q:XQCNT=0  ;The menu trees look OK to me.
 ;
 N %
 S %=$$FLAG(.XQREACT,.XQCNT) ;Are we already merging them (1)
 Q:%
 ;
 I XQCNT>0 D
 .S ZTRTN="REACTQ^XQ84"
 .S ZTSAVE("XQREACT(")="",ZTSAVE("XUN")=""
 .S ZTIO="",ZTDTH=$H
 .S ZTDESC="Rebuild reactivated user's menu trees (DUZ="_XUN_")"
 .D ^%ZTLOAD
 .K ZTSK
 .Q
 Q
 ;
FLAG(XQARRAY,XQNUM1) ;Should we build a particular array of trees
 ;Input: XQARRAY - array of trees e.g. P106, etc.  XQNUM1 number of trees
 ;Output: 0 - There are trees to rebuild, 1 - Trees are already flagged
 ;Merge flags e.g. [^XUTL("XQMERGED","P106)=$H] are set here 
 ; and killed in REACTQ+16
 ;
 N %,XQNUM,XQPXU S XQNUM=0
 S %=$$STATUS^XQ81() I '% Q 1  ;Menues rebuilding
 S XQPXU=$G(^DIC(19,"AXQ","PXU",0)) Q:XQPXU="" 1
 S %="" F  S %=$O(XQARRAY(%)) Q:%=""  D
 .N X
 .S X=XQARRAY(%)
 .I $D(^XUTL("XQMERGED",X)) D
 ..N Y,Z
 ..S Y=$G(^XUTL("XQMERGED",X)) Q:Y=""  ;Flag's gone
 ..S Z=$$HDIFF^XLFDT(XQPXU,Y)
 ..I Z>0 K ^XUTL("XQMERGED",X) ;Old Flag
 ..Q
 .I $D(^XUTL("XQMERGED",X)) K XQARRAY(%) Q
 .S ^XUTL("XQMERGED",X)=$H,XQNUM=XQNUM+1 ;We'll merge this one
 .Q
 I XQNUM>0 S XQNUM1=XQNUM Q 0  ;There are some left to rebuild
 Q 1
 ;
 ;
REACTQ ;Queued job to rebuild a reativated user's menu trees
 ;  can also be run in real time by USER (above) [Not Used]
 ;
 N % S %=0
 K ZTREQ ;Don't delete the task information
 I $D(^DIC(19,"AXQ","P0")) S XQSTAT=$$STATUS^XQ81 Q:'XQSTAT  ;Menus are being rebuilt
 Q:'$D(XQREACT)  ;Nothing to rebuild
 ;
 D MICRO^XQ81  ;Turn off Micro Surgery
 S ^DIC(19,"AXQ","P0")=$H
 N XQCNT,XQDIC S XQCNT=""
 K ^TMP($J),^TMP("XQO",$J)
 F  S XQCNT=$O(XQREACT(XQCNT)) Q:XQCNT=""  D
 .S (XQFG1,XQXUF)="",XQDIC="P"_XQREACT(XQCNT)
 .D PM2^XQ8
 .Q:'$D(^TMP("XQO",$J,XQDIC))
 .M ^DIC(19,"AXQ",XQDIC)=^TMP("XQO",$J,XQDIC) ;D MERGET^XQ81
 .M ^XUTL("XQO",XQDIC)=^DIC(19,"AXQ",XQDIC)  ;D MERGEX^XQ81
 .K ^XUTL("XQMERGED",XQREACT(XQCNT))
 .Q
 K ^DIC(19,"AXQ","P0"),^TMP($J),^TMP("XQO",$J)
 D REPORT($E($P(^VA(200,XUN,0),U),1,9))
 K ^DIC(19,"AXQ","P0","STOP")
 K D,I,W,X,XQK,XQQUE,XQXUF,Y,Z
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
 ;
REPORT(XQTYPE) ;Tell Rick What happened.
 N %,X,XQI,XQJ,XQK,XQLINE,XQEND,Y
 I '$D(^XUTL("XQ","MICRO")) S ^("MICRO")=0
 I XQTYPE["MICRO" S ^XUTL("XQ","MICRO")=^XUTL("XQ","MICRO")+1 Q  ;Update Micro count
 S XQEND=$$HTE^XLFDT($H)
 I '$D(XQSTART) S XQSTART=XQEND
 S XQLINE=XQSTART_"^"_XQEND_"^"_$P(^VA(200,DUZ,0),U,1)_"^"
 ;S X=$S($D(^DIC(19,"AXQ","P0","MICRO")):"MICRO",$D(ZTSK):"QUEUED",1:"LIVE")
 S X=XQTYPE K XQTYPE
 S Y=$S($D(ZTSK):ZTSK,1:"LIVE")
 S XQLINE=XQLINE_X_"^"_Y
 D GETENV^%ZOSV
 S XQLINE=XQLINE_"^"_$P(Y,"^",1,3)_"^"_$J
 I $D(^XUTL("XQ","REBUILDS")) D
 .S (XQJ,XQK)=0
 .F  S XQJ=$O(^XUTL("XQ","REBUILDS",XQJ)) Q:XQJ=""!(XQJ=49)  S XQK=XQK+1
 .F XQI=XQK:-1:1 S ^XUTL("XQ","REBUILDS",XQI+1)=^(XQI)
 .Q
 S ^XUTL("XQ","REBUILDS",1)=XQLINE
 Q
 ;
 ;
NOW ;Is there a rebuild of any kind running right now?
 N % S %=0
 I $D(^DIC(19,"AXQ","P0","MICRO")) D
 .W !!?6,"Micro surgery is currently updating the compiled menus."
 .I $D(^DIC(19,"AXQ","AXQ","STOP")) D
 ..W !?6,"... but it has been instructed to stop."
 ..Q
 .S %=47
 .Q
 Q:%=47
 I $D(^DIC(19,"AXQ","P0")) D
 .W !!?6," A complete menu rebuild is currently running."
 .S %=47
 .Q
 Q:%=47
 W !!?6,"There is no menu rebuild activity running on your system right now."
 Q
