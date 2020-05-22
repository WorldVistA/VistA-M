IBDEI2BL ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37071,0)
 ;;=11719^^144^1908^7^^^^1
 ;;^UTILITY(U,$J,358.3,37071,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37071,1,2,0)
 ;;=2^Trimming Nondystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,37071,1,3,0)
 ;;=3^11719
 ;;^UTILITY(U,$J,358.3,37072,0)
 ;;=G0127^^144^1908^6^^^^1
 ;;^UTILITY(U,$J,358.3,37072,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37072,1,2,0)
 ;;=2^Trimming Dystrophic Nails, any number
 ;;^UTILITY(U,$J,358.3,37072,1,3,0)
 ;;=3^G0127
 ;;^UTILITY(U,$J,358.3,37073,0)
 ;;=11720^^144^1908^1^^^^1
 ;;^UTILITY(U,$J,358.3,37073,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37073,1,2,0)
 ;;=2^Debridement of Nail(s)any method(s); 1-5 
 ;;^UTILITY(U,$J,358.3,37073,1,3,0)
 ;;=3^11720
 ;;^UTILITY(U,$J,358.3,37074,0)
 ;;=11721^^144^1908^2^^^^1
 ;;^UTILITY(U,$J,358.3,37074,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37074,1,2,0)
 ;;=2^Debridement of Nails any method; 6 or more
 ;;^UTILITY(U,$J,358.3,37074,1,3,0)
 ;;=3^11721
 ;;^UTILITY(U,$J,358.3,37075,0)
 ;;=11055^^144^1908^3^^^^1
 ;;^UTILITY(U,$J,358.3,37075,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37075,1,2,0)
 ;;=2^Paring/Cutting Lesions;1 Lesion
 ;;^UTILITY(U,$J,358.3,37075,1,3,0)
 ;;=3^11055
 ;;^UTILITY(U,$J,358.3,37076,0)
 ;;=11056^^144^1908^4^^^^1
 ;;^UTILITY(U,$J,358.3,37076,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37076,1,2,0)
 ;;=2^Paring/Cutting Lesions;2-4 Lesions
 ;;^UTILITY(U,$J,358.3,37076,1,3,0)
 ;;=3^11056
 ;;^UTILITY(U,$J,358.3,37077,0)
 ;;=11057^^144^1908^5^^^^1
 ;;^UTILITY(U,$J,358.3,37077,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37077,1,2,0)
 ;;=2^Paring/Cutting Lesions;More Than 4 Lesions
 ;;^UTILITY(U,$J,358.3,37077,1,3,0)
 ;;=3^11057
 ;;^UTILITY(U,$J,358.3,37078,0)
 ;;=L9900^^144^1909^2^^^^1
 ;;^UTILITY(U,$J,358.3,37078,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37078,1,2,0)
 ;;=2^Orthotic/Prosthetic Supply/Accessory/Service Component
 ;;^UTILITY(U,$J,358.3,37078,1,3,0)
 ;;=3^L9900
 ;;^UTILITY(U,$J,358.3,37079,0)
 ;;=97763^^144^1909^1^^^^1
 ;;^UTILITY(U,$J,358.3,37079,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37079,1,2,0)
 ;;=2^Orthotic/Prosth F/U Mgmt/Trng,Ea 15 min
 ;;^UTILITY(U,$J,358.3,37079,1,3,0)
 ;;=3^97763
 ;;^UTILITY(U,$J,358.3,37080,0)
 ;;=90471^^144^1910^1^^^^1
 ;;^UTILITY(U,$J,358.3,37080,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37080,1,2,0)
 ;;=2^Immunization Admin,Single
 ;;^UTILITY(U,$J,358.3,37080,1,3,0)
 ;;=3^90471
 ;;^UTILITY(U,$J,358.3,37081,0)
 ;;=90658^^144^1910^5^^^^1
 ;;^UTILITY(U,$J,358.3,37081,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37081,1,2,0)
 ;;=2^Flu Vaccine,IM
 ;;^UTILITY(U,$J,358.3,37081,1,3,0)
 ;;=3^90658
 ;;^UTILITY(U,$J,358.3,37082,0)
 ;;=90656^^144^1910^6^^^^1
 ;;^UTILITY(U,$J,358.3,37082,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37082,1,2,0)
 ;;=2^Flu Vaccine,Preserve Free,IM
 ;;^UTILITY(U,$J,358.3,37082,1,3,0)
 ;;=3^90656
 ;;^UTILITY(U,$J,358.3,37083,0)
 ;;=90686^^144^1910^4^^^^1
 ;;^UTILITY(U,$J,358.3,37083,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37083,1,2,0)
 ;;=2^Flu Vaccine Single Dose Syringe (Fluarix)
 ;;^UTILITY(U,$J,358.3,37083,1,3,0)
 ;;=3^90686
 ;;^UTILITY(U,$J,358.3,37084,0)
 ;;=90688^^144^1910^2^^^^1
 ;;^UTILITY(U,$J,358.3,37084,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,37084,1,2,0)
 ;;=2^Flu Vaccine Multi Dose Syringe (Flulaval)
 ;;^UTILITY(U,$J,358.3,37084,1,3,0)
 ;;=3^90688
 ;;^UTILITY(U,$J,358.3,37085,0)
 ;;=90732^^144^1910^7^^^^1
