XQ41 ;SEA/JLI - Diagram menus (continued) ;08/27/97  14:47
 ;;8.0;KERNEL;**46**;Jul 10, 1995
L G LL:'$D(^TMP($J,"XQM",XQL,L)) K X1,X2,X3 S Y=1,XQV=^(L) S:$D(^(L,.1)) X1=^(.1) S:$D(^(.2)) X2=^(.2) S:$D(^(.3)) X3=^(.3) I $D(^(1)) S XQV(L)=^(1)
 E  S:$P(XQV,U,5)'="M" XQT=L
 S XQP=$P(XQV,U,1),XQP(L)=$E("-----",1,5-$L(XQP))_XQP_" ",X=$P(XQV,U,3)_" ["_$P(XQV,U,2)_"]" D T I $P(XQV,U,4)]"" S X="**UNAVAILABLE**" D T
 G:XQ4<0 LL I $P(XQV,U,7)]"" S X="**LOCKED: "_$P(XQV,U,7)_"**" D T
 I $P(XQV,U,17)]"" S X="**R-LOCK: "_$P(XQV,U,17)_"**" D T
 S XQN=$O(^DIC(19,"B",$P(XQV,U,2),0)),XQX=""
 I $D(^DIC(19,XQN,3.91)) S %XQI=0 F  S %XQI=$O(^DIC(19,XQN,3.91,%XQI)) Q:%XQI'>0  S XQX=XQX_$P(^(%XQI,0),U,1)_$P(^(0),U,2)_" "
 I XQX="" S XQX=$P(XQV,U,10) I XQX'="" S XQX=XQX_"MO-FR"
 I XQX]"" S X="**PROHIBITED TIMES: "_XQX_"**" D T
 K XQX,%XQI
 I XQ4>0&$D(X3) S X="**HEADER: " D T S X=X3 D T
 I XQ4>0&$D(X1) S X="**ENTRY ACTION: " D T S X=X1 D T
 I XQ4>0&$D(X2) S X="**EXIT  ACTION: " D T S X=X2 D T
LL S Y=0,L=L+1 G L:L'>M
Y S Y=Y+1,L=1 D:$Y+2>IOSL WAIT Q:XQFLAG=U  W ! G WL:$O(Z(0))>0 S Z=XQT-1
B I L=M Q:$D(XQV(Z))!'Z  S Z=Z-1,L=1 W !
 D D S L=L+1 G B
D Q:L'<XQT!'$D(XQV(L))  W ?W+10*(L-1)+10 I Y=1 W "|" K:XQV(L)=XQL XQV(L) F X=1:1 G Q:X=W!'$D(Z(L+1)) W "-"
 W "|" W:L<M ?W+4*L Q
WL I '$D(Z(L,Y)) D D G O
 S XQV=Z(L,Y),XQP=XQP(L) K Z(L,Y) S:XQT'>L L=M I Y=1 F X=1:1 Q:W+10*(L-1)-1<$X  W "-"
 W:Y=1 ?W+10*(L-1),XQP W ?W+10*(L-1)+6,XQV
O S L=L+1 G Y:M<L,WL
 ;
T S D=""
W S Z=$P(X," ",1),X=$P(X," ",2,999) I $L(D)+$L(Z)>W,$L(D) S Z(L,Y)=D,D="",Y=Y+1
 I $L(Z)>W S Z(L,Y)=$E(Z,1,W),Z=$E(Z,W+1,99) S:$E(Z,1)=" " Z=$E(Z,2,99) S Y=Y+1
 S D=D_Z_" " G W:X]"" S Z(L,Y)=D,Y=Y+1 Q
 ;
X Q:'$D(XQB(L))&('$D(XQBN(L)))  Q:'$D(XQB(L,XQBN(L)))  S Y=$G(XQB(L,XQBN(L))) Q:'$D(XQB(L,XQBN(L)))  S XQBN(L)=XQBN(L)+1 I '$D(^DIC(19,+Y,0)) G X
E Q:'$D(Y)  S Z=^DIC(19,+Y,0) S:$P(Z,U,16) XI=$S('$D(^(3)):"",1:$P(^(3),U)),Z=$P(Z,U,1,15)_U_XI_U_$P(Z,U,17,99) S ^TMP($J,"XQM",XQL,L)=$P(Y,";",2)_U_Z,XQV=$P(Z,U,6) S:L>1 ^TMP($J,"XQM",XQV(L-1),L-1,1)=XQL
 F XQI=15,20,26 I $D(^DIC(19,+Y,XQI))#2,^(XQI)'="" S ^TMP($J,"XQM",XQL,L,$S(XQI=26:.3,XQI=15:.2,1:.1))=^(XQI)
 I $P(Z,U,4)'="M"!$D(^TMP($J,"XQ1",+Y))!$S(XQV]""&$D(XQDUZ):'$D(^XUSEC(XQV,XQDUZ)),1:0)!($P(Z,U,3)]"") S XQL=XQL+1 G X
 S ^TMP($J,"XQ1",+Y)="",XQV(L)=XQL,L=L+1,X(L)="",(Y,XQDIC,XQDIC(L))=+Y S:M<L M=L
 I $S('$D(^XUTL("XQO",XQDIC,0)):1,'$D(^DIC(19,XQDIC,99)):1,1:^DIC(19,XQDIC,99)'=$P(^XUTL("XQO",XQDIC,0),U,2)) S XQSAV=Y D ^XQSET S Y=XQSAV K XQSAV
 K XQA S XQJ=-1 F  S XQJ=$O(^XUTL("XQO",Y,U,XQJ)) Q:XQJ=""  S XQA($P(^(XQJ),U,2))=XQJ
 K XQB(L) S XQBN(L)=1,XQJ=+^XUTL("XQO",Y,0),XQBN1=0
 F XQI=1:1:XQJ S XQN=^XUTL("XQO",Y,0,XQI) F XQP=0:1 S XQB=$P(XQN,U,8*XQP+2) Q:'$L($P(XQN,U,8*XQP+2,99))  I XQB'="",($D(XQA(XQB))) S XQBN1=XQBN1+1,XQB(L,XQBN1)=XQA(XQB)_";"_$P(XQN,U,8*XQP+1) K XQA(XQB)
 K XQBN1
 D X
 Q:L=1  S L=L-1,XQDIC=XQDIC(L) G X
 ;
WAIT ;
 I 1 S XQFLAG="" R:IOST["C-" !?26,"Press RETURN to continue, '^' to halt...",XQFLAG:DTIME S:'$T XQFLAG=U W @IOF
Q Q
 ;
