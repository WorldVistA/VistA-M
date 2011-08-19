ZTEDIT ;SF/RWF - VA EDITOR, Generic routine editor ;9/29/92  11:41 ;
 ;;7.3;TOOLKIT;**16,120**;Apr 25, 1995
 ;K ^%Z
A S %A=$T(%),^%Z=$P(%A," ",2,256) F %I=1:1 S %A=$T(%+%I),%T=$P(%A," ",1),%B=$P(%A," ",2,256) Q:%T="END"  I $L(%T) S ^%Z(%T)=%B
 D ^ZTEDIT1 S ^%Z("VR")=$P($T(+2),";",3)
 Q
 ; This and the other ZTEDIT* routines set up the ^%Z global by
 ; copying lines into them from within these routines themselves.  A
 ; line here with tag "x" is copied into ^%Z(x), for instance.  Untagged
 ; lines aren't copied, and therefore are comments.
 ;
% N %RN S %NX="LOCK" X ^%Z(0) F %IED=0:0 X ^%Z(%NX) Q:'$D(%NX)
0 S %9=84000,%SL=0,%RM=80,XY="",%S=0,%ST="" X ^%Z("TERM1"),^%Z("TERM3") W !,"%Z Editing: ",$T(+0),"  Terminal type: ",%ST I $D(%TG) S %T=%TG X ^%Z("TAG") K:%L="" %TG
 ;EDIT;Same line; Execute; +N; Absolute N; Global; *Local; -N; Zexecute; .Function; Question; tag-N; Edit line
1 S %NX=2 R !,"Edit: ",%X:%9
2 S %NX=$S(%X="":31,%X?1A1" ".E:"EXEC",%X?1"+".N:10,%X?1"""""+".N:35,%X?1"^".E:"GLO",%X="*":"GT3",%X?1"*".E:"LOCAL",%X?1"-".N:26,%X?1"Z"1A1" ".E:"EXEC",%X?1".".E:"FUNC",%X?1"?".E:"?",%X["-":25,1:"EDIT")
 ;+
10 S %NX=32 S:%X="+" %X="+1" I $D(%TG),%TG'?1"+".E S %A=$P(%TG,"+",2)+$E(%X,2,9),%TG=$P(%TG,"+",1),%NX=31 S:%A %TG=%TG_"+"_%A
 ;-
25 S %NX=27,%B=$P(%X,"-",1),%A=0-$P(%X,"-",2)
26 S %NX=32 S:%X="-" %X="-1" I $D(%TG),%TG'?1"+".E S %A=$P(%TG,"+",2)-$E(%X,2,9),%B=$P(%TG,"+",1),%NX=27 I %A'<0 S %TG=%B,%NX=31 I %A S %TG=%TG_"+"_%A
27 S %NX="what" F %I=1:1 S %C=$T(+%I) Q:%C=""  I $P($P(%C," "),"(")=%B S %A=%I+%A S:%A>0 %NX=28 Q
28 S %NX=29,%B=0 F %I=1:1:%A S %C=$P($P($T(+%I)," "),"("),%B=%B+1 I %C]"" S %TG=%C,%B=0
29 S %NX=31 I %B S %TG=%TG_"+"_%B
 ;SAME LINE
31 S:'$D(%TG) %TG="+1" W " ",%TG S %X=%TG,%NX="EDIT"
32 S:'$D(%TG)&(%X<0) %NX="what" S:'$D(%TG) %TG="" S %TG=%TG+%X S:%TG<0 %NX="what" S:%TG'<0 %TG="+"_%TG,%NX=31
35 S %X=$E(%X,3,99),%NX=$S(%X>0:"EDIT",1:"what") I %X="+0" W !,$T(+0) S %NX=1
LOCK S %NX=1,%RN=$T(+0) Q:'$L(%RN)  L +@%RN:1 E  S %NX="EXIT" W !,"This routine is being edited by another user."
LOCKX I %RN]"" L -@%RN
STORE ZR @%TG ZI:%L]"" %L S %A=$P($P(%L," "),"("),%NX=1 S:%A]"" %TG=%A
BREAK S %NX="what" W "reak line: " X ^%Z("GTAG") Q:%L=""  S %NX="BR2" W:%X'=%T " ",%T S %TG=%T
BR2 S %NX=1 R " after characters: ",%R:%9 I %R'="",%L[%R S %LS=$P(%L,%R,2,999),%LS=$E(" ",%LS'?1" ".E)_%LS,%L=$P(%L,%R,1)_%R ZR @%TG ZI %L,%LS W !,%L,!,%LS
EXEC W ! S %A=%X_" W *0" X %A,^%Z(0):'$D(%RM) S %NX=1,%IED=0
 ;Functions;Insert,Change,Search,Remove,File,Move,Break,Join,X-mode,Action,Terminal
FUNC S %A=$E(%X,2),%A=$S(%A?1L:$C($A(%A)-32),1:%A),%NX=$S(%A="":"EXIT",%A="I":"INSERT",%A="C":"CHANGE",%A="S":"SEARCH",%A="R":"REMOVE",%A="F":"FILE",%A="M":"MV",%A="B":"BREAK",1:"FUNC2")
FUNC2 S %NX=$S(%A="J":"JOIN",%A="X":"MODE",%A="T":"TERM",%A="A":"ACTION",1:"what")
EXIT X ^%Z("LOCKX") S X=%RM+1 X ^%ZOSF("RM") K %,%A,%B,%C,%CTG,%D,%DT,%E,%F,%FI,%GLO,%I,%IED,%J,%K,%L,%LCL,%LO,%LS,%M,%N,%NX,%POP,%R,%RM,%RN,%S,%SL,%ST,%SX,%SY,%T,%W,%X,%XY,%Y,%Z,DX,DY
INSERT S %NX=1 W "nsert after: " X ^%Z("GTAG") Q:%L=""  ZR @%T ZI %L S %NX="IN2",%TG=%T
IN2 S %NX=1 R !,"Line: ",%L:%9 Q:%L=""  X ^%Z("LN1") S %NX="IN2" W:%POP *7,!,?5,"[tag syntax]" I '%POP ZI %L S %A=$P(%L," "),%B=$S(%A]"":$P(%A,"("),1:$P(%TG,"+")_"+"_($P(%TG,"+",2)+1)),%TG=%B
CHANGE S %NX=1 R "hange every: ",%R:%9 Q:%R=""  R " to: ",%W:%9,! X ^%Z("SELALL") S %D=$L(%W)-$L(%R),%NX=$S(%POP:"what",1:"CH2")
CH2 S %NX=1 F %A=%A:1:%I S %L=$T(+%A),%F=$F(%L,%R),%X=%F X:%X>0 ^%Z("CH3") S:$P(%L," ")]"" %T=$P(%L," "),%C=0,%B=$P(%T,"(") S %T=$S(%C:%B_"+"_%C,1:%T),%C=%C+1 W:%X>0 !,%T,?6," ",$P(%L," ",2,99)
CH3 X ^%Z("CH4") ZR +%A ZI %L
CH4 F %IED=0:0 S %L=$E(%L,0,%F-$L(%R)-1)_%W_$E(%L,%F,999),%F=$F(%L,%R,%F+%D) Q:%F<1
END ;
 ;%T= current tag
 ;%TG= save last/current tag
 ;%L= current line
 ;%LO= save current line for restore
