%ZTBKC1 ;SF/GJL - M/SQL BLOCK COUNT ;6/14/90  15:50
 ;;8.0;KERNEL;;JUL 10, 1995
 O 63 E  S %T="The VIEW device is busy." G EXIT
 V 1 S %B=$V(12+1024,0,3)
MVXGD V %B S %G="",%E=$V(2046,0,2),%O=0
 F %I=0:1 Q:%E'>%O  S %Z=$V(%O,0),%O=%O+1 S:(%Z#256) %G=%G_$C(%Z) I (%Z#256)=0 Q:%G=$P(X,"(",1)  S %G="",%O=%O+9
 I %G'="" S %T=0,%O=%O+6 D MVXPTDW S %B=%L G MVXPTBK:%B\256-65535 S %T="IMPLICIT" G EXIT
 S %B=$V(2040,0,3) I %B G MVXGD
 G EXIT
MVXPTBK V %B S (%H,%J,%L,%N)=0 I $V(2043,0,1)=8 G MVXDATA
MVXPTLP S %N=%N+1,%F=$V(%N-1*2+1,-6) I %F'="" G MVXPTNT
 S %B=$V(2040,0,3) I %B=0 S %B=%L
 I %B G MVXPTBK
 G EXIT
MVXPTNT D MVXNODE I %I=2 S %L=$V(%N-1*2+2,-6) G MVXPTLP
 I %I=1,%L=0 S %L=$V(%N-1*2+2,-6)
 S %B=%L G MVXPTBK
MVXPTDW S %L=$V(%O,0,3)
 Q
MVXDTBK V %B S %N=0,%T=%T+1,%J=0
MVXDATA S %N=%N+1,%F=$V(%N-1*2+1,-6) I %F'="" G MVXDTNT
MVXNBLK S %B=$V(2040,0,3) I %B G MVXDTBK
 G EXIT
MVXDTNT S %J=%J+1 D MVXNODE I %I=1 S:%H=0 %T=%T+1 S %H=1 G MVXNBLK ;Next BLK
 I %I=2 G MVXDATA
 S:%J=1 %T=%T-1 G EXIT
MVXNODE S %F=$E(%F,$L(%G)+1,256),%M="",%I=0
MVXPROC S %I=%I+1 I %I>$L(%F) G MVXTSTN
 S %V=$A(%F,%I) I %V=0 S %M=%M_"," G MVXPROC ;Level
 I %V=1 G MVXZERO
 I %V>31 S %M=%M_$C(%V) ;ASCII and Pos
 G MVXPROC
MVXZERO S %I=%I+1,%V=$A(%F,%I) I %V=48 S %M=%M_"0" G MVXPROC
 S %S="",%V=30-%V+1
MVXNEG S %I=%I+1 I $A(%F,%I)'=255 S %S=%S_$C(105-$A(%F,%I)) G MVXNEG
 I %V<$L(%S) S %S=$E(%S,0,%V)_"."_$E(%S,%V+1,512)
 S %M=%M_"-"_%S G MVXPROC
MVXTSTN S %M=$E(%M,2,256),%S=$P(X,"(",2),%S=$P(%S,")",1) I (%S="")!(%S=%M) S %I=1 Q
MVXTSTL S %X=$P(%S,",",1),%Y=$P(%M,",",1) I +%X'=%X G MVXSTR
 I %Y="" S %I=2 Q
 I +%Y'=%Y S %I=3 Q
 I %X>%Y S %I=2 Q
 I %X<%Y S %I=3 Q
MVXTSTC S %S=$P(%S,",",2,256) I %S="" S %I=1 Q
 S %M=$P(%M,",",2,256) I %M="" S %I=2 Q
 G MVXTSTL
MVXSTR I +%Y=%Y S %I=2 Q
 I %X]%Y S %I=2 Q
 I %X'=%Y S %I=3 Q
 G MVXTSTC
ALL ;Entry point for block count of all globals.
ALLMVX ;Directory at ^UTILITY("GLO")
 I '$D(^UTILITY("GLO",0)) W !,"No globals are listed in the ^UTILITY Directory !",! Q
 W !!,$P(^UTILITY("GLO",0),"^",2),"  " S %SK=$X+1 W "Globals",?(%SK+12),"Data Blocks"
 S %DT="T",X="N" D ^%DT W ?(%SK+34),$E(Y,4,5),"/",$E(Y,6,7),"/",$E(Y,2,3) S Y=$P(Y,".",2) W "  ",$E(Y,1,2),":",$E(Y,3,4),! K %DT,Y
 S (%TOT,%GLO)=0 F %II=1:1 S X=$O(^UTILITY("GLO",%GLO)),%GLO=X Q:X=""  I $D(^(X))#2,$P(^(X),"^",4)\256'=65535 W !,?%SK,X,?(%SK+15) S %T=-1 D %ZTBKC1 S X=%T S:X>0 %TOT=%TOT+X W:X<0 "-- no such global --" W:X'<0 X
 W !!?%SK,"Total",?(%SK+15),%TOT K %GLO,%II,%SK,%TOT,X
EXIT C 63 K %,%A,%B,%C,%D,%E,%F,%G,%H,%I,%J,%K,%L,%M,%N,%O,%S,%V,%W,%X,%Y,%Z
 Q
