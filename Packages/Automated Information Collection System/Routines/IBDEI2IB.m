IBDEI2IB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42074,1,3,0)
 ;;=3^Cyst,Follicular of Skin/Subcutaneous Tissue NEC
 ;;^UTILITY(U,$J,358.3,42074,1,4,0)
 ;;=4^L72.8
 ;;^UTILITY(U,$J,358.3,42074,2)
 ;;=^5009282
 ;;^UTILITY(U,$J,358.3,42075,0)
 ;;=L72.9^^192^2134^71
 ;;^UTILITY(U,$J,358.3,42075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42075,1,3,0)
 ;;=3^Cyst,Follicular of Skin/Subcutaneous Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,42075,1,4,0)
 ;;=4^L72.9
 ;;^UTILITY(U,$J,358.3,42075,2)
 ;;=^5009283
 ;;^UTILITY(U,$J,358.3,42076,0)
 ;;=M79.A21^^192^2134^13
 ;;^UTILITY(U,$J,358.3,42076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42076,1,3,0)
 ;;=3^Compartment Syndrome,Right Lower Extremity,Nontraumatic
 ;;^UTILITY(U,$J,358.3,42076,1,4,0)
 ;;=4^M79.A21
 ;;^UTILITY(U,$J,358.3,42076,2)
 ;;=^5013362
 ;;^UTILITY(U,$J,358.3,42077,0)
 ;;=M79.A22^^192^2134^11
 ;;^UTILITY(U,$J,358.3,42077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42077,1,3,0)
 ;;=3^Compartment Syndrome,Left Lower Extremity,Nontraumatic
 ;;^UTILITY(U,$J,358.3,42077,1,4,0)
 ;;=4^M79.A22
 ;;^UTILITY(U,$J,358.3,42077,2)
 ;;=^5133870
 ;;^UTILITY(U,$J,358.3,42078,0)
 ;;=M21.541^^192^2134^10
 ;;^UTILITY(U,$J,358.3,42078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42078,1,3,0)
 ;;=3^Clubfoot,Right Foot,Acquired
 ;;^UTILITY(U,$J,358.3,42078,1,4,0)
 ;;=4^M21.541
 ;;^UTILITY(U,$J,358.3,42078,2)
 ;;=^5011125
 ;;^UTILITY(U,$J,358.3,42079,0)
 ;;=M21.542^^192^2134^9
 ;;^UTILITY(U,$J,358.3,42079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42079,1,3,0)
 ;;=3^Clubfoot,Left Foot,Acquired
 ;;^UTILITY(U,$J,358.3,42079,1,4,0)
 ;;=4^M21.542
 ;;^UTILITY(U,$J,358.3,42079,2)
 ;;=^5011126
 ;;^UTILITY(U,$J,358.3,42080,0)
 ;;=S80.12XA^^192^2134^28
 ;;^UTILITY(U,$J,358.3,42080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42080,1,3,0)
 ;;=3^Contusion of lft lwr leg, init enc
 ;;^UTILITY(U,$J,358.3,42080,1,4,0)
 ;;=4^S80.12XA
 ;;^UTILITY(U,$J,358.3,42080,2)
 ;;=^5039903
 ;;^UTILITY(U,$J,358.3,42081,0)
 ;;=S80.11XA^^192^2134^36
 ;;^UTILITY(U,$J,358.3,42081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42081,1,3,0)
 ;;=3^Contusion of rt lwr leg, init enc
 ;;^UTILITY(U,$J,358.3,42081,1,4,0)
 ;;=4^S80.11XA
 ;;^UTILITY(U,$J,358.3,42081,2)
 ;;=^5039900
 ;;^UTILITY(U,$J,358.3,42082,0)
 ;;=S90.31XA^^192^2134^31
 ;;^UTILITY(U,$J,358.3,42082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42082,1,3,0)
 ;;=3^Contusion of rt ft, init enc
 ;;^UTILITY(U,$J,358.3,42082,1,4,0)
 ;;=4^S90.31XA
 ;;^UTILITY(U,$J,358.3,42082,2)
 ;;=^5043883
 ;;^UTILITY(U,$J,358.3,42083,0)
 ;;=S90.32XA^^192^2134^24
 ;;^UTILITY(U,$J,358.3,42083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42083,1,3,0)
 ;;=3^Contusion of lft ft, init enc
 ;;^UTILITY(U,$J,358.3,42083,1,4,0)
 ;;=4^S90.32XA
 ;;^UTILITY(U,$J,358.3,42083,2)
 ;;=^5043886
 ;;^UTILITY(U,$J,358.3,42084,0)
 ;;=S90.02XA^^192^2134^23
 ;;^UTILITY(U,$J,358.3,42084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42084,1,3,0)
 ;;=3^Contusion of lft ankl, init enc
 ;;^UTILITY(U,$J,358.3,42084,1,4,0)
 ;;=4^S90.02XA
 ;;^UTILITY(U,$J,358.3,42084,2)
 ;;=^5043853
 ;;^UTILITY(U,$J,358.3,42085,0)
 ;;=S90.01XA^^192^2134^30
 ;;^UTILITY(U,$J,358.3,42085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42085,1,3,0)
 ;;=3^Contusion of rt ankl, init enc
 ;;^UTILITY(U,$J,358.3,42085,1,4,0)
 ;;=4^S90.01XA
 ;;^UTILITY(U,$J,358.3,42085,2)
 ;;=^5043850
 ;;^UTILITY(U,$J,358.3,42086,0)
 ;;=S90.111A^^192^2134^33
 ;;^UTILITY(U,$J,358.3,42086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42086,1,3,0)
 ;;=3^Contusion of rt grt toe w/o damage to nail, init enc
