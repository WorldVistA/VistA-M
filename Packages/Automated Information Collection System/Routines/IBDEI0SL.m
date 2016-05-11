IBDEI0SL ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13408,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,13409,0)
 ;;=D75.9^^53^593^55
 ;;^UTILITY(U,$J,358.3,13409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13409,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,13409,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,13409,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,13410,0)
 ;;=D59.0^^53^593^58
 ;;^UTILITY(U,$J,358.3,13410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13410,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,13410,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,13410,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,13411,0)
 ;;=D59.2^^53^593^59
 ;;^UTILITY(U,$J,358.3,13411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13411,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,13411,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,13411,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,13412,0)
 ;;=R59.9^^53^593^62
 ;;^UTILITY(U,$J,358.3,13412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13412,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,13412,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,13412,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,13413,0)
 ;;=D47.3^^53^593^63
 ;;^UTILITY(U,$J,358.3,13413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13413,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,13413,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,13413,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,13414,0)
 ;;=C82.09^^53^593^64
 ;;^UTILITY(U,$J,358.3,13414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13414,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,13414,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,13414,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,13415,0)
 ;;=C82.00^^53^593^65
 ;;^UTILITY(U,$J,358.3,13415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13415,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,13415,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,13415,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,13416,0)
 ;;=C82.19^^53^593^66
 ;;^UTILITY(U,$J,358.3,13416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13416,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,13416,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,13416,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,13417,0)
 ;;=C82.10^^53^593^67
 ;;^UTILITY(U,$J,358.3,13417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13417,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,13417,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,13417,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,13418,0)
 ;;=C82.29^^53^593^68
 ;;^UTILITY(U,$J,358.3,13418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13418,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,13418,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,13418,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,13419,0)
 ;;=C82.20^^53^593^69
 ;;^UTILITY(U,$J,358.3,13419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13419,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,13419,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,13419,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,13420,0)
 ;;=C82.39^^53^593^70
 ;;^UTILITY(U,$J,358.3,13420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13420,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,13420,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,13420,2)
 ;;=^5001500
 ;;^UTILITY(U,$J,358.3,13421,0)
 ;;=C82.30^^53^593^71
 ;;^UTILITY(U,$J,358.3,13421,1,0)
 ;;=^358.31IA^4^2
