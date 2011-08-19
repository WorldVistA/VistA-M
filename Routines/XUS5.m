XUS5 ;SF-ISC/STAFF - RESUME LOGIC FOR CONTINUE ;07/15/2003  12:39
 ;;8.0;KERNEL;**313**;Jul 10, 1995
 S %=^XUTL("XQ",$J,"XQM"),XQSV=%_U_%_U_$S($D(^XUTL("XQO","P"_%,"^",%)):$P(^(%),U,2,99),1:^DIC(19,%,0))
 G JUMP^XQ72
 ;
CONT D ABT^XQ12
C1 S XQY=^VA(200,DUZ,201),^XUTL("XQ",$J,"XQM")=XQY,^("T")=1
 S XQY0=$S($D(^XUTL("XQO","P"_XQY,"^",XQY)):$P(^(XQY),U,2,99),1:"") I XQY0="" D S1^XQCHK
 S XQCY=XQY D ^XQCHK I XQCY<1 S XQPRMN=1,XQL=0 D MES^XQCHK,PAUSE^XQ6 G ^XUSCLEAN
 S XQDIC="P"_XQY,^XUTL("XQ",$J,1)=XQY_XQDIC_U_XQY0
 I $P(XQY0,U,14),$D(^DIC(19,XQY,20)),$L(^(20)) X ^(20)
 I $D(XQUIT) W !!,"==> The variable XQUIT encountered in the Entry Action of your Primary Menu.",*7 S XQL=0 D PAUSE^XQ6 G ^XUSCLEAN
 I $P(XQY0,U,18),$D(^DIC(19,XQY,26)),$L(^(26)) X ^(26)
 S XQA=0 Q:'$D(^VA(200,DUZ,202.1))
 S %=^(202.1) K ^VA(200,DUZ,202.1) S XQY=+%,XQPSM=$P(%,XQY,2),XQDIC=$S(XQPSM[",":$P(XQPSM,",",2),1:XQPSM)
 S XQCY=XQY D ^XQCHK I 'XQCY K XQCY,XQCY0 D NOGO Q
 I $E(XQDIC,1)="U" D:$S('$D(^XUTL("XQO",XQDIC,0)):1,'$D(^VA(200,DUZ,203.1)):1,1:^VA(200,DUZ,203.1)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET
 I $E(XQDIC,1)="P",XQDIC'="PXU" I $S('$D(^XUTL("XQO",XQDIC,0)):1,'$D(^DIC(19,$E(XQDIC,2,99),99.1)):1,1:0) S XQCON="" D NOGO Q
 I XQDIC="PXU" S %=$O(^DIC(19,"B","XUCOMMAND",0)) I $S('$D(^XUTL("XQO",XQDIC,0)):1,'$D(^DIC(19,%,99.1)):1,1:0) S XQCON="" D NOGO Q
 I '$D(^XUTL("XQO",XQDIC,"^",XQY)) D NOGO Q
 W !!,"You were last executing the '",$P(^XUTL("XQO",XQDIC,"^",XQY),U,3),"' menu option."
ASK W !,"Do you wish to resume" S %=1 D YN^DICN I '% W !!,"If you wish to continue at the last option you were executing, enter 'Y',",! G ASK
 I %=1 S XQA=1,XQY0=$P(^XUTL("XQO",XQDIC,"^",XQY),U,2,99)
 E  D NOGO Q
 I $D(^XUTL("XQO",XQDIC,"^",XQY,0)) S XQ=^(0) F XQI=1:1:XQ S XQ(XQI)=$P(^XUTL("XQO",XQDIC,"^",XQY,0,XQI),U)
 E  S XQ=0
 Q
 ;
NOGO ;Continue fails: reset primary menu
 S XQY=^XUTL("XQ",$J,"XQM"),XQA3="",XQA=0 K XQCON,XQRE
 Q
 ;
EUC ; EDIT USER CHARACTERISTIC
 N Y,XUDEV,XUIOP,IOP,DR,DIE,DA,DUOUT
 S Y=0,XUDEV=$G(^XUTL("XQ",$J,"IOS"))
 I $D(^VA(200,DUZ,1.2))[0 S ^(1.2)=IOST(0)
 K XUIOP(1) D:'$D(ION) HOME^%ZIS S:'($D(XUIOP)#2) XUIOP=ION
 I $D(^VA(200,DUZ,1.2))#2,$D(^%ZIS(2,+^(1.2),0)) S $P(XUIOP,";",2)=$P(^(0),U)
 D TT^XUS3 G ECX:$D(DUOUT)!$D(DTOUT)
 S POP=1,X=+$G(^VA(200,DUZ,1.2))
 I X'=$G(^XUTL("XQ",$J,"IOST(0)")) S IOP=$S($D(^XUTL("XQ",$J,"ION")):^("ION"),1:"HOME")_";"_$P($G(^%ZIS(2,X,0)),"^"),%ZIS="M" D ^%ZIS
 I 'POP S ^VA(200,DUZ,1.2)=IOST(0) D SAVE^XUS1
 S DR="["_$$GET^XUPARAM("XUEDIT CHARACTERISTICS","N")_"]"
 S DIE="^VA(200,",DA=DUZ D XUDIE
ECX S X=$P($G(^VA(200,DUZ,200)),U,6),DUZ("AUTO")=$S(X'="":X,1:DUZ("AUTO")),X=$P($G(^(200)),U,9) I X'="" S DUZ("BUF")=(X["Y"),X=$S(DUZ("BUF"):"",1:"NO-")_"TYPE-AHEAD" X:$D(^%ZOSF(X)) ^%ZOSF(X)
 ;DUZ("LANG")
 K X
 Q
VIRTUAL ;
 N X,Y,DIC
 S X=$S($D(^%ZOSF("VOL")):^("VOL")_$I,1:$E($I,2,99)),DIC=3.5,DIC(0)="ML",DIC("DR")="1///"_$I_";1.9////"_$S($D(^%ZOSF("VOL")):^("VOL"),1:"")_";4////1;5////1;2////TRM;.02////"_$I D ^DIC K DIR,DR Q:Y<0  S XUDEV=+Y
 Q
 ;Called from several places.
XUDIE ; Check and see if need a DDS or a DIE call
 N J,XUDIE,DDSFILE,DIMSG
 S:+DIE DIE=^DIC(+DIE,0,"GL") S J=$S($E(DR)="[":$E(DR,2,$L(DR)-1),1:""),XUDIE=DIE_(+DA)_",0)"
 L +@XUDIE:2 I '$T W !,"Record in use by someone else." Q
 I J]"",IOST["C-",$D(^DIST(.403,"B",J)) S DDSFILE=DIE D ^DDS G:'$D(DIMSG) XUDIEX
 K DIMSG D ^DIE
XUDIEX ;
 D CALL^XUSERP(+DA,2) ;Call XQOR
 L -@XUDIE Q
