IBDEI2JN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42664,1,3,0)
 ;;=3^Injury,Rt Lsr Toe(s),Sprfcl,Init Encntr
 ;;^UTILITY(U,$J,358.3,42664,1,4,0)
 ;;=4^S90.934A
 ;;^UTILITY(U,$J,358.3,42664,2)
 ;;=^5044123
 ;;^UTILITY(U,$J,358.3,42665,0)
 ;;=S90.935A^^192^2140^17
 ;;^UTILITY(U,$J,358.3,42665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42665,1,3,0)
 ;;=3^Injury,Lft Lsr Toe(s),Sprfcl,Init Encntr
 ;;^UTILITY(U,$J,358.3,42665,1,4,0)
 ;;=4^S90.935A
 ;;^UTILITY(U,$J,358.3,42665,2)
 ;;=^5044126
 ;;^UTILITY(U,$J,358.3,42666,0)
 ;;=S90.921A^^192^2140^18
 ;;^UTILITY(U,$J,358.3,42666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42666,1,3,0)
 ;;=3^Injury,Rt Foot,Sprfcl,Init Encntr
 ;;^UTILITY(U,$J,358.3,42666,1,4,0)
 ;;=4^S90.921A
 ;;^UTILITY(U,$J,358.3,42666,2)
 ;;=^5044111
 ;;^UTILITY(U,$J,358.3,42667,0)
 ;;=S91.012A^^192^2141^16
 ;;^UTILITY(U,$J,358.3,42667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42667,1,3,0)
 ;;=3^Lacrtn w/o foreign body lft ankl, init
 ;;^UTILITY(U,$J,358.3,42667,1,4,0)
 ;;=4^S91.012A
 ;;^UTILITY(U,$J,358.3,42667,2)
 ;;=^5044138
 ;;^UTILITY(U,$J,358.3,42668,0)
 ;;=S91.011A^^192^2141^23
 ;;^UTILITY(U,$J,358.3,42668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42668,1,3,0)
 ;;=3^Lacrtn w/o foreign body rt ankl, init
 ;;^UTILITY(U,$J,358.3,42668,1,4,0)
 ;;=4^S91.011A
 ;;^UTILITY(U,$J,358.3,42668,2)
 ;;=^5044135
 ;;^UTILITY(U,$J,358.3,42669,0)
 ;;=S91.312A^^192^2141^17
 ;;^UTILITY(U,$J,358.3,42669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42669,1,3,0)
 ;;=3^Lacrtn w/o foreign body lft ft, init
 ;;^UTILITY(U,$J,358.3,42669,1,4,0)
 ;;=4^S91.312A
 ;;^UTILITY(U,$J,358.3,42669,2)
 ;;=^5044323
 ;;^UTILITY(U,$J,358.3,42670,0)
 ;;=S91.115A^^192^2141^20
 ;;^UTILITY(U,$J,358.3,42670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42670,1,3,0)
 ;;=3^Lacrtn w/o foreign body lft lsr toe(s) w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,42670,1,4,0)
 ;;=4^S91.115A
 ;;^UTILITY(U,$J,358.3,42670,2)
 ;;=^5044195
 ;;^UTILITY(U,$J,358.3,42671,0)
 ;;=S91.111A^^192^2141^26
 ;;^UTILITY(U,$J,358.3,42671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42671,1,3,0)
 ;;=3^Lacrtn w/o foreign body rt grt toe w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,42671,1,4,0)
 ;;=4^S91.111A
 ;;^UTILITY(U,$J,358.3,42671,2)
 ;;=^5044183
 ;;^UTILITY(U,$J,358.3,42672,0)
 ;;=S91.112A^^192^2141^19
 ;;^UTILITY(U,$J,358.3,42672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42672,1,3,0)
 ;;=3^Lacrtn w/o foreign body lft grt toe w/o nail dmg, init
 ;;^UTILITY(U,$J,358.3,42672,1,4,0)
 ;;=4^S91.112A
 ;;^UTILITY(U,$J,358.3,42672,2)
 ;;=^5044186
 ;;^UTILITY(U,$J,358.3,42673,0)
 ;;=S91.214A^^192^2141^15
 ;;^UTILITY(U,$J,358.3,42673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42673,1,3,0)
 ;;=3^Lacrtn w/o foregin body rt lsr toe(s) w/ nail dmg, init
 ;;^UTILITY(U,$J,358.3,42673,1,4,0)
 ;;=4^S91.214A
 ;;^UTILITY(U,$J,358.3,42673,2)
 ;;=^5044279
 ;;^UTILITY(U,$J,358.3,42674,0)
 ;;=S91.215A^^192^2141^21
 ;;^UTILITY(U,$J,358.3,42674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42674,1,3,0)
 ;;=3^Lacrtn w/o foreign body lft lsr toe(s) w/ nail dmg, init
 ;;^UTILITY(U,$J,358.3,42674,1,4,0)
 ;;=4^S91.215A
 ;;^UTILITY(U,$J,358.3,42674,2)
 ;;=^5044282
 ;;^UTILITY(U,$J,358.3,42675,0)
 ;;=S91.022A^^192^2141^5
 ;;^UTILITY(U,$J,358.3,42675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42675,1,3,0)
 ;;=3^Lacrtn w/ foreign body lft ankl, init
 ;;^UTILITY(U,$J,358.3,42675,1,4,0)
 ;;=4^S91.022A
 ;;^UTILITY(U,$J,358.3,42675,2)
 ;;=^5137406
 ;;^UTILITY(U,$J,358.3,42676,0)
 ;;=S91.021A^^192^2141^10
 ;;^UTILITY(U,$J,358.3,42676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42676,1,3,0)
 ;;=3^Lacrtn w/ foreign body rt ankl, init
