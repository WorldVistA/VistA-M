DIPZ1 ;SFISC/GFT,XAK-COMPILE PRINT TEMPLATES ;30JAN2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
PX ;
 F DX=DX+1:1 I '$D(^UTILITY("DIPZ",$J,DX)) S ^(DX)=" "_$E(Y,2,999) Q
 W:'$G(DIPZS) "." S O=0,DIPZL=$L(Y)+DIPZL+2 I DIPZL>DMAX S DRN(DRN)=DX,^(DX+1)=^(DX),DIPZL=$L(Y)+2,DRN=DRN+1,^(DX)=" G ^"_DNM_DRN,DX=DX+1
 Q
 ;
DE ;
 D SUBNAME S DX=F(DM-1),^(DX)=^(DX)_" D "_X
D S DIPZL(DM)=DX+1,DIPZLR(DM)=DRN,^(DX+1)=" G "_X_"R",^(DX+2)=X_" ;",DX=DX+2 Q
 ;
DIWR ;
 S I=$D(^UTILITY("DIPZ",$J,1)) I $D(DIWR(DM)),DX=DIWR(DM) S ^(DX)=" D A^DIWW"
 E  I $D(DIWR(DM)) S DX=DX+1,^(DX)=" D ^DIWW"
 E  F I=DM-1:-1:0 I $D(DIWR(I)) K DIWR(I) S I=F(I),^(I-.1)=" D ^DIWW" Q
 K DIWR(DM) Q
 ;
WP ;
 S I=$E(^UTILITY("DIPZ",$J,X),2,999) D WPX^DIL0 S ^UTILITY("DIPZ",$J,X)=" "_I Q
 ;
DREL ;
 S %=X,DHT=Y,DM=DM+1 D SUBNAME F DX=DX+1:1 I '$D(^UTILITY("DIPZ",$J,DX)) S ^(DX)=" S DICMX=""D "_X_U_DNM_""",DIXX("_DM_")="""_X_""""_% Q
 D D S DX=DX+2,^(DX-1)=" I $D(DSC("_DP_")) X DSC("_DP_") E  Q",^(DX)=" W:$X>"_DG_" !"_DHT,DHT=-1,F=F_+W_C,DIL=DIL+1,DD=DD-1,%=DX Q
 ;
UP ;
 S ^UTILITY("DIPZ",$J,DX+1)=" Q",X=DIPZ(DM) D X
 S (F(DM-1),DX)=DX+2,^UTILITY("DIPZ",$J,DX)=X_"R ;" S:DIPZLR(DM)'=DRN ^(DIPZL(DM))=^(DIPZL(DM))_"^"_DNM_DRN Q
 ;
SUBNAME S (DIPZ(DM),X)=$G(DIPZ(DM))+1
X S X=$S(X<27:$C(64+X),1:$C(X\26+64,X#26+65))_DM Q
