IBDEI0WD ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14596,0)
 ;;=S06.9X3A^^58^701^6
 ;;^UTILITY(U,$J,358.3,14596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14596,1,3,0)
 ;;=3^Intcrn inj w LOC of 1-5 hrs 59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14596,1,4,0)
 ;;=4^S06.9X3A
 ;;^UTILITY(U,$J,358.3,14596,2)
 ;;=^5021215
 ;;^UTILITY(U,$J,358.3,14597,0)
 ;;=S06.9X1A^^58^701^7
 ;;^UTILITY(U,$J,358.3,14597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14597,1,3,0)
 ;;=3^Intcrn inj w LOC of 30 minutes or less, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14597,1,4,0)
 ;;=4^S06.9X1A
 ;;^UTILITY(U,$J,358.3,14597,2)
 ;;=^5021209
 ;;^UTILITY(U,$J,358.3,14598,0)
 ;;=S06.9X2A^^58^701^8
 ;;^UTILITY(U,$J,358.3,14598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14598,1,3,0)
 ;;=3^Intcrn inj w LOC of 31-59 min, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14598,1,4,0)
 ;;=4^S06.9X2A
 ;;^UTILITY(U,$J,358.3,14598,2)
 ;;=^5021212
 ;;^UTILITY(U,$J,358.3,14599,0)
 ;;=S06.9X4A^^58^701^9
 ;;^UTILITY(U,$J,358.3,14599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14599,1,3,0)
 ;;=3^Intcrn inj w LOC of 6 hours to 24 hours, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14599,1,4,0)
 ;;=4^S06.9X4A
 ;;^UTILITY(U,$J,358.3,14599,2)
 ;;=^5021218
 ;;^UTILITY(U,$J,358.3,14600,0)
 ;;=S06.9X9A^^58^701^10
 ;;^UTILITY(U,$J,358.3,14600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14600,1,3,0)
 ;;=3^Intcrn inj w LOC of unsp duration, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14600,1,4,0)
 ;;=4^S06.9X9A
 ;;^UTILITY(U,$J,358.3,14600,2)
 ;;=^5021233
 ;;^UTILITY(U,$J,358.3,14601,0)
 ;;=S06.9X0A^^58^701^12
 ;;^UTILITY(U,$J,358.3,14601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14601,1,3,0)
 ;;=3^Intcrn inj w/o LOC, init encntr,Unspec
 ;;^UTILITY(U,$J,358.3,14601,1,4,0)
 ;;=4^S06.9X0A
 ;;^UTILITY(U,$J,358.3,14601,2)
 ;;=^5021206
 ;;^UTILITY(U,$J,358.3,14602,0)
 ;;=S78.019S^^58^702^4
 ;;^UTILITY(U,$J,358.3,14602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14602,1,3,0)
 ;;=3^Complete traumatic amputation at unsp hip joint, sequela
 ;;^UTILITY(U,$J,358.3,14602,1,4,0)
 ;;=4^S78.019S
 ;;^UTILITY(U,$J,358.3,14602,2)
 ;;=^5039710
 ;;^UTILITY(U,$J,358.3,14603,0)
 ;;=S68.419S^^58^702^1
 ;;^UTILITY(U,$J,358.3,14603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14603,1,3,0)
 ;;=3^Complete traumatic amp of unsp hand at wrist level, sequela
 ;;^UTILITY(U,$J,358.3,14603,1,4,0)
 ;;=4^S68.419S
 ;;^UTILITY(U,$J,358.3,14603,2)
 ;;=^5036707
 ;;^UTILITY(U,$J,358.3,14604,0)
 ;;=S88.919S^^58^702^2
 ;;^UTILITY(U,$J,358.3,14604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14604,1,3,0)
 ;;=3^Complete traumatic amp of unsp low leg, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,14604,1,4,0)
 ;;=4^S88.919S
 ;;^UTILITY(U,$J,358.3,14604,2)
 ;;=^5137219
 ;;^UTILITY(U,$J,358.3,14605,0)
 ;;=S48.919S^^58^702^3
 ;;^UTILITY(U,$J,358.3,14605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14605,1,3,0)
 ;;=3^Complete traumatic amp of unsp shldr/up arm, level unsp, sequela
 ;;^UTILITY(U,$J,358.3,14605,1,4,0)
 ;;=4^S48.919S
 ;;^UTILITY(U,$J,358.3,14605,2)
 ;;=^5028331
 ;;^UTILITY(U,$J,358.3,14606,0)
 ;;=S14.2XXS^^58^702^6
 ;;^UTILITY(U,$J,358.3,14606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14606,1,3,0)
 ;;=3^Injury of nerve root of cervical spine, sequela
 ;;^UTILITY(U,$J,358.3,14606,1,4,0)
 ;;=4^S14.2XXS
 ;;^UTILITY(U,$J,358.3,14606,2)
 ;;=^5022204
 ;;^UTILITY(U,$J,358.3,14607,0)
 ;;=S34.21XS^^58^702^7
 ;;^UTILITY(U,$J,358.3,14607,1,0)
 ;;=^358.31IA^4^2
