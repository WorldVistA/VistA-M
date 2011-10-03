LABCX4XX ;SLC/DLG - BECKMAN BIDIRECTIONAL DIRECT CONNECT INTERFACE ;8/16/90  14:53 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 S:$D(ZTQUEUED) ZTREQ="@"
 S LANM=$T(+0),(TSK,T)=+$E(LANM,7,8) Q:+T<1  Q:$D(^LA("LOCK",T))  S IOP=$P(^LAB(62.4,T,0),"^",2) G:IOP="" H^XUS G ^LABCX4I
LA2 K RES,TV,Y S A=1 G RD:OUT="" D:$D(^LA(DEB,0)) DBO W OUT G RD:$A(OUT,1)<32
 I OUT'["]" G W
 W !
RD S:OUT["[" TOUT=$S($P(OUT,",",3)="03":180,1:15) S IN="",A=0 R *X:TOUT G:'$T TOUT D:$D(^LA(DEB,0)) DBX S IN=$C(X) D IN G RD1:IN="["
 I X=LB S ^LA(T,"P")="IN",OUT=$C(ACK),^("P1")=ETX G LA2
 I X=LBO S OUT=$C(NAK) G LA2
 I X=EOT S ^LA(T,"P")="",(^("P1"),^("P2"))=ACK,OUT="" G LA2
 I X=ENQ G LA2
 I X=NAK S ^LA(T,"O",0)=^LA(T,"P3") G W
 I X=^LA(T,"P2") S ^("P2")=$S(X=ACK:ETX,1:ACK),^LA(T,"P3")=^LA(T,"O",0),OUT="",FLA=1,^LA(T,"P")="OUT" G RD
 S OUT="" G LA2
RD1 S TOUT=2,CK=X,FL=1,^LA(T,"P")="IN"
RD2 F I=0:0 Q:$L(IN)=255  R *X:TOUT Q:('$T!(X=13))  S:FL CK=CK+X S IN=IN_$C(X) S:X=93 FL=0
 D:'$D(^LA(T,"I")) SET D IN,QC,DBI:$D(^LA(DEB,0)) S LN=$L(IN)
 I LN=255,(IN'["]") S IN="" G RD2
 I LN<255,(IN'["]") S OUT=$C(NAK) G LA2
 S LRCC=$S(LN=1:$E(Y(A-1),$L(Y(A-1)))_IN,LN=2:IN,1:$E(IN,LN-1,LN))
 S CK=CK+($F("0123456789ABCDEF",$E(LRCC,1))-2*16)+$F("0123456789ABCDEF",$E(LRCC,2))-2#256 S:CK OUT=$C(NAK) G:CK LA2 S OUT=$C(^LA(T,"P1")),^LA(T,"P1")=$S(^LA(T,"P1")=ACK:ETX,1:ACK)
 K TV S (TRAY,CUP,ID,IDE,RMK)="",ST=+$P(Y(1),",",2),FC=+$P(Y(1),",",3) G @ST
400 ;
403 ;
404 G LA2
401 G:FC#2 LA2 S RC=+$P(Y(1),",",$S(FC=2:4,1:5)) G:RC>0 LA2 D OUT G LA2
402 D HDR:FC=1,RES:FC=3,RES1:FC=11 G LA2:'(FC=1!(FC=3)!(FC=11))
LA3 G:ID="" LA2 X LAGEN G LA2:'ISQN
 F I=0:0 S I=$O(TV(I)) Q:I<1  S:TV(I,1)]"" ^LAH(LWL,1,ISQN,I)=TV(I,1)
 S:$L(RMK) ^LAH(LWL,1,ISQN,1)=RMK G LA2
W IF $D(^LA("STOP",T)) K ^LA("LOCK",T),^LA("STOP",T) G H^XUS
 S OUT="",CNT=^LA(T,"O",0)+1 I $D(^(CNT)) S ^(0)=CNT,OUT=^(CNT)
 S:OUT=$C(4,1) ^LA(T,"P")="PEND" G LA2
TOUT S %H=$H D YMD^%DTC S:LADT'=X LADT=X K %,%H
 I $D(^LA(T,"O")),^LA(T,"O")>^LA(T,"O",0) G W
 I $D(^LA(T,"C")),^LA(T,"C")>^("C",0) D OUT G TOUT
 G RD Q
QC S A=A+1,Y(A)=IN Q
NUM S X="" F JJ=1:1:$L(V) S:$A(V,JJ)>32 X=X_$E(V,JJ)
 S V=X Q
IN Q:IN="["  L ^LA(T,"I") S (CNT,^LA(T,"I"),^LA(T,"I",0))=^LA(T,"I")+1,^LA(T,"I",CNT)=$S($L(IN)>1:IN,1:"~"_$C(X+64)) K:CNT>100 ^LA(T,"I",CNT-100) L  Q
OUT Q:'$D(^LA(T,"C",0))  S MV="",CNT=^LA(T,"C",0)+1 I $D(^(CNT)) S ^(0)=CNT,MV=^(CNT),CT=^LA(T,"O")+1,^("O")=CT,^("O",CT)=MV K:CT>100 ^LA(T,"O",CT-100)
 Q:MV=""  I MV'[$C(4),(MV'["]") G OUT
HDR S IDE=+$P(Y(1),",",19),ID=+$P(Y(1),",",15),TRAY=+$P(Y(1),",",8),CUP=+$P(Y(1),",",9)
 S RMK=$P(Y(1),",",16)_$P(Y(1),",",17)_$P(Y(1),",",27)_$P(Y(2),",",1) F I=$L(RMK):-1:1 Q:$E(RMK,I)'=" "  S RMK=$E(RMK,1,I-1)
 Q
RES S TRAY=+$P(Y(1),",",8),CUP=+$P(Y(1),",",9),V=$P(Y(1),",",10) D NUM S TS=V,V=$P(Y(1),",",15) D NUM S:V="" V=$P(Y(1),",",23) D NUM S V=$S("*"[V:"","#"[V:"",1:V) I V]"",($D(TS(TS))#2) S @TC(TS(TS),1)=+V
F S J=$O(^LAH(LWL,1,"B",TRAY_";"_CUP,0)) I J>0 S ID=$P(^LAH(LWL,1,J,0),"^",5)
 Q
RES1 S TRAY=+$P(Y(1),",",5),CUP=+$P(Y(1),",",6),V=$P(Y(1),",",8) D NUM S TS=V
 S V=$P(Y(1),",",10) D NUM S:"*"[V V="" I V]"",($D(TS(TS))#2),($P(Y(1),",",11)="OK") S @TC(TS(TS),1)=+V
 G F
DQ K ^LA("LOCK",$E($T(+0),7,8)) G LABCX4XX
SET S:'$D(^LA(T,"I"))#2 ^LA(T,"I")=0,^("I",0)=0
SETO S:'$D(^LA(T,"O"))#2 ^LA(T,"O")=0,^("O",0)=0 Q
TRAP D ^LABERR S T=TSK D SET^LAB G @("LA2^"_LANM)
DBO S (Q,^LA(DEB,0))=^LA(DEB,0)+1,^(Q)="OUT: "_$S($L(OUT)>2:$E(OUT,1,230),$L(OUT)=1:"~"_$C($A(OUT)+64),1:"~"_$C($A(OUT,1)+64)_"~"_$C($A(OUT,2)+64))_"%^%"_$H Q
DBX Q:X=91  S (Q,^LA(DEB,0))=^LA(DEB,0)+1,^(Q)="IN: "_$S(X>31:$C(X),1:"~"_$C(X+64))_"%^%"_$H Q
DBI S (Q,^LA(DEB,0))=^LA(DEB,0)+1,^(Q)="IN: "_$E(IN,1,230)_"%^%"_$H Q
