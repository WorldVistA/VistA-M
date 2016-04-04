DICOMPX ;SFISC/GFT-EVALUATE COMPUTED FLD EXPR ;2014-12-26  9:30 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**6,76,114,1014,1040,1046**
 ;
M ;From DICOMP
 S DICOMPXM=M
 F  D F Q:$D(X)  D  Q:'$D(X)  ;Try as long a file name as possible
 .I M<$L(I) F M=M+1:1 S W=$E(I,M) I DPUNC[W S X=$E(I,1,M-1) Q
 S:'$D(X) M=DICOMPXM K DICOMPXM
 Q
 ;
F I '$D(J(0)) K X Q
 S DIC("S")="I $P(^(0),U,2),$P(^DD(+$P(^(0),U,2),.01,0),U,2)'[""W"""
MM S DICN=X,T=DLV S:X?1"#".NP X=$E(X,2,99)
TRY S DIC="^DD("_J(T)_",",DG=$O(^DD(J(T),0,"NM",0))_" " D DICS^DICOMPY,^DIC G R:Y<0
 F D=M:1:$L(I)+1 Q:$F(X,$E(I,1,D))-1-D  S W=$E(I,D+1)
 I DICOMP["?",$P(Y,U,2)'=DICN W !?3,"By '"_DICN_"', do you mean the '"_$P(Y,U,2)_"' Subfield" S %=1 D YN^DICN I %-1 G R:%+1 K X Q
 S M=D,Y=+$P(Y(0),U,2),X=$P($P(Y(0),U,4),";") I +X'=X S X=""""_X_""""
 S (DLV,D)=DLV0+100 F %=T\100*100:1 Q:%>T  S J(DLV)=J(%),I(DLV)=I(%),DLV=DLV+1
 S I(DLV)=X,X=$$CONVQQ^DILIBF(I(D)),J(DLV)=Y D  S DLV0=DLV0+100 F DLV=D:1:DLV D SN
REF .F Y=D+1:1:DLV S V=Y#100-1,DICN=$$CONVQQ^DILIBF(I(Y)),X=X_$S(T<DLV0:"I("_(T\100*100+V)_",0)",1:"D"_V)_","_DICN_","
Q Q
 ;
R I X]"",$P(X,DG)="",X=DICN S X=$P(X,DG,2,9) G TRY
 S T=T-1 I T'<0 G TRY:$D(J(T)) F T=T-99:1 G TRY:'$D(J(T+1))
FILEQ S X=DICN,DIC=1 D DRW,^DIC I Y>0 S X=$$CONVQQ^DILIBF(^(0,"GL")) G Y
 K X Q
 ;
Y ;
 S DLV0=DLV0+100,I(DLV0)=^DIC(+Y,0,"GL"),J(DLV0)=+Y F DLV=DLV+100:-1:DLV0 D SN
 Q
 ;
SN D SV(DLV0-100) S DG(DLV0)=DLV Q
 ;
SV(%X) ;also called from DICOMPY
 S (T,DG(%X))=DG(%X)+1,%=DLV#100,K(K+2,1)=DLV0,DG(%X,T)=%,M(%,%X+%)=T Q
 ;
 ;
OKFILE(Y,DICOMP) ;Called from DICATT6 Block, DICATT3, DICOMP0 to see if we can jump to FILE Y
 I DICOMP'["W",DICOMP'["?" Q 1 ;DICOMP either does or doesn't contain "W" and "?"
 N D,DIC,DIAC,DIFILE,%
 D DRW I $D(^DIC(Y,0)) X DIC("S")
 Q $T
 ;
DRW ;also called from DICOMPV, and DICOMPW to filter FILE names
 S D=$S(DICOMP["W":"""WR""",1:"""RD""")
 S DIC("S")="S DIAC="_D_",DIFILE=+Y D ^DIAC I %"
 Q
 ;
P ;from DINUM^DICOMPV, DICOMP0
 S X=" S D0="_X_" S:'D0!'$D("_%Y_"+D0,0)) D0=-1 S D0=D0"
 I $D(DICOMPX(0)) S X=X_" S "_DICOMPX(0)_"0)=D0",DICOMPX(0,DICN)=""
 D ST
 I W=":" D
 .S M=M+1,W="",%=$E(I,M,999) I %,+%=$P(%,")") S I=$E(I,1,M-1)_"#"_%
 E  S I="#.01"_$E(I,M,999),M=1,W=""
 S DLV0=DLV0+100,I(DLV0)=%Y,J(DLV0)=DICN F DLV=DLV+100:-1:DLV0 D SN
 Q
 ;
ST N X D ST^DICOMP S DPS(DPS,"ST")=1,K=K+1,K(K)=X
 Q
