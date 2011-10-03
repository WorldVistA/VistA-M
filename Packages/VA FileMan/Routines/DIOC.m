DIOC ;SFISC/TKW-GENERATE CODE TO CHECK QUERY CONDITIONS ;04:18 PM  13 Feb 2002
 ;;22.0;VA FileMan;**97**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
BEF(X,Y,N,M) ; BEFORE  (X before Y)
 N Z D Q(.Y)
 I $G(N)="'" S Z=Y_"']]"_X Q Z
 S Z="" S:$G(M)]"" Z=X_"]"""","
 S Z=Z_Y_"]]"_X Q Z
AFT(X,Y,N,M) ; AFTER (X after Y)
 N Z D Q(.Y)
 I $G(N)="'" S Z="" S:$G(M)]"" Z=X_"]""""," S Z=Z_X_"']]"_Y Q Z
 S Z=X_"]]"_Y Q Z
BTWI(X,F,T,N,S) ;BETWEEN INCLUSIVE  (NOTE: Param.'S' defined only if called from sort.
 S S=$G(S) N Z
 I $G(N)="'" S Z="("_$$BEF(X,F)_")!("_$$AFT(X,T)_")" Q Z
 S:S]"" Z=$$AFT(X,F)
 I S="" D Q(.F) S Z=F_"']]"_X
 S Z="("_Z_")&("_$$AFT(X,T,"'")_")" Q Z
BTWE(X,F,T,N) ;BETWEEN EXCLUSIVE
 N Z D Q(.T)
 I $G(N)="'" S Z="("_$$AFT(X,F,"'")_")!("_T_"']]"_X_")" Q Z
 S Z="("_$$AFT(X,F)_")&("_T_"]]"_X_")" Q Z
EQ(X,Y,N) ;EQUALS
 N Z S:$G(N)'="'" N="" D Q(.Y) S Z=X_N_"="_Y Q Z
NULL(X,N) ;NULL
 N Z S:$G(N)'="'" N="" S Z=X_N_"=""""" Q Z
 ;
Q(X) ;
 I +$P(X,"E")'=X S X=""""_$$CONVQQ^DILIBF(X)_""""
 Q
