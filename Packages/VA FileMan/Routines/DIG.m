DIG ;SFISC/GFT SUBTOTALS & SCATTERGRAM ;31MAY2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**2,144,1002,1003,1004,1005,1043**
 ;
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
 D TOP(H)
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
STATS(NA,DELIM) ;CROSS-TABS
 N DIGC,DIGB,DIGPG,DIGCOL,DIGSUB,RUN,DIGTYPE,DIG3,I,LT,L,%T,H,DUOUT
 D DIGC S DIGPG=1
1 I $D(@NA@(1)) D  G Q:$D(DUOUT),END
 .F H=0:0 S H=$O(@NA@("F",H)),DIGTYPE="S" Q:'H  D:$P(^(H),U,4)'["D"  S DIGTYPE="N" D  Q:$D(DUOUT)
 ..S Y="",L=0 F I=0:0 S Y=$O(@NA@(1,Y)) Q:Y=""  I $D(^(Y,H,DIGTYPE)) S:$L(^(DIGTYPE))>L L=$L(^(DIGTYPE)) S:$L($$E(Y,1))>I I=$L($$E(Y,1))
 ..I 'I!'L Q
 ..D TOP(H) W !! D TAB(4) W $$CAPT(1),!
 ..S Y="",%T=0
 ..F  S Y=$O(@NA@(1,Y)) Q:Y=""  I $D(^(Y,H,DIGTYPE)) D  Q:$D(DUOUT)
 ...I $Y+2>IOSL D EOP Q:$D(DUOUT)  D TOP(H)
 ...W ! D TAB(4) W $$E(Y,1) D TAB(I+7) S X=@NA@(1,Y,H,DIGTYPE) W $$J(X,L) S %T=%T+X
 ..W !! D TAB(4) W "TOTAL" D TAB(I+7) W $$J(%T,L) D EOP
2 S DIGB=$NA(@NA@(2)) I $D(@DIGB)>9 D ALL2 G END
3 N A,B,C,D,E,NAT ;We had 3 levels of subtotalling, so we build a NAT matrix of TOTALS
 S NAT=$NA(^TMP("DIG",$J,0)) K ^TMP("DIG",$J) F A="F","HD","SHD" M ^TMP("DIG",$J,A)=@NA@(A)
 S A="" F  S A=$O(@NA@(3,A)),B="" Q:A=""  F  S B=$O(@NA@(3,A,B)),C="" Q:B=""  F  S C=$O(@NA@(3,A,B,C)),D="" Q:C=""  F  S D=$O(@NA@(3,A,B,C,D)),E="" Q:D=""  F  S E=$O(@NA@(3,A,B,C,D,E)) Q:E=""  D
 .S ^(E)=^(E)+$G(@NAT@(B,C,D,E)) ;SUM OVER ALL OF THEM
 F RUN=0:0 S RUN=$O(@NA@("F",RUN)) Q:'RUN  F DIGTYPE="S","N" D:$$PAR(NAT,RUN,DIGTYPE)  G END:$D(DUOUT)
 .F X="DIGCOL","DIGSUB","I","L","LT","C" M DIG3(RUN,DIGTYPE,X)=@X
 S DIG3="" F  S DIG3=$O(@NA@(3,DIG3)) Q:DIG3=""  S DIGB=$NA(@NA@(3,DIG3)) D ALL2 G END:$D(DUOUT)
 S NA=$NA(^TMP("DIG",$J)),DIG3="**ALL**",DIGB=NAT D ALL2 ;print grand totals
 G END
 ;
ALL2 F RUN=0:0 S RUN=$O(@NA@("F",RUN)) Q:'RUN  F DIGTYPE="S","N" I $P(@NA@("F",RUN),U,4)'["D"!(DIGTYPE="N") D RUN(RUN,DIGTYPE) Q:$D(DUOUT)  ;don't try to sum dates
 Q
 ;
RUN(RUN,DIGTYPE) N %H,%Y,%D,T,C,X,Y,DX,DXS,DYS,DXSC,DYSC,DIGCOL
 I $D(DIG3) Q:'$D(DIG3(RUN,DIGTYPE))  F X="DIGSUB","DIGCOL","C","L","LT","I" M @X=DIG3(RUN,DIGTYPE,X)
 E  Q:'$$PAR(DIGB,RUN,DIGTYPE)  ;If 3-level, we have already set up PARameters
 D TOP(RUN),SUBTOP
 M @DIGB@($C(127)_"EMPTY")=@DIGB@("  EMPTY") K @DIGB@("  EMPTY")
 S Y=""
 F  S Y=$O(@DIGB@(Y)) Q:Y=""  D  G Q:$D(DUOUT) ;loop writes one output line
 .I $Y+2>IOSL D  Q:$D(DUOUT)  D TOP(RUN),SUBTOP
 ..D EOP
 .N T S X="" W !! D TAB(1) W $$E(Y,2) D TAB(I+5) ;write row caption
 .F N=0:1 S X=$O(DIGCOL(X)) Q:X=""  S %T=$G(@DIGB@(Y,X,RUN,DIGTYPE)) W $$J(+%T,L) S T=$G(T)+%T,DX(X)=$G(DX(X))+%T
 .W $$J(T,LT)
 S X="  "_$TR($J("",IOM\2)," ","-") ;THE UNDERLINE
 I '$D(DELIM) W !! D TAB(I+5) F N=N:-1 W $E(X,1,L) I N=1 W $E(X,1,LT) Q
 W !! D TAB(1) W "TOTALS" D TAB(I+5) S (%T,X)="" F N=0:1 S X=$O(DIGCOL(X)) Q:X=""  W $$J(DX(X),L) S %T=%T+DX(X)
 W $$J(%T,LT)
EOP ;
 W !! I $G(IOST)?1"C".E D
 .N DIR,X,Y
 .S DIR(0)="E" D ^DIR
 Q
 ;
PAR(DIGB,RUN,DIGTYPE)  ;DIGB=NAME OF ARRAY  Sets up DIGCOL array, and:
 ;I=width of left column
 ;L=width of data columns
 ;LT=width of TOTAL column 
 ;C=number of data columns
 N Y,DY,DX,%,S
 K DIGCOL,DIGSUB
 S Y="",I=0,C=0,L=0
 F  S Y=$O(@DIGB@(Y)),X="" Q:Y=""  S DY=$$E(Y,2) S:$L(DY)>I I=$L(DY) D
 .F  S X=$O(@DIGB@(Y,X)) Q:X=""  I $D(^(X,RUN,DIGTYPE)) S:$L(^(DIGTYPE))>L L=$L(^(DIGTYPE)) D:'$D(DIGCOL(X))
 ..S C=C+1,DIGCOL(X)="",DX=$$E(X,1),%=0 F  Q:DX=""  S S=$P(DX," "),DX=$P(DX," ",2,99) I S]"" S %=%+1,DIGSUB(%,X)=S S:$L(S)>L L=$L(S)
 I 'C Q 0
 S X="" F  S X=$O(DIGCOL(X)) Q:X=""  F Y=$O(DIGSUB(""),-1):-1:2 I $G(DIGSUB(Y,X))?." " S DIGSUB(Y,X)=$G(DIGSUB(Y-1,X)) K DIGSUB(Y-1,X)
 S Y=L*C+I+13
 I Y>IOM,'$D(DELIM) U $P W !,"MARGIN WIDTH OF ",IOM," IS TOO SMALL FOR DISPLAY",!,"USE WIDTH OF AT LEAST ",Y H 1 S DUOUT=1 Q 0
 S LT=8 F Y=Y+C+1:C+1:IOM S LT=LT+1,L=L+1
 I Y+3<IOM S I=I+3
 Q 1
 ;
TOP(H) N X,Y,DC
 U IO W:$Y @IOF
 S DC=$G(DIGPG) I $D(@NA@("HD")) D
 .X ^("HD") W !!
 E  D
 .S X=@NA@("F",H)
 .W !,"    ",$O(^DD(+X,0,"NM",0))," FILE: "
 .W $S(DIGTYPE="N":"COUNTS",1:"SUMS")
 .I $P(X,U,2)'=.01,$P(X,U,3)]"" W " OF '",$P(X,U,3),"'"
 .S Y=DT X ^DD("DD")
 .I $G(DIGPG) S Y=Y_"    Page "_DIGPG
 .W ?IOM-$L(Y)-1,Y
SHD I $D(@NA@("SHD")) W !,?IOM-$L(^("SHD"))\2,^("SHD")
 S:$G(DIGPG) DIGPG=DIGPG+1
 Q
 ;
SUBTOP N Y
 I $D(DIG3) W !!?1,$$CAPT(3),": ",$$E(DIG3,3),!
 S Y=$$CAPT(2) F X=1:1:$L(Y," ") W !?2,$P(Y," ",X)
 S Y=$$CAPT(1) W ?(IOM-I-LT-$L(Y)\2+I+4),Y,!
 F Y=1:1 Q:'$D(DIGSUB(Y))  W ! D TAB(I+5) S X="" F  S X=$O(DIGCOL(X)) Q:X=""  W $$J($G(DIGSUB(Y,X)),L)
 ;W " " D TAB(I+5) S X="" F  S X=$O(DIGCOL(X)) Q:X=""  W $$J($$E(X,1),L)
 W $$J("TOTAL",LT)
 I '$D(DELIM) W ! F Y=1:1:IOM W "-"
 Q
 ;
CAPT(N) N F S N=DIGC(N),F=$P(N,U,5) I F[";""" Q $P(F,"""",2)
 Q $P(N,U,3)
 ;
TAB(N) I $D(DELIM) W:$X DELIM Q
 W ?N Q
 ;
J(VALUE,SPACE) I $D(DELIM) Q $TR(VALUE,DELIM)_DELIM
 Q $J(VALUE,SPACE) Q
 ;
DIGC N X,C
 S (X,C)="" F  S X=$O(@NA@("BY",X),-1) Q:'X  D
 .S C=C+1,DIGC(C)=^(X)
 .S DIGC(C,0)=$S($D(^DD(+DIGC(C),+$P(DIGC(C),U,2),0)):$P(^(0),U,2),1:$P(DIGC(C),U,7))
 Q
 ;
E(VALUE,XY) ;2=Y,1=X
 I XY=2,$A(VALUE)=127 S $E(VALUE)="" ;so length isn't thrown off by non-printing char
 Q $TR($$EE,$G(DELIM))
 ;
EE() N %DT,Y
 I $P(DIGC(XY),U,4)["-" S VALUE=-VALUE
 I VALUE,DIGC(XY,0)["D" Q $$DATE^DIUTL(VALUE)
 I DIGC(XY,0)["O" Q VALUE
 I DIGC(XY,0)["S" S Y=$P(DIGC(XY),U,2) S:'Y Y=$P($P(DIGC(XY),U,4),"+""",2) S:Y Y=$$SET^DIQ(+DIGC(XY),Y,VALUE) Q Y
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
