IBDEI04E ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1529,1,3,0)
 ;;=3^Temporomandibular joint disorder, unspecified
 ;;^UTILITY(U,$J,358.3,1529,1,4,0)
 ;;=4^M26.60
 ;;^UTILITY(U,$J,358.3,1529,2)
 ;;=^5011714
 ;;^UTILITY(U,$J,358.3,1530,0)
 ;;=L84.^^3^45^21
 ;;^UTILITY(U,$J,358.3,1530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1530,1,3,0)
 ;;=3^Corns and callosities
 ;;^UTILITY(U,$J,358.3,1530,1,4,0)
 ;;=4^L84.
 ;;^UTILITY(U,$J,358.3,1530,2)
 ;;=^271920
 ;;^UTILITY(U,$J,358.3,1531,0)
 ;;=M32.10^^3^45^109
 ;;^UTILITY(U,$J,358.3,1531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1531,1,3,0)
 ;;=3^Systemic lupus erythematosus, organ or system involv unsp
 ;;^UTILITY(U,$J,358.3,1531,1,4,0)
 ;;=4^M32.10
 ;;^UTILITY(U,$J,358.3,1531,2)
 ;;=^5011753
 ;;^UTILITY(U,$J,358.3,1532,0)
 ;;=M06.9^^3^45^87
 ;;^UTILITY(U,$J,358.3,1532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1532,1,3,0)
 ;;=3^Rheumatoid arthritis, unspecified
 ;;^UTILITY(U,$J,358.3,1532,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,1532,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,1533,0)
 ;;=M06.4^^3^45^40
 ;;^UTILITY(U,$J,358.3,1533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1533,1,3,0)
 ;;=3^Inflammatory polyarthropathy
 ;;^UTILITY(U,$J,358.3,1533,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,1533,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,1534,0)
 ;;=M15.0^^3^45^74
 ;;^UTILITY(U,$J,358.3,1534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1534,1,3,0)
 ;;=3^Primary generalized (osteo)arthritis
 ;;^UTILITY(U,$J,358.3,1534,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,1534,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,1535,0)
 ;;=M17.9^^3^45^55
 ;;^UTILITY(U,$J,358.3,1535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1535,1,3,0)
 ;;=3^Osteoarthritis of knee, unspecified
 ;;^UTILITY(U,$J,358.3,1535,1,4,0)
 ;;=4^M17.9
 ;;^UTILITY(U,$J,358.3,1535,2)
 ;;=^5010794
 ;;^UTILITY(U,$J,358.3,1536,0)
 ;;=M15.3^^3^45^92
 ;;^UTILITY(U,$J,358.3,1536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1536,1,3,0)
 ;;=3^Secondary multiple arthritis
 ;;^UTILITY(U,$J,358.3,1536,1,4,0)
 ;;=4^M15.3
 ;;^UTILITY(U,$J,358.3,1536,2)
 ;;=^5010765
 ;;^UTILITY(U,$J,358.3,1537,0)
 ;;=M19.011^^3^45^80
 ;;^UTILITY(U,$J,358.3,1537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1537,1,3,0)
 ;;=3^Primary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,1537,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,1537,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,1538,0)
 ;;=M19.012^^3^45^77
 ;;^UTILITY(U,$J,358.3,1538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1538,1,3,0)
 ;;=3^Primary osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,1538,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,1538,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,1539,0)
 ;;=M19.041^^3^45^79
 ;;^UTILITY(U,$J,358.3,1539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1539,1,3,0)
 ;;=3^Primary osteoarthritis, right hand
 ;;^UTILITY(U,$J,358.3,1539,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,1539,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,1540,0)
 ;;=M19.042^^3^45^76
 ;;^UTILITY(U,$J,358.3,1540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1540,1,3,0)
 ;;=3^Primary osteoarthritis, left hand
 ;;^UTILITY(U,$J,358.3,1540,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,1540,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,1541,0)
 ;;=M16.9^^3^45^54
 ;;^UTILITY(U,$J,358.3,1541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1541,1,3,0)
 ;;=3^Osteoarthritis of hip, unspecified
 ;;^UTILITY(U,$J,358.3,1541,1,4,0)
 ;;=4^M16.9
 ;;^UTILITY(U,$J,358.3,1541,2)
 ;;=^5010783
 ;;^UTILITY(U,$J,358.3,1542,0)
 ;;=M19.071^^3^45^78
 ;;^UTILITY(U,$J,358.3,1542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1542,1,3,0)
 ;;=3^Primary osteoarthritis, right ankle and foot
