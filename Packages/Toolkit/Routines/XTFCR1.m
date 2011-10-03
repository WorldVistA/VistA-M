XTFCR1 ;SF-ISC.SEA/JLI - DISPLAY FLOWCHART ;9/21/93  09:58 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
 W @IOF
 K LN S XT="",XTZX1="" F Z=0:0 S Z=$O(^TMP($J,XTLEV,"FC",Z)) Q:Z'>0  S XTZX=$O(^TMP($J,XTLEV,"FC",Z,"")) D LIST Q:XT=U
 I XT'=U D WAIT
 Q
 ;
LIST ;
 S N=$S(IOM<80:80,1:IOM)\2+20,X=^TMP($J,XTLEV,"FC",Z,XTZX) S:'$D(LN) LN=N F XTZA=0:0 S Y=$E(X,1,4) Q:Y'="    "&(Y'="....")  S X=$E(X,5,$L(X)),N=N-10 S:N<1 N=1
 D:N>LN CLOSE K NX S NX=$S(N>1:N,1:0) F NX=NX:10:($S(IOM<80:80,1:IOM)\2+20) S:'$D(NX(NX+10)) NX(NX)="" S:NX<($S(IOM<80:80,1:IOM)\2+20) NX(NX+20)=""
 I XTZX1'="PROC "!(XTZX'="PROC ") W ! I LN'=N!(XTZX1'="GOTO "&(XTZX1'="QUIT ")) F NX=-1:0 S NX=$O(NX(NX)) Q:NX=""  W ?NX,"|"
 S LN=N,N=$S(XTZX="LABEL":N-$L(X),1:N-($L(X)\2))
 D:$Y+3>IOSL WAIT Q:XT=U  W !,?N,X S XTZX1=XTZX
 F NX=0:0 S NX=$O(NX(NX)) Q:NX=""  I NX>($X+1) W ?NX,"|"
 Q
 ;
WAIT ; Skip to top of next page
 I IOST["C-" F K=1:1:4 Q:$Y+3'<IOSL  W !
 I 1 S XT="" R:IOST["C-" !?26,"Press RETURN to continue, '^' to halt...",XT:DTIME S:'$T XT=U W @IOF
 Q
CLOSE ; Close previous nesting level
 S IX1=$S(LN>1:LN,1:0),IX2=IX1+19 S:XTZX1="GOTO "!(XTZX1="QUIT ") IX1=IX1+10 W ! W:IX1'>LN ?IX1,"|" W:IX1>LN ?IX1 F IX3=0:0 Q:($X'<(IX2+1))  W "_"
 W "|" F NX=-1:0 S NX=$O(NX(NX)) Q:NX=""  I $X<(NX-1) W ?NX,"|"
 S LN=$S(LN>1:LN,1:0)+10 I LN<N S XTZX1=" " G CLOSE
 S LN=LN-1 Q
