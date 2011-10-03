FHORD83 ; HISC/REL/NCA/JH - Diet Order Lists (cont.) ;7/31/96  11:37
 ;;5.5;DIETETICS;;Jan 28, 2005
DISP ; Display Patient Food Preference
 I ($Y>(IOSL-6)) D HDR^FHORD81,FLNE^FHORD82
 W !!?26,"Likes",?58,"DisLikes",!!
 K P S P1=1 F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S X=^(K,0) D FP
 S (M,MM)="" F  S M=$O(P(M)) Q:M=""  D  S MM=M
 .I $D(P(M)) D
 ..I ($Y>(IOSL-6)) D HDR^FHORD81,FLNE^FHORD82 W !!?26,"Likes",?58,"Dislikes",!!
 ..W ?13,$P(M,"~",2) S (P1,P2)=0 F  S:P1'="" P1=$O(P(M,"L",P1)) S X1=$S(P1'="":P(M,"L",P1),1:"") S:P2'="" P2=$O(P(M,"D",P2)) S X2=$S(P2'="":P(M,"D",P2),1:"") Q:P1=""&(P2="")  D P0 W:MM'=M !
 ..Q
 .Q
 I $O(P(""))="" W !?13,"No Food Preferences on file",!
 Q
P0 I X1'="" W ?25 S X=X1 D P1 S X1=X
 I X2'="" W ?52 S X=X2 D P1 S X2=X
 Q:X1=""&(X2="")  W ! G P0
P1 I $L(X)<27 W X S X="" Q
 F KK=28:-1:1 Q:$E(X,KK-1,KK)=", "
 I KK=1 S KK=26 W $E(X,1,KK) S X=$E(X,KK+1,999) Q
 I $Y>(IOSL-6) D HDR^FHORD81
 W $E(X,1,KK-2) S X=$E(X,KK+1,999) Q
FP Q:'$P(X,U)  S M1=$P(X,"^",2) Q:M1=""  S:M1="A" M1="BNE" S Z=$G(^FH(115.2,+X,0)) Q:$P(Z,U)=""!($P(Z,U,2)="")  S L1=$P(Z,"^",1),KK=$P(Z,"^",2),M="",DAS=$P(X,"^",4)
 I KK="L" S Q=$P(X,"^",3),L1=$S(Q:Q,1:1)_" "_L1
 I M1="BNE" S M="1~All Meals" G FP1
 S Z1=$E(M1,1) I Z1'="" S M=$S(Z1="B":"2~Break",Z1="N":"3~Noon",1:"4~Even")
 S Z1=$E(M1,2) I Z1'="" S M=M_","_$S(Z1="B":"Break",Z1="N":"Noon",1:"Even")
FP1 S:'$D(P(M,KK,P1)) P(M,KK,P1)="" I $L(P(M,KK,P1))+$L(L1)<255 S P(M,KK,P1)=P(M,KK,P1)_$S(P(M,KK,P1)="":"",1:", ")_L1_$S(DAS="Y":" (D)",1:"")
 E  S:'$D(P(M,KK,K)) P(M,KK,K)="" S P(M,KK,K)=L1_$S(DAS="Y":" (D)",1:"") S P1=K
 Q
