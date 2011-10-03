TIUEDS14 ; ;04/21/09
 ;;
1 N X,X1,X2 S DIXR=247 D X1(U) K X2 M X2=X D X1("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K ^TIU(8925,"ADIV",X(1),X(2),X(3),X(4),DA)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . S ^TIU(8925,"ADIV",X(1),X(2),X(3),X(4),DA)=""
 Q
X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",8925,DIIENS,1212,DION),$P($G(^TIU(8925,DA,12)),U,12))
 S X(2)=$G(@DIEZTMP@("V",8925,DIIENS,.01,DION),$P($G(^TIU(8925,DA,0)),U,1))
 S X(3)=$G(@DIEZTMP@("V",8925,DIIENS,.05,DION),$P($G(^TIU(8925,DA,0)),U,5))
 S X=$G(@DIEZTMP@("V",8925,DIIENS,1301,DION),$P($G(^TIU(8925,DA,13)),U,1))
 I $D(X)#2 S X=9999999-X
 S:$D(X)#2 X(4)=X
 S X=$G(X(1))
 Q
