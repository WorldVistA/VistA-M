DIVU ;SFISC/DCM-VERIFY FIELDS UTILITIES ;8/1/95  1:02 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
DE(FI,FD,N,G,S) ;
 Q:'$D(^DD($G(FI),0))  I $G(FD) Q:'$D(^(FD,0))
 I $G(G)']"" S G="DE"
 N Z,X,Y,%,H,D,I,J,V,K
 I $G(^DIC(FI,0))]"" S I(0)=^(0,"GL"),J(0)=+FI,V=0
 E  D IJ(FI)
 S Y=I(0),X=V,H="",Z=0
 I +$G(S),V S S=$S('$P(S,U,2):V,1:$P(S,U,2)) S Z=S,X=X-S F %=0:1 S Y=Y_"D"_%_","_I(%+1)_","  I %=(S-1) Q
L S D="D" S D=D_Z S Y=Y_D,H=H_"S "_D_"=0 F  ",%="S "_D_"=$O("_Y_"))" I V>1 S @G@(Z)=%,H=H_"X "_G_"("_(Z)_")"
 E  S H=H_%
 S H=H_" Q:"_D_"'>0  "
 S X=X-1,Z=Z+1
L1 I X<0 D  Q
 .I $G(N)]"",$G(FD)]"" D  S H=H_" X "_G_"(99)",@G=H,@G@(99)=Y Q
 . . N DN,%,%N,%P,%4,Q
 . . S Q=";",%=^DD(FI,FD,0),%(2)=$G(^(2)),%4=$P(%,U,4),%N=$P(%4,Q),%P=$P(%4,Q,2)
 . . I FD=.001,%P="" S Y="S "_N_"=D"_V Q
 . . I %P=" " D CAL Q
 . . I $G(%P)]"" S Y=Y_","_%N_")"
 . . I %P S DN="$P(",%P="),U,"_%P_")"
 . . I $E(%P)="E" S DN="$E(",%P="),"_$E(%P,2,9)_")"
 . . I $G(DN)="" Q
 . . S Y="S "_N_"="_DN_"$G("_Y_%P
 . . I %(2)]"",$P(%,U,2)["O",$P(%,U,2)'["D" S Y=Y_",Y="_N_" "_%(2)_" S "_N_"=Y"
 . . Q
 . S @G=H Q
 S Y=Y_","_I(V-X)_"," G L
 ;
CAL S Y=$P(%,U,5,99)_" S "_N_"=X" Q
 Q
IJ(FI) ;set I( and J( and V=level
 Q:'$D(^DD($G(FI),0))
 N X,Y,S,Q,F S X=0,(S,Y)=FI,Q="""" F  Q:'$D(^DD(Y,0,"UP"))  S X=X+1,Y=^("UP")
 S V=X I X'=0 F X=X:-1 S Y=$G(^DD(S,0,"UP")) Q:'Y  S F=$O(^DD(Y,"SB",S,0)) Q:'F  S I(X)=$P($P($G(^DD(Y,F,0)),U,4),";"),K(X)=$O(^DD(S,0,"NM","")),J(X)=S,S=Y S:I(X)'=+I(X) I(X)=Q_I(X)_Q
 S I(0)=$G(^DIC(S,0,"GL")),J(0)=S
 Q
DA(Z) ;convert D0,D1... to DA()
 N A,B,C,D K Z
 F A=0:1 S D="D"_A Q:'$D(@D)
 S C=0,A=A-1 F B=A:-1:0 S Z(B)=@("D"_C),C=C+1
 S Z=Z(0) K Z(0)
 Q
DIBT(X,%,S) ;lookup sort template, return template's IEN
 N DIC,Y
 S X=$E(X,2,$L(X)-1),DIC="^DIBT(",DIC("S")="I $P(^(0),U,4)="_S,DIC(0)="ZM" D ^DIC
 S %=+Y
 Q
