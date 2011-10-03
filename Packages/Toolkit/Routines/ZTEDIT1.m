ZTEDIT1 ;SF/RWF - VA EDITOR edit single lines ;10/5/89  09:53 ;
 ;;7.3;TOOLKIT;**16,120**;Apr 25, 1995
 F %J=1:1 S %A=$T(%+%J),%T=$P(%A," ",1),%B=$P(%A," ",2,256) Q:%T="END"  I $L(%T) S ^%Z(%T)=%B
 G ^ZTEDIT2
 Q
% ;
GLO S %NX="what" W:%X="^"&$D(%GLO) $E(%GLO,2,99) S:%X="^"&$D(%GLO) %X=%GLO I (%X?1.2P1.8AN)!(%X?1.2P1.8AN1"(".E1")"),$D(@%X)#2 S %GLO=%X,%T=%X,%L=@%X X ^%Z("EDITLINE") S @%GLO=%L,%NX=1
REMOVE W "emove lines: " X ^%Z("SELECT") S %NX="what" Q:%POP  R !,"OK to remove lines? ",%R:%9 S %NX=$S(%R?1"Y".E:"R10",%R?1"y".E:"R10",1:"R5")
R5 S %NX=1 W " [no change]",!
R10 S %NX=1 ZR +%A:+%I W " ...deleted lines",!
what W " what?" S %NX=1
what2 W " ??? Just the first letter please. " S %NX="ACTION"
EDXY S %N="E1",X=0 X ^%ZOSF("RM"),^%ZOSF("EOFF") F %IED=0:0 X ^%Z(%N) Q:'$D(%N)
EXY X ^%Z("EW2"),^%Z("ELONG"):$L(%L)>245 S %N="E1" Q:$L(%L)>255  X ^%ZOSF("EON") S DX=0,DY=%EY,X=%RM+1 X ^%ZOSF("RM"),XY K %EX,%EY,%E1,%E2,DX,DY,%N Q
E1 S DX=0,DY=%SL,%A=1,%N="E2" W !!!! X ^%Z("EWL"),^%Z("EW1")
E2 S DX=%A-1#%RM,DY=%A-1\%RM+%SL,%EX=$L(%L)#%RM,%EY=$L(%L)\%RM+%SL,%N="E3"
E3 S %N="E4" X:DX'<%RM ^%Z("ER") X XY
 ;E,EE;<bs>,EB;<cr>,EOL;<advance past eol>,E4;<space>,ES;'.',EP;<rub>,ERUB;D,EDEL;^R,EUD;>,;<,;
E4 R *%X:%9 S %X=$S($C(%X)?1L:%X-32,1:%X),%N=$S(%X=69:"EE",%X=8:"EB",%X=13!(%X=27):"EOL",%A>$L(%L):"E4",%X=32:"ES",%X=46:"EP",%X=127:"ERUB",%X=68:"EDEL",%X=18:"EUD",%X=62:"EL",1:"E4")
EL S %N="E3",%A=$S(%A+%RM'>$L(%L):%A+%RM,1:$L(%L)+1),DX=%A-1#%RM,DY=%A\%RM+%SL
EP S %A=%A+1,DX=DX+1,%N="E3"
ES S %N="E3" F %IED=%A:1:$L(%L) S %A=%A+1,DX=DX+1 Q:$E(%L,%A)=" "!($E(%L,%A)=",")
EB S %N="E3" Q:%A=1  S DX=DX-1,%A=%A-1 I DX=-1 S DX=%RM-1,DY=DY-1
ERUB S %IED=%A+1,%N="EDEL2"
EDEL2 S %N="E4",%E1=$L(%L),%L=$E(%L,1,%A-1)_$E(%L,%IED,999),%E2=$L(%L),%L=%L_$J("",%E1-%E2) X ^%Z("EWL") S %L=$E(%L,1,%E2) X XY
EDEL S %N="EDEL2" F %IED=%A+1:1 S %E=$E(%L,%IED) Q:%E=" "!(%E="")!(%E=",")
EE S %C=%A,%B=$E(%L,%A,999),%Y="",%D=0,%N="EEN"
EEN X XY R *%X:%9 S %N=$S(%X=127&%D:"EER",%X=13!(%X=27):"EEE",$C(%X)?1C:"EEN",1:"EE1")
EE1 W $C(%X) S DX=DX+1,%D=%D+1,%Y=%Y_$C(%X) X:DX'<%RM ^%Z("ERE") X ^%Z("EWL") X XY S %N="EEN"
EE4 S:$Y=%EY&(%EX<$X) %EX=$X S %D=%D+1,%Y=%Y_$C(%X),%N="EEN" X XY
EEE S %L=$E(%L,1,%A-1)_%Y_$E(%L,%C,999),%N="E2",%A=%A+$L(%Y) X ^%Z("EW2") I $X>%EX,DY=%EY S %EX=$S(%RM>$X:$X,1:%RM)
EER S %D=%D-1,%Y=$E(%Y,1,%D),%N=$S(DX:"EER1",1:"EER2")
EER1 S DX=DX-1,%N="EEN" X ^%Z("EWL") W " "
EER2 S DX=%RM-1,DY=DY-1,%N="EEN" X ^%Z("EWL") W !," " X XY
ER S DX=DX#%RM,DY=DY+1 X XY
ELONG W !,*7,"  Line too long for programming standard (",$L(%L),") ",!!! S %N="E1"
EOL S %N=$S(%A=1:"EXY",1:"E2"),%A=1
EUD S %L=%LO,%N="E1"
ERE S DX=0,DY=DY+1 X XY
EWL X XY S %EX=%A,%EY=%RM-DX-1+%A,%=DY-%SL+1 F %=%:1:4 W $E(%L,%EX,%EY) S %EX=%EY+1,%EY=%EY+%RM Q:%EX>$L(%L)  W:%<4 !
EW1 S %SX=DX,%SY=DY,DX=0,DY=%SL-1 X XY W "Length: ",$J($L(%L),3) W:$D(%T) "    Line: ",%T,"        " S DX=%SX,DY=%SY X XY
EW2 S %SX=DX,%SY=DY,DX=8,DY=%SL-1 X XY W $J($L(%L),3) S DX=%SX,DY=%SY X XY
EDITLINE W:XY="" !,%L,! X $S(XY]"":^%Z("EDXY"),1:^%Z("ED")) W:XY="" !,%L
EDIT S %T=%X,%NX="what" X ^%Z("TAG") Q:%L=""  S %NX=1 W:%X'=%T " ",%T S %TG=%T,%LO=%L X ^%Z("EDITLINE") S %NX="STORE"
ED F %IED=0:0 R " r ",%R:%9 Q:%R=""  X ^%Z($S(%R="END":"ED16",%L[%R:"ED14",%R["...":"ED20",%R=$C(18):"ED15",1:"ED17"))
ED14 R " w ",%W:%9 S %L=$P(%L,%R,1)_%W_$P(%L,%R,2,999)
ED15 S %L=%LO W !,"Line restored",!,%L,!
ED16 R " w ",%W:%9 S %L=%L_%W
ED17 W " ???"
ED20 S %A=$P(%R,"...",1),%B=$P(%R,"...",2,999),%J=$F(%L,%A),%C=%J-1-$L(%A),%D=$S(%B="":999,1:$F(%L,%B,%J)) W:%C<0!(%D<1) " ???" Q:%C<0!(%D<1)  R " w ",%W:%9 S %L=$E(%L,1,%C)_%W_$E(%L,%D,999)
END ;
