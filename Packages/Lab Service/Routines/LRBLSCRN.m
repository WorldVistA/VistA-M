LRBLSCRN ;DAL/MEA - BB DD FIELD SCREEN; ; 11/21/00 3:34pm
 ;;5.2;LAB SERVICE;**267**;Sep 27, 1994
 ;
PEDI() N X,Y,ANS,CODEX,CODEY
 S ANS=0
 S X=^(0)  ; From ^LAB(66,x,0)
 S Y=^LAB(66,DA,0)
 I $P(X,U,29) D
 .S CODEX=$P(X,U,5)
 .S CODEY=$P(Y,U,5)
 .I $E(CODEX,1,6)'=$E(CODEY,1,6) Q  ; Both have same base product code
 .I $E(CODEX,7)'="A" Q  ; Seventh character is an 'A' (split)
 .I $P(X,U,12)'=$P(Y,U,12) Q  ; Both have same anti coag
 .I $P(X,U,29)'=$P(Y,U,29) Q  ; Both are of the same symbology
 .S ANS=1  ; If ISBT, same coag, and same symbology
 I '$P(X,U,29),$P(X,U)["PEDIATRIC",$P(X,U,12)=$P(Y,U,12),$P(X,U,29)=$P(Y,U,29) S ANS=1
 Q ANS
