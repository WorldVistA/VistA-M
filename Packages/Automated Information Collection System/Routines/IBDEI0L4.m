IBDEI0L4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9856,1,3,0)
 ;;=3^Vascular D/O of Iris & Ciliary Body,Bilateral
 ;;^UTILITY(U,$J,358.3,9856,1,4,0)
 ;;=4^H21.1X3
 ;;^UTILITY(U,$J,358.3,9856,2)
 ;;=^5005177
 ;;^UTILITY(U,$J,358.3,9857,0)
 ;;=H31.401^^44^496^13
 ;;^UTILITY(U,$J,358.3,9857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9857,1,3,0)
 ;;=3^Choroidal Detachment,Right Eye,Unspec
 ;;^UTILITY(U,$J,358.3,9857,1,4,0)
 ;;=4^H31.401
 ;;^UTILITY(U,$J,358.3,9857,2)
 ;;=^5005476
 ;;^UTILITY(U,$J,358.3,9858,0)
 ;;=H31.402^^44^496^12
 ;;^UTILITY(U,$J,358.3,9858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9858,1,3,0)
 ;;=3^Choroidal Detachment,Left Eye,Unspec
 ;;^UTILITY(U,$J,358.3,9858,1,4,0)
 ;;=4^H31.402
 ;;^UTILITY(U,$J,358.3,9858,2)
 ;;=^5005477
 ;;^UTILITY(U,$J,358.3,9859,0)
 ;;=H31.421^^44^496^120
 ;;^UTILITY(U,$J,358.3,9859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9859,1,3,0)
 ;;=3^Serous Choroidal Detachment,Right Eye
 ;;^UTILITY(U,$J,358.3,9859,1,4,0)
 ;;=4^H31.421
 ;;^UTILITY(U,$J,358.3,9859,2)
 ;;=^5005483
 ;;^UTILITY(U,$J,358.3,9860,0)
 ;;=H31.422^^44^496^119
 ;;^UTILITY(U,$J,358.3,9860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9860,1,3,0)
 ;;=3^Serous Choroidal Detachment,Left Eye
 ;;^UTILITY(U,$J,358.3,9860,1,4,0)
 ;;=4^H31.422
 ;;^UTILITY(U,$J,358.3,9860,2)
 ;;=^5005484
 ;;^UTILITY(U,$J,358.3,9861,0)
 ;;=H21.231^^44^496^28
 ;;^UTILITY(U,$J,358.3,9861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9861,1,3,0)
 ;;=3^Degeneration of Iris,Right Eye
 ;;^UTILITY(U,$J,358.3,9861,1,4,0)
 ;;=4^H21.231
 ;;^UTILITY(U,$J,358.3,9861,2)
 ;;=^5005187
 ;;^UTILITY(U,$J,358.3,9862,0)
 ;;=H21.232^^44^496^27
 ;;^UTILITY(U,$J,358.3,9862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9862,1,3,0)
 ;;=3^Degeneration of Iris,Left Eye
 ;;^UTILITY(U,$J,358.3,9862,1,4,0)
 ;;=4^H21.232
 ;;^UTILITY(U,$J,358.3,9862,2)
 ;;=^5005188
 ;;^UTILITY(U,$J,358.3,9863,0)
 ;;=H40.011^^44^496^85
 ;;^UTILITY(U,$J,358.3,9863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9863,1,3,0)
 ;;=3^Open-Angle w/ Borderline Findings,Low Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,9863,1,4,0)
 ;;=4^H40.011
 ;;^UTILITY(U,$J,358.3,9863,2)
 ;;=^5005724
 ;;^UTILITY(U,$J,358.3,9864,0)
 ;;=H40.012^^44^496^86
 ;;^UTILITY(U,$J,358.3,9864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9864,1,3,0)
 ;;=3^Open-Angle w/ Borderline Findings,Low Risk,Left Eye
 ;;^UTILITY(U,$J,358.3,9864,1,4,0)
 ;;=4^H40.012
 ;;^UTILITY(U,$J,358.3,9864,2)
 ;;=^5005725
 ;;^UTILITY(U,$J,358.3,9865,0)
 ;;=H40.021^^44^496^82
 ;;^UTILITY(U,$J,358.3,9865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9865,1,3,0)
 ;;=3^Open-Angle w/ Borderline Findings,Hi Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,9865,1,4,0)
 ;;=4^H40.021
 ;;^UTILITY(U,$J,358.3,9865,2)
 ;;=^5005728
 ;;^UTILITY(U,$J,358.3,9866,0)
 ;;=H40.022^^44^496^83
 ;;^UTILITY(U,$J,358.3,9866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9866,1,3,0)
 ;;=3^Open-Angle w/ Borderline Findings,Hi Risk,Left Eye
 ;;^UTILITY(U,$J,358.3,9866,1,4,0)
 ;;=4^H40.022
 ;;^UTILITY(U,$J,358.3,9866,2)
 ;;=^5005729
 ;;^UTILITY(U,$J,358.3,9867,0)
 ;;=H40.031^^44^496^3
 ;;^UTILITY(U,$J,358.3,9867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9867,1,3,0)
 ;;=3^Anatomical Narrow Angle,Right Eye
 ;;^UTILITY(U,$J,358.3,9867,1,4,0)
 ;;=4^H40.031
 ;;^UTILITY(U,$J,358.3,9867,2)
 ;;=^5005732
 ;;^UTILITY(U,$J,358.3,9868,0)
 ;;=H40.032^^44^496^2
 ;;^UTILITY(U,$J,358.3,9868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9868,1,3,0)
 ;;=3^Anatomical Narrow Angle,Left Eye
 ;;^UTILITY(U,$J,358.3,9868,1,4,0)
 ;;=4^H40.032
 ;;^UTILITY(U,$J,358.3,9868,2)
 ;;=^5005733
