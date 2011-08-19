DIG ;SFISC/GFT-SUBTOTALS & SCATTERGRAM ;28SEP2004
 ;;22.0;VA FileMan;**2,144**;Mar 30, 1999;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 W ! I '$D(^DOSV(0,IO(0),2)) W "NO SUB-SUB TOTALS WERE RUN" Q
 N POP,IOP,ZTSK S:$D(^%ZTSK) %ZIS="QM" D ^%ZIS Q:POP
 G QUE:$D(IO("Q"))
 ;
DQ N DXMIN,DYMIN,DXMAX,DYMAX,DXI,N,NA,DYI
 S NA=$NA(^DOSV(0,IO(0)))
 S X=$O(@NA@(2,"")),(DXMIN,DXMAX)=X,(DYMIN,DYMAX)=$O(^(X,"")),X=""
 F  S X=$O(@NA@(2,X)) Q:X=""  S DXMAX=X,Y=$O(^(X,"")),DY=$O(^(""),-1) S:DYMIN>Y DYMIN=Y S:DY>DYMAX DYMAX=DY
 I DXMAX-DXMIN*(DYMAX-DYMIN)=0 D STATS(NA) Q
 ;
 ;here's the SCATTERGRAM
NUMNUM N DIGPG,DIGTYPE,%H,%T,%Y,%D,B,I,L,H,T,DIGC,X,Y,DX,DY,DXS,DYS,DXSC,DYSC
 D DIGC
 S H=DYMAX,L=DYMIN,DYS=IOSL-9,N=DYS/6
 D S(1)
 S DYMIN=B,DYSC=I/6,DYMAX=T,DYI=X
DYI I T-B/DYI*6'>DYS,DYI'<2 S DYI=DYI\2 G DYI
 S H=DXMAX,L=DXMIN,DXS=IOM-28,N=DXS/6
 D S(2)
 S DXMIN=B,DXSC=I/6,DXI=X,DXMAX=T,T=X*DXS/(T-B)
 S H=""
LOOP K ^UTILITY($J)
 S DIGTYPE="N",H=$O(@NA@("F",H)) G END:'H
 D TOP
 S (B,DX,DY)="" D  G LOOP:X'=U
I2 .S (DX,X)=$O(@NA@(2,DX)) I X="" W !?5,"(TOTAL = "_B_")",! G O
 .I DIGC(2,0)["D" D H^%DTC S X=%H
 .S X=$J(X-DXMIN/DXSC,0,0)
I3 .S (Y,DY)=$O(@NA@(2,DX,DY)) G I2:Y="" I DIGC(1,0)["D" S C=X,X=Y D H^%DTC S Y=%H,X=C
 .I $D(^(DY,H,"N")) S C=^("N"),Y=$J(Y-DYMIN/DYSC,0,0),B=B+C,^(X)=C+$G(^UTILITY($J,Y,X))
 .G I3
O .S X=0 D X W !?12,"." D P K Y S L=0 F B=DYMIN:DYI:DYMAX S Y($J(L,0,0))=$$E(B,1),L=DYI*DYS/(DYMAX-DYMIN)+L
 .W ".",! F Y=DYS:-1:0 D  W !
 ..I $D(Y(Y)) W ?12-$L(Y(Y)),Y(Y),"+"
 ..E  W ?12,"|"
 ..S X="" F  S X=$O(^UTILITY($J,Y,X)) Q:X=""  S I=^(X) W ?X+13,$S(I>9:"*",I:I,1:"")
 ..W ?DXS+14 I  W "+",Y(Y) Q
 ..W "|"
 .W ?13 D P W ! S X=DXI D X W !?22,"X-AXIS: ",$P(DIGC(2),U,3),"    Y-AXIS: ",$P(DIGC(1),U,3)
 .G EOP
END W:$E(IOST)'="C"&$Y @IOF
 K:$D(ZTSK) ^DOSV(0,IO(0))
Q D CLOSE^DIO4
 Q
 ;
X F B=DXMIN+X:DXI*2:DXMAX S Y=$$E(B,2) W ?B-DXMIN\DXSC-($L(Y)\2)+13,Y
 Q
 ;
S(C) I DIGC(C,0)["D" F B="H","L" S X=@B D H^%DTC S @B=%H
 S B=H-L,X=1 I B>1 F C=1:1 S X=X*10 Q:B'>X
 E  S I=1 Q:'B  F C=0:-1 Q:X/10'>B  S X=X/10
 S B=L-X\X*X F I=B:X/10 Q:I'<L  S B=I
 S T=H+X\X*X F I=T:-X/10 Q:I'>H  S T=I
I S I=T-B/X*10 I I>N S X=X*2 G I
 S X=X/10,I=T-B/N
 Q
 ;
 ;
 ;
STATS(NA) ;
 N DIGC,DIGB,DIGPG,RUN,DIGTYPE,DIG3,I,L,%T,H,DUOUT
 D DIGC S DIGPG=1
 I $D(@NA@(1)) D  G Q:$D(DUOUT),END
 .F H=0:0 S H=$O(@NA@("F",H)),DIGTYPE="S" Q:'H  D:$P(^(H),U,4)'["D"  S DIGTYPE="N" D  Q:$D(DUOUT)
 ..S Y="",L=0 F I=0:0 S Y=$O(@NA@(1,Y)) Q:Y=""  I $D(^(Y,H,DIGTYPE)) S:$L(^(DIGTYPE))>L L=$L(^(DIGTYPE)) S:$L($$E(Y,1))>I I=$L($$E(Y,1))
 ..I 'I!'L Q
 ..D TOP W !!?4,$P(DIGC(1),U,3),!
 ..S Y="",%T=0
 ..F  S Y=$O(@NA@(1,Y)) Q:Y=""  I $D(^(Y,H,DIGTYPE)) D  Q:$D(DUOUT)
 ...I $Y+2>IOSL D EOP Q:$D(DUOUT)  D TOP
 ...W !?4,$$E(Y,1),?I+7 S X=@NA@(1,Y,H,DIGTYPE) W $J(X,L) S %T=%T+X
 ..W !!?4,"TOTAL",?I+7,$J(%T,L) D EOP
 S DIGB=$NA(@NA@(2)) I $D(@DIGB)>9 D ALL2 G END
 S DIG3="" F  S DIG3=$O(@NA@(3,DIG3)) G END:DIG3=""!$D(DUOUT) S DIGB=$NA(@NA@(3,DIG3)) D ALL2
 ;
ALL2 F RUN=0:0 S RUN=$O(@NA@("F",RUN)) Q:'RUN  F DIGTYPE="S","N" I $P(@NA@("F",RUN),U,4)'["D"!(DIGTYPE="N") D RUN(RUN,DIGTYPE)
 Q
 ;
RUN(H,DIGTYPE) N %H,%Y,%D,T,C,X,Y,DX,DY,DXS,DYS,DXSC,DYSC
 S Y="",I=0,C=0,L=0
 F  S Y=$O(@DIGB@(Y)),X="" Q:Y=""  S DY=$$E(Y,2) S:$L(DY)>I I=$L(DY) D
 .F  S X=$O(@DIGB@(Y,X)) Q:X=""  I $D(^(X,H,DIGTYPE)) S:'$D(X(X)) C=C+1 S DX=$$E(X,1) S:$L(DX)>L L=$L(DX) S X(X)=""
 ;I=width of left column
 ;L=width of data columns
 ;C=number of data columns
 I 'C Q
 S Y=L+2*C+I+13
 I Y>IOM U IO(0) W !,"MARGIN WIDTH OF ",IOM," IS TOO SMALL FOR DISPLAY",!,"USE WIDTH OF AT LEAST ",Y Q
 S I=I+3,L=IOM-13-I\C ;make columns wide
 D TOP,SUBTOP
 S Y=""
 F  S Y=$O(@DIGB@(Y)) Q:Y=""  D  G Q:$D(DUOUT)
 .I $Y+2>IOSL D  Q:$D(DUOUT)  D TOP,SUBTOP
 ..N X D EOP
 .N T S X="" W !!?4,$$E(Y,2),?I+6
 .F N=0:1 S X=$O(X(X)) Q:X=""  S %T=$G(@DIGB@(Y,X,H,DIGTYPE)) W $J(+%T,L) S T=$G(T)+%T,DX(X)=$G(DX(X))+%T
 .W $J(T,7)
 S X="  ----------------------------------------------------"
 W !!?I+6 F N=1:1:N W $E(X,1,L)
 W $E(X,1,IOM-$X)
 W !!,"    TOTALS",?I+6 S (%T,X)="" F N=0:1 S X=$O(X(X)) Q:X=""  W $J(DX(X),L) S %T=%T+DX(X)
 W $J(%T,7)
EOP ;
 I $G(IOST)?1"C".E D
 .N DIR,X,Y
 .S DIR(0)="E" D ^DIR
 Q
 ;
TOP N X,Y
 U IO W:$Y @IOF
 S X=@NA@("F",H)
 W !,"    ",$O(^DD(+X,0,"NM",0))," FILE: "
 W $S(DIGTYPE="N":"COUNTS",1:"SUMS")
 I $P(X,U,2)'=.01 W " OF '",$P(X,U,3),"'"
 S Y=DT X ^DD("DD")
 I $G(DIGPG) S Y=Y_"    Page "_DIGPG,DIGPG=DIGPG+1
 W ?IOM-$L(Y)-1,Y Q
 ;
SUBTOP N Y
 I $D(DIG3) W !!?4,$P(DIGC(3),U,3),": ",$$E(DIG3,3),!
 S Y=$P(DIGC(2),U,3) F X=1:1:$L(Y," ") W !?4,$P(Y," ",X)
 S Y=$P(DIGC(1),U,3) W ?(IOM-I-$L(Y)\2+I+4),Y,!!
 W ?I+6 S X="" F  S X=$O(X(X)) Q:X=""  W $J($$E(X,1),L)
 W "  TOTAL"
 W ! F Y=1:1:IOM W "-"
 Q
 ;
DIGC N X,C
 S (X,C)="" F  S X=$O(@NA@("BY",X),-1) Q:'X  D
 .S C=C+1,DIGC(C)=^(X)
 .S DIGC(C,0)=$S($D(^DD(+DIGC(C),+$P(DIGC(C),U,2),0)):$P(^(0),U,2),1:$P(DIGC(C),U,7))
 Q
 ;
E(VALUE,XY) ;2=Y,1=X
 N %DT,Y
 I $P(DIGC(XY),U,4)["-" S VALUE=-VALUE
 I DIGC(XY,0)["O" Q VALUE
 I VALUE,DIGC(XY,0)["D" S Y=VALUE D DD^%DT Q Y
 I DIGC(XY,0)["S" S Y=$P(DIGC(XY),U,2) S:'Y Y=$P($P(DIGC(XY),U,4),"+""",2) S:Y Y=$$EXTERNAL^DILFD(+DIGC(XY),Y,,VALUE,"%DT(0)") I Y]"" Q Y
 Q VALUE
 ;
P S L=-1,X=0
PP I L<X W "+" S L=L+T
 E  W "-"
 S X=X+1 G PP:X'>DXS Q
 ;
 ;
QUE ;
 S ZTSAVE("^DOSV(0,$I,")=""
 S ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL,ZTRTN="DQ^DIG"
 D ^%ZTLOAD K ZTSK G END
