XMLSWP2 ;(WASH ISC)/CAP-Sliding Window Protocol ;04/17/2002  10:59
 ;;8.0;MailMan;;Jun 28, 2002
TRAN Q:$S('$D(XM):1,XM'["D":1,1:0)  N I,X,Y,% S X=$P($H,",",2),Y=X\3600_":"_$J(X#3600\60,2)_":"_$J(X#60,2) F I=1:1 Q:Y'[" "  S Y=$P(Y," ")_0_$P(Y," ",2,4)
 S %=$E(Y_" ",1,$L(XMTRAN)<245*99),%=%_$E(XMTRAN,1,245-$L(%)) U IO(0) W !,% I IO'="" U IO
 Q
PROG ;Statistics
 I '$D(T) S T=$H*86400+$P($H,",",2)-1
 N D,X S D=$S($D(^XMBS(4.2999,XMINST,3))#10:^(3),1:""),$P(D,U,1,6)=$H_U_$S($D(XMZ):XMZ,1:"")_U_I_U_E_U_$J(C/($H*86400+$P($H,",",2)-T),0,2)_U_IO_" SWP" S ^(3)=D,XMLCT=0
 Q:$S('$D(XMLIN):1,XMLIN="":1,'G:1,1:0)
 S D="Line: "_$P(D,U,3)_", Speed: "_$P(D,U,5) Q:$S('$D(W):1,+W'=W:1,1:0)
 S D=D_", Window: "_W_", Out: ",A=0
 F X=0:0 S X=$O(W(X)),A=A+1 I '$O(W(X)) S D=D_$O(W(0))_"/"_X Q
 S D=D_", Status: "_G_"/"_E X P("I")
 Q
PROGS N % S %=1 G PROG
PROGR N % S %=2 G PROG
QQQ S ER=F>9,E=E+1 R X:4 G Q:'$T,QQQ
QQ K W S ER=0
Q K XMLSWPQ S:$D(XMBLOCK) XMS0AJ=J G:'ER R:$O(W(0)) S XMTLER=$S('$D(XMTLER):E,1:XMTLER+E) G U:ER
 S:$O(W(0)) XMS0AJ=$O(W(0))-.000001
 I G,$D(Z),$P(Z,U)="@" S XMS0AJ="@"
U K W,Y Q:'ER  K XMBLOCK Q
R S X=$O(W(0)),V=0,W=$S(W-4>6:W-4,W>6:6,1:W),E=E+1 D E^XMLSWP0 G QQQ:E>199 I 'X S A=0 G W^XMLSWP
 S %X=^XMB(3.9,XMZ,2,W(X,0),0) I $E(%X)="." S %X="."_%X
 W %X,$C(13),W(X,2),$C(13) S (ER,F)=0,D="Retransmit line "_X X P("S")
 K %X H 3 G 2^XMLSWP
