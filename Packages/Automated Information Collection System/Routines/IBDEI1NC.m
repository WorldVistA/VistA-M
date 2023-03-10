IBDEI1NC ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 ;
 ;
 I N="DIST(.403," D
 .N DIFRVAL S DIFRVAL=$$VAL^DIFROMSS(.403,DA)
 .I DIFRVAL W !,"Compiling form: ",$P(^DIST(.403,DA,0),U) D EN^DDSZ(DA) Q
 .W !,"ERROR: Form: ",$P(^DIST(.403,DA,0),U)," cannot be compiled"
 .Q
 Q
BLK F J=0:0 S J=$O(^UTILITY(U,$J,N,R,40,J)) Q:'J  I $D(^(J,0)) S %=$P(^(0),U,2) S:%]"" %=$O(^DIST(.404,"B",%,0)) S:% $P(^UTILITY(U,$J,N,R,40,J,0),U,2)=% D B1
 K A0,A1,A2,J,L Q
B1 F L=0:0 S L=$O(^UTILITY(U,$J,N,R,40,J,40,L)) Q:'L  S A0=$G(^(L,0)),%=$P(A0,U) I %]"" S %=$O(^DIST(.404,"B",%,0)) I % S $P(A0,U)=%,^UTILITY(U,$J,N,R,40,J,"BLK",%,0)=A0 D
 .N X S X=0
 .F  S X=$O(^UTILITY(U,$J,N,R,40,J,40,L,X)) Q:X=""  S ^UTILITY(U,$J,N,R,40,J,"BLK",%,X)=^(X)
 .Q
 S A0=$G(^UTILITY(U,$J,N,R,40,J,40,0)) Q:A0=""  K ^UTILITY(U,$J,N,R,40,J,40) S (A1,A2)=0
 F L=0:0 S L=$O(^UTILITY(U,$J,N,R,40,J,"BLK",L)) Q:'L  S ^UTILITY(U,$J,N,R,40,J,40,L,0)=^(L,0),A1=L,A2=A2+1 D
 .N X S X=0
 .F  S X=$O(^UTILITY(U,$J,N,R,40,J,"BLK",L,X)) Q:X=""  S ^UTILITY(U,$J,N,R,40,J,40,L,X)=^(X)
 .Q
 S $P(A0,U,3,4)=A1_U_A2,^UTILITY(U,$J,N,R,40,J,40,0)=A0 K ^UTILITY(U,$J,N,R,40,J,"BLK")
 Q
KAD(D0) N D1,X
 S X=0 F  S X=$O(^DIC(19,D0,10,"B",X)) Q:X'>0  S D1=0 F  S D1=$O(^DIC(19,D0,10,"B",X,D1)) Q:D1'>0  K ^DIC(19,"AD",X,D0,D1)
 Q
