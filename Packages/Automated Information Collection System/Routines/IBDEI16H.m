IBDEI16H ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20034,2)
 ;;=^340496
 ;;^UTILITY(U,$J,358.3,20035,0)
 ;;=D75.9^^84^929^55
 ;;^UTILITY(U,$J,358.3,20035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20035,1,3,0)
 ;;=3^Disease of Blood/Blood-Forming Organs,Unspec
 ;;^UTILITY(U,$J,358.3,20035,1,4,0)
 ;;=4^D75.9
 ;;^UTILITY(U,$J,358.3,20035,2)
 ;;=^5002393
 ;;^UTILITY(U,$J,358.3,20036,0)
 ;;=D59.0^^84^929^58
 ;;^UTILITY(U,$J,358.3,20036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20036,1,3,0)
 ;;=3^Drug-Induced Autoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,20036,1,4,0)
 ;;=4^D59.0
 ;;^UTILITY(U,$J,358.3,20036,2)
 ;;=^5002323
 ;;^UTILITY(U,$J,358.3,20037,0)
 ;;=D59.2^^84^929^59
 ;;^UTILITY(U,$J,358.3,20037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20037,1,3,0)
 ;;=3^Drug-Induced Nonautoimmune Hemolytic Anemia
 ;;^UTILITY(U,$J,358.3,20037,1,4,0)
 ;;=4^D59.2
 ;;^UTILITY(U,$J,358.3,20037,2)
 ;;=^5002325
 ;;^UTILITY(U,$J,358.3,20038,0)
 ;;=R59.9^^84^929^62
 ;;^UTILITY(U,$J,358.3,20038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20038,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,20038,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,20038,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,20039,0)
 ;;=D47.3^^84^929^63
 ;;^UTILITY(U,$J,358.3,20039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20039,1,3,0)
 ;;=3^Essential Thrombocythemia
 ;;^UTILITY(U,$J,358.3,20039,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,20039,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,20040,0)
 ;;=C82.09^^84^929^64
 ;;^UTILITY(U,$J,358.3,20040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20040,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,20040,1,4,0)
 ;;=4^C82.09
 ;;^UTILITY(U,$J,358.3,20040,2)
 ;;=^5001470
 ;;^UTILITY(U,$J,358.3,20041,0)
 ;;=C82.00^^84^929^65
 ;;^UTILITY(U,$J,358.3,20041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20041,1,3,0)
 ;;=3^Follicular Lymphoma Grade I,Unspec Site
 ;;^UTILITY(U,$J,358.3,20041,1,4,0)
 ;;=4^C82.00
 ;;^UTILITY(U,$J,358.3,20041,2)
 ;;=^5001461
 ;;^UTILITY(U,$J,358.3,20042,0)
 ;;=C82.19^^84^929^66
 ;;^UTILITY(U,$J,358.3,20042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20042,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,20042,1,4,0)
 ;;=4^C82.19
 ;;^UTILITY(U,$J,358.3,20042,2)
 ;;=^5001480
 ;;^UTILITY(U,$J,358.3,20043,0)
 ;;=C82.10^^84^929^67
 ;;^UTILITY(U,$J,358.3,20043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20043,1,3,0)
 ;;=3^Follicular Lymphoma Grade II,Unspec Site
 ;;^UTILITY(U,$J,358.3,20043,1,4,0)
 ;;=4^C82.10
 ;;^UTILITY(U,$J,358.3,20043,2)
 ;;=^5001471
 ;;^UTILITY(U,$J,358.3,20044,0)
 ;;=C82.29^^84^929^68
 ;;^UTILITY(U,$J,358.3,20044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20044,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,20044,1,4,0)
 ;;=4^C82.29
 ;;^UTILITY(U,$J,358.3,20044,2)
 ;;=^5001490
 ;;^UTILITY(U,$J,358.3,20045,0)
 ;;=C82.20^^84^929^69
 ;;^UTILITY(U,$J,358.3,20045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20045,1,3,0)
 ;;=3^Follicular Lymphoma Grade III,Unspec Site
 ;;^UTILITY(U,$J,358.3,20045,1,4,0)
 ;;=4^C82.20
 ;;^UTILITY(U,$J,358.3,20045,2)
 ;;=^5001481
 ;;^UTILITY(U,$J,358.3,20046,0)
 ;;=C82.39^^84^929^70
 ;;^UTILITY(U,$J,358.3,20046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20046,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,20046,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,20046,2)
 ;;=^5001500
 ;;^UTILITY(U,$J,358.3,20047,0)
 ;;=C82.30^^84^929^71
 ;;^UTILITY(U,$J,358.3,20047,1,0)
 ;;=^358.31IA^4^2
