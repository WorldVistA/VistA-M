IBDEI28A ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35583,0)
 ;;=S06.9X4A^^139^1816^9
 ;;^UTILITY(U,$J,358.3,35583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35583,1,3,0)
 ;;=3^Intcrn inj w LOC of 6 hours to 24 hours, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,35583,1,4,0)
 ;;=4^S06.9X4A
 ;;^UTILITY(U,$J,358.3,35583,2)
 ;;=^5021218
 ;;^UTILITY(U,$J,358.3,35584,0)
 ;;=S06.9X9A^^139^1816^10
 ;;^UTILITY(U,$J,358.3,35584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35584,1,3,0)
 ;;=3^Intcrn inj w LOC of unsp duration, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,35584,1,4,0)
 ;;=4^S06.9X9A
 ;;^UTILITY(U,$J,358.3,35584,2)
 ;;=^5021233
 ;;^UTILITY(U,$J,358.3,35585,0)
 ;;=S06.9X0A^^139^1816^12
 ;;^UTILITY(U,$J,358.3,35585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35585,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,35585,1,4,0)
 ;;=4^S06.9X0A
 ;;^UTILITY(U,$J,358.3,35585,2)
 ;;=^5021206
 ;;^UTILITY(U,$J,358.3,35586,0)
 ;;=S78.019S^^139^1817^4
 ;;^UTILITY(U,$J,358.3,35586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35586,1,3,0)
 ;;=3^Complete traumatic amputation at unsp hip joint, sequela
 ;;^UTILITY(U,$J,358.3,35586,1,4,0)
 ;;=4^S78.019S
 ;;^UTILITY(U,$J,358.3,35586,2)
 ;;=^5039710
 ;;^UTILITY(U,$J,358.3,35587,0)
 ;;=S68.419S^^139^1817^1
 ;;^UTILITY(U,$J,358.3,35587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35587,1,3,0)
 ;;=3^Complete traumatic amp of unsp hand at wrist level, sequela
 ;;^UTILITY(U,$J,358.3,35587,1,4,0)
 ;;=4^S68.419S
 ;;^UTILITY(U,$J,358.3,35587,2)
 ;;=^5036707
 ;;^UTILITY(U,$J,358.3,35588,0)
 ;;=S88.919S^^139^1817^2
 ;;^UTILITY(U,$J,358.3,35588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35588,1,3,0)
 ;;=3^Complete traumatic amp of unsp low leg, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,35588,1,4,0)
 ;;=4^S88.919S
 ;;^UTILITY(U,$J,358.3,35588,2)
 ;;=^5137219
 ;;^UTILITY(U,$J,358.3,35589,0)
 ;;=S48.919S^^139^1817^3
 ;;^UTILITY(U,$J,358.3,35589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35589,1,3,0)
 ;;=3^Complete traumatic amp of unsp shldr/up arm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,35589,1,4,0)
 ;;=4^S48.919S
 ;;^UTILITY(U,$J,358.3,35589,2)
 ;;=^5028331
 ;;^UTILITY(U,$J,358.3,35590,0)
 ;;=S14.2XXS^^139^1817^6
 ;;^UTILITY(U,$J,358.3,35590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35590,1,3,0)
 ;;=3^Injury of nerve root of cervical spine, sequela
 ;;^UTILITY(U,$J,358.3,35590,1,4,0)
 ;;=4^S14.2XXS
 ;;^UTILITY(U,$J,358.3,35590,2)
 ;;=^5022204
 ;;^UTILITY(U,$J,358.3,35591,0)
 ;;=S34.21XS^^139^1817^7
 ;;^UTILITY(U,$J,358.3,35591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35591,1,3,0)
 ;;=3^Injury of nerve root of lumbar spine, sequela
 ;;^UTILITY(U,$J,358.3,35591,1,4,0)
 ;;=4^S34.21XS
 ;;^UTILITY(U,$J,358.3,35591,2)
 ;;=^5025252
 ;;^UTILITY(U,$J,358.3,35592,0)
 ;;=S34.22XS^^139^1817^8
 ;;^UTILITY(U,$J,358.3,35592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35592,1,3,0)
 ;;=3^Injury of nerve root of sacral spine, sequela
 ;;^UTILITY(U,$J,358.3,35592,1,4,0)
 ;;=4^S34.22XS
 ;;^UTILITY(U,$J,358.3,35592,2)
 ;;=^5025255
 ;;^UTILITY(U,$J,358.3,35593,0)
 ;;=S24.2XXS^^139^1817^9
 ;;^UTILITY(U,$J,358.3,35593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35593,1,3,0)
 ;;=3^Injury of nerve root of thoracic spine, sequela
 ;;^UTILITY(U,$J,358.3,35593,1,4,0)
 ;;=4^S24.2XXS
 ;;^UTILITY(U,$J,358.3,35593,2)
 ;;=^5023347
 ;;^UTILITY(U,$J,358.3,35594,0)
 ;;=S04.9XXS^^139^1817^11
 ;;^UTILITY(U,$J,358.3,35594,1,0)
 ;;=^358.31IA^4^2
