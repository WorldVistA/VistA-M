DITIME ;O-OIFO/GFT - INPUT TRANSFROM FOR 'TIME' DATA TYPE ;05OCT2016
 ;;22.2;VA FileMan;**2**;Jan 05, 2016;Build 139
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;ENTER WITH X
 N Y,%DT I X?1.A1(1"+",1"-")1.N1(1"D",1"M",1"W") G KX  ;NO DAYS, WEEKS, OR MONTHS
 I X?.N D  Q:'$D(X)
 .S Y=$G(DIPA("SECONDS ALLOWED"))
 .I 'Y S Y=$E(X,5,999),X=$E(X,1,4) I Y'="00"&(Y]"") K X Q
 .S X=$E(X,1,6)
 S:X?1N.E X="T@"_X
 S %DT=$P("S",U,$G(DIPA("SECONDS ALLOWED"))'=0)_"R"
 D ^%DT
 S X=$E(Y_"000000",9,14)
 G:Y<0 KX
 I '$D(DIQUIET) S Y=X X $$METH4TYP^DIETLIBF("OUTPUT TRANSFORM",13) W "  (",Y,")"
 Q
KX K X Q
 ;
 ;
