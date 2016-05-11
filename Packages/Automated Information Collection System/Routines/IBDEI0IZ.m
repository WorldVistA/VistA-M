IBDEI0IZ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8824,1,3,0)
 ;;=3^Toxic Conjunctivitis,Bilateral,Acute
 ;;^UTILITY(U,$J,358.3,8824,1,4,0)
 ;;=4^H10.213
 ;;^UTILITY(U,$J,358.3,8824,2)
 ;;=^5004670
 ;;^UTILITY(U,$J,358.3,8825,0)
 ;;=H21.1X1^^41^468^162
 ;;^UTILITY(U,$J,358.3,8825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8825,1,3,0)
 ;;=3^Vascular D/O of Iris & Ciliary Body,Right Eye
 ;;^UTILITY(U,$J,358.3,8825,1,4,0)
 ;;=4^H21.1X1
 ;;^UTILITY(U,$J,358.3,8825,2)
 ;;=^5005175
 ;;^UTILITY(U,$J,358.3,8826,0)
 ;;=H21.1X2^^41^468^161
 ;;^UTILITY(U,$J,358.3,8826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8826,1,3,0)
 ;;=3^Vascular D/O of Iris & Ciliary Body,Left Eye
 ;;^UTILITY(U,$J,358.3,8826,1,4,0)
 ;;=4^H21.1X2
 ;;^UTILITY(U,$J,358.3,8826,2)
 ;;=^5005176
 ;;^UTILITY(U,$J,358.3,8827,0)
 ;;=H21.1X3^^41^468^160
 ;;^UTILITY(U,$J,358.3,8827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8827,1,3,0)
 ;;=3^Vascular D/O of Iris & Ciliary Body,Bilateral
 ;;^UTILITY(U,$J,358.3,8827,1,4,0)
 ;;=4^H21.1X3
 ;;^UTILITY(U,$J,358.3,8827,2)
 ;;=^5005177
 ;;^UTILITY(U,$J,358.3,8828,0)
 ;;=H31.401^^41^469^13
 ;;^UTILITY(U,$J,358.3,8828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8828,1,3,0)
 ;;=3^Choroidal Detachment,Right Eye,Unspec
 ;;^UTILITY(U,$J,358.3,8828,1,4,0)
 ;;=4^H31.401
 ;;^UTILITY(U,$J,358.3,8828,2)
 ;;=^5005476
 ;;^UTILITY(U,$J,358.3,8829,0)
 ;;=H31.402^^41^469^12
 ;;^UTILITY(U,$J,358.3,8829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8829,1,3,0)
 ;;=3^Choroidal Detachment,Left Eye,Unspec
 ;;^UTILITY(U,$J,358.3,8829,1,4,0)
 ;;=4^H31.402
 ;;^UTILITY(U,$J,358.3,8829,2)
 ;;=^5005477
 ;;^UTILITY(U,$J,358.3,8830,0)
 ;;=H31.421^^41^469^120
 ;;^UTILITY(U,$J,358.3,8830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8830,1,3,0)
 ;;=3^Serous Choroidal Detachment,Right Eye
 ;;^UTILITY(U,$J,358.3,8830,1,4,0)
 ;;=4^H31.421
 ;;^UTILITY(U,$J,358.3,8830,2)
 ;;=^5005483
 ;;^UTILITY(U,$J,358.3,8831,0)
 ;;=H31.422^^41^469^119
 ;;^UTILITY(U,$J,358.3,8831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8831,1,3,0)
 ;;=3^Serous Choroidal Detachment,Left Eye
 ;;^UTILITY(U,$J,358.3,8831,1,4,0)
 ;;=4^H31.422
 ;;^UTILITY(U,$J,358.3,8831,2)
 ;;=^5005484
 ;;^UTILITY(U,$J,358.3,8832,0)
 ;;=H21.231^^41^469^28
 ;;^UTILITY(U,$J,358.3,8832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8832,1,3,0)
 ;;=3^Degeneration of Iris,Right Eye
 ;;^UTILITY(U,$J,358.3,8832,1,4,0)
 ;;=4^H21.231
 ;;^UTILITY(U,$J,358.3,8832,2)
 ;;=^5005187
 ;;^UTILITY(U,$J,358.3,8833,0)
 ;;=H21.232^^41^469^27
 ;;^UTILITY(U,$J,358.3,8833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8833,1,3,0)
 ;;=3^Degeneration of Iris,Left Eye
 ;;^UTILITY(U,$J,358.3,8833,1,4,0)
 ;;=4^H21.232
 ;;^UTILITY(U,$J,358.3,8833,2)
 ;;=^5005188
 ;;^UTILITY(U,$J,358.3,8834,0)
 ;;=H40.011^^41^469^85
 ;;^UTILITY(U,$J,358.3,8834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8834,1,3,0)
 ;;=3^Open-Angle w/ Borderline Findings,Low Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,8834,1,4,0)
 ;;=4^H40.011
 ;;^UTILITY(U,$J,358.3,8834,2)
 ;;=^5005724
 ;;^UTILITY(U,$J,358.3,8835,0)
 ;;=H40.012^^41^469^86
 ;;^UTILITY(U,$J,358.3,8835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8835,1,3,0)
 ;;=3^Open-Angle w/ Borderline Findings,Low Risk,Left Eye
 ;;^UTILITY(U,$J,358.3,8835,1,4,0)
 ;;=4^H40.012
 ;;^UTILITY(U,$J,358.3,8835,2)
 ;;=^5005725
 ;;^UTILITY(U,$J,358.3,8836,0)
 ;;=H40.021^^41^469^82
 ;;^UTILITY(U,$J,358.3,8836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8836,1,3,0)
 ;;=3^Open-Angle w/ Borderline Findings,Hi Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,8836,1,4,0)
 ;;=4^H40.021
 ;;^UTILITY(U,$J,358.3,8836,2)
 ;;=^5005728
