LAC178HP ;SLC/FHS - DUAL CORNING 178 VIA HP COMPUTER ;8/16/90  14:12
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
EN ;
 ;Cross linked by IDE
 ;Enter transmitted test name in PARAM 3
 S:$D(ZTQUEUED) ZTREQ="@"
 S LANM=$T(+0),TSK=$O(^LAB(62.4,"C",LANM,0)) Q:'$D(^LA(TSK,"I",0))
 S SS="CH" D ^LASET Q:TSK<1  S X="TRAP^"_LANM,@^%ZOSF("TRAP")
 F I=0:0 S I=$O(TC(I)) Q:I'>0  S LA(TC(I,4))=TC(I,1)
 S (TOUT,ID)=0,TRAY=1
LA2 D IN G QUIT:TOUT G LA2:$E(IN,1,7)'="Corning" D IN S X=$E(IN,20,30) D PACK G:X="---" LA2 S (CUP,ID,IDE)=X
TEST ;
 F A=0:0 D IN Q:IN=""  S TEST=$P(IN," "),X=$E(IN,8,13) D PACK I $D(LA(TEST)) S @LA(TEST)=X
 X LAGEN F I=0:0 S I=$O(TV(I)) Q:I<1  S R=$S($D(TV(I,1)):TV(I,1),1:"") S:R'="" ^LAH(LWL,1,ISQN,I)=R
 F I=0:0 S I=$O(TC(I)) Q:I<1  S:$D(TC(I,1)) @TC(I,1)=""
 G LA2
PACK S Y=X,X="" F I=1:1:$L(Y) S:$A(Y,I)-32 X=X_$E(Y,I)
 Q:X=""  S:X'?.P1N.NP X="---" Q
IN S CNT=^LA(TSK,"I",0)+1 IF '$D(^(CNT)) Q:TOUT>9  S TOUT=TOUT+1 H 9 G IN
 S IN=^(CNT),^(0)=CNT,TOUT=0
 Q
QUIT F I=0:0 LOCK ^LA(TSK):1 Q:$T  H 5 G QUIT
 K ^LA(TSK),^LA("LOCK",TSK) LOCK
 Q
TRAP D ^LABERR S T=TSK D SET^LAB G @("LA2^"_LANM) ;ERROR TRAP
 ;
FORMAT ;Data stream should look like.
 ;
 ;Corning 178-1 xx/xx/xx 00:00
 ;                ACC #
 ;pH     7.401
 ;pCO2    57.8
 ;pO2     47.5
 ;COMMENT
 ;
 ;Spacing is not exact
