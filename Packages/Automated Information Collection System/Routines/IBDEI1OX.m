IBDEI1OX ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28283,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,28283,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,28283,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,28284,0)
 ;;=G43.A0^^132^1327^8
 ;;^UTILITY(U,$J,358.3,28284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28284,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,28284,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,28284,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,28285,0)
 ;;=G43.C1^^132^1327^16
 ;;^UTILITY(U,$J,358.3,28285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28285,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,28285,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,28285,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,28286,0)
 ;;=G43.B1^^132^1327^27
 ;;^UTILITY(U,$J,358.3,28286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28286,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,28286,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,28286,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,28287,0)
 ;;=G43.A1^^132^1327^7
 ;;^UTILITY(U,$J,358.3,28287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28287,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,28287,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,28287,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,28288,0)
 ;;=G43.819^^132^1327^23
 ;;^UTILITY(U,$J,358.3,28288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28288,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,28288,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,28288,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,28289,0)
 ;;=G43.909^^132^1327^25
 ;;^UTILITY(U,$J,358.3,28289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28289,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,28289,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,28289,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,28290,0)
 ;;=G43.919^^132^1327^24
 ;;^UTILITY(U,$J,358.3,28290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28290,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,28290,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,28290,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,28291,0)
 ;;=G51.0^^132^1327^5
 ;;^UTILITY(U,$J,358.3,28291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28291,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,28291,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,28291,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,28292,0)
 ;;=G57.10^^132^1327^20
 ;;^UTILITY(U,$J,358.3,28292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28292,1,3,0)
 ;;=3^Meralgia Paresthetica Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,28292,1,4,0)
 ;;=4^G57.10
 ;;^UTILITY(U,$J,358.3,28292,2)
 ;;=^5004041
 ;;^UTILITY(U,$J,358.3,28293,0)
 ;;=G57.12^^132^1327^21
 ;;^UTILITY(U,$J,358.3,28293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28293,1,3,0)
 ;;=3^Meralgia Paresthetica,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,28293,1,4,0)
 ;;=4^G57.12
 ;;^UTILITY(U,$J,358.3,28293,2)
 ;;=^5004043
 ;;^UTILITY(U,$J,358.3,28294,0)
 ;;=G57.11^^132^1327^22
 ;;^UTILITY(U,$J,358.3,28294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28294,1,3,0)
 ;;=3^Meralgia Paresthetica,Right Lower Limb
 ;;^UTILITY(U,$J,358.3,28294,1,4,0)
 ;;=4^G57.11
 ;;^UTILITY(U,$J,358.3,28294,2)
 ;;=^5004042
 ;;^UTILITY(U,$J,358.3,28295,0)
 ;;=G60.8^^132^1327^30
 ;;^UTILITY(U,$J,358.3,28295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28295,1,3,0)
 ;;=3^Neuropathies,Oth Hereditary and Idiopathic
 ;;^UTILITY(U,$J,358.3,28295,1,4,0)
 ;;=4^G60.8
