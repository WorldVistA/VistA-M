RACTQE4 ; ;05/01/18
 ;;
1 N X,X1,X2 S DIXR=1425 D X1(U) K X2 M X2=X D X1("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"" D
 . K ^RAO(75.1,"AP",$E(X(1),1,30),$E(X(2),1,30),$E(X(3),1,14),DA)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"" D
 . S ^RAO(75.1,"AP",$E(X(1),1,30),$E(X(2),1,30),$E(X(3),1,14),DA)=""
 Q
X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",75.1,DIIENS,.01,DION),$P($G(^RAO(75.1,DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",75.1,DIIENS,2,DION),$P($G(^RAO(75.1,DA,0)),U,2))
 S X=$G(@DIEZTMP@("V",75.1,DIIENS,21,DION),$P($G(^RAO(75.1,DA,0)),U,21))
 I $D(X)#2 S X=9999999.9999-X
 S:$D(X)#2 X(3)=X
 S X=$G(X(1))
 Q
2 N X,X1,X2 S DIXR=1426 D X2(U) K X2 M X2=X D X2("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . K ^RAO(75.1,"AS",$E(X(1),1,30),$E(X(2),1,3),DA)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . S ^RAO(75.1,"AS",$E(X(1),1,30),$E(X(2),1,3),DA)=""
 Q
X2(DION) K X
 S X(1)=$G(@DIEZTMP@("V",75.1,DIIENS,.01,DION),$P($G(^RAO(75.1,DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",75.1,DIIENS,5,DION),$P($G(^RAO(75.1,DA,0)),U,5))
 S X=$G(X(1))
 Q
