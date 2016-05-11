IBDEI0FL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7193,0)
 ;;=G43.919^^30^403^26
 ;;^UTILITY(U,$J,358.3,7193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7193,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,7193,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,7193,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,7194,0)
 ;;=G51.0^^30^403^5
 ;;^UTILITY(U,$J,358.3,7194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7194,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,7194,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,7194,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,7195,0)
 ;;=G57.10^^30^403^22
 ;;^UTILITY(U,$J,358.3,7195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7195,1,3,0)
 ;;=3^Meralgia Paresthetica Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,7195,1,4,0)
 ;;=4^G57.10
 ;;^UTILITY(U,$J,358.3,7195,2)
 ;;=^5004041
 ;;^UTILITY(U,$J,358.3,7196,0)
 ;;=G57.12^^30^403^23
 ;;^UTILITY(U,$J,358.3,7196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7196,1,3,0)
 ;;=3^Meralgia Paresthetica,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,7196,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,7196,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,7197,0)
 ;;=G57.11^^30^403^24
 ;;^UTILITY(U,$J,358.3,7197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7197,1,3,0)
 ;;=3^Meralgia Paresthetica,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,7197,1,4,0)
 ;;=4^G57.11
 ;;^UTILITY(U,$J,358.3,7197,2)
 ;;=^5004042
 ;;^UTILITY(U,$J,358.3,7198,0)
 ;;=G60.8^^30^403^32
 ;;^UTILITY(U,$J,358.3,7198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7198,1,3,0)
 ;;=3^Neuropathies,Oth Hereditary and Idiopathic
 ;;^UTILITY(U,$J,358.3,7198,1,4,0)
 ;;=4^G60.8
 ;;^UTILITY(U,$J,358.3,7198,2)
 ;;=^5004070
 ;;^UTILITY(U,$J,358.3,7199,0)
 ;;=G60.9^^30^403^33
 ;;^UTILITY(U,$J,358.3,7199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7199,1,3,0)
 ;;=3^Neuropathy,Hereditary and Idiopathic Unspec
 ;;^UTILITY(U,$J,358.3,7199,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,7199,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,7200,0)
 ;;=R56.01^^30^403^7
 ;;^UTILITY(U,$J,358.3,7200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7200,1,3,0)
 ;;=3^Complex Febrile Convulsions
 ;;^UTILITY(U,$J,358.3,7200,1,4,0)
 ;;=4^R56.01
 ;;^UTILITY(U,$J,358.3,7200,2)
 ;;=^334162
 ;;^UTILITY(U,$J,358.3,7201,0)
 ;;=R56.1^^30^403^36
 ;;^UTILITY(U,$J,358.3,7201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7201,1,3,0)
 ;;=3^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,7201,1,4,0)
 ;;=4^R56.1
 ;;^UTILITY(U,$J,358.3,7201,2)
 ;;=^5019523
 ;;^UTILITY(U,$J,358.3,7202,0)
 ;;=R56.00^^30^403^40
 ;;^UTILITY(U,$J,358.3,7202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7202,1,3,0)
 ;;=3^Simple Febrile Convulsions
 ;;^UTILITY(U,$J,358.3,7202,1,4,0)
 ;;=4^R56.00
 ;;^UTILITY(U,$J,358.3,7202,2)
 ;;=^5019522
 ;;^UTILITY(U,$J,358.3,7203,0)
 ;;=R56.9^^30^403^8
 ;;^UTILITY(U,$J,358.3,7203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7203,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,7203,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,7203,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,7204,0)
 ;;=G89.0^^30^404^1
 ;;^UTILITY(U,$J,358.3,7204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7204,1,3,0)
 ;;=3^Central Pain Syndrome
 ;;^UTILITY(U,$J,358.3,7204,1,4,0)
 ;;=4^G89.0
 ;;^UTILITY(U,$J,358.3,7204,2)
 ;;=^334189
 ;;^UTILITY(U,$J,358.3,7205,0)
 ;;=G89.11^^30^404^10
 ;;^UTILITY(U,$J,358.3,7205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7205,1,3,0)
 ;;=3^Pain d/t Trauma,Acute
 ;;^UTILITY(U,$J,358.3,7205,1,4,0)
 ;;=4^G89.11
 ;;^UTILITY(U,$J,358.3,7205,2)
 ;;=^5004152
 ;;^UTILITY(U,$J,358.3,7206,0)
 ;;=G89.12^^30^404^14
 ;;^UTILITY(U,$J,358.3,7206,1,0)
 ;;=^358.31IA^4^2
