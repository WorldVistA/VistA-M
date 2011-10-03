LABCX4B ;SLC/DLG - BECKMAN CX4 AND CX5 UNI AND BIDIRECTIONAL ;7/20/90  07:25 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;CROSS LINK BY ID OR IDE
LA1 S:$D(ZTQUEUED) ZTREQ="@"
 S LANM=$T(+0),TSK=$O(^LAB(62.4,"C",LANM,0)) Q:TSK<1
 Q:'$D(^LA(TSK,"I",0))
 K LATOP D ^LASET Q:'TSK  S X="TRAP^"_LANM,@^%ZOSF("TRAP")
 S I=0 F J=0:0 S I=$O(TC(I)) Q:I<1  S:$D(TC(I,4))#2 TEST(TC(I,4))=I
LA2 K TV,Y S (TRAY,CUP,ID,IDE,RMK)="",TOUT=0,A=1 D IN G QUIT:TOUT,LA2:$P(IN,",",2)'="402"
 I $P(IN,",",3)="01" D QC,IN,QC,HDR G LA3
 I $P(IN,",",3)="03" D QC,RES G LA3
 I $P(IN,",",3)="11" D QC,RES1 G LA3
 G LA2
LA3 G:ID="" LA2 X LAGEN G LA2:'ISQN ;Can be changed by the cross-link code
 F I=0:0 S I=$O(TV(I)) Q:I<1  S:TV(I,1)]"" ^LAH(LWL,1,ISQN,I)=TV(I,1)
 I $D(RMK),$L(RMK) D RMK^LASET
 G LA2
QC ;QC TESTING HERE; S BAD=1 IF DONT STORE
 S Y(A)=IN,A=A+1 Q
HDR S V=$P(Y(1),",",6) D NUM S IDE=+V,V=$P(Y(1),",",15) D NUM S ID=+V,V=$P(Y(1),",",8) D NUM S TRAY=V,V=$P(Y(1),",",9) D NUM S CUP=V
 S RMK=$P(Y(1),",",16)_$P(Y(1),",",17)_$P(Y(1),",",27) S:$L(RMK)<110 RMK=RMK_$P(Y(2),",",1) F I=$L(RMK):-1:1 Q:$E(RMK,I)'=" "  S RMK=$E(RMK,1,I-1)
 Q
RES S V=$P(Y(1),",",6) D NUM S IDE=+V,V=$P(Y(1),",",8) D NUM S TRAY=+V,V=$P(Y(1),",",9) D NUM S CUP=+V,V=$P(Y(1),",",10)
 D NUM S TEST=V,V=$P(Y(1),",",15) D NUM S:V="" V=$P(Y(1),",",23) D NUM S:"*#"[V V="" I V]"",($D(TEST(TEST))#2) S @TC(TEST(TEST),1)=+V
F S J=$O(^LAH(LWL,1,"B",TRAY_";"_CUP,0)) I J>0 S ID=$P(^LAH(LWL,1,J,0),"^",5)
 Q
RES1 S V=$P(Y(1),",",6) D NUM S IDE=+V,V=$P(Y(1),",",7) D NUM S TRAY=+V,V=$P(Y(1),",",8) D NUM S CUP=+V,V=$P(Y(1),",",10)
 D NUM S TEST=V,V=$P(Y(1),",",12) D NUM S:"*"[V V="" I V]"",($D(TEST(TEST))#2),($P(Y(1),",",11)="OK") S @TC(TEST(TEST),1)=+V
 G F
NUM S X="" F JJ=1:1:$L(V) S:$A(V,JJ)>32 X=X_$E(V,JJ)
 S V=X Q
IN S CNT=^LA(TSK,"I",0)+1 IF '$D(^(CNT)) S TOUT=TOUT+1 Q:TOUT>9  H 5 G IN
 S ^LA(TSK,"I",0)=CNT,IN=^(CNT),TOUT=0
 S:IN["~" CTRL=$P(IN,"~",2),IN=$P(IN,"~",1)
 Q
OUT S CNT=^LA(TSK,"O")+1,^("O")=CNT,^("O",CNT)=OUT
 LOCK ^LA("Q") S Q=^LA("Q")+1,^("Q")=Q,^("Q",Q)=TSK LOCK
 Q
QUIT LOCK ^LA(TSK) H 1 K ^LA(TSK),^LA("LOCK",TSK)
 Q
TRAP D ^LABERR S T=TSK D SET^LAB G @("LA2^"_LANM) ;ERROR TRAP
