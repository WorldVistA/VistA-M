IBDEI0IZ ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8540,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,8540,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,8541,0)
 ;;=D59.0^^39^401^63
 ;;^UTILITY(U,$J,358.3,8541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8541,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,8541,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,8541,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,8542,0)
 ;;=D59.2^^39^401^64
 ;;^UTILITY(U,$J,358.3,8542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8542,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,8542,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,8542,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,8543,0)
 ;;=R59.9^^39^401^67
 ;;^UTILITY(U,$J,358.3,8543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8543,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,8543,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,8543,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,8544,0)
 ;;=D47.3^^39^401^68
 ;;^UTILITY(U,$J,358.3,8544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8544,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,8544,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,8544,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,8545,0)
 ;;=C82.09^^39^401^69
 ;;^UTILITY(U,$J,358.3,8545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8545,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,8545,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,8545,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,8546,0)
 ;;=C82.00^^39^401^70
 ;;^UTILITY(U,$J,358.3,8546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8546,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,8546,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,8546,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,8547,0)
 ;;=C82.19^^39^401^71
 ;;^UTILITY(U,$J,358.3,8547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8547,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,8547,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,8547,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,8548,0)
 ;;=C82.10^^39^401^72
 ;;^UTILITY(U,$J,358.3,8548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8548,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,8548,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,8548,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,8549,0)
 ;;=C82.29^^39^401^73
 ;;^UTILITY(U,$J,358.3,8549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8549,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,8549,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,8549,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,8550,0)
 ;;=C82.20^^39^401^74
 ;;^UTILITY(U,$J,358.3,8550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8550,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,8550,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,8550,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,8551,0)
 ;;=C82.39^^39^401^75
 ;;^UTILITY(U,$J,358.3,8551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8551,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,8551,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,8551,2)
 ;;=^5001500
 ;;^UTILITY(U,$J,358.3,8552,0)
 ;;=C82.30^^39^401^76
 ;;^UTILITY(U,$J,358.3,8552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8552,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Unspec Site
