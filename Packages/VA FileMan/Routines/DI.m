DI ;SFISC/GFT-DIRECT ENTRY TO VA FILEMAN ;06 Aug 2015  3:02 PM
V ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ; Per VHA Directive 2004-038, this routine should not be modified.
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
