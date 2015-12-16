IBDEI0BO ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5144,0)
 ;;=708.3^^25^292^3
 ;;^UTILITY(U,$J,358.3,5144,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5144,1,2,0)
 ;;=2^708.3
 ;;^UTILITY(U,$J,358.3,5144,1,5,0)
 ;;=5^Dermatographic Urticaria
 ;;^UTILITY(U,$J,358.3,5144,2)
 ;;=^265291
 ;;^UTILITY(U,$J,358.3,5145,0)
 ;;=708.5^^25^292^2
 ;;^UTILITY(U,$J,358.3,5145,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5145,1,2,0)
 ;;=2^708.5
 ;;^UTILITY(U,$J,358.3,5145,1,5,0)
 ;;=5^Cholinergic Urticaria
 ;;^UTILITY(U,$J,358.3,5145,2)
 ;;=^265460
 ;;^UTILITY(U,$J,358.3,5146,0)
 ;;=708.8^^25^292^4
 ;;^UTILITY(U,$J,358.3,5146,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5146,1,2,0)
 ;;=2^708.8
 ;;^UTILITY(U,$J,358.3,5146,1,5,0)
 ;;=5^Exercise Induced Urticaria
 ;;^UTILITY(U,$J,358.3,5146,2)
 ;;=^88159
 ;;^UTILITY(U,$J,358.3,5147,0)
 ;;=757.33^^25^292^6
 ;;^UTILITY(U,$J,358.3,5147,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5147,1,2,0)
 ;;=2^757.33
 ;;^UTILITY(U,$J,358.3,5147,1,5,0)
 ;;=5^Urticaria Pigmentosa
 ;;^UTILITY(U,$J,358.3,5147,2)
 ;;=^27472
 ;;^UTILITY(U,$J,358.3,5148,0)
 ;;=708.9^^25^292^5
 ;;^UTILITY(U,$J,358.3,5148,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5148,1,2,0)
 ;;=2^708.9
 ;;^UTILITY(U,$J,358.3,5148,1,5,0)
 ;;=5^Generalized Urticaria
 ;;^UTILITY(U,$J,358.3,5148,2)
 ;;=^124650
 ;;^UTILITY(U,$J,358.3,5149,0)
 ;;=454.1^^25^293^1
 ;;^UTILITY(U,$J,358.3,5149,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5149,1,2,0)
 ;;=2^454.1
 ;;^UTILITY(U,$J,358.3,5149,1,5,0)
 ;;=5^Varicose Veins W/ Inflammation
 ;;^UTILITY(U,$J,358.3,5149,2)
 ;;=^125435
 ;;^UTILITY(U,$J,358.3,5150,0)
 ;;=454.2^^25^293^2
 ;;^UTILITY(U,$J,358.3,5150,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5150,1,2,0)
 ;;=2^454.2
 ;;^UTILITY(U,$J,358.3,5150,1,5,0)
 ;;=5^Varicose Veins W/ Inflammation, Ulcerated
 ;;^UTILITY(U,$J,358.3,5150,2)
 ;;=^269821
 ;;^UTILITY(U,$J,358.3,5151,0)
 ;;=454.0^^25^293^3
 ;;^UTILITY(U,$J,358.3,5151,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5151,1,2,0)
 ;;=2^454.0
 ;;^UTILITY(U,$J,358.3,5151,1,5,0)
 ;;=5^Varicose Veins, Ulcerated
 ;;^UTILITY(U,$J,358.3,5151,2)
 ;;=^125410
 ;;^UTILITY(U,$J,358.3,5152,0)
 ;;=998.83^^25^294^4
 ;;^UTILITY(U,$J,358.3,5152,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5152,1,2,0)
 ;;=2^998.83
 ;;^UTILITY(U,$J,358.3,5152,1,5,0)
 ;;=5^Non-Healing Surgical Wound
 ;;^UTILITY(U,$J,358.3,5152,2)
 ;;=^304351
 ;;^UTILITY(U,$J,358.3,5153,0)
 ;;=998.59^^25^294^3
 ;;^UTILITY(U,$J,358.3,5153,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5153,1,2,0)
 ;;=2^998.59
 ;;^UTILITY(U,$J,358.3,5153,1,5,0)
 ;;=5^Infection(Post Operative)
 ;;^UTILITY(U,$J,358.3,5153,2)
 ;;=^97081
 ;;^UTILITY(U,$J,358.3,5154,0)
 ;;=998.12^^25^294^2
 ;;^UTILITY(U,$J,358.3,5154,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5154,1,2,0)
 ;;=2^998.12
 ;;^UTILITY(U,$J,358.3,5154,1,5,0)
 ;;=5^Hematoma(Post Operative)
 ;;^UTILITY(U,$J,358.3,5154,2)
 ;;=^304348
 ;;^UTILITY(U,$J,358.3,5155,0)
 ;;=998.32^^25^294^1
 ;;^UTILITY(U,$J,358.3,5155,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5155,1,2,0)
 ;;=2^998.32
 ;;^UTILITY(U,$J,358.3,5155,1,5,0)
 ;;=5^Disruption of ext surg wound
 ;;^UTILITY(U,$J,358.3,5155,2)
 ;;=Disruption of ext surg wound
 ;;^UTILITY(U,$J,358.3,5156,0)
 ;;=701.2^^25^295^1
 ;;^UTILITY(U,$J,358.3,5156,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5156,1,2,0)
 ;;=2^701.2
 ;;^UTILITY(U,$J,358.3,5156,1,5,0)
 ;;=5^Acanthosis Nigricans
 ;;^UTILITY(U,$J,358.3,5156,2)
 ;;=^2231
 ;;^UTILITY(U,$J,358.3,5157,0)
 ;;=528.8^^25^295^3
 ;;^UTILITY(U,$J,358.3,5157,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5157,1,2,0)
 ;;=2^528.8
 ;;^UTILITY(U,$J,358.3,5157,1,5,0)
 ;;=5^Apthous Stomatitis
