DI ;SFISC/GFT-DIRECT ENTRY TO VA FILEMAN ;2OCT2012
V ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 G QQ:$G(^DI(.84,0))']""
C G QQ:$G(^DI(.84,0))']"" K (DTIME,DUZ) G ^DII
D G QQ:$G(^DI(.84,0))']"" G ^DII
P G QQ:$G(^DI(.84,0))']"" K (DTIME,DUZ)
Q G QQ:$G(^DI(.84,0))']"" S DUZ(0)="@" G ^DII
VERSION ;
 S VERSION=$P($T(V),";",3),X=$P($T(V),";",4)_" "_VERSION Q
 ;
QQ ;
 W $C(7),!!,"You must run ^DINIT first."
 Q
