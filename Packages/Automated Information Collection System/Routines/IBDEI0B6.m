IBDEI0B6 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5242,1,2,0)
 ;;=2^11305
 ;;^UTILITY(U,$J,358.3,5242,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk: 0.5cm or less
 ;;^UTILITY(U,$J,358.3,5243,0)
 ;;=11306^^40^444^2^^^^1
 ;;^UTILITY(U,$J,358.3,5243,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5243,1,2,0)
 ;;=2^11306
 ;;^UTILITY(U,$J,358.3,5243,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk: 0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5244,0)
 ;;=11307^^40^444^3^^^^1
 ;;^UTILITY(U,$J,358.3,5244,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5244,1,2,0)
 ;;=2^11307
 ;;^UTILITY(U,$J,358.3,5244,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk: 1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5245,0)
 ;;=11308^^40^444^4^^^^1
 ;;^UTILITY(U,$J,358.3,5245,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5245,1,2,0)
 ;;=2^11308
 ;;^UTILITY(U,$J,358.3,5245,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk > 2.0cm
 ;;^UTILITY(U,$J,358.3,5246,0)
 ;;=11310^^40^445^1^^^^1
 ;;^UTILITY(U,$J,358.3,5246,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5246,1,2,0)
 ;;=2^11310
 ;;^UTILITY(U,$J,358.3,5246,1,3,0)
 ;;=3^Shaving Epiderm Face/Mucous:0.5cm or less
 ;;^UTILITY(U,$J,358.3,5247,0)
 ;;=11311^^40^445^2^^^^1
 ;;^UTILITY(U,$J,358.3,5247,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5247,1,2,0)
 ;;=2^11311
 ;;^UTILITY(U,$J,358.3,5247,1,3,0)
 ;;=3^Shaving Epiderm Face/Mucous: 0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5248,0)
 ;;=11312^^40^445^3^^^^1
 ;;^UTILITY(U,$J,358.3,5248,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5248,1,2,0)
 ;;=2^11312
 ;;^UTILITY(U,$J,358.3,5248,1,3,0)
 ;;=3^Shaving Epiderm Face/Mucous: 1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5249,0)
 ;;=11313^^40^445^4^^^^1
 ;;^UTILITY(U,$J,358.3,5249,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5249,1,2,0)
 ;;=2^11313
 ;;^UTILITY(U,$J,358.3,5249,1,3,0)
 ;;=3^Shaving Epiderm Face/Mucous > 2.0cm
 ;;^UTILITY(U,$J,358.3,5250,0)
 ;;=12011^^40^446^1^^^^1
 ;;^UTILITY(U,$J,358.3,5250,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5250,1,2,0)
 ;;=2^12011
 ;;^UTILITY(U,$J,358.3,5250,1,3,0)
 ;;=3^Simple repair Face/Mucous; 2.5 cm or less
 ;;^UTILITY(U,$J,358.3,5251,0)
 ;;=12013^^40^446^2^^^^1
 ;;^UTILITY(U,$J,358.3,5251,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5251,1,2,0)
 ;;=2^12013
 ;;^UTILITY(U,$J,358.3,5251,1,3,0)
 ;;=3^Simple repair Face/Mucous; 2.6 cm to 5.0 cm
 ;;^UTILITY(U,$J,358.3,5252,0)
 ;;=12014^^40^446^3^^^^1
 ;;^UTILITY(U,$J,358.3,5252,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5252,1,2,0)
 ;;=2^12014
 ;;^UTILITY(U,$J,358.3,5252,1,3,0)
 ;;=3^Simple repair Face/Mucous; 5.1 cm to 7.5 cm
 ;;^UTILITY(U,$J,358.3,5253,0)
 ;;=12015^^40^446^4^^^^1
 ;;^UTILITY(U,$J,358.3,5253,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5253,1,2,0)
 ;;=2^12015
 ;;^UTILITY(U,$J,358.3,5253,1,3,0)
 ;;=3^Simple repair Face/Mucous; 7.6 cm to 12.5 cm
 ;;^UTILITY(U,$J,358.3,5254,0)
 ;;=12016^^40^446^5^^^^1
 ;;^UTILITY(U,$J,358.3,5254,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5254,1,2,0)
 ;;=2^12016
 ;;^UTILITY(U,$J,358.3,5254,1,3,0)
 ;;=3^Simple repair Face/Mucous; 12.6 cm to 20 cm
 ;;^UTILITY(U,$J,358.3,5255,0)
 ;;=12017^^40^446^6^^^^1
 ;;^UTILITY(U,$J,358.3,5255,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5255,1,2,0)
 ;;=2^12017
 ;;^UTILITY(U,$J,358.3,5255,1,3,0)
 ;;=3^Simple repair Face/Mucous; 20.1 cm to 30 cm
 ;;^UTILITY(U,$J,358.3,5256,0)
 ;;=12018^^40^446^7^^^^1
 ;;^UTILITY(U,$J,358.3,5256,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5256,1,2,0)
 ;;=2^12018
 ;;^UTILITY(U,$J,358.3,5256,1,3,0)
 ;;=3^Simple repair Face/Mucous; over 30 cm
 ;;^UTILITY(U,$J,358.3,5257,0)
 ;;=12020^^40^446^8^^^^1
 ;;^UTILITY(U,$J,358.3,5257,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5257,1,2,0)
 ;;=2^12020
