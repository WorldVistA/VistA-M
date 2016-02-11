IBDEI2I4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41987,1,3,0)
 ;;=3^Bite,Open Rt Grt Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,41987,1,4,0)
 ;;=4^S91.151A
 ;;^UTILITY(U,$J,358.3,41987,2)
 ;;=^5044243
 ;;^UTILITY(U,$J,358.3,41988,0)
 ;;=S91.152A^^192^2133^4
 ;;^UTILITY(U,$J,358.3,41988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41988,1,3,0)
 ;;=3^Bite,Open Lft Grt Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,41988,1,4,0)
 ;;=4^S91.152A
 ;;^UTILITY(U,$J,358.3,41988,2)
 ;;=^5044246
 ;;^UTILITY(U,$J,358.3,41989,0)
 ;;=S91.154A^^192^2133^10
 ;;^UTILITY(U,$J,358.3,41989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41989,1,3,0)
 ;;=3^Bite,Open Rt Lsr Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,41989,1,4,0)
 ;;=4^S91.154A
 ;;^UTILITY(U,$J,358.3,41989,2)
 ;;=^5044252
 ;;^UTILITY(U,$J,358.3,41990,0)
 ;;=S91.155A^^192^2133^6
 ;;^UTILITY(U,$J,358.3,41990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41990,1,3,0)
 ;;=3^Bite,Open Lft Lsr Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,41990,1,4,0)
 ;;=4^S91.155A
 ;;^UTILITY(U,$J,358.3,41990,2)
 ;;=^5044255
 ;;^UTILITY(U,$J,358.3,41991,0)
 ;;=L75.0^^192^2133^17
 ;;^UTILITY(U,$J,358.3,41991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41991,1,3,0)
 ;;=3^Bromhidrosis
 ;;^UTILITY(U,$J,358.3,41991,1,4,0)
 ;;=4^L75.0
 ;;^UTILITY(U,$J,358.3,41991,2)
 ;;=^5009297
 ;;^UTILITY(U,$J,358.3,41992,0)
 ;;=S90.421A^^192^2133^15
 ;;^UTILITY(U,$J,358.3,41992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41992,1,3,0)
 ;;=3^Blister (nontherm), rt grt toe, init enc
 ;;^UTILITY(U,$J,358.3,41992,1,4,0)
 ;;=4^S90.421A
 ;;^UTILITY(U,$J,358.3,41992,2)
 ;;=^5043907
 ;;^UTILITY(U,$J,358.3,41993,0)
 ;;=S90.422A^^192^2133^12
 ;;^UTILITY(U,$J,358.3,41993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41993,1,3,0)
 ;;=3^Blister (nontherm), lft grt toe, init enc
 ;;^UTILITY(U,$J,358.3,41993,1,4,0)
 ;;=4^S90.422A
 ;;^UTILITY(U,$J,358.3,41993,2)
 ;;=^5043910
 ;;^UTILITY(U,$J,358.3,41994,0)
 ;;=T25.032A^^192^2133^33
 ;;^UTILITY(U,$J,358.3,41994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41994,1,3,0)
 ;;=3^Burn of lft toe(s)(nail), unsp degree, init enc
 ;;^UTILITY(U,$J,358.3,41994,1,4,0)
 ;;=4^T25.032A
 ;;^UTILITY(U,$J,358.3,41994,2)
 ;;=^5048505
 ;;^UTILITY(U,$J,358.3,41995,0)
 ;;=T25.031A^^192^2133^49
 ;;^UTILITY(U,$J,358.3,41995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41995,1,3,0)
 ;;=3^Burn of rt toe(s)(nail), unsp degree, init enc
 ;;^UTILITY(U,$J,358.3,41995,1,4,0)
 ;;=4^T25.031A
 ;;^UTILITY(U,$J,358.3,41995,2)
 ;;=^5048502
 ;;^UTILITY(U,$J,358.3,41996,0)
 ;;=T25.021A^^192^2133^41
 ;;^UTILITY(U,$J,358.3,41996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41996,1,3,0)
 ;;=3^Burn of rt ft, unspec degree, init enc
 ;;^UTILITY(U,$J,358.3,41996,1,4,0)
 ;;=4^T25.021A
 ;;^UTILITY(U,$J,358.3,41996,2)
 ;;=^5048496
 ;;^UTILITY(U,$J,358.3,41997,0)
 ;;=T25.022A^^192^2133^25
 ;;^UTILITY(U,$J,358.3,41997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41997,1,3,0)
 ;;=3^Burn of lft ft, unspec degree, init enc
 ;;^UTILITY(U,$J,358.3,41997,1,4,0)
 ;;=4^T25.022A
 ;;^UTILITY(U,$J,358.3,41997,2)
 ;;=^5048499
 ;;^UTILITY(U,$J,358.3,41998,0)
 ;;=T25.011A^^192^2133^37
 ;;^UTILITY(U,$J,358.3,41998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41998,1,3,0)
 ;;=3^Burn of rt ankl, unspec degree, init enc
 ;;^UTILITY(U,$J,358.3,41998,1,4,0)
 ;;=4^T25.011A
 ;;^UTILITY(U,$J,358.3,41998,2)
 ;;=^5048490
 ;;^UTILITY(U,$J,358.3,41999,0)
 ;;=T25.012A^^192^2133^21
 ;;^UTILITY(U,$J,358.3,41999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,41999,1,3,0)
 ;;=3^Burn of lft ankl, unspec degree, init enc
