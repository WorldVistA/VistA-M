DICRW1 ;SFISC/XAK-SELECT A FILE ;1/30/91  4:18 PM
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
L ;LIST DD'S
 S DIB(1)=0 S D=" START WITH" D C2 G C4:U[X&(Y<0),L:Y<0
C3 S D="      GO TO" D C2 G C3:Y<0&(X'[U)
 I Y<DIB(1),X'[U W $C(7),!," The 'START WITH' File Number must be less than the 'GO TO' File Number." G L
C4 I X[U!'$D(DIC) K DIC Q
 S X=DIB(1),DIB(1)=+Y,Y=X Q
C2 D R1^DICRW D:$D(DDUC) DU S DIC(0)="QEI" D DIC^DICRW K DIAC,DIFILE Q:X[U!'$D(DIC)!(Y=-1)  S:DIB(1)=0 DIB(1)=+Y Q
DU S DIC("S")="I Y'<2 "_DIC("S")
 Q
