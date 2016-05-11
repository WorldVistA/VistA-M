IBDEI06R ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2840,1,3,0)
 ;;=3^Pseudofolliculitis Barbae
 ;;^UTILITY(U,$J,358.3,2840,1,4,0)
 ;;=4^L73.1
 ;;^UTILITY(U,$J,358.3,2840,2)
 ;;=^5009284
 ;;^UTILITY(U,$J,358.3,2841,0)
 ;;=L40.9^^18^208^91
 ;;^UTILITY(U,$J,358.3,2841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2841,1,3,0)
 ;;=3^Psoriasis,Unspec
 ;;^UTILITY(U,$J,358.3,2841,1,4,0)
 ;;=4^L40.9
 ;;^UTILITY(U,$J,358.3,2841,2)
 ;;=^5009171
 ;;^UTILITY(U,$J,358.3,2842,0)
 ;;=R21.^^18^208^92
 ;;^UTILITY(U,$J,358.3,2842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2842,1,3,0)
 ;;=3^Rash/Other Nonspec Skin Eruption
 ;;^UTILITY(U,$J,358.3,2842,1,4,0)
 ;;=4^R21.
 ;;^UTILITY(U,$J,358.3,2842,2)
 ;;=^5019283
 ;;^UTILITY(U,$J,358.3,2843,0)
 ;;=L71.9^^18^208^93
 ;;^UTILITY(U,$J,358.3,2843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2843,1,3,0)
 ;;=3^Rosacea,Unspec
 ;;^UTILITY(U,$J,358.3,2843,1,4,0)
 ;;=4^L71.9
 ;;^UTILITY(U,$J,358.3,2843,2)
 ;;=^5009276
 ;;^UTILITY(U,$J,358.3,2844,0)
 ;;=L82.0^^18^208^94
 ;;^UTILITY(U,$J,358.3,2844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2844,1,3,0)
 ;;=3^Seborrheic Keratosis,Inflamed
 ;;^UTILITY(U,$J,358.3,2844,1,4,0)
 ;;=4^L82.0
 ;;^UTILITY(U,$J,358.3,2844,2)
 ;;=^303311
 ;;^UTILITY(U,$J,358.3,2845,0)
 ;;=L82.1^^18^208^95
 ;;^UTILITY(U,$J,358.3,2845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2845,1,3,0)
 ;;=3^Seborrheic Keratosis,Other
 ;;^UTILITY(U,$J,358.3,2845,1,4,0)
 ;;=4^L82.1
 ;;^UTILITY(U,$J,358.3,2845,2)
 ;;=^303312
 ;;^UTILITY(U,$J,358.3,2846,0)
 ;;=L92.9^^18^208^43
 ;;^UTILITY(U,$J,358.3,2846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2846,1,3,0)
 ;;=3^Granulomatous Disorder of Skin,Unspec
 ;;^UTILITY(U,$J,358.3,2846,1,4,0)
 ;;=4^L92.9
 ;;^UTILITY(U,$J,358.3,2846,2)
 ;;=^5009466
 ;;^UTILITY(U,$J,358.3,2847,0)
 ;;=L98.9^^18^208^101
 ;;^UTILITY(U,$J,358.3,2847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2847,1,3,0)
 ;;=3^Skin Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2847,1,4,0)
 ;;=4^L98.9
 ;;^UTILITY(U,$J,358.3,2847,2)
 ;;=^5009595
 ;;^UTILITY(U,$J,358.3,2848,0)
 ;;=L08.9^^18^208^104
 ;;^UTILITY(U,$J,358.3,2848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2848,1,3,0)
 ;;=3^Skin Infection,Local,Unspec
 ;;^UTILITY(U,$J,358.3,2848,1,4,0)
 ;;=4^L08.9
 ;;^UTILITY(U,$J,358.3,2848,2)
 ;;=^5009082
 ;;^UTILITY(U,$J,358.3,2849,0)
 ;;=L57.9^^18^208^97
 ;;^UTILITY(U,$J,358.3,2849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2849,1,3,0)
 ;;=3^Skin Changes d/t Chr Expsr to Nonionizing Radiation,Unspec
 ;;^UTILITY(U,$J,358.3,2849,1,4,0)
 ;;=4^L57.9
 ;;^UTILITY(U,$J,358.3,2849,2)
 ;;=^5009227
 ;;^UTILITY(U,$J,358.3,2850,0)
 ;;=L90.9^^18^208^99
 ;;^UTILITY(U,$J,358.3,2850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2850,1,3,0)
 ;;=3^Skin Disorder,Atrophic,Unspec
 ;;^UTILITY(U,$J,358.3,2850,1,4,0)
 ;;=4^L90.9
 ;;^UTILITY(U,$J,358.3,2850,2)
 ;;=^5009458
 ;;^UTILITY(U,$J,358.3,2851,0)
 ;;=L91.9^^18^208^100
 ;;^UTILITY(U,$J,358.3,2851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2851,1,3,0)
 ;;=3^Skin Disorder,Hypertrophic,Unspec
 ;;^UTILITY(U,$J,358.3,2851,1,4,0)
 ;;=4^L91.9
 ;;^UTILITY(U,$J,358.3,2851,2)
 ;;=^5009461
 ;;^UTILITY(U,$J,358.3,2852,0)
 ;;=R20.0^^18^208^96
 ;;^UTILITY(U,$J,358.3,2852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2852,1,3,0)
 ;;=3^Skin Anesthesia
 ;;^UTILITY(U,$J,358.3,2852,1,4,0)
 ;;=4^R20.0
 ;;^UTILITY(U,$J,358.3,2852,2)
 ;;=^5019278
 ;;^UTILITY(U,$J,358.3,2853,0)
 ;;=R20.3^^18^208^102
 ;;^UTILITY(U,$J,358.3,2853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2853,1,3,0)
 ;;=3^Skin Hyperesthesia
 ;;^UTILITY(U,$J,358.3,2853,1,4,0)
 ;;=4^R20.3
