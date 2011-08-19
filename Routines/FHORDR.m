FHORDR ; HISC/REL - Production Diet Recode ;3/28/95  12:09
 ;;5.5;DIETETICS;;Jan 28, 2005
 S FLG=0
CODE ; Recode diet
 Q:"^^^^"[FHOR  I FHOR="1^^^^" S Z=1 G C1
 Q:PDFLG
 S MP=$O(^FH(111.1,"AB",FHOR,0))
 S Z=$P($G(^FH(111.1,+MP,0)),"^",7) G:Z C1
 S M="^" F K1=1:1:5 S Z=$P(FHOR,"^",K1) Q:Z<1  S M=M_+$P(^FH(111,Z,0),"^",5)_"^"
 F LC=0:0 S LC=$O(^FH(116.2,"AR",LC)) Q:LC<1  S X=^(LC) F K1=1:1 S X1=$P(X,"^",K1) Q:X1<1  D REC G:Z C1
 S Z=0 D:FLG MIS
C1 S:Z $P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",13)=Z Q
MIS ; No recoding of diet order
 D PATNAME^FHOMUTL I DFN="" Q
 W !,$P($G(^DPT(DFN,0)),"^",1),", Admission ",ADM,", Diet Order ",FHORD," not recoded" Q
 Q
REC S Z=$P(X1,":",1),X1=$P(X1,":",2) F K2=1:1 S C=$P(X1," ",K2) Q:C<1  G:M'[("^"_C_"^") R1
 Q
R1 S Z=0 Q
SET ; Rebuild 'AR' recode cross-reference
 K M,^FH(116.2,"AR") F K1=0:0 S K1=$O(^FH(116.2,K1)) Q:K1<1  D S1
 S LC=1,X="" F M=0:0 S M=$O(M(M)) Q:M<1  S Z=M(M) D S2
 S:X'="" ^FH(116.2,"AR",LC)=$E(X,2,999) K FHORD,K1,K2,LC,M,X,Z Q
S1 S X="",M=+$P(^FH(116.2,K1,0),"^",5) Q:'M  Q:$D(^FH(116.2,K1,"I"))
 F K2=0:0 S K2=$O(^FH(116.2,K1,"R",K2)) Q:K2<1  S Z=^(K2,0) S:Z X=X_" "_Z
 S:X="" X=" "_K1 S M(M)=K1_":"_$E(X,2,999) Q
S2 I $L(X)+$L(Z)>245 S ^FH(116.2,"AR",LC)=$E(X,2,999),X="",LC=LC+1
 S X=X_"^"_Z Q
INP ; Recode all inpatients
 D SET S FLG=1,PDFLG=0
 F W1=0:0 S W1=$O(^FHPT("AW",W1)) Q:W1'>0  F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",W1,FHDFN)) Q:FHDFN<1  S ADM=$G(^FHPT("AW",W1,FHDFN)) D:ADM Z1
 K ADM,C,D,FHDFN,DFN,FHOR,FHORD,FLG,I,K1,K2,LC,M,W1,X,X1,Z Q
Z1 F FHORD=0:0 S FHORD=$O(^FHPT(FHDFN,"A",ADM,"DI",FHORD)) Q:FHORD<1  D Z2
 Q
Z2 S Z=$G(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)),FHOR=$P(Z,"^",2,6) Q:"^^^^"[FHOR  D CODE Q
