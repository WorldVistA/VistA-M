IBDEI2BY ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37227,1,3,0)
 ;;=3^Burn of lft lwr leg, sec degree, init enc
 ;;^UTILITY(U,$J,358.3,37227,1,4,0)
 ;;=4^T24.232A
 ;;^UTILITY(U,$J,358.3,37227,2)
 ;;=^5048277
 ;;^UTILITY(U,$J,358.3,37228,0)
 ;;=T25.331A^^146^1913^51
 ;;^UTILITY(U,$J,358.3,37228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37228,1,3,0)
 ;;=3^Burn of rt toe(s) (nail), third degree, init enc
 ;;^UTILITY(U,$J,358.3,37228,1,4,0)
 ;;=4^T25.331A
 ;;^UTILITY(U,$J,358.3,37228,2)
 ;;=^5048604
 ;;^UTILITY(U,$J,358.3,37229,0)
 ;;=T25.332A^^146^1913^35
 ;;^UTILITY(U,$J,358.3,37229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37229,1,3,0)
 ;;=3^Burn of lft toe(s) (nail), third degree, init enc
 ;;^UTILITY(U,$J,358.3,37229,1,4,0)
 ;;=4^T25.332A
 ;;^UTILITY(U,$J,358.3,37229,2)
 ;;=^5048607
 ;;^UTILITY(U,$J,358.3,37230,0)
 ;;=T25.321A^^146^1913^44
 ;;^UTILITY(U,$J,358.3,37230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37230,1,3,0)
 ;;=3^Burn of rt ft, third degree, init enc
 ;;^UTILITY(U,$J,358.3,37230,1,4,0)
 ;;=4^T25.321A
 ;;^UTILITY(U,$J,358.3,37230,2)
 ;;=^5048595
 ;;^UTILITY(U,$J,358.3,37231,0)
 ;;=T25.322A^^146^1913^28
 ;;^UTILITY(U,$J,358.3,37231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37231,1,3,0)
 ;;=3^Burn of lft ft, third degree, init enc
 ;;^UTILITY(U,$J,358.3,37231,1,4,0)
 ;;=4^T25.322A
 ;;^UTILITY(U,$J,358.3,37231,2)
 ;;=^5048598
 ;;^UTILITY(U,$J,358.3,37232,0)
 ;;=T25.311A^^146^1913^40
 ;;^UTILITY(U,$J,358.3,37232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37232,1,3,0)
 ;;=3^Burn of rt ankl, third degree, init enc
 ;;^UTILITY(U,$J,358.3,37232,1,4,0)
 ;;=4^T25.311A
 ;;^UTILITY(U,$J,358.3,37232,2)
 ;;=^5048586
 ;;^UTILITY(U,$J,358.3,37233,0)
 ;;=T25.312A^^146^1913^24
 ;;^UTILITY(U,$J,358.3,37233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37233,1,3,0)
 ;;=3^Burn of lft ankl, third degree, init enc
 ;;^UTILITY(U,$J,358.3,37233,1,4,0)
 ;;=4^T25.312A
 ;;^UTILITY(U,$J,358.3,37233,2)
 ;;=^5048589
 ;;^UTILITY(U,$J,358.3,37234,0)
 ;;=T24.331A^^146^1913^48
 ;;^UTILITY(U,$J,358.3,37234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37234,1,3,0)
 ;;=3^Burn of rt lwr leg, third degree, init enc
 ;;^UTILITY(U,$J,358.3,37234,1,4,0)
 ;;=4^T24.331A
 ;;^UTILITY(U,$J,358.3,37234,2)
 ;;=^5048316
 ;;^UTILITY(U,$J,358.3,37235,0)
 ;;=T24.332A^^146^1913^32
 ;;^UTILITY(U,$J,358.3,37235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37235,1,3,0)
 ;;=3^Burn of lft lwr leg, third degree, init enc
 ;;^UTILITY(U,$J,358.3,37235,1,4,0)
 ;;=4^T24.332A
 ;;^UTILITY(U,$J,358.3,37235,2)
 ;;=^5048319
 ;;^UTILITY(U,$J,358.3,37236,0)
 ;;=T31.0^^146^1913^54
 ;;^UTILITY(U,$J,358.3,37236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37236,1,3,0)
 ;;=3^Burns involving less than 10% of body surface
 ;;^UTILITY(U,$J,358.3,37236,1,4,0)
 ;;=4^T31.0
 ;;^UTILITY(U,$J,358.3,37236,2)
 ;;=^5048924
 ;;^UTILITY(U,$J,358.3,37237,0)
 ;;=T31.10^^146^1913^55
 ;;^UTILITY(U,$J,358.3,37237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37237,1,3,0)
 ;;=3^Burns of 10-19% of body surfc w 0% to 9% 3rd degree burns
 ;;^UTILITY(U,$J,358.3,37237,1,4,0)
 ;;=4^T31.10
 ;;^UTILITY(U,$J,358.3,37237,2)
 ;;=^5048925
 ;;^UTILITY(U,$J,358.3,37238,0)
 ;;=S90.424A^^146^1913^16
 ;;^UTILITY(U,$J,358.3,37238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37238,1,3,0)
 ;;=3^Blister (nontherm), rt lsr toe(s), init enc
 ;;^UTILITY(U,$J,358.3,37238,1,4,0)
 ;;=4^S90.424A
 ;;^UTILITY(U,$J,358.3,37238,2)
 ;;=^5043916
