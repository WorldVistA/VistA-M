IBDEI2GI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41222,0)
 ;;=S90.932A^^189^2089^16
 ;;^UTILITY(U,$J,358.3,41222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41222,1,3,0)
 ;;=3^Injury,Lft Grt Toe,Sprfcl,Init Encntr
 ;;^UTILITY(U,$J,358.3,41222,1,4,0)
 ;;=4^S90.932A
 ;;^UTILITY(U,$J,358.3,41222,2)
 ;;=^5044120
 ;;^UTILITY(U,$J,358.3,41223,0)
 ;;=S90.934A^^189^2089^20
 ;;^UTILITY(U,$J,358.3,41223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41223,1,3,0)
 ;;=3^Injury,Rt Lsr Toe(s),Sprfcl,Init Encntr
 ;;^UTILITY(U,$J,358.3,41223,1,4,0)
 ;;=4^S90.934A
 ;;^UTILITY(U,$J,358.3,41223,2)
 ;;=^5044123
 ;;^UTILITY(U,$J,358.3,41224,0)
 ;;=S90.935A^^189^2089^17
 ;;^UTILITY(U,$J,358.3,41224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41224,1,3,0)
 ;;=3^Injury,Lft Lsr Toe(s),Sprfcl,Init Encntr
 ;;^UTILITY(U,$J,358.3,41224,1,4,0)
 ;;=4^S90.935A
 ;;^UTILITY(U,$J,358.3,41224,2)
 ;;=^5044126
 ;;^UTILITY(U,$J,358.3,41225,0)
 ;;=S90.921A^^189^2089^18
 ;;^UTILITY(U,$J,358.3,41225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41225,1,3,0)
 ;;=3^Injury,Rt Foot,Sprfcl,Init Encntr
 ;;^UTILITY(U,$J,358.3,41225,1,4,0)
 ;;=4^S90.921A
 ;;^UTILITY(U,$J,358.3,41225,2)
 ;;=^5044111
 ;;^UTILITY(U,$J,358.3,41226,0)
 ;;=S91.012A^^189^2090^16
 ;;^UTILITY(U,$J,358.3,41226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41226,1,3,0)
 ;;=3^Lacrtn w/o foreign body lft ankl, init
 ;;^UTILITY(U,$J,358.3,41226,1,4,0)
 ;;=4^S91.012A
 ;;^UTILITY(U,$J,358.3,41226,2)
 ;;=^5044138
 ;;^UTILITY(U,$J,358.3,41227,0)
 ;;=S91.011A^^189^2090^23
 ;;^UTILITY(U,$J,358.3,41227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41227,1,3,0)
 ;;=3^Lacrtn w/o foreign body rt ankl, init
 ;;^UTILITY(U,$J,358.3,41227,1,4,0)
 ;;=4^S91.011A
 ;;^UTILITY(U,$J,358.3,41227,2)
 ;;=^5044135
 ;;^UTILITY(U,$J,358.3,41228,0)
 ;;=S91.312A^^189^2090^17
 ;;^UTILITY(U,$J,358.3,41228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41228,1,3,0)
 ;;=3^Lacrtn w/o foreign body lft ft, init
 ;;^UTILITY(U,$J,358.3,41228,1,4,0)
 ;;=4^S91.312A
 ;;^UTILITY(U,$J,358.3,41228,2)
 ;;=^5044323
 ;;^UTILITY(U,$J,358.3,41229,0)
 ;;=S91.115A^^189^2090^20
 ;;^UTILITY(U,$J,358.3,41229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41229,1,3,0)
 ;;=3^Lacrtn w/o foreign body lft lsr toe(s) w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,41229,1,4,0)
 ;;=4^S91.115A
 ;;^UTILITY(U,$J,358.3,41229,2)
 ;;=^5044195
 ;;^UTILITY(U,$J,358.3,41230,0)
 ;;=S91.111A^^189^2090^26
 ;;^UTILITY(U,$J,358.3,41230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41230,1,3,0)
 ;;=3^Lacrtn w/o foreign body rt grt toe w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,41230,1,4,0)
 ;;=4^S91.111A
 ;;^UTILITY(U,$J,358.3,41230,2)
 ;;=^5044183
 ;;^UTILITY(U,$J,358.3,41231,0)
 ;;=S91.112A^^189^2090^19
 ;;^UTILITY(U,$J,358.3,41231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41231,1,3,0)
 ;;=3^Lacrtn w/o foreign body lft grt toe w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,41231,1,4,0)
 ;;=4^S91.112A
 ;;^UTILITY(U,$J,358.3,41231,2)
 ;;=^5044186
 ;;^UTILITY(U,$J,358.3,41232,0)
 ;;=S91.214A^^189^2090^15
 ;;^UTILITY(U,$J,358.3,41232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41232,1,3,0)
 ;;=3^Lacrtn w/o foregin body rt lsr toe(s) w/ nail dmg, init
 ;;^UTILITY(U,$J,358.3,41232,1,4,0)
 ;;=4^S91.214A
 ;;^UTILITY(U,$J,358.3,41232,2)
 ;;=^5044279
 ;;^UTILITY(U,$J,358.3,41233,0)
 ;;=S91.215A^^189^2090^21
 ;;^UTILITY(U,$J,358.3,41233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41233,1,3,0)
 ;;=3^Lacrtn w/o foreign body lft lsr toe(s) w/ nail dmg, init
 ;;^UTILITY(U,$J,358.3,41233,1,4,0)
 ;;=4^S91.215A
 ;;^UTILITY(U,$J,358.3,41233,2)
 ;;=^5044282
 ;;^UTILITY(U,$J,358.3,41234,0)
 ;;=S91.022A^^189^2090^5
