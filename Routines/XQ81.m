XQ81 ;SEA/AMF/LUKE,SF/RWF - Build menu trees ;12/10/07
 ;;8.0;KERNEL;**81,116,157,253,478**;Jul 10, 1995;Build 3
BUILD ;
 ;
RD2 N XQSTAT S XQSTAT=$$STATUS()
 I 'XQSTAT W !!,"Some one else is rebuilding menus.  Sorry." Q
 K ZTSK
 D MICRO ;Turn off micro surgery for now
 ;
 S XQSTART=$$HTE^XLFDT($H)
 K XQFG W !!,"This option will build menu trees for each primary and secondary menu.",!,"You may build all the trees, or build them selectively, using 'verify'.",!,"Note that the 'compiled menus' will only be built into ^XUTL on this CPU.",!
 S DIR(0)="Y",DIR("A")="Do you wish to verify each primary menu",DIR("B")="NO",DIR("??")="XQBUILDTREE-VER" D ^DIR K DIR G:$D(DIRUT) BLDEND1 S XQVE=(Y=1)
 S DIR(0)="Y",DIR("A")="Would you like to build secondary menu trees too",DIR("B")="YES",DIR("??")="XQBUILDTREE-SEC" D ^DIR G:$D(DIRUT) BLDEND1 S XQBSEC=(Y=1)
 ;
 I 'XQVE S DIR(0)="Y",DIR("A")="Would you like to queue this job",DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT) BLDEND1 I Y=1 D
 .S ZTRTN="QUE^XQ81",ZTIO=""
 .S ZTSAVE("XQVE")="",ZTSAVE("XQBSEC")="",ZTSAVE("XQSTART")=""
 .S ZTDESC="Build menu trees in ^DIC(19,""AXQ"")"
 .D ^%ZTLOAD
 .I $D(ZTSK),'XQVE W !!,"Task #: ",ZTSK,!
 .Q
 ;
 I $D(ZTSK) K ^DIC(19,"AXQ","P0") S XQALLDON="" G BLDEND
 E  S ^DIC(19,"AXQ","P0")=$H L +^DIC(19,"AXQ","P0")
 ;
 I 'XQVE S DIR(0)="Y",DIR("A")="Do you really wish to run this DIRECTLY (it may take some time)",DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT) BLDEND1 G:Y'=1 RD2
 ;
KIDS ;Entry from KIDS
 I '$D(XQSTAT),$D(^DIC(19,"AXQ","P0")) S XQSTAT=$$STATUS I 'XQSTAT W !!,"  Some one else is building menus.  Sorry." K XQSTAT Q
 I '$D(^DIC(19,"AXQ","P0","STOP")) D MICRO
 I '$D(^DIC(19,"AXQ","P0")) S ^DIC(19,"AXQ","P0")=$H L +^DIC(19,"AXQ","P0")
 I '$D(XQVE) S XQFG=0,XQBSEC=1,XQVE=0
 N XQNTREE,XQNDONE S (XQNTREE,XQNDONE)=0
 ;
 ;Set up the error trap so we can clear the screen if it blows
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^XQ81"
 E  S X="ERR^XQ81",@^%ZOSF("TRAP")
 ;
 ;Set up the bar graph and window if not from KIDS
 I '$D(XPDNM) D INIT^XPDID
 I XPDIDVT D
 .I $D(XPDIDTOT) S XQSAVTOT=XPDIDTOT
 .S X="Rebuilding Menus" D TITLE^XPDID(X)
 .S XPDIDTOT=50 ;Number of divisions in bar graph
 .D UPDATE^XPDID(0)
 .Q
 ;
 S XQSTART=$$HTE^XLFDT($H)
 W !!,"Starting Menu Rebuild:  ",XQSTART
 S XQFG=0 W !!,"Collecting primary menus in the New Person file..."
 ;
DQ ;Entry from taskman  Write if $D(XQFG)
 K ZTREQ
 I '$D(XQSTART) S XQSTART=$$HTE^XLFDT($H)
 N XQNOW,XQ8FLG,XQTASK
 S XQ8FLG=0
 S:'$D(XQNOW) XQNOW=$H
 S ^DIC(19,"AXQ","P0")=XQNOW
 S ^DIC(19,"AXQ","P0","STOP")=XQNOW ;Stop micro surgery if it's running
 ;
 S XQSEC=1,XQ81T="" I 'XQVE H 1
 S XQI="" F XQK=0:0 S XQI=$O(^TMP("XQO",$J,XQI)) Q:XQI'=+XQI!(XQI="")  I $D(^TMP("XQO",$J,XQI,0))#2 S $P(^(0),U,2)=""
 S XQI="U" F XQK=0:0 S XQI=$O(^TMP("XQO",$J,XQI)) Q:"U"'[$E(XQI)!(XQI="")  I $D(^TMP("XQO",$J,XQI,0))#2 S $P(^(0),U,2)=""
 S XQI="P" F XQK=0:0 S XQI=$O(^TMP("XQO",$J,XQI)) Q:"P"'[$E(XQI)!(XQI="")  I $D(^TMP("XQO",$J,XQI,0))#2,$L(^(0)) S XQ81T=^(0) Q
 S:XQ81T="" XQ81T="Unknown"
 S XQI="P" F XQK=0:0 S XQI=$O(^TMP("XQO",$J,XQI)) Q:"P"'[$E(XQI)!(XQI="")  I "P"[$E(XQI),XQI'="P0" K ^TMP("XQO",$J,XQI)
 ;
 ;Find the various trees and put them into ^TMP($J), and count them
 S:'$D(XQH) XQH=$H K ^TMP($J) S XQI=.5 F XQK=0:0 S XQI=$O(^VA(200,XQI)) Q:XQI'=+XQI  I $D(^VA(200,XQI,0)),$L($P(^VA(200,XQI,0),U,3)) D SET
 ;
 S (XQNTREE,%)=0 F  S %=$O(^TMP($J,%)) Q:%=""  S XQNTREE=XQNTREE+1
 S %=0 F  S %=$O(^TMP($J,"SEC",%)) Q:%=""  S XQNTREE=XQNTREE+1
 ;
 W:$D(XQFG) !!?20,"Primary menus found in the New Person file",!?20,"------------------------------------------"
 W:$D(XQFG) !!,"OPTION NAME         MENU TEXT",?49,"# OF",?62,"LAST",?71,"LAST",!?49,"USERS",?62,"USED",?71,"BUILT",!
 S X="" F XQBLD=0:0 S XQBLD=$O(^TMP($J,XQBLD)) Q:XQBLD'>0!(X=U)  I $D(^DIC(19,XQBLD,0)) S XQJ=^DIC(19,XQBLD,0) D VER
 S XQSEC=0 I $D(XQFG),XQBSEC W !!,"Building secondary menu trees...."
 I XQBSEC S X="" F XQBLD=0:0 S XQBLD=$O(^TMP($J,"SEC",XQBLD)) Q:XQBLD'>0  D SEC
 I 'XQVE S XQK="P" F XQBLD=0:0 S XQK=$O(^TMP("XQO",$J,XQK)) Q:XQK'["P"  S ^(XQK,0)=XQH
 G BLDEND
 ;
SEC S XQL="P"_XQBLD Q:$D(^TMP("XQO",$J,XQL))  D RD3 Q
 S XQL="P" F XQN=0:0 S XQL=$O(^TMP("XQO",$J,XQL)) Q:$E(XQL)'="P"  I $D(^TMP("XQO",$J,XQL,"^",XQBLD)) Q
 D:$E(XQL)'="P" RD3
 Q
 ;
VER I $D(XQFG) D
 .N XQMT,XQOPNM
 .S XQK=$P(^TMP($J,XQBLD),U,2)
 .S:$L(XQK) XQK=$E(XQK,4,5)_"/"_$E(XQK,6,7)_"/"_$E(XQK,2,3)
 .S XQOPNM=$P(XQJ,U)
 .S XQMT=$P(XQJ,U,2) I $L(XQMT)>28 S XQMT=$E(XQMT,1,25)_"..."
 .W !,$P(XQJ,U,1)
 .W:($L(XQOPNM)>20) !
 .W ?20,XQMT,?49,+^TMP($J,XQBLD),?60,XQK
 .Q
 ;
 I $D(XQFG) S:$D(^DIC(19,"AXQ","P"_XQBLD,0)) XQ81T=+^(0) I $L(XQ81T) S %H=XQ81T D YMD^%DTC S XQK=X W ?71,$E(XQK,4,5),"/",$E(XQK,6,7),"/",$E(XQK,2,3)
 ;
RD3 ;Update counter an rebuild it if necessary
 I $D(XQFG),XPDIDVT D
 .N %
 .S XQNDONE=XQNDONE+1
 .S %=(XQNDONE/XQNTREE)*XPDIDTOT
 .D UPDATE^XPDID(%)
 .Q
 ;
 S XQDIC="P"_XQBLD D CHK^XQ8 I XQRE W:$D(XQFG) !,"SOMEONE ELSE IS CURRENTLY REBUILDING THIS MENU" Q
 I XQVE,XQSEC S DIR(0)="Y",DIR("A")="Rebuild",DIR("B")="YES" D ^DIR Q:$D(DIRUT)  W ! Q:Y'=1
 S XQFG1=1 D PM2^XQ8
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
SET G:'$D(^VA(200,XQI,201)) SET1 S XQK=+^(201) Q:'$L(XQK)  ;I $D(XQFG) W:'(XQI#10) "."
 S XQR="" S:$D(^VA(200,XQI,1.1)) XQR=$P(^(1.1),".",1) S XQP=1_U_XQR
 I $D(^TMP($J,XQK)) S XQP=^TMP($J,XQK) S XQP=XQP+1_U_$S(XQR>$P(XQP,U,2):XQR,1:$P(XQP,U,2))
 I $D(^DIC(19,XQK,0)),$P(^(0),U,4)="M" S ^TMP($J,XQK)=XQP
 ;
SET1 I XQBSEC F XQN=0:0 S XQN=$O(^VA(200,XQI,203,XQN)) Q:XQN'>0  S XQL=+^(XQN,0) I $D(^DIC(19,XQL,0)),$P(^(0),U,4)="M" S ^TMP($J,"SEC",XQL)=""
 Q
 ;
QUE ;Entry point for the option XQBUILDTREEQUE, and XQBUILDALL
 ;Also called by CHEK^XQ83
 S XQVE=0,XQBSEC=1 K XQFG
 S XQSTART=$$HTE^XLFDT($H)
 G DQ
 ;
BLDEND ;File a report, cleanup, and quit.
 ;
 K %,%H,%TG,C,D,DIC,DIR,I,J,K,L,V,XQBSEC,X,Y,Z,XQL,XQN,XQRE,XQK,XQI,XQII,UU,XQH,XQPX,XQSAV,XQXUF,XQ81T,XQDATE,XQSEC,XQVE,XQBLD,XQP,XQR,XQJ
 ;
 I $D(XQALLDON) K XQALLDON Q  ;Quit here if we're just creating a task
 ;
 D MERGET
 D CLEAN
 D MERGEX
 ;
 K ^TMP($J),^TMP("XQO",$J)
 ;
 ;Clear the flags and locks.
 K ^XUTL("XQMERGED") ;Menues merged since last rebuild REACT^XQ84
 K ^DIC(19,"AT") ;Micro message nodes
 S ^XUTL("XQ","MICRO")=0 ;Number of Micro instances since last build
 K ^DIC(19,"AXQ","P0","STOP") ;Allow Micro surgery to start up
 K ^DIC(19,"AXQ","P0") ;Clear the rebuild flag (redundant, I know)
 L -^DIC(19,"AXQ","P0") ;Unlock the rebuild flag, everybody's good to go
 ;
 S %=$S($D(XPDNM):"KIDS",$D(ZTSK):"QUEUED",1:"LIVE")
 D REPORT^XQ84(%)
 K XQSTART,ZTSK
 ;
 I '$D(XPDIDVT) K XQFG Q
 ;
 I $D(XQFG),XPDIDVT F %=((XQNDONE/XQNTREE)*XPDIDTOT):1:XPDIDTOT D UPDATE^XPDID(%) H .25
 I $D(XQFG),XPDIDVT D UPDATE^XPDID(XPDIDTOT)
 I $D(XQFG) W !!,"Menu Rebuild Complete:  ",$$HTE^XLFDT($H)
 ;
 ;
 H 2
 ;If we're not from KIDS then clean it up, otherwise let kids do it.
 I '$D(XPDNM) D
 .D EXIT^XPDID()
 .K XPDIDVT,XPDIDTOT
 .Q
 ;
 I $D(XQSAVTOT) S XPDIDTOT=XQSAVTOT
 K %,VALMCOFF,VALMCON,VALMIOXY,VALMSGR,VALMWD,XQFG,XQNDONE,XQNTREE,XQSAVTOT
 Q
 ;
 ;================================Subroutines==========================
 ;
MERGET ;Merge ^TMP("XQO",$J) into ^DIC(19,"AXQ")
 N Q,X,XQFLAG,Y S X="P",XQFLAG=0,Q=""""
 I $D(XQFG) W !!,"Merging...."
 F  S X=$O(^TMP("XQO",$J,X)) Q:X=""  D
 .L +^DIC(19,"AXQ",X):2 I '$T S XQFLAG=1 Q
 .S %X="^TMP(""XQO"","_$J_","_Q_X_Q_","
 .S %Y="^DIC(19,""AXQ"","_Q_X_Q_","
 .K ^DIC(19,"AXQ",X)
 .;M ^DIC(19,"AXQ",X)=^TMP("XQO",$J,X)
 .D %XY^%RCR
 .L -^DIC(19,"AXQ",X)
 .K %X,%Y
 .Q
 ;
 I XQFLAG,$D(XQFG) D
 .N %,Y
 .S Y=$P(X,"P",2) Q:Y=""
 .S %=$G(^DIC(19,Y,0)) Q:%=""
 .S Y=$P(%,"^",2) Q:%=""
 .W !,?12,"Could not merge menu: "_Y
 .Q
 Q
 ;
CLEAN ;Clean out unused menu trees from ^DIC(19,"AXQ")
 N X,Y S X="P"
 F  S X=$O(^DIC(19,"AXQ",X)) Q:X=""  D
 .I X'="PXU" D
 ..S Y=$E(X,2,99)
 ..I '$D(^TMP($J,Y))&('$D(^TMP($J,"SEC",Y))) K ^DIC(19,"AXQ",X),^XUTL("XQO",X)
 ..Q
 .Q
 Q
 ;
MERGEX ;Merge ^DIC(19,"AXQ") into ^XUTL("XQO")
 N Q,X,XQFLAG,Y S X="P",XQFLAG=0,Q=""""
 F  S X=$O(^DIC(19,"AXQ",X)) Q:X=""  D
 .L +^XUTL("XQO",X):2 I '$T S XQFLAG=1 Q
 .S %X="^DIC(19,""AXQ"","_Q_X_Q_","
 .S %Y="^XUTL(""XQO"","_Q_X_Q_","
 .K ^XUTL("XQO",X)
 .;M ^XUTL("XQO",X)=^DIC(19,"AXQ",X)
 .D %XY^%RCR
 .L -^XUTL("XQO",X)
 .K %X,%Y
 .Q
 ;
 I XQFLAG,$D(XQFG) D
 .N %,Y
 .S Y=$P(X,"P",2) Q:Y=""
 .S %=$G(^DIC(19,Y,0)) Q:%=""
 .S Y=$P(%,"^",2) Q:%=""
 .W !,?12,"Could not merge menu: "_Y
 .Q
 ;
 I 'XQFLAG,$D(XQFG) W " done."
 Q
 ;
STATUS()  ;Are the menus being rebuilt even as we speak?
 N %,XQTHEN
 S %=$G(^DIC(19,"AXQ","P0")) I %="" Q 1  ;It finished.  Never mind.
 L +^DIC(19,"AXQ","P0"):0 ;If job is still running we can't lock it
 I $T L -^DIC(19,"AXQ","P0") K ^("P0") Q 1  ;Job must have failed
 Q 0
 ;
 ;
MICRO ;Turn off micro surgery
 I $D(^DIC(19,"AXQ","P0","MICRO")) D
 .S ^DIC(19,"AXQ","P0","STOP")=$H ;Turn off micro-surgery
 .K ^DIC(19,"AXQ","P0","MICRO")
 .H 2
 .Q
 Q
 ;
 ;
ERR ;Come here on error
 N XQERROR
 S XQERROR=$$EC^%ZOSV
 D ^%ZTER
 D EXIT^XPDID()
 G UNWIND^%ZTER
 Q
 ;
BLDEND1 ;Quit and clean
 K %,%H,%TG,C,D,DIC,DIR,I,J,K,L,V,XQBSEC,X,Y,Z,XQL,XQN,XQRE,XQK,XQI,XQII,UU,XQH,XQPX,XQSAV,XQXUF,XQ81T,XQDATE,XQSEC,XQVE,XQBLD,XQP,XQR,XQJ
 Q
