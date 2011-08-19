%ZTBKC1 ;SFISC/GJL,AC - DTM BLOCK COUNT ;5/21/91  16:51
 ;;8.0;KERNEL;;JUL 10, 1995
 I '$D(%DS) D
 .;Comment out(after 1st .) the next 5 lines if you want to ask for the data set.
 .N %,%DSLIST,%DSNAM
 .S %DSLIST=$$^%mdslist
 .F %=1:1:$L(%DSLIST,",") D  Q:$D(%DS)
 ..S %DSNAME=$P(%DSLIST,",",%)
 ..I $ZNSPACE_"-GBL"=$P(%DSNAME,":") S %DS=$P(%DSNAME,":",2) Q
 .I '$D(%DS) S %DS=$$^%dsselect,%DS=+$P(%DS,$C(22),2)
 ZGETPAGE %DS+2:0:0 S %B=$V(14,0,-2),(%G,%N)="",(num,tot)=0
 S SIZ=$P("512,1024,2048,4096,8192,16384,32768",",",$V(14,12,-1)\4#8+1)
 S %G=$P(X,"(")
DTMDGD ;
 S %T=0,%N="",%L="" G DTMPTBK
 G EXIT
DTMPTBK ZGETPAGE %DS+1:%B:0 S (%H,%J)=0,%O=24,%E=$V(14,8,-2)
DTMPTLP I %O<%E G DTMPTNT
 S %B=$V(14,6,-2) I %B=65535 S %B=%L
 I %B'=65535 S:%B=%L %L="" G DTMPTBK
 G EXIT
DTMPTNT D DTMNODE I %I=2 D DTMPTDW S %O=%O+2 G DTMPTLP
 I %I=1,%L="" D DTMPTDW
 S %B=%L,%L="" G DTMPTBK:$V(14,0,-1)'=4 S (%H,%J)=0,%T=%T-1 G DTMDTBK
DTMPTDW S %L=$V(14,%O,-2) Q
 ;
DTMDTBK ZGETPAGE %DS:%B:0 S %O=24,%E=$V(14,8,-2),%T=%T+1,%J=0
 ;
DTMDATA I %O<%E G DTMDTNT
 S %B=$V(14,6,-2) I %B'=65535 G DTMDTBK
 G EXIT
DTMDTNT S %J=%J+1 D DTMNODE I %I=1 S:%H=0 %T=%T+1 S %H=1,%O=%E G DTMDATA ;Next BLK
 I %I=2 S %I=$V(14,%O,-2),%O=%O+%I+2 G DTMDATA
 S:%J=1 %T=%T-1 G EXIT
DTMNODE S %C=$V(14,%O,-1),%W=$V(14,%O+1,-1),%N=$E(%N,1,%C)_$V(14,%O+2,%W)
 S %F=$E(%N,$L($P(%N,$C(0)))+1,$L(%N)),%M="",%I=0,%O=%O+2+%W
 I %N="" S %I=2 Q
 I %G]$P(%N,$C(0)) S %I=2 Q
 I $P(%N,$C(0))]%G S %I=3 Q
DTMPROC S %I=%I+1 I %I>$L(%F) G DTMTSTN
 S %V=$A(%F,%I) I %V=0 S %M=%M_"," G DTMPROC
 I %V=128 S %I=%I+1 G DTMASCI:$A(%F,%I),DTMPROC
 I %V=64 S %M=%M_"0" G DTMPROC
 I %V>64 S %S="",%V=%V-94 G DTMPOS
 I %V<64 S %M=%M_"-",%S="",%V=33-%V G DTMNEG
 W !,"ERROR",$C(7),$C(7) G DTMPROC
DTMASCI S %M=%M_$E(%F,%I) I $A(%F,%I+1) S %I=%I+1 G DTMASCI ;Also zero & pos
 G DTMPROC
DTMPOS S %I=%I+1 S %S=%S_($A(%F,%I)-17\16)_($A(%F,%I)-17#16) I $A(%F,%I+1) G DTMPOS
 I %V'<0,%V<$L(%S) S %S=$E(%S,0,%V)_"."_$E(%S,%V+1,$L(%S)) S %S=+%S,%M=%M_%S G DTMPROC
 S @("%S="_%S_"E"_(%V-$L(%S))) S %M=%M_%S G DTMPROC
DTMNEG S %I=%I+1 I $A(%F,%I)'=255 S %S=%S_(239-$A(%F,%I)\16)_(239-$A(%F,%I)#16) G DTMNEG
 ;
 I %V'<0,%V<$L(%S) S %S=$E(%S,0,%V)_"."_$E(%S,%V+1,$L(%S)) S %S=+%S,%M=%M_%S G DTMPROC
 S @("%S="_%S_"E"_(%V-$L(%S))) S %M=%M_%S G DTMPROC
 ;
DTMTSTN S %M=$E(%M,2,256),%S=$P(X,"(",2),%S=$P(%S,")",1) I (%S="")!(%S=%M) S %I=1 Q
DTMTSTL S %X=$P(%S,",",1),%Y=$P(%M,",",1) I +%X'=%X G DTMSTR
 I %Y="" S %I=2 Q
 I +%Y'=%Y S %I=3 Q
 I %X>%Y S %I=2 Q
 I %X<%Y S %I=3 Q
DTMTSTC S %S=$P(%S,",",2,256) I %S="" S %I=1 Q
 S %M=$P(%M,",",2,256) I %M="" S %I=2 Q
 G DTMTSTL
DTMSTR I +%Y=%Y S %I=2 Q
 I %X]%Y S %I=2 Q
 I %X'=%Y S %I=3 Q
 G DTMTSTC
ALL ;All globals from current directory.
 S %DS=$$^%dsselect
 S %DS=+$P(%DS,$C(22),2)
 K ^UTILITY("%ZTBKC",$J) X ^%ZOSF("UCI") W !!,Y,"  " S %SK=$X+1 W "Globals",?(%SK+12),"Data Pages"
 W ?(%SK+34) D NOW^%DTC S X=%,%DT="ET" D ^%DT W !
 ZGETPAGE %DS+2:0:0 S %B=$V(14,0,-2),(%G,%N,%OR,%R)="",(num,tot)=0
 S SIZ=$P("512,1024,2048,4096,8192,16384,32768",",",$V(14,12,-1)\4#8+1)
 F  ZGETPAGE %DS+1:%B:0 Q:$V(14,0,-1)=4  S %B=$V(14,26,-2)
 S %E=$V(14,8,-2),%O=24
ADTMVUE ZGETPAGE %DS+1:%B:0 S %G="",%E=$V(14,8,-2),%O=24
ADTMNXT G ADTMPTR:%E'>%O
ADTMLOP S %C=$V(14,%O,-1),%W=$V(14,%O+1,-1),%G=$E(%G,1,%C)_$V(14,%O+2,%W)
 S:%C!%W %OR=%R,%R=$V(14,%O+%W+2,-2)
 I $P(%G,$C(0))'=%N D ADTMDATA:$L(%N)&(%OR]"") ZGETPAGE %DS+1:%B:0 S %N=$P(%G,$C(0))
 S %O=%O+4+%W G ADTMNXT
ADTMDATA ;
 N %G,%B,%E,%O,%C,%W S %LD=0
 ZGETPAGE %DS:%OR:0 S %G="",%E=$V(14,8,-2),%O=24
ADTMDTNT I %E'>%O S:$L(%N) ^UTILITY("%ZTBKC",$J,%N)="" S %N=$P(%G,$C(0)) Q
 S %C=$V(14,%O,-1),%W=$V(14,%O+1,-1),%G=$E(%G,1,%C)_$V(14,%O+2,%W)
 S:%C!%W %LD=$V(14,%O+%W+2,-2)
 I $P(%G,$C(0))'=%N S:$L(%N) ^UTILITY("%ZTBKC",$J,%N)="" S %N=$P(%G,$C(0))
 S %O=%O+4+%W+%LD G ADTMDTNT
ADTMPTR S %B=$V(14,6,-2) I %B'=65535 G ADTMVUE
 S:$L(%N) ^UTILITY("%ZTBKC",$J,%N)="" S %N=$P(%G,$C(0))
 S %OR=%R D ADTMDATA:$L(%N)&(%OR]"")
DONE zrelpage
 K %BLK,%END,%MM,%NAM,%PT,%S,%STB,%SYS,%UCI,%UCIN,%UCN,%UCNUM
 S (%TOT,%GLO)=0 F %II=1:1 S X=$O(^UTILITY("%ZTBKC",$J,%GLO)),%GLO=X Q:X=""  W !,?%SK,X,?(%SK+15) S:X?1"^".E X=$E(X,2,255) S %T=-1 D %ZTBKC1 S X=%T S:X>0 %TOT=%TOT+X W:X<0 "-- no such global --" W:X'<0 X
 W !!?%SK,"Total",?(%SK+15),%TOT K %GLO,%II,%SK,%TOT,X,Y,^UTILITY("%ZTBKC",$J)
 K %T
EXIT K %,%A,%B,%C,%D,%DT,%E,%F,%G,%H,%I,%J,%K,%L,%M,%N,%O,%S,%UT,%V,%W,%X,%Y,%Z,A
 Q
