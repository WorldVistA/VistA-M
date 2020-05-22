IBDEI11M ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16766,1,3,0)
 ;;=3^Tracheostomy Status
 ;;^UTILITY(U,$J,358.3,16766,1,4,0)
 ;;=4^Z93.0
 ;;^UTILITY(U,$J,358.3,16766,2)
 ;;=^5063642
 ;;^UTILITY(U,$J,358.3,16767,0)
 ;;=Z99.3^^88^880^156
 ;;^UTILITY(U,$J,358.3,16767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16767,1,3,0)
 ;;=3^Wheelchair Dependence
 ;;^UTILITY(U,$J,358.3,16767,1,4,0)
 ;;=4^Z99.3
 ;;^UTILITY(U,$J,358.3,16767,2)
 ;;=^5063759
 ;;^UTILITY(U,$J,358.3,16768,0)
 ;;=Z83.42^^88^880^21
 ;;^UTILITY(U,$J,358.3,16768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16768,1,3,0)
 ;;=3^Family Hx of Familial Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,16768,1,4,0)
 ;;=4^Z83.42
 ;;^UTILITY(U,$J,358.3,16768,2)
 ;;=^8132985
 ;;^UTILITY(U,$J,358.3,16769,0)
 ;;=Z98.890^^88^880^114
 ;;^UTILITY(U,$J,358.3,16769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16769,1,3,0)
 ;;=3^Postprocedural States/HX of Surgery NEC
 ;;^UTILITY(U,$J,358.3,16769,1,4,0)
 ;;=4^Z98.890
 ;;^UTILITY(U,$J,358.3,16769,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,16770,0)
 ;;=Z95.1^^88^880^115
 ;;^UTILITY(U,$J,358.3,16770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16770,1,3,0)
 ;;=3^Presence of Aortocoronary Bypass
 ;;^UTILITY(U,$J,358.3,16770,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,16770,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,16771,0)
 ;;=Z98.2^^88^880^127
 ;;^UTILITY(U,$J,358.3,16771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16771,1,3,0)
 ;;=3^Presence of Cerebrospinal Fluid Drainage Device
 ;;^UTILITY(U,$J,358.3,16771,1,4,0)
 ;;=4^Z98.2
 ;;^UTILITY(U,$J,358.3,16771,2)
 ;;=^5063735
 ;;^UTILITY(U,$J,358.3,16772,0)
 ;;=Z97.5^^88^880^128
 ;;^UTILITY(U,$J,358.3,16772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16772,1,3,0)
 ;;=3^Presence of Contraceptive (Intrauterine) Device
 ;;^UTILITY(U,$J,358.3,16772,1,4,0)
 ;;=4^Z97.5
 ;;^UTILITY(U,$J,358.3,16772,2)
 ;;=^5063731
 ;;^UTILITY(U,$J,358.3,16773,0)
 ;;=Z95.5^^88^880^129
 ;;^UTILITY(U,$J,358.3,16773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16773,1,3,0)
 ;;=3^Presence of Coronary Angioplasty Implant/Graft
 ;;^UTILITY(U,$J,358.3,16773,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,16773,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,16774,0)
 ;;=Z97.2^^88^880^130
 ;;^UTILITY(U,$J,358.3,16774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16774,1,3,0)
 ;;=3^Presence of Dental Prosthetic Device
 ;;^UTILITY(U,$J,358.3,16774,1,4,0)
 ;;=4^Z97.2
 ;;^UTILITY(U,$J,358.3,16774,2)
 ;;=^5063728
 ;;^UTILITY(U,$J,358.3,16775,0)
 ;;=Z97.4^^88^880^131
 ;;^UTILITY(U,$J,358.3,16775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16775,1,3,0)
 ;;=3^Presence of External Hearing Aid
 ;;^UTILITY(U,$J,358.3,16775,1,4,0)
 ;;=4^Z97.4
 ;;^UTILITY(U,$J,358.3,16775,2)
 ;;=^5063730
 ;;^UTILITY(U,$J,358.3,16776,0)
 ;;=Z96.622^^88^880^117
 ;;^UTILITY(U,$J,358.3,16776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16776,1,3,0)
 ;;=3^Presence of Artificial Elbow Joint,Left
 ;;^UTILITY(U,$J,358.3,16776,1,4,0)
 ;;=4^Z96.622
 ;;^UTILITY(U,$J,358.3,16776,2)
 ;;=^5063696
 ;;^UTILITY(U,$J,358.3,16777,0)
 ;;=Z96.632^^88^880^122
 ;;^UTILITY(U,$J,358.3,16777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16777,1,3,0)
 ;;=3^Presence of Artificial Wrist Joint,Left
 ;;^UTILITY(U,$J,358.3,16777,1,4,0)
 ;;=4^Z96.632
 ;;^UTILITY(U,$J,358.3,16777,2)
 ;;=^5063699
 ;;^UTILITY(U,$J,358.3,16778,0)
 ;;=Z96.621^^88^880^118
 ;;^UTILITY(U,$J,358.3,16778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16778,1,3,0)
 ;;=3^Presence of Artificial Elbow Joint,Right
