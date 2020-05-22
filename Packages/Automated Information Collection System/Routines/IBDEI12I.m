IBDEI12I ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17160,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/ Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,17160,1,4,0)
 ;;=4^G40.901
 ;;^UTILITY(U,$J,358.3,17160,2)
 ;;=^5003864
 ;;^UTILITY(U,$J,358.3,17161,0)
 ;;=G40.909^^88^886^15
 ;;^UTILITY(U,$J,358.3,17161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17161,1,3,0)
 ;;=3^Epilepsy,Not Intractable w/o Status Epilepticus,Unspec
 ;;^UTILITY(U,$J,358.3,17161,1,4,0)
 ;;=4^G40.909
 ;;^UTILITY(U,$J,358.3,17161,2)
 ;;=^5003865
 ;;^UTILITY(U,$J,358.3,17162,0)
 ;;=G43.809^^88^886^29
 ;;^UTILITY(U,$J,358.3,17162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17162,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,17162,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,17162,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,17163,0)
 ;;=G43.B0^^88^886^31
 ;;^UTILITY(U,$J,358.3,17163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17163,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,17163,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,17163,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,17164,0)
 ;;=G43.C0^^88^886^18
 ;;^UTILITY(U,$J,358.3,17164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17164,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,17164,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,17164,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,17165,0)
 ;;=G43.A0^^88^886^9
 ;;^UTILITY(U,$J,358.3,17165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17165,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,17165,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,17165,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,17166,0)
 ;;=G43.C1^^88^886^17
 ;;^UTILITY(U,$J,358.3,17166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17166,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,17166,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,17166,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,17167,0)
 ;;=G43.B1^^88^886^30
 ;;^UTILITY(U,$J,358.3,17167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17167,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,17167,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,17167,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,17168,0)
 ;;=G43.A1^^88^886^8
 ;;^UTILITY(U,$J,358.3,17168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17168,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,17168,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,17168,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,17169,0)
 ;;=G43.819^^88^886^26
 ;;^UTILITY(U,$J,358.3,17169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17169,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,17169,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,17169,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,17170,0)
 ;;=G43.909^^88^886^28
 ;;^UTILITY(U,$J,358.3,17170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17170,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,17170,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,17170,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,17171,0)
 ;;=G43.919^^88^886^27
 ;;^UTILITY(U,$J,358.3,17171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17171,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,17171,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,17171,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,17172,0)
 ;;=G51.0^^88^886^6
