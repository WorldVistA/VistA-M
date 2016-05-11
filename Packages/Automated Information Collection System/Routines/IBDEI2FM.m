IBDEI2FM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41251,1,3,0)
 ;;=3^Cutaneous Follicle Center Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,41251,1,4,0)
 ;;=4^C82.60
 ;;^UTILITY(U,$J,358.3,41251,2)
 ;;=^5001521
 ;;^UTILITY(U,$J,358.3,41252,0)
 ;;=D56.2^^159^2004^54
 ;;^UTILITY(U,$J,358.3,41252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41252,1,3,0)
 ;;=3^Delta-Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,41252,1,4,0)
 ;;=4^D56.2
 ;;^UTILITY(U,$J,358.3,41252,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,41253,0)
 ;;=D75.9^^159^2004^55
 ;;^UTILITY(U,$J,358.3,41253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41253,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,41253,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,41253,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,41254,0)
 ;;=D59.0^^159^2004^58
 ;;^UTILITY(U,$J,358.3,41254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41254,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,41254,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,41254,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,41255,0)
 ;;=D59.2^^159^2004^59
 ;;^UTILITY(U,$J,358.3,41255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41255,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,41255,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,41255,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,41256,0)
 ;;=R59.9^^159^2004^62
 ;;^UTILITY(U,$J,358.3,41256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41256,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,41256,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,41256,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,41257,0)
 ;;=D47.3^^159^2004^63
 ;;^UTILITY(U,$J,358.3,41257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41257,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,41257,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,41257,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,41258,0)
 ;;=C82.09^^159^2004^64
 ;;^UTILITY(U,$J,358.3,41258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41258,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,41258,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,41258,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,41259,0)
 ;;=C82.00^^159^2004^65
 ;;^UTILITY(U,$J,358.3,41259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41259,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,41259,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,41259,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,41260,0)
 ;;=C82.19^^159^2004^66
 ;;^UTILITY(U,$J,358.3,41260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41260,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,41260,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,41260,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,41261,0)
 ;;=C82.10^^159^2004^67
 ;;^UTILITY(U,$J,358.3,41261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41261,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,41261,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,41261,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,41262,0)
 ;;=C82.29^^159^2004^68
 ;;^UTILITY(U,$J,358.3,41262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41262,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,41262,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,41262,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,41263,0)
 ;;=C82.20^^159^2004^69
 ;;^UTILITY(U,$J,358.3,41263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41263,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,41263,1,4,0)
 ;;=4^C82.20
