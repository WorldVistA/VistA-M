IBDEI0FG ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6656,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,6656,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,6656,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,6657,0)
 ;;=I12.0^^53^430^5
 ;;^UTILITY(U,$J,358.3,6657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6657,1,3,0)
 ;;=3^Hypertensive CKD w/ Stage 5 CKD or ESRD
 ;;^UTILITY(U,$J,358.3,6657,1,4,0)
 ;;=4^I12.0
 ;;^UTILITY(U,$J,358.3,6657,2)
 ;;=^5007065
 ;;^UTILITY(U,$J,358.3,6658,0)
 ;;=I12.9^^53^430^4
 ;;^UTILITY(U,$J,358.3,6658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6658,1,3,0)
 ;;=3^Hypertensive CKD w/ Stage 1-4 CKD
 ;;^UTILITY(U,$J,358.3,6658,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,6658,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,6659,0)
 ;;=I13.0^^53^430^8
 ;;^UTILITY(U,$J,358.3,6659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6659,1,3,0)
 ;;=3^Hypertensive HRT & CKD w/ Hrt Fail & Stg 1-4 CKD
 ;;^UTILITY(U,$J,358.3,6659,1,4,0)
 ;;=4^I13.0
 ;;^UTILITY(U,$J,358.3,6659,2)
 ;;=^5007067
 ;;^UTILITY(U,$J,358.3,6660,0)
 ;;=I13.10^^53^430^10
 ;;^UTILITY(U,$J,358.3,6660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6660,1,3,0)
 ;;=3^Hypertensive HRT & CKD w/o Hrt Fail & Stg 1-4 CKD
 ;;^UTILITY(U,$J,358.3,6660,1,4,0)
 ;;=4^I13.10
 ;;^UTILITY(U,$J,358.3,6660,2)
 ;;=^5007068
 ;;^UTILITY(U,$J,358.3,6661,0)
 ;;=I13.11^^53^430^11
 ;;^UTILITY(U,$J,358.3,6661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6661,1,3,0)
 ;;=3^Hypertensive HRT & CKD w/o Hrt Fail & Stg 5 CKD/ESRD
 ;;^UTILITY(U,$J,358.3,6661,1,4,0)
 ;;=4^I13.11
 ;;^UTILITY(U,$J,358.3,6661,2)
 ;;=^5007069
 ;;^UTILITY(U,$J,358.3,6662,0)
 ;;=I13.2^^53^430^9
 ;;^UTILITY(U,$J,358.3,6662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6662,1,3,0)
 ;;=3^Hypertensive HRT & CKD w/ Hrt Fail & Stg 5 CKD/ESRD
 ;;^UTILITY(U,$J,358.3,6662,1,4,0)
 ;;=4^I13.2
 ;;^UTILITY(U,$J,358.3,6662,2)
 ;;=^5007070
 ;;^UTILITY(U,$J,358.3,6663,0)
 ;;=I15.0^^53^430^15
 ;;^UTILITY(U,$J,358.3,6663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6663,1,3,0)
 ;;=3^Renovascular Hypertension
 ;;^UTILITY(U,$J,358.3,6663,1,4,0)
 ;;=4^I15.0
 ;;^UTILITY(U,$J,358.3,6663,2)
 ;;=^5007071
 ;;^UTILITY(U,$J,358.3,6664,0)
 ;;=I15.1^^53^430^3
 ;;^UTILITY(U,$J,358.3,6664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6664,1,3,0)
 ;;=3^Hypertension Secondary to Oth Renal Disorders
 ;;^UTILITY(U,$J,358.3,6664,1,4,0)
 ;;=4^I15.1
 ;;^UTILITY(U,$J,358.3,6664,2)
 ;;=^5007072
 ;;^UTILITY(U,$J,358.3,6665,0)
 ;;=I15.2^^53^430^2
 ;;^UTILITY(U,$J,358.3,6665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6665,1,3,0)
 ;;=3^Hypertension Secondary to Endocrine Disorders
 ;;^UTILITY(U,$J,358.3,6665,1,4,0)
 ;;=4^I15.2
 ;;^UTILITY(U,$J,358.3,6665,2)
 ;;=^5007073
 ;;^UTILITY(U,$J,358.3,6666,0)
 ;;=I15.8^^53^430^16
 ;;^UTILITY(U,$J,358.3,6666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6666,1,3,0)
 ;;=3^Secondary Hypertension,Oth
 ;;^UTILITY(U,$J,358.3,6666,1,4,0)
 ;;=4^I15.8
 ;;^UTILITY(U,$J,358.3,6666,2)
 ;;=^5007074
 ;;^UTILITY(U,$J,358.3,6667,0)
 ;;=I15.9^^53^430^17
 ;;^UTILITY(U,$J,358.3,6667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6667,1,3,0)
 ;;=3^Secondary Hypertension,Unspec
 ;;^UTILITY(U,$J,358.3,6667,1,4,0)
 ;;=4^I15.9
 ;;^UTILITY(U,$J,358.3,6667,2)
 ;;=^5007075
 ;;^UTILITY(U,$J,358.3,6668,0)
 ;;=I16.0^^53^430^14
 ;;^UTILITY(U,$J,358.3,6668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6668,1,3,0)
 ;;=3^Hypertensive Urgency
