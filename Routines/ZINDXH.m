ZINDXH ;ISC/GRK - Move out %INDEX routines for safe keeping ;2/28/91  07:18 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
SAVE S A="%IND",B="ZIND" D MOVE Q
RESTORE S A="ZIND",B="%IND" D MOVE Q
MOVE W !,"Move ",A,"* routines to ",B,"* routines.  Proceed  ? " R X:$S($G(DTIME):DTIME,1:360) I X=""!("Yes,Y,y,yes"'[X) W !,"No routines moved." Q
MV2 F J="EX","X1","X10","X11","X2","X3","X4","X5","X51","X52","X53","X6","X8","X9" X "ZL @(A_J) W !,""Loaded "",A,J ZS @(B_J) W ?20,""Saved as "",B,J"
 Q
WINDEX S A="WIND",B="ZIND" D MOVE Q
INSTALL S A="ZIND",B="%IND" D MV2 Q
