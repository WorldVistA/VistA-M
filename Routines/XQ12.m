XQ12 ;SEA/LUKE - MENU MANAGER UTILITIES ;11/14/2002  11:55
 ;;8.0;KERNEL;**9,20,46,157,253**;Jul 10, 1995
 ;
DVARS ;Set up (or reset) necessary variables. From ^XQ1 and ^XQT1.
 S U="^" I '$D(DUZ)#2 S DUZ=^XUTL("XQ",$J,"DUZ")
 S:'$D(DUZ(0))#2 DUZ(0)="" I DUZ(0)="" S:$D(^VA(200,DUZ,0)) DUZ(0)=$P(^(0),U,4)
 I '$D(DT) D ^XQDATE S DT=$P(%,".")
 I '$D(DUZ("AG")),$D(^XTV(8989.3,1,0)) S DUZ("AG")=$P(^(0),U,8)
 I '$D(IOS) S IOS=$S($D(^XUTL("XQ",$J,"IOS"))#2:^("IOS"),1:"")
 I '$D(DTIME) S DTIME=$$DTIME^XUP(DUZ,IOS)
 I '$D(DUZ("AUTO")) S I=$S($D(^VA(200,DUZ,200)):$P(^(200),U,6),1:"") S:'$L(I) I=$S($D(^%ZIS(1,$I,"XUS")):$P(^("XUS"),U,6),1:"") S:'$L(I) I=$S($D(^XTV(8989.3,1,"XUS")):$P(^("XUS"),U,6),1:"") S:'$L(I) I=1 S DUZ("AUTO")=I
 Q
 ;
INIT ;Entry for new logon, called from the top of ^XQ and ^XQ1
 K DIC,Y Q:$D(DUZ)[0  Q:'$D(^VA(200,DUZ,0))
 ;S:'$D(XQY) XQY=^VA(200,DUZ,201)
 I '$D(XQUSER) S XQUSER=$P($P(^VA(200,DUZ,0),U),",",2)_" "_$P($P(^(0),U),",")
 ;
 ;Select device tied option, primary menu, or primary window
 ;
 S:'$D(XQY) XQY=""
 S %=$G(^VA(200,DUZ,201)),^XUTL("XQ",$J,"XQM")=+%,^("XQW")=$P(%,"^",2)
 D:'$D(IO) HOME^%ZIS
 I IO]"" S %=$G(^%ZIS(1,IO,201)) I %]"" S XQY=%
 I XQY']"" D
 .S %=$G(^VA(200,DUZ,201))
 .S XQPM=$P(%,U),XQPW=$P(%,U,2),XQSD=$P(%,U,3)
 .I XQPW']"" S XQY=XQPM Q
 .I XQSD="M" S XQY=XQPM
 .E  S XQY=XQPW
 .Q
 ;
 D SET^XQCHK
 S ^XUTL("XQ",$J,1)=XQY_"P"_XQY_"^"_XQY0,^("T")=1
 S XQDIC=XQY,XQPSM="P"_XQY
 ;
 ;D MERGE,MGPXU,MGSEC ;get the menu trees this user will need to jump
 ;
 ;Fire LOGIN menu template if they have one and its the first login
 ;of the day.  XQXFLG("LLOG") is copy of ^VA(200,DUZ,1.1) before it's
 ;updated at XUS1+47
 I $D(^VA(200,DUZ,19.8,"B","LOGIN")) D
 .Q:'$D(XQXFLG("LLOG"))
 .S XQLAST=$P($P(XQXFLG("LLOG"),U),".") ;Get last login DT
 .Q:+XQLAST<1
 .I XQLAST<DT S XQUR="[LOGIN",XQJS=3
 .K XQLAST
 .Q
 K XQXFLG("LLOG")
 ;
UI ;Entry for TaskMan (DUZ may =  0), from ZTSK^XQ1
 D DVARS I '$D(^XUTL("XQ",$J,0)) D ^XQDATE S ^XUTL("XQ",$J,0)=%_U_%Y
 S:'$D(XQDIC) XQDIC="P"_XQY
 S:'$D(XQPSM) XQPSM="P"_XQY
 S:'$D(XQJS)&'$D(ZTQUEUED) XQY0=^DIC(19,XQY,0),^XUTL("XQ",$J,"T")=0,^("DUZ")=DUZ,^("XQM")=XQY,XQPSM="P"_XQY
 S XQCY=XQY D ^XQCHK I XQCY<1 D
 .S XQPRMN=1,XQL=0
 .D:'$D(ZTQUEUED) MES^XQCHK,PAUSE^XQ6
 .;G:'$D(ZTQUEUED) ^XUSCLEAN S XQY=-1
 .S XQY=-1
 .Q
 S XQM3="" I $P(XQY0,U,4)'="A",$P(XQY0,U,14),$D(^DIC(19,XQY,20)),$L(^(20)) X ^(20) ;W "  ==> XQ12+59"
 ;I $D(XQUIT),'$D(ZTQUEUED) S XQL=0 W !!,"The variable XQUIT was encountered in the Entry Action of your Primary Menu." D PAUSE^XQ6 S XQY=-1 G ^XUSCLEAN
 I $D(XQUIT),'$D(ZTQUEUED) D PM^XQUIT I $D(XQUIT) S XQY=-1 G ^XUSCLEAN
 ;I $P(XQY0,U,17),$D(^DIC(19,XQY,26)),$L(^(26)) X ^(26)
ABT ;WARNING: XQXFLG is also used by OERR test sites.
 S U="^"
 S $P(XQXFLG,U)=$S($O(^XTV(8989.3,1,"ABPKG",0))>0:1,1:0)
CMP S $P(XQXFLG,U,2)=$S('$D(^XTV(8989.3,1,"XUCP")):0,1:^("XUCP")="Y")
 K %,%Y,PGM,X,XQCY,XQPM,XQPXU,XQPW,XQSD
 Q
 ;
 ;
MERGE ;Merge in the menu trees that this user needs, start with Primary Menu
 Q:'$D(^DIC(19,"AXQ",XQPSM))
 I $D(^XUTL("XQMERGED",XQPSM)) D OLDF(XQPSM)
 Q:$D(^XUTL("XQMERGED",XQPSM))  ;It's already being done
 ;
 L +^XUTL("XQO",XQPSM):0 Q:'$T
 S ^XUTL("XQMERGED",XQPSM)=$H
 ;
 K ^XUTL("XQO",XQPSM)
 M ^XUTL("XQO",XQPSM)=^DIC(19,"AXQ",XQPSM)
 ;
 L -^DIC(19,"AXQ",XQPSM)
 K ^XUTL("XQMERGED",XQPSM)
 Q
 ;
MGPXU ;Check for XUCOMMAND
 Q:'$D(^DIC(19,"AXQ","PXU"))
 I $D(^XUTL("XQMERGED","PXU")) D OLDF("PXU")
 Q:$D(^XUTL("XQMERGED","PXU"))  ;Already being merged
 ;
 L +^XUTL("XQO","PXU"):0 Q:'$T
 S ^XUTL("XQMERGED","PXU")=$H
 ;
 K ^XUTL("XQO","PXU")
 M ^XUTL("XQO","PXU")=^DIC(19,"AXQ","PXU")
 ;
 L -^DIC(19,"AXQ","PXU")
 K ^XUTL("XQMERGED","PXU")
 Q
 ;
MGSEC ;Now the Secondary Menu trees
 N %,%1
 F %=0:0 S %=$O(^VA(200,DUZ,203,"B",%)) Q:%'=+%  D
 .S %1="P"_%
 .I '$D(^XUTL("XQO",%1)),$D(^DIC(19,"AXQ",%1)) D
 ..I $D(^XUTL("XQMERGED",%1)) D OLDF(%1)
 ..Q:$D(^XUTL("XQMERGED",%1))  ;Already merging as we speak
 ..S ^XUTL("XQMERGED",%1)=$H
 ..L +^XUTL("XQO",%1):0 Q:'$T
 ..I '$D(^XUTL("XQO",%1)) D
 ...K ^XUTL("XQO",%1)
 ...M ^XUTL("XQO",%1)=^DIC(19,"AXQ",%1)
 ...Q
 ..L -^DIC(19,"AXQ",%1)
 ..K ^XUTL("XQMERGED",%1)
 ..Q
 .Q
 Q
 ;
OLDF(X) ;See if this flag is au current, if not KILL it
 ;X is the P name of the tree, e.g., P9 might be EVE
 S:'$D(XQPXU) XQPXU=$G(^DIC(19,"AXQ","PXU",0))
 I XQPXU="" S XQPXU=$H ;Assume it's rebuilding now
 N Y,Z
 S Y=$G(^XUTL("XQMERGED",X)) Q:Y=""  ;Flag's gone
 S Z=$$HDIFF^XLFDT(XQPXU,Y,2)
 I Z<3600 K ^XUTL("XQMERGED",X) ;Old Flag
 Q
 ;
LOGOPT ;Option audit
 S:'$D(XQLTL) XQLTL=""
 S %=$P($H,",",2),%=DT_(%\60#60/100+(%\3600)+(%#60/10000)/100)
 I XQLTL S $P(^XUSEC(19,XQLTL,0),U,5)=%,XQLTL=0
 S I=1 I XQAUDIT'=1 S I=0 F J=1:2 S K1=$P(XQAUDIT,U,J),K2=$P(XQAUDIT,U,J+1) Q:'$L(K1)!I  I K1=2&(K2=XQY)!(K1=3&($E($P(XQY0,U,1),1,$L(K2))=K2)) S I=1
 Q:'I  S XQLTL=% L +^XUSEC(19,0):0 S %=^XUSEC(19,0),XQLTL=XQLTL+(.00000001*$S(XQLTL'=$E($P(%,U,3),1,14):10,1:$E($P(%,U,3),15,16)+1)),$P(^(0),U,3,4)=XQLTL_"^"_($P(%,U,4)+1) L -^XUSEC(19,0)
 D GETENV^%ZOSV S XUVOL=$P(Y,U,2),^XUSEC(19,XQLTL,0)=XQY_U_DUZ_U_$I_U_$J_"^^"_XUVOL
 K K1,K2
 Q
XPRMP D CHK^XM W !!,"Do you really want to ",$S(XQUR="REST":"restart",1:"halt"),"? YES// " R X:10 S:'$L(X) X="Y"
 I "Yy"'[$E(X) S Y=1 S:^XUTL("XQ",$J,"T")>1 Y=^("T")-1 S ^("T")=Y,Y=^(Y),XQY0=$P(Y,U,2,99),XQPSM=$P(Y,U,1),(XQY,XQDIC)=+XQPSM,XQPSM=$P(XQPSM,XQY,2,3),XQAA="Select "_$P(XQY0,U,2)_" Option: " W ! G ASK^XQ
 G REST:XQUR="REST",HALT:XQUR'="CON"
 ;
CON ;Continue option logic.  Enter from ASK^XQ on timeout.
 W !!,"Do you want to halt and continue with this option later? YES// " R XQUR:20 S:(XQUR="")!('$T) XQUR="Y"
 I "YyNn"'[$E(XQUR,1) W !!,"   If you enter 'Y' or 'RETURN' you will halt and continue here next time",!,"    you logon to the computer.",!,"   If you enter 'N' you will resume processing where you were." G CON
 I "Nn"[$E(XQUR,1) W ! S XQUR=0,Y=^XUTL("XQ",$J,"T"),Y=^(Y),XQY0=$P(Y,U,2,99),XQPSM=$P(Y,U,1),(XQY,XQDIC)=+XQPSM,XQPSM=$P(XQPSM,XQY,2,3),XQAA="Select "_$P(XQY0,U,2)_" Option: " G ASK^XQ
 S X=^XUTL("XQ",$J,^XUTL("XQ",$J,"T")),Y=^("XQM") I (+X'=+Y) S XQM="P"_+Y S XQPSM=$S($D(^XUTL("XQO",XQM,"^",+X)):XQM,$D(^XUTL("XQO","PXU","^",+X)):"PXU",1:"") D:XQPSM="" SS S:XQPSM'="" ^VA(200,DUZ,202.1)=+X_XQPSM
 S X=$P($H,",",2),X=(X>41400&(X<46800))
 W !!,$P("HMM^OK^ALL RIGHT^WELL CERTAINLY^FINE","^",$R(5)+1),"... ",$P("SEE YOU LATER^I'LL BE READY WHEN YOU ARE.^HURRY BACK!^HAVE A GOOD LUNCH BREAK!","^",$R(3)+X+1)
HALT ;
 G H^XUS
REST S XQNOHALT=1 D ^XUSCLEAN G ^XUS
 ;
SS ;Search Secondaries for a particuloar option.
 Q:'$D(^VA(200,DUZ,203,0))  Q:$P(^VA(200,DUZ,203,0),U,4)<1
 S Y=0 F XQI=1:1 Q:XQPSM'=""  S Y=$O(^VA(200,DUZ,203,Y)) Q:Y'>0  S %=^(Y,0) I $D(^XUTL("XQO","P"_%,"^",+X)) S XQPSM="U"_DUZ_",P"_%
 Q
ABLOG S %2=0 F %3=0:0 S %2=$O(^XTV(8989.3,1,"ABPKG",%2)) Q:%2'>0  F %=0:0 S %=$O(^XTV(8989.3,1,"ABPKG",%2,1,%)) Q:%'>0  S %1=$P(^(%,0),U) I $E(XQY0,1,$L(%1))=%1,$E(XQY0,$L(%1)+1)'="Z" D ABLOG1
 K %,%1,%2,%3,%4
 Q
ABLOG1 F %4=0:0 S %4=$O(^XTV(8989.3,1,"ABPKG",%2,1,%,1,%4)) Q:%4'>0  S %1=$P(^(%4,0),U) I $E(XQY0,1,$L(%1))=%1 Q
 I %4'>0 S:'$D(^XTV(8989.3,1,"ABOPT",0)) ^(0)="^8989.333P^" S:'$D(^(XQY)) %4=+$P(^(0),U,3),$P(^(0),U,3,4)=$S(XQY>%4:XQY,1:%4)_U_($P(^(0),U,4)+1) S ^(0)=XQY_U_($S($D(^(XQY,0)):$P(^(0),U,2),1:0)+1),%2="A"
 Q
