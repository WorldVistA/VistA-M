IBDEI24A ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35551,1,4,0)
 ;;=4^O11.2
 ;;^UTILITY(U,$J,358.3,35551,2)
 ;;=^5016143
 ;;^UTILITY(U,$J,358.3,35552,0)
 ;;=O11.3^^166^1821^32
 ;;^UTILITY(U,$J,358.3,35552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35552,1,3,0)
 ;;=3^Pre-existing hypertension w pre-eclampsia, third trimester
 ;;^UTILITY(U,$J,358.3,35552,1,4,0)
 ;;=4^O11.3
 ;;^UTILITY(U,$J,358.3,35552,2)
 ;;=^5016144
 ;;^UTILITY(U,$J,358.3,35553,0)
 ;;=O10.13^^166^1821^33
 ;;^UTILITY(U,$J,358.3,35553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35553,1,3,0)
 ;;=3^Pre-existing hypertensive heart disease comp the puerperium
 ;;^UTILITY(U,$J,358.3,35553,1,4,0)
 ;;=4^O10.13
 ;;^UTILITY(U,$J,358.3,35553,2)
 ;;=^5016119
 ;;^UTILITY(U,$J,358.3,35554,0)
 ;;=O10.23^^166^1821^29
 ;;^UTILITY(U,$J,358.3,35554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35554,1,3,0)
 ;;=3^Pre-existing hyp chronic kidney disease comp the puerperium
 ;;^UTILITY(U,$J,358.3,35554,1,4,0)
 ;;=4^O10.23
 ;;^UTILITY(U,$J,358.3,35554,2)
 ;;=^5016125
 ;;^UTILITY(U,$J,358.3,35555,0)
 ;;=O10.33^^166^1821^23
 ;;^UTILITY(U,$J,358.3,35555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35555,1,3,0)
 ;;=3^Pre-exist hyp heart and chr kidney disease comp the puerp
 ;;^UTILITY(U,$J,358.3,35555,1,4,0)
 ;;=4^O10.33
 ;;^UTILITY(U,$J,358.3,35555,2)
 ;;=^5016131
 ;;^UTILITY(U,$J,358.3,35556,0)
 ;;=O13.1^^166^1821^4
 ;;^UTILITY(U,$J,358.3,35556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35556,1,3,0)
 ;;=3^Gestational htn w/o significant proteinuria, first trimester
 ;;^UTILITY(U,$J,358.3,35556,1,4,0)
 ;;=4^O13.1
 ;;^UTILITY(U,$J,358.3,35556,2)
 ;;=^5016158
 ;;^UTILITY(U,$J,358.3,35557,0)
 ;;=O13.2^^166^1821^5
 ;;^UTILITY(U,$J,358.3,35557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35557,1,3,0)
 ;;=3^Gestational htn w/o significant proteinuria, second trimester
 ;;^UTILITY(U,$J,358.3,35557,1,4,0)
 ;;=4^O13.2
 ;;^UTILITY(U,$J,358.3,35557,2)
 ;;=^5016159
 ;;^UTILITY(U,$J,358.3,35558,0)
 ;;=O13.3^^166^1821^6
 ;;^UTILITY(U,$J,358.3,35558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35558,1,3,0)
 ;;=3^Gestational htn w/o significant proteinuria, third trimester
 ;;^UTILITY(U,$J,358.3,35558,1,4,0)
 ;;=4^O13.3
 ;;^UTILITY(U,$J,358.3,35558,2)
 ;;=^5016160
 ;;^UTILITY(U,$J,358.3,35559,0)
 ;;=O16.1^^166^1821^9
 ;;^UTILITY(U,$J,358.3,35559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35559,1,3,0)
 ;;=3^Maternal hypertension, first trimester NEC
 ;;^UTILITY(U,$J,358.3,35559,1,4,0)
 ;;=4^O16.1
 ;;^UTILITY(U,$J,358.3,35559,2)
 ;;=^5016180
 ;;^UTILITY(U,$J,358.3,35560,0)
 ;;=O16.2^^166^1821^10
 ;;^UTILITY(U,$J,358.3,35560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35560,1,3,0)
 ;;=3^Maternal hypertension, second trimester NEC
 ;;^UTILITY(U,$J,358.3,35560,1,4,0)
 ;;=4^O16.2
 ;;^UTILITY(U,$J,358.3,35560,2)
 ;;=^5016181
 ;;^UTILITY(U,$J,358.3,35561,0)
 ;;=O16.3^^166^1821^11
 ;;^UTILITY(U,$J,358.3,35561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35561,1,3,0)
 ;;=3^Maternal hypertension, third trimester NEC
 ;;^UTILITY(U,$J,358.3,35561,1,4,0)
 ;;=4^O16.3
 ;;^UTILITY(U,$J,358.3,35561,2)
 ;;=^5016182
 ;;^UTILITY(U,$J,358.3,35562,0)
 ;;=O14.02^^166^1821^12
 ;;^UTILITY(U,$J,358.3,35562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35562,1,3,0)
 ;;=3^Mild to moderate pre-eclampsia, second trimester
 ;;^UTILITY(U,$J,358.3,35562,1,4,0)
 ;;=4^O14.02
 ;;^UTILITY(U,$J,358.3,35562,2)
 ;;=^5016163
 ;;^UTILITY(U,$J,358.3,35563,0)
 ;;=O14.03^^166^1821^13
 ;;^UTILITY(U,$J,358.3,35563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35563,1,3,0)
 ;;=3^Mild to moderate pre-eclampsia, third trimester
