IBDEI0SP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13201,2)
 ;;=^5005859
 ;;^UTILITY(U,$J,358.3,13202,0)
 ;;=H40.33X0^^80^754^128
 ;;^UTILITY(U,$J,358.3,13202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13202,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Unspec Stage
 ;;^UTILITY(U,$J,358.3,13202,1,4,0)
 ;;=4^H40.33X0
 ;;^UTILITY(U,$J,358.3,13202,2)
 ;;=^5005860
 ;;^UTILITY(U,$J,358.3,13203,0)
 ;;=H40.33X1^^80^754^125
 ;;^UTILITY(U,$J,358.3,13203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13203,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Mild Stage
 ;;^UTILITY(U,$J,358.3,13203,1,4,0)
 ;;=4^H40.33X1
 ;;^UTILITY(U,$J,358.3,13203,2)
 ;;=^5005861
 ;;^UTILITY(U,$J,358.3,13204,0)
 ;;=H40.33X2^^80^754^126
 ;;^UTILITY(U,$J,358.3,13204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13204,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Moderate Stage
 ;;^UTILITY(U,$J,358.3,13204,1,4,0)
 ;;=4^H40.33X2
 ;;^UTILITY(U,$J,358.3,13204,2)
 ;;=^5005862
 ;;^UTILITY(U,$J,358.3,13205,0)
 ;;=H40.33X3^^80^754^127
 ;;^UTILITY(U,$J,358.3,13205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13205,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Severe Stage
 ;;^UTILITY(U,$J,358.3,13205,1,4,0)
 ;;=4^H40.33X3
 ;;^UTILITY(U,$J,358.3,13205,2)
 ;;=^5005863
 ;;^UTILITY(U,$J,358.3,13206,0)
 ;;=H40.33X4^^80^754^124
 ;;^UTILITY(U,$J,358.3,13206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13206,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,13206,1,4,0)
 ;;=4^H40.33X4
 ;;^UTILITY(U,$J,358.3,13206,2)
 ;;=^5005864
 ;;^UTILITY(U,$J,358.3,13207,0)
 ;;=H21.233^^80^754^26
 ;;^UTILITY(U,$J,358.3,13207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13207,1,3,0)
 ;;=3^Degeneration of Iris,Bilateral
 ;;^UTILITY(U,$J,358.3,13207,1,4,0)
 ;;=4^H21.233
 ;;^UTILITY(U,$J,358.3,13207,2)
 ;;=^5005189
 ;;^UTILITY(U,$J,358.3,13208,0)
 ;;=H40.61X1^^80^754^40
 ;;^UTILITY(U,$J,358.3,13208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13208,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Right Eye,Mild Stage
 ;;^UTILITY(U,$J,358.3,13208,1,4,0)
 ;;=4^H40.61X1
 ;;^UTILITY(U,$J,358.3,13208,2)
 ;;=^5005907
 ;;^UTILITY(U,$J,358.3,13209,0)
 ;;=H40.013^^80^754^59
 ;;^UTILITY(U,$J,358.3,13209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13209,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,13209,1,4,0)
 ;;=4^H40.013
 ;;^UTILITY(U,$J,358.3,13209,2)
 ;;=^5005726
 ;;^UTILITY(U,$J,358.3,13210,0)
 ;;=H40.012^^80^754^60
 ;;^UTILITY(U,$J,358.3,13210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13210,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Left Eye
 ;;^UTILITY(U,$J,358.3,13210,1,4,0)
 ;;=4^H40.012
 ;;^UTILITY(U,$J,358.3,13210,2)
 ;;=^5005725
 ;;^UTILITY(U,$J,358.3,13211,0)
 ;;=H40.011^^80^754^61
 ;;^UTILITY(U,$J,358.3,13211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13211,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,13211,1,4,0)
 ;;=4^H40.011
 ;;^UTILITY(U,$J,358.3,13211,2)
 ;;=^5005724
 ;;^UTILITY(U,$J,358.3,13212,0)
 ;;=H40.023^^80^754^84
 ;;^UTILITY(U,$J,358.3,13212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13212,1,3,0)
 ;;=3^Open-Angle w/ Borderline Findings,Hi Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,13212,1,4,0)
 ;;=4^H40.023
 ;;^UTILITY(U,$J,358.3,13212,2)
 ;;=^5005730
 ;;^UTILITY(U,$J,358.3,13213,0)
 ;;=H40.063^^80^754^108
 ;;^UTILITY(U,$J,358.3,13213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13213,1,3,0)
 ;;=3^Primary Angle-Closure w/o Glaucoma Damage,Bilateral
 ;;^UTILITY(U,$J,358.3,13213,1,4,0)
 ;;=4^H40.063
 ;;^UTILITY(U,$J,358.3,13213,2)
 ;;=^5005746
