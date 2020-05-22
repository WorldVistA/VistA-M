IBDEI1TC ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28955,1,3,0)
 ;;=3^Family Psychotherpy w/pt.
 ;;^UTILITY(U,$J,358.3,28956,0)
 ;;=90875^^117^1441^7^^^^1
 ;;^UTILITY(U,$J,358.3,28956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28956,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,28956,1,3,0)
 ;;=3^Indiv Psychophysiological Tx w/ Biofeedback,30 min
 ;;^UTILITY(U,$J,358.3,28957,0)
 ;;=90876^^117^1441^8^^^^1
 ;;^UTILITY(U,$J,358.3,28957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28957,1,2,0)
 ;;=2^90876
 ;;^UTILITY(U,$J,358.3,28957,1,3,0)
 ;;=3^Indiv Psychophysiological Tx w/ Biofeedback,45 min
 ;;^UTILITY(U,$J,358.3,28958,0)
 ;;=90832^^117^1441^1^^^^1
 ;;^UTILITY(U,$J,358.3,28958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28958,1,2,0)
 ;;=2^90832
 ;;^UTILITY(U,$J,358.3,28958,1,3,0)
 ;;=3^Psychotherapy 16-37 min
 ;;^UTILITY(U,$J,358.3,28959,0)
 ;;=90834^^117^1441^2^^^^1
 ;;^UTILITY(U,$J,358.3,28959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28959,1,2,0)
 ;;=2^90834
 ;;^UTILITY(U,$J,358.3,28959,1,3,0)
 ;;=3^Psychotherapy 38-52 min
 ;;^UTILITY(U,$J,358.3,28960,0)
 ;;=90837^^117^1441^3^^^^1
 ;;^UTILITY(U,$J,358.3,28960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28960,1,2,0)
 ;;=2^90837
 ;;^UTILITY(U,$J,358.3,28960,1,3,0)
 ;;=3^Psychotherapy 53-89 min
 ;;^UTILITY(U,$J,358.3,28961,0)
 ;;=90849^^117^1441^9^^^^1
 ;;^UTILITY(U,$J,358.3,28961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28961,1,2,0)
 ;;=2^90849
 ;;^UTILITY(U,$J,358.3,28961,1,3,0)
 ;;=3^Multiple Family Psychotherapy
 ;;^UTILITY(U,$J,358.3,28962,0)
 ;;=97533^^117^1442^7^^^^1
 ;;^UTILITY(U,$J,358.3,28962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28962,1,2,0)
 ;;=2^97533
 ;;^UTILITY(U,$J,358.3,28962,1,3,0)
 ;;=3^Sensory Integrative Techniques,per 15 min
 ;;^UTILITY(U,$J,358.3,28963,0)
 ;;=H0046^^117^1442^6^^^^1
 ;;^UTILITY(U,$J,358.3,28963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28963,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,28963,1,3,0)
 ;;=3^PTSD Group
 ;;^UTILITY(U,$J,358.3,28964,0)
 ;;=G0177^^117^1442^10^^^^1
 ;;^UTILITY(U,$J,358.3,28964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28964,1,2,0)
 ;;=2^G0177
 ;;^UTILITY(U,$J,358.3,28964,1,3,0)
 ;;=3^Train & Ed for Disabiling MH Problem,45+ min
 ;;^UTILITY(U,$J,358.3,28965,0)
 ;;=T1016^^117^1442^1^^^^1
 ;;^UTILITY(U,$J,358.3,28965,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28965,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,28965,1,3,0)
 ;;=3^Case Management,ea 15 min
 ;;^UTILITY(U,$J,358.3,28966,0)
 ;;=S9484^^117^1442^3^^^^1
 ;;^UTILITY(U,$J,358.3,28966,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28966,1,2,0)
 ;;=2^S9484
 ;;^UTILITY(U,$J,358.3,28966,1,3,0)
 ;;=3^Crisis Intervention,per hr
 ;;^UTILITY(U,$J,358.3,28967,0)
 ;;=H2011^^117^1442^2^^^^1
 ;;^UTILITY(U,$J,358.3,28967,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28967,1,2,0)
 ;;=2^H2011
 ;;^UTILITY(U,$J,358.3,28967,1,3,0)
 ;;=3^Crisis Intervention Svc,per 15 min
 ;;^UTILITY(U,$J,358.3,28968,0)
 ;;=S9446^^117^1442^4^^^^1
 ;;^UTILITY(U,$J,358.3,28968,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28968,1,2,0)
 ;;=2^S9446
 ;;^UTILITY(U,$J,358.3,28968,1,3,0)
 ;;=3^Group Educational Svcs,NOS,Non Phys
 ;;^UTILITY(U,$J,358.3,28969,0)
 ;;=S9452^^117^1442^5^^^^1
 ;;^UTILITY(U,$J,358.3,28969,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,28969,1,2,0)
 ;;=2^S9452
 ;;^UTILITY(U,$J,358.3,28969,1,3,0)
 ;;=3^Nutrition Class,Non-MD,per session
 ;;^UTILITY(U,$J,358.3,28970,0)
 ;;=S9454^^117^1442^8^^^^1
