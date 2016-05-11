IBDEI04D ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1618,1,3,0)
 ;;=3^Postprocedural Heart Failure Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1618,1,4,0)
 ;;=4^I97.131
 ;;^UTILITY(U,$J,358.3,1618,2)
 ;;=^5008088
 ;;^UTILITY(U,$J,358.3,1619,0)
 ;;=I97.190^^11^145^40
 ;;^UTILITY(U,$J,358.3,1619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1619,1,3,0)
 ;;=3^Postprocedural Cardiac Function Disturbance Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1619,1,4,0)
 ;;=4^I97.190
 ;;^UTILITY(U,$J,358.3,1619,2)
 ;;=^5008089
 ;;^UTILITY(U,$J,358.3,1620,0)
 ;;=I97.191^^11^145^41
 ;;^UTILITY(U,$J,358.3,1620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1620,1,3,0)
 ;;=3^Postprocedural Cardiac Function Disturbance Following Oth Surgery
 ;;^UTILITY(U,$J,358.3,1620,1,4,0)
 ;;=4^I97.191
 ;;^UTILITY(U,$J,358.3,1620,2)
 ;;=^5008090
 ;;^UTILITY(U,$J,358.3,1621,0)
 ;;=I97.0^^11^145^37
 ;;^UTILITY(U,$J,358.3,1621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1621,1,3,0)
 ;;=3^Postcardiotomy Syndrome
 ;;^UTILITY(U,$J,358.3,1621,1,4,0)
 ;;=4^I97.0
 ;;^UTILITY(U,$J,358.3,1621,2)
 ;;=^5008082
 ;;^UTILITY(U,$J,358.3,1622,0)
 ;;=I97.110^^11^145^43
 ;;^UTILITY(U,$J,358.3,1622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1622,1,3,0)
 ;;=3^Postprocedural Cardiac Insufficiency Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,1622,1,4,0)
 ;;=4^I97.110
 ;;^UTILITY(U,$J,358.3,1622,2)
 ;;=^5008083
 ;;^UTILITY(U,$J,358.3,1623,0)
 ;;=T86.20^^11^145^11
 ;;^UTILITY(U,$J,358.3,1623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1623,1,3,0)
 ;;=3^Complication of Heart Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,1623,1,4,0)
 ;;=4^T86.20
 ;;^UTILITY(U,$J,358.3,1623,2)
 ;;=^5055713
 ;;^UTILITY(U,$J,358.3,1624,0)
 ;;=T86.21^^11^145^25
 ;;^UTILITY(U,$J,358.3,1624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1624,1,3,0)
 ;;=3^Heart Transplant Rejection
 ;;^UTILITY(U,$J,358.3,1624,1,4,0)
 ;;=4^T86.21
 ;;^UTILITY(U,$J,358.3,1624,2)
 ;;=^5055714
 ;;^UTILITY(U,$J,358.3,1625,0)
 ;;=T86.22^^11^145^23
 ;;^UTILITY(U,$J,358.3,1625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1625,1,3,0)
 ;;=3^Heart Transplant Failure
 ;;^UTILITY(U,$J,358.3,1625,1,4,0)
 ;;=4^T86.22
 ;;^UTILITY(U,$J,358.3,1625,2)
 ;;=^5055715
 ;;^UTILITY(U,$J,358.3,1626,0)
 ;;=T86.23^^11^145^24
 ;;^UTILITY(U,$J,358.3,1626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1626,1,3,0)
 ;;=3^Heart Transplant Infection
 ;;^UTILITY(U,$J,358.3,1626,1,4,0)
 ;;=4^T86.23
 ;;^UTILITY(U,$J,358.3,1626,2)
 ;;=^5055716
 ;;^UTILITY(U,$J,358.3,1627,0)
 ;;=T86.290^^11^145^5
 ;;^UTILITY(U,$J,358.3,1627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1627,1,3,0)
 ;;=3^Cardiac Allograft Vasculopathy
 ;;^UTILITY(U,$J,358.3,1627,1,4,0)
 ;;=4^T86.290
 ;;^UTILITY(U,$J,358.3,1627,2)
 ;;=^5055717
 ;;^UTILITY(U,$J,358.3,1628,0)
 ;;=T86.298^^11^145^16
 ;;^UTILITY(U,$J,358.3,1628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1628,1,3,0)
 ;;=3^Complications of Heart Transplant NEC
 ;;^UTILITY(U,$J,358.3,1628,1,4,0)
 ;;=4^T86.298
 ;;^UTILITY(U,$J,358.3,1628,2)
 ;;=^5055718
 ;;^UTILITY(U,$J,358.3,1629,0)
 ;;=T86.30^^11^145^12
 ;;^UTILITY(U,$J,358.3,1629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1629,1,3,0)
 ;;=3^Complication of Heart-Lung Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,1629,1,4,0)
 ;;=4^T86.30
 ;;^UTILITY(U,$J,358.3,1629,2)
 ;;=^5055719
 ;;^UTILITY(U,$J,358.3,1630,0)
 ;;=T86.39^^11^145^17
 ;;^UTILITY(U,$J,358.3,1630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1630,1,3,0)
 ;;=3^Complications of Heart-Lung Transplant NEC
 ;;^UTILITY(U,$J,358.3,1630,1,4,0)
 ;;=4^T86.39
 ;;^UTILITY(U,$J,358.3,1630,2)
 ;;=^5055723
