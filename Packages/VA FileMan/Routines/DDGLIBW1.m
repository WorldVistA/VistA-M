DDGLIBW1 ;SFISC/MKO-WINDOWING PRIMITIVES ;02:23 PM  13 Jul 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
CREATE(I,A,B,N) ;
CREATE1 ;Create window I of area A and draw border (if B)
 ;N = nn; first n=1 means don't give the window focus
 ;        second n=1 means don't write to screen
 ;
 S:$G(I)="" I=-1
 S:$G(A)="" A="0^0^"_IOSL_U_IOM
 K @DDGLREF@(I) S @DDGLREF@(I)=A
 D:$G(B) BOX^DDGLIBW(I,"0^0^"_$P(A,U,3,4),1,$G(N))
 D:$G(N)<9 FOCUS(I,$G(N)!$G(B))
 Q
 ;
OPEN(I,N) ;
OPEN1 ;Open window I
 G FOCUS1
 ;
FOCUS(I,N) ;
FOCUS1 ;Give focus to window I
 ;If N=1; don't paint window
 Q:$D(@DDGLREF@(I))[0
 Q:$G(DDGLSCR(+$G(DDGLSCR)))=I
 ;
 I '$D(DDGLSCR("B",I)) D
 . S DDGLSCR=$G(DDGLSCR)+1,DDGLSCR(DDGLSCR)=I,DDGLSCR("B",I,DDGLSCR)=""
 E  D
 . N M,N
 . S DDGLSCR(DDGLSCR+1)=I
 . S M=$O(DDGLSCR("B",I,""))
 . F N=M:1:DDGLSCR D
 .. K DDGLSCR("B",DDGLSCR(N),N)
 .. S DDGLSCR(N)=DDGLSCR(N+1)
 .. S DDGLSCR("B",DDGLSCR(N),N)=""
 . K DDGLSCR(DDGLSCR+1)
 D:'$G(N) REPAINT^DDGLIBW(I)
 Q
 ;
CLOSE(I,NC) ;
CLOSE1 ;Close window I
 N A,M,N,W
 S M=$O(DDGLSCR("B",I,""))
 Q:M=""
 ;
 I '$G(NC) D
 . S A=$$AREA(I)
 . D CLEAR(I,"0^0^"_$P(A,U,3,4))
 . F N=1:1:DDGLSCR D:N'=M
 .. S W=DDGLSCR(N)
 .. D REPAINT^DDGLIBW(W,$$RELAREA(W,$$INTSECT($$AREA(W),A)))
 ;
 F N=M:1:DDGLSCR-1 D
 . K DDGLSCR("B",DDGLSCR(N),N)
 . S DDGLSCR(N)=DDGLSCR(N+1)
 . S DDGLSCR("B",DDGLSCR(N),N)=""
 K DDGLSCR("B",DDGLSCR(DDGLSCR),DDGLSCR),DDGLSCR(DDGLSCR)
 S DDGLSCR=DDGLSCR-1
 Q
 ;
CLEAR(I,A) ;
CLEAR1 ;Clear area A in window I
 N Y,X,H,W,S,DY,DX
 S:$G(I)="" I=-1 S:$G(A)="" A=$$AREA(I)
 S A=$$ABSAREA(I,A)
 S Y=$P(A,U),X=$P(A,U,2),H=$P(A,U,3),W=$P(A,U,4)
 I Y=0,X=0,H=IOSL,W=IOM W $P(DDGLCLR,DDGLDEL,2) Q
 S DX=X,S=$S(IOM-X=W:$P(DDGLCLR,DDGLDEL),1:$J("",W))
 F DY=Y:1:Y+H-1 X IOXY W S
 Q
 ;
ABSAREA(I,A) ;
 ;Given relative area A in window I, return absolute area
 N X,Y,H,W,X1,Y1
 S Y=$P(A,U),X=$P(A,U,2),H=$P(A,U,3),W=$P(A,U,4)
 S A=$$AREA(I)
 S Y1=Y+$P(A,U),X1=X+$P(A,U,2)
 S:Y1+H>IOSL H=IOSL-Y1 S:X1+W>IOM W=IOM-X1
 Q Y1_U_X1_U_H_U_W
 ;
RELAREA(I,A) ;
 ;Given absolute area A in window I, return relative area
 N X,Y,H,W,X1,Y1
 S Y=$P(A,U),X=$P(A,U,2),H=$P(A,U,3),W=$P(A,U,4)
 S A=$$AREA(I)
 S Y1=Y-$P(A,U),X1=X-$P(A,U,2)
 Q Y1_U_X1_U_H_U_W
 ;
AREA(I) ;Return the coord and area of window I
 Q $S($D(@DDGLREF@(I))#2:@DDGLREF@(I),1:"0^0^"_IOSL_U_IOM)
 ;
INTSECT(A1,A2) ;
 ;Return the intersection of areas 1 and 2
 N A,X1,Y1,H1,W1,X2,Y2,H2,W2
 S Y1=$P(A1,U),X1=$P(A1,U,2),H1=$P(A1,U,3),W1=$P(A1,U,4)
 S Y2=$P(A2,U),X2=$P(A2,U,2),H2=$P(A2,U,3),W2=$P(A2,U,4)
 S A=""
 S $P(A,U)=$$MAX(Y1,Y2),$P(A,U,2)=$$MAX(X1,X2)
 S $P(A,U,3)=$$LEN(Y1,H1,Y2,H2)
 S $P(A,U,4)=$$LEN(X1,W1,X2,W2)
 Q:'$P(A,U,3)!'$P(A,U,4) ""
 Q A
 ;
MAX(X,Y) ;
 ;Return the max of X and Y
 Q $S(X>Y:X,1:Y)
 ;
LEN(C1,L1,C2,L2) ;
 ;Return intersection length of two lines
 ; C = position along X or Y axis
 ; L = length of line
 Q:C1'>C2 $S(C1+L1'<(C2+L2):L2,C1+L1>C2:L1-C2+C1,1:0)
 Q $S(C2+L2'<(C1+L1):L1,C2+L2>C1:L2-C1+C2,1:0)
