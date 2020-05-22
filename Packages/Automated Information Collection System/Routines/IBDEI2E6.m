IBDEI2E6 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38162,1,3,0)
 ;;=3^Varicose veins rt lwr extrem w/ pain
 ;;^UTILITY(U,$J,358.3,38162,1,4,0)
 ;;=4^I83.811
 ;;^UTILITY(U,$J,358.3,38162,2)
 ;;=^5008011
 ;;^UTILITY(U,$J,358.3,38163,0)
 ;;=I83.891^^146^1930^12
 ;;^UTILITY(U,$J,358.3,38163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38163,1,3,0)
 ;;=3^Varicose veins rt lwr extrem w/ oth complications
 ;;^UTILITY(U,$J,358.3,38163,1,4,0)
 ;;=4^I83.891
 ;;^UTILITY(U,$J,358.3,38163,2)
 ;;=^5008015
 ;;^UTILITY(U,$J,358.3,38164,0)
 ;;=Q66.31^^146^1930^22
 ;;^UTILITY(U,$J,358.3,38164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38164,1,3,0)
 ;;=3^Varus Deformity,Congenital,Right Foot
 ;;^UTILITY(U,$J,358.3,38164,1,4,0)
 ;;=4^Q66.31
 ;;^UTILITY(U,$J,358.3,38164,2)
 ;;=^5158124
 ;;^UTILITY(U,$J,358.3,38165,0)
 ;;=Q66.32^^146^1930^21
 ;;^UTILITY(U,$J,358.3,38165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38165,1,3,0)
 ;;=3^Varus Deformity,Congenital,Left Foot
 ;;^UTILITY(U,$J,358.3,38165,1,4,0)
 ;;=4^Q66.32
 ;;^UTILITY(U,$J,358.3,38165,2)
 ;;=^5158125
 ;;^UTILITY(U,$J,358.3,38166,0)
 ;;=S91.001A^^146^1931^7
 ;;^UTILITY(U,$J,358.3,38166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38166,1,3,0)
 ;;=3^Open wound, rt ankl, unspec, init enc
 ;;^UTILITY(U,$J,358.3,38166,1,4,0)
 ;;=4^S91.001A
 ;;^UTILITY(U,$J,358.3,38166,2)
 ;;=^5044129
 ;;^UTILITY(U,$J,358.3,38167,0)
 ;;=S91.002A^^146^1931^1
 ;;^UTILITY(U,$J,358.3,38167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38167,1,3,0)
 ;;=3^Open wound, lft ankl, unspec, init enc
 ;;^UTILITY(U,$J,358.3,38167,1,4,0)
 ;;=4^S91.002A
 ;;^UTILITY(U,$J,358.3,38167,2)
 ;;=^5044132
 ;;^UTILITY(U,$J,358.3,38168,0)
 ;;=S91.301A^^146^1931^8
 ;;^UTILITY(U,$J,358.3,38168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38168,1,3,0)
 ;;=3^Open wound, rt foot, unspec, init enc
 ;;^UTILITY(U,$J,358.3,38168,1,4,0)
 ;;=4^S91.301A
 ;;^UTILITY(U,$J,358.3,38168,2)
 ;;=^5044314
 ;;^UTILITY(U,$J,358.3,38169,0)
 ;;=S91.302A^^146^1931^2
 ;;^UTILITY(U,$J,358.3,38169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38169,1,3,0)
 ;;=3^Open wound, lft foot, unspec, init enc
 ;;^UTILITY(U,$J,358.3,38169,1,4,0)
 ;;=4^S91.302A
 ;;^UTILITY(U,$J,358.3,38169,2)
 ;;=^5044317
 ;;^UTILITY(U,$J,358.3,38170,0)
 ;;=S91.101A^^146^1931^10
 ;;^UTILITY(U,$J,358.3,38170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38170,1,3,0)
 ;;=3^Open wound, rt grt toe w/o nail dmg, unspec, init enc
 ;;^UTILITY(U,$J,358.3,38170,1,4,0)
 ;;=4^S91.101A
 ;;^UTILITY(U,$J,358.3,38170,2)
 ;;=^5044168
 ;;^UTILITY(U,$J,358.3,38171,0)
 ;;=S91.102A^^146^1931^4
 ;;^UTILITY(U,$J,358.3,38171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38171,1,3,0)
 ;;=3^Open wound, lft grt toe w/o nail dmg, unspec, init enc
 ;;^UTILITY(U,$J,358.3,38171,1,4,0)
 ;;=4^S91.102A
 ;;^UTILITY(U,$J,358.3,38171,2)
 ;;=^5044171
 ;;^UTILITY(U,$J,358.3,38172,0)
 ;;=S91.104A^^146^1931^12
 ;;^UTILITY(U,$J,358.3,38172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38172,1,3,0)
 ;;=3^Open wound, rt lsr toe(s) w/o nail dmg, unspec, init enc
 ;;^UTILITY(U,$J,358.3,38172,1,4,0)
 ;;=4^S91.104A
 ;;^UTILITY(U,$J,358.3,38172,2)
 ;;=^5044174
 ;;^UTILITY(U,$J,358.3,38173,0)
 ;;=S91.105A^^146^1931^6
 ;;^UTILITY(U,$J,358.3,38173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38173,1,3,0)
 ;;=3^Open wound, lft lsr toe(s) w/o nail dmg, unspec, init enc
 ;;^UTILITY(U,$J,358.3,38173,1,4,0)
 ;;=4^S91.105A
 ;;^UTILITY(U,$J,358.3,38173,2)
 ;;=^5044177
