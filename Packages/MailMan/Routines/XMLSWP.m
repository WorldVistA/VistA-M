XMLSWP ;(WASH ISC)/CAP-Sliding Window Protocol ;04/17/2002  10:58
 ;;8.0;MailMan;;Jun 28, 2002
SEND ;
 S X=1 G I^XMLSWP0
1 ;I $L(XMSG)>245 G E
 I XMSG'?.ANP F %=1:1:$L(XMSG) I $E(XMSG,%)?1C,$A(XMSG,%)'=9 S XMSG=$E(XMSG,1,%-1)_$E(XMSG,%+1,999) Q:XMSG?.ANP  S %=%-1
 S C=C+$L(XMSG),F=0 I G S A=A+1,XMLIN=$S(J<1:"",1:XMLIN\1+1),(M,B(1))=0,XMLCT=$S($D(XMLCT):XMLCT+$L(XMSG),1:$L(XMSG))
D S I=$S('G:"",1:XMLIN),X=XMSG D SUM S Q=I_U_S_"^~^^"_$S(XMSG=".":"<<END~OF~FILE>>",1:"") D CHK S $P(Q,U,4)=S
 W X_$C(13),Q_$C(13) S D=X X P("S")
 I G,I'="" S W(I,0)=J,W(I,1)=$P(Q,U,2),W(I,2)=Q
 I $D(XMINST),$L(XMINST),$S(I<100&(I#20=0):1,I#100=0:1,I<1:1,B(1):1,'J:1,1:0) D PROGS^XMLSWP2
 ;
C G Q:$S(ER:1,1:0) I G,$D(XMLIN),XMLIN G W
2 I G,XMLIN,'$O(W(0)) G Q:J<1!'J,W
 R X:$S('$D(XMLIN):30,XMLIN="":30,'G:30,W<8:9,1:5) E  S:M M=2 G U:'$L(X)
 I X'?.".".N1"^"1N.N1"^~".E G:'G 1:X="!@~^NAK^~@!",C S G=G+1 G C:G<3,W
 S D=X,$P(X,U,4)="" D SUM S X=D I S'=$P(X,U,4) G G:G S F=F+1 G 2:F<9,QQQ
 S B=0 I X?1"!@~^"1N.N1"^~@!^"1N.N1"^Resynch" S D=X,B=0 X P("R") S Y=X G G2
 I $S('$D(XMLIN):1,XMLIN="":1,'G:1,1:0) G Q:X=Q S F=F+1 G 2:F<9,QQQ
3 I '$D(W(+X)) G G9:M="END",W
 I W(+X,1)-$P(X,U,2)'=0 S D="BAD Acknowledgement" X P("I") G R
 I $O(W(0))=+X D K S G=1 G G9:M="END",W:'M,C
 I $D(W(+X)) D K S G=G+1 S:W<G W=$S(W-4>6:W-4,W>6:6,1:W),V=0 G G:W<G I W*2<G S G=1 G R
 I $O(W(0)) S G=G+1 G G9:M="END",G:'M,C:M=1 I W*2<G S G=1 G G
W I $S(W<5&(W*2<A):1,W/2+W<A:1,1:0) G 2
 I $D(Z),$P(Z,U)="@" G G9:Z="@^1" S M=0,Z=Z_"^1" G G9
 S J=$O(^XMB(3.9,XMZ,2,J)) I J S XMSG=^(J,0) G 1:$E(XMSG)'="." S XMSG="."_XMSG G 1
 S Z="@" G C
E D E^XMLSWP0
QQQ G QQQ^XMLSWP2
QQ G QQ^XMLSWP2
Q G Q^XMLSWP2
R G R^XMLSWP2
 ;ACK
K S V=V+1 I $D(W(+X)) S A=A-1 K W(+X)
 Q:$S(W<5&(W*2>V):1,W>4&(W*3>V):1,1:0)
 S V=0 I $D(IOST),$E(IOST,1,6)="C-MINI" S W=$S(W<8:8,W<9:10,W<12:12,1:W)
 E  S W=$S(W<4:4,1:5)
 Q
 ;Timeout
U S B(1)=B(1)+1,D="Time-out ["_B(1)_"]" X P("I") I B(1)<$S(G:4,1:2) G:'$O(W(0)) W:G,D S I=XMLIN G R:A>W,W:G,D
 G E
CHK N X S X=Q
SUM ;Calculate S=checksum
 I $D(XMOS(0)) X XMOS(0) S S=XMSUM Q
 I XMOS["VAX DSM" S S=$ZC(%LPC,X)+$L(X)*$L(X) Q
 I XMOS["DSM" S S=$ZC(LPC,X)+$L(X)*$L(X) Q
 I XMOS["M/11"!(XMOS["M/VX") S S=$ZC(X)+$L(X)*$L(X) Q
 G ZSUM^XMLSWP0
 ;RE-SYNCH Sender
G S (B,XMLSWPQ,M)=0 I M,'$O(W(0)) G W
 I M'=1 G W:'$O(W(0)) S M=1 G 2
G0 S XMLSWPQ=$G(XMLSWPQ)+1 R Y:(9+B) G:'$T G9:XMLSWPQ>20,G0 K XMLSWPQ I B>$S(M:3,1:33) G Q:'M,E
 G G9:'$L(Y) S D=Y X P("R") I Y="A-OK" R Y:(9+B) G G9:Y="",G9:Y'="^432^~" F D=0:0 R Y:4 E  G R:$O(W(0)),QQ
 G G1:Y?1"!@~^"1N.N1"^~@!^"1N.N1"^Resynch" I 'M S M=0 G G9:'$O(W(0)) S X=Y,M="END" G 3
 G W:Y=O,G9
G1 S (D,X)=Y,$P(X,U,4)="" D SUM G G9:S'=$P(D,U,4)
G2 S D="Rec'r reqests "_$P(Y,U,2) X P("I") S B=0 G R:$O(W(0)),QQQ
G9 S (D,X)=O,B=B+1 D SUM S X=U_S_"^~^^@@<<Ctrl-Packet>>" D SUM S $P(X,U,4)=S W O_$C(13)_X_$C(13) X P("S")
 G G0
