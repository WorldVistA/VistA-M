IBDEI0NI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10743,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,10743,1,4,0)
 ;;=4^C82.39
 ;;^UTILITY(U,$J,358.3,10743,2)
 ;;=^5001500
 ;;^UTILITY(U,$J,358.3,10744,0)
 ;;=C82.30^^68^675^69
 ;;^UTILITY(U,$J,358.3,10744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10744,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIa,Unspec Site
 ;;^UTILITY(U,$J,358.3,10744,1,4,0)
 ;;=4^C82.30
 ;;^UTILITY(U,$J,358.3,10744,2)
 ;;=^5001491
 ;;^UTILITY(U,$J,358.3,10745,0)
 ;;=C82.49^^68^675^70
 ;;^UTILITY(U,$J,358.3,10745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10745,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,10745,1,4,0)
 ;;=4^C82.49
 ;;^UTILITY(U,$J,358.3,10745,2)
 ;;=^5001510
 ;;^UTILITY(U,$J,358.3,10746,0)
 ;;=C82.40^^68^675^71
 ;;^UTILITY(U,$J,358.3,10746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10746,1,3,0)
 ;;=3^Follicular Lymphoma Grade IIIb,Unspec Site
 ;;^UTILITY(U,$J,358.3,10746,1,4,0)
 ;;=4^C82.40
 ;;^UTILITY(U,$J,358.3,10746,2)
 ;;=^5001501
 ;;^UTILITY(U,$J,358.3,10747,0)
 ;;=C82.99^^68^675^72
 ;;^UTILITY(U,$J,358.3,10747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10747,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,10747,1,4,0)
 ;;=4^C82.99
 ;;^UTILITY(U,$J,358.3,10747,2)
 ;;=^5001550
 ;;^UTILITY(U,$J,358.3,10748,0)
 ;;=C82.90^^68^675^73
 ;;^UTILITY(U,$J,358.3,10748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10748,1,3,0)
 ;;=3^Follicular Lymphoma Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,10748,1,4,0)
 ;;=4^C82.90
 ;;^UTILITY(U,$J,358.3,10748,2)
 ;;=^5001541
 ;;^UTILITY(U,$J,358.3,10749,0)
 ;;=R59.1^^68^675^58
 ;;^UTILITY(U,$J,358.3,10749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10749,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Generalized
 ;;^UTILITY(U,$J,358.3,10749,1,4,0)
 ;;=4^R59.1
 ;;^UTILITY(U,$J,358.3,10749,2)
 ;;=^5019530
 ;;^UTILITY(U,$J,358.3,10750,0)
 ;;=C91.40^^68^675^77
 ;;^UTILITY(U,$J,358.3,10750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10750,1,3,0)
 ;;=3^Hairy Cell Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,10750,1,4,0)
 ;;=4^C91.40
 ;;^UTILITY(U,$J,358.3,10750,2)
 ;;=^5001771
 ;;^UTILITY(U,$J,358.3,10751,0)
 ;;=C91.42^^68^675^75
 ;;^UTILITY(U,$J,358.3,10751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10751,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Relapse
 ;;^UTILITY(U,$J,358.3,10751,1,4,0)
 ;;=4^C91.42
 ;;^UTILITY(U,$J,358.3,10751,2)
 ;;=^5001773
 ;;^UTILITY(U,$J,358.3,10752,0)
 ;;=C91.41^^68^675^76
 ;;^UTILITY(U,$J,358.3,10752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10752,1,3,0)
 ;;=3^Hairy Cell Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,10752,1,4,0)
 ;;=4^C91.41
 ;;^UTILITY(U,$J,358.3,10752,2)
 ;;=^5001772
 ;;^UTILITY(U,$J,358.3,10753,0)
 ;;=D57.01^^68^675^78
 ;;^UTILITY(U,$J,358.3,10753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10753,1,3,0)
 ;;=3^Hb-SS Disease w/ Acute Chest Syndrome
 ;;^UTILITY(U,$J,358.3,10753,1,4,0)
 ;;=4^D57.01
 ;;^UTILITY(U,$J,358.3,10753,2)
 ;;=^5002307
 ;;^UTILITY(U,$J,358.3,10754,0)
 ;;=D57.00^^68^675^79
 ;;^UTILITY(U,$J,358.3,10754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10754,1,3,0)
 ;;=3^Hb-SS Disease w/ Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,10754,1,4,0)
 ;;=4^D57.00
 ;;^UTILITY(U,$J,358.3,10754,2)
 ;;=^5002306
 ;;^UTILITY(U,$J,358.3,10755,0)
 ;;=D57.02^^68^675^80
 ;;^UTILITY(U,$J,358.3,10755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10755,1,3,0)
 ;;=3^Hb-SS Disease w/ Splenic Sequestration
 ;;^UTILITY(U,$J,358.3,10755,1,4,0)
 ;;=4^D57.02
 ;;^UTILITY(U,$J,358.3,10755,2)
 ;;=^5002308
