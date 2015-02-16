JULIEDBA ;
 F I=65:1:89 D
 . F J=48:1:57 D
 ..F K=48:1:57 D
 ...F L=48:1:57 D
 ....D SET
 ...F L=65:1:89 D
 ....D SET
 ..F K=65:1:89 D
 ...D SET
 .F J=65:1:89 D
 ..D SET
 Q
SET S X=$C(I)_$C(J)_$C(K)_$C(L)
 S ^JULIEDBA(I,J,K,L)=X
 W !,X
 Q
