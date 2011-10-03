LBRYTRN ;SSI/ALA-CREATE TRANSACTIONS ;[ 10/04/94  4:25 PM ]
 ;;2.5;Library;;Mar 11, 1996
TIT ; Move associated title information into transaction file
 S FX="0;1^0;5^0;6^3;5^3;8^3;1^3;3^3;4",TX="1;1^1;4^2;1^2;2^3;1^3;3^4;2^4;3"
 F I=1:1:8 S FR=$P(FX,U,I),TO=$P(TX,U,I) D
 . S ND1=$P(FR,";"),PC1=$P(FR,";",2),ND2=$P(TO,";"),PC2=$P(TO,";",2)
 . S $P(^LBRY(682.1,LBRYDA,ND2),U,PC2)=$P($G(^LBRY(680.5,LBRYCLS,ND1)),U,PC1)
 S PF="3;6-680.5^3;7-680.5^3;2-680.1^0;4-680.2^0;3-680.9",PT="2;3^3;2^4;1^4;4^4;5"
 F I=1:1:5 S FR=$P(PF,U,I),TO=$P(PT,U,I) D
 . S PO=$P(FR,"-"),GLB=$P(FR,"-",2)
 . S ND1=$P(PO,";"),PC1=$P(PO,";",2),ND2=$P(TO,";"),PC2=$P(TO,";",2)
 . N J S J=$P($G(^LBRY(680.5,LBRYCLS,ND1)),U,PC1) Q:'J
 . I J'?.N Q
 . S $P(^LBRY(682.1,LBRYDA,ND2),U,PC2)=$P(^LBRY(GLB,J,0),U)
 I $D(^LBRY(680.5,LBRYCLS,1))>0 S IN=0 F  S IN=$O(^LBRY(680.5,LBRYCLS,1,IN)) Q:IN'>0  D
 . S INP=$P(^LBRY(680.8,^LBRY(680.5,LBRYCLS,1,IN,0),0),U)
 . S ^LBRY(682.1,LBRYDA,6,IN,0)=INP
 I $D(^LBRY(680.5,LBRYCLS,2)) S IN=0 F  S IN=$O(^LBRY(680.5,LBRYCLS,2,IN)) Q:IN=""  S ^LBRY(682.1,LBRYDA,7,IN,0)=^LBRY(680.5,LBRYCLS,2,IN,0)
 S DA=LBRYDA D ^LBRYX44
 G EXIT
PRP ;  Move prediction pattern information into transaction file
 S $P(^LBRY(682.1,LBRYDA,1),U,3)=LBRYCLS
 S $P(^LBRY(682.1,LBRYDA,4),U,5)=$P(^LBRY(680.9,LBRYCLS,0),U,2)
 S $P(^LBRY(682.1,LBRYDA,4),U,6)=$P(^LBRY(680.9,LBRYCLS,0),U)
 S FRX="0;3^3;1^0;4^2;4^2;1^2;3^2;2^0;5",TOX="5;1^5;2^5;3^5;4^5;5^5;6^5;7^5;8"
 F I=1:1:8 S FR=$P(FRX,U,I),TO=$P(TOX,U,I) D
 . S ND1=$P(FR,";"),PC1=$P(FR,";",2),ND2=$P(TO,";"),PC2=$P(TO,";",2)
 . S $P(^LBRY(682.1,LBRYDA,ND2),U,PC2)=$P($G(^LBRY(680.9,LBRYCLS,ND1)),U,PC1)
 I $D(^LBRY(680.9,LBRYCLS,1)) S N=0 F  S N=$O(^LBRY(680.9,LBRYCLS,1,N)) Q:N=""  S ^LBRY(682.1,LBRYDA,8,N,0)=^LBRY(680.9,LBRYCLS,1,N,0)
 G EXIT
FRQ ;  Set frequency data into a transaction
 S $P(^LBRY(682.1,LBRYDA,1),U,3)=FRQ
 S $P(^LBRY(682.1,LBRYDA,4),U,4)=$P(^LBRY(680.2,FRQ,0),U)
 S $P(^LBRY(682.1,LBRYDA,2),U)=$P(^LBRY(680.2,FRQ,0),U,2)
 Q
PBL ;  Set publisher info into transaction
 S $P(^LBRY(682.1,LBRYDA,1),U,3)=PUB
 S $P(^LBRY(682.1,LBRYDA,4),U)=$P(^LBRY(680.1,PUB,0),U)
 Q
INX ;  Set indexing source into transaction
 S $P(^LBRY(682.1,LBRYDA,1),U,3)=INP
 S ^LBRY(682.1,LBRYDA,6,1,0)=^LBRY(680.8,INP,0)_U_INP
 Q
EXIT K FX,TX,FR,TO,ND1,PC1,ND2,PC2,PF,PT,PO,GLB,IN,INP,N
 Q
