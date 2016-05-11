SDBT6 ; ;05/04/16
 ;;
1 N X,X1,X2 S DIXR=1353 D X1(U) K X2 M X2=X D X1("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . K ^SC("AG",X(1),X(2),DA)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . S ^SC("AG",X(1),X(2),DA)=""
 Q
X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",44,DIIENS,2,DION),$P($G(^SC(DA,0)),U,3))
 S X(2)=$G(@DIEZTMP@("V",44,DIIENS,.01,DION),$P($G(^SC(DA,0)),U,1))
 S X=$G(X(1))
 Q
