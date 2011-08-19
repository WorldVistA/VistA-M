XLFUTL ;SFISC/RWF - Library Function, Check digit ;6/29/94  14:04
 ;;8.0;KERNEL;;Jul 10, 1995
 Q
 ;
CCD(%X) ; Compute check digit and append to number
 ;see Taylor report Computerworld 1975
 ; X= integer, Return X with check digit
 ;
 N %I,%N,%D,%S S %S=0,%D=1,%X=$G(%X) S:+%X'=%X (%X,%S)=""
 F %I=$L(%X):-1:1 S %N=$E(%X,%I),%N=%N*(%D+1),%N=$E(%N)+$E(%N,2),%S=%S+%N,%D='%D
 Q %X_$S(+%X:(-%S#10),1:"")
 ;
VCD(%X) ; -- Verify check digit (last digit)
 ; -- Pass X = integer with check digit appended
 ; -- rtns 0 if check not valid or 1 if valid
 ;
 Q %X=$$CCD($E(%X,1,$L(%X)-1))
 ;
QL(X) ;$QLENGTH OF GLOBAL STRING
 N %,%1
 S %1="" F %=0:1 Q:%1=$NA(@X,%)  S %1=$NA(@X,%)
 Q %-1
 ;
QS(X1,X2) ;$QSUBSCRIPT OF GLOBAL STRING
 N %,%1,Y
 I X2=-1,X1?1"^"1"[".E1"]".E Q $TR($P($P($NA(@X1,0),"]"),"[",2),"""")
 I X2=-1,X1?1"^"1"|".E1"|".E Q $TR($P($NA(@X1,0),"|",2,$L($NA(@X1,0),"|")-1),"""")
 I X2=0,(X1'?1"^"1"[".E)&(X1'?1"^"1"|".E) Q $NA(@X1,X2)
 I X2=0,X1?1"^"1"[".E1"]".E Q "^"_$P($NA(@X1,X2),"]",2,999)
 I X2=0,X1?1"^"1"|".E Q "^"_$P($NA(@X1,X2),"|",$L($NA(@X1,X2),"|"))
 S %1=$NA(@X1,X2-1)
 I $E(%1,$L(%1))=")" S %1=$E(%1,1,$L(%1)-1)
 S Y=$P($NA(@X1,X2),%1,2,999),Y=$E(Y,1,$L(Y)-1)
 I X2=1,$E(Y)="(" S Y=$E(Y,2,999)
 I X2>1,$E(Y)="," S Y=$E(Y,2,999)
 I $A(Y)=34,$A(Y,$L(Y))=34 S Y=$E(Y,2,$L(Y)-1)
 Q Y
BASE(%X1,%X2,%X3) ;Convert %X1 from %X2 base to %X3 base
 I (%X2<2)!(%X2>16)!(%X3<2)!(%X3>16) Q -1
 Q $$CNV($$DEC(%X1,%X2),%X3)
DEC(N,B) ;Cnv N from B to 10
 Q:B=10 N N I,Y S Y=0
 F I=1:1:$L(N) S Y=Y*B+($F("0123456789ABCDEF",$E(N,I))-2)
 Q Y
CNV(N,B) ;Cnv N from 10 to B
 Q:B=10 N N I,Y S Y=""
 F I=1:1 S Y=$E("0123456789ABCDEF",N#B+1)_Y,N=N\B Q:N<1
 Q Y
