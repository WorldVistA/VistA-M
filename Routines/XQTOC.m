XQTOC ;SEA/MJM - Time Out/Continue/Jump Start ;05/31/2001  10:57
 ;;8.0;KERNEL;**20,157**;Jul 10, 1995
 ;
 S ^XUTL("XQ",$J,1)=XQY_XQPSM_U_XQY0,^("T")=1
 Q:XQJS=0
 S %=^VA(200,DUZ,202.1) K ^(202.1) S $P(XQJS,U,2)=%,XQY=+%,XQPSM=$P(%,XQY,2,99),XQDIC=$S(XQPSM[",":$P(XQPSM,",",2),1:XQPSM)
 I '$D(^XUTL("XQO",XQDIC,"^",XQY)) D NOGO Q
 D
 .N %
 .S %=$G(^XUTL("XQO",XQDIC,"^",XQY))
 .I %="" S %=$G(^DIC(19,"AXQ",XQDIC,"^",XQY))
 .I %]"" S XQOPTN=$P(%,"^",1,99)
 .E  D NOGO S XQFAIL=""
 .Q
 I $D(XQFAIL) K XQFAIL Q
 ;
 W !!,"You were last executing the '",$P(XQOPTN,U,3),"' menu option."
ASK W !,"Do you wish to resume" S %=1 D YN^DICN I '% W !!,"If you wish to continue at the last option you were executing, enter 'Y',",! G ASK
 I %=1
 E  D NOGO Q
 ;
 ;S XQY0=$P(^XUTL("XQO",XQDIC,"^",XQY),U,2,99)
 D
 .N %
 .S %=$G(^XUTL("XQO",XQDIC,"^",XQY))
 .I %="" S %=$G(^DIC(19,"AXQ",XQDIC,"^",XQY))
 .I %]"" S XQY0=$P(%,"^",2,99)
 .E  D NOGO S XQFAIL=""
 .Q
 I $D(XQFAIL) K XQFAIL Q
 ;
 I $D(^XUTL("XQO",XQDIC,"^",XQY,0)) D
 .S XQ=^(0)
 .F XQI=1:1:XQ D
 ..N %
 ..S %=$G(^XUTL("XQO",XQDIC,"^",XQY,0,XQI))
 ..I %="" S %=$G(^DIC(19,"AXQ",XQDIC,"^",XQY,0,XQI))
 ..I %]"" S XQ(XQI)=% ;$P(^XUTL("XQO",XQDIC,"^",XQY,0,XQI),U)
 ..Q
 .Q
 E  S XQ=0
 Q
 ;
SET ;Set up variables to GO JUMP^XQ72.  Enter from ASK1+1^XQ
 S %=^XUTL("XQ",$J,1),XQSV=+%_U_+%_U_$P(%,U,2,99)
 K XQJS
 Q
 ;
LOOK ;Look up the Jump Start Entry
 F  Q:XQUR'[U  S XQUR=$P(XQUR,U,2)
 I '$L(XQUR) D NOGO Q
 D S^XQ75 I 'XQY D NOGO Q
 Q
 ;
NOGO ;Continue fails: reset to primary menu
 S XQY=^XUTL("XQ",$J,"XQM"),XQA3="",XQA=0 K XQCON,XQRE,XQJS,XQUR,XQOPTN
 D S1^XQCHK ; Reconstruct XQY0
 S $P(^XUTL("XQ",$J,0),U,3)=$P(^(0),U,3)_", NOGO"
 Q
 ;
 ;
CON ;Continue option logic.  Enter from ASK^XQ on timeout.
 W !!,"Do you want to halt and continue with this option later? YES// " R XQUR:20 S:(XQUR="")!('$T) XQUR="Y"
 I "YyNn"'[$E(XQUR,1) W !!,"   If you enter 'Y' or 'RETURN' you will halt and continue here next time",!,"    you logon to the computer.",!,"   If you enter 'N' you will resume processing where you were." G CON
 I "Nn"[$E(XQUR,1) W ! S XQUR=0,Y=^XUTL("XQ",$J,"T"),Y=^(Y),XQY0=$P(Y,U,2,99),XQPSM=$P(Y,U,1),(XQY,XQDIC)=+XQPSM,XQPSM=$P(XQPSM,XQY,2,3),XQAA="Select "_$P(XQY0,U,2)_" Option: " G ASK^XQ
 S X=^XUTL("XQ",$J,^XUTL("XQ",$J,"T")),Y=^("XQM") I (+X'=+Y) S XQM="P"_+Y S XQPSM=$S($D(^XUTL("XQO",XQM,"^",+X)):XQM,$D(^XUTL("XQO","PXU","^",+X)):"PXU",1:"") D:XQPSM="" SS S:XQPSM'="" ^VA(200,DUZ,202.1)=+X_XQPSM
 S X=$P($H,",",2),X=(X>41400&(X<46800))
 W !!,$P("Great^OK^All right^Well certainly^Fine","^",$R(5)+1),".  ",$P("See you later.^I'll be ready when you are.^Hurry back!^Have a nice lunch.","^",$R(3)+X+1)
 G H^XUS
 ;
SS ;Search Secondaries for a particular option.
 Q:'$D(^VA(200,DUZ,203,0))  Q:$P(^VA(200,DUZ,203,0),U,4)<1
 S Y=0 F XQI=1:1 Q:XQPSM'=""  S Y=$O(^VA(200,DUZ,203,Y)) Q:Y'>0  S %=+^(Y,0) I $D(^XUTL("XQO","P"_%,"^",+X)) S XQPSM="U"_DUZ_",P"_%
 Q
