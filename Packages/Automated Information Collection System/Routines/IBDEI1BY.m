IBDEI1BY ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23565,1,5,0)
 ;;=5^Alzheimers Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,23565,2)
 ;;=^321980^331.0
 ;;^UTILITY(U,$J,358.3,23566,0)
 ;;=294.10^^127^1423^12
 ;;^UTILITY(U,$J,358.3,23566,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23566,1,2,0)
 ;;=2^294.10
 ;;^UTILITY(U,$J,358.3,23566,1,5,0)
 ;;=5^Dementia d/t Parkinson w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,23566,2)
 ;;=^321980^332.0
 ;;^UTILITY(U,$J,358.3,23567,0)
 ;;=294.11^^127^1423^11
 ;;^UTILITY(U,$J,358.3,23567,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23567,1,2,0)
 ;;=2^294.11
 ;;^UTILITY(U,$J,358.3,23567,1,5,0)
 ;;=5^Dementia d/t Parkinson w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,23567,2)
 ;;=^321982^332.0
 ;;^UTILITY(U,$J,358.3,23568,0)
 ;;=294.11^^127^1423^9
 ;;^UTILITY(U,$J,358.3,23568,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23568,1,2,0)
 ;;=2^294.11
 ;;^UTILITY(U,$J,358.3,23568,1,5,0)
 ;;=5^Dementia d/t MS w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,23568,2)
 ;;=^321982^340.
 ;;^UTILITY(U,$J,358.3,23569,0)
 ;;=294.10^^127^1423^10
 ;;^UTILITY(U,$J,358.3,23569,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23569,1,2,0)
 ;;=2^294.10
 ;;^UTILITY(U,$J,358.3,23569,1,5,0)
 ;;=5^Dementia d/t MS w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,23569,2)
 ;;=^321980^340.
 ;;^UTILITY(U,$J,358.3,23570,0)
 ;;=293.0^^127^1424^1
 ;;^UTILITY(U,$J,358.3,23570,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23570,1,2,0)
 ;;=2^293.0
 ;;^UTILITY(U,$J,358.3,23570,1,5,0)
 ;;=5^Acute Delirium d/t Oth Spec Condition
 ;;^UTILITY(U,$J,358.3,23570,2)
 ;;=Acute Delirium^268035
 ;;^UTILITY(U,$J,358.3,23571,0)
 ;;=291.0^^127^1424^2
 ;;^UTILITY(U,$J,358.3,23571,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23571,1,2,0)
 ;;=2^291.0
 ;;^UTILITY(U,$J,358.3,23571,1,5,0)
 ;;=5^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,23571,2)
 ;;=Withdrawal Delirium^4589
 ;;^UTILITY(U,$J,358.3,23572,0)
 ;;=292.81^^127^1424^3
 ;;^UTILITY(U,$J,358.3,23572,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23572,1,2,0)
 ;;=2^292.81
 ;;^UTILITY(U,$J,358.3,23572,1,5,0)
 ;;=5^Drug Induced Delirium
 ;;^UTILITY(U,$J,358.3,23572,2)
 ;;=Drug Induced Delirium^268022
 ;;^UTILITY(U,$J,358.3,23573,0)
 ;;=296.50^^127^1425^6
 ;;^UTILITY(U,$J,358.3,23573,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23573,1,2,0)
 ;;=2^296.50
 ;;^UTILITY(U,$J,358.3,23573,1,5,0)
 ;;=5^Bipolar Depressed, NOS
 ;;^UTILITY(U,$J,358.3,23573,2)
 ;;=^268130
 ;;^UTILITY(U,$J,358.3,23574,0)
 ;;=296.51^^127^1425^4
 ;;^UTILITY(U,$J,358.3,23574,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23574,1,2,0)
 ;;=2^296.51
 ;;^UTILITY(U,$J,358.3,23574,1,5,0)
 ;;=5^Bipolar Depressed, Mild
 ;;^UTILITY(U,$J,358.3,23574,2)
 ;;=^303620
 ;;^UTILITY(U,$J,358.3,23575,0)
 ;;=296.52^^127^1425^5
 ;;^UTILITY(U,$J,358.3,23575,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23575,1,2,0)
 ;;=2^296.52
 ;;^UTILITY(U,$J,358.3,23575,1,5,0)
 ;;=5^Bipolar Depressed, Moderate
 ;;^UTILITY(U,$J,358.3,23575,2)
 ;;=^303621
 ;;^UTILITY(U,$J,358.3,23576,0)
 ;;=296.53^^127^1425^2
 ;;^UTILITY(U,$J,358.3,23576,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23576,1,2,0)
 ;;=2^296.53
 ;;^UTILITY(U,$J,358.3,23576,1,5,0)
 ;;=5^Bipolar Depress Severe w/o Psychosis
 ;;^UTILITY(U,$J,358.3,23576,2)
 ;;=^303622
 ;;^UTILITY(U,$J,358.3,23577,0)
 ;;=296.54^^127^1425^1
 ;;^UTILITY(U,$J,358.3,23577,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23577,1,2,0)
 ;;=2^296.54
 ;;^UTILITY(U,$J,358.3,23577,1,5,0)
 ;;=5^Bipolar Depress Severe w/Psychosis
 ;;^UTILITY(U,$J,358.3,23577,2)
 ;;=Bipolar Depress Severe w/Psychosis^303623
 ;;^UTILITY(U,$J,358.3,23578,0)
 ;;=296.55^^127^1425^7
