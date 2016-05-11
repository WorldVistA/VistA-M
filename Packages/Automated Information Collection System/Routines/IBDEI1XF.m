IBDEI1XF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32675,1,3,0)
 ;;=3^Open wound, lft lsr toe(s) w/o nail dmg, unspec, init enc
 ;;^UTILITY(U,$J,358.3,32675,1,4,0)
 ;;=4^S91.105A
 ;;^UTILITY(U,$J,358.3,32675,2)
 ;;=^5044177
 ;;^UTILITY(U,$J,358.3,32676,0)
 ;;=S91.231A^^126^1623^31
 ;;^UTILITY(U,$J,358.3,32676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32676,1,3,0)
 ;;=3^Punctr Wnd w/o FB, rt grt toe w/ nail dmg, init
 ;;^UTILITY(U,$J,358.3,32676,1,4,0)
 ;;=4^S91.231A
 ;;^UTILITY(U,$J,358.3,32676,2)
 ;;=^5044290
 ;;^UTILITY(U,$J,358.3,32677,0)
 ;;=S91.232A^^126^1623^27
 ;;^UTILITY(U,$J,358.3,32677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32677,1,3,0)
 ;;=3^Punctr Wnd w/o FB, lft grt toe w/ nail dmg, init
 ;;^UTILITY(U,$J,358.3,32677,1,4,0)
 ;;=4^S91.232A
 ;;^UTILITY(U,$J,358.3,32677,2)
 ;;=^5044293
 ;;^UTILITY(U,$J,358.3,32678,0)
 ;;=S91.234A^^126^1623^33
 ;;^UTILITY(U,$J,358.3,32678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32678,1,3,0)
 ;;=3^Punctr Wnd w/o FB, rt lsr toe(s) w/ nail dmg, init
 ;;^UTILITY(U,$J,358.3,32678,1,4,0)
 ;;=4^S91.234A
 ;;^UTILITY(U,$J,358.3,32678,2)
 ;;=^5044296
 ;;^UTILITY(U,$J,358.3,32679,0)
 ;;=S91.202A^^126^1623^3
 ;;^UTILITY(U,$J,358.3,32679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32679,1,3,0)
 ;;=3^Open wound, lft grt toe w/ nail dmg, unspec, init
 ;;^UTILITY(U,$J,358.3,32679,1,4,0)
 ;;=4^S91.202A
 ;;^UTILITY(U,$J,358.3,32679,2)
 ;;=^5137421
 ;;^UTILITY(U,$J,358.3,32680,0)
 ;;=S91.204A^^126^1623^11
 ;;^UTILITY(U,$J,358.3,32680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32680,1,3,0)
 ;;=3^Open wound, rt lsr toe(s) w/ nail dmg, unspec, init
 ;;^UTILITY(U,$J,358.3,32680,1,4,0)
 ;;=4^S91.204A
 ;;^UTILITY(U,$J,358.3,32680,2)
 ;;=^5044267
 ;;^UTILITY(U,$J,358.3,32681,0)
 ;;=S91.205A^^126^1623^5
 ;;^UTILITY(U,$J,358.3,32681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32681,1,3,0)
 ;;=3^Open wound, lft lsr toe(s) w/ nail dmg, unspec, init
 ;;^UTILITY(U,$J,358.3,32681,1,4,0)
 ;;=4^S91.205A
 ;;^UTILITY(U,$J,358.3,32681,2)
 ;;=^5137430
 ;;^UTILITY(U,$J,358.3,32682,0)
 ;;=S91.134A^^126^1623^34
 ;;^UTILITY(U,$J,358.3,32682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32682,1,3,0)
 ;;=3^Punctr Wnd w/o FB, rt lsr toe(s) w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,32682,1,4,0)
 ;;=4^S91.134A
 ;;^UTILITY(U,$J,358.3,32682,2)
 ;;=^5044222
 ;;^UTILITY(U,$J,358.3,32683,0)
 ;;=S91.135A^^126^1623^29
 ;;^UTILITY(U,$J,358.3,32683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32683,1,3,0)
 ;;=3^Punctr Wnd w/o FB, lft lsr toe(s) w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,32683,1,4,0)
 ;;=4^S91.135A
 ;;^UTILITY(U,$J,358.3,32683,2)
 ;;=^5044225
 ;;^UTILITY(U,$J,358.3,32684,0)
 ;;=S91.201A^^126^1623^9
 ;;^UTILITY(U,$J,358.3,32684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32684,1,3,0)
 ;;=3^Open wound, rt grt toe w/ nail dmg, unspec, init
 ;;^UTILITY(U,$J,358.3,32684,1,4,0)
 ;;=4^S91.201A
 ;;^UTILITY(U,$J,358.3,32684,2)
 ;;=^5044264
 ;;^UTILITY(U,$J,358.3,32685,0)
 ;;=S91.131A^^126^1623^32
 ;;^UTILITY(U,$J,358.3,32685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32685,1,3,0)
 ;;=3^Punctr Wnd w/o FB, rt grt toe w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,32685,1,4,0)
 ;;=4^S91.131A
 ;;^UTILITY(U,$J,358.3,32685,2)
 ;;=^5044213
 ;;^UTILITY(U,$J,358.3,32686,0)
 ;;=S91.132A^^126^1623^28
 ;;^UTILITY(U,$J,358.3,32686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32686,1,3,0)
 ;;=3^Punctr Wnd w/o FB, lft grt toe w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,32686,1,4,0)
 ;;=4^S91.132A
 ;;^UTILITY(U,$J,358.3,32686,2)
 ;;=^5044216
 ;;^UTILITY(U,$J,358.3,32687,0)
 ;;=S91.041A^^126^1623^19
