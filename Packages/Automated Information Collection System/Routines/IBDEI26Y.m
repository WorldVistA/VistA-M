IBDEI26Y ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36790,0)
 ;;=C91.00^^169^1859^1
 ;;^UTILITY(U,$J,358.3,36790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36790,1,3,0)
 ;;=3^Acute lymphoblastic leukemia not having achieved remission
 ;;^UTILITY(U,$J,358.3,36790,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,36790,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,36791,0)
 ;;=C91.01^^169^1859^3
 ;;^UTILITY(U,$J,358.3,36791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36791,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in remission
 ;;^UTILITY(U,$J,358.3,36791,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,36791,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,36792,0)
 ;;=C91.02^^169^1859^2
 ;;^UTILITY(U,$J,358.3,36792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36792,1,3,0)
 ;;=3^Acute lymphoblastic leukemia, in relapse
 ;;^UTILITY(U,$J,358.3,36792,1,4,0)
 ;;=4^C91.02
 ;;^UTILITY(U,$J,358.3,36792,2)
 ;;=^5001764
 ;;^UTILITY(U,$J,358.3,36793,0)
 ;;=C91.10^^169^1859^13
 ;;^UTILITY(U,$J,358.3,36793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36793,1,3,0)
 ;;=3^Chronic lymphocytic leuk of B-cell type not achieve remis
 ;;^UTILITY(U,$J,358.3,36793,1,4,0)
 ;;=4^C91.10
 ;;^UTILITY(U,$J,358.3,36793,2)
 ;;=^5001765
 ;;^UTILITY(U,$J,358.3,36794,0)
 ;;=C91.11^^169^1859^14
 ;;^UTILITY(U,$J,358.3,36794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36794,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in remission
 ;;^UTILITY(U,$J,358.3,36794,1,4,0)
 ;;=4^C91.11
 ;;^UTILITY(U,$J,358.3,36794,2)
 ;;=^5001766
 ;;^UTILITY(U,$J,358.3,36795,0)
 ;;=C91.12^^169^1859^15
 ;;^UTILITY(U,$J,358.3,36795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36795,1,3,0)
 ;;=3^Chronic lymphocytic leukemia of B-cell type in relapse
 ;;^UTILITY(U,$J,358.3,36795,1,4,0)
 ;;=4^C91.12
 ;;^UTILITY(U,$J,358.3,36795,2)
 ;;=^5001767
 ;;^UTILITY(U,$J,358.3,36796,0)
 ;;=D47.1^^169^1859^16
 ;;^UTILITY(U,$J,358.3,36796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36796,1,3,0)
 ;;=3^Chronic myeloproliferative disease
 ;;^UTILITY(U,$J,358.3,36796,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,36796,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,36797,0)
 ;;=C94.42^^169^1859^5
 ;;^UTILITY(U,$J,358.3,36797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36797,1,3,0)
 ;;=3^Acute panmyelosis with myelofibrosis, in relapse
 ;;^UTILITY(U,$J,358.3,36797,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,36797,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,36798,0)
 ;;=C94.41^^169^1859^6
 ;;^UTILITY(U,$J,358.3,36798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36798,1,3,0)
 ;;=3^Acute panmyelosis with myelofibrosis, in remission
 ;;^UTILITY(U,$J,358.3,36798,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,36798,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,36799,0)
 ;;=C94.40^^169^1859^4
 ;;^UTILITY(U,$J,358.3,36799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36799,1,3,0)
 ;;=3^Acute panmyelosis w myelofibrosis not achieve remission
 ;;^UTILITY(U,$J,358.3,36799,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,36799,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,36800,0)
 ;;=D47.2^^169^1859^55
 ;;^UTILITY(U,$J,358.3,36800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36800,1,3,0)
 ;;=3^Monoclonal gammopathy
 ;;^UTILITY(U,$J,358.3,36800,1,4,0)
 ;;=4^D47.2
 ;;^UTILITY(U,$J,358.3,36800,2)
 ;;=^5002257
 ;;^UTILITY(U,$J,358.3,36801,0)
 ;;=C88.0^^169^1859^76
 ;;^UTILITY(U,$J,358.3,36801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36801,1,3,0)
 ;;=3^Waldenstrom macroglobulinemia
 ;;^UTILITY(U,$J,358.3,36801,1,4,0)
 ;;=4^C88.0
 ;;^UTILITY(U,$J,358.3,36801,2)
 ;;=^5001748
 ;;^UTILITY(U,$J,358.3,36802,0)
 ;;=C81.70^^169^1859^41
 ;;^UTILITY(U,$J,358.3,36802,1,0)
 ;;=^358.31IA^4^2
