DIWP ;SFISC/GFT-ASSEMBLE WP LINE ;24APR2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**46,152,169**
 ;
 ;The DIWF variable contains a string of one-letter codes to control W-P output.
 ;"|" in DIWF means that "|"-windows are not to be evaluated, but are to be printed as
 ;     they stand.
 ;"X" means eXactly line-for-line, with "||" printed as "||"
 ;"W" in DIWF means that formatted text will be written out to
 ;     the current device as it is assembled.
 ;"N" means NOWRAP-- text is assembled line-for-line
 ;"R" means text will be assembled Right-justified
 ;"D" means text will be double-spaced
 ;"L" means internal line numbers appear at the left margin
 ;"C" followed by a number will cause formatting of text in a column
 ;     width specified by the number.
 ;"I" followed by a number will cause text to be indented that number
 ;     of columns.
 ;"?" means that, if user's terminal is available, "|"-windows that cannot
 ;     be evaluated will be asked from the user's terminal.
 ;"B" followed by number causes new page when output gets within that
 ;   number of lines from the bottom of the page (as defined by IOSL).
 ;   
 ;DIWTC is a Boolean -- Are we printing out in LINE MODE?
 S:'$L(X) X=" "
 S DIWTC=X[($C(124)_"TAB") S:'$D(DN) DN=1
LN S:'$D(DIWF) DIWF="" S:'DIWTC DIWTC=DIWF["N" S DIWX=X,DIW=$C(124),I=$P(DIWF,"C",2) I I S DIWR=DIWL+I-1
 I '$D(^UTILITY($J,"W",DIWL)) S ^(DIWL)=1 K DIWFU,DIWFWU,DIWLL D DIWI S:'$D(DIWT) DIWT="5,10,15,20,25" G DIW
 S I=^(DIWL),DIWI=^(DIWL,I,0) I DIWI="" D DIWI G Z
 D NEW:DIWTC
Z S Z=X?.P!DIWTC I X?1" ".E!Z S DIWTC=1 D NEW:DIWI]"" S DIWTC=Z
DIW ;from RCR+5^DIWW
 I DIWF["X" S DIWTC=1,X=DIWX,DIWX="" D C G D ;**DI*22*152**  Leave line unaltered
 S X=$P(DIWX,DIW,1) D C:X]"" S X=$P(DIWX,DIW,1),DIWX=$P(DIWX,DIW,2,999) G D:DIWX="" I $D(DIWP),X'?.E1" " D ST
 S X=$P(DIWX,DIW,1) I $P(X,"TAB",1)="" D TAB G N
 I X="TOP" D PUT S ^("X")="S DIFF=1 X:$D(^UTILITY($J,1)) ^(1)" D NEW G N
 I DIWF'[DIW G U:X="_" D PUT,RCR^DIWW G N:$D(X)
 S X=DIW_$P(DIWX,DIW,1) S:DIWX[DIW!(DIWF'[DIW) X=X_DIW D C ;DO NOT PUT GRATUITOUS "|" AT END, IF DIWF["|"
N K X S DIWX=$P(DIWX,DIW,2,99) I DIWX]"" D ST:$D(DIWP) G DIW
D K DIWP D PUT,PRE:DIWTC S:DIWTC DIWI="" Q
 ;
ST S DIWI=$E(DIWI,1,$L(DIWI)-1) K DIWP Q
 ;
DIWI S DIWI=$J("",+$P(DIWF,"I",2)) I DIWF["L",$D(D)#2 S DIWLL=D
 Q
PUT S I=^UTILITY($J,"W",DIWL),^(DIWL,I,0)=DIWI I DIWF["L",$D(DIWLL) S ^("L")=DIWLL
 Q
L ;
 S DIWTC=1 G LN
 ;
TAB I X="" S X=DIW G C
 S J=$P(DIWT,",",DIWTC),DIWTC=DIWTC+1 S:X?3A1P.P.N.E J=$E(X,5,9) S:J?1"""".E1"""" J=$E(J,2,$L(J)-1)
 I J'>0 S %=$P(DIWX,DIW,2) Q:%=""  S J=$S(J<0:1-$L(%)-J,J="C":DIWR-DIWL-$L(%)\2,1:0)
 S J=J-1-$L(DIWI) Q:J<1  S X=$J("",J)
C K DIWP I DIWTC S DIWI=DIWI_X Q
B S Z=DIWR-DIWL+1-$L(DIWI) G FULL:$F(X," ")-1>Z F %=Z:-1 I " "[$E(X,%) S:$E(X,%+1)=" " %=%+1 Q
 S Z=$E(X,1,%-1),X=$E(X,%+1,999) I Z]"" S DIWI=DIWI_Z G S:X]"" S %=$E(Z,$L(Z)) S:%'=" " DIWI=DIWI_$J("",%="."+1),DIWP=1 Q
FULL I $P(DIWF,"I",2)'<$L(DIWI) S DIWI=DIWI_$P(X," ",1),X=$P(X," ",2,999)
S D PUT,NEW G B:X]"" Q
 ;
U S I=^UTILITY($J,"W",DIWL) I $D(DIWFU) S ^(DIWL,I,"U",$L(DIWI)+1)="" K DIWFU G N
 S ^(DIWL,I,"U",$L(DIWI)+1)=X,DIWFU=1 G N
 ;
NEW D DIWI
PRE S I=^UTILITY($J,"W",DIWL),^(DIWL)=I+1,^(DIWL,I+1,0)="" I DIWF["D" S ^(0)=" ",^UTILITY($J,"W",DIWL)=I+2,^(DIWL,I+2,0)=""
 I $D(DIWFU) S ^("U",1+$P(DIWF,"I",2))="_"
 G P:DIWF'["R"!DIWTC K % Q:'$D(^UTILITY($J,"W",DIWL,I,0))
 S Y=^(0),%=$L(Y) F %=%:-1 Q:$A(Y,%)-32
 S Y=$E(Y,1,%),J=DIWR-DIWL-%+1,%X=0 G P:J<1
 F %=1:1 S %(%)=$P(Y," ",1),Y=$P(Y," ",2,999) G:Y="" PAD:%-1,P I $E(%(%),$L(%(%)))?.P S:%=1&(%(%)="") %=0,%X=%X+1 S:%&J J=J-1,%(%)=%(%)_" "
PAD I J F Y=%\2+1:1:%-1,%\2:-1 S %(Y)=%(Y)_" ",J=J-1 G PAD:Y=1!'J
 S Y=%(%) F %=%-1:-1:1 S Y=%(%)_" "_Y
 S ^(0)=$J("",%X)_Y K %
P I DIWF["W" G NX^DIWW
