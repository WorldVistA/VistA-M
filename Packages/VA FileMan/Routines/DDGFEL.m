DDGFEL ;SFISC/MKO-SELECT OR EDIT ELEMENT ;07:25 AM  7 Aug 1995
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
SELECT ;Select an element
 N B,F,T,C,C1,C2,C3,D,D1,D2,D3,L,P1,P2
 D GETELEM(DY,DX) Q:$G(F)=""
 ;
 I F="P" G ^DDGFAPC
 ;
 ;Clear and/or kill portions of DDGFREF
 S:T="D" $P(@DDGFREF@("F",DDGFPG,B,F),U,5,8)=""
 K:T="C" @DDGFREF@("RC",DDGFWID,C1,C2,C3,B,F,"C"),@DDGFREF@("F",DDGFPG,B,F)
 K:$D(D) @DDGFREF@("RC",DDGFWID,D1,D2,D3,B,F,"D")
 ;
 D COVER
 G ^DDGF2
 ;
EDIT ;Edit a caption or data length
 N B,F,T,C,C1,C2,C3,D,D1,D2,D3,L,P1,P2,X,Y
 D GETELEM(DY,DX) Q:"P"[$G(F)
 ;
 S DDGFCHG=1
 I T="C" D
 . K D,D1,D2,D3,L
 . S $P(@DDGFREF@("F",DDGFPG,B,F),U,1,4)="^^^"
 . K @DDGFREF@("RC",DDGFWID,C1,C2,C3,B,F,"C")
 . D COVER
 . D
 .. N DX,DY
 .. S DY=IOSL-6,DX=IOM-9 X IOXY W "EDIT   "
 . ;
 . N DDGFCOD,DDGFX
 . D EN^DIR0(C1,C2,$L(C),1,C,"","","","KWT",.DDGFX,.DDGFCOD)
 . S X=DDGFX
 . I $P(DDGFCOD,U)="TO"!(X="!M") W $C(7) S X=C
 . E  I X["^" S X=C
 . E  X $P(^DD(.4044,1,0),U,5,999) I '$D(X) W $C(7) S X=C
 . S C3=C2+$L(X)-1
 . ;
 . S @DDGFREF@("RC",DDGFWID,C1,C2,C3,B,F,"C")=""
 . D WRITE^DDGLIBW(DDGFWID,X,C1-P1,C2-P2)
 . I $L(X)<$L(C) D REPAINT^DDGLIBW(DDGFWID,(C1-P1)_U_(C3+1-P2)_U_1_U_($L(C)-$L(X)))
 . S $P(@DDGFREF@("F",DDGFPG,B,F),U,1,4)=C1_U_C2_U_C3_U_X,$P(^(F),U,9)=1
 ;
 I T="D" D
 . K C,C1,C2,C3
 . S $P(@DDGFREF@("F",DDGFPG,B,F),U,5,8)=""
 . K @DDGFREF@("RC",DDGFWID,D1,D2,D3,B,F)
 . D COVER,^DDGFADL
 . ;
 . S $P(@DDGFREF@("F",DDGFPG,B,F),U,5,8)=D1_U_D2_U_D3_U_L,$P(^(F),U,9)=1
 . S @DDGFREF@("RC",DDGFWID,D1,D2,D3,B,F,"D")=""
 . D WRITE^DDGLIBW(DDGFWID,D,D1-P1,D2-P2)
 ;
 D RC(DY,DX)
 Q
 ;
GETELEM(DY,DX) ;Which element is the cursor on
 ;Returns P,B,F,T,C,C1,C2,C3,D,D1,D2,D3,L,P1,P2
 ;If on pop-up page border, return only B="P",F="P",T="PTOP" or "PBRC"
 ;Set P=page,B=Block,F=DDO,T=type ("D" or "C")
 ;If cursor is not on anything, $G(F)=""
 ;
 Q:'$D(@DDGFREF@("RC",DDGFWID,DY))
 N X1,X2,F1
 S X1="" K F
 F  S X1=$O(@DDGFREF@("RC",DDGFWID,DY,X1)) Q:X1=""!(DX<X1)  D
 . S X2=""
 . F  S X2=$O(@DDGFREF@("RC",DDGFWID,DY,X1,X2)) Q:X2=""  D  Q:$G(F)
 .. Q:DX>X2
 .. S B=$O(@DDGFREF@("RC",DDGFWID,DY,X1,X2,""))
 .. S F=$O(@DDGFREF@("RC",DDGFWID,DY,X1,X2,B,""))
 .. S T=$O(@DDGFREF@("RC",DDGFWID,DY,X1,X2,B,F,""))
 Q:"P"[$G(F)
 ;
 S P1=$P(DDGFLIM,U),P2=$P(DDGFLIM,U,2)
 S F1=$G(@DDGFREF@("F",DDGFPG,B,F))
 ;
 ;Get caption, data, and coordinates
 S C1=$P(F1,U),C2=$P(F1,U,2),C3=$P(F1,U,3),C=$P(F1,U,4)
 I $P(F1,U,8)]"" D
 . S D1=$P(F1,U,5),D2=$P(F1,U,6),D3=$P(F1,U,7)
 . S L=$P(F1,U,8),D=$TR($J("",L)," ","_")
 Q
 ;
COVER ;Look for covered (hidden) fields
 ;Input:
 ; T,C,C1,C2,P1,P2
 ;H(DDO) - array of hidden fields
 ;Erase the element we've selected from buffer
 ;Redraw the element(s) that were covered
 N H,O,X1,X2,Y
 F Y="C1","D1" D
 . I Y="C1",T'="C" Q
 . I Y="D1",'$D(D) Q
 . S X1=""
 . F  S X1=$O(@DDGFREF@("RC",DDGFWID,@Y,X1)) Q:X1=""  D
 .. S X2=""
 .. F  S X2=$O(@DDGFREF@("RC",DDGFWID,@Y,X1,X2)) Q:X2=""  D
 ... N B
 ... S B=$O(@DDGFREF@("RC",DDGFWID,@Y,X1,X2,""))
 ... S O=$O(@DDGFREF@("RC",DDGFWID,@Y,X1,X2,B,""))
 ... I O]"",$D(H(O))[0 D
 .... I T="C",$$OVERLAP(C2,C3,X1,X2) S H(O)=DDGFPG_U_B
 .... E  I $D(D),$$OVERLAP(D2,D3,X1,X2) S H(O)=DDGFPG_U_B
 ;
 ;Clear in buffer area occupied by element(s) selected
 D:T="C" CLEAR(C,C1,C2,C3)
 D:$D(D) CLEAR(D,D1,D2,D3)
 ;
 ;Write to buffer the overlapped field(s)
 I $D(H) S H="" F  S H=$O(H(H)) Q:H=""  D
 . S O=$G(@DDGFREF@("F",$P(H(H),U),$P(H(H),U,2),H)) Q:O=""
 . D WRITE^DDGLIBW(DDGFWID,$P(O,U,4),$P(O,U)-P1,$P(O,U,2)-P2,"",1)
 . I $P(O,U,8)>0 D WRITE^DDGLIBW(DDGFWID,$TR($J("",$P(O,U,8))," ","_"),$P(O,U,5)-P1,$P(O,U,6)-P2,"",1)
 Q
 ;
OVERLAP(A1,A2,B1,B2) ;Does line with X-coords A1,A2 overlap B1,B2
 N T
 I A1<B1 S T=A1,A1=B1,B1=T,T=A2,A2=B2,B2=T
 Q A1'<B1&(A1'>B2)!(A2'<B1&(A2'>B2))
 ;
RC(DDGFY,DDGFX) ;Update status line, reset DX and DY, move cursor
 N S
 I DDGFR D
 . S DY=IOSL-6,DX=IOM-9,S="R"_(DDGFY+1)_",C"_(DDGFX+1)
 . X IOXY W S_$J("",7-$L(S))
 S DY=DDGFY,DX=DDGFX X IOXY
 Q
 ;
CLEAR(C,C1,C2,C3) ;Clear in buffer area occupied by element(s) selected
 ;If on the page border, redraw the lines
 N L
 S L=$J("",$L(C)-$S(C3>$P(DDGFLIM,U,4):C3-$P(DDGFLIM,U,4),1:0))
 D WRITE^DDGLIBW(DDGFWID,L,C1-$P(DDGFLIM,U),C2-$P(DDGFLIM,U,2),"",1)
 ;
 I $P(@DDGFREF@("F",DDGFPG),U,3) D
 . I C1=$P(DDGFLIM,U)!(C1=$P(DDGFLIM,U,3)) D
 .. S L=$TR(L," ",$P(DDGLGRA,DDGLDEL,3))
 .. S:C2=$P(DDGFLIM,U,2) $E(L)=$P(DDGLGRA,DDGLDEL,$S(C1=$P(DDGFLIM,U):5,1:7))
 .. S:C3'<$P(DDGFLIM,U,4) $E(L,$L(L))=$P(DDGLGRA,DDGLDEL,$S(C1=$P(DDGFLIM,U):6,1:8))
 .. D WRITE^DDGLIBW(DDGFWID,L,C1-$P(DDGFLIM,U),C2-$P(DDGFLIM,U,2),"G",1)
 . E  I C2=$P(DDGFLIM,U,2) D
 .. D WRITE^DDGLIBW(DDGFWID,$P(DDGLGRA,DDGLDEL,4),C1-$P(DDGFLIM,U),C2-$P(DDGFLIM,U,2),"G",1)
 . E  I C3'<$P(DDGFLIM,U,4) D
 .. D WRITE^DDGLIBW(DDGFWID,$P(DDGLGRA,DDGLDEL,4),C1-$P(DDGFLIM,U),$P(DDGFLIM,U,4)-$P(DDGFLIM,U,2),"G",1)
 Q
