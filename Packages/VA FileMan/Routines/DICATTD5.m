DICATTD5 ;GFT ;06:12 PM  23 Nov 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
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
