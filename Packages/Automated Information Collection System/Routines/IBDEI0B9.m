IBDEI0B9 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5289,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5289,1,2,0)
 ;;=2^17315
 ;;^UTILITY(U,$J,358.3,5289,1,3,0)
 ;;=3^MOHS Surg Addl Block
 ;;^UTILITY(U,$J,358.3,5290,0)
 ;;=96372^^40^453^7^^^^1
 ;;^UTILITY(U,$J,358.3,5290,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5290,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,5290,1,3,0)
 ;;=3^Ther/Proph/Diag Inj SC/IM
 ;;^UTILITY(U,$J,358.3,5291,0)
 ;;=96406^^40^453^1^^^^1
 ;;^UTILITY(U,$J,358.3,5291,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5291,1,2,0)
 ;;=2^96406
 ;;^UTILITY(U,$J,358.3,5291,1,3,0)
 ;;=3^Chemo Intralesional > 7
 ;;^UTILITY(U,$J,358.3,5292,0)
 ;;=96405^^40^453^2^^^^1
 ;;^UTILITY(U,$J,358.3,5292,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5292,1,2,0)
 ;;=2^96405
 ;;^UTILITY(U,$J,358.3,5292,1,3,0)
 ;;=3^Chemo Intralesional Up to 7
 ;;^UTILITY(U,$J,358.3,5293,0)
 ;;=C9800^^40^453^3^^^^1
 ;;^UTILITY(U,$J,358.3,5293,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5293,1,2,0)
 ;;=2^C9800
 ;;^UTILITY(U,$J,358.3,5293,1,3,0)
 ;;=3^Dermal Filler Inj Px/Supply
 ;;^UTILITY(U,$J,358.3,5294,0)
 ;;=11901^^40^453^6^^^^1
 ;;^UTILITY(U,$J,358.3,5294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5294,1,2,0)
 ;;=2^11901
 ;;^UTILITY(U,$J,358.3,5294,1,3,0)
 ;;=3^Skin Lesion Injection,Addl Lesions
 ;;^UTILITY(U,$J,358.3,5295,0)
 ;;=11900^^40^453^5^^^^1
 ;;^UTILITY(U,$J,358.3,5295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5295,1,2,0)
 ;;=2^11900
 ;;^UTILITY(U,$J,358.3,5295,1,3,0)
 ;;=3^Skin Lesion Injection
 ;;^UTILITY(U,$J,358.3,5296,0)
 ;;=Q2026^^40^453^4^^^^1
 ;;^UTILITY(U,$J,358.3,5296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5296,1,2,0)
 ;;=2^Q2026
 ;;^UTILITY(U,$J,358.3,5296,1,3,0)
 ;;=3^Radiesse Inj 0.1 ml
 ;;^UTILITY(U,$J,358.3,5297,0)
 ;;=15780^^40^454^6^^^^1
 ;;^UTILITY(U,$J,358.3,5297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5297,1,2,0)
 ;;=2^15780
 ;;^UTILITY(U,$J,358.3,5297,1,3,0)
 ;;=3^Dermabrasion,Total Face
 ;;^UTILITY(U,$J,358.3,5298,0)
 ;;=15781^^40^454^2^^^^1
 ;;^UTILITY(U,$J,358.3,5298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5298,1,2,0)
 ;;=2^15781
 ;;^UTILITY(U,$J,358.3,5298,1,3,0)
 ;;=3^Dermabrasion,Segmental,Face
 ;;^UTILITY(U,$J,358.3,5299,0)
 ;;=15782^^40^454^1^^^^1
 ;;^UTILITY(U,$J,358.3,5299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5299,1,2,0)
 ;;=2^15782
 ;;^UTILITY(U,$J,358.3,5299,1,3,0)
 ;;=3^Dermabrasion,Regional,Not Face
 ;;^UTILITY(U,$J,358.3,5300,0)
 ;;=15783^^40^454^5^^^^1
 ;;^UTILITY(U,$J,358.3,5300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5300,1,2,0)
 ;;=2^15783
 ;;^UTILITY(U,$J,358.3,5300,1,3,0)
 ;;=3^Dermabrasion,Superficial
 ;;^UTILITY(U,$J,358.3,5301,0)
 ;;=15786^^40^454^3^^^^1
 ;;^UTILITY(U,$J,358.3,5301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5301,1,2,0)
 ;;=2^15786
 ;;^UTILITY(U,$J,358.3,5301,1,3,0)
 ;;=3^Dermabrasion,Single Lesion
 ;;^UTILITY(U,$J,358.3,5302,0)
 ;;=15787^^40^454^4^^^^1
 ;;^UTILITY(U,$J,358.3,5302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5302,1,2,0)
 ;;=2^15787
 ;;^UTILITY(U,$J,358.3,5302,1,3,0)
 ;;=3^Dermabrasion,4 Addl Lesions
 ;;^UTILITY(U,$J,358.3,5303,0)
 ;;=96900^^40^455^7^^^^1
 ;;^UTILITY(U,$J,358.3,5303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5303,1,2,0)
 ;;=2^96900
 ;;^UTILITY(U,$J,358.3,5303,1,3,0)
 ;;=3^Ultraviolet Light Therapy
 ;;^UTILITY(U,$J,358.3,5304,0)
 ;;=96910^^40^455^5^^^^1
 ;;^UTILITY(U,$J,358.3,5304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5304,1,2,0)
 ;;=2^96910
 ;;^UTILITY(U,$J,358.3,5304,1,3,0)
 ;;=3^Photochemotherapy w/ UV-B
 ;;^UTILITY(U,$J,358.3,5305,0)
 ;;=96912^^40^455^4^^^^1
 ;;^UTILITY(U,$J,358.3,5305,1,0)
 ;;=^358.31IA^3^2
