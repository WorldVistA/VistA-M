IBDEI0H5 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7438,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,7438,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,7439,0)
 ;;=G43.C1^^58^474^16
 ;;^UTILITY(U,$J,358.3,7439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7439,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,7439,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,7439,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,7440,0)
 ;;=G43.B1^^58^474^29
 ;;^UTILITY(U,$J,358.3,7440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7440,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,7440,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,7440,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,7441,0)
 ;;=G43.A1^^58^474^7
 ;;^UTILITY(U,$J,358.3,7441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7441,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,7441,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,7441,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,7442,0)
 ;;=G43.819^^58^474^25
 ;;^UTILITY(U,$J,358.3,7442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7442,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,7442,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,7442,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,7443,0)
 ;;=G43.909^^58^474^27
 ;;^UTILITY(U,$J,358.3,7443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7443,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,7443,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,7443,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,7444,0)
 ;;=G43.919^^58^474^26
 ;;^UTILITY(U,$J,358.3,7444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7444,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,7444,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,7444,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,7445,0)
 ;;=G51.0^^58^474^5
 ;;^UTILITY(U,$J,358.3,7445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7445,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,7445,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,7445,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,7446,0)
 ;;=G57.10^^58^474^22
 ;;^UTILITY(U,$J,358.3,7446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7446,1,3,0)
 ;;=3^Meralgia Paresthetica Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,7446,1,4,0)
 ;;=4^G57.10
 ;;^UTILITY(U,$J,358.3,7446,2)
 ;;=^5004041
 ;;^UTILITY(U,$J,358.3,7447,0)
 ;;=G57.12^^58^474^23
 ;;^UTILITY(U,$J,358.3,7447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7447,1,3,0)
 ;;=3^Meralgia Paresthetica,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,7447,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,7447,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,7448,0)
 ;;=G57.11^^58^474^24
 ;;^UTILITY(U,$J,358.3,7448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7448,1,3,0)
 ;;=3^Meralgia Paresthetica,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,7448,1,4,0)
 ;;=4^G57.11
 ;;^UTILITY(U,$J,358.3,7448,2)
 ;;=^5004042
 ;;^UTILITY(U,$J,358.3,7449,0)
 ;;=G60.8^^58^474^32
 ;;^UTILITY(U,$J,358.3,7449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7449,1,3,0)
 ;;=3^Neuropathies,Oth Hereditary and Idiopathic
 ;;^UTILITY(U,$J,358.3,7449,1,4,0)
 ;;=4^G60.8
 ;;^UTILITY(U,$J,358.3,7449,2)
 ;;=^5004070
 ;;^UTILITY(U,$J,358.3,7450,0)
 ;;=G60.9^^58^474^33
 ;;^UTILITY(U,$J,358.3,7450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7450,1,3,0)
 ;;=3^Neuropathy,Hereditary and Idiopathic Unspec
 ;;^UTILITY(U,$J,358.3,7450,1,4,0)
 ;;=4^G60.9
