IBDEI0SM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13421,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Unspec Site
 ;;^UTILITY(U,$J,358.3,13421,1,4,0)
 ;;=4^C82.30
 ;;^UTILITY(U,$J,358.3,13421,2)
 ;;=^5001491
 ;;^UTILITY(U,$J,358.3,13422,0)
 ;;=C82.49^^53^593^72
 ;;^UTILITY(U,$J,358.3,13422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13422,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,13422,1,4,0)
 ;;=4^C82.49
 ;;^UTILITY(U,$J,358.3,13422,2)
 ;;=^5001510
 ;;^UTILITY(U,$J,358.3,13423,0)
 ;;=C82.40^^53^593^73
 ;;^UTILITY(U,$J,358.3,13423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13423,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Unspec Site
 ;;^UTILITY(U,$J,358.3,13423,1,4,0)
 ;;=4^C82.40
 ;;^UTILITY(U,$J,358.3,13423,2)
 ;;=^5001501
 ;;^UTILITY(U,$J,358.3,13424,0)
 ;;=C82.99^^53^593^74
 ;;^UTILITY(U,$J,358.3,13424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13424,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,13424,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,13424,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,13425,0)
 ;;=C82.90^^53^593^75
 ;;^UTILITY(U,$J,358.3,13425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13425,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,13425,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,13425,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,13426,0)
 ;;=R59.1^^53^593^60
 ;;^UTILITY(U,$J,358.3,13426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13426,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Generalized
 ;;^UTILITY(U,$J,358.3,13426,1,4,0)
 ;;=4^R59.1
 ;;^UTILITY(U,$J,358.3,13426,2)
 ;;=^5019530
 ;;^UTILITY(U,$J,358.3,13427,0)
 ;;=C91.40^^53^593^79
 ;;^UTILITY(U,$J,358.3,13427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13427,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,13427,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,13427,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,13428,0)
 ;;=C91.42^^53^593^77
 ;;^UTILITY(U,$J,358.3,13428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13428,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,13428,1,4,0)
 ;;=4^C91.42
 ;;^UTILITY(U,$J,358.3,13428,2)
 ;;=^5001773
 ;;^UTILITY(U,$J,358.3,13429,0)
 ;;=C91.41^^53^593^78
 ;;^UTILITY(U,$J,358.3,13429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13429,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,13429,1,4,0)
 ;;=4^C91.41
 ;;^UTILITY(U,$J,358.3,13429,2)
 ;;=^5001772
 ;;^UTILITY(U,$J,358.3,13430,0)
 ;;=D57.01^^53^593^80
 ;;^UTILITY(U,$J,358.3,13430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13430,1,3,0)
 ;;=3^Hb-SS Disease w/ Acute Chest Syndrome
 ;;^UTILITY(U,$J,358.3,13430,1,4,0)
 ;;=4^D57.01
 ;;^UTILITY(U,$J,358.3,13430,2)
 ;;=^5002307
 ;;^UTILITY(U,$J,358.3,13431,0)
 ;;=D57.00^^53^593^81
 ;;^UTILITY(U,$J,358.3,13431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13431,1,3,0)
 ;;=3^Hb-SS Disease w/ Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,13431,1,4,0)
 ;;=4^D57.00
 ;;^UTILITY(U,$J,358.3,13431,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,13432,0)
 ;;=D57.02^^53^593^82
 ;;^UTILITY(U,$J,358.3,13432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13432,1,3,0)
 ;;=3^Hb-SS Disease w/ Splenic Sequestration
 ;;^UTILITY(U,$J,358.3,13432,1,4,0)
 ;;=4^D57.02
 ;;^UTILITY(U,$J,358.3,13432,2)
 ;;=^5002308
 ;;^UTILITY(U,$J,358.3,13433,0)
 ;;=D68.32^^53^593^84
 ;;^UTILITY(U,$J,358.3,13433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13433,1,3,0)
 ;;=3^Hemorrhagic Disorder d/t Extrinsic Circulating Anticoagulants
 ;;^UTILITY(U,$J,358.3,13433,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,13433,2)
 ;;=^5002357
