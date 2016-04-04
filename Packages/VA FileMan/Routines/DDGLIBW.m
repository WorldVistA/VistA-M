DDGLIBW ;SFISC/MKO-WINDOW PRIMITIVES ;02:24 PM  13 Jul 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ; Area is defined as $Y^$X^height^width
 ; DDGLREF(wid)=$Y^$X^height^width
 ; DDGLREF(wid,$Y+1,"TXT")=string
 ; DDGLREF(wid,$Y+1,"ATT")=attributes (bold,underline,reverse,graphic)
 ;
 ; DDGLSCR array - keeps track of what windows are on the screen and
 ;                the order in which they overlap
 ; Form of DDGLSCR array:
 ;   DDGLSCR           = # of elements
 ;   DDGLSCR(n)        = wid
 ;   DDGLSCR("B",wid,n)= ""
 ;
CREATE(I,A,B,N) ;
 G CREATE1^DDGLIBW1
 ;
OPEN(I,N) ;
 G OPEN1^DDGLIBW1
 ;
FOCUS(I,N) ;
 G FOCUS1^DDGLIBW1
 ;
CLOSE(I,NC) ;
 G CLOSE1^DDGLIBW1
 ;
CLEAR(I,A) ;
 ;Clear area A in window I
 G CLEAR1^DDGLIBW1
 ;
EXIST(I) ;
 ;Does window I exist?
 Q $D(@DDGLREF@(I))#2
 ;
CLOSEALL(N) ;
 ;Close all windows
 W:'$G(N) $P(DDGLCLR,DDGLDEL,2)
 K DDGLSCR
 Q
 ;
DESTROY(I,NC) ;
 ;Destroy window I
 D CLOSE(I,$G(NC))
 K @DDGLREF@(I)
 Q
 ;
DESTALL ;Destroy all windows
 K @DDGLREF,DDGLSCR
 Q
 ;
WRITE(I,S,Y,X,A,N) ;
 ;Write str S in window I at $Y=R, $X=C, attr A
 ; If N=1, update buffer, but don't write
 N A1,A0,A9
 Q:$G(S)=""
 S:$G(I)="" I=-1
 S A9=$$AREA(I)
 Q:X'<$P(A9,U,4)  Q:Y'<$P(A9,U,3)
 S S=$E(S,1,$P(A9,U,4)-X)
 ;
 S $E(@DDGLREF@(I,Y+1,"TXT"),X+1,X+$L(S))=S
 I $G(A)="",$D(@DDGLREF@(I,Y+1,"ATT"))#2 S $E(@DDGLREF@(I,Y+1,"ATT"),X+1,X+$L(S))=$J("",$L(S))
 S:$G(A)]"" $E(@DDGLREF@(I,Y+1,"ATT"),X+1,X+$L(S))=$TR($J("",$L(S))," ",$$CODE(A,.A1,.A0))
 ;
 I '$G(N) D
 . N DY,DX
 . S DY=Y+$P(A9,U),DX=X+$P(A9,U,2) X IOXY W $G(A1)_S_$G(A0)
 ;
 I $G(@DDGLREF@(I,Y+1,"TXT"))?." ",$G(@DDGLREF@(I,Y+1,"ATT"))?." " K @DDGLREF@(I,Y+1,"TXT"),@DDGLREF@(I,Y+1,"ATT")
 Q
 ;
REPALL(A) ;
 ;Repaint absolute area A in all windows in DDGLSCR array
 N J
 I $G(A)="" D
 . W $P(DDGLCLR,DDGLDEL,2)
 . F J=1:1:$G(DDGLSCR) D REPAINT(DDGLSCR(J))
 E  D
 . D CLEAR(-1,A)
 . F J=1:1:$G(DDGLSCR) D REPAINT(DDGLSCR(J),$$RELAREA(DDGLSCR(J),A))
 Q
 ;
REPAINT(I,A) ;
 ;Repaint area A of window I
 N X,Y,H,W,R,C,T,X1,X2,A2,A1,A0,S,DY,DX,P
 I $D(A),A="" Q
 S:$G(I)="" I=-1
 S:'$D(A) A="0^0^"_IOSL_U_IOM
 ;
 S A2=$$AREA(I)
 S A=$P(A,U)+$P(A2,U)_U_($P(A,U,2)+$P(A2,U,2))_U_$P(A,U,3,4)
 S A=$$INTSECT^DDGLIBW1(A,A2)
 S Y=$P(A,U)-$P(A2,U),X=$P(A,U,2)-$P(A2,U,2),H=$P(A,U,3),W=$P(A,U,4)
 ;
 I $D(@DDGLREF@(I))<9,Y+$P(A2,U)=0,X+$P(A2,U,2)=0,H=IOSL,W=IOM W $P(DDGLCLR,DDGLDEL,2) Q
 S P=IOM-X-$P(A2,U,2)-1_""" """
 F R=Y+1:1:Y+H D
 . S S=""
 . S T=$E($G(@DDGLREF@(I,R,"TXT"))_$J("",X+W-$L($G(@DDGLREF@(I,R,"TXT")))),1,X+W)
 . S A=$E($G(@DDGLREF@(I,R,"ATT")),1,X+W)
 . S (X1,X2)=X+1 F  D  Q:$E(T,X2)=""
 .. S X1=X2,C=$E(A,X1)
 .. I C="" S X2=999 S S=S_$E(T,X1,X2) Q
 .. F X2=X1:1:$L(A)+1 Q:C'=$E(A,X2)
 .. D DECODE(C,.A1,.A0)
 .. S S=S_A1_$E(T,X1,X2-1)_A0
 . S DY=R-1+$P(A2,U),DX=X+$P(A2,U,2) X IOXY
 . W $S(S?@P:$P(DDGLCLR,DDGLDEL),1:S)
 Q
 ;
BOX(I,A,C,N) ;
 ;Draw a box in window I representing area A
 ;If C=1 writes spaces within the box
 ;If N=1 write to buffer but not screen
 N Y,X,H,W,L,R,S,A1
 S:$G(I)="" I=-1
 S:$G(A)="" A=$$AREA(I)
 S:$G(N)="" N=0
 S A1=$$ABSAREA(I,A)
 S Y=$P(A,U),X=$P(A,U,2),H=$P(A,U,3),W=$P(A,U,4)
 Q:'H!'W
 S S=$J("",W-2),L=$TR(S," ",$P(DDGLGRA,DDGLDEL,3))
 D WRITE(I,$P(DDGLGRA,DDGLDEL,5)_$S(W>1:L_$P(DDGLGRA,DDGLDEL,6),1:""),Y,X,"G",N)
 F R=Y+1:1:Y+H-2 D
 . D WRITE(I,$P(DDGLGRA,DDGLDEL,4),R,X,"G",N)
 . I W>1 D
 .. I $G(C) D WRITE(I,S,R,X+1,"",N)
 .. D WRITE(I,$P(DDGLGRA,DDGLDEL,4),R,X+W-1,"G",N)
 D:H>1 WRITE(I,$P(DDGLGRA,DDGLDEL,7)_$S(W>1:L_$P(DDGLGRA,DDGLDEL,8),1:""),Y+H-1,X,"G",N)
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
CODE(A,A1,A0) ;
 ;Return code char for selected attr
 N I,C,T
 S C=0,(A1,A0)=""
 S T=$TR(A,"burg","BURG")
 F I=1:1:$L(A) D
 . S T=$T(@$E(A,I))
 . I T]"" D
 .. S C=C+$P(T,";",3)
 .. S A1=A1_$P(@$P(T,";",4),DDGLDEL,$P(T,";",5))
 .. S A0=A0_$P(@$P(T,";",4),DDGLDEL,$P(T,";",6))
 Q $C(C+32)
 ;
DECODE(C,A1,A0) ;
 ;Given code char C, return codes to turn on/off attr
 N B,T
 S (A1,A0)="" Q:" "[$G(C)
 S C=$A(C)-32
 S B=1 F  D  Q:B>8
 . I C\B#2,$T(@B)]"" D
 .. S T=$T(@B+1)
 .. S A1=A1_$P(@$P(T,";",4),DDGLDEL,$P(T,";",5))
 .. S A0=A0_$P(@$P(T,";",4),DDGLDEL,$P(T,";",6))
 . S B=B*2
 Q
 ;
1 ;;
B ;;1;DDGLVID;1;2
2 ;;
U ;;2;DDGLVID;4;5
4 ;;
R ;;4;DDGLVID;6;7
8 ;;
G ;;8;DDGLGRA;1;2
