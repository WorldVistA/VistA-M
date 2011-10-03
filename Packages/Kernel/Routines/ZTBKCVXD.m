%ZTBKC1 ;SFISC/GJL,AC - VAX DSM BLOCK COUNT ;6/14/90  15:51
 ;;8.0;KERNEL;;JUL 10, 1995
 S %D=$P($ZU(""),",",2),%O=+$ZU(""),%O=%O-1*20,%D="S"_%D
 S A=$ZC(%VIEWBUFFER,1) V 0:%D S %UT=$V(910,0,3)
 V %UT:%D
 S %B=$V(%O+2,0,3)
VXDGD V %B:%D S %G="",%E=$V(1022,0,2),%O=0
 F %I=0:1 Q:%E'>%O  S %Z=$V(%O,0,1),%G=%G_$C(%Z\2),%O=%O+1 I '(%Z#2) Q:%G=$P(X,"(",1)  S %G="",%O=%O+8
 I %G'="" S %T=0,%O=%O+5 D VXDPTDW S %B=%L,%N="" G VXDPTBK
 S %B=$V(1014,0,3) I %B G VXDGD
 G EXIT
VXDPTBK V %B:%D S (%H,%J,%L,%O)=0,%E=$V(1022,0,2) I ($V(1021,0,1)#128)=8 G VXDDATA
VXDPTLP I %O<%E G VXDPTNT
 S %B=$V(1018,0,3) I %B=0 S %B=%L
 I %B G VXDPTBK
 G EXIT
VXDPTNT D VXDNODE I %I=2 D VXDPTDW S %O=%O+3 G VXDPTLP
 I %I=1,%L=0 D VXDPTDW
 S %B=%L G VXDPTBK
VXDPTDW S %L=$V(%O,0,3) Q
 ;
VXDDTBK V %B:%D S %O=0,%E=$V(1022,0,2),%T=%T+1,%J=0
 ;
VXDDATA I %O<%E G VXDDTNT
 S %B=$V(1018,0,3) I %B G VXDDTBK
 G EXIT
VXDDTNT S %J=%J+1 D VXDNODE I %I=1 S:%H=0 %T=%T+1 S %H=1,%O=%E G VXDDATA ;Next BLK
 I %I=2 S %I=$V(%O,0,1),%O=%O+%I+1 G VXDDATA
 S:%J=1 %T=%T-1 G EXIT
VXDNODE S %C=$V(%O,0,1),%W=$V(%O+1,0,1),%O=%O+2
 S %I=%O,%K="" I %C=0 S %K=%G,%I=%I+$L(%G)
 ;
 F %I=%I:1:%O+%W I %I<(%O+%W) S %Z=$V(%I,0,1),%K=%K_$C(%Z)
 S %O=%I,%N=$E(%N,0,%C)_%K,%F=$E(%N,$L(%G)+1,256),%M="",%I=0
VXDPROC S %I=%I+1 I %I>$L(%F) G VXDTSTN
 S %M=%M_",",%V=$A(%F,%I),%I=%I+1 I %V=1 G VXDNULL
 I %V<128 S %M=%M_"-" G VXDNEG
VXDASCI S %M=%M_$E(%F,%I),%I=%I+1 I $A(%F,%I) G VXDASCI ;Also zero & pos
 G VXDPROC
VXDNULL S %M=%M_"",%I=%I+1 I $A(%F,%I) G VXDNULL
 G VXDPROC
VXDNEG I $E(%F,%I)="." S %M=%M_"."
 E  S %M=%M_$C(105-$A(%F,%I))
 S %I=%I+1 I $A(%F,%I)=254 S %I=%I+1 G VXDPROC
 G VXDNEG
VXDTSTN S %M=$E(%M,2,256),%S=$P(X,"(",2),%S=$P(%S,")",1) I (%S="")!(%S=%M) S %I=1 Q
VXDTSTL S %X=$P(%S,",",1),%Y=$P(%M,",",1) I +%X'=%X G VXDSTR
 I %Y="" S %I=2 Q
 I +%Y'=%Y S %I=3 Q
 I %X>%Y S %I=2 Q
 I %X<%Y S %I=3 Q
VXDTSTC S %S=$P(%S,",",2,256) I %S="" S %I=1 Q
 S %M=$P(%M,",",2,256) I %M="" S %I=2 Q
 G VXDTSTL
VXDSTR I +%Y=%Y S %I=2 Q
 I %X]%Y S %I=2 Q
 I %X'=%Y S %I=3 Q
 G VXDTSTC
ALL ;All globals from current directory.
 K ^UTILITY("%ZTBKC",$J) X ^%ZOSF("UCI") W !!,Y,"  " S %SK=$X+1 W "Globals",?(%SK+12),"Data Blocks"
 W ?(%SK+34) D NOW^%DTC S X=%,%DT="ET" D ^%DT W !
 S %D=$P($ZU(""),",",2),%O=+$ZU(""),%O=%O-1*20,%D="S"_%D
 S A=$ZC(%VIEWBUFFER,1) V 0:%D S %UT=$V(910,0,3)
 V %UT:%D
 S %B=$V(%O+2,0,3)
AVXDVUE V %B:%D S %G="",%E=$V(1022,0,2),%O=0
AVXDNXT G AVXDPTR:%E'>%O
AVXDLOP S %Z=$V(%O,0,1),%O=%O+1,%G=%G_$C(%Z\2) G AVXDLOP:%Z#2
 S ^UTILITY("%ZTBKC",$J,%G)="",%O=%O+8,%G="" G AVXDNXT
AVXDPTR S %B=$V(1014,0,3) I %B G AVXDVUE
 C 63 ;K %BLK,%END,%MM,%NAM,%PT,%S,%STB,%SYS,%UCI,%UCIN,%UCN,%UCNUM
 S (%TOT,%GLO)=0 F %II=1:1 S X=$O(^UTILITY("%ZTBKC",$J,%GLO)),%GLO=X Q:X=""  W !,?%SK,X,?(%SK+15) S:X?1"^".E X=$E(X,2,255) S %T=-1 D %ZTBKC1 S X=%T S:X>0 %TOT=%TOT+X W:X<0 "-- no such global --" W:X'<0 X
 W !!?%SK,"Total",?(%SK+15),%TOT K %GLO,%II,%SK,%TOT,X,^UTILITY("%ZTBKC",$J)
EXIT K %,%A,%B,%C,%D,%E,%F,%G,%H,%I,%J,%K,%L,%M,%N,%O,%S,%UT,%V,%W,%X,%Y,%Z,A
 Q
