XTFCE1 ;SF-ISC.SEA/JLI - DISPLAY FLOWCHARTS BY ENTRY POINT ;12/7/95  14:49
 ;;7.3;TOOLKIT;**8**;Apr 25, 1995
 W @IOF
 S XTZX1="",XTSLINE=0,XTREF=0,XT="",XTZX1="" F Z=0:0 S Z=$O(^TMP($J,XTLEV,"FC",Z)) D:Z'>0 WAIT Q:+Z'=Z!(XT=U)  I Z>0 S XTZX=$O(^TMP($J,XTLEV,"FC",Z,"")) D LIST Q:XT=U
 Q
 ;
LIST ;
 S N=60,X=^TMP($J,XTLEV,"FC",Z,XTZX) F XTZA=0:0 S Y=$E(X,1,4) Q:Y'="    "&(Y'="....")  S X=$E(X,5,$L(X)),N=N-10 S:N<1 N=1
 I $E(X,1)="{"!($E(X,1)="[") S XTL=$E(X,3,$L(X)-2) I '$D(^TMP($J,XTLEV,"C",$P(XTL,"("))) S XTREF=XTREF+1,^($P(XTL,"("),XTREF)="",^TMP($J,XTLEV,"X",XTREF)=$P(XTL,"(")
 S:'$D(LN) LN=N D:LN<N CLOSE K NX F NX=N:10:60 S:'$D(NX(NX+10)) NX(NX)="" S:NX<60 NX(NX+20)=""
 I XTZX1'="PROC "!(XTZX'="PROC ") W ! I LN'=N!(XTZX1'="GOTO "&(XTZX1'="QUIT ")) F NX=0:0 S NX=$O(NX(NX)) Q:NX=""  W ?NX,"|"
 S LN=N,N=$S(XTZX="LABEL":N-$L(X),1:N-($L(X)\2))
 D:$Y+5+(XTREF+1\2)>IOSL WAIT Q:XT=U  W !,?N,X S XTZX1=XTZX
 F NX=0:0 S NX=$O(NX(NX)) Q:NX=""  I $X<(NX-1) W ?NX,"|"
 Q
 ;
WAIT ; Skip to top of next page
 F K=1:1:4 Q:($Y+4+(XTREF+1\2))'<IOSL  W !
 I XTREF>0 W !,"The following references may be selected for expansion..."
 I XTREF>0 F JK=1:1:(XTREF+1\2) W !?5,$J(JK,2),".  ",^TMP($J,XTLEV,"X",JK) S JL=JK+(XTREF+1\2) I JL'>XTREF W ?30,$J(JL,2),".  ",^(JL)
 I XTREF>0 W !?16,"Select LINE^ROUTINE to expand (1 to ",XTREF," ) or"
 I 1 S XT="" R:IOST["C-" !?16,"Press RETURN to continue, '^' to halt: ",XT:DTIME S:'$T XT=U
 I XT>0&(XT'>XTREF) S XTSLINE(XTLEV)=XTSLINE,XTZX1(XTLEV)=XTZX1,XTLINE=^TMP($J,XTLEV,"X",+XT),XTROU=$P(XTLINE,U,2),XTLINE=$P(XTLINE,U,1),XTLEV=XTLEV+1
 I XT>0&(XT'>XTREF) D NODE^XTFCE S XTLINE=XTLINE(XTLEV),XTROU=XTROU(XTLEV),Z=XTSLINE(XTLEV),XTZX1=XTZX1(XTLEV)
 S XTZX1=XTZX1,XTSLINE=Z W @IOF
 S XTREF=0 K ^TMP($J,XTLEV,"C"),^("X")
 Q
 ;
CLOSE ; Close previous nesting level
 S IX1=$S(LN>1:LN,1:0),IX2=IX1+19 S:XTZX1="GOTO "!(XTZX1="QUIT ") IX1=IX1+10 W ! W:IX1'>LN ?IX1,"|" W:IX1>LN ?IX1 F IX3=0:0 Q:($X'<(IX2+1))  W "_"
 W "|" F NX=-1:0 S NX=$O(NX(NX)) Q:NX=""  I $X<(NX-1) W ?NX,"|"
 S LN=$S(LN>1:LN,1:0)+10 I LN<N S XTZX1=" " G CLOSE
 S LN=LN-1
 Q
