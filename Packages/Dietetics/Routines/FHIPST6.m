FHIPST6 ; HISC/REL - Set up Recipe Analysis values ;5/4/93  14:19
 ;;5.5;DIETETICS;;Jan 28, 2005
 F REC=0:0 S REC=$O(^FH(114,REC)) Q:REC<1  F KK=0:0 S KK=$O(^FH(114,REC,"I",KK)) Q:KK<1  S Y0=$G(^(KK,0)) D I1
 Q
I1 ; Set up Ingredient values
 Q:$P(Y0,"^",3)  S I1=+Y0 Q:'I1  S AMT=$P(Y0,"^",2) Q:'AMT
 S Y0=$G(^FHING(I1,0)),N1=$P(Y0,"^",21),A1=$P(Y0,"^",22) Q:'N1
 S EP=$P($G(^FHNU(N1,0)),"^",5)
 I A1 S A1=A1*AMT I EP,EP'=100 S A1=A1*EP/100
 S $P(^FH(114,REC,"I",KK,0),"^",3,4)=N1_"^"_A1 Q
