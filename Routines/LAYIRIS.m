LAYIRIS ;SLC/RWF- IRIS ;7/20/90  09:22 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;CROSS LINK BY ID OR IDE
LA1 S:$D(ZTQUEUED) ZTREQ="@"
 S LANM=$T(+0),TSK=$O(^LAB(62.4,"C",LANM,0)) Q:TSK<1
 Q:'$D(^LA(TSK,"I",0))
 K LATOP D ^LASET Q:'TSK  S X="TRAP^"_LANM,@^%ZOSF("TRAP")
LA2 K TV,TY S TOUT=0,RMK="",TY(0)="" D IN G QUIT:TOUT,LA2:$$CAPS(IN)'["REPORT" F A=1:1:2 S TOUT=0 D IN G QUIT:TOUT
 S V=$P(IN,"RUN",2) D NUM S TRAY=1,(ID,CUP)=+V,TOUT=0 D IN G QUIT:TOUT S V=$P(IN,":",2) D NUM S IDE=+V
 F A=1:1:33 S TOUT=0 D IN G QUIT:TOUT Q:$E(IN,1,2)="V-"  I IN[":" S TEST=$P(IN,":"),V=$P(IN,":",2) D
 . F I=0:0 S I=$O(TC(I)) Q:I<1  X:'$D(TY(I)) TC(I,2) I TEST=TC(I,4) S V=$P(V,"/"),V=$P(V," mg"),V=$P(V," g") D NUM X:$L($G(TC(I,2))) TC(I,2) S @TC(I,1)=V Q
 F I=0:0 S I=$O(TY(I)) Q:I<1  S RMK=RMK_TY(I)
LA3 X LAGEN G LA2:'ISQN ;Can be changed by the cross-link code
 F I=0:0 S I=$O(TV(I)) Q:I<1  S:TV(I,1)]"" ^LAH(LWL,1,ISQN,I)=TV(I,1)
 I $D(RMK),$L(RMK) D RMK^LASET
 G LA2
NUM S X="" F JJ=1:1:$L(V) S:$A(V,JJ)>32 X=X_$E(V,JJ)
 S V=X Q
IN S CNT=^LA(TSK,"I",0)+1 IF '$D(^(CNT)) S TOUT=TOUT+1 Q:TOUT>9  H 5 G IN
 S ^LA(TSK,"I",0)=CNT,IN=^(CNT),TOUT=0
 S:IN["~" CTRL=$P(IN,"~",2),IN=$P(IN,"~",1)
 Q
QUIT LOCK ^LA(TSK) H 1 K ^LA(TSK),^LA("LOCK",TSK),^TMP($J),^TMP("LA",$J)
 Q
TRAP D ^LABERR S T=TSK D SET^LAB Q:'$D(^LA(T,"I",0))
 G @("LA2^"_LANM) ;ERROR TRAP
 Q
CAPS(X) ;converts header string to caps before evaluating for existance
 ;of REPORT
 Q $TR(IN,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
