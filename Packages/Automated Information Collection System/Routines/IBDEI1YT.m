IBDEI1YT ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31389,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,1st tri,unsp fts
 ;;^UTILITY(U,$J,358.3,31389,1,4,0)
 ;;=4^O31.11X0
 ;;^UTILITY(U,$J,358.3,31389,2)
 ;;=^5016537
 ;;^UTILITY(U,$J,358.3,31390,0)
 ;;=O31.11X1^^126^1625^23
 ;;^UTILITY(U,$J,358.3,31390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31390,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,1st tri,fts 1
 ;;^UTILITY(U,$J,358.3,31390,1,4,0)
 ;;=4^O31.11X1
 ;;^UTILITY(U,$J,358.3,31390,2)
 ;;=^5016538
 ;;^UTILITY(U,$J,358.3,31391,0)
 ;;=O31.11X2^^126^1625^24
 ;;^UTILITY(U,$J,358.3,31391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31391,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,1st tri,fts 2
 ;;^UTILITY(U,$J,358.3,31391,1,4,0)
 ;;=4^O31.11X2
 ;;^UTILITY(U,$J,358.3,31391,2)
 ;;=^5016539
 ;;^UTILITY(U,$J,358.3,31392,0)
 ;;=O31.12X1^^126^1625^28
 ;;^UTILITY(U,$J,358.3,31392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31392,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,2nd tri,fts 1
 ;;^UTILITY(U,$J,358.3,31392,1,4,0)
 ;;=4^O31.12X1
 ;;^UTILITY(U,$J,358.3,31392,2)
 ;;=^5016545
 ;;^UTILITY(U,$J,358.3,31393,0)
 ;;=O31.12X2^^126^1625^29
 ;;^UTILITY(U,$J,358.3,31393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31393,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,2nd tri,fts 2
 ;;^UTILITY(U,$J,358.3,31393,1,4,0)
 ;;=4^O31.12X2
 ;;^UTILITY(U,$J,358.3,31393,2)
 ;;=^5016546
 ;;^UTILITY(U,$J,358.3,31394,0)
 ;;=O31.13X1^^126^1625^33
 ;;^UTILITY(U,$J,358.3,31394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31394,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,3rd tri,fts 1
 ;;^UTILITY(U,$J,358.3,31394,1,4,0)
 ;;=4^O31.13X1
 ;;^UTILITY(U,$J,358.3,31394,2)
 ;;=^5016552
 ;;^UTILITY(U,$J,358.3,31395,0)
 ;;=O31.13X2^^126^1625^34
 ;;^UTILITY(U,$J,358.3,31395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31395,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,3rd tri,fts 2
 ;;^UTILITY(U,$J,358.3,31395,1,4,0)
 ;;=4^O31.13X2
 ;;^UTILITY(U,$J,358.3,31395,2)
 ;;=^5016553
 ;;^UTILITY(U,$J,358.3,31396,0)
 ;;=O31.11X3^^126^1625^25
 ;;^UTILITY(U,$J,358.3,31396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31396,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,1st tri,fts 3
 ;;^UTILITY(U,$J,358.3,31396,1,4,0)
 ;;=4^O31.11X3
 ;;^UTILITY(U,$J,358.3,31396,2)
 ;;=^5016540
 ;;^UTILITY(U,$J,358.3,31397,0)
 ;;=O31.12X3^^126^1625^30
 ;;^UTILITY(U,$J,358.3,31397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31397,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,2nd tri,fts 3
 ;;^UTILITY(U,$J,358.3,31397,1,4,0)
 ;;=4^O31.12X3
 ;;^UTILITY(U,$J,358.3,31397,2)
 ;;=^5016547
 ;;^UTILITY(U,$J,358.3,31398,0)
 ;;=O31.13X3^^126^1625^35
 ;;^UTILITY(U,$J,358.3,31398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31398,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,3rd tri,fts 3
 ;;^UTILITY(U,$J,358.3,31398,1,4,0)
 ;;=4^O31.13X3
 ;;^UTILITY(U,$J,358.3,31398,2)
 ;;=^5016554
 ;;^UTILITY(U,$J,358.3,31399,0)
 ;;=O31.11X4^^126^1625^26
 ;;^UTILITY(U,$J,358.3,31399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31399,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,1st tri,fts 4
 ;;^UTILITY(U,$J,358.3,31399,1,4,0)
 ;;=4^O31.11X4
 ;;^UTILITY(U,$J,358.3,31399,2)
 ;;=^5016541
 ;;^UTILITY(U,$J,358.3,31400,0)
 ;;=O31.12X4^^126^1625^31
 ;;^UTILITY(U,$J,358.3,31400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31400,1,3,0)
 ;;=3^Cont post spont abort,1 fts or more,2nd tri,fts 4
 ;;^UTILITY(U,$J,358.3,31400,1,4,0)
 ;;=4^O31.12X4
