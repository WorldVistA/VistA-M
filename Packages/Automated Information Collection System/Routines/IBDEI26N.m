IBDEI26N ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34862,1,3,0)
 ;;=3^Intcrn inj w LOC of 31-59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,34862,1,4,0)
 ;;=4^S06.9X2A
 ;;^UTILITY(U,$J,358.3,34862,2)
 ;;=^5021212
 ;;^UTILITY(U,$J,358.3,34863,0)
 ;;=S06.9X4A^^137^1786^9
 ;;^UTILITY(U,$J,358.3,34863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34863,1,3,0)
 ;;=3^Intcrn inj w LOC of 6 hours to 24 hours, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,34863,1,4,0)
 ;;=4^S06.9X4A
 ;;^UTILITY(U,$J,358.3,34863,2)
 ;;=^5021218
 ;;^UTILITY(U,$J,358.3,34864,0)
 ;;=S06.9X9A^^137^1786^10
 ;;^UTILITY(U,$J,358.3,34864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34864,1,3,0)
 ;;=3^Intcrn inj w LOC of unsp duration, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,34864,1,4,0)
 ;;=4^S06.9X9A
 ;;^UTILITY(U,$J,358.3,34864,2)
 ;;=^5021233
 ;;^UTILITY(U,$J,358.3,34865,0)
 ;;=S06.9X0A^^137^1786^12
 ;;^UTILITY(U,$J,358.3,34865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34865,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,34865,1,4,0)
 ;;=4^S06.9X0A
 ;;^UTILITY(U,$J,358.3,34865,2)
 ;;=^5021206
 ;;^UTILITY(U,$J,358.3,34866,0)
 ;;=S78.019S^^137^1787^4
 ;;^UTILITY(U,$J,358.3,34866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34866,1,3,0)
 ;;=3^Complete traumatic amputation at unsp hip joint, sequela
 ;;^UTILITY(U,$J,358.3,34866,1,4,0)
 ;;=4^S78.019S
 ;;^UTILITY(U,$J,358.3,34866,2)
 ;;=^5039710
 ;;^UTILITY(U,$J,358.3,34867,0)
 ;;=S68.419S^^137^1787^1
 ;;^UTILITY(U,$J,358.3,34867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34867,1,3,0)
 ;;=3^Complete traumatic amp of unsp hand at wrist level, sequela
 ;;^UTILITY(U,$J,358.3,34867,1,4,0)
 ;;=4^S68.419S
 ;;^UTILITY(U,$J,358.3,34867,2)
 ;;=^5036707
 ;;^UTILITY(U,$J,358.3,34868,0)
 ;;=S88.919S^^137^1787^2
 ;;^UTILITY(U,$J,358.3,34868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34868,1,3,0)
 ;;=3^Complete traumatic amp of unsp low leg, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,34868,1,4,0)
 ;;=4^S88.919S
 ;;^UTILITY(U,$J,358.3,34868,2)
 ;;=^5137219
 ;;^UTILITY(U,$J,358.3,34869,0)
 ;;=S48.919S^^137^1787^3
 ;;^UTILITY(U,$J,358.3,34869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34869,1,3,0)
 ;;=3^Complete traumatic amp of unsp shldr/up arm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,34869,1,4,0)
 ;;=4^S48.919S
 ;;^UTILITY(U,$J,358.3,34869,2)
 ;;=^5028331
 ;;^UTILITY(U,$J,358.3,34870,0)
 ;;=S14.2XXS^^137^1787^6
 ;;^UTILITY(U,$J,358.3,34870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34870,1,3,0)
 ;;=3^Injury of nerve root of cervical spine, sequela
 ;;^UTILITY(U,$J,358.3,34870,1,4,0)
 ;;=4^S14.2XXS
 ;;^UTILITY(U,$J,358.3,34870,2)
 ;;=^5022204
 ;;^UTILITY(U,$J,358.3,34871,0)
 ;;=S34.21XS^^137^1787^7
 ;;^UTILITY(U,$J,358.3,34871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34871,1,3,0)
 ;;=3^Injury of nerve root of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,34871,1,4,0)
 ;;=4^S34.21XS
 ;;^UTILITY(U,$J,358.3,34871,2)
 ;;=^5025252
 ;;^UTILITY(U,$J,358.3,34872,0)
 ;;=S34.22XS^^137^1787^8
 ;;^UTILITY(U,$J,358.3,34872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34872,1,3,0)
 ;;=3^Injury of nerve root of sacral spine, sequela
 ;;^UTILITY(U,$J,358.3,34872,1,4,0)
 ;;=4^S34.22XS
 ;;^UTILITY(U,$J,358.3,34872,2)
 ;;=^5025255
 ;;^UTILITY(U,$J,358.3,34873,0)
 ;;=S24.2XXS^^137^1787^9
 ;;^UTILITY(U,$J,358.3,34873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34873,1,3,0)
 ;;=3^Injury of nerve root of thoracic spine, sequela
