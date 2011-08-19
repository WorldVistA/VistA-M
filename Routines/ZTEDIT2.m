ZTEDIT2 ;SF/RWF - VA EDITOR ;09/03/2008
 ;;8.0;KERNEL;**9,16,120,499**;Jul 10, 1995;Build 14
 F %I=1:1 S %A=$T(%+%I),%T=$P(%A," ",1),%B=$P(%A," ",2,256) Q:%T="END"  I $L(%T) S ^%Z(%T)=%B
 G ^ZTEDIT3
 Q
% ;
ACTION R !,"Action: ",%X:%9 S %X=$S(%X?1".".E:$E(%X,2),1:$E(%X)),%NX=$S(%X="":1,"BCRSV"[%X:"A"_$A(%X),"bcrsv"[%X:"A"_($A(%X)-32),%X="?":"?A",1:"what2")
A66 S %NX="A661",%Y=0 F %=1:1 S %X=$T(+%) Q:%X=""  S %Y=%Y+2+$L(%X) I $L(%X)>245 W !,"Line '+",%,"' is longer than 245"
A661 S %NX="A99" W ?20,"Routine is ",%Y," Bytes in size."
A67 X ^%Z("A671") W !,?20,"Checksum is ",%Y S %NX="A99"
A671 S %Y=0 F %=1,3:1 S %1=$T(+%),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S %Y=$A(%1,%2)*%2+%Y
A83 X ^%Z("MV1"),^%Z("A99")
A82 X ^%Z("MV100"),^%Z("A99")
A86 W !,"%Z editor version ",^%Z("VR") X ^%Z("A99")
A99 S %NX="ACTION"
JOIN S %NX=1 W "oin line: " X ^%Z("GTAG") Q:%T=""  S %LS=%L,%TG=%T,%T=%D_"+"_(%E+1) X ^%Z("TAG") S %NX=$S(%L="":"what",1:"JO2")
JO2 W:%X'=%TG " ",%TG S %NX=1,%X=$L(%LS)+$L(%L)>245 W:%X " ... too long" I '%X ZR @%T,@%TG ZI %LS_%L W !,%LS_%L
SEARCH S %NX=1 R "earch for: ",%R:%9 Q:%R=""  X ^%Z("SELALL") S %NX=$S(%POP:"what",1:"S55")
S55 S %NX=1,%T=$S(%C:%B_"+"_%C,1:%B) F %A=%A:1:%I S %L=$T(+%A) S:$P(%L," ")]"" %T=$P($P(%L," "),"("),%C=0,%B=$P(%T,"(") W:%L[%R !,%T,?6," ",$P(%L," ",2,999),! S %C=%C+1,%T=%B_"+"_%C
GTAG W:$D(%TG) %TG,"//" R %X:%9 X ^%Z("GT2"):%X="*" S %L="",%T=$S(%X?1.P:"",%X]"":%X,$D(%TG):%TG,1:"") S:%T="" %NX=1 Q:%T=""  X ^%Z("TAG") S:%T]"" %TG=%T
GT2 S %D="",%E=0 F %I=1:1 S %L=$T(+%I),%E=%E+1 Q:%L=""  S:$P(%L," ")]"" %D=$P($P(%L," "),"("),%E=0 S %X=$S(%E:%D_"+"_%E,1:%D)
GT3 X ^%Z("GT2") S %NX="EDIT"
TAG S:%T?1"""""+".N %T=$E(%T,3,9) S %L="",%D=$P(%T,"+",1),%E=$P(%T,"+",2) Q:%D'?1.8AN&(%D'?1"%".AN)&(%D]"")!(%E'?.N)  S:%D="" %D=$P($P($T(+1)," "),"("),%E=%E-1 X ^("TAG2")
TAG2 S %T=%D,%I=%E,%E=-1 F %I=0:1:%I S %E=%E+1,%T=$S(%E>0:%D_"+"_%E,1:%D),@("%L=$T("_%T_")") I $P(%L," ",1)]"" S %D=$P($P(%L," "),"("),%E=0,%T=%D
SELECT S %POP=1 W " from line: " X ^%Z("GTAG") Q:%L=""  S %ST=%T,%B=%D,%C=%E X ^%Z("SEL3") S %A=%I W " to line: " X ^%Z("GTAG") Q:%L=""  X ^%Z("SEL3") S %POP=%A>%I
SELALL S %POP=1 R " from line: BEG=> ",%T:%9 S:%T="" %T="+1" X ^%Z("TAG") Q:%L=""  S %B=%D,%C=%E X ^%Z("SEL3") S %A=%I R " to line: END=> ",%T:%9 S (%D,%E)="" X ^%Z("TAG"):%T]"" S %POP=%L=""&(%T]"") Q:%POP  X ^%Z("SEL3") S %POP=%A>%I
SEL3 F %I=1:1 S %L=$T(+%I) Q:%L=""  I $P($P(%L," "),"(")=%D,%D]"" S %I=%I+%E Q
LN1 S:$P(%L," ")[$C(9) %L=$P(%L,$C(9))_" "_$P(%L,$C(9),2,99) S %T=$P($P(%L," "),"("),%POP=$P(%L," ",2)']"" I '%POP,%T'?.N,%T'?1A.7AN,%T'?1"%".7AN S %POP=1
LOCAL S %NX="what" S:%X'="*" %LCL=$E(%X,2,99) Q:'$D(%LCL)  Q:'$D(@%LCL)#2  S %T="*"_%LCL,%L=@%LCL X ^%Z("EDITLINE") S @%LCL=%L,%NX=1
TERM S %NX=1 X ^%Z("TERM1"),^%Z("TERM2"),^%Z("TERM3")
TERM1 S %S=$O(^%ZIS(2,"B","C-VT100",0)),%S=$G(^VA(200,+$G(DUZ),1.2),%S) I %S'>0 W !,"Terminal Type not found."
TERM2 W !,"TERMINAL TYPE: ",$S(%S'>0:"",$D(^%ZIS(2,%S,0)):$P(^(0),"^",1)_"//",1:"") R %X:999 Q:%X=""  S %S=$S($D(^%ZIS(2,"B",%X)):$O(^(%X,0)),1:0)
TERM3 Q:%S<1  S %ST=$P(^%ZIS(2,%S,0),"^",1),%=^(1),%RM=%-1,%SL=$P(%,"^",3)-4,XY=$G(^("XY")),DX=0,DY=%SL,X=%RM+1,IOT=$G(IOT,"TRM") X ^%ZOSF("RM") X XY W !!!
MODE W " mode change" S:XY]"" %XY=XY S %NX=1,XY=$S(XY]"":"",1:$S($D(%XY):%XY,1:"")) W !,$S(XY="":"replace-with",1:"line editor"),!
END ;
