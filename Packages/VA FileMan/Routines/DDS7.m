DDS7 ;SFISC/MKO-Relational ;1:39 PM  28 Jun 1996
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
RPB(DDP,DDSFLD,DDSPG) ;Repaint pointed-to block(s) recursively
 N DDS7B
 S DDS7B=""
 F  S DDS7B=$O(@DDSREFS@("PT",DDP,DDSFLD,DDSPG,DDS7B)) Q:DDS7B=""  D
 . N DDP,DDSFLD
 . I $P($G(@DDSREFS@(DDSPG,DDS7B)),U,8) D
 .. D BLK^DDS1(DDSPG,DDS7B,"","",1)
 .. D DB^DDSR(DDSPG,DDS7B)
 . S DDP=$P($G(@DDSREFS@(DDSPG,DDS7B)),U,3)
 . D:$D(@DDSREFS@("PT",DDP))
 .. S DDSFLD=""
 .. F  S DDSFLD=$O(@DDSREFS@("PT",DDP,DDSFLD)) Q:DDSFLD=""  D
 ... D:$D(@DDSREFS@("PT",DDP,DDSFLD,DDSPG)) RPB(DDP,DDSFLD,DDSPG)
 Q
 ;
RPF(DDP,DDSPTB,DDSDA,DA) ;Repaint and update pointer field of
 ;pointer blocks because user changed the .01 value
 S DDS7V=$G(@DDSREFT@("F"_DDP,DDSDA,.01,"D")) I DDS7V]"",$D(^("X"))#2 S DDS7V=^("X")
 S DDS7DAS=U_DA_U
 F DDS7I=$L(DDSPTB,U):-1:1 D  Q:$G(DDS7FD)'=.01
 . S DDS7PTB=$P(DDSPTB,U,DDS7I)
 . D:DDS7PTB]"" RPF1
 K DDS7B,DDS7D,DDS7DA,DDS7DAS,DDS7DAST,DDS7DDO,DDS7FD,DDS7FI
 K DDS7I,DDS7L,DDS7PTB,DDS7REF,DDS7RJ,DDS7V,DDS7X
 Q
RPF1 ;
 I DDS7PTB[";J" S DDS7FD="" Q
 S DDS7PTB=$P(DDS7PTB,";")
 I $L(DDS7PTB,",")=2 S DDS7FI=+DDS7PTB,DDS7FD=$P(DDS7PTB,",",2)
 E  I $L(DDS7PTB,",")=3 S DDS7FI=0,DDS7FD=$P(DDS7PTB,",",2,3)
 E  Q
 Q:DDS7FI=""!(DDS7FD="")
 ;
 ;Repaint pointer field on current page
 S DDS7B=""
 F  S DDS7B=$O(@DDSREFS@("F"_DDS7FI,DDS7FD,"L",DDSPG,DDS7B))  Q:DDS7B=""  D
 . S DDS7DDO=""
 . F  S DDS7DDO=$O(@DDSREFS@("F"_DDS7FI,DDS7FD,"L",DDSPG,DDS7B,DDS7DDO)) Q:DDS7DDO=""  D
 .. Q:$G(@DDSREFS@(DDSPG,DDS7B,DDS7DDO,"D"))=""  S DY=+^("D"),DX=$P(^("D"),U,2),DDS7L=$P(^("D"),U,3),DDS7RJ=$P(^("D"),U,10)
 .. X IOXY
 .. S DDS7X=$P(DDGLVID,DDGLDEL)_$E(DDS7V,1,DDS7L)_$P(DDGLVID,DDGLDEL,10)
 .. W $S(DDS7RJ:$J(" ",DDS7L-$L(DDS7V))_DDS7X,1:DDS7X_$J(" ",DDS7L-$L(DDS7V)))
 ;
 ;Reset external form of pointer data.
 ;
 ;If the pointer field is the .01, then we may have to follow back
 ;to pointers that point to this pointer block.
 ;
 ;DDS7DAS initially contains a list of records whose .01s we changed.
 ;DDS7DAST keeps a running list of all records in the pointer block
 ;that we change.
 ;DDS7DAS is finally set to this running list, so that when we go
 ;to update the pointer to the pointer block, we know which pointers
 ;to update.
 ;
 S DDS7DAST="",DDS7DA=" "
 F  S DDS7DA=$O(@DDSREFT@("F"_DDS7FI,DDS7DA)) Q:DDS7DA'[","  D
 . S DDS7REF=$NA(@DDSREFT@("F"_DDS7FI,DDS7DA,DDS7FD))
 . S DDS7D=$G(@DDS7REF@("D"))
 . I DDS7DAS[(U_$P(DDS7D,";")_U),$S(DDS7D[";":U_$P(DDS7D,";",2)=DIE,1:1) D
 .. I DDS7V="",DDS7FD'=.01 S @DDS7REF@("D")="",^("F")=3
 .. S:$D(@DDS7REF@("X"))#2 ^("X")=$S(DDS7V=""&(DDS7FD=.01):@DDS7REF@("D"),1:DDS7V)
 .. I DDS7FD=.01,DDS7DAST_U'[(U_+DDS7DA_U) S DDS7DAST=DDS7DAST_U_+DDS7DA
 S DDS7DAS=DDS7DAST_U
 Q
