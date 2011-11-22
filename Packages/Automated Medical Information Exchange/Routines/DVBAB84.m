DVBAB84 ;ALB/DK - CAPRI REMOTE NEW PERSON FILE ;09/28/09
 ;;2.7;AMIE;**90,137,140,143**;Apr 10, 1995;Build 4
 ;
START(MSG) ;RPC DVBAB NEW PERSON FILE
 K ^TMP("DVBAB200",$J)
 N DATA,VAR,VAR1,DVBDIV,DVBDIVN,DVBRPT,CNT
 S DATA="",CNT=0,MSG=$NA(^TMP("DVBAB200",$J))
 F  S DATA=$O(^VA(200,"B",DATA)) Q:DATA=""  D
 . S VAR=""
 . F  S VAR=$O(^VA(200,"B",DATA,VAR)) Q:VAR=""  D
 . . D GETS^DIQ(200,VAR_",",".01","E","DVBRPT")
 . . I $P($G(^VA(200,VAR,2,0)),"^",3)'="" D  Q
 . . . S VAR1=""
 . . . F  S VAR1=$O(^VA(200,VAR,2,"B",VAR1)) Q:VAR1=""  D
 . . . . S DVBDIV=$$GET1^DIQ(200.02,VAR1_","_VAR_",",.01,"I")
 . . . . S DVBDIVN=$$GET1^DIQ(200.02,VAR1_","_VAR_",",.01,"E")
 . . . . S ^TMP("DVBAB200",$J,CNT)=VAR_"^"_DVBRPT(200,VAR_",",.01,"E")_"^"_DVBDIV_"^"_DVBDIVN_$C(13)
 . . . . S CNT=CNT+1
 . . S ^TMP("DVBAB200",$J,CNT)=VAR_"^"_DVBRPT(200,VAR_",",.01,"E")_"^"_"^"_$C(13)
 . . S CNT=CNT+1
 Q
DUZ2(Y,NUM) ;RPC DVBAB SET DUZ2
 N X,Z S NUM=$G(NUM),Y=1,X="0^STATION NUMBER "
 I NUM="" S Y=X_"IS REQUIRED"
 I '$D(^DIC(4,"D",NUM))&Y S Y=X_"DOES NOT EXIST"
 Q:'Y  S Y=$O(^DIC(4,"D",NUM,"")),Z=""
 S:Y]"" Z=$G(^DIC(4,Y,0))
 I Y=""!(Z="") S Y=X_"HAS A BAD X-REF" Q
 S DUZ(2)=Y,Y=Y_U_$P(Z,U)
 Q
DUP(Y,NAM,DOB,SSN) ;RPC DVBAB FIND DUPS
 N E,C,N,D,S,A,B,M S B=" - Must be ",M=B_"at least 1 argument"
 S NAM=$$N0($G(NAM)),DOB=$P($G(DOB),"."),SSN=$$U($G(SSN))
 S (C,N,D,S)=0,E="-1^Invalid Argument: ",Y=$NA(^TMP("DVBDUP",$J,DUZ)) K @Y
 I '$L(NAM_DOB_SSN) S C=E_"None Passed"_M
 S:'C&DOB&'$L(NAM_SSN) C=E_$P(M," ",3,8)_" passed with DOB"
 S:'C N=$$VN(NAM) I N S C=E_"NAM"_B_"LAST,FIRST or IEN"
 S:'C D=$$VD(DOB) I D S C=E_"DOB"_B_"FileMan format"
 S:'C S=$$VS(SSN) I S>0 S C=E_"SSN"_B_"9 digits, 1U4N format, or P (for pseudo-SSN)"
 I C S @Y@(0)=C Q
 S:S<0 SSN=$$S(NAM,DOB)
 D DN(.N,NAM),DD(.D,DOB,NAM,SSN),DS(.S,SSN,NAM,DOB),WT(Y,.A,.N,.D,.S)
 Q
DN(A,N) I N=""!A S A=0 Q  ;Dup Name checks
 N K,M S A=0,M=$$N2(N),K=$$N1(M)_"zzzzzzzzzz"
 F  S K=$O(^DPT("B",K)) Q:$$N2(K)'=M  D:$$M("N",K,N,,,5) D0(.A,"B",K)
 Q
DD(A,D,N,S) I A!'D S A=0 Q  ;Dup DOB checks
 N K,M,F S A=0,M=$E(D,1,5),K=M-1_99
 F  S K=$O(^DPT("ADOB",K)) Q:$E(K,1,5)'=M  D
 .S F=0 I N]"",$$M("DN",K,N,D,,7) S F=1
 .I 'F,S]"",$$M("DS",K,,D,S,7) S F=1
 .D:F D0(.A,"ADOB",K)
 Q
DS(A,S,N,D) N F,K,M,X,R,P I A!'S S A=0 Q  ;Dup SSN checks
 S A=0,P=$L(S),R=P-4,M=$E(S,1,R),K=M-1_9999,X=$S(P=5:"BS5",1:"SSN")
 F  S K=$O(^DPT(X,K)) Q:$E(K,1,R)'=M  D
 .S F=$$M("S",K,,,S,P) I F D D0(.A,X,K) Q
 .Q:N=""&'D  Q:'$$FF(S,K)
 .I D,$$MD(K,D,1) D D0(.A,X,K,3,D) Q
 .I N]"",$$MN(K,N,1) D D0(.A,X,K,1,N)
 Q
D0(A,X,Y,P,V) N I,C,Z S I="",C="N D     S",P=$G(P),V=$G(V)
 F  S I=$O(^DPT(X,Y,I)) Q:'I  D
 .S Z=$G(^DPT(I,0)) Q:Z=""
 .I P,'$$M($E(C,P),$P(Z,U,P),V,V,V,5) Q
 .S A=A+1,A(I)=Z
 Q
VN(X) Q:X="" 0  Q X'?2.U1","1.U  ;Validate Name
VD(X) Q:X="" 0  Q:X'?7N 1  N M,D S M=$E(X,4,5),D=$E(X,6,7)  ;Validate DOB
 Q:M<1!(M>12)!(D<0) 1  Q (D>$$D(M,$E(X,1,3)))
VS(X) Q:X="" 0  Q:$E(X,$L(X))="P" -1  N L S L=$L(X)  ;Validate SSN
 Q:L=5&(X'?1A4N)!(L=9&(X'?9N))!(L<5)!(L>9) 1
 Q:$E(X,1,5)="00000" 0  ;Test Patient
 Q $E(X,1)=9!($E(X,1,3)="000")  ;Can't begin with 9 or 000
MN(X,N,F) S F=$G(F)_U_($$N2(X,2)=$$N2(N,2)) Q:'F $P(F,U,2)  Q $$N2(X)=$$N2(N)  ;Match Name
MD(X,D,F) S F=$G(F)_U_($E(X,4,5)=$E(D,4,5)) Q:'F $P(F,U,2)  Q $E(X,1,3)=$E(D,1,3)  ;Match DOB
MS(X,S) N I,K S K=0,X=$$L4(X),S=$$L4(S)  ;Match SSN
 F I=1:1:4 S K=$E(X,I)=$E(S,I)+K
 Q:K>1 1  ;2 nums, same spot
 Q $$S4(X)=$$S4(S)  ;ALL 4 nums, any spot
M(Y,X,N,D,S,L) N A,B,C,Z S (A,B,C)=0,Z=$L(X),L=+$G(L) Q:Z<L 0
 S:Y["N" A=$$MN(X,N) S:Y["D" B=$$MD(X,D) S:Y["S" C=$$MS(X,S)
 Q:Y="N" A  Q:Y="D" B  Q:Y="S" C  Q:Y'["N" B&C
 Q:Y'["D" A&C  Q:Y'["S" A&B  Q A&B&C
WT(Y,A,N,D,S) N C S C=$$W0(.A,.N,.D,.S),@Y@(0)=C Q:'C  ;Weights
 N I,J,K,L S (C,I,J,K,L)=""
 F  S I=$O(A(I)) Q:'I  F  S J=$O(A(I,J)) Q:'J  D
 .S K=K+1,K(-J,$P(A(I,J),U),K)=I_U_A(I,J)
 F  S I=$O(K(I)) Q:'I  F  S J=$O(K(I,J)) Q:J=""  D
 .F  S L=$O(K(I,J,L)) Q:'L  D
 ..;If SSN or DOB should not be displayed in the Patient File Matches 
 ..;list in CAPRI replace DOB and SSN with *SENSITIVE* in DOB and SSN 
 ..;fields in RPC results.
 ..N DVBADOB,DVBASSN,DVBADFN
 ..;1st piece in K array is DFN followed by 0th node of DPT record.
 ..;DOB found in 3rd piece of 0th node and 4th piece K array
 ..S DVBADFN=+$P($G(K(I,J,L)),"^")
 ..S DVBADOB=$$DOB^DPTLK1(DVBADFN,2)
 ..I DVBADOB="*SENSITIVE*" S $P(K(I,J,L),"^",4)=DVBADOB
 ..;1st piece in K array is DFN followed by 0th node of DPT( record.  
 ..;SSN found in 9th piece of the 0th node and 10 piece in K array.
 ..S DVBASSN=$$SSN^DPTLK1(DVBADFN)
 ..I DVBASSN="*SENSITIVE*" S $P(K(I,J,L),"^",10)=DVBASSN
 ..S C=C+1
 ..S @Y@(C)=K(I,J,L)
 Q
W0(A,N,D,S) Q:N&D&S $$W3(.A,.N,.D,.S)  Q:N&S&'D $$W2(.A,.N,.S)
 Q:D&S&'N $$W2(.A,.D,.S)  Q:N&D&'S $$W2(.A,.N,.D)
 Q:S&'N&'D $$W1(.A,.S)  Q:N&'D&'S $$W1(.A,.N)  ;Q:D&'N&'S $$W1(.A,.D)
 Q 0
W1(A,X) N I,C S (I,C)=0 ;Weighting 1
 F  S I=$O(X(I)) Q:'I  S C=C+1,A(I,1)=X(I)
 Q C
W2(A,X,Y) N I,C S (I,C)=0 ;Weighting 2
 F  S I=$O(X(I)) Q:'I  S C=C+1 D
 .I $D(Y(I)) S A(I,2)=Y(I)
 .E  S A(I,1)=X(I)
 F  S I=$O(Y(I)) Q:'I  S:'$D(X(I)) C=C+1,A(I,1)=Y(I)
 Q C
W3(A,X,Y,Z) N I,C S (I,C)=0 ;Weighting 3
 F  S I=$O(X(I)) Q:'I  S C=C+1 D
 .I $D(Y(I)) D  Q
 ..I $D(Z(I)) S A(I,3)=Z(I)
 ..E  S A(I,2)=Y(I)
 .I $D(Z(I)) S A(I,2)=Z(I)
 .E  S A(I,1)=X(I)
 Q C+$$W2(.A,.Y,.Z)
N0(X) Q:X="" ""  I X?.1"`"1.N S:X["`" X=$P(X,"`",2) S X=$P($G(^DPT(X,0)),U)
 Q $$U($$P(X,", "))
N1(X) Q $E(X,1,$L(X)-1)_$C($A($E(X,$L(X)))-1)
N2(X,Y) Q $E($$P($P(X,",",$G(Y,1)),2),1,2)
U(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
L4(X) N L S L=$L(X) S:$E(X,L)="P" L=L-1,X=$E(X,1,L) Q $E(X,L-3,L)
D(M,Y) Q:M=2 28+$$L(Y+1700)  Q 31-((M<7&'(M#2))!(M>7&(M#2)))
L(Y) Q Y#100!('(Y#400)&'(Y#4))
C(X) S X=$A($E(X,1))-65\3+1 Q:X<0 0  Q X
P(X,C,L) N I,Y,Z S Z="",Y=X,C=$G(C,U),L=$G(L,$L(Y))
 F I=1:1:$L(Y) Q:$L(Z)=L  S X=$E(Y,I) S:X?1U!(C[X) Z=Z_X
 Q Z
S(N,D) N L1,L2,L3 S:$G(D)="" D=2000000 ;PSEU^DGRPDD1
 S L3=$$C(N),L1=$$C($P(N," ",2)),L2=$$C($P(N,",",2))
 Q L2_L1_L3_$E(D,4,7)_$E(D,2,3)_"P"
A(X) Q $S(X<0:X*-1,1:X)
FF(X,Y) N I,K S X=$$L4(X),Y=$$L4(Y),K=0
 F I=1:1:4 S:$$A($E(X,I)-$E(Y,I))<2 K=K+1
 Q K>2
S4(X) N I,J,K,L,M S L=$L(X)
 F I=2:1:L S J=I,K=$E(X,I) D
 .F  Q:J=1  S M=$E(X,J-1)  Q:M'>K  S $E(X,J)=M,J=J-1
 .S $E(X,J)=K
 Q X
