DDSZ2 ;SFISC/MKO-LOAD SCR, NAV, AND ORDER INFO ;21JAN2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8,1003,1004**
 ;
EN(SC,N,O,RNAV) ;
 ;Input:
 ;  DDSPG
 ;  DDSREFS
 ;
 D SCR(.SC),NAV(.N,.RNAV),ORD(.O)
 D:$D(RNAV) RNAV(.RNAV,.O)
 Q
 ;
SCR(SC) ;Move image from SC to global
 N C,P,R,S
 Q:'$D(SC)
 S R=0 F  S R=$O(SC(R)) Q:'R  D
 . F C=1:1 Q:$E(SC(R),C)'=" "
 . S @DDSREFS@("X",DDSPG,R-1,C-1)=$TR($E(SC(R),C,999),$C(0)," ")
 . I $D(SC(R))=11 D
 .. S S="",P=0
 .. F  S P=$O(SC(R,P)) Q:'P  S S=S_(P-C+1)_";"_(SC(R,P)-C+1)_";U"_U
 .. S:S?.E1"^" S=$E(S,1,$L(S)-1)
 .. S:S]"" @DDSREFS@("X",DDSPG,R-1,C-1,"A")=S
 Q
 ;
NAV(N,RNAV) ;
 N B,D1,D2,F,LN
 S N(9999,1)="0,0"
 ;
 S D1="" F  S D1=$O(N(D1)) Q:D1=""  D
 . S D2="" F  S D2=$O(N(D1,D2)) Q:D2=""  D
 .. S F=$P(N(D1,D2),","),B=$P(N(D1,D2),",",2),LN=""
 .. D NAV1(.N,.RNAV,D1,D2,.LN)
 .. S @DDSREFS@(DDSPG,B,F,"N")=LN
 .. S:$D(DDSMUL(B,F)) $P(@DDSREFS@(DDSPG,B,F,"N"),U,11)=1
 Q
 ;
NAV1(N,RNAV,D1,D2,LN) ;Setup "N" for navigation
 N E1,E2,I
 ;
 S E1=$S($O(N(D1),-1)]"":$O(N(D1),-1),1:$O(N(""),-1))
 S E2=D2
 I $D(N(E1,E2))[0 S E2=$S($O(N(E1,E2),-1)]"":$O(N(E1,E2),-1),1:$O(N(E1,E2)))
 I E1]"",E2]"" D
 . N RBO
 . S RBO=$P(N(E1,E2),",",3)
 . I RBO,$D(RNAV(RBO,E1))#2 D  Q:E2=""
 .. S E2="" F  S E2=$O(RNAV(RBO,E1,E2)) Q:E2=""  Q:RNAV(RBO,E1,E2)'[","
 . S $P(LN,U)=$P(N(E1,E2),",",1,2)
 ;
 S E1=$S($O(N(D1))]"":$O(N(D1)),1:$O(N("")))
 S E2=D2
 I $D(N(E1,E2))[0 S E2=$S($O(N(E1,E2),-1)]"":$O(N(E1,E2),-1),1:$O(N(E1,E2)))
 I E1]"",E2]"" D
 . N RBO
 . S RBO=$P(N(E1,E2),",",3)
 . I RBO,$D(RNAV(RBO,E1))#2 D  Q:E2=""
 .. S E2="" F  S E2=$O(RNAV(RBO,E1,E2)) Q:E2=""  Q:RNAV(RBO,E1,E2)'[","
 . S $P(LN,U,2)=$P(N(E1,E2),",",1,2)
 ;
 S E1=D1,E2=$O(N(D1,D2))
 I E2="" S E1=$S($O(N(E1))]"":$O(N(E1)),1:$O(N(""))),E2=$O(N(E1,""))
 I E1]"",E2]"" S $P(LN,U,3)=$P(N(E1,E2),",",1,2)
 ;
 S E1=D1,E2=$S($O(N(E1,D2),-1)]"":$O(N(E1,D2),-1),1:"")
 I E2="" S E1=$S($O(N(E1),-1)]"":$O(N(E1),-1),1:$O(N(""),-1)),E2=$S($O(N(E1,""),-1)]"":$O(N(E1,""),-1),1:"")
 I E1]"",E2]"" S $P(LN,U,4)=$P(N(E1,E2),",",1,2)
 ;
 F I=1:1:4 S:$P($P(LN,U,I),",",2)=B!'$P($P(LN,U,I),",",2) $P(LN,U,I)=+$P(LN,U,I)
 Q
 ;
ORD(O) ;Setup field order info
 N B,BO,BP,F,FO,FP
 S (BO,FO)="" F  S BO=$O(O(BO)) Q:BO=""  S FO=$O(O(BO,"")) Q:FO]""
 S:FO="" BO=$O(O(""))
 S B=+$G(O(+BO)),F=+$G(O(+BO,+FO))
 S @DDSREFS@(DDSPG,"FIRST")=F_","_B
 ;
 S (BP,FP)=0
 S BO="" F  S BO=$O(O(BO)) Q:BO=""  D
 . S B=+O(BO),F=0
 . S FO=$O(O(BO,"")) S:FO]"" F=O(BO,FO)
 . S $P(@DDSREFS@(DDSPG,B),U,9)=F
 . S:$P(O(BO),U,2)]"" $P(@DDSREFS@(DDSPG,B),U,10)=$S($P(O(BO),U,2)="FIRST":F,1:$P(O(BO),U,2))
 . S FO="" F  S FO=$O(O(BO,FO)) Q:FO=""  D
 .. S F=O(BO,FO)
 .. S $P(@DDSREFS@(DDSPG,BP,FP,"N"),U,5)=F_$S(B'=BP:","_B,1:"")
 .. S FP=F,BP=B
 S $P(@DDSREFS@(DDSPG,BP,FP,"N"),U,5)=0
 Q
 ;
RNAV(DDSRNAV,DDSO) ;Setup nav and fo info for rep blocks
 N DDSBO,DDSN,B,D1,D2,DN,F,F1,FO,LN,NX,RT
 S DDSBO="" F  S DDSBO=$O(DDSRNAV(DDSBO)) Q:DDSBO=""  D
 . K DDSN M DDSN=DDSRNAV(DDSBO)
 . S D1="" F  S D1=$O(DDSN(D1)) Q:D1=""  D:$D(DDSN(D1))#2
 .. S B=DDSN(D1)
 .. N HITE S HITE=$$HITE^DDSR(B)
 .. S D2="" F  S D2=$O(DDSN(D1,D2)) Q:D2=""  D
 ... S F=DDSN(D1,D2),LN="" Q:F[","
 ... D NAV1(.DDSN,.DDSRNAV,D1,D2,.LN)
 ... S $P(@DDSREFS@(DDSPG,B,F,"N"),U,6,9)=LN
 ... Q:HITE<2  ;GFT
FIRST ...S FO=$O(DDSO(DDSBO,"")) S:FO FO=DDSO(DDSBO,FO)
 ...S F1=$O(DDSO(DDSBO,""),-1) S:F1 F1=DDSO(DDSBO,F1)
 ... I $P(@DDSREFS@(DDSPG,B,F,"N"),U,9)["-" S $P(^("N"),U,9)=$P(^("N"),U,4) I $P(^("N"),U,4)[","!'$P(^("N"),U,4) S $P(^("N"),U,9)=F1_",-1" ;WHERE 'F4' GOES
 ... I $P(^("N"),U,8)["+" S $P(^("N"),U,8)=$P(^("N"),U,3) I '$P(^("N"),U,3) S $P(^("N"),U,8)=FO_",+1" ;WHERE 'TAB' GOES
 . S B=+$G(DDSO(+DDSBO)) Q:'B
 . S FO=$O(DDSO(DDSBO,"")) Q:FO=""
 . S (F,F1)=DDSO(DDSBO,FO)
 . F  S FO=$O(DDSO(DDSBO,FO)) Q:FO=""  D
 .. S $P(@DDSREFS@(DDSPG,B,F,"N"),U,10)=DDSO(DDSBO,FO)
 .. S F=DDSO(DDSBO,FO)
 . S $P(@DDSREFS@(DDSPG,B,F,"N"),U,10)=F1_",+1"
 . ;
 . S DN=0
 . S F=0 F  S F=$O(@DDSREFS@(DDSPG,B,F)) Q:DN=2!(F="")  D
 .. S LN=$G(@DDSREFS@(DDSPG,B,F,"N")) Q:LN=""
 .. S RT=$P(LN,U,3),NX=$P(LN,U,5)
 .. S:RT[","!'RT DN=DN+1
 .. S:NX[","!'NX DN=DN+1
 . ;
 . S F=0 F  S F=$O(@DDSREFS@(DDSPG,B,F)) Q:F=""  D
 .. S $P(@DDSREFS@(DDSPG,B,F,"N"),U,3)=RT
 .. S $P(@DDSREFS@(DDSPG,B,F,"N"),U,5)=NX
 Q
