LADIMPXX ;SLC/DLG - DIMENSION DIRECT CONNECT INTERFACE ;8/16/90  14:15 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 S:$D(ZTQUEUED) ZTREQ="@" S LANM=$T(+0),(HOME,T,TSK)=$E(LANM,7,8) Q:+T<1  Q:$D(^LA("LOCK",T))  G ^LADIMPI
LA ;Entry point from LADIMPI
LA2 K RS,TV,Y S RN=1 G RD:OUT="" D:$D(^LA(DEB,0)) DBO W OUT G W:OUT[$C(6),NAK:OUT[$C(21),RD:OUT[$C(3),LA2
RD S ^LA(T,"R")=$H R *X:TOUT G RD:'$T D:($T&($D(^LA(DEB,0)))) DBX G RD1:X=2
 I X=6 S IN=X D IN S ^LA(T,"P3")=^LA(T,"O",0),OUT="" G RD
 I X=21 S IN=X D IN S ^LA(T,"O",0)=^LA(T,"P3") G W
 I X=5 S IN=X D IN G LA2
 S IN=X D IN G RD
RD1 S TOUT=5,IN="[",CS=0,^LA(T,"P")="IN"
RD2 F I=0:0 R *X:TOUT S:($T&($L(IN)<255)) IN=IN_$S(X=3:"]",X=28:FS,1:$C(X)),CS=CS+X Q:(X<0!(X=3)!($L(IN)=255))  I $L(IN)=2,$E(IN)="[" S RT=$E(IN,2)
 D:$D(^LA(DEB,0)) DBI S:RT="R" Y(RN)=IN,RN=RN+1
 D:'$D(^LA(T,"I")) SET D IN S LN=$L(IN)
 I LN=255,(X'=3) S IN="" G RD2
 I LN<255,(X'=3) S OUT=$C(21) D OUT G W
 S:LN=1 CNT=^LA(T,"I")-1,LRCC=$E(^LA(T,"I",CNT),($L(^(CNT))-1),$L(^(CNT)))
 S:LN=2 CNT=^LA(T,"I")-1,LRCC=$E(^LA(T,"I",CNT),$L(^(CNT)))_$E(IN,1)
 S:LN>2 LRCC=$E(IN,LN-2,LN-1)
 S CS=CS-3-$A(LRCC)-$A(LRCC,2)#256,LRCC=$F("0123456789ABCDEF",$E(LRCC,1))-2*16+$F("0123456789ABCDEF",$E(LRCC,2))-2,OUT=$C($S(CS=LRCC:6,1:21))
 D OUT G P:RT="P",R:RT="R",R:RT="C",M:RT="M"
W IF $D(^LA("STOP",HOME)) K ^LA("LOCK",HOME),^LA("STOP",HOME) G H^XUS
 S OUT="",CNT=^LA(T,"O",0)+1 I $D(^(CNT)) S OUT=^(CNT),^(0)=CNT,^LA(T,"P")="OUT"
 G LA2
 ;
 ;
NAK S ^LA(T,"O",0)=^LA(T,"P3") G W
M D UPD S POS=$P(IN,FS,6) S:$P(IN,FS,2)="R" ^LA(T,"C",0)=^LA(T,"P2"),ERC=$P(IN,FS,3) G W
 ;
P D UPD I POS=60 D NEGR S POS=0 G W
 S REQ=$P(IN,FS,4),NC=$P(IN,FS,5),CAR=$S(NC=0:"A",1:0)
 I ERC=7,NC=2 D NEGR G W
 I ERC=7,NC=1 S CAR=$P(IN,FS,6),CAR=$S(CAR="A":"B",1:"A"),ERC=0
 I REQ=0!('$D(^LA(T,"C"))) D NEGR G W
 I ^LA(T,"C")=^("C",0) D NEGR K ^LA(T,"C") S ^LA(T,"P2")=0 G W
 S ^LA(T,"P2")=^LA(T,"C",0)
P2 S Q=^LA(T,"C",0)+1,^(0)=Q,C=^(Q) I C'["%^%" D P4 G P2
 D P4 G W
P4 S J=1,K=$L(C) S:$E(C,1)=$C(2) J=2,$P(C,FS1,2)=CAR S:(($E(C,1)=$C(2))&(CAR'="0")) $P(C,FS1,11)=1 S:C["%^%" K=K-3 D CS
 I C["%^%" D HEX S C=$P(C,"%^%",1)_CS_$C(3)
 S OUT=C D OUT
 Q
NEGR S OUT=$C(2)_"N"_FS1_"6A"_$C(3) D OUT Q
R D UPD S OUT=$C(2)_"M"_FS1_"A"_FS1_FS1_"E2"_$C(3) D OUT G:RT="C" W
 S NP=0,P=1 F I=1:1 Q:'$D(Y(I))  S F=0 F II=0:0 S F=$F(Y(I),FS,F) S NP=NP+1 D NX I F<1 S P=2,F=0 Q
 S IDE=RS(3),ID=RS(4),TRAY=RS(6),CUP=$P(TRAY,";",2),TRAY=$P(TRAY,";",1),NS=RS(9),NT=RS(11),J=12,K=0
AG I $D(TEST(RS(J))),($D(RS(J+3))),(RS(J+3)="") S @TC(TEST(RS(J)),1)=RS(J+1)
 S J=J+4,K=K+1 G:$D(RS(J)) AG G:ID<1 W S %H=$H D YMD^%DTC S:LADT'=X LADT=X K %,%H X LAGEN G:'ISQN W ;Can be changed by the cross-link code
 F I=0:0 S I=$O(TV(I)) Q:I<1  S:TV(I,1)]"" ^LAH(LWL,1,ISQN,I)=TV(I,1)
 G W
NX I F<1,($E(Y(I),$L(Y(I)))'="]") S NP=NP-1,RS(NP)=RS(NP)_$P(Y(I),FS,P),NP=NP+1,P=2,F=0 Q
 S RS(NP)=$P(Y(I),FS,P),P=P+1
 I F=256 S NP=NP+1,RS(NP)=$P(Y(I+1),FS),P=2,F=0
 Q
IN L ^LA(T) S CNT=^LA(T,"I")+1,^("I")=CNT,^("I",CNT)=IN K:CNT-100>0 ^(CNT-100) L  Q
OUT L ^LA(T) S O=^LA(T,"O")+1,^("O")=O,^("O",O)=OUT K:O-100>0 ^(O-100) L  Q
UPD S ^LA(T,"I",0)=^LA(T,"I") Q
CS S CS=$S(J=2:0,1:CS) F I=J:1:K S CS=CS+$A(C,I)
 Q
HEX S CS=CS#256,CS=$E("0123456789ABCDEF",(CS\16+1))_$E("0123456789ABCDEF",(CS#16+1)) Q
DQ K ^LA("LOCK",$E($T(+0),7,8)) G LADIMPXX
SET S:'$D(^LA(T,"I"))#2 ^LA(T,"I")=0,^("I",0)=0
SETO S:'$D(^LA(T,"O"))#2 ^LA(T,"O")=0,^("O",0)=0 Q
 Q
DBO S (Q,^LA(DEB,0))=^LA(DEB,0)+1,^(Q)="OUT: "_$S($L(OUT)>1:$E(OUT,1,230),1:"~"_$C($A(OUT)+64))_"%^%"_$H Q
DBX S (Q,^LA(DEB,0))=^LA(DEB,0)+1,^(Q)="IN: ~"_$C(X+64)_"%^%"_$H Q
DBI S (Q,^LA(DEB,0))=^LA(DEB,0)+1,^(Q)="IN: "_$E(IN,1,230)_"%^%"_$H Q
TRAP D ^LABERR S T=TSK D SET^LAB G @("LA2^"_LANM)
