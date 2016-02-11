IBDEI0IR ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8428,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,8428,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,8429,0)
 ;;=D68.32^^55^538^36
 ;;^UTILITY(U,$J,358.3,8429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8429,1,3,0)
 ;;=3^Hemorrhagic disord d/t extrinsic circulating anticoagulants
 ;;^UTILITY(U,$J,358.3,8429,1,4,0)
 ;;=4^D68.32
 ;;^UTILITY(U,$J,358.3,8429,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,8430,0)
 ;;=D68.9^^55^538^28
 ;;^UTILITY(U,$J,358.3,8430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8430,1,3,0)
 ;;=3^Coagulation defect, unspecified
 ;;^UTILITY(U,$J,358.3,8430,1,4,0)
 ;;=4^D68.9
 ;;^UTILITY(U,$J,358.3,8430,2)
 ;;=^5002364
 ;;^UTILITY(U,$J,358.3,8431,0)
 ;;=D47.3^^55^538^31
 ;;^UTILITY(U,$J,358.3,8431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8431,1,3,0)
 ;;=3^Essential (hemorrhagic) thrombocythemia
 ;;^UTILITY(U,$J,358.3,8431,1,4,0)
 ;;=4^D47.3
 ;;^UTILITY(U,$J,358.3,8431,2)
 ;;=^5002258
 ;;^UTILITY(U,$J,358.3,8432,0)
 ;;=D69.6^^55^538^129
 ;;^UTILITY(U,$J,358.3,8432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8432,1,3,0)
 ;;=3^Thrombocytopenia, unspecified
 ;;^UTILITY(U,$J,358.3,8432,1,4,0)
 ;;=4^D69.6
 ;;^UTILITY(U,$J,358.3,8432,2)
 ;;=^5002370
 ;;^UTILITY(U,$J,358.3,8433,0)
 ;;=D75.1^^55^538^127
 ;;^UTILITY(U,$J,358.3,8433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8433,1,3,0)
 ;;=3^Secondary polycythemia
 ;;^UTILITY(U,$J,358.3,8433,1,4,0)
 ;;=4^D75.1
 ;;^UTILITY(U,$J,358.3,8433,2)
 ;;=^186856
 ;;^UTILITY(U,$J,358.3,8434,0)
 ;;=M31.1^^55^538^130
 ;;^UTILITY(U,$J,358.3,8434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8434,1,3,0)
 ;;=3^Thrombotic microangiopathy
 ;;^UTILITY(U,$J,358.3,8434,1,4,0)
 ;;=4^M31.1
 ;;^UTILITY(U,$J,358.3,8434,2)
 ;;=^119061
 ;;^UTILITY(U,$J,358.3,8435,0)
 ;;=I80.9^^55^538^92
 ;;^UTILITY(U,$J,358.3,8435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8435,1,3,0)
 ;;=3^Phlebitis and thrombophlebitis of unspecified site
 ;;^UTILITY(U,$J,358.3,8435,1,4,0)
 ;;=4^I80.9
 ;;^UTILITY(U,$J,358.3,8435,2)
 ;;=^93357
 ;;^UTILITY(U,$J,358.3,8436,0)
 ;;=R59.9^^55^538^30
 ;;^UTILITY(U,$J,358.3,8436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8436,1,3,0)
 ;;=3^Enlarged lymph nodes, unspecified
 ;;^UTILITY(U,$J,358.3,8436,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,8436,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,8437,0)
 ;;=Z85.819^^55^538^112
 ;;^UTILITY(U,$J,358.3,8437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8437,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of unsp site lip,oral cav,& pharynx
 ;;^UTILITY(U,$J,358.3,8437,1,4,0)
 ;;=4^Z85.819
 ;;^UTILITY(U,$J,358.3,8437,2)
 ;;=^5063440
 ;;^UTILITY(U,$J,358.3,8438,0)
 ;;=Z85.818^^55^538^108
 ;;^UTILITY(U,$J,358.3,8438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8438,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of site of lip, oral cav, & pharynx
 ;;^UTILITY(U,$J,358.3,8438,1,4,0)
 ;;=4^Z85.818
 ;;^UTILITY(U,$J,358.3,8438,2)
 ;;=^5063439
 ;;^UTILITY(U,$J,358.3,8439,0)
 ;;=Z85.01^^55^538^100
 ;;^UTILITY(U,$J,358.3,8439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8439,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of esophagus
 ;;^UTILITY(U,$J,358.3,8439,1,4,0)
 ;;=4^Z85.01
 ;;^UTILITY(U,$J,358.3,8439,2)
 ;;=^5063395
 ;;^UTILITY(U,$J,358.3,8440,0)
 ;;=Z85.028^^55^538^110
 ;;^UTILITY(U,$J,358.3,8440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8440,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of stomach
 ;;^UTILITY(U,$J,358.3,8440,1,4,0)
 ;;=4^Z85.028
 ;;^UTILITY(U,$J,358.3,8440,2)
 ;;=^5063397
 ;;^UTILITY(U,$J,358.3,8441,0)
 ;;=Z85.038^^55^538^102
 ;;^UTILITY(U,$J,358.3,8441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8441,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of large intestine
