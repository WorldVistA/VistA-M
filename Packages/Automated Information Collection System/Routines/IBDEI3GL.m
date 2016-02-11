IBDEI3GL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,58182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58182,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Mild Stage
 ;;^UTILITY(U,$J,358.3,58182,1,4,0)
 ;;=4^H40.33X1
 ;;^UTILITY(U,$J,358.3,58182,2)
 ;;=^5005861
 ;;^UTILITY(U,$J,358.3,58183,0)
 ;;=H40.33X2^^272^2901^126
 ;;^UTILITY(U,$J,358.3,58183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58183,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Moderate Stage
 ;;^UTILITY(U,$J,358.3,58183,1,4,0)
 ;;=4^H40.33X2
 ;;^UTILITY(U,$J,358.3,58183,2)
 ;;=^5005862
 ;;^UTILITY(U,$J,358.3,58184,0)
 ;;=H40.33X3^^272^2901^127
 ;;^UTILITY(U,$J,358.3,58184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58184,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Severe Stage
 ;;^UTILITY(U,$J,358.3,58184,1,4,0)
 ;;=4^H40.33X3
 ;;^UTILITY(U,$J,358.3,58184,2)
 ;;=^5005863
 ;;^UTILITY(U,$J,358.3,58185,0)
 ;;=H40.33X4^^272^2901^124
 ;;^UTILITY(U,$J,358.3,58185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58185,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,58185,1,4,0)
 ;;=4^H40.33X4
 ;;^UTILITY(U,$J,358.3,58185,2)
 ;;=^5005864
 ;;^UTILITY(U,$J,358.3,58186,0)
 ;;=H21.233^^272^2901^26
 ;;^UTILITY(U,$J,358.3,58186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58186,1,3,0)
 ;;=3^Degeneration of Iris,Bilateral
 ;;^UTILITY(U,$J,358.3,58186,1,4,0)
 ;;=4^H21.233
 ;;^UTILITY(U,$J,358.3,58186,2)
 ;;=^5005189
 ;;^UTILITY(U,$J,358.3,58187,0)
 ;;=H40.61X1^^272^2901^40
 ;;^UTILITY(U,$J,358.3,58187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58187,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Right Eye,Mild Stage
 ;;^UTILITY(U,$J,358.3,58187,1,4,0)
 ;;=4^H40.61X1
 ;;^UTILITY(U,$J,358.3,58187,2)
 ;;=^5005907
 ;;^UTILITY(U,$J,358.3,58188,0)
 ;;=H40.013^^272^2901^59
 ;;^UTILITY(U,$J,358.3,58188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58188,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,58188,1,4,0)
 ;;=4^H40.013
 ;;^UTILITY(U,$J,358.3,58188,2)
 ;;=^5005726
 ;;^UTILITY(U,$J,358.3,58189,0)
 ;;=H40.012^^272^2901^60
 ;;^UTILITY(U,$J,358.3,58189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58189,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Left Eye
 ;;^UTILITY(U,$J,358.3,58189,1,4,0)
 ;;=4^H40.012
 ;;^UTILITY(U,$J,358.3,58189,2)
 ;;=^5005725
 ;;^UTILITY(U,$J,358.3,58190,0)
 ;;=H40.011^^272^2901^61
 ;;^UTILITY(U,$J,358.3,58190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58190,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,58190,1,4,0)
 ;;=4^H40.011
 ;;^UTILITY(U,$J,358.3,58190,2)
 ;;=^5005724
 ;;^UTILITY(U,$J,358.3,58191,0)
 ;;=H40.023^^272^2901^84
 ;;^UTILITY(U,$J,358.3,58191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58191,1,3,0)
 ;;=3^Open-Angle w/ Borderline Findings,Hi Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,58191,1,4,0)
 ;;=4^H40.023
 ;;^UTILITY(U,$J,358.3,58191,2)
 ;;=^5005730
 ;;^UTILITY(U,$J,358.3,58192,0)
 ;;=H40.063^^272^2901^108
 ;;^UTILITY(U,$J,358.3,58192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58192,1,3,0)
 ;;=3^Primary Angle-Closure w/o Glaucoma Damage,Bilateral
 ;;^UTILITY(U,$J,358.3,58192,1,4,0)
 ;;=4^H40.063
 ;;^UTILITY(U,$J,358.3,58192,2)
 ;;=^5005746
 ;;^UTILITY(U,$J,358.3,58193,0)
 ;;=H40.243^^272^2901^113
 ;;^UTILITY(U,$J,358.3,58193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,58193,1,3,0)
 ;;=3^Residual Stage Angle-Closure Glaucoma,Bilateral
 ;;^UTILITY(U,$J,358.3,58193,1,4,0)
 ;;=4^H40.243
 ;;^UTILITY(U,$J,358.3,58193,2)
 ;;=^5005845
 ;;^UTILITY(U,$J,358.3,58194,0)
 ;;=H40.043^^272^2901^121
