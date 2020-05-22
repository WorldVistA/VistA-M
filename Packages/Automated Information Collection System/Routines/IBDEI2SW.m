IBDEI2SW ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44673,0)
 ;;=F43.23^^167^2225^5
 ;;^UTILITY(U,$J,358.3,44673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44673,1,3,0)
 ;;=3^Adjustment disorder with mixed anxiety and depressed mood
 ;;^UTILITY(U,$J,358.3,44673,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,44673,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,44674,0)
 ;;=F43.24^^167^2225^4
 ;;^UTILITY(U,$J,358.3,44674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44674,1,3,0)
 ;;=3^Adjustment disorder with disturbance of conduct
 ;;^UTILITY(U,$J,358.3,44674,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,44674,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,44675,0)
 ;;=F43.25^^167^2225^1
 ;;^UTILITY(U,$J,358.3,44675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44675,1,3,0)
 ;;=3^Adjustment disorder w mixed disturb of emotions and conduct
 ;;^UTILITY(U,$J,358.3,44675,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,44675,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,44676,0)
 ;;=F43.29^^167^2225^6
 ;;^UTILITY(U,$J,358.3,44676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44676,1,3,0)
 ;;=3^Adjustment disorder with other symptoms
 ;;^UTILITY(U,$J,358.3,44676,1,4,0)
 ;;=4^F43.29
 ;;^UTILITY(U,$J,358.3,44676,2)
 ;;=^5003574
 ;;^UTILITY(U,$J,358.3,44677,0)
 ;;=F43.20^^167^2225^7
 ;;^UTILITY(U,$J,358.3,44677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44677,1,3,0)
 ;;=3^Adjustment disorder, unspec
 ;;^UTILITY(U,$J,358.3,44677,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,44677,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,44678,0)
 ;;=M79.7^^167^2226^2
 ;;^UTILITY(U,$J,358.3,44678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44678,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,44678,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,44678,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,44679,0)
 ;;=R20.2^^167^2226^3
 ;;^UTILITY(U,$J,358.3,44679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44679,1,3,0)
 ;;=3^Paresthesia of skin
 ;;^UTILITY(U,$J,358.3,44679,1,4,0)
 ;;=4^R20.2
 ;;^UTILITY(U,$J,358.3,44679,2)
 ;;=^5019280
 ;;^UTILITY(U,$J,358.3,44680,0)
 ;;=R42.^^167^2226^1
 ;;^UTILITY(U,$J,358.3,44680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44680,1,3,0)
 ;;=3^Dizziness and giddiness
 ;;^UTILITY(U,$J,358.3,44680,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,44680,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,44681,0)
 ;;=G43.C0^^167^2227^22
 ;;^UTILITY(U,$J,358.3,44681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44681,1,3,0)
 ;;=3^Periodic headache syndromes in chld/adlt, not intractable
 ;;^UTILITY(U,$J,358.3,44681,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,44681,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,44682,0)
 ;;=G43.C1^^167^2227^21
 ;;^UTILITY(U,$J,358.3,44682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44682,1,3,0)
 ;;=3^Periodic headache syndromes in child or adult, intractable
 ;;^UTILITY(U,$J,358.3,44682,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,44682,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,44683,0)
 ;;=R51.^^167^2227^12
 ;;^UTILITY(U,$J,358.3,44683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44683,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,44683,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,44683,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,44684,0)
 ;;=G43.909^^167^2227^19
 ;;^UTILITY(U,$J,358.3,44684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44684,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,44684,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,44684,2)
 ;;=^5003909
