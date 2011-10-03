XMPC ;(WASH ISC)/THM/CAP-PackMan Compare ;12/04/2002  13:48
 ;;8.0;MailMan;**10**;Jun 28, 2002
 S S="",%2="",C=IOM-2/2\1,(M,B)=0,H=3
D S M=M+1,B=B+1 G:M>O!(B>F) WRI G:^TMP($J,1,M,0)=^TMP($J,2,B,0) D S W=^TMP($J,1,M,0),(%4,%3)=""
 F I=B:1:$S(B+5<F:B+5,1:F) S V=^TMP($J,2,I,0) D DDD G D:%4="EQUAL"
 S Z=1,G=M D HEAD:'$D(%2) D WP S B=B-1 G D
DDD F K=1:5:26 Q:$L($E(V,K,K+10))<7  I $F(W,$E(V,K,K+10)) S %3="MPART" G E1
 Q
E1 D HEAD G MAT:%3="MPART"!(%4="EQUAL") S Z=1,G=M D WP S B=B-1,%4="EQUAL" Q
MAT S Q=1 F J=B:1:I-1 S X=^TMP($J,2,J,0),Z=1,G=J D WF1
 S B=B+(I-B) S:W=V %4="EQUAL" Q:%4="EQUAL"
 S %4=W,%3=^TMP($J,2,B,0),Q=0,Z=1,L=0
 F K=1:1 S X=$E(%4,1,C-5) S:K=1 G=M D WP1 S Y=X,X=$E(%3,1,C-5) S:K=1 G=B,Z=1 D WF1 S %4=$E(%4,C-4,255),%3=$E(%3,C-4,255) D:X'=Y&$D(S)&(L=0) S I '$L(%3)&('$L(%4)) S %4="EQUAL" Q
 Q
WRI I M>O&(B<(F+1)) F I=B:1:F S X=^TMP($J,2,I,0),Q=1,Z=1,G=I D WF1
 I B>F&(M<(O+1)) F I=M:1:O S X=^TMP($J,1,I,0),Z=1,G=I D WP1
 K %,%0,%1,%2,%3,%4,B,C,D,F,G,H,J,K,L,M,N,O,P,Q,R,S,T,V,W,X,Z
W W !,"-----------------------------------------------------------------------------"
 Q
WP S X=W
WP1 W ! Q:'$L(X)  W " ",$S(Z:$J(G,2),1:"  "),"{",$E(X,1,C-5),$C(125) S Z=0 Q:$L(X)<(C-4)  S X=$E(X,C-4,255) G WP1
WF1 W:Q=1 ! Q:'$L(X)  W ?C+2 W $S(Z:$J(G,2),1:"  "),"{",$E(X,1,C-5),$C(125) S Z=0 Q:$L(X)<(C-4)  S X=$E(X,C-4,255) G WF1
HEAD S:H=2 H=0 Q:H'=0  W !,P," (",IOD,")",?C+1,P," (",E,")" S H=1 Q
S F L=1:1:$L(X) G:$E(X,L)'=$E(Y,L) S1
S1 W !?L+3,"^",?L+C+4,"^" Q
LOAD K ^TMP($J,1),^TMP($J,2) S (X,R)=$P(X," ",2) S:X[U (X,R)=$P(R,U,2) I '$D(^%ZOSF("TEST")) W !,"Routine compare not available. " Q
 X ^%ZOSF("TEST") I '$T W !,"Routine ",R," missing from disk." G W
 S DIF="^TMP($J,1,",XCNP=0,X=R X ^%ZOSF("LOAD") S O=XCNP
L3 F F=0:0 D NT Q:+XCN'=XCN!($E(X,1,4)["$END")  I $E(X)'="$" S F=F+1,^TMP($J,2,F,0)=X
 S O=O-1 G XMPC
NT S XCN=$O(@(DIE_XCN_")")) Q:+XCN'=XCN  S X=^(XCN,0) Q
COMP ;COMPARE MESSAGE X TO MESSAGE Y
 S J=.999
C1 S J=$O(^XMB(3.9,X,2,J)) Q:J=""  G C1:^(J,0)=^XMB(3.9,Y,2,J,0)
 W !,"NOT THE SAME" Q
TOP ;W @IOF,!,"MailMan PackMan Compare - For "_XMDUN
 I '$D(XMR) S XMR=^XMB(3.9,XMZ,0)
 I $E($G(IOST),1,2)'="C-" D
 . W "MailMan PackMan Compare - For ",XMV("NAME")
 . W !,"Message #"_XMZ,!,"Subject: "_$P(XMR,U),!,"From: "_$$NAME^XMXUTIL($P(XMR,U,2))
 . D NOW^%DTC S XMA=%,X=% D DW^%DTC W !,X,"  " S Y=XMA D DD^%DT
 . W Y X ^%ZOSF("UCI") W " ("_Y_")",!
 S I="",$P(I,"*",81)=""
 W !,I,!,"Message #"_XMZ_"     Routine from DISK on LEFT - from Message on RIGHT",!,I,!
 K %H,%T,%Y,%,XMA
 Q
