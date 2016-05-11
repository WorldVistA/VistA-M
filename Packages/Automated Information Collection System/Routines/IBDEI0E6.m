IBDEI0E6 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6518,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,6518,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,6518,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,6519,0)
 ;;=D75.9^^30^396^53
 ;;^UTILITY(U,$J,358.3,6519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6519,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,6519,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,6519,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,6520,0)
 ;;=D59.0^^30^396^56
 ;;^UTILITY(U,$J,358.3,6520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6520,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,6520,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,6520,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,6521,0)
 ;;=D59.2^^30^396^57
 ;;^UTILITY(U,$J,358.3,6521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6521,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,6521,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,6521,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,6522,0)
 ;;=R59.9^^30^396^60
 ;;^UTILITY(U,$J,358.3,6522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6522,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,6522,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,6522,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,6523,0)
 ;;=D47.3^^30^396^61
 ;;^UTILITY(U,$J,358.3,6523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6523,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,6523,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,6523,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,6524,0)
 ;;=C82.09^^30^396^62
 ;;^UTILITY(U,$J,358.3,6524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6524,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6524,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,6524,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,6525,0)
 ;;=C82.00^^30^396^63
 ;;^UTILITY(U,$J,358.3,6525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6525,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,6525,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,6525,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,6526,0)
 ;;=C82.19^^30^396^64
 ;;^UTILITY(U,$J,358.3,6526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6526,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6526,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,6526,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,6527,0)
 ;;=C82.10^^30^396^65
 ;;^UTILITY(U,$J,358.3,6527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6527,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,6527,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,6527,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,6528,0)
 ;;=C82.29^^30^396^66
 ;;^UTILITY(U,$J,358.3,6528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6528,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6528,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,6528,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,6529,0)
 ;;=C82.20^^30^396^67
 ;;^UTILITY(U,$J,358.3,6529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6529,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,6529,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,6529,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,6530,0)
 ;;=C82.39^^30^396^68
 ;;^UTILITY(U,$J,358.3,6530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6530,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6530,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,6530,2)
 ;;=^5001500
