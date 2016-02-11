IBDEI355 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52730,1,3,0)
 ;;=3^Adjustment disorder with disturbance of conduct
 ;;^UTILITY(U,$J,358.3,52730,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,52730,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,52731,0)
 ;;=F43.25^^240^2639^1
 ;;^UTILITY(U,$J,358.3,52731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52731,1,3,0)
 ;;=3^Adjustment disorder w mixed disturb of emotions and conduct
 ;;^UTILITY(U,$J,358.3,52731,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,52731,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,52732,0)
 ;;=F43.29^^240^2639^6
 ;;^UTILITY(U,$J,358.3,52732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52732,1,3,0)
 ;;=3^Adjustment disorder with other symptoms
 ;;^UTILITY(U,$J,358.3,52732,1,4,0)
 ;;=4^F43.29
 ;;^UTILITY(U,$J,358.3,52732,2)
 ;;=^5003574
 ;;^UTILITY(U,$J,358.3,52733,0)
 ;;=M79.7^^240^2640^2
 ;;^UTILITY(U,$J,358.3,52733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52733,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,52733,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,52733,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,52734,0)
 ;;=R20.2^^240^2640^3
 ;;^UTILITY(U,$J,358.3,52734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52734,1,3,0)
 ;;=3^Paresthesia of skin
 ;;^UTILITY(U,$J,358.3,52734,1,4,0)
 ;;=4^R20.2
 ;;^UTILITY(U,$J,358.3,52734,2)
 ;;=^5019280
 ;;^UTILITY(U,$J,358.3,52735,0)
 ;;=R42.^^240^2640^1
 ;;^UTILITY(U,$J,358.3,52735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52735,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,52735,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,52735,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,52736,0)
 ;;=G43.C0^^240^2641^21
 ;;^UTILITY(U,$J,358.3,52736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52736,1,3,0)
 ;;=3^Periodic headache syndromes in chld/adlt, not intractable
 ;;^UTILITY(U,$J,358.3,52736,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,52736,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,52737,0)
 ;;=G43.C1^^240^2641^20
 ;;^UTILITY(U,$J,358.3,52737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52737,1,3,0)
 ;;=3^Periodic headache syndromes in child or adult, intractable
 ;;^UTILITY(U,$J,358.3,52737,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,52737,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,52738,0)
 ;;=R51.^^240^2641^11
 ;;^UTILITY(U,$J,358.3,52738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52738,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,52738,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,52738,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,52739,0)
 ;;=G43.909^^240^2641^18
 ;;^UTILITY(U,$J,358.3,52739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52739,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,52739,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,52739,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,52740,0)
 ;;=G43.919^^240^2641^16
 ;;^UTILITY(U,$J,358.3,52740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52740,1,3,0)
 ;;=3^Migraine, unsp, intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,52740,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,52740,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,52741,0)
 ;;=G44.209^^240^2641^29
 ;;^UTILITY(U,$J,358.3,52741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52741,1,3,0)
 ;;=3^Tension-type headache, unspecified, not intractable
 ;;^UTILITY(U,$J,358.3,52741,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,52741,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,52742,0)
 ;;=G43.901^^240^2641^17
 ;;^UTILITY(U,$J,358.3,52742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52742,1,3,0)
 ;;=3^Migraine, unsp, not intractable, with status migrainosus
