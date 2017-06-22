DICATTD5 ;GFT/GFT - SUBDICTIONARY NUMBER FOR MULTIPLE FIELDS IN SCREENMAN ;06:12 PM  23 Nov 1998
 ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
SUBDIC ;
 N %,DE
 S %=$P(DICATTA,"."),DE=%_"."_+$P(DICATTA,".",2)_DICATTF
 I +DE'=DE!$D(^DD(DE)) F DE=DICATTA+.01:.01:%+.7,%+.7:.001:%+.9,%+.9:.0001 Q:DE>DICATTA&'$D(^DD(DE))
 S Y=DE Q
 ;
CHKDIC ;
 N %
 S %=$P(DICATTA,".")
 I X<DICATTA K X Q
 I %+1'>X!$D(^DD(X)) K X Q
 Q
