DDSR1 ;SFISC/MKO-PAINT ;08:09 AM  20 May 1994
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CAP ;Write captions in "X" nodes
 W:$D(DDGLVAN) $P(DDGLVID,DDGLDEL,2)
 ;
 S DY=""
 F  S DY=$O(@DDSREFS@("X",DDS3P,DY)) Q:DY=""  S DX=$O(^(DY,"")),DDS3CAP=^(DX) D:$D(^(DX))=11  X IOXY W DDS3CAP
 . N A,C,C1,C2,P,PC,V,X
 . Q:'$D(@DDSREFS@("X",DDS3P,DY,DX,"A"))  S A=^("A")
 . S X=DDS3CAP,DDS3CAP="",P=1
 . F PC=1:1:$L(A,U) S C=$P(A,U,PC) D:C]""
 .. S C1=$P(C,";"),C2=$P(C,";",2)
 .. S V=$S($P(C,";",3)="U":$P(DDGLVID,DDGLDEL,4),1:"")
 .. S DDS3CAP=DDS3CAP_$E(X,P,C1-1)_V_$E(X,C1,C2)_$P(DDGLVID,DDGLDEL,10)_$S($D(DDGLVAN):$P(DDGLVID,DDGLDEL,2),1:"")
 .. S P=C2+1
 . S DDS3CAP=DDS3CAP_$E(X,P,999)
 ;
 W:$D(DDGLVAN) $P(DDGLVID,DDGLDEL,10)
 K DDS3CAP
 Q
