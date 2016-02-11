IBDEI24C ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35576,1,3,0)
 ;;=3^Late vomiting of pregnancy
 ;;^UTILITY(U,$J,358.3,35576,1,4,0)
 ;;=4^O21.2
 ;;^UTILITY(U,$J,358.3,35576,2)
 ;;=^270873
 ;;^UTILITY(U,$J,358.3,35577,0)
 ;;=O48.0^^166^1823^1
 ;;^UTILITY(U,$J,358.3,35577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35577,1,3,0)
 ;;=3^Post-term pregnancy
 ;;^UTILITY(U,$J,358.3,35577,1,4,0)
 ;;=4^O48.0
 ;;^UTILITY(U,$J,358.3,35577,2)
 ;;=^5017495
 ;;^UTILITY(U,$J,358.3,35578,0)
 ;;=O48.1^^166^1823^2
 ;;^UTILITY(U,$J,358.3,35578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35578,1,3,0)
 ;;=3^Prolonged pregnancy
 ;;^UTILITY(U,$J,358.3,35578,1,4,0)
 ;;=4^O48.1
 ;;^UTILITY(U,$J,358.3,35578,2)
 ;;=^5017496
 ;;^UTILITY(U,$J,358.3,35579,0)
 ;;=O31.03X0^^166^1824^56
 ;;^UTILITY(U,$J,358.3,35579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35579,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, not applicable or unsp
 ;;^UTILITY(U,$J,358.3,35579,1,4,0)
 ;;=4^O31.03X0
 ;;^UTILITY(U,$J,358.3,35579,2)
 ;;=^5016523
 ;;^UTILITY(U,$J,358.3,35580,0)
 ;;=O31.03X1^^166^1824^51
 ;;^UTILITY(U,$J,358.3,35580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35580,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, fetus 1
 ;;^UTILITY(U,$J,358.3,35580,1,4,0)
 ;;=4^O31.03X1
 ;;^UTILITY(U,$J,358.3,35580,2)
 ;;=^5016524
 ;;^UTILITY(U,$J,358.3,35581,0)
 ;;=O31.03X2^^166^1824^52
 ;;^UTILITY(U,$J,358.3,35581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35581,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, fetus 2
 ;;^UTILITY(U,$J,358.3,35581,1,4,0)
 ;;=4^O31.03X2
 ;;^UTILITY(U,$J,358.3,35581,2)
 ;;=^5016525
 ;;^UTILITY(U,$J,358.3,35582,0)
 ;;=O31.03X3^^166^1824^53
 ;;^UTILITY(U,$J,358.3,35582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35582,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, fetus 3
 ;;^UTILITY(U,$J,358.3,35582,1,4,0)
 ;;=4^O31.03X3
 ;;^UTILITY(U,$J,358.3,35582,2)
 ;;=^5016526
 ;;^UTILITY(U,$J,358.3,35583,0)
 ;;=O31.03X4^^166^1824^54
 ;;^UTILITY(U,$J,358.3,35583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35583,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, fetus 4
 ;;^UTILITY(U,$J,358.3,35583,1,4,0)
 ;;=4^O31.03X4
 ;;^UTILITY(U,$J,358.3,35583,2)
 ;;=^5016527
 ;;^UTILITY(U,$J,358.3,35584,0)
 ;;=O31.03X5^^166^1824^55
 ;;^UTILITY(U,$J,358.3,35584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35584,1,3,0)
 ;;=3^Papyraceous fetus, third trimester, fetus 5
 ;;^UTILITY(U,$J,358.3,35584,1,4,0)
 ;;=4^O31.03X5
 ;;^UTILITY(U,$J,358.3,35584,2)
 ;;=^5016528
 ;;^UTILITY(U,$J,358.3,35585,0)
 ;;=O31.02X0^^166^1824^50
 ;;^UTILITY(U,$J,358.3,35585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35585,1,3,0)
 ;;=3^Papyraceous fetus, second trimester, not applicable or unsp
 ;;^UTILITY(U,$J,358.3,35585,1,4,0)
 ;;=4^O31.02X0
 ;;^UTILITY(U,$J,358.3,35585,2)
 ;;=^5016516
 ;;^UTILITY(U,$J,358.3,35586,0)
 ;;=O31.02X1^^166^1824^45
 ;;^UTILITY(U,$J,358.3,35586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35586,1,3,0)
 ;;=3^Papyraceous fetus, second trimester, fetus 1
 ;;^UTILITY(U,$J,358.3,35586,1,4,0)
 ;;=4^O31.02X1
 ;;^UTILITY(U,$J,358.3,35586,2)
 ;;=^5016517
 ;;^UTILITY(U,$J,358.3,35587,0)
 ;;=O31.02X2^^166^1824^46
 ;;^UTILITY(U,$J,358.3,35587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35587,1,3,0)
 ;;=3^Papyraceous fetus, second trimester, fetus 2
 ;;^UTILITY(U,$J,358.3,35587,1,4,0)
 ;;=4^O31.02X2
 ;;^UTILITY(U,$J,358.3,35587,2)
 ;;=^5016518
 ;;^UTILITY(U,$J,358.3,35588,0)
 ;;=O31.02X3^^166^1824^47
 ;;^UTILITY(U,$J,358.3,35588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35588,1,3,0)
 ;;=3^Papyraceous fetus, second trimester, fetus 3
 ;;^UTILITY(U,$J,358.3,35588,1,4,0)
 ;;=4^O31.02X3
