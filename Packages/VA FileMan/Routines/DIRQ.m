DIRQ ;SFISC/XAK-READER-MAID END ;7/11/94  14:34
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 K:$D(%G) DIR("B")
 K DIR0("L")
 Q
DA I DA'=+$P(DA,"E") K DA Q
 S (X,Y)=%B1,DA(0)=DA
 F %=0:1 Q:'$D(^DD(X,0,"UP"))  S X=^("UP"),%P=$O(^DD(X,"SB",Y,0)),%(%)=""""_$P($P(^DD(X,%P,0),U,4),";")_""",",Y=X
 S %(%)=$S($D(^DIC(X,0,"GL")):^("GL"),1:"") G Q:%(%)=""
 S %G="" F %=%:-1:0 G GQ:'$D(DA(%)) S %G=%G_%(%)_DA(%)_","
 S %P=$P(%B3,U,4),%=$P(%P,";"),%G=%G_""""_%_""")" G GQ:'$D(@%G)
 S %G=$P(%P,";",2),Y=$S(%G:$P(^(%),U,%G),1:$E(^(%),+$P(%G,"E",2),$P(%G,",",2))) G GQ:Y=""
 S %G=Y,C=$P(^DD(%B1,%B2,0),U,2) D Y^DIQ S DIR("B")=Y G Q
GQ K %G
Q K %,%P,X,Y,DA(0) Q
