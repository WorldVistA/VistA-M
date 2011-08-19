LAKOAG40 ;SLC/RWF - ORTHO KOAGULAB 40-A ;7/20/90  09:23 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;CROSS LINK BY CUP
LA1 S:$D(ZTQUEUED) ZTREQ="@" S LANM=$T(+0),TSK=$O(^LAB(62.4,"C",LANM,0)) Q:TSK<1
 Q:'$D(^LA(TSK,"I",0))
 K LATOP D ^LASET Q:'TSK  S X="TRAP^"_LANM,@^%ZOSF("TRAP")
LA2 K Y S TOUT=0,BAD=0,A=1 D IN G QUIT:TOUT,LA2:$E(IN,1,5)'?3AP2N D QC I $E(Y(1),20,21)="01" S CUP=0 K TV
 G LA2:'$D(CUP) S I=+$E(Y(1),4,5),I=$S(I=13:1,I=14:3,1:I) I $D(TC(I)) X TC(I,2) S @TC(I,1)=$S('BAD:+V,1:"") ;Test # in Auto Inst. file must match test code
 G LA2:$E(Y(1),4,5)=13
 S (ID,IDE,CUP)=CUP+1,TRAY=1 ;Future expansion of instrument software will transmit IDE
LA3 X LAGEN G LA2:'ISQN ;Can be changed by the cross-link code
 F I=0:0 S I=$O(TV(I)) Q:I<1  S:TV(I,1)]"" ^LAH(LWL,1,ISQN,I)=TV(I,1)
 G LA2
QC ;QC TESTING HERE; S BAD=1 IF DONT STORE
 S Y(A)=IN S:$E(IN,66,69)?2A2N BAD=1 Q
NUM S X="" F JJ=1:1:$L(V) S:$A(V,JJ)>32 X=X_$E(V,JJ)
 S V=X Q
IN S CNT=^LA(TSK,"I",0)+1 IF '$D(^(CNT)) S TOUT=TOUT+1 Q:TOUT>9  H 30 G IN
 S ^LA(TSK,"I",0)=CNT,IN=^(CNT),TOUT=0
 S:IN["~" CTRL=$P(IN,"~",2),IN=$P(IN,"~",1)
 Q
QUIT LOCK ^LA(TSK) H 1 K ^LA(TSK),^LA("LOCK",TSK),^TMP($J),^TMP("LA",$J)
 Q
TRAP D ^LABERR S T=TSK D SET^LAB G @("LA2^"_LANM) ;ERROR TRAP
