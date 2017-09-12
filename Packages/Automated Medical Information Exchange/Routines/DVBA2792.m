DVBA2792 ;DLS/DEK - PATCH DRIVER ; 5/2/05
 ;;2.7;AMIE;**92**;Apr 10, 1995
 ;
 ; DBIA#  External Reference(s)
 ;  2053  FILE^DIE
 ; 10013  ENALL^DIK
 ; 10103  $$FMADD^XLFDT
 ; 10141  BMES^XPDUTL, MES^XPDUTL
 N DIK S N="92T1",(C,J,L,V)=0,K=396.18,B=$$FMADD^XLFDT(DT,-9),DIK="^DVB("_K_",",DIK(1)=".01^2"
 F  S L=$O(^DVB(K,L)) Q:'L  S T=^(L,0),V=$P(T,"~",2),M=L,C=C+1 D
 .I V=N D C(T'["MENT"+2,L) Q
 .I V["T",'$P($G(^DVB(K,L,2)),U,2) D C(3,L)
 S $P(^DVB(K,0),U,3,4)=M_U_C
 D:J L(">>>>>   Review these errors   <<<<<")
 K A,B,C,J,K,L,M,N,T,V,^TMP("DIERR",$J),^TMP("DVBA",$J),@(DIK_"""AV"")")
 D ENALL^DIK
 Q
3 S A(K,IEN,7)=0,A(K,IEN,F)=B,A(K,IEN,2)="@" Q
2 S A(K,IEN,7)=1,A(K,IEN,F)=DT,A(K,IEN,3)="@" Q
C(F,IEN) S IEN=IEN_"," D @F,FILE^DIE(,"A")
 I $D(^TMP("DIERR",$J)) S J=J+1 M ^TMP("DVBA",$J,J)=^TMP("DIERR",$J)
 Q
L(X) I $D(XPDNM) K C M C=^TMP("DVBA",$J) D BMES^XPDUTL(X),MES^XPDUTL(.C) Q
 S L="""",A=L_","_$J,J="DVBA"_A,V="^TMP("_L_"DIERR"_A_","
 W !!,X S C=$Q(^TMP("DVBA",$J)) F  Q:C'[J  W !?3,V,$P(C,",",3,99)," = ",@C S C=$Q(@C)
 Q
