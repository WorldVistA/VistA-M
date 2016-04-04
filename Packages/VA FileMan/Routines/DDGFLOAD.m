DDGFLOAD ;SFISC/MKO-LOAD PAGE/BLOCK ;12:33 PM  29 Mar 1995
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
PG(S,P,V,R) ;
 ;Load and paint page
 ;Called when a new form or page is selected
 ;If Page is not pop-up close all windows first
 ;Input:
 ; S = internal form number
 ; P = internal page number
 ; V = 1 if buffer should be updated but nothing painted
 ;     (new windows are still given focus)
 ; R = 1 to reload blocks/fields on page even if loaded before
 ;Returns:
 ; DDGFWID  = Window number for a given page
 ; DDGFWIDB = Window number of block displayer for a given page
 ; DDGFLIM  = Boundaries within which cursor can be moved
 ;
 I $D(^DIST(.403,+$G(S),40,+$G(P),0))[0 S DDGFWID="P0",DDGFWIDB="B0",DDGFLIM="0^0^"_(IOSL-8)_U_(IOM-2),DDGFPG=0 Q
 ;
 S DDGFWID="P"_DDGFPG,DDGFWIDB="B"_DDGFPG
 I $$EXIST^DDGLIBW(DDGFWID),$G(R) D DESTROY^DDGLIBW(DDGFWID,1)
 I $$EXIST^DDGLIBW(DDGFWID),'$G(R) D  Q
 . S DDGFLIM=$P(@DDGFREF@("F",P),U,1,4)
 . I $P(DDGFLIM,U,3,4)?."^" D
 .. S $P(DDGFLIM,U,3,4)=IOSL-8_U_(IOM-2)
 .. D CLOSEALL^DDGLIBW($G(V))
 . D FOCUS^DDGLIBW(DDGFWID,$G(V))
 ;
 N P1,P2,P3,P4,B,B1,B2
 ;
 ;Get page coordinates
 I $D(@DDGFREF@("F",+P))#2 D
 . N N
 . S N=@DDGFREF@("F",+P)
 . S P1=$P(N,U),P2=$P(N,U,2),P3=$P(N,U,3),P4=$P(N,U,4)
 E  D
 . S P2=$P(^DIST(.403,+S,40,+P,0),U,3),P3=$P(^(0),U,7)
 . S P1=$P(P2,",")-1,P2=$P(P2,",",2)-1
 . S:P1<0 P1=0 S:P2<0 P2=0
 . S:P3]"" P4=$P(P3,",",2)-1,P3=$P(P3,",")-1
 . S @DDGFREF@("F",P)=P1_U_P2_U_$S(P3]"":P3_U_P4,1:U)_U_$P($G(^DIST(.403,+S,40,+P,1)),U)_U_$P(^(0),U)
 ;
 I P3]"" D
 . S DDGFLIM=P1_U_P2_U_P3_U_P4
 . D CREATE^DDGLIBW(DDGFWID,P1_U_P2_U_(P3-P1+1)_U_(P4-P2+1),1,$G(V))
 . S @DDGFREF@("RC",DDGFWID,P1,P2,P4,"P","P","PTOP")=""
 . S @DDGFREF@("RC",DDGFWID,P3,P4,P4,"P","P","PBRC")=""
 ;
 E  D
 . S DDGFLIM=P1_U_P2_U_(IOSL-8)_U_(IOM-2)
 . D CLOSEALL^DDGLIBW($G(V))
 . D CREATE^DDGLIBW(DDGFWID,P1_U_P2_U_(IOSL-7-P1)_U_(IOM-1-P2),"",$G(V))
 ;
 ;Load header block
 S B=$P(^DIST(.403,+S,40,+P,0),U,2) I B]"" D
 . S B1=P1,B2=P2
 . D BK(+P,B,P1,P2,B1,B2,1,$G(V))
 ;
 ;Load all other blocks
 S B=0 F  S B=$O(^DIST(.403,+S,40,+P,40,B)) Q:B'=+$P(B,"E")  D
 . Q:$D(^DIST(.403,+S,40,+P,40,B,0))[0
 . S B2=$P(^DIST(.403,+S,40,+P,40,B,0),U,3)
 . S B1=$P(B2,",")-1,B2=$P(B2,",",2)-1
 . S:B1<0 B1=0 S:B2<0 B2=0
 . S B1=B1+P1,B2=B2+P2
 . D BK(+P,B,P1,P2,B1,B2,"",$G(V))
 Q
 ;
BK(P,B,P1,P2,B1,B2,H,V) ;Load block image
 ; P  = internal page number
 ; B  = internal block number
 ; P1 = page $Y
 ; P2 = page $X
 ; B1 = block abs $Y
 ; B2 = block abs $X
 ; H  = 1 if header block, immobile (optional)
 ; V  = 1 if buffer should be updated but nothing painted (optional)
 N B3,F,F1,C,C1,C2,C3,D1,D2,D3,I,L,N,T
 Q:$D(^DIST(.404,B,0))[0
 ;
 S N=$P(^DIST(.404,B,0),U)
 S:$G(H) B1=P1,B2=P2
 S B3=B2+$L(N)-1
 S @DDGFREF@("F",P,B)=B1_U_B2_U_B3_U_N
 S @DDGFREF@("BKRC",DDGFWIDB,B1,B2,B3,B)=$S($G(H):"H",1:"")
 ;
 S F1=""
 F  S F1=$O(^DIST(.404,B,40,"B",F1)) Q:F1=""  S F=$O(^(F1,"")) D:F
 . Q:$D(^DIST(.404,B,40,F,0))[0
 . S C=$P(^DIST(.404,B,40,F,0),U,2),C2=$P($G(^(2)),U,3)
 . I C]"",'$P($G(^DIST(.404,B,40,F,2)),U,4),$P(^(0),U,3)'=1 S C=C_":"
 . S L=$P($G(^DIST(.404,B,40,F,2)),U,2),D2=$P($G(^(2)),U)
 . S T=$P(^DIST(.404,B,40,F,0),U,3)
 . ;
 . ;Kill nodes that are null or contain only ^s
 . S I=0
 . F  S I=$O(^DIST(.404,B,40,F,I)) Q:'I  I $D(^(I))=1,^(I)?."^" K ^(I)
 . ;
 . ;Check that fields with captions have caption coords
 . I C]"",'C2 S C2="1,1",$P(^DIST(.404,B,40,F,2),U,3)=C2
 . ;
 . ;Check for DD fields that should be Caption fields
 . I T=3,$D(^DIST(.404,B,40,F,1))[0,'$O(^(2)) D
 .. S T=1,(D2,L)=""
 .. S C=$P($G(^DIST(.404,B,40,F,0)),U,2)
 .. S $P(^DIST(.404,B,40,F,0),U,3)=1
 .. S $P(^DIST(.404,B,40,F,2),U,1,4)="^^"_C2_"^"
 . ;
 . ;Check that fields have some coordinate
 . I 'C2,T=1!'D2 D
 .. I C="" D
 ... S C="** Null **",$P(^DIST(.404,B,40,F,0),U,2)=C,$P(^(2),U,4)=""
 ... S:T'=1 C=C_":"
 .. S C2="1,1",$P(^DIST(.404,B,40,F,2),U,3)=C2
 . ;
 . ;Make sure nonCaption fields have data coordinates and length
 . I T'=1 D
 .. S:'D2 D2=+C2_","_($P(C2,",",2)+$L(C)+1),$P(^DIST(.404,B,40,F,2),U)=D2
 .. S:'L L=1,$P(^DIST(.404,B,40,F,2),U,2)=1
 .. I C="",C2 S C2="",$P(^DIST(.404,B,40,F,2),U,3)=""
 . ;
 . I C]"" D
 .. S C1=$P(C2,",")-1+B1,C2=$P(C2,",",2)-1+B2,C3=C2+$L(C)-1
 .. S @DDGFREF@("F",P,B,F)=C1_U_C2_U_C3_U_C
 .. S @DDGFREF@("RC",DDGFWID,C1,C2,C3,B,F,"C")=""
 .. D WRITE^DDGLIBW(DDGFWID,C,C1-P1,C2-P2,"",$G(V))
 . ;
 . ;NonCaption fields
 . I T'=1 D
 .. S D1=$P(D2,",")-1+B1,D2=$P(D2,",",2)-1+B2,D3=D2+L-1
 .. S $P(@DDGFREF@("F",P,B,F),U,5,8)=D1_U_D2_U_D3_U_L
 .. S @DDGFREF@("RC",DDGFWID,D1,D2,D3,B,F,"D")=""
 .. D WRITE^DDGLIBW(DDGFWID,$TR($J("",L)," ","_"),D1-P1,D2-P2,"",$G(V))
 Q
