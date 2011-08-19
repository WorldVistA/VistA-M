ONCOSCT3 ;WASH ISC/SRR,MLH-ASCII OUTPUT ;8/21/93  11:17
 ;;2.11;ONCOLOGY;**1**;Mar 07, 1995
 ;
OUTPUT ;IN ^TMP($J,"CLAB",'Column Alpha Order')=COLUMN LABEL
 ;   ^TMP($J,"RLAB", Row Number)= ROW LABEL
 ;       ,"COL", Column number) = Column Alpha
 ;     "CSUM", 'Column Alpha') = column sum
 ;        "RSUM:, 'Row Number) = Row sum
 ;^TMP($J,"CELL",Row Number,Column Alpha code)= Total for cell ^(x,y)
 ;
AS K X S J=2,Q="""",C=",",B=Q_Q,X(1)=B,X(2)=Q_$P(ROWDD,U)_Q
 S X=-1 F  S X=$O(^TMP($J,"CLAB",X)) Q:X=""  S VA=^(X) D DATA
 S R=0 F  S R=$O(^TMP($J,"RLAB",R)) Q:R=""  S J=J+1,X(J)=Q_^(R)_Q D
 .S TC=0,CO=0 F  S CO=$O(^TMP($J,"COL",CO)) Q:CO=""  S V=^(CO),TC=TC+1,T=$G(^TMP($J,"CELL",R,V)),T=$S(T="":0,1:T),X(J)=X(J)_C_T
 Q:J=2  S J=J+1,X(J)=B F K=1:1:TC S X(J)=X(J)_C_B
B S XMSUB=$P(COLDD,U,1)_" VS "_$P(ROWDD,U,1) ;B  
M S XMDUZ=DUZ D XMZ^XMA2
 S L=0
A S L=L+1 I $D(X(L)) S X=X(L) I $L(X),$L(X)'>255 S ^XMB(3.9,XMZ,2,L,0)=X G A
 ;String length too long
 ;
 ;NO DATA RETURNED SET ZERO NODE
 S DA=XMZ,DIE=3.9,DR="1.7///P;1.95///Y" D ^DIE
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_L_"^"_L_"^"_DT
 ;S XMDUN="SENDER"
 S XMY(DUZ)="",XMY($P(^VA(200,DUZ,0),U))=""
 D ENT1^XMD ; CALL for delivery
 ;D ^XMD ;    formerly NNEW^XMA
 Q
 ;
DATA ;CREATE STRING
D ;CHECK LENGTH
 Q:X(1)["END"  S NVA=C_Q_VA_Q,SL=$L(NVA)+$L(X(1)) I SL>245 S X(1)=X(1)_C_Q_"END" Q
 S X(1)=X(1)_NVA,X(2)=X(2)_C_B
 Q
EX ;Exit and kill
 K XMX,XMSUB,XMY,L,XMZ,V,CO,TC,T,VA,B,Q,J,X
