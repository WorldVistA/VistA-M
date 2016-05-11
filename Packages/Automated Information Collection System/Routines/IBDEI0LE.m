IBDEI0LE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9981,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Unspec Stage
 ;;^UTILITY(U,$J,358.3,9981,1,4,0)
 ;;=4^H40.33X0
 ;;^UTILITY(U,$J,358.3,9981,2)
 ;;=^5005860
 ;;^UTILITY(U,$J,358.3,9982,0)
 ;;=H40.33X1^^44^496^125
 ;;^UTILITY(U,$J,358.3,9982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9982,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Mild Stage
 ;;^UTILITY(U,$J,358.3,9982,1,4,0)
 ;;=4^H40.33X1
 ;;^UTILITY(U,$J,358.3,9982,2)
 ;;=^5005861
 ;;^UTILITY(U,$J,358.3,9983,0)
 ;;=H40.33X2^^44^496^126
 ;;^UTILITY(U,$J,358.3,9983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9983,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Moderate Stage
 ;;^UTILITY(U,$J,358.3,9983,1,4,0)
 ;;=4^H40.33X2
 ;;^UTILITY(U,$J,358.3,9983,2)
 ;;=^5005862
 ;;^UTILITY(U,$J,358.3,9984,0)
 ;;=H40.33X3^^44^496^127
 ;;^UTILITY(U,$J,358.3,9984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9984,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Severe Stage
 ;;^UTILITY(U,$J,358.3,9984,1,4,0)
 ;;=4^H40.33X3
 ;;^UTILITY(U,$J,358.3,9984,2)
 ;;=^5005863
 ;;^UTILITY(U,$J,358.3,9985,0)
 ;;=H40.33X4^^44^496^124
 ;;^UTILITY(U,$J,358.3,9985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9985,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,9985,1,4,0)
 ;;=4^H40.33X4
 ;;^UTILITY(U,$J,358.3,9985,2)
 ;;=^5005864
 ;;^UTILITY(U,$J,358.3,9986,0)
 ;;=H21.233^^44^496^26
 ;;^UTILITY(U,$J,358.3,9986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9986,1,3,0)
 ;;=3^Degeneration of Iris,Bilateral
 ;;^UTILITY(U,$J,358.3,9986,1,4,0)
 ;;=4^H21.233
 ;;^UTILITY(U,$J,358.3,9986,2)
 ;;=^5005189
 ;;^UTILITY(U,$J,358.3,9987,0)
 ;;=H40.61X1^^44^496^40
 ;;^UTILITY(U,$J,358.3,9987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9987,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Right Eye,Mild Stage
 ;;^UTILITY(U,$J,358.3,9987,1,4,0)
 ;;=4^H40.61X1
 ;;^UTILITY(U,$J,358.3,9987,2)
 ;;=^5005907
 ;;^UTILITY(U,$J,358.3,9988,0)
 ;;=H40.013^^44^496^59
 ;;^UTILITY(U,$J,358.3,9988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9988,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,9988,1,4,0)
 ;;=4^H40.013
 ;;^UTILITY(U,$J,358.3,9988,2)
 ;;=^5005726
 ;;^UTILITY(U,$J,358.3,9989,0)
 ;;=H40.012^^44^496^60
 ;;^UTILITY(U,$J,358.3,9989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9989,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Left Eye
 ;;^UTILITY(U,$J,358.3,9989,1,4,0)
 ;;=4^H40.012
 ;;^UTILITY(U,$J,358.3,9989,2)
 ;;=^5005725
 ;;^UTILITY(U,$J,358.3,9990,0)
 ;;=H40.011^^44^496^61
 ;;^UTILITY(U,$J,358.3,9990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9990,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,9990,1,4,0)
 ;;=4^H40.011
 ;;^UTILITY(U,$J,358.3,9990,2)
 ;;=^5005724
 ;;^UTILITY(U,$J,358.3,9991,0)
 ;;=H40.023^^44^496^84
 ;;^UTILITY(U,$J,358.3,9991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9991,1,3,0)
 ;;=3^Open-Angle w/ Borderline Findings,Hi Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,9991,1,4,0)
 ;;=4^H40.023
 ;;^UTILITY(U,$J,358.3,9991,2)
 ;;=^5005730
 ;;^UTILITY(U,$J,358.3,9992,0)
 ;;=H40.063^^44^496^108
 ;;^UTILITY(U,$J,358.3,9992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9992,1,3,0)
 ;;=3^Primary Angle-Closure w/o Glaucoma Damage,Bilateral
 ;;^UTILITY(U,$J,358.3,9992,1,4,0)
 ;;=4^H40.063
 ;;^UTILITY(U,$J,358.3,9992,2)
 ;;=^5005746
 ;;^UTILITY(U,$J,358.3,9993,0)
 ;;=H40.243^^44^496^113
 ;;^UTILITY(U,$J,358.3,9993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9993,1,3,0)
 ;;=3^Residual Stage Angle-Closure Glaucoma,Bilateral
