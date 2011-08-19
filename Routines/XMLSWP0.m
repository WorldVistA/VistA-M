XMLSWP0 ;(WASH ISC)/CAP-Sliding Window Protocol ;04/17/2002  10:59
 ;;8.0;MailMan;;Jun 28, 2002
REC ;SEE SEND
 S X=0 G I
RL ;
 R X:$S($D(XMSTIME):XMSTIME,1:15) S Z=$T,(XMRG,D)=X X P("R")
 I 'Z S B=B+1 G RL:B<3 S B=0,B(0)=$S($D(B(0)):B(0)+1,1:1) G:B(0)<4&G F:'M,RL D E G ER
 S (B,B(0))=0
Y S L=X D SUM I $D(XMLIN),XMLIN>1,X?1"..".E S (XMRG,X)=$E(X,2,999)
 R W:15 E  S B=B+1 G RL
 G Z:L'=".",Z:$P(W,U,2)'=47,Z:$P(W,U,5)'="<<END~OF~FILE>>"
 S (D,V)=1,F=0 I $O(W(0)) G F
V S XMRG="." K XMBLOCK F XMLIN=XMLIN+1:1 Q:'$D(^XMB(3.9,XMZ,2,XMLIN))
 D SEND Q:D  S F=F+1 G ER
Z S D=0 I W'?.".".N1"^"1N.N1"^~".E S (XMRG,X)=W G Y
 I S-$P(W,U,2)=0 S D=1 D SEND
 I D,L=O G F:$P(W,"@@",2)="<<Ctrl-Packet>>"
 I 'D G F:G S F=F+1,ER=1 Q:F>3  W "!@~^NAK^~@!",$C(13) S ER=0 G RL
 Q:'$D(XMLIN)!'+W  Q:XMLIN=0  S M=$S(L="QUIT":99,1:0),F=0
 I XMLIN>1,XMLIN+1-W'=0,W-XMLIN>0 F D=W-1:-1 Q:D<1!$D(^XMB(3.9,XMZ,2,D,0))  S W(D)=""
 S D=$S(1-W>0:XMLIN+.001,1:+W) S:D-XMLIN>0 XMLIN=+W K W(+W) I '$D(^XMB(3.9,XMZ,2,D,0)) S ^(0)=XMRG,C=C+$L(XMRG)
 I $D(XMINST),$L(XMINST) S I=XMLIN D P
 G W:XMLIN#10'=0,W:'$O(W(0)) D E S D="Didn't receive "_$O(W(0)) X P("I")
 G F
W G RL:'V,F:$O(W(0)),V
 ;
 ;QUIT control
E S F=F+1 S D="Errors ("_F_")" X P("I") Q
 Q
SUM ;Calculate S=checksum
 I $D(XMOS(0)) X XMOS(0) S S=XMSUM Q
 I XMOS["VAX DSM" S S=$ZC(%LPC,X)+$L(X)*$L(X) Q
 I XMOS["DSM" S S=$ZC(LPC,X)+$L(X)*$L(X) Q
 I XMOS["M/11"!(XMOS["M/VX") S S=$ZC(X)+$L(X)*$L(X) Q
ZSUM S S=$A(X) Q:$L(X)=1  N J S J=1
A S J=J+1 I $L(X)<J K %,%0,%1 S S=S+$L(X)*$L(X) Q
 S Y=$A(X,J) F %=256:0 Q:%\4<Y  S %=%\2
B S %0=S#%,%=%\2 G A:%=0 S %0=%0\%,%1=Y\% I %1=1 S Y=Y-%
 G B:%1+%0=0 I %1'=%0 S:%0=0 S=S+% G B
 G B:%0=0 S S=S-%
 G B
P N G S G=1,XMLCT=$S($D(XMLCT):XMLCT+$L(XMRG),1:$L(XMRG)) Q:$S(XMLIN<100&(XMLIN#20'=0):1,XMLIN#100'=0:1,1:0)  G PROGR^XMLSWP2
I ;Initialize
 N %,A,B,C,D,E,F,G,I,L,M,O,P,Q,S,T,Y,Z
 I $D(XMS0AJ),XMS0AJ<1 N J S (XMLIN,J)=XMS0AJ
 F I=73,83,82 S P($C(I))="I $D(XMLD) S XMTRAN="_$C(34,I,58,32,34)_"_$E(D,1,240) D TRAN^XMLSWP2"
 K Z,W,M S ER=0,(A,B,B(0),B(1),C,E,F,G,M,Q,V)=0,(I,L)="",O="!@~^Resynch^~@!1545",W=$S($E(IOST,1,6)="C-MINI":2,1:1)*3,T=$H*86400+$P($H,",",2)-1
 I $D(XMBLOCK) G ER:'$D(XMS0AJ) S G=1,XMLIN=$S('$D(XMLIN):0,1:XMLIN),J=XMS0AJ G ER:XMTLER
 D LPC:'$D(XMOS) G 1^XMLSWP:X,RL
 ;
 ;RE-SYNCH Receiver
F I '$O(W(0)) W "A-OK"_$C(13)_"^432^~"_$C(13) G RL
 S (B(0),B)=0,M=50
 S (D,X)="!@~^"_+$O(W(0))_"^~@!^^Resynch" D SUM S $P(D,U,4)=S W D,$C(13) X P("S")
 G RL
ER S ER=1 Q
SEND S X=W,$P(X,U,4)="" D SUM I S=$P(W,U,4) Q:$P(W,"@@",2)="<<Ctrl-Packet>>"  W W_$C(13) Q
 S D=0 Q
LPC ;GET CORRECT LPC checksum information
 S XMOS=$S($D(^%ZOSF("OS")):^("OS"),1:0) I $D(^("LPC")) S XMOS(0)=^("LPC")
 I '$D(XMOS(0)),$D(^XMB(1,1,"LPC")) S XMOS(0)=^("LPC")
 I $D(XMOS(0)) S XMOS(0)=XMOS(0)_",XMSUM=Y+$L(X)*$L(X)"
 Q
