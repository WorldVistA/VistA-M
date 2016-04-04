DDGFUPDP ;SFISC/MKO-UPDATE PAGE COORDINATES ;01:37 PM  19 Jan 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
PAGE(P1,P2,P3,P4,T,A) ;
 ;
 D DESTROY^DDGLIBW(DDGFWID,1),DESTROY^DDGLIBW(DDGFWIDB,1)
 I P3]"" D
 . D REPALL^DDGLIBW($G(A))
 . D CREATE^DDGLIBW(DDGFWID,P1_U_P2_U_(P3-P1+1)_U_(P4-P2+1),1)
 . S DDGFLIM=P1_U_P2_U_P3_U_P4
 E  D
 . D CLOSEALL^DDGLIBW()
 . D CREATE^DDGLIBW(DDGFWID,P1_U_P2_U_(IOSL-7-P1)_U_(IOM-1-P2))
 . S DDGFLIM=P1_U_P2_U_(IOSL-8)_U_(IOM-2)
 D:T="PTOP" TOP(P1,P2,P3,P4)
 D:T="PBRC" BRC(P1,P2,P3,P4)
 Q
 ;
TOP(P1,P2,P3,P4) ;Update page image
 ;
 N B,C,C1,C2,C3,D1,D2,D3,F,I,L,N,P,X1,Y1
 ;
 S P=DDGFPG
 S N=@DDGFREF@("F",P)
 S Y1=P1-$P(N,U),X1=P2-$P(N,U,2)
 I 'Y1,'X1 Q
 ;
 I $P(N,U,3)]"" D
 . K @DDGFREF@("RC",DDGFWID,$P(N,U),$P(N,U,2),$P(N,U,4),"P","P","PTOP")
 . K @DDGFREF@("RC",DDGFWID,$P(N,U,3),$P(N,U,4),$P(N,U,4),"P","P","PBRC")
 I $G(P3)]"" D
 . S @DDGFREF@("RC",DDGFWID,P1,P2,P4,"P","P","PTOP")=""
 . S @DDGFREF@("RC",DDGFWID,P3,P4,P4,"P","P","PBRC")=""
 ;
 S $P(N,U,1,4)=P1_U_P2_U_P3_U_P4,$P(N,U,7)=1,DDGFCHG=1
 S @DDGFREF@("F",P)=N
 ;
 ;Loop through all blocks on page
 S B="" F  S B=$O(@DDGFREF@("F",P,B)) Q:B=""  D
 . S N=@DDGFREF@("F",P,B)
 . S @DDGFREF@("BKRC",DDGFWIDB,$P(N,U)+Y1,$P(N,U,2)+X1,$P(N,U,3)+X1,B)=@DDGFREF@("BKRC",DDGFWIDB,$P(N,U),$P(N,U,2),$P(N,U,3),B)
 . K @DDGFREF@("BKRC",DDGFWIDB,$P(N,U),$P(N,U,2),$P(N,U,3),B)
 . S $P(N,U,1,3)=$P(N,U)+Y1_U_($P(N,U,2)+X1)_U_($P(N,U,3)+X1)
 . S @DDGFREF@("F",P,B)=N
 . ;
 . S F="" F  S F=$O(@DDGFREF@("F",P,B,F)) Q:F=""  D
 .. S N=@DDGFREF@("F",P,B,F)
 .. S C1=$P(N,U),C2=$P(N,U,2),C3=$P(N,U,3),C=$P(N,U,4)
 .. S D1=$P(N,U,5),D2=$P(N,U,6),D3=$P(N,U,7),L=$P(N,U,8)
 .. ;
 .. I Y1 S:C1]"" $P(N,U)=C1+Y1 S:L $P(N,U,5)=D1+Y1
 .. I X1 D
 ... I C]"" F I=2,3 S $P(N,U,I)=$P(N,U,I)+X1
 ... I L F I=6,7 S $P(N,U,I)=$P(N,U,I)+X1
 .. S @DDGFREF@("F",P,B,F)=N
 .. ;
 .. I C]"" D
 ... K @DDGFREF@("RC",DDGFWID,C1,C2,C3,B,F,"C")
 ... S @DDGFREF@("RC",DDGFWID,$P(N,U),$P(N,U,2),$P(N,U,3),B,F,"C")=""
 .. I L D
 ... K @DDGFREF@("RC",DDGFWID,D1,D2,D3,B,F,"D")
 ... S @DDGFREF@("RC",DDGFWID,$P(N,U,5),$P(N,U,6),$P(N,U,7),B,F,"D")=""
 .. ;
 .. D:C]"" WRITE^DDGLIBW(DDGFWID,C,$P(N,U)-P1,$P(N,U,2)-P2)
 .. D:L WRITE^DDGLIBW(DDGFWID,$TR($J("",L)," ","_"),$P(N,U,5)-P1,$P(N,U,6)-P2)
 Q
 ;
BRC(P1,P2,P3,P4) ;Change bottom right coordinate of page
 N B,C,F,L,N,P
 S P=DDGFPG
 S N=@DDGFREF@("F",P)
 I $P(N,U,3)]"" D
 . K @DDGFREF@("RC",DDGFWID,$P(N,U),$P(N,U,2),$P(N,U,4),"P","P","PTOP")
 . K @DDGFREF@("RC",DDGFWID,$P(N,U,3),$P(N,U,4),$P(N,U,4),"P","P","PBRC")
 I $G(P3)]"" D
 . S @DDGFREF@("RC",DDGFWID,P1,P2,P4,"P","P","PTOP")=""
 . S @DDGFREF@("RC",DDGFWID,P3,P4,P4,"P","P","PBRC")=""
 ;
 S $P(N,U,1,4)=P1_U_P2_U_P3_U_P4,$P(N,U,7)=1,DDGFCHG=1
 S @DDGFREF@("F",P)=N
 ;
 ;Loop through all blocks/fields on page
 S B="" F  S B=$O(@DDGFREF@("F",P,B)) Q:B=""  D
 . S F="" F  S F=$O(@DDGFREF@("F",P,B,F)) Q:F=""  D
 .. S N=@DDGFREF@("F",P,B,F)
 .. S C=$P(N,U,4),L=$P(N,U,8)
 .. ;
 .. I C]"" D WRITE^DDGLIBW(DDGFWID,C,$P(N,U)-P1,$P(N,U,2)-P2)
 .. I L D WRITE^DDGLIBW(DDGFWID,$TR($J("",L)," ","_"),$P(N,U,5)-P1,$P(N,U,6)-P2)
 Q
