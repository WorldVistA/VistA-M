XQT ;SEA/MJM - Menu template loader ;01/09/2001  13:32
 ;;8.0;KERNEL;**20,47,46,37,155**;Jul 10, 1995
 ;
 ;Entry from XQ
 ;
 S XQTSV=XQY_U_XQDIC_U_XQY0,(XQU,XQUR)=$P(XQUR,"[",2)
 I XQUR["?" D:XQUR["??" SHO^XQT4 W !!?5,"See 'Menu Templates' options for more information." G OUT
 I XQUR=" ",$D(^DISV(DUZ,"XQT")) S XQUR=^("XQT"),XQU=""
 D FIND G:XQK OUT D LOD I XQY<0 G OUT
 S ^XUTL("XQ",$J,"S")=XQTSV,^DISV(DUZ,"XQT")=XQUR W:XQU'=-1 $E(XQUR,$L(XQU)+1,99)
 K %,XQ,XQBLD,XQFL,XQI,XQJ,XQK,XQL,XQM,XQMA,XQMN,XQN,XQNO1,XQSIB,XQTSV,XQTL,XQTU,XQU
 G ^XQT1 ; Template is loaded and checked
 ;
FIND ;Find the template requested
 S XQK=0,XQN="",XQJ=1,(XQM,XQMA)=^XUTL("XQ",$J,"XQM")
 I XQUR'?.ANP W *7,"  ??" S XQK=1 Q
 S XQX=XQUR I XQUR'?.PUN S XQX=$$UP^XLFSTR(XQX) ;F XQI=1:1 Q:XQX?.NUP  S XQN=$A(XQX,XQI) I XQN<123,XQN>96 S XQX=$E(XQX,1,XQI-1)_$C(XQN-32)_$E(XQX,XQI+1,255)
 S XQUR=XQX
 F XQI=0:0 S XQN=$O(^VA(200,DUZ,19.8,"B",XQN)) Q:XQN=""  S:XQUR=$E(XQN,1,$L(XQUR)) XQ(XQJ)=XQN,XQJ=XQJ+1
 I XQJ=1 W " ??",*7 S XQK=1 Q
 I XQJ=2 S XQUR=XQ(1) Q
 I XQJ>2 S XQK=0 D CHS
 Q
 ;
LOD ;Load the template into the ^XUTL("XQT").
 ;I $D(^XUTL("XQT",$J,XQUR,0))#2 S ^("T")=1 Q
 S XQN=$O(^VA(200,DUZ,19.8,"B",XQUR,0)) I XQN="" W " ??",*7 G OUT
 I '$D(ZTQUEUED) W @IOF,?33,"Loading ",XQUR,"...",!
 S ^XUTL("XQT",$J,XQUR,0)=DT,(XQEA,XQFL,XQTU)=0
 S XQJ=$P(^VA(200,DUZ,19.8,XQN,1,0),U,3),XQY=XQM,XQL=1
 D NO1^XQT5 Q:XQY'>0
 F XQI=1:1:XQJ Q:XQY=-1  S XQTL=^VA(200,DUZ,19.8,XQN,1,XQI,0) F XQK=1:1 D:'XQFL RPT S XQ=$P(XQTL,U,XQK) Q:XQ=""  S XQY=+XQ,XQDIC=$P(XQ,",",2),XQEA=$P(XQ,",",3) D CHK S XQMA=XQY Q:XQY=-1  D OK Q:XQY=-1
 I XQY=-1 K ^XUTL("XQT",$J,XQUR)
 Q
 ;
SET ;Build the ^XUTL("XQO",+XQDIC [ or "U"_DUZ]) nodes if need be
 L +^XUTL("XQO",XQDIC):5 D:$S('$D(^XUTL("XQO",XQDIC,0)):1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET L -^XUTL("XQO",XQDIC)
 Q
 ;
SETU ;Build the ^XUTL("XQO","U"_DUZ) nodes if need be
 D:$S('$D(^XUTL("XQO","U"_DUZ)):1,'$D(^VA(200,DUZ,203.1)):1,1:^VA(200,DUZ,203.1)'=$P(^XUTL("XQO","U"_DUZ,0),U,2)) ^XQSET
 Q
 ;
CHK ;Make sure it's OK to use this option
 I $D(^XUTL("XQO","P"_XQM,U,XQY))!(XQM=XQY) Q
 I $D(^XUTL("XQO","PXU",U,XQY)) Q
 I '$D(XQBLD) N XQDIC S XQDIC="U"_DUZ D SETU S XQBLD=""
 I $D(^XUTL("XQO","U"_DUZ,U,+XQY)) Q
 S (%,XQTU)=0 F XQII=1:1 Q:XQTU  S %=$O(^VA(200,DUZ,203,%,0)) Q:%'>0  S:$D(^XUTL("XQO","P"_%,U,XQY)) XQTU=1
 Q:XQTU=1
 D SET Q:$D(^XUTL("XQO",XQDIC,U,XQY))
 I '$D(^DIC(19,XQY,0))#2 W !!,"The Option File has been changed. This template will no longer work.",!?5,"'",XQUR,"' should be deleated and/or rebuilt." S XQY=-1 Q
 W !!,"Sorry, the option '",$P(^DIC(19,XQY,0),U,2),"'",!,?5,"is no longer available to you." S XQY=-1
 Q
 ;
OK ;See if it's locked, etc.
 I XQY=XQDIC D S1^XQCHK I 1
 E  L +^XUTL("XQO",XQDIC):5 D:$S('$D(^XUTL("XQO",XQDIC,0)):1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) ^XQSET L -^XUTL("XQO",XQDIC)
 S %=$G(^XUTL("XQO",XQDIC,U,+XQY)) I %="",XQY'=XQDIC W !!,"Because of changes to the Option File an option is no longer available." S XQY=-1 Q
 S XQY0=$S(XQY=XQDIC:XQY0,1:$P(%,U,2,99))
 I $L($P(XQY0,U,3)) W !!,"Option '",$P(XQY0,U,2),"'",!,?5,"is out of order.  The message is: ",$P(XQY0,U,3) S XQY=-1 Q
 I $L($P(XQY0,U,6)),'$D(^XUSEC($P(XQY0,U,6),DUZ)) W !!,"Option '",$P(XQY0,U,2),!,?5,"is locked.  You don't own the key." S XQY=-1 Q
 I $L($P(XQY0,U,9)) D ^XQDATE S X=% D ^XQ92 I X="" W !!,"Option '",$P(XQY0,U,2),"'",!,?5,"is not permitted to run right now.  Sorry." S XQY=-1 Q
 I $P(XQY0,U,10)["y",'$D(^DIC(19,XQY,3.96,"B",ION)) W !!,"Option '",$P(XQY0,U,2),!,?5,"is restricted to run only only certain terminals.  You're not on one.  Sorry." S XQY=-1 Q
 S ^XUTL("XQT",$J,XQUR,XQL)=XQY_U_XQDIC_U_XQY0
 I $P(XQY0,U,17),$D(^DIC(19,XQY,26)),$L(^(26)) S ^XUTL("XQT",$J,XQUR,XQL,"H")=^DIC(19,XQY,26)
 I $P(XQY0,U,14),XQEA["E",$D(^DIC(19,XQY,20)),$L(^(20)) S ^XUTL("XQT",$J,XQUR,XQL,"E")=^DIC(19,XQY,20)
 I $P(XQY0,U,15),XQEA["X",$D(^DIC(19,XQY,15)),$L(^(15)) S ^XUTL("XQT",$J,XQUR,XQL,"X")=^DIC(19,XQY,15)
 S XQL=XQL+1
 Q
 ;
CHS ;Choose the template from those that match
 S XQK=1,XQU=-1 W !!,"Chose by number from: ",! F XQI=1:1:XQJ-1 W !,?5,XQI,".  ",XQ(XQI)
 W !!,"Enter a number between 1 and ",XQJ-1," or '^' to quit: " R %:DTIME S:'$T %=U S:%="" %=U Q:%=U  G:(%'?.N)!(%>(XQJ-1))!(%="")!(%<1) CHS S XQUR=XQ(%),XQK=0
 Q
 ;
RPT ;Set the 'repeat' flag in ^XUTL and strip it off list of options
 S XQFL=1,^XUTL("XQT",$J,XQUR,"RPT")=$P(XQTL,U,1),XQTL=$P(XQTL,U,2,99)
 Q
OUT ;
 S XQY=+XQTSV,XQDIC=$P(XQTSV,U,2),XQY0=$P(XQTSV,U,3,99)
 K %,XQ,XQBLD,XQEX,XQI,XQJ,XQK,XQL,XQM,XQN,XQN1,XQTSV,XQTU
 G NOFIND^XQ
 Q
