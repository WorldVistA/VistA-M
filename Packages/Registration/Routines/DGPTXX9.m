DGPTXX9 ; COMPILED XREF FOR FILE #45 ; 02/01/23
 ; 
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD21")
CR25 S DIXR=1247
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X(4)=$P(DIKZ(71),U,13)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD22")
CR26 S DIXR=1248
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X(4)=$P(DIKZ(71),U,14)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD23")
CR27 S DIXR=1249
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,2)
 S X(3)=$P(DIKZ(0),U,11)
 S DIKZ(71)=$G(^DGPT(DA,71))
 S X(4)=$P(DIKZ(71),U,15)
 S DIKZ(70)=$G(^DGPT(DA,70))
 S X(5)=$P(DIKZ(70),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . D SPTFDD^DGPTDDCR(.X,.DA,"D SD24")
CR28 S DIXR=1691
 K X
 S DIKZ(0)=$G(^DGPT(DA,0))
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,11)
 S DIKZ("401P")=$G(^DGPT(DA,"401P"))
 S X(3)=$P(DIKZ("401P"),U,1)
 S X(4)=$P(DIKZ("401P"),U,2)
 S X(5)=$P(DIKZ("401P"),U,3)
 S X(6)=$P(DIKZ("401P"),U,4)
 S X(7)=$P(DIKZ("401P"),U,5)
 S X=$G(X(1))
 D
 . K X1,X2 M X1=X,X2=X
 . D NOTIFYP^DGPTDD(.X1,.X2,.DA,45,"DISCHARGE","SET")
CR29 K X
END G ^DGPTXX10
