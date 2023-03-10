IBDEI10L ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16499,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,16499,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,16500,0)
 ;;=D75.9^^61^775^60
 ;;^UTILITY(U,$J,358.3,16500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16500,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,16500,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,16500,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,16501,0)
 ;;=D59.0^^61^775^63
 ;;^UTILITY(U,$J,358.3,16501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16501,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,16501,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,16501,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,16502,0)
 ;;=D59.2^^61^775^64
 ;;^UTILITY(U,$J,358.3,16502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16502,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,16502,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,16502,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,16503,0)
 ;;=R59.9^^61^775^67
 ;;^UTILITY(U,$J,358.3,16503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16503,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,16503,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,16503,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,16504,0)
 ;;=D47.3^^61^775^68
 ;;^UTILITY(U,$J,358.3,16504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16504,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,16504,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,16504,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,16505,0)
 ;;=C82.09^^61^775^69
 ;;^UTILITY(U,$J,358.3,16505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16505,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,16505,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,16505,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,16506,0)
 ;;=C82.00^^61^775^70
 ;;^UTILITY(U,$J,358.3,16506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16506,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,16506,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,16506,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,16507,0)
 ;;=C82.19^^61^775^71
 ;;^UTILITY(U,$J,358.3,16507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16507,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,16507,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,16507,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,16508,0)
 ;;=C82.10^^61^775^72
 ;;^UTILITY(U,$J,358.3,16508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16508,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,16508,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,16508,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,16509,0)
 ;;=C82.29^^61^775^73
 ;;^UTILITY(U,$J,358.3,16509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16509,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,16509,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,16509,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,16510,0)
 ;;=C82.20^^61^775^74
 ;;^UTILITY(U,$J,358.3,16510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16510,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,16510,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,16510,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,16511,0)
 ;;=C82.39^^61^775^75
 ;;^UTILITY(U,$J,358.3,16511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16511,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
