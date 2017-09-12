DVBA2789 ;DLS/DEK - PATCH DRIVER ; 2/24/05
 ;;2.7;AMIE;**89**;Apr 10, 1995
 ;
 ; DBIA#  External Reference(s)
 ;  2051  $$FIND1^DIC
 ;  2053  FILE^DIE
 ; 10103  $$FMADD^XLFDT
 ; 10141  BMES^XPDUTL, MES^XPDUTL
S S N=89,(C,I,J)=0,K=396.18,T="~",E="DIERR",M="DVBA",B=$$FMADD^XLFDT(DT,-9) Q
B D S,0 G K ;Pre
A D S,1 ;Post
K D:J L(">>>>>   Review these errors   <<<<<")
 K A,B,C,H,I,J,K,L,N,P,R,S,T,V,^TMP(M,$J),^TMP(E,$J),M,E
 Q
3 S A(K,IEN,2)="@",A(K,IEN,7)=0,A(K,IEN,F)=B Q
2 S A(K,IEN,3)="@",A(K,IEN,7)=1,A(K,IEN,F)=DT Q
C(F,IEN) Q:F=3&$P($G(^DVB(K,IEN,2)),U,2)  S IEN=IEN_"," D @F,FILE^DIE(,"A")
 I $D(^TMP(E,$J)) S J=J+1 M ^TMP(M,$J,J)=^TMP(E,$J)
 Q
L(X) I $D(XPDNM) K C M C=^TMP(M,$J) D BMES^XPDUTL(X),MES^XPDUTL(.C) Q
 S I="""",J=","_$J,R=M_I_J,T="^TMP("_I_E_I_J_","
 W !!,X S C=$Q(^TMP(M,$J)) F  Q:C'[R  W !?3,T,$P(C,",",3,99)," = ",@C S C=$Q(@C)
 Q
Z(DA,F) S DA=$$FIND1^DIC(K,,"O",DA) D:DA&F C(F,DA) Q
0 F  S I=$O(^DVB(K,I)) Q:'I  S C=$P(^(I,0),T,2) D:C["T" C(3,I)
 Q
1 F I=1:1 S L=$P($T(N+I),";;",2) Q:L=""  D Z($P(L,U),$P(L,U,2))
 F  S L=$O(^DVB(K,+L)) Q:'L  S V=^(L,0),C=C+1 D:$P(V,T,2)=N V
 S $P(^DVB(K,0),U,3,4)=+$O(^DVB(K," "),-1)_U_C
 Q
V S V=$P($E(V,1,30),T),S=$E(V,1,$L(V)-1)_$C($A($E(V,$L(V)))-1)
 F  S S=$O(^DVB(K,"B",S)) Q:S=""!(S'[V)  D
 .F H=0:0 S H=$O(^DVB(K,"B",S,H)) Q:'H  D C(H'=L+2,H)
N Q  ;Named de/activations
 ;;AUDIO~85^3
 ;;COLD INJURY PROTOCOL~85^3
 ;;AUDIO~88^3
 ;;JOINTS~85^2
 ;;SPINE~85^2
 ;;
