FHZDOC2 ; HISC/REL - Diagram Menus ;3/12/89  20:56 
 ;;5.5;DIETETICS;;Jan 28, 2005
 W !! D INIT
 R "Select USER or OPTION name: ",X:DTIME S DIC=3,DIC(0)="EMZ",DIC("S")="I $D(^(201)),^(201)",FL="US" G:X=""!(X["^") END
RQUE D ^DIC I Y>0 S D0=+Y,MQ=$P(Y(0),U,1),Y=+^(201) I $D(^DIC(19,Y,0)) D E G:'FL QPU D GO Q
 S DIC=19,DIC(0)="QEMZ" K DIC("S") D ^DIC S FL="OP",D0=+Y I Y=-1 G FHZDOC2
 I $P(Y(0),U,4)'="M" W !,*7,"This is not a menu option and therefore cannot be diagrammed.",! G FHZDOC2
 D:Y>0 E G:'FL QPU Q
 ;
OP ;
 D INIT S Y=D0 D E:$D(^DIC(19,Y,0)) G GO
US ;
 D INIT Q:'$D(^VA(200,D0,201))  S XQDUZ=D0,Y=+^(201) Q:'$D(^DIC(19,Y,0))  D E
GO K X,XQV,DIC U IO S W=IOM\M-10,%="" S:W>33 W=33
 I W<10 D ^%ZISC W !,*7,"This menu contains too many levels to be diagrammed using this margin width." G FHZDOC2
 S X=^TMP($J,"XQM",1,0),Z=$P(X,"^",2)
 W @IOF,!!?(IOM-17-$L(Z)\2),"DIAGRAM OF MENU: ",Z
 K ^TMP($J,"XQM",1,0) W !,$P(X,U,3)," (",$P(X,U,2),")",!,"|",!,"|"
 F XQL=1:1 Q:'$D(^TMP($J,"XQM",XQL))  S XQT=M,L=1 K Z D L
 D END
Q Q
 ;
L G LL:'$D(^TMP($J,"XQM",XQL,L)) S Y=1,XQV=^(L) I $D(^(L,1)) S XQV(L)=^(1)
 E  S:$P(XQV,U,5)'="M" XQT=L
 S XQP=$P(XQV,U,1),XQP(L)=$E("-----",1,5-$L(XQP))_XQP,X=$P(XQV,U,3)_" ["_$P(XQV,U,2)_"]" D T I $P(XQV,U,4)]"" S X="**UNAVAILABLE**" D T G LL
 S XQV=$P(XQV,U,7) I XQV]"" S X="**LOCKED: "_XQV_"**" D T
LL S Y=0,L=L+1 G L:L'>M
Y S Y=Y+1,L=1 W ! G WL:$O(Z(0))>0 S Z=XQT-1
B I L=M Q:$D(XQV(Z))!'Z  S Z=Z-1,L=1 W !
 D D S L=L+1 G B
D Q:L'<XQT!'$D(XQV(L))  W ?W+10*(L-1)+10 I Y=1 W "|" K:XQV(L)=XQL XQV(L) F X=1:1 G Q:X=W!'$D(Z(L+1)) W "-"
 W "|" W:L<M ?W+4*L Q
WL I '$D(Z(L,Y)) D D G O
 S XQV=Z(L,Y) K Z(L,Y) S:Y=1 XQP=XQP(L) S:XQT'>L L=M I Y=1 F X=1:1 Q:W+10*(L-1)-1<$X  W "-"
 W:Y=1 ?W+10*(L-1),XQP W ?W+10*(L-1)+6,XQV
O S L=L+1 G Y:M<L,WL
 ;
T S D=""
W S Z=$P(X," ",1),X=$P(X," ",2,999) I $L(D)+$L(Z)>W,$L(D) S Z(L,Y)=D,D="",Y=Y+1
 I $L(Z)>W S Z(L,Y)=$E(Z,1,W),Z=$E(Z,W+1,99) S:$E(Z,1)=" " Z=$E(Z,2,99) S Y=Y+1
 S D=D_Z_" " G W:X]"" S Z(L,Y)=D,Y=Y+1 Q
 ;
X S Y=$P(XQB(L),U,XQBN(L)) Q:'$L($P(XQB(L),U,XQBN(L),99))  S XQBN(L)=XQBN(L)+1 I '$D(^DIC(19,+Y,0)) G X
E S Z=^(0),^TMP($J,"XQM",XQL,L)=$P(Y,";",2)_U_Z,XQV=$P(Z,U,6) S:L>1 ^TMP($J,"XQM",XQV(L-1),L-1,1)=XQL I $P(Z,U,4)'="M"!$S(XQV]""&$D(XQDUZ):'$D(^XUSEC(XQV,XQDUZ)),1:0)!($P(Z,U,3)]"") S XQL=XQL+1 G X
 S XQV(L)=XQL,L=L+1,X(L)="",(Y,DIC,DIC(L))=+Y S:M<L M=L
 I $S('$D(^XUTL("XQO",DIC,0)):1,'$D(^DIC(19,DIC,99)):1,1:^DIC(19,DIC,99)'=$P(^XUTL("XQO",DIC,0),U,2)) Q  ;S XQSY=Y,XQDIC=DIC D SET^XQ7 S Y=XQSY
 K XQA S XQJ=-1 F XQI=0:0 S XQJ=$O(^XUTL("XQO",Y,U,XQJ)) Q:XQJ=-1  S XQA($P(^(XQJ),U,2))=XQJ
 S XQB(L)="",XQBN(L)=1,XQJ=+^XUTL("XQO",Y,0) F XQI=1:1:XQJ S XQN=^XUTL("XQO",Y,0,XQI) F XQP=0:1 S XQB=$P(XQN,U,7*XQP+2) Q:'$L($P(XQN,U,7*XQP+2,99))  I $D(XQA(XQB)) S XQB(L)=XQB(L)_XQA(XQB)_";"_$P(XQN,U,7*XQP+1)_U K XQA(XQB)
 D X
 Q:L=1  S L=L-1,DIC=DIC(L) G X
 ;
INIT K ^TMP($J,"XQM"),X,IOP,XQDUZ,DIC S L=0,XQL=1,X(0)=0,M=1
 Q
QPU ;
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN=FL_"^FHZDOC2",ZTSAVE("D0")="",ZTDESC="DIAGRAM MENUS" D ^%ZTLOAD K ZTSK G FHZDOC2
 D:IO["" GO
 G FHZDOC2
END K ^TMP($J,"XQM"),X,FL,IOP,XQDUZ,DIC D ^%ZISC
 I $D(ZTSK) K ^%ZTSK(ZTSK)
 Q
