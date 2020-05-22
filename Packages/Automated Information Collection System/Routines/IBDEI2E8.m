IBDEI2E8 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38185,1,3,0)
 ;;=3^Punctr Wnd w/ FB, rt ankl, init enc
 ;;^UTILITY(U,$J,358.3,38185,1,4,0)
 ;;=4^S91.041A
 ;;^UTILITY(U,$J,358.3,38185,2)
 ;;=^5044156
 ;;^UTILITY(U,$J,358.3,38186,0)
 ;;=S91.042A^^146^1931^14
 ;;^UTILITY(U,$J,358.3,38186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38186,1,3,0)
 ;;=3^Punctr Wnd w/ FB, lft ankl, init enc
 ;;^UTILITY(U,$J,358.3,38186,1,4,0)
 ;;=4^S91.042A
 ;;^UTILITY(U,$J,358.3,38186,2)
 ;;=^5137412
 ;;^UTILITY(U,$J,358.3,38187,0)
 ;;=S81.841A^^146^1931^25
 ;;^UTILITY(U,$J,358.3,38187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38187,1,3,0)
 ;;=3^Punctr Wnd w/ FB, rt lwr leg, init enc
 ;;^UTILITY(U,$J,358.3,38187,1,4,0)
 ;;=4^S81.841A
 ;;^UTILITY(U,$J,358.3,38187,2)
 ;;=^5040092
 ;;^UTILITY(U,$J,358.3,38188,0)
 ;;=S91.341A^^146^1931^20
 ;;^UTILITY(U,$J,358.3,38188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38188,1,3,0)
 ;;=3^Punctr Wnd w/ FB, rt ft, init enc
 ;;^UTILITY(U,$J,358.3,38188,1,4,0)
 ;;=4^S91.341A
 ;;^UTILITY(U,$J,358.3,38188,2)
 ;;=^5044341
 ;;^UTILITY(U,$J,358.3,38189,0)
 ;;=S81.842A^^146^1931^18
 ;;^UTILITY(U,$J,358.3,38189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38189,1,3,0)
 ;;=3^Punctr Wnd w/ FB, lft lwr leg, init enc
 ;;^UTILITY(U,$J,358.3,38189,1,4,0)
 ;;=4^S81.842A
 ;;^UTILITY(U,$J,358.3,38189,2)
 ;;=^5136697
 ;;^UTILITY(U,$J,358.3,38190,0)
 ;;=S91.144A^^146^1931^24
 ;;^UTILITY(U,$J,358.3,38190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38190,1,3,0)
 ;;=3^Punctr Wnd w/ FB, rt lsr toe(s) w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,38190,1,4,0)
 ;;=4^S91.144A
 ;;^UTILITY(U,$J,358.3,38190,2)
 ;;=^5044237
 ;;^UTILITY(U,$J,358.3,38191,0)
 ;;=S91.142A^^146^1931^16
 ;;^UTILITY(U,$J,358.3,38191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38191,1,3,0)
 ;;=3^Punctr Wnd w/ FB, lft grt toe w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,38191,1,4,0)
 ;;=4^S91.142A
 ;;^UTILITY(U,$J,358.3,38191,2)
 ;;=^5137472
 ;;^UTILITY(U,$J,358.3,38192,0)
 ;;=S91.141A^^146^1931^22
 ;;^UTILITY(U,$J,358.3,38192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38192,1,3,0)
 ;;=3^Punctr Wnd w/ FB, rt grt toe w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,38192,1,4,0)
 ;;=4^S91.141A
 ;;^UTILITY(U,$J,358.3,38192,2)
 ;;=^5044234
 ;;^UTILITY(U,$J,358.3,38193,0)
 ;;=S91.242A^^146^1931^15
 ;;^UTILITY(U,$J,358.3,38193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38193,1,3,0)
 ;;=3^Punctr Wnd w/ FB, lft grt toe w/ nail dmg, init
 ;;^UTILITY(U,$J,358.3,38193,1,4,0)
 ;;=4^S91.242A
 ;;^UTILITY(U,$J,358.3,38193,2)
 ;;=^5137497
 ;;^UTILITY(U,$J,358.3,38194,0)
 ;;=S91.241A^^146^1931^21
 ;;^UTILITY(U,$J,358.3,38194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38194,1,3,0)
 ;;=3^Punctr Wnd w/ FB, rt grt toe w/ nail dmg, init
 ;;^UTILITY(U,$J,358.3,38194,1,4,0)
 ;;=4^S91.241A
 ;;^UTILITY(U,$J,358.3,38194,2)
 ;;=^5137496
 ;;^UTILITY(U,$J,358.3,38195,0)
 ;;=S91.245A^^146^1931^17
 ;;^UTILITY(U,$J,358.3,38195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38195,1,3,0)
 ;;=3^Punctr Wnd w/ FB, lft lsr toe(s) w/ nail dmg, init
 ;;^UTILITY(U,$J,358.3,38195,1,4,0)
 ;;=4^S91.245A
 ;;^UTILITY(U,$J,358.3,38195,2)
 ;;=^5137503
 ;;^UTILITY(U,$J,358.3,38196,0)
 ;;=S91.244A^^146^1931^23
 ;;^UTILITY(U,$J,358.3,38196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38196,1,3,0)
 ;;=3^Punctr Wnd w/ FB, rt lsr toe(s) w/ nail dmg, init
 ;;^UTILITY(U,$J,358.3,38196,1,4,0)
 ;;=4^S91.244A
 ;;^UTILITY(U,$J,358.3,38196,2)
 ;;=^5137502
