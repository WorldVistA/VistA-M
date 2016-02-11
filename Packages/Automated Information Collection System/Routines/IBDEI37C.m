IBDEI37C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53792,1,3,0)
 ;;=3^Malignant neoplasm of upper lobe, left bronchus or lung
 ;;^UTILITY(U,$J,358.3,53792,1,4,0)
 ;;=4^C34.12
 ;;^UTILITY(U,$J,358.3,53792,2)
 ;;=^5000962
 ;;^UTILITY(U,$J,358.3,53793,0)
 ;;=C34.2^^253^2723^4
 ;;^UTILITY(U,$J,358.3,53793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53793,1,3,0)
 ;;=3^Malignant neoplasm of middle lobe, bronchus or lung
 ;;^UTILITY(U,$J,358.3,53793,1,4,0)
 ;;=4^C34.2
 ;;^UTILITY(U,$J,358.3,53793,2)
 ;;=^267137
 ;;^UTILITY(U,$J,358.3,53794,0)
 ;;=C34.31^^253^2723^3
 ;;^UTILITY(U,$J,358.3,53794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53794,1,3,0)
 ;;=3^Malignant neoplasm of lower lobe, right bronchus or lung
 ;;^UTILITY(U,$J,358.3,53794,1,4,0)
 ;;=4^C34.31
 ;;^UTILITY(U,$J,358.3,53794,2)
 ;;=^5133321
 ;;^UTILITY(U,$J,358.3,53795,0)
 ;;=C34.32^^253^2723^2
 ;;^UTILITY(U,$J,358.3,53795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53795,1,3,0)
 ;;=3^Malignant neoplasm of lower lobe, left bronchus or lung
 ;;^UTILITY(U,$J,358.3,53795,1,4,0)
 ;;=4^C34.32
 ;;^UTILITY(U,$J,358.3,53795,2)
 ;;=^5133322
 ;;^UTILITY(U,$J,358.3,53796,0)
 ;;=C34.81^^253^2723^6
 ;;^UTILITY(U,$J,358.3,53796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53796,1,3,0)
 ;;=3^Malignant neoplasm of ovrlp sites of right bronchus and lung
 ;;^UTILITY(U,$J,358.3,53796,1,4,0)
 ;;=4^C34.81
 ;;^UTILITY(U,$J,358.3,53796,2)
 ;;=^5000964
 ;;^UTILITY(U,$J,358.3,53797,0)
 ;;=C34.82^^253^2723^5
 ;;^UTILITY(U,$J,358.3,53797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53797,1,3,0)
 ;;=3^Malignant neoplasm of ovrlp sites of left bronchus and lung
 ;;^UTILITY(U,$J,358.3,53797,1,4,0)
 ;;=4^C34.82
 ;;^UTILITY(U,$J,358.3,53797,2)
 ;;=^5000965
 ;;^UTILITY(U,$J,358.3,53798,0)
 ;;=C83.38^^253^2724^22
 ;;^UTILITY(U,$J,358.3,53798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53798,1,3,0)
 ;;=3^Diffuse large B-cell lymphoma, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,53798,1,4,0)
 ;;=4^C83.38
 ;;^UTILITY(U,$J,358.3,53798,2)
 ;;=^5001579
 ;;^UTILITY(U,$J,358.3,53799,0)
 ;;=C83.58^^253^2724^29
 ;;^UTILITY(U,$J,358.3,53799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53799,1,3,0)
 ;;=3^Lymphoblastic (diffuse) lymphoma, lymph nodes mult site
 ;;^UTILITY(U,$J,358.3,53799,1,4,0)
 ;;=4^C83.58
 ;;^UTILITY(U,$J,358.3,53799,2)
 ;;=^5001589
 ;;^UTILITY(U,$J,358.3,53800,0)
 ;;=C83.78^^253^2724^15
 ;;^UTILITY(U,$J,358.3,53800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53800,1,3,0)
 ;;=3^Burkitt lymphoma, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,53800,1,4,0)
 ;;=4^C83.78
 ;;^UTILITY(U,$J,358.3,53800,2)
 ;;=^5001599
 ;;^UTILITY(U,$J,358.3,53801,0)
 ;;=C83.18^^253^2724^35
 ;;^UTILITY(U,$J,358.3,53801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53801,1,3,0)
 ;;=3^Mantle cell lymphoma, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,53801,1,4,0)
 ;;=4^C83.18
 ;;^UTILITY(U,$J,358.3,53801,2)
 ;;=^5001569
 ;;^UTILITY(U,$J,358.3,53802,0)
 ;;=C83.38^^253^2724^23
 ;;^UTILITY(U,$J,358.3,53802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53802,1,3,0)
 ;;=3^Diffuse large B-cell lymphoma, lymph nodes of multiple sites
 ;;^UTILITY(U,$J,358.3,53802,1,4,0)
 ;;=4^C83.38
 ;;^UTILITY(U,$J,358.3,53802,2)
 ;;=^5001579
 ;;^UTILITY(U,$J,358.3,53803,0)
 ;;=C84.68^^253^2724^12
 ;;^UTILITY(U,$J,358.3,53803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53803,1,3,0)
 ;;=3^Anaplastic large cell lymphoma, ALK-pos, nodes mult site
 ;;^UTILITY(U,$J,358.3,53803,1,4,0)
 ;;=4^C84.68
 ;;^UTILITY(U,$J,358.3,53803,2)
 ;;=^5001659
 ;;^UTILITY(U,$J,358.3,53804,0)
 ;;=C84.78^^253^2724^11
