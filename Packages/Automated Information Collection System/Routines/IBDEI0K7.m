IBDEI0K7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9115,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,9115,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,9116,0)
 ;;=I73.9^^55^560^5
 ;;^UTILITY(U,$J,358.3,9116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9116,1,3,0)
 ;;=3^Peripheral vascular disease, unspecified
 ;;^UTILITY(U,$J,358.3,9116,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,9116,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,9117,0)
 ;;=I80.9^^55^560^6
 ;;^UTILITY(U,$J,358.3,9117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9117,1,3,0)
 ;;=3^Phlebitis and thrombophlebitis of unspecified site
 ;;^UTILITY(U,$J,358.3,9117,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,9117,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,9118,0)
 ;;=I83.91^^55^560^3
 ;;^UTILITY(U,$J,358.3,9118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9118,1,3,0)
 ;;=3^Asymptomatic varicose veins of right lower extremity
 ;;^UTILITY(U,$J,358.3,9118,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,9118,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,9119,0)
 ;;=I83.92^^55^560^2
 ;;^UTILITY(U,$J,358.3,9119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9119,1,3,0)
 ;;=3^Asymptomatic varicose veins of left lower extremity
 ;;^UTILITY(U,$J,358.3,9119,1,4,0)
 ;;=4^I83.92
 ;;^UTILITY(U,$J,358.3,9119,2)
 ;;=^5008021
 ;;^UTILITY(U,$J,358.3,9120,0)
 ;;=I99.8^^55^560^4
 ;;^UTILITY(U,$J,358.3,9120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9120,1,3,0)
 ;;=3^Circulatory System Disorder NEC
 ;;^UTILITY(U,$J,358.3,9120,1,4,0)
 ;;=4^I99.8
 ;;^UTILITY(U,$J,358.3,9120,2)
 ;;=^5008113
 ;;^UTILITY(U,$J,358.3,9121,0)
 ;;=99201^^56^561^1
 ;;^UTILITY(U,$J,358.3,9121,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9121,1,1,0)
 ;;=1^Problem Focused
 ;;^UTILITY(U,$J,358.3,9121,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,9122,0)
 ;;=99202^^56^561^2
 ;;^UTILITY(U,$J,358.3,9122,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9122,1,1,0)
 ;;=1^Expanded Problem Focused
 ;;^UTILITY(U,$J,358.3,9122,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,9123,0)
 ;;=99203^^56^561^3
 ;;^UTILITY(U,$J,358.3,9123,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9123,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,9123,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,9124,0)
 ;;=99204^^56^561^4
 ;;^UTILITY(U,$J,358.3,9124,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9124,1,1,0)
 ;;=1^Comprehensive-Moderate
 ;;^UTILITY(U,$J,358.3,9124,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,9125,0)
 ;;=99205^^56^561^5
 ;;^UTILITY(U,$J,358.3,9125,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9125,1,1,0)
 ;;=1^Comprehensive-High Complex
 ;;^UTILITY(U,$J,358.3,9125,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,9126,0)
 ;;=99211^^56^562^1
 ;;^UTILITY(U,$J,358.3,9126,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9126,1,1,0)
 ;;=1^RN/LPN Visit
 ;;^UTILITY(U,$J,358.3,9126,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,9127,0)
 ;;=99212^^56^562^2
 ;;^UTILITY(U,$J,358.3,9127,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9127,1,1,0)
 ;;=1^Problem Focused 
 ;;^UTILITY(U,$J,358.3,9127,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,9128,0)
 ;;=99213^^56^562^3
 ;;^UTILITY(U,$J,358.3,9128,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9128,1,1,0)
 ;;=1^Expanded Problem Focused 
 ;;^UTILITY(U,$J,358.3,9128,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,9129,0)
 ;;=99214^^56^562^4
 ;;^UTILITY(U,$J,358.3,9129,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9129,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,9129,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,9130,0)
 ;;=99215^^56^562^5
 ;;^UTILITY(U,$J,358.3,9130,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9130,1,1,0)
 ;;=1^Comprehensive 
 ;;^UTILITY(U,$J,358.3,9130,1,2,0)
 ;;=2^99215
