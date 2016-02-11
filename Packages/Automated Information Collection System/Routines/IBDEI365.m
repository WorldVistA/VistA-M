IBDEI365 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53205,1,3,0)
 ;;=3^Hepatitis C,Chr
 ;;^UTILITY(U,$J,358.3,53205,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,53205,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,53206,0)
 ;;=B35.6^^245^2673^4
 ;;^UTILITY(U,$J,358.3,53206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53206,1,3,0)
 ;;=3^Tinea Cruris
 ;;^UTILITY(U,$J,358.3,53206,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,53206,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,53207,0)
 ;;=B35.3^^245^2673^5
 ;;^UTILITY(U,$J,358.3,53207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53207,1,3,0)
 ;;=3^Tinea Pedis
 ;;^UTILITY(U,$J,358.3,53207,1,4,0)
 ;;=4^B35.3
 ;;^UTILITY(U,$J,358.3,53207,2)
 ;;=^119732
 ;;^UTILITY(U,$J,358.3,53208,0)
 ;;=B97.89^^245^2673^6
 ;;^UTILITY(U,$J,358.3,53208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53208,1,3,0)
 ;;=3^Viral Agents as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,53208,1,4,0)
 ;;=4^B97.89
 ;;^UTILITY(U,$J,358.3,53208,2)
 ;;=^5000879
 ;;^UTILITY(U,$J,358.3,53209,0)
 ;;=B02.9^^245^2673^7
 ;;^UTILITY(U,$J,358.3,53209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53209,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,53209,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,53209,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,53210,0)
 ;;=C44.91^^245^2674^1
 ;;^UTILITY(U,$J,358.3,53210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53210,1,3,0)
 ;;=3^Basal cell carcinoma of skin, unspecified
 ;;^UTILITY(U,$J,358.3,53210,1,4,0)
 ;;=4^C44.91
 ;;^UTILITY(U,$J,358.3,53210,2)
 ;;=^5001092
 ;;^UTILITY(U,$J,358.3,53211,0)
 ;;=D17.9^^245^2674^2
 ;;^UTILITY(U,$J,358.3,53211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53211,1,3,0)
 ;;=3^Benign lipomatous neoplasm, unspecified
 ;;^UTILITY(U,$J,358.3,53211,1,4,0)
 ;;=4^D17.9
 ;;^UTILITY(U,$J,358.3,53211,2)
 ;;=^5002020
 ;;^UTILITY(U,$J,358.3,53212,0)
 ;;=C67.9^^245^2674^3
 ;;^UTILITY(U,$J,358.3,53212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53212,1,3,0)
 ;;=3^Malignant neoplasm of bladder, unspecified
 ;;^UTILITY(U,$J,358.3,53212,1,4,0)
 ;;=4^C67.9
 ;;^UTILITY(U,$J,358.3,53212,2)
 ;;=^5001263
 ;;^UTILITY(U,$J,358.3,53213,0)
 ;;=C18.9^^245^2674^4
 ;;^UTILITY(U,$J,358.3,53213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53213,1,3,0)
 ;;=3^Malignant neoplasm of colon, unspecified
 ;;^UTILITY(U,$J,358.3,53213,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,53213,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,53214,0)
 ;;=C15.9^^245^2674^5
 ;;^UTILITY(U,$J,358.3,53214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53214,1,3,0)
 ;;=3^Malignant neoplasm of esophagus, unspecified
 ;;^UTILITY(U,$J,358.3,53214,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,53214,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,53215,0)
 ;;=C32.9^^245^2674^6
 ;;^UTILITY(U,$J,358.3,53215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53215,1,3,0)
 ;;=3^Malignant neoplasm of larynx, unspecified
 ;;^UTILITY(U,$J,358.3,53215,1,4,0)
 ;;=4^C32.9
 ;;^UTILITY(U,$J,358.3,53215,2)
 ;;=^5000956
 ;;^UTILITY(U,$J,358.3,53216,0)
 ;;=C34.92^^245^2674^7
 ;;^UTILITY(U,$J,358.3,53216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53216,1,3,0)
 ;;=3^Malignant neoplasm of left bronchus/lung,unspec part
 ;;^UTILITY(U,$J,358.3,53216,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,53216,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,53217,0)
 ;;=C50.912^^245^2674^8
 ;;^UTILITY(U,$J,358.3,53217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53217,1,3,0)
 ;;=3^Malignant neoplasm of left female breast,unspec site
 ;;^UTILITY(U,$J,358.3,53217,1,4,0)
 ;;=4^C50.912
 ;;^UTILITY(U,$J,358.3,53217,2)
 ;;=^5001196
 ;;^UTILITY(U,$J,358.3,53218,0)
 ;;=C64.2^^245^2674^9
