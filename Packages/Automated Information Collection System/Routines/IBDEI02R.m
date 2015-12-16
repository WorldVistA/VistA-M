IBDEI02R ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,742,2)
 ;;=^5009054
 ;;^UTILITY(U,$J,358.3,743,0)
 ;;=L03.113^^3^32^25
 ;;^UTILITY(U,$J,358.3,743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,743,1,3,0)
 ;;=3^Cellulitis of right upper limb
 ;;^UTILITY(U,$J,358.3,743,1,4,0)
 ;;=4^L03.113
 ;;^UTILITY(U,$J,358.3,743,2)
 ;;=^5009033
 ;;^UTILITY(U,$J,358.3,744,0)
 ;;=L03.114^^3^32^19
 ;;^UTILITY(U,$J,358.3,744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,744,1,3,0)
 ;;=3^Cellulitis of left upper limb
 ;;^UTILITY(U,$J,358.3,744,1,4,0)
 ;;=4^L03.114
 ;;^UTILITY(U,$J,358.3,744,2)
 ;;=^5009034
 ;;^UTILITY(U,$J,358.3,745,0)
 ;;=L03.115^^3^32^22
 ;;^UTILITY(U,$J,358.3,745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,745,1,3,0)
 ;;=3^Cellulitis of right lower limb
 ;;^UTILITY(U,$J,358.3,745,1,4,0)
 ;;=4^L03.115
 ;;^UTILITY(U,$J,358.3,745,2)
 ;;=^5009035
 ;;^UTILITY(U,$J,358.3,746,0)
 ;;=L03.116^^3^32^16
 ;;^UTILITY(U,$J,358.3,746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,746,1,3,0)
 ;;=3^Cellulitis of left lower limb
 ;;^UTILITY(U,$J,358.3,746,1,4,0)
 ;;=4^L03.116
 ;;^UTILITY(U,$J,358.3,746,2)
 ;;=^5133645
 ;;^UTILITY(U,$J,358.3,747,0)
 ;;=L08.9^^3^32^54
 ;;^UTILITY(U,$J,358.3,747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,747,1,3,0)
 ;;=3^Local infection of the skin and subcutaneous tissue, unsp
 ;;^UTILITY(U,$J,358.3,747,1,4,0)
 ;;=4^L08.9
 ;;^UTILITY(U,$J,358.3,747,2)
 ;;=^5009082
 ;;^UTILITY(U,$J,358.3,748,0)
 ;;=L21.9^^3^32^140
 ;;^UTILITY(U,$J,358.3,748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,748,1,3,0)
 ;;=3^Seborrheic dermatitis, unspecified
 ;;^UTILITY(U,$J,358.3,748,1,4,0)
 ;;=4^L21.9
 ;;^UTILITY(U,$J,358.3,748,2)
 ;;=^188703
 ;;^UTILITY(U,$J,358.3,749,0)
 ;;=L21.8^^3^32^138
 ;;^UTILITY(U,$J,358.3,749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,749,1,3,0)
 ;;=3^Seborrheic Dermatitis NEC
 ;;^UTILITY(U,$J,358.3,749,1,4,0)
 ;;=4^L21.8
 ;;^UTILITY(U,$J,358.3,749,2)
 ;;=^303310
 ;;^UTILITY(U,$J,358.3,750,0)
 ;;=L20.81^^3^32^8
 ;;^UTILITY(U,$J,358.3,750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,750,1,3,0)
 ;;=3^Atopic neurodermatitis
 ;;^UTILITY(U,$J,358.3,750,1,4,0)
 ;;=4^L20.81
 ;;^UTILITY(U,$J,358.3,750,2)
 ;;=^5009108
 ;;^UTILITY(U,$J,358.3,751,0)
 ;;=L20.0^^3^32^9
 ;;^UTILITY(U,$J,358.3,751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,751,1,3,0)
 ;;=3^Besnier's prurigo
 ;;^UTILITY(U,$J,358.3,751,1,4,0)
 ;;=4^L20.0
 ;;^UTILITY(U,$J,358.3,751,2)
 ;;=^5009107
 ;;^UTILITY(U,$J,358.3,752,0)
 ;;=L20.82^^3^32^41
 ;;^UTILITY(U,$J,358.3,752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,752,1,3,0)
 ;;=3^Flexural eczema
 ;;^UTILITY(U,$J,358.3,752,1,4,0)
 ;;=4^L20.82
 ;;^UTILITY(U,$J,358.3,752,2)
 ;;=^5009109
 ;;^UTILITY(U,$J,358.3,753,0)
 ;;=L20.84^^3^32^52
 ;;^UTILITY(U,$J,358.3,753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,753,1,3,0)
 ;;=3^Intrinsic (allergic) eczema
 ;;^UTILITY(U,$J,358.3,753,1,4,0)
 ;;=4^L20.84
 ;;^UTILITY(U,$J,358.3,753,2)
 ;;=^5009111
 ;;^UTILITY(U,$J,358.3,754,0)
 ;;=L20.89^^3^32^7
 ;;^UTILITY(U,$J,358.3,754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,754,1,3,0)
 ;;=3^Atopic Dermatitis NEC
 ;;^UTILITY(U,$J,358.3,754,1,4,0)
 ;;=4^L20.89
 ;;^UTILITY(U,$J,358.3,754,2)
 ;;=^5009112
 ;;^UTILITY(U,$J,358.3,755,0)
 ;;=L25.5^^3^32^27
 ;;^UTILITY(U,$J,358.3,755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,755,1,3,0)
 ;;=3^Contact Dermatitis d/t Plants,Unspec
 ;;^UTILITY(U,$J,358.3,755,1,4,0)
 ;;=4^L25.5
 ;;^UTILITY(U,$J,358.3,755,2)
 ;;=^5009142
 ;;^UTILITY(U,$J,358.3,756,0)
 ;;=L56.0^^3^32^33
 ;;^UTILITY(U,$J,358.3,756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,756,1,3,0)
 ;;=3^Drug phototoxic response
