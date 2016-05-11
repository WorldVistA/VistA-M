IBDEI16I ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20047,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Unspec Site
 ;;^UTILITY(U,$J,358.3,20047,1,4,0)
 ;;=4^C82.30
 ;;^UTILITY(U,$J,358.3,20047,2)
 ;;=^5001491
 ;;^UTILITY(U,$J,358.3,20048,0)
 ;;=C82.49^^84^929^72
 ;;^UTILITY(U,$J,358.3,20048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20048,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,20048,1,4,0)
 ;;=4^C82.49
 ;;^UTILITY(U,$J,358.3,20048,2)
 ;;=^5001510
 ;;^UTILITY(U,$J,358.3,20049,0)
 ;;=C82.40^^84^929^73
 ;;^UTILITY(U,$J,358.3,20049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20049,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Unspec Site
 ;;^UTILITY(U,$J,358.3,20049,1,4,0)
 ;;=4^C82.40
 ;;^UTILITY(U,$J,358.3,20049,2)
 ;;=^5001501
 ;;^UTILITY(U,$J,358.3,20050,0)
 ;;=C82.99^^84^929^74
 ;;^UTILITY(U,$J,358.3,20050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20050,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,20050,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,20050,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,20051,0)
 ;;=C82.90^^84^929^75
 ;;^UTILITY(U,$J,358.3,20051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20051,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,20051,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,20051,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,20052,0)
 ;;=R59.1^^84^929^60
 ;;^UTILITY(U,$J,358.3,20052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20052,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Generalized
 ;;^UTILITY(U,$J,358.3,20052,1,4,0)
 ;;=4^R59.1
 ;;^UTILITY(U,$J,358.3,20052,2)
 ;;=^5019530
 ;;^UTILITY(U,$J,358.3,20053,0)
 ;;=C91.40^^84^929^79
 ;;^UTILITY(U,$J,358.3,20053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20053,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,20053,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,20053,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,20054,0)
 ;;=C91.42^^84^929^77
 ;;^UTILITY(U,$J,358.3,20054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20054,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,20054,1,4,0)
 ;;=4^C91.42
 ;;^UTILITY(U,$J,358.3,20054,2)
 ;;=^5001773
 ;;^UTILITY(U,$J,358.3,20055,0)
 ;;=C91.41^^84^929^78
 ;;^UTILITY(U,$J,358.3,20055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20055,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,20055,1,4,0)
 ;;=4^C91.41
 ;;^UTILITY(U,$J,358.3,20055,2)
 ;;=^5001772
 ;;^UTILITY(U,$J,358.3,20056,0)
 ;;=D57.01^^84^929^80
 ;;^UTILITY(U,$J,358.3,20056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20056,1,3,0)
 ;;=3^Hb-SS Disease w/ Acute Chest Syndrome
 ;;^UTILITY(U,$J,358.3,20056,1,4,0)
 ;;=4^D57.01
 ;;^UTILITY(U,$J,358.3,20056,2)
 ;;=^5002307
 ;;^UTILITY(U,$J,358.3,20057,0)
 ;;=D57.00^^84^929^81
 ;;^UTILITY(U,$J,358.3,20057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20057,1,3,0)
 ;;=3^Hb-SS Disease w/ Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,20057,1,4,0)
 ;;=4^D57.00
 ;;^UTILITY(U,$J,358.3,20057,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,20058,0)
 ;;=D57.02^^84^929^82
 ;;^UTILITY(U,$J,358.3,20058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20058,1,3,0)
 ;;=3^Hb-SS Disease w/ Splenic Sequestration
 ;;^UTILITY(U,$J,358.3,20058,1,4,0)
 ;;=4^D57.02
 ;;^UTILITY(U,$J,358.3,20058,2)
 ;;=^5002308
 ;;^UTILITY(U,$J,358.3,20059,0)
 ;;=D68.32^^84^929^84
 ;;^UTILITY(U,$J,358.3,20059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20059,1,3,0)
 ;;=3^Hemorrhagic Disorder d/t Extrinsic Circulating Anticoagulants
 ;;^UTILITY(U,$J,358.3,20059,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,20059,2)
 ;;=^5002357
