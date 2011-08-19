XQORM1 ; SLC/KCM - Display selections & prompt ;12/22/93  14:43
 ;;8.0;KERNEL;;Jul 10, 1995
DISP ;From: XQORM
 N L,M,N,T
 I $E(X)="?" W ! S (DX,DY)=0 X ^%ZOSF("XY")
 S T=1 S:$D(^XUTL("XQORM",XQORM,"COL")) T=^("COL") S:'T T=1 S T=IOM\T
 S M=5 I $D(XQORM("M")),+XQORM("M"),XQORM("M")'>T S M=XQORM("M")
 N X S L=0 F I=0:0 S I=$O(^XUTL("XQORM",XQORM,I)) Q:I'>0  I $D(^(I,0)) S X=^(0),J=($P(I,".",2)-1)*T D:$P(I,".")>L RD Q:N  D
 . D:$D(XQORM("S")) SCRN
 . W ?(J),$P(X,"^",4),?(J+M)
 . I '$D(XQORM("W")) W $P(X,"^",3)
 . E  X XQORM("W")
 . S L=$P(I,".")
 Q
SCRN Q:$D(XQORM("S"))[0  Q:'$L(XQORM("S"))  Q:'+X  D SCRN1
 Q:$T  S $P(X,"^",3)="("_$P(X,"^",3)_")"
 Q
SCRN1 N DA S DA=+X,DA(1)=+XQORM N I,J,L,M,T,X,Y X XQORM("S") Q
PRMT ;From: XQORM
 S ORUPRMT=$S($D(XQORM("A"))[0:"Select Item(s): ",1:XQORM("A"))
 F ORU=0:0 D PRMT1 I Y D:(X'=" ")&(X?.ANP) EAT S:X="^^" DIROUT=1 D:X'?.ANP CC^XQORM4 D:$L(X)>80 LL^XQORM4 Q:($E(X)'="?")&(X?.ANP)&($L(X)'>80)  D:$E(X)="?" HELP^XQORM4 I $D(DIROUT) S X="^^" Q
 K ORUPRMT Q
PRMT1 S Y=0 W:XQORM(0)'["\" ! W ORUPRMT,$S($D(XQORM("B"))'[0:XQORM("B")_"// ",1:"")
 I '$L($T(INITKB^XGF)) D
 . R X:$S($D(DTIME):DTIME,1:300) S:'$T DTOUT=1,X="^"
 E  D  ; allow function key use
 . D INITKB^XGF()
 . S X=$$READ^XGF()
 . I $L(XGRT),XGRT'="CR" S X=XGRT S:$D(XQORM("XLATE",X)) X=XQORM("XLATE",X)
 . D RESETKB^XGF
 S:'$L(X)&($D(XQORM("B"))'[0) X=XQORM("B")
 I $D(XQORM("NO^")),X["^"!(X=""),X'?1"^^"1E.E D NU^XQORM4 Q
 S Y=1 Q
UP S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
EAT F I=0:0 Q:$E(X)]" "  Q:'$L(X)  S X=$E(X,2,999)
 F I=0:0 Q:$E(X,$L(X))]" "  Q:'$L(X)  S X=$E(X,1,$L(X)-1)
 Q
RD S N=0 W ! Q:$Y<(IOSL-2)  W !,"Press RETURN to continue or '^' to exit: "
 N X R X:$S($D(DTIME):DTIME,1:300) S:'$T X="^" S:$E(X)="^" N=1
 S (DX,DY)=0 X ^%ZOSF("XY") W !!
 Q
INHI() ; Switch to highlighted video (IOINHI must be defined by caller)
 S DX=$X#81,DY=$Y#25 W IOINHI X ^%ZOSF("XY")
 Q ""
INLO() ; Switch to lowlighted video (IOINLOW must be defined by caller)
 S DX=$X#81,DY=$Y#25 W IOINLOW X ^%ZOSF("XY")
 Q ""
