%ZIS5 ;SFISC/STAFF --DEVICE LOOK-UP ;08/30/2011
 ;;8.0;KERNEL;**18,24,69,499,518,546,572**;JUL 10, 1995;Build 7
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;Does a DIC like lookup. %XX,%YY are call in/out parameters
 N %DO,%DIY,%DD,%DIX
 S U="^",%DO="" K DUOUT
 I $D(^%ZIS(%ZISDFN,0)) S %DO=^(0)
A G:%ZIS(0)'["A" X
 ;Ask Device
 I $D(%ZIS("A")) S %DD=%ZIS("A") G B
 S %DD="Select "_$P(%DO,U,1)_": "
B I $D(%ZIS("B")),%ZIS("B")]"" S %YY=%ZIS("B"),%XX=$O(^%ZIS(%ZISDFN,%D,%YY)),%DIY=$S($F(%XX,%YY)-1=$L(%YY):%XX,$D(^%ZIS(%ZISDFN,%YY,0)):$P(^(0),U,1),1:%YY) W %DD,%DIY,"// " R %XX:%ZISDTIM G G:%XX]"" S %XX=%DIY G G
 W !,%DD R %XX:%ZISDTIM
G G NO:'$T,NO:%XX["^" G:%XX?.N&(+%XX=%XX) NUM I %XX'?.ANP!($L(%XX)>30) W:%ZIS(0)["Q" *7," ??" G A
 ;Lookup
X ;**P572 START CJM
 ;I %XX=" ",$D(DUZ)#2,$D(^DISV(+DUZ,"^%ZIS("_%ZISDFN_",")) S %YY=+^("^%ZIS("_%ZISDFN_",") D S G:'$T NO G GOT
 I %XX=" ",$D(DUZ)#2,$D(^DISV(+DUZ,"ZIS","^%ZIS("_%ZISDFN_","))!$D(^DISV(+DUZ,"^%ZIS("_%ZISDFN_",")) D  D S G:'$T NO G GOT
 .S %YY=$S($D(^DISV(+DUZ,"ZIS","^%ZIS("_%ZISDFN_",")):+^("^%ZIS("_%ZISDFN_","),1:^DISV(+DUZ,"^%ZIS("_%ZISDFN_","))
 ;**P572 END CJM
F G NO:%XX="" K %DS S %DS=0,%DS(0)=1,%DIX=%XX,%DIY=0
 I $D(^%ZIS(%ZISDFN,%D,%XX)) G T1
TRY S %DIX=$O(^%ZIS(%ZISDFN,%D,%DIX)) G:$P(%DIX,%XX,1)'=""!(%DIX="") T2 S %DIY=0
T1 S %DIY=$O(^%ZIS(%ZISDFN,%D,%DIX,+%DIY)) G:%DIY'>0 TRY S %YY=+%DIY D S G:'$T T1
 I %DS,'(%DS#10) D LST G NO:%XX=U,ADD:%YY<0,GOT:%YY>0
 S %DS=%DS+1,%DS(%DS)=%DIY G T1
LSYN ;
S I $D(^%ZIS(%ZISDFN,%YY,0)) G S1
 Q
S1 G S2:%ZISDFN'=1!(%D'="LSYN") I $P(^%ZIS(1,%YY,0),U,9)=%ZISV!($P(^(0),U,9)="") G S2
 Q
S2 N Y S Y=%YY D:$D(%ZIS("S")) XS^ZISX Q
T2 G:'%DS NO S %DIY="" D LST G NO:%XX=U,ADD:%YY<1,GOT
LST I %DS=1,'$D(%ZISLST) S %YY=%DS(1) Q
 S %YY=-1 Q:%ZIS(0)'["E"  W !
 F %DZ=%DS(0):1:%DS W !,$J(%DZ,2)," ",$P(^%ZIS(%ZISDFN,%DS(%DZ),0),U,1) D:%ZISDFN=1  I $D(%ZIS("W")),$D(^(0)) W "  " D XW^ZISX
 . ;Show Location
 . S %=$G(^(1)) W:$X+$L($P(%,U))>74 !?75-$L(X) W "   "_$P(%,U)
L1 W:%DIY !,"Type '^' to Stop, or" W !,"Choose 1" W:%DS>1 "-",%DS
 R "> ",%YY:%ZISDTIM S %ZISLST=1 I %YY="",%DIY S %DS(0)=%DS+1,%YY=0 W ! Q
 I %YY=U!(%YY="") S %YY=-1,DUOUT=1 S:%YY=U %XX=U Q
 I +%YY'=%YY!(%YY<1)!(%YY>%DS) W:%ZIS(0)["Q" *7," ??" G L1
 S %YY=%DS(%YY) Q
GOT S %DZ=^%ZIS(%ZISDFN,+%YY,0)
 W:%ZIS(0)["E" "  ",$P(%DZ,U,1)
 ;**P572 START CJM
R ;
 ;I %ZIS(0)'["F" S:$S($D(DUZ)#2:$S(DUZ:1,1:0),1:0) ^DISV(DUZ,"^%ZIS("_%ZISDFN_",")=+%YY
 I %ZIS(0)'["F" I '$D(IOP),$S($D(DUZ)#2:$S(DUZ:1,1:0),1:0) S ^DISV(DUZ,"ZIS","^%ZIS("_%ZISDFN_",")=+%YY
 ;**P572 END CJM
 ;
 I %ZIS(0)["Z" S %YY(0)=^%ZIS(%ZISDFN,+%YY,0)
Q K %ZISDFN,%DO,%DD,%DIX,%DIY,%DZ Q
ADD ;can't add to files
NO S %YY=-1 G Q
NUM I $D(^%ZIS(%ZISDFN,%XX)) S %YY=%XX D S I $T G GOT
 G F
 ;
1 ;Entry point for Device lookup
 N %D,%DS,%ZISDFN,%ZISLST ;p518
 F %D="B","LSYN" S %ZISDFN=1,%ZIS(0)=$S($D(IOP):"M",1:"EMQ") D %ZIS5 Q:(%YY>0)!$D(DUOUT)
 Q
2 ;Entry point for Terminal type lookup
 N %D,%DS,%ZISDFN,%ZISLST ;p518
 S %D="B",%ZISDFN=2,%ZIS(0)=$S($D(IOP):"M",1:"EMQ") D %ZIS5
 Q
 ;
 ;A=all printers, P=local printers, C=complete list, D=local devices
LD1 ;Called from %ZIS7
 S %E=0,%Y=0 D LCPU:"PD"[$E(%X) S %E=0 W !
L S %E=$S("PD"[$E(%X):$O(^UTILITY("ZIS",$J,"DEVLST","B",%E)),1:$O(^%ZIS(1,"B",%E))) G:%E="" RESTART S %A=+$O(^(%E,0))
 G L:'$D(^%ZIS(1,%A,0)) ;,L:$P(^(0),"^",2)=46,L:$P(^(0),"^",2)=63 p546 Skip check for device numbers
 I $D(%ZIS("S")) N Y S Y=%A D XS^ZISX G L:'$T ;Screen
 I "AP"[$E(%X) G L:$P($G(^%ZIS(2,+$G(^%ZIS(1,%A,"SUBTYPE")),0)),U)'?1"P".E
 W $P(^%ZIS(1,%A,0),"^",1) W:$D(^(1)) " ",$P(^(1),"^",1) I $D(^(90)),^(90) W " ** OUT OF SERVICE"
 W ?39 I $X>40 W ! S %Y=%Y+1 I %Y>20 R "'^' TO STOP: ",%Y:%ZISDTIM,! G RESTART:%Y?1P S %Y=0
 G L
 ;
LCPU S %A=%ZISV
LC1 S %A=$O(^%ZIS(1,"CPU",%A)) Q:$P(%A,".")'=%ZISV  S %E=0
LC2 S %E=+$O(^%ZIS(1,"CPU",%A,%E)) G LC1:%E'>0,LC1:'$D(^%ZIS(1,%E,0)) S ^UTILITY("ZIS",$J,"DEVLST","B",$P(^(0),"^",1),%E)="" G LC2
 ;
RESTART S:$D(%H) %E=+%H K %X,^UTILITY("ZIS",$J,"DEVLST")
 Q
