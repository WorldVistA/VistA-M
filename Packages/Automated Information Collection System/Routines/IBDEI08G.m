IBDEI08G ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3479,2)
 ;;=^321980^332.0
 ;;^UTILITY(U,$J,358.3,3480,0)
 ;;=294.11^^11^149^11
 ;;^UTILITY(U,$J,358.3,3480,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3480,1,2,0)
 ;;=2^294.11
 ;;^UTILITY(U,$J,358.3,3480,1,5,0)
 ;;=5^Dementia d/t Parkinson w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,3480,2)
 ;;=^321982^332.0
 ;;^UTILITY(U,$J,358.3,3481,0)
 ;;=294.11^^11^149^9
 ;;^UTILITY(U,$J,358.3,3481,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3481,1,2,0)
 ;;=2^294.11
 ;;^UTILITY(U,$J,358.3,3481,1,5,0)
 ;;=5^Dementia d/t MS w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,3481,2)
 ;;=^321982^340.
 ;;^UTILITY(U,$J,358.3,3482,0)
 ;;=294.10^^11^149^10
 ;;^UTILITY(U,$J,358.3,3482,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3482,1,2,0)
 ;;=2^294.10
 ;;^UTILITY(U,$J,358.3,3482,1,5,0)
 ;;=5^Dementia d/t MS w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,3482,2)
 ;;=^321980^340.
 ;;^UTILITY(U,$J,358.3,3483,0)
 ;;=293.0^^11^150^1
 ;;^UTILITY(U,$J,358.3,3483,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3483,1,2,0)
 ;;=2^293.0
 ;;^UTILITY(U,$J,358.3,3483,1,5,0)
 ;;=5^Acute Delirium d/t Oth Spec Condition
 ;;^UTILITY(U,$J,358.3,3483,2)
 ;;=Acute Delirium^268035
 ;;^UTILITY(U,$J,358.3,3484,0)
 ;;=291.0^^11^150^2
 ;;^UTILITY(U,$J,358.3,3484,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3484,1,2,0)
 ;;=2^291.0
 ;;^UTILITY(U,$J,358.3,3484,1,5,0)
 ;;=5^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,3484,2)
 ;;=Withdrawal Delirium^4589
 ;;^UTILITY(U,$J,358.3,3485,0)
 ;;=292.81^^11^150^3
 ;;^UTILITY(U,$J,358.3,3485,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3485,1,2,0)
 ;;=2^292.81
 ;;^UTILITY(U,$J,358.3,3485,1,5,0)
 ;;=5^Drug Induced Delirium
 ;;^UTILITY(U,$J,358.3,3485,2)
 ;;=Drug Induced Delirium^268022
 ;;^UTILITY(U,$J,358.3,3486,0)
 ;;=296.50^^11^151^6
 ;;^UTILITY(U,$J,358.3,3486,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3486,1,2,0)
 ;;=2^296.50
 ;;^UTILITY(U,$J,358.3,3486,1,5,0)
 ;;=5^Bipolar Depressed, NOS
 ;;^UTILITY(U,$J,358.3,3486,2)
 ;;=^268130
 ;;^UTILITY(U,$J,358.3,3487,0)
 ;;=296.51^^11^151^4
 ;;^UTILITY(U,$J,358.3,3487,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3487,1,2,0)
 ;;=2^296.51
 ;;^UTILITY(U,$J,358.3,3487,1,5,0)
 ;;=5^Bipolar Depressed, Mild
 ;;^UTILITY(U,$J,358.3,3487,2)
 ;;=^303620
 ;;^UTILITY(U,$J,358.3,3488,0)
 ;;=296.52^^11^151^5
 ;;^UTILITY(U,$J,358.3,3488,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3488,1,2,0)
 ;;=2^296.52
 ;;^UTILITY(U,$J,358.3,3488,1,5,0)
 ;;=5^Bipolar Depressed, Moderate
 ;;^UTILITY(U,$J,358.3,3488,2)
 ;;=^303621
 ;;^UTILITY(U,$J,358.3,3489,0)
 ;;=296.53^^11^151^2
 ;;^UTILITY(U,$J,358.3,3489,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3489,1,2,0)
 ;;=2^296.53
 ;;^UTILITY(U,$J,358.3,3489,1,5,0)
 ;;=5^Bipolar Depress Severe w/o Psychosis
 ;;^UTILITY(U,$J,358.3,3489,2)
 ;;=^303622
 ;;^UTILITY(U,$J,358.3,3490,0)
 ;;=296.54^^11^151^1
 ;;^UTILITY(U,$J,358.3,3490,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3490,1,2,0)
 ;;=2^296.54
 ;;^UTILITY(U,$J,358.3,3490,1,5,0)
 ;;=5^Bipolar Depress Severe w/Psychosis
 ;;^UTILITY(U,$J,358.3,3490,2)
 ;;=Bipolar Depress Severe w/Psychosis^303623
 ;;^UTILITY(U,$J,358.3,3491,0)
 ;;=296.55^^11^151^7
 ;;^UTILITY(U,$J,358.3,3491,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3491,1,2,0)
 ;;=2^296.55
 ;;^UTILITY(U,$J,358.3,3491,1,5,0)
 ;;=5^Bipolar Depressed, Part or Unspec Remiss
 ;;^UTILITY(U,$J,358.3,3491,2)
 ;;=^303624
 ;;^UTILITY(U,$J,358.3,3492,0)
 ;;=296.56^^11^151^3
 ;;^UTILITY(U,$J,358.3,3492,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3492,1,2,0)
 ;;=2^296.56
 ;;^UTILITY(U,$J,358.3,3492,1,5,0)
 ;;=5^Bipolar Depressed, Full Remission
