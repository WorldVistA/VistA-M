IBDEI1AW ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23295,1,5,0)
 ;;=5^Drug Dermatitis(Internal, Taken Appropriately)
 ;;^UTILITY(U,$J,358.3,23295,2)
 ;;=^33042
 ;;^UTILITY(U,$J,358.3,23296,0)
 ;;=692.3^^148^1442^8
 ;;^UTILITY(U,$J,358.3,23296,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23296,1,2,0)
 ;;=2^692.3
 ;;^UTILITY(U,$J,358.3,23296,1,5,0)
 ;;=5^Drug Dermatitis(External)
 ;;^UTILITY(U,$J,358.3,23296,2)
 ;;=^271905
 ;;^UTILITY(U,$J,358.3,23297,0)
 ;;=693.1^^148^1442^11
 ;;^UTILITY(U,$J,358.3,23297,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23297,1,2,0)
 ;;=2^693.1
 ;;^UTILITY(U,$J,358.3,23297,1,5,0)
 ;;=5^Food Dermatitis
 ;;^UTILITY(U,$J,358.3,23297,2)
 ;;=^33044
 ;;^UTILITY(U,$J,358.3,23298,0)
 ;;=692.0^^148^1442^7
 ;;^UTILITY(U,$J,358.3,23298,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23298,1,2,0)
 ;;=2^692.0
 ;;^UTILITY(U,$J,358.3,23298,1,5,0)
 ;;=5^Detergent Dermatitis
 ;;^UTILITY(U,$J,358.3,23298,2)
 ;;=^271902
 ;;^UTILITY(U,$J,358.3,23299,0)
 ;;=692.74^^148^1442^18
 ;;^UTILITY(U,$J,358.3,23299,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23299,1,2,0)
 ;;=2^692.74
 ;;^UTILITY(U,$J,358.3,23299,1,5,0)
 ;;=5^Sun Dermatitis, Chronic
 ;;^UTILITY(U,$J,358.3,23299,2)
 ;;=^293927
 ;;^UTILITY(U,$J,358.3,23300,0)
 ;;=694.9^^148^1442^5
 ;;^UTILITY(U,$J,358.3,23300,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23300,1,2,0)
 ;;=2^694.9
 ;;^UTILITY(U,$J,358.3,23300,1,5,0)
 ;;=5^Bullous dermatoses, NOS
 ;;^UTILITY(U,$J,358.3,23300,2)
 ;;=^187900
 ;;^UTILITY(U,$J,358.3,23301,0)
 ;;=692.73^^148^1442^2
 ;;^UTILITY(U,$J,358.3,23301,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23301,1,2,0)
 ;;=2^692.73
 ;;^UTILITY(U,$J,358.3,23301,1,5,0)
 ;;=5^Actinic Granuloma/Reticuloid
 ;;^UTILITY(U,$J,358.3,23301,2)
 ;;=Actinic Granuloma/Reticuloid^293926
 ;;^UTILITY(U,$J,358.3,23302,0)
 ;;=692.72^^148^1442^14
 ;;^UTILITY(U,$J,358.3,23302,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23302,1,2,0)
 ;;=2^692.72
 ;;^UTILITY(U,$J,358.3,23302,1,5,0)
 ;;=5^Polymorphic Light Eruption
 ;;^UTILITY(U,$J,358.3,23302,2)
 ;;=Polymorphic Light Eruptio^93951
 ;;^UTILITY(U,$J,358.3,23303,0)
 ;;=110.0^^148^1443^5
 ;;^UTILITY(U,$J,358.3,23303,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23303,1,2,0)
 ;;=2^110.0
 ;;^UTILITY(U,$J,358.3,23303,1,5,0)
 ;;=5^Dermatophytosis Scalp
 ;;^UTILITY(U,$J,358.3,23303,2)
 ;;=^33176
 ;;^UTILITY(U,$J,358.3,23304,0)
 ;;=110.5^^148^1443^1
 ;;^UTILITY(U,$J,358.3,23304,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23304,1,2,0)
 ;;=2^110.5
 ;;^UTILITY(U,$J,358.3,23304,1,5,0)
 ;;=5^Dermatophytosis Body(Tinea Imbricata)
 ;;^UTILITY(U,$J,358.3,23304,2)
 ;;=^33179
 ;;^UTILITY(U,$J,358.3,23305,0)
 ;;=110.1^^148^1443^6
 ;;^UTILITY(U,$J,358.3,23305,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23305,1,2,0)
 ;;=2^110.1
 ;;^UTILITY(U,$J,358.3,23305,1,5,0)
 ;;=5^Onychomycosis
 ;;^UTILITY(U,$J,358.3,23305,2)
 ;;=Onychomycosis^33173
 ;;^UTILITY(U,$J,358.3,23306,0)
 ;;=110.4^^148^1443^2
 ;;^UTILITY(U,$J,358.3,23306,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23306,1,2,0)
 ;;=2^110.4
 ;;^UTILITY(U,$J,358.3,23306,1,5,0)
 ;;=5^Dermatophytosis Foot(Tinea Pedis)
 ;;^UTILITY(U,$J,358.3,23306,2)
 ;;=^33168
 ;;^UTILITY(U,$J,358.3,23307,0)
 ;;=110.3^^148^1443^3
 ;;^UTILITY(U,$J,358.3,23307,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23307,1,2,0)
 ;;=2^110.3
 ;;^UTILITY(U,$J,358.3,23307,1,5,0)
 ;;=5^Dermatophytosis Groin(Tinea Cruris)
 ;;^UTILITY(U,$J,358.3,23307,2)
 ;;=^33171
 ;;^UTILITY(U,$J,358.3,23308,0)
 ;;=110.2^^148^1443^4
 ;;^UTILITY(U,$J,358.3,23308,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23308,1,2,0)
 ;;=2^110.2
 ;;^UTILITY(U,$J,358.3,23308,1,5,0)
 ;;=5^Dermatophytosis Hand(Tinea Manuum)
