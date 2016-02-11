IBDEI0E1 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6121,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Ankle,Unspec Severity
 ;;^UTILITY(U,$J,358.3,6121,1,4,0)
 ;;=4^L97.329
 ;;^UTILITY(U,$J,358.3,6121,2)
 ;;=^5009524
 ;;^UTILITY(U,$J,358.3,6122,0)
 ;;=L97.421^^40^383^102
 ;;^UTILITY(U,$J,358.3,6122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6122,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Heel/Midfoot,Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,6122,1,4,0)
 ;;=4^L97.421
 ;;^UTILITY(U,$J,358.3,6122,2)
 ;;=^5009535
 ;;^UTILITY(U,$J,358.3,6123,0)
 ;;=L97.422^^40^383^103
 ;;^UTILITY(U,$J,358.3,6123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6123,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Heel/Midfoot,Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,6123,1,4,0)
 ;;=4^L97.422
 ;;^UTILITY(U,$J,358.3,6123,2)
 ;;=^5009536
 ;;^UTILITY(U,$J,358.3,6124,0)
 ;;=L97.423^^40^383^104
 ;;^UTILITY(U,$J,358.3,6124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6124,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Heel/Midfoot,Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,6124,1,4,0)
 ;;=4^L97.423
 ;;^UTILITY(U,$J,358.3,6124,2)
 ;;=^5009537
 ;;^UTILITY(U,$J,358.3,6125,0)
 ;;=L97.424^^40^383^105
 ;;^UTILITY(U,$J,358.3,6125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6125,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Heel/Midfoot,Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,6125,1,4,0)
 ;;=4^L97.424
 ;;^UTILITY(U,$J,358.3,6125,2)
 ;;=^5009538
 ;;^UTILITY(U,$J,358.3,6126,0)
 ;;=L97.429^^40^383^106
 ;;^UTILITY(U,$J,358.3,6126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6126,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Heel/Midfoot,Unspec Severity
 ;;^UTILITY(U,$J,358.3,6126,1,4,0)
 ;;=4^L97.429
 ;;^UTILITY(U,$J,358.3,6126,2)
 ;;=^5009539
 ;;^UTILITY(U,$J,358.3,6127,0)
 ;;=L97.521^^40^383^97
 ;;^UTILITY(U,$J,358.3,6127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6127,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Foot NEC,Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,6127,1,4,0)
 ;;=4^L97.521
 ;;^UTILITY(U,$J,358.3,6127,2)
 ;;=^5009550
 ;;^UTILITY(U,$J,358.3,6128,0)
 ;;=L97.522^^40^383^98
 ;;^UTILITY(U,$J,358.3,6128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6128,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Foot NEC,Fat Layer Exposed
 ;;^UTILITY(U,$J,358.3,6128,1,4,0)
 ;;=4^L97.522
 ;;^UTILITY(U,$J,358.3,6128,2)
 ;;=^5009551
 ;;^UTILITY(U,$J,358.3,6129,0)
 ;;=L97.523^^40^383^99
 ;;^UTILITY(U,$J,358.3,6129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6129,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Foot NEC,Necrosis of Muscle
 ;;^UTILITY(U,$J,358.3,6129,1,4,0)
 ;;=4^L97.523
 ;;^UTILITY(U,$J,358.3,6129,2)
 ;;=^5009552
 ;;^UTILITY(U,$J,358.3,6130,0)
 ;;=L97.524^^40^383^100
 ;;^UTILITY(U,$J,358.3,6130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6130,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Foot NEC,Necrosis of Bone
 ;;^UTILITY(U,$J,358.3,6130,1,4,0)
 ;;=4^L97.524
 ;;^UTILITY(U,$J,358.3,6130,2)
 ;;=^5009553
 ;;^UTILITY(U,$J,358.3,6131,0)
 ;;=L97.529^^40^383^101
 ;;^UTILITY(U,$J,358.3,6131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6131,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Foot NEC,Unspec Severity
 ;;^UTILITY(U,$J,358.3,6131,1,4,0)
 ;;=4^L97.529
 ;;^UTILITY(U,$J,358.3,6131,2)
 ;;=^5009554
 ;;^UTILITY(U,$J,358.3,6132,0)
 ;;=L97.821^^40^383^107
 ;;^UTILITY(U,$J,358.3,6132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6132,1,3,0)
 ;;=3^Nonpressure Chr Ulcer of Left Lower Leg,Breakdown of Skin
 ;;^UTILITY(U,$J,358.3,6132,1,4,0)
 ;;=4^L97.821
 ;;^UTILITY(U,$J,358.3,6132,2)
 ;;=^5009565
 ;;^UTILITY(U,$J,358.3,6133,0)
 ;;=L97.822^^40^383^108
