PSN4PRE ;BIR/DMA-pre transport routine to get conversion values ;21 Sep 98 / 7:50 AM
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
 ;
 N ROOT,DA,I,K,X,LINE
 S ROOT=$NA(@XPDGREF@("LINE")),DA=0,I=1,LINE="",TOT=0
 F  S DA=$O(^ZCONV(DA)),K=0 Q:'DA  F  S K=$O(^ZCONV(DA,K)) Q:'K  S X=^(K),LINE=LINE_DA_"^"_K_"^"_X_"|" I $L(LINE)>200 S @ROOT@(I)=LINE,I=I+1,LINE=""
 I $L(LINE) S @ROOT@(I)=LINE,I=I+1
 ;
 ;
 S ROOT=$NA(@XPDGREF@("INTER")),DA=0
 F  S DA=$O(^PS(56,DA)) Q:'DA  S X=^(DA,0),@ROOT@(DA)=X
 Q
