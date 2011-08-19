%ZTBKC1 ;SFISC/GJL,AC - MSM BLOCK COUNT  ;1/22/90  18:21
 ;;8.0;KERNEL;;JUL 10, 1995
 S %D=$P($ZU(""),",",2),%O=+$ZU(""),%O=0,%D="G"_%D
 O 63::5 E  W !,$C(7),"The VIEW device is busy!",$C(7),!! Q
 S %G=$P(X,"("),%B=$ZBN(@("^"_%G)),%N="",%T=0 G MSMPTBK
MSMGD ;FIND GLOBAL DIRECTORY
 G EXIT
MSMPTBK V %B:%D S (%H,%J,%L,%O)=0,%E=$V(1022,0,2) S %TYPE=$V(1020,0,1)#128 I %TYPE=3!(%TYPE=4) G MSMDATA
 ;
MSMPTLP I %O<%E G MSMPTNT
 S %B=$V(1012,0,4) I %B=0 S %B=%L
 I %B G MSMPTBK
 G EXIT
MSMPTNT D MSMNODE I %I=2 D MSMPTDW S %O=%O+3 G MSMPTLP
 I %I=1,%L=0 D MSMPTDW
 S %B=%L G MSMPTBK
MSMPTDW S %L=$V(%O,0,3) Q
 ;
MSMDTBK V %B:%D S %O=0,%E=$V(1022,0,2),%T=%T+1,%J=0
 ;
MSMDATA I %O<%E G MSMDTNT
 S %B=$V(1012,0,4) I %B G MSMDTBK
 G EXIT
MSMDTNT S %J=%J+1 D MSMNODE I %I=1 S:%H=0 %T=%T+1 S %H=1,%O=%E G MSMDATA ;Next BLK
 I %I'=2 S:%J=1 %T=%T-1 G EXIT
 S %I=$V(%O,0,1) I '%I S %O=%O+5 G MSMDATA ;G 0:'%I
 S %I=$S(%I=3!(%I=8):$V(%O+1,0,1),1:-1),%O=%O+%I+2 G MSMDATA
MSMNODE S %C=$V(%O,0,1),%W=$V(%O+1,0,1),%O=%O+2
 S %I=%O,%K="" I %C=0 S %K=%G,%I=%I+$L(%G)
 ;
 F %I=%I:1:%O+%W I %I<(%O+%W) S %Z=$V(%I,0,1),%K=%K_$C(%Z#256)
 S %O=%I,%N=$E(%N,0,%C)_%K,%F=$E(%N,$L(%G)+1,256),%M="",%I=0
MSMPROC S %I=%I+1 I %I>$L(%F) G MSMTSTN
 S %V=$A(%F,%I) I %V=0 S %M=%M_"," G MSMPROC
 I %V=255 S %I=%I+1 G MSMASCI:$A(%F,%I),MSMPROC
 I %V>127 S %I=%I+1,%S="",%V=%V-128 G MSMPOS:$A(%F,%I),MSMPROC
 I %V=127 S %M=%M_"0" G MSMPROC
 I %V<127 S %M=%M_"-",%S="",%V=126-%V G MSMNEG
 W !,"ERROR",$C(7),$C(7) G MSMPROC
MSMASCI S %M=%M_$E(%F,%I) I $A(%F,%I+1) S %I=%I+1 G MSMASCI ;Also zero & pos
 G MSMPROC
MSMPOS S %S=%S_$E(%F,%I) I $A(%F,%I+1) S %I=%I+1 G MSMPOS
 I %V<$L(%S) S %S=$E(%S,0,%V)_"."_$E(%S,%V+1,256)
 S %M=%M_%S G MSMPROC
 G MSMPOS
MSMNEG S %I=%I+1 I $A(%F,%I)'=255 S %S=%S_$C(105-$A(%F,%I)) G MSMNEG
 I %V<$L(%S) S %S=$E(%S,0,%V)_"."_$E(%S,%V+1,256)
 S %M=%M_%S
 G MSMPROC
MSMTSTN S %M=$E(%M,2,$L(%M)),%S=$P(X,"(",2),%S=$P(%S,")",1) I (%S="")!(%S=%M) S %I=1 Q
MSMTSTL S %X=$P(%S,",",1),%Y=$P(%M,",",1) I +%X'=%X G MSMSTR
 I %Y="" S %I=2 Q
 I +%Y'=%Y S %I=3 Q
 I %X>%Y S %I=2 Q
 I %X<%Y S %I=3 Q
MSMTSTC S %S=$P(%S,",",2,$L(%S)) I %S="" S %I=1 Q
 S %M=$P(%M,",",2,$L(%M)) I %M="" S %I=2 Q
 G MSMTSTL
MSMSTR I +%Y=%Y S %I=2 Q
 I %X]%Y S %I=2 Q
 I %X'=%Y S %I=3 Q
 G MSMTSTC
ALL ;Entry point for block count of all globals.
 O 63::2 E  W !,"The VIEW device is busy.",$C(7) Q
 K ^UTILITY("%ZTBKC",$J) X ^%ZOSF("UCI") W !!,Y,"  " S %SK=$X+1 W "Globals",?(%SK+12),"Data Blocks"
 W ?(%SK+34) D NOW^%DTC S X=%,%DT="ET" D ^%DT W !
 S %D=$P($ZU(""),",",2),%O=+$ZU("")
 S %A=$V(44),%S=$V(%A+8,-3,2)+%A,%VT=$V(40+%S)
 S %UT=$V($V(%D*4+%VT)+20),%D="G"_%D
 S %B=$V(%O-1*32+%UT+4,-3,4),%N="",(%C,%W)=0
AMSMVUE V %B:%D S %G="",%E=$V(1022,0,2),%O=$S($V(0,0,1)=0:13,1:0)
AMSMNXT G AMSMPTR:%E'>%O
 S %C=$V(%O,0,1),%W=$V(%O+1,0,1),%G=$E(%N,1,%C),%O=%O+2
AMSMLOP S %Z=$V(%O,0,1),%O=%O+1 S:%Z#256 %G=%G_$C(%Z#256) G AMSMLOP:%Z
 S ^UTILITY("%ZTBKC",$J,%G)="",%O=%O+11,%N=%G,%G="" G AMSMNXT
AMSMPTR S %B=$V(1012,0,4) I %B G AMSMVUE
 C 63 K %VT
 S (%TOT,%GLO)=0 F %II=1:1 S X=$O(^UTILITY("%ZTBKC",$J,%GLO)),%GLO=X Q:X=""  W !,?%SK,X,?(%SK+15) S:X?1"^".E X=$E(X,2,255) S %T=-1 D %ZTBKC1 S X=%T S:X>0 %TOT=%TOT+X W:X<0 "-- no such global --" W:X'<0 X
 W !!?%SK,"Total",?(%SK+15),%TOT K %GLO,%II,%SK,%TOT,X,^UTILITY("%ZTBKC",$J)
EXIT C 63 K %A,%B,%C,%D,%E,%F,%G,%H,%I,%J,%K,%L,%M,%N,%O,%S,%TYPE,%UT,%V,%W,%X,%Y,%Z
