IBDEI1WO ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33866,1,3,0)
 ;;=3^Soft Tissue Disorders NEC
 ;;^UTILITY(U,$J,358.3,33866,1,4,0)
 ;;=4^M79.89
 ;;^UTILITY(U,$J,358.3,33866,2)
 ;;=^5013357
 ;;^UTILITY(U,$J,358.3,33867,0)
 ;;=S86.911A^^191^1978^25
 ;;^UTILITY(U,$J,358.3,33867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33867,1,3,0)
 ;;=3^Strain of unsp musc/tend lwr rt leg, init
 ;;^UTILITY(U,$J,358.3,33867,1,4,0)
 ;;=4^S86.911A
 ;;^UTILITY(U,$J,358.3,33867,2)
 ;;=^5137199
 ;;^UTILITY(U,$J,358.3,33868,0)
 ;;=S86.912A^^191^1978^24
 ;;^UTILITY(U,$J,358.3,33868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33868,1,3,0)
 ;;=3^Strain of unsp musc/ten lwr lft leg, init
 ;;^UTILITY(U,$J,358.3,33868,1,4,0)
 ;;=4^S86.912A
 ;;^UTILITY(U,$J,358.3,33868,2)
 ;;=^5137200
 ;;^UTILITY(U,$J,358.3,33869,0)
 ;;=S93.401A^^191^1978^18
 ;;^UTILITY(U,$J,358.3,33869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33869,1,3,0)
 ;;=3^Sprain of unsp ligament rt ankl, init
 ;;^UTILITY(U,$J,358.3,33869,1,4,0)
 ;;=4^S93.401A
 ;;^UTILITY(U,$J,358.3,33869,2)
 ;;=^5045774
 ;;^UTILITY(U,$J,358.3,33870,0)
 ;;=S93.402A^^191^1978^17
 ;;^UTILITY(U,$J,358.3,33870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33870,1,3,0)
 ;;=3^Sprain of unsp ligament lft ankl, init
 ;;^UTILITY(U,$J,358.3,33870,1,4,0)
 ;;=4^S93.402A
 ;;^UTILITY(U,$J,358.3,33870,2)
 ;;=^5045777
 ;;^UTILITY(U,$J,358.3,33871,0)
 ;;=S93.601A^^191^1978^5
 ;;^UTILITY(U,$J,358.3,33871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33871,1,3,0)
 ;;=3^Sprain Rt Ft,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,33871,1,4,0)
 ;;=4^S93.601A
 ;;^UTILITY(U,$J,358.3,33871,2)
 ;;=^5045867
 ;;^UTILITY(U,$J,358.3,33872,0)
 ;;=S93.602A^^191^1978^6
 ;;^UTILITY(U,$J,358.3,33872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33872,1,3,0)
 ;;=3^Sprain Rt Ft,Unspec,Init Enctr
 ;;^UTILITY(U,$J,358.3,33872,1,4,0)
 ;;=4^S93.602A
 ;;^UTILITY(U,$J,358.3,33872,2)
 ;;=^5045870
 ;;^UTILITY(U,$J,358.3,33873,0)
 ;;=S93.621A^^191^1978^15
 ;;^UTILITY(U,$J,358.3,33873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33873,1,3,0)
 ;;=3^Sprain of tarsometarsal ligament rt ft, init
 ;;^UTILITY(U,$J,358.3,33873,1,4,0)
 ;;=4^S93.621A
 ;;^UTILITY(U,$J,358.3,33873,2)
 ;;=^5045882
 ;;^UTILITY(U,$J,358.3,33874,0)
 ;;=S93.622A^^191^1978^16
 ;;^UTILITY(U,$J,358.3,33874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33874,1,3,0)
 ;;=3^Sprain of tarsometatarsal ligament lft ft, init
 ;;^UTILITY(U,$J,358.3,33874,1,4,0)
 ;;=4^S93.622A
 ;;^UTILITY(U,$J,358.3,33874,2)
 ;;=^5045885
 ;;^UTILITY(U,$J,358.3,33875,0)
 ;;=S93.525A^^191^1978^7
 ;;^UTILITY(U,$J,358.3,33875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33875,1,3,0)
 ;;=3^Sprain of MTP jt lft lsr toe(s), init
 ;;^UTILITY(U,$J,358.3,33875,1,4,0)
 ;;=4^S93.525A
 ;;^UTILITY(U,$J,358.3,33875,2)
 ;;=^5045858
 ;;^UTILITY(U,$J,358.3,33876,0)
 ;;=S93.524A^^191^1978^8
 ;;^UTILITY(U,$J,358.3,33876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33876,1,3,0)
 ;;=3^Sprain of MTP jt rt lsr toe(s), init
 ;;^UTILITY(U,$J,358.3,33876,1,4,0)
 ;;=4^S93.524A
 ;;^UTILITY(U,$J,358.3,33876,2)
 ;;=^5045855
 ;;^UTILITY(U,$J,358.3,33877,0)
 ;;=S93.521A^^191^1978^14
 ;;^UTILITY(U,$J,358.3,33877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33877,1,3,0)
 ;;=3^Sprain of metatarsophalangeal jt rt grt toe, init
 ;;^UTILITY(U,$J,358.3,33877,1,4,0)
 ;;=4^S93.521A
 ;;^UTILITY(U,$J,358.3,33877,2)
 ;;=^5045846
 ;;^UTILITY(U,$J,358.3,33878,0)
 ;;=S93.522A^^191^1978^13
 ;;^UTILITY(U,$J,358.3,33878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33878,1,3,0)
 ;;=3^Sprain of metatarsophalangeal jt lft grt toe, init
 ;;^UTILITY(U,$J,358.3,33878,1,4,0)
 ;;=4^S93.522A
