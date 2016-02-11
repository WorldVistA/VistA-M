IBDEI0IT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8454,1,4,0)
 ;;=4^Z85.820
 ;;^UTILITY(U,$J,358.3,8454,2)
 ;;=^5063441
 ;;^UTILITY(U,$J,358.3,8455,0)
 ;;=Z85.828^^55^538^109
 ;;^UTILITY(U,$J,358.3,8455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8455,1,3,0)
 ;;=3^Prsnl hx of malig neoplm of skin NEC
 ;;^UTILITY(U,$J,358.3,8455,1,4,0)
 ;;=4^Z85.828
 ;;^UTILITY(U,$J,358.3,8455,2)
 ;;=^5063443
 ;;^UTILITY(U,$J,358.3,8456,0)
 ;;=Z79.01^^55^538^45
 ;;^UTILITY(U,$J,358.3,8456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8456,1,3,0)
 ;;=3^Long term (current) use of anticoagulants
 ;;^UTILITY(U,$J,358.3,8456,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,8456,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,8457,0)
 ;;=Z95.1^^55^539^1
 ;;^UTILITY(U,$J,358.3,8457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8457,1,3,0)
 ;;=3^Presence of aortocoronary bypass graft
 ;;^UTILITY(U,$J,358.3,8457,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,8457,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,8458,0)
 ;;=Z95.2^^55^539^3
 ;;^UTILITY(U,$J,358.3,8458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8458,1,3,0)
 ;;=3^Presence of prosthetic heart valve
 ;;^UTILITY(U,$J,358.3,8458,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,8458,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,8459,0)
 ;;=Z95.3^^55^539^4
 ;;^UTILITY(U,$J,358.3,8459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8459,1,3,0)
 ;;=3^Presence of xenogenic heart valve
 ;;^UTILITY(U,$J,358.3,8459,1,4,0)
 ;;=4^Z95.3
 ;;^UTILITY(U,$J,358.3,8459,2)
 ;;=^5063671
 ;;^UTILITY(U,$J,358.3,8460,0)
 ;;=Z95.0^^55^539^2
 ;;^UTILITY(U,$J,358.3,8460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8460,1,3,0)
 ;;=3^Presence of cardiac pacemaker
 ;;^UTILITY(U,$J,358.3,8460,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,8460,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,8461,0)
 ;;=A15.0^^55^540^103
 ;;^UTILITY(U,$J,358.3,8461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8461,1,3,0)
 ;;=3^Tuberculosis of lung
 ;;^UTILITY(U,$J,358.3,8461,1,4,0)
 ;;=4^A15.0
 ;;^UTILITY(U,$J,358.3,8461,2)
 ;;=^5000062
 ;;^UTILITY(U,$J,358.3,8462,0)
 ;;=A31.0^^55^540^92
 ;;^UTILITY(U,$J,358.3,8462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8462,1,3,0)
 ;;=3^Pulmonary mycobacterial infection
 ;;^UTILITY(U,$J,358.3,8462,1,4,0)
 ;;=4^A31.0
 ;;^UTILITY(U,$J,358.3,8462,2)
 ;;=^5000149
 ;;^UTILITY(U,$J,358.3,8463,0)
 ;;=B20.^^55^540^72
 ;;^UTILITY(U,$J,358.3,8463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8463,1,3,0)
 ;;=3^Human immunodeficiency virus [HIV] disease
 ;;^UTILITY(U,$J,358.3,8463,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,8463,2)
 ;;=^5000555
 ;;^UTILITY(U,$J,358.3,8464,0)
 ;;=B02.9^^55^540^110
 ;;^UTILITY(U,$J,358.3,8464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8464,1,3,0)
 ;;=3^Zoster without complications
 ;;^UTILITY(U,$J,358.3,8464,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,8464,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,8465,0)
 ;;=A60.9^^55^540^26
 ;;^UTILITY(U,$J,358.3,8465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8465,1,3,0)
 ;;=3^Anogenital herpesviral infection, unspecified
 ;;^UTILITY(U,$J,358.3,8465,1,4,0)
 ;;=4^A60.9
 ;;^UTILITY(U,$J,358.3,8465,2)
 ;;=^5000359
 ;;^UTILITY(U,$J,358.3,8466,0)
 ;;=A60.04^^55^540^71
 ;;^UTILITY(U,$J,358.3,8466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8466,1,3,0)
 ;;=3^Herpesviral vulvovaginitis
 ;;^UTILITY(U,$J,358.3,8466,1,4,0)
 ;;=4^A60.04
 ;;^UTILITY(U,$J,358.3,8466,2)
 ;;=^5000356
 ;;^UTILITY(U,$J,358.3,8467,0)
 ;;=A60.01^^55^540^70
 ;;^UTILITY(U,$J,358.3,8467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8467,1,3,0)
 ;;=3^Herpesviral infection of penis
 ;;^UTILITY(U,$J,358.3,8467,1,4,0)
 ;;=4^A60.01
 ;;^UTILITY(U,$J,358.3,8467,2)
 ;;=^5000353
