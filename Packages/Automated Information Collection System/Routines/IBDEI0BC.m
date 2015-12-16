IBDEI0BC ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4975,2)
 ;;=^271905
 ;;^UTILITY(U,$J,358.3,4976,0)
 ;;=693.1^^25^260^11
 ;;^UTILITY(U,$J,358.3,4976,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4976,1,2,0)
 ;;=2^693.1
 ;;^UTILITY(U,$J,358.3,4976,1,5,0)
 ;;=5^Food Dermatitis
 ;;^UTILITY(U,$J,358.3,4976,2)
 ;;=^33044
 ;;^UTILITY(U,$J,358.3,4977,0)
 ;;=692.0^^25^260^7
 ;;^UTILITY(U,$J,358.3,4977,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4977,1,2,0)
 ;;=2^692.0
 ;;^UTILITY(U,$J,358.3,4977,1,5,0)
 ;;=5^Detergent Dermatitis
 ;;^UTILITY(U,$J,358.3,4977,2)
 ;;=^271902
 ;;^UTILITY(U,$J,358.3,4978,0)
 ;;=692.74^^25^260^19
 ;;^UTILITY(U,$J,358.3,4978,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4978,1,2,0)
 ;;=2^692.74
 ;;^UTILITY(U,$J,358.3,4978,1,5,0)
 ;;=5^Sun Dermatitis, Chronic
 ;;^UTILITY(U,$J,358.3,4978,2)
 ;;=^293927
 ;;^UTILITY(U,$J,358.3,4979,0)
 ;;=694.9^^25^260^5
 ;;^UTILITY(U,$J,358.3,4979,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4979,1,2,0)
 ;;=2^694.9
 ;;^UTILITY(U,$J,358.3,4979,1,5,0)
 ;;=5^Bullous dermatoses, NOS
 ;;^UTILITY(U,$J,358.3,4979,2)
 ;;=^187900
 ;;^UTILITY(U,$J,358.3,4980,0)
 ;;=692.73^^25^260^2
 ;;^UTILITY(U,$J,358.3,4980,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4980,1,2,0)
 ;;=2^692.73
 ;;^UTILITY(U,$J,358.3,4980,1,5,0)
 ;;=5^Actinic Granuloma/Reticuloid
 ;;^UTILITY(U,$J,358.3,4980,2)
 ;;=Actinic Granuloma/Reticuloid^293926
 ;;^UTILITY(U,$J,358.3,4981,0)
 ;;=692.72^^25^260^15
 ;;^UTILITY(U,$J,358.3,4981,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4981,1,2,0)
 ;;=2^692.72
 ;;^UTILITY(U,$J,358.3,4981,1,5,0)
 ;;=5^Polymorphic Light Eruption
 ;;^UTILITY(U,$J,358.3,4981,2)
 ;;=Polymorphic Light Eruptio^93951
 ;;^UTILITY(U,$J,358.3,4982,0)
 ;;=692.6^^25^260^14
 ;;^UTILITY(U,$J,358.3,4982,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4982,1,2,0)
 ;;=2^692.6
 ;;^UTILITY(U,$J,358.3,4982,1,5,0)
 ;;=5^Plant Dermatitis
 ;;^UTILITY(U,$J,358.3,4982,2)
 ;;=^271908
 ;;^UTILITY(U,$J,358.3,4983,0)
 ;;=110.0^^25^261^5
 ;;^UTILITY(U,$J,358.3,4983,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4983,1,2,0)
 ;;=2^110.0
 ;;^UTILITY(U,$J,358.3,4983,1,5,0)
 ;;=5^Dermatophytosis Scalp
 ;;^UTILITY(U,$J,358.3,4983,2)
 ;;=^33176
 ;;^UTILITY(U,$J,358.3,4984,0)
 ;;=110.5^^25^261^1
 ;;^UTILITY(U,$J,358.3,4984,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4984,1,2,0)
 ;;=2^110.5
 ;;^UTILITY(U,$J,358.3,4984,1,5,0)
 ;;=5^Dermatophytosis Body(Tinea Imbricata)
 ;;^UTILITY(U,$J,358.3,4984,2)
 ;;=^33179
 ;;^UTILITY(U,$J,358.3,4985,0)
 ;;=110.1^^25^261^6
 ;;^UTILITY(U,$J,358.3,4985,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4985,1,2,0)
 ;;=2^110.1
 ;;^UTILITY(U,$J,358.3,4985,1,5,0)
 ;;=5^Onychomycosis
 ;;^UTILITY(U,$J,358.3,4985,2)
 ;;=Onychomycosis^33173
 ;;^UTILITY(U,$J,358.3,4986,0)
 ;;=110.4^^25^261^2
 ;;^UTILITY(U,$J,358.3,4986,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4986,1,2,0)
 ;;=2^110.4
 ;;^UTILITY(U,$J,358.3,4986,1,5,0)
 ;;=5^Dermatophytosis Foot(Tinea Pedis)
 ;;^UTILITY(U,$J,358.3,4986,2)
 ;;=^33168
 ;;^UTILITY(U,$J,358.3,4987,0)
 ;;=110.3^^25^261^3
 ;;^UTILITY(U,$J,358.3,4987,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4987,1,2,0)
 ;;=2^110.3
 ;;^UTILITY(U,$J,358.3,4987,1,5,0)
 ;;=5^Dermatophytosis Groin(Tinea Cruris)
 ;;^UTILITY(U,$J,358.3,4987,2)
 ;;=^33171
 ;;^UTILITY(U,$J,358.3,4988,0)
 ;;=110.2^^25^261^4
 ;;^UTILITY(U,$J,358.3,4988,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4988,1,2,0)
 ;;=2^110.2
 ;;^UTILITY(U,$J,358.3,4988,1,5,0)
 ;;=5^Dermatophytosis Hand(Tinea Manuum)
 ;;^UTILITY(U,$J,358.3,4988,2)
 ;;=^266859
 ;;^UTILITY(U,$J,358.3,4989,0)
 ;;=111.0^^25^261^7
 ;;^UTILITY(U,$J,358.3,4989,1,0)
 ;;=^358.31IA^5^2
