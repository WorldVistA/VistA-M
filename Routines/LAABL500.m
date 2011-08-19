LAABL500 ;SLC/RAF - RADIOMETER ABL500,505,520  ;5/27/93  07:00;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;CROSS LINK BY ID = ACCESSION #,IDE=INTERNAL SEQUENCE #
LA1 S:$D(ZTQUEUED) ZTREQ="@" S LANM=$T(+0),TSK=$O(^LAB(62.4,"C",LANM,0)),U="^" Q:TSK<1
 Q:'$D(^LA(TSK,"I",0))  D ^LASET Q:'TSK  S X="TRAP^"_LANM,@^%ZOSF("TRAP")
 S I=0 F  S I=$O(TC(I)) Q:I<1  D
 .S TEST(TC(I,4))=TC(I,1),FIX(TC(I,4))=TC(I,2)
LA2 K Y,TV,ID,IDE S (A,TOUT)=0 D IN G QUIT:TOUT,ID:$E(IN)="P",LA2
ID ;sets ID from the accession # in the 4th piece of the "P" string ("|")
 S V=$P(IN,"|",4) D NUM S ID=+V D IN G QUIT:TOUT
IDE ;sets IDE from the 2nd piece of the "O" string ("^")
 I $P(IN,"|")="O" S V=$P(IN,"^",2) D NUM S IDE=+V
RES ;sets TEST and values from the "R" string
 S TOUT=0 D IN G QUIT:TOUT,LA3:$E(IN)="L"
 S V=$P($P(IN,"^",4),"|") D NUM S TEST=V G RES:TEST=""!('$D(TEST(TEST)))
 S V=$P(IN,"|",4) D NUM,FIX S:V="....." V="" S @TEST(TEST)=V G RES
 Q
LA3 ;moving data to LAH global
 X LAGEN G LA2:ISQN<1
 F I=0:0 S I=$O(TV(I)) Q:I<1  I $D(TV(I,1)),TV(I,1)]"" S ^LAH(LWL,1,ISQN,I)=TV(I,1)
 G LA2
 Q
IN S CNT=^LA(TSK,"I",0)+1 I '$D(^(CNT)) S TOUT=TOUT+1 Q:TOUT>9  H 9 G IN
 S ^LA(TSK,"I",0)=CNT,IN=^(CNT),TOUT=0
 S:IN["~" CTRL=$P(IN,"~",2),IN=$P(IN,"~",1)
 Q
NUM S X="" F I=1:1:$L(V) S:$A(V,I)-32 X=X_$E(V,I)
 S V=X Q
QUIT LOCK ^LA(TSK) H 1 K ^LA(TSK),^LA("LOCK",TSK) D
 .K X,A,ID,IDE,BAD,CNT,I,JJ,LAGEN,IN,ISQN,LANM,LWL,T,TEST,TC,TV,TOUT,TSK,V,CTRL,FIX
 .S:$D(ZTQUEUED) ZTREQ="@"
 Q
TRAP D ^LABERR S T=TSK D SET^LAB G @("LA2^"_LANM) ;ERROR TRAP
FIX ;allows site to utilize param 1 for result manipulation
 I $D(FIX(TEST)) X FIX(TEST)
 Q
