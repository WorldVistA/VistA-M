DINIT013 ; SFISC/TKW,VEN/SMH-DIALOG & LANGUAGE FILE INITS ; 6DEC2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**41,110**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",11.1,0)
 ;;=^.114IA^1^1
 ;;^UTILITY("KX",$J,"IX",.85,.85,"E",11.1,1,0)
 ;;=1^F^.85^.05^^1^F
 ;;^UTILITY("KX",$J,"KEY",.85,.85,"A",0)
 ;;=.85^A^P^1046
 ;;^UTILITY("KX",$J,"KEY",.85,.85,"A",2,0)
 ;;=^.312IA^1^1
 ;;^UTILITY("KX",$J,"KEY",.85,.85,"A",2,1,0)
 ;;=.01^.85^1
 ;;^UTILITY("KX",$J,"KEY",.85,.85,"B",0)
 ;;=.85^B^S^1048
 ;;^UTILITY("KX",$J,"KEY",.85,.85,"B",2,0)
 ;;=^.312IA^1^1
 ;;^UTILITY("KX",$J,"KEY",.85,.85,"B",2,1,0)
 ;;=.03^.85^1
 ;;^UTILITY("KX",$J,"KEYPTR",.85,.85,"A")
 ;;=.85^B
 ;;^UTILITY("KX",$J,"KEYPTR",.85,.85,"B")
 ;;=.85^D
 ;;^UTILITY(U,$J,.85)
 ;;=^DI(.85,
 ;;^UTILITY(U,$J,.85,0)
 ;;=LANGUAGE^.85I^18^11
 ;;^UTILITY(U,$J,.85,1,0)
 ;;=ENGLISH^EN^ENG
 ;;^UTILITY(U,$J,.85,1,1,0)
 ;;=^.8501^2^2
 ;;^UTILITY(U,$J,.85,1,1,1,0)
 ;;=MODERN ENGLISH (1500-)
 ;;^UTILITY(U,$J,.85,1,1,2,0)
 ;;=ENGLISH,MODERN (1500-)
 ;;^UTILITY(U,$J,.85,1,"CRD")
 ;;=I Y S Y=$FN(Y,",")
 ;;^UTILITY(U,$J,.85,1,"DD")
 ;;=S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12)_$S($E(Y,13,14):":"_$E(Y_0,13,14),1:""),"^",Y[".")
 ;;^UTILITY(U,$J,.85,1,"FMTE")
 ;;=N RTN,%T S %T="."_$E($P(Y,".",2)_"000000",1,7),%F=$G(%F),RTN="F"_$S(%F<1:1,%F>7:1,1:+%F\1)_"^DILIBF" D @RTN S Y=%R
 ;;^UTILITY(U,$J,.85,1,"LC")
 ;;=S Y=$TR(Y,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 ;;^UTILITY(U,$J,.85,1,"ORD")
 ;;=I $G(Y) S Y=Y_$S(Y#10=1&(Y#100-11):"ST",Y#10=2&(Y#100-12):"ND",Y#10=3&(Y#100-13):"RD",1:"TH")
 ;;^UTILITY(U,$J,.85,1,"TIME")
 ;;=S Y=$S($L($G(Y),".")>1:$E(Y_0,9,10)_":"_$E(Y_"000",11,12)_$S($E(Y,13,14):":"_$E(Y_0,13,14),1:""),1:"")
 ;;^UTILITY(U,$J,.85,1,"UC")
 ;;=S Y=$TR(Y,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;;^UTILITY(U,$J,.85,2,0)
 ;;=GERMAN^DE^DEU^^GER
 ;;^UTILITY(U,$J,.85,2,1,0)
 ;;=^.8501^7^7
 ;;^UTILITY(U,$J,.85,2,1,1,0)
 ;;=GERMAN, STANDARD
 ;;^UTILITY(U,$J,.85,2,1,2,0)
 ;;=STANDARD GERMAN
 ;;^UTILITY(U,$J,.85,2,1,3,0)
 ;;=DEUTSCH
 ;;^UTILITY(U,$J,.85,2,1,4,0)
 ;;=DEUTSCH SPRACHE
 ;;^UTILITY(U,$J,.85,2,1,5,0)
 ;;=TEDESCO
 ;;^UTILITY(U,$J,.85,2,1,6,0)
 ;;=MODERN GERMAN (1500-)
 ;;^UTILITY(U,$J,.85,2,1,7,0)
 ;;=GERMAN,MODERN (1500-)
 ;;^UTILITY(U,$J,.85,2,"CRD")
 ;;=S:$G(Y) Y=$TR($FN(Y,","),",",".")
 ;;^UTILITY(U,$J,.85,2,"DD")
 ;;=S:Y Y=$S($E(Y,6,7):$E(Y,6,7)_".",1:"")_$S($E(Y,4,5):$E(Y,4,5)_".",1:"")_($E(Y,1,3)+1700)_$P(" "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12)_$S($E(Y,13,14):":"_$E(Y_0,13,14),1:""),"^",Y[".")
 ;;^UTILITY(U,$J,.85,2,"LC")
 ;;=S Y=$TR(Y,"ABCDEFGHIJKLMNOPQRSTUVWXYZ[]\","abcdefghijklmnopqrstuvwxyz{}|")
 ;;^UTILITY(U,$J,.85,2,"ORD")
 ;;=S:$G(Y) Y=Y_"."
 ;;^UTILITY(U,$J,.85,2,"TIME")
 ;;=S Y=$S($L($G(Y),".")>1:$E(Y_0,9,10)_":"_$E(Y_"000",11,12)_$S($E(Y,13,14):":"_$E(Y_0,13,14),1:""),1:"")
 ;;^UTILITY(U,$J,.85,2,"UC")
 ;;=S Y=$TR(Y,"abcdefghijklmnopqrstuvwxyz{}|","ABCDEFGHIJKLMNOPQRSTUVWXYZ[]\")
 ;;^UTILITY(U,$J,.85,3,0)
 ;;=SPANISH^ES^SPA
 ;;^UTILITY(U,$J,.85,3,1,0)
 ;;=^.8501^5^5
 ;;^UTILITY(U,$J,.85,3,1,1,0)
 ;;=CASTILIAN
 ;;^UTILITY(U,$J,.85,3,1,2,0)
 ;;=CASTELLANO
 ;;^UTILITY(U,$J,.85,3,1,3,0)
 ;;=ESPANOL
 ;;^UTILITY(U,$J,.85,3,1,4,0)
 ;;=MODERN SPANISH (1500-)
 ;;^UTILITY(U,$J,.85,3,1,5,0)
 ;;=SPANISH, MODERN (1500-)
 ;;^UTILITY(U,$J,.85,4,0)
 ;;=FRENCH^FR^FRA^^FRE
 ;;^UTILITY(U,$J,.85,4,1,0)
 ;;=^.8501^3^3
 ;;^UTILITY(U,$J,.85,4,1,1,0)
 ;;=FRANCAIS
 ;;^UTILITY(U,$J,.85,4,1,2,0)
 ;;=MODERN FRENCH (1600-)
 ;;^UTILITY(U,$J,.85,4,1,3,0)
 ;;=FRENCH, MODERN (1600-)
 ;;^UTILITY(U,$J,.85,5,0)
 ;;=FINNISH^FI^FIN
 ;;^UTILITY(U,$J,.85,5,1,0)
 ;;=^.8501^3^3
 ;;^UTILITY(U,$J,.85,5,1,1,0)
 ;;=SUOMEA
 ;;^UTILITY(U,$J,.85,5,1,2,0)
 ;;=SUOMI
 ;;^UTILITY(U,$J,.85,5,1,3,0)
 ;;=SUOMEN KIELI
 ;;^UTILITY(U,$J,.85,5,"DD")
 ;;=X:$G(Y) ^DD("DD")
 ;;^UTILITY(U,$J,.85,5,"ORD")
 ;;=I $G(Y) S Y=Y_"."
 ;;^UTILITY(U,$J,.85,6,0)
 ;;=ITALIAN^IT^ITA
 ;;^UTILITY(U,$J,.85,6,1,0)
 ;;=^.8501^2^2
 ;;^UTILITY(U,$J,.85,6,1,1,0)
 ;;=ITALIANO
 ;;^UTILITY(U,$J,.85,6,1,2,0)
 ;;=LINGUA ITALIANA
 ;;^UTILITY(U,$J,.85,7,0)
 ;;=PORTUGUESE^PT^POR
 ;;^UTILITY(U,$J,.85,7,1,0)
 ;;=^.8501^4^4
 ;;^UTILITY(U,$J,.85,7,1,1,0)
 ;;=PORTUGUES
 ;;^UTILITY(U,$J,.85,7,1,2,0)
 ;;=LINGUA PORTUGUESA
 ;;^UTILITY(U,$J,.85,7,1,3,0)
 ;;=MODERN PORTUGUESE (1516-)
 ;;^UTILITY(U,$J,.85,7,1,4,0)
 ;;=PORTUGUESE, MODERN (1516-)
 ;;^UTILITY(U,$J,.85,10,0)
 ;;=ARABIC^AR^ARA
 ;;^UTILITY(U,$J,.85,10,1,0)
 ;;=^.8501^2^2
 ;;^UTILITY(U,$J,.85,10,1,1,0)
 ;;=AL-'ARABIYYAH
 ;;^UTILITY(U,$J,.85,10,1,2,0)
 ;;='ARABI
 ;;^UTILITY(U,$J,.85,11,0)
 ;;=RUSSIAN^RU^RUS
 ;;^UTILITY(U,$J,.85,11,1,0)
 ;;=^.8501^2^2
 ;;^UTILITY(U,$J,.85,11,1,1,0)
 ;;=RUSSKI
 ;;^UTILITY(U,$J,.85,11,1,2,0)
 ;;=RUSSKIY YAZYK
 ;;^UTILITY(U,$J,.85,12,0)
 ;;=GREEK^EL^ELL^^GRE
 ;;^UTILITY(U,$J,.85,12,1,0)
 ;;=^.8501^9^9
 ;;^UTILITY(U,$J,.85,12,1,1,0)
 ;;=ELLINIKA
 ;;^UTILITY(U,$J,.85,12,1,2,0)
 ;;=ELLINIKI GLOSSA
 ;;^UTILITY(U,$J,.85,12,1,3,0)
 ;;=GRAECAE
 ;;^UTILITY(U,$J,.85,12,1,4,0)
 ;;=GREC
 ;;^UTILITY(U,$J,.85,12,1,5,0)
 ;;=GRECO
 ;;^UTILITY(U,$J,.85,12,1,6,0)
 ;;=NEO-HELLENIC
 ;;^UTILITY(U,$J,.85,12,1,7,0)
 ;;=ROMAIC
 ;;^UTILITY(U,$J,.85,12,1,8,0)
 ;;=MODERN GREEK (1453-)
 ;;^UTILITY(U,$J,.85,12,1,9,0)
 ;;=GREEK, MODERN (1453-)
 ;;^UTILITY(U,$J,.85,18,0)
 ;;=HEBREW^HE^HEB
 ;;^UTILITY(U,$J,.85,18,1,0)
 ;;=^.8501^3^3
 ;;^UTILITY(U,$J,.85,18,1,1,0)
 ;;=IVRIT
 ;;^UTILITY(U,$J,.85,18,1,2,0)
 ;;=MODERN HEBREW (1881-)
 ;;^UTILITY(U,$J,.85,18,1,3,0)
 ;;=HEBREW, MODERN (1881-)
