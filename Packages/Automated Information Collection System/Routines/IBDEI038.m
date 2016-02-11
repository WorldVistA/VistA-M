IBDEI038 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,768,2)
 ;;=^271938
 ;;^UTILITY(U,$J,358.3,769,0)
 ;;=L50.9^^9^88^113
 ;;^UTILITY(U,$J,358.3,769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,769,1,3,0)
 ;;=3^Urticaria,Unspec
 ;;^UTILITY(U,$J,358.3,769,1,4,0)
 ;;=4^L50.9
 ;;^UTILITY(U,$J,358.3,769,2)
 ;;=^5009204
 ;;^UTILITY(U,$J,358.3,770,0)
 ;;=J30.0^^9^88^114
 ;;^UTILITY(U,$J,358.3,770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,770,1,3,0)
 ;;=3^Vasomotor Rhinitis
 ;;^UTILITY(U,$J,358.3,770,1,4,0)
 ;;=4^J30.0
 ;;^UTILITY(U,$J,358.3,770,2)
 ;;=^5008201
 ;;^UTILITY(U,$J,358.3,771,0)
 ;;=R06.2^^9^88^116
 ;;^UTILITY(U,$J,358.3,771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,771,1,3,0)
 ;;=3^Wheezing
 ;;^UTILITY(U,$J,358.3,771,1,4,0)
 ;;=4^R06.2
 ;;^UTILITY(U,$J,358.3,771,2)
 ;;=^5019184
 ;;^UTILITY(U,$J,358.3,772,0)
 ;;=D51.0^^9^88^115
 ;;^UTILITY(U,$J,358.3,772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,772,1,3,0)
 ;;=3^Vitamin B12 Defic Anemia d/t Intrinsic Factor Defic
 ;;^UTILITY(U,$J,358.3,772,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,772,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,773,0)
 ;;=Z88.0^^9^88^36
 ;;^UTILITY(U,$J,358.3,773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,773,1,3,0)
 ;;=3^Allergy to Penicillin
 ;;^UTILITY(U,$J,358.3,773,1,4,0)
 ;;=4^Z88.0
 ;;^UTILITY(U,$J,358.3,773,2)
 ;;=^5063521
 ;;^UTILITY(U,$J,358.3,774,0)
 ;;=L20.0^^9^88^53
 ;;^UTILITY(U,$J,358.3,774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,774,1,3,0)
 ;;=3^Besnier's Prurigo
 ;;^UTILITY(U,$J,358.3,774,1,4,0)
 ;;=4^L20.0
 ;;^UTILITY(U,$J,358.3,774,2)
 ;;=^5009107
 ;;^UTILITY(U,$J,358.3,775,0)
 ;;=J30.2^^9^88^109
 ;;^UTILITY(U,$J,358.3,775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,775,1,3,0)
 ;;=3^Seasonal Allergies
 ;;^UTILITY(U,$J,358.3,775,1,4,0)
 ;;=4^J30.2
 ;;^UTILITY(U,$J,358.3,775,2)
 ;;=^5008202
 ;;^UTILITY(U,$J,358.3,776,0)
 ;;=Z88.1^^9^88^28
 ;;^UTILITY(U,$J,358.3,776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,776,1,3,0)
 ;;=3^Allergy to Antibiotic Agents NEC
 ;;^UTILITY(U,$J,358.3,776,1,4,0)
 ;;=4^Z88.1
 ;;^UTILITY(U,$J,358.3,776,2)
 ;;=^5063522
 ;;^UTILITY(U,$J,358.3,777,0)
 ;;=Z88.2^^9^88^39
 ;;^UTILITY(U,$J,358.3,777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,777,1,3,0)
 ;;=3^Allergy to Sulfonamides
 ;;^UTILITY(U,$J,358.3,777,1,4,0)
 ;;=4^Z88.2
 ;;^UTILITY(U,$J,358.3,777,2)
 ;;=^5063523
 ;;^UTILITY(U,$J,358.3,778,0)
 ;;=Z88.3^^9^88^27
 ;;^UTILITY(U,$J,358.3,778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,778,1,3,0)
 ;;=3^Allergy to Anti-Infective Agents NEC
 ;;^UTILITY(U,$J,358.3,778,1,4,0)
 ;;=4^Z88.3
 ;;^UTILITY(U,$J,358.3,778,2)
 ;;=^5063524
 ;;^UTILITY(U,$J,358.3,779,0)
 ;;=Z88.4^^9^88^26
 ;;^UTILITY(U,$J,358.3,779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,779,1,3,0)
 ;;=3^Allergy to Anesthetic Agent
 ;;^UTILITY(U,$J,358.3,779,1,4,0)
 ;;=4^Z88.4
 ;;^UTILITY(U,$J,358.3,779,2)
 ;;=^5063525
 ;;^UTILITY(U,$J,358.3,780,0)
 ;;=Z88.5^^9^88^33
 ;;^UTILITY(U,$J,358.3,780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,780,1,3,0)
 ;;=3^Allergy to Narcotic Agent
 ;;^UTILITY(U,$J,358.3,780,1,4,0)
 ;;=4^Z88.5
 ;;^UTILITY(U,$J,358.3,780,2)
 ;;=^5063526
 ;;^UTILITY(U,$J,358.3,781,0)
 ;;=Z88.6^^9^88^25
 ;;^UTILITY(U,$J,358.3,781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,781,1,3,0)
 ;;=3^Allergy to Analgesic Agent
 ;;^UTILITY(U,$J,358.3,781,1,4,0)
 ;;=4^Z88.6
 ;;^UTILITY(U,$J,358.3,781,2)
 ;;=^5063527
 ;;^UTILITY(U,$J,358.3,782,0)
 ;;=Z88.7^^9^88^38
 ;;^UTILITY(U,$J,358.3,782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,782,1,3,0)
 ;;=3^Allergy to Serum and Vaccine
 ;;^UTILITY(U,$J,358.3,782,1,4,0)
 ;;=4^Z88.7
 ;;^UTILITY(U,$J,358.3,782,2)
 ;;=^5063528
