ZTEDIT3 ;SF/RWF - VA EDITOR Transfer lines from one place to another ;8/7/98  08:29
 ;;7.3;TOOLKIT;**16,120**;Apr 25, 1995
 F %I=1:1 S %A=$T(%+%I),%T=$P(%A," ",1),%B=$P(%A," ",2,256) Q:%T="END"  I $L(%T) S ^%Z(%T)=%B
 G ^ZTEDIT4
CHECK ;see if routines and global are the same
 S S=" ",H="Tag: ",H2=" not the same",A="F %I=1:1 S %A=$T(%+%I),%T=$P(%A,S,1),%B=$P(%A,S,2,256) Q:%T=""END""  I $L(%T),%B'=$S($D(^%Z(%T)):^(%T),1:0) W !,H,%T,H2"
 F R="ZTEDIT","ZTEDIT1","ZTEDIT2","ZTEDIT3" W !,"Checking ",R X "ZL @R X A"
 D CHECK^ZTEDIT4 W !,"DONE" Q
% ;
MV W "ove lines" K %ST,%EN S %NX=1 X ^%Z("MV1") Q:'($D(%ST)&$D(%EN))  ZR @(%ST_":"_%EN) X ^%Z("MV102") W !,$T(@%D+%E),!,$T(@%D+%E+1)
MV1 S %POP=0 W !,"Begin: " X ^%Z("GTAG") Q:%T=""  K ^TMP("%Z",$J) S %ST=%T X ^%Z("MV2")
MV2 W "   End:" X ^%Z("GTAG") Q:%T=""  S %X=%T X ^%Z($S(%X="*":"MV3",1:"MV20")),^%Z("MV99")
MV3 S %J=1,%B=$P(%ST,"+",1),%I=+$P(%ST,"+",2) F %I=%I:1 S %T=%B_"+"_%I,@("%L=$T("_%T_")") Q:%L=""  S %EN=%T,^TMP("%Z",$J,%J)=%L,%J=%J+1
MV20 S %T=%X X ^%Z("TAG") Q:%L=""  S %EN=%T X ^%Z("MV21")
MV21 S %J=1,%B=$P(%ST,"+",1),%I=+$P(%ST,"+",2) F %I=%I:1 S %T=$S(%I:%B_"+"_%I,1:%B),@("%L=$T("_%T_")") X ^%Z("MV22") S:$P(%L," ",1)]"" %B=$P($P(%L," "),"("),%I=0,%T=%B Q:%T=%EN
MV22 S ^TMP("%Z",$J,%J)=%L,%J=%J+1
MV99 K %A,%B,%I,%J,%T,%L,%X
MV100 S %L="" W !,"Insert after: " X ^%Z("GTAG") Q:%T=""  S %TG=%T X ^%Z("MV101"),^%Z("MV99")
MV101 I $D(^TMP("%Z",$J,1)) S %A=^(1) ZR @%T ZI %L F %J=1:1 Q:'$D(^TMP("%Z",$J,%J))  S %A=^(%J) ZI %A
MV102 X ^%Z("MV100") I $D(%L) W !,"The lines removed have NOT been inserted back into the routine",!,"use the .Action menu to Restore lines."
FILE S %NX="F30",%POP=("Ff"[$E(%X_" ",3)),%X=$T(+0) W "ile ",%X I %X]"" X ^%Z("F2"),^%Z("F3") S %NX="F10",%L=$T(+1),$P(%L," ;",3,9)=%D_"  "_%C ZR +1 ZI %L ZS
F2 S %=$H>21549+$H-.1,%Y=%\365.25+141,%=%#365.25\1,%D=%+306#(%Y#4=0+365)#153#61#31+1,%M=%-%D\29+1,%DT=%Y_"00"+%M_"00"+%D,%D=%M_"/"_%D_"/"_$E(%Y,2,3)
F3 S %A=$P($H,",",2),%=(%A#3600\60)/100+(%A\3600)/100,%DT=%DT+%,%A=$E(%_"0000",2,5) S %C=$E(%A,1,2)_":"_$E(%A,3,4)
F10 S %NX=1 X ^%Z("F11") I %A>0 X ^%ZOSF("UCI") S ^DIC(9.8,%A,23,%C,0)=%DT_"^"_$I_"^"_Y_"^"_$S($D(DUZ)#2:DUZ,1:"") X ^%Z("F14")
F11 S %A="" Q:'$D(^DIC(9.8,0))  L +^DIC(9.8,0) S %A=$O(^DIC(9.8,"B",%X,0)) X ^%Z("F12"):%A'>0,^%Z("F13") L -^DIC(9.8,0)
F12 S %A=$P(^DIC(9.8,0),"^",3)+1,%C=$P(^(0),"^",4)+1 X "F %=0:0 Q:'$D(^DIC(9.8,%A,0))  S %A=%A+1" S $P(^DIC(9.8,0),"^",3,4)=%A_"^"_%C,^DIC(9.8,%A,0)=%X_"^R",^DIC(9.8,"B",%X,%A)=""
F13 S:'$D(^DIC(9.8,%A,23,0)) ^(0)="^9.823^^" S %C=1+$P(^DIC(9.8,%A,23,0),"^",3),$P(^(0),"^",3,4)=%C_"^"_(1+$P(^(0),"^",4))
F14 S:$D(DUZ)[0 DUZ=0,DUZ=0,DUZ(0)="" X:'%POP ^%Z("F15") S X="XTVRC1Z" X ^%ZOSF("TEST") D:$T ^XTVRC1Z
F15 S DWPK=1,DIC="^DIC(9.8,"_%A_",23,"_%C_",1," W !,"Edit comment:" N %X,%NX,%TG D EN^DIWE W !,"Return"
F30 W *7," No name, Can't FILE." S %NX=1
END ;
