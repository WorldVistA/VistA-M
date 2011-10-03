DGPTX45 ; ;12/12/07
 ;;
1 N X,X1,X2 S DIXR=422 D X1(U) K X2 M X2=X D X1("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KDGPT0^DGPTDDCR(.X,.DA,"S",1)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SDGPT0^DGPTDDCR(.X,.DA,"S",1)
 Q
X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.01,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"S",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.01,DIIENS,8,DION),$P($G(^DGPT(DA(1),"S",DA,0)),U,8))
 S X=$G(X(1))
 Q
2 N X,X1,X2 S DIXR=423 D X2(U) K X2 M X2=X D X2("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KDGPT0^DGPTDDCR(.X,.DA,"S",2)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SDGPT0^DGPTDDCR(.X,.DA,"S",2)
 Q
X2(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.01,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"S",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.01,DIIENS,9,DION),$P($G(^DGPT(DA(1),"S",DA,0)),U,9))
 S X=$G(X(1))
 Q
3 N X,X1,X2 S DIXR=424 D X3(U) K X2 M X2=X D X3("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KDGPT0^DGPTDDCR(.X,.DA,"S",3)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SDGPT0^DGPTDDCR(.X,.DA,"S",3)
 Q
X3(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.01,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"S",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.01,DIIENS,10,DION),$P($G(^DGPT(DA(1),"S",DA,0)),U,10))
 S X=$G(X(1))
 Q
4 N X,X1,X2 S DIXR=425 D X4(U) K X2 M X2=X D X4("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KDGPT0^DGPTDDCR(.X,.DA,"S",4)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SDGPT0^DGPTDDCR(.X,.DA,"S",4)
 Q
X4(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.01,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"S",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.01,DIIENS,11,DION),$P($G(^DGPT(DA(1),"S",DA,0)),U,11))
 S X=$G(X(1))
 Q
5 N X,X1,X2 S DIXR=426 D X5(U) K X2 M X2=X D X5("F") K X1 M X1=X
 I $G(X(1))]"",$G(X(2))]"" D
 . D KDGPT0^DGPTDDCR(.X,.DA,"S",5)
 K X M X=X2 I $G(X(1))]"",$G(X(2))]"" D
 . D SDGPT0^DGPTDDCR(.X,.DA,"S",5)
 Q
X5(DION) K X
 S X(1)=$G(@DIEZTMP@("V",45.01,DIIENS,.01,DION),$P($G(^DGPT(DA(1),"S",DA,0)),U,1))
 S X(2)=$G(@DIEZTMP@("V",45.01,DIIENS,12,DION),$P($G(^DGPT(DA(1),"S",DA,0)),U,12))
 S X=$G(X(1))
 Q
