IBDEI0IM ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8376,1,3,0)
 ;;=3^Cystitis w/o Hematuria,Irradiation
 ;;^UTILITY(U,$J,358.3,8376,1,4,0)
 ;;=4^N30.40
 ;;^UTILITY(U,$J,358.3,8376,2)
 ;;=^5015639
 ;;^UTILITY(U,$J,358.3,8377,0)
 ;;=N32.0^^39^398^8
 ;;^UTILITY(U,$J,358.3,8377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8377,1,3,0)
 ;;=3^Bladder-Neck Obstruction
 ;;^UTILITY(U,$J,358.3,8377,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,8377,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,8378,0)
 ;;=N31.9^^39^398^79
 ;;^UTILITY(U,$J,358.3,8378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8378,1,3,0)
 ;;=3^Neurogenic Bladder Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,8378,1,4,0)
 ;;=4^N31.9
 ;;^UTILITY(U,$J,358.3,8378,2)
 ;;=^5015648
 ;;^UTILITY(U,$J,358.3,8379,0)
 ;;=N31.1^^39^398^80
 ;;^UTILITY(U,$J,358.3,8379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8379,1,3,0)
 ;;=3^Neuropathic Bladder,Reflex NEC
 ;;^UTILITY(U,$J,358.3,8379,1,4,0)
 ;;=4^N31.1
 ;;^UTILITY(U,$J,358.3,8379,2)
 ;;=^5015645
 ;;^UTILITY(U,$J,358.3,8380,0)
 ;;=N32.89^^39^398^7
 ;;^UTILITY(U,$J,358.3,8380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8380,1,3,0)
 ;;=3^Bladder Disorders,Other Spec
 ;;^UTILITY(U,$J,358.3,8380,1,4,0)
 ;;=4^N32.89
 ;;^UTILITY(U,$J,358.3,8380,2)
 ;;=^87989
 ;;^UTILITY(U,$J,358.3,8381,0)
 ;;=N33.^^39^398^6
 ;;^UTILITY(U,$J,358.3,8381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8381,1,3,0)
 ;;=3^Bladder Disorders,Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,8381,1,4,0)
 ;;=4^N33.
 ;;^UTILITY(U,$J,358.3,8381,2)
 ;;=^5015654
 ;;^UTILITY(U,$J,358.3,8382,0)
 ;;=N34.2^^39^398^115
 ;;^UTILITY(U,$J,358.3,8382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8382,1,3,0)
 ;;=3^Urethritis
 ;;^UTILITY(U,$J,358.3,8382,1,4,0)
 ;;=4^N34.2
 ;;^UTILITY(U,$J,358.3,8382,2)
 ;;=^88231
 ;;^UTILITY(U,$J,358.3,8383,0)
 ;;=N34.1^^39^398^116
 ;;^UTILITY(U,$J,358.3,8383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8383,1,3,0)
 ;;=3^Urethritis,Nonspec
 ;;^UTILITY(U,$J,358.3,8383,1,4,0)
 ;;=4^N34.1
 ;;^UTILITY(U,$J,358.3,8383,2)
 ;;=^5015655
 ;;^UTILITY(U,$J,358.3,8384,0)
 ;;=N39.0^^39^398^120
 ;;^UTILITY(U,$J,358.3,8384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8384,1,3,0)
 ;;=3^Urinary Tract Infection,Site Not Spec
 ;;^UTILITY(U,$J,358.3,8384,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,8384,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,8385,0)
 ;;=N31.0^^39^398^81
 ;;^UTILITY(U,$J,358.3,8385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8385,1,3,0)
 ;;=3^Neuropathic Bladder,Uninhibited NEC
 ;;^UTILITY(U,$J,358.3,8385,1,4,0)
 ;;=4^N31.0
 ;;^UTILITY(U,$J,358.3,8385,2)
 ;;=^5015644
 ;;^UTILITY(U,$J,358.3,8386,0)
 ;;=R31.9^^39^398^60
 ;;^UTILITY(U,$J,358.3,8386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8386,1,3,0)
 ;;=3^Hematuria,Unspec
 ;;^UTILITY(U,$J,358.3,8386,1,4,0)
 ;;=4^R31.9
 ;;^UTILITY(U,$J,358.3,8386,2)
 ;;=^5019328
 ;;^UTILITY(U,$J,358.3,8387,0)
 ;;=R31.0^^39^398^57
 ;;^UTILITY(U,$J,358.3,8387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8387,1,3,0)
 ;;=3^Hematuria,Gross
 ;;^UTILITY(U,$J,358.3,8387,1,4,0)
 ;;=4^R31.0
 ;;^UTILITY(U,$J,358.3,8387,2)
 ;;=^5019325
 ;;^UTILITY(U,$J,358.3,8388,0)
 ;;=R31.1^^39^398^56
 ;;^UTILITY(U,$J,358.3,8388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8388,1,3,0)
 ;;=3^Hematuria,Benign Essential Microscopic
 ;;^UTILITY(U,$J,358.3,8388,1,4,0)
 ;;=4^R31.1
 ;;^UTILITY(U,$J,358.3,8388,2)
 ;;=^5019326
 ;;^UTILITY(U,$J,358.3,8389,0)
 ;;=N40.0^^39^398^3
