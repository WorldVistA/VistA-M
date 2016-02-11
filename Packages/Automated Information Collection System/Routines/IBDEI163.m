IBDEI163 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19500,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,19500,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,19500,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,19501,0)
 ;;=G43.A1^^94^923^7
 ;;^UTILITY(U,$J,358.3,19501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19501,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,19501,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,19501,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,19502,0)
 ;;=G43.819^^94^923^23
 ;;^UTILITY(U,$J,358.3,19502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19502,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,19502,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,19502,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,19503,0)
 ;;=G43.909^^94^923^25
 ;;^UTILITY(U,$J,358.3,19503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19503,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,19503,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,19503,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,19504,0)
 ;;=G43.919^^94^923^24
 ;;^UTILITY(U,$J,358.3,19504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19504,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,19504,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,19504,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,19505,0)
 ;;=G51.0^^94^923^5
 ;;^UTILITY(U,$J,358.3,19505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19505,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,19505,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,19505,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,19506,0)
 ;;=G57.10^^94^923^20
 ;;^UTILITY(U,$J,358.3,19506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19506,1,3,0)
 ;;=3^Meralgia Paresthetica Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,19506,1,4,0)
 ;;=4^G57.10
 ;;^UTILITY(U,$J,358.3,19506,2)
 ;;=^5004041
 ;;^UTILITY(U,$J,358.3,19507,0)
 ;;=G57.12^^94^923^21
 ;;^UTILITY(U,$J,358.3,19507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19507,1,3,0)
 ;;=3^Meralgia Paresthetica,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,19507,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,19507,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,19508,0)
 ;;=G57.11^^94^923^22
 ;;^UTILITY(U,$J,358.3,19508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19508,1,3,0)
 ;;=3^Meralgia Paresthetica,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,19508,1,4,0)
 ;;=4^G57.11
 ;;^UTILITY(U,$J,358.3,19508,2)
 ;;=^5004042
 ;;^UTILITY(U,$J,358.3,19509,0)
 ;;=G60.8^^94^923^30
 ;;^UTILITY(U,$J,358.3,19509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19509,1,3,0)
 ;;=3^Neuropathies,Oth Hereditary and Idiopathic
 ;;^UTILITY(U,$J,358.3,19509,1,4,0)
 ;;=4^G60.8
 ;;^UTILITY(U,$J,358.3,19509,2)
 ;;=^5004070
 ;;^UTILITY(U,$J,358.3,19510,0)
 ;;=G60.9^^94^923^31
 ;;^UTILITY(U,$J,358.3,19510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19510,1,3,0)
 ;;=3^Neuropathy,Hereditary and Idiopathic Unspec
 ;;^UTILITY(U,$J,358.3,19510,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,19510,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,19511,0)
 ;;=G89.0^^94^924^1
 ;;^UTILITY(U,$J,358.3,19511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19511,1,3,0)
 ;;=3^Central Pain Syndrome
 ;;^UTILITY(U,$J,358.3,19511,1,4,0)
 ;;=4^G89.0
 ;;^UTILITY(U,$J,358.3,19511,2)
 ;;=^334189
 ;;^UTILITY(U,$J,358.3,19512,0)
 ;;=G89.11^^94^924^10
 ;;^UTILITY(U,$J,358.3,19512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19512,1,3,0)
 ;;=3^Pain d/t Trauma,Acute
 ;;^UTILITY(U,$J,358.3,19512,1,4,0)
 ;;=4^G89.11
 ;;^UTILITY(U,$J,358.3,19512,2)
 ;;=^5004152
 ;;^UTILITY(U,$J,358.3,19513,0)
 ;;=G89.12^^94^924^14
