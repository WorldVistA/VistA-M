IBDEI076 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3042,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,3042,1,4,0)
 ;;=4^E11.311
 ;;^UTILITY(U,$J,358.3,3042,2)
 ;;=^5002632
 ;;^UTILITY(U,$J,358.3,3043,0)
 ;;=E11.319^^18^213^19
 ;;^UTILITY(U,$J,358.3,3043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3043,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Reinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,3043,1,4,0)
 ;;=4^E11.319
 ;;^UTILITY(U,$J,358.3,3043,2)
 ;;=^5002633
 ;;^UTILITY(U,$J,358.3,3044,0)
 ;;=Z72.4^^18^213^30
 ;;^UTILITY(U,$J,358.3,3044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3044,1,3,0)
 ;;=3^Diet & Eating Habits,Inappropriate
 ;;^UTILITY(U,$J,358.3,3044,1,4,0)
 ;;=4^Z72.4
 ;;^UTILITY(U,$J,358.3,3044,2)
 ;;=^5063257
 ;;^UTILITY(U,$J,358.3,3045,0)
 ;;=R68.81^^18^213^31
 ;;^UTILITY(U,$J,358.3,3045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3045,1,3,0)
 ;;=3^Early Satiety
 ;;^UTILITY(U,$J,358.3,3045,1,4,0)
 ;;=4^R68.81
 ;;^UTILITY(U,$J,358.3,3045,2)
 ;;=^5019554
 ;;^UTILITY(U,$J,358.3,3046,0)
 ;;=E34.9^^18^213^32
 ;;^UTILITY(U,$J,358.3,3046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3046,1,3,0)
 ;;=3^Endocrine Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3046,1,4,0)
 ;;=4^E34.9
 ;;^UTILITY(U,$J,358.3,3046,2)
 ;;=^5002777
 ;;^UTILITY(U,$J,358.3,3047,0)
 ;;=R62.7^^18^213^33
 ;;^UTILITY(U,$J,358.3,3047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3047,1,3,0)
 ;;=3^Failure to Thrive,Adult
 ;;^UTILITY(U,$J,358.3,3047,1,4,0)
 ;;=4^R62.7
 ;;^UTILITY(U,$J,358.3,3047,2)
 ;;=^322019
 ;;^UTILITY(U,$J,358.3,3048,0)
 ;;=R63.3^^18^213^34
 ;;^UTILITY(U,$J,358.3,3048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3048,1,3,0)
 ;;=3^Feeding Difficulty
 ;;^UTILITY(U,$J,358.3,3048,1,4,0)
 ;;=4^R63.3
 ;;^UTILITY(U,$J,358.3,3048,2)
 ;;=^5019541
 ;;^UTILITY(U,$J,358.3,3049,0)
 ;;=E87.8^^18^213^35
 ;;^UTILITY(U,$J,358.3,3049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3049,1,3,0)
 ;;=3^Fluid & Electrolyte Balance Disorder NEC
 ;;^UTILITY(U,$J,358.3,3049,1,4,0)
 ;;=4^E87.8
 ;;^UTILITY(U,$J,358.3,3049,2)
 ;;=^5003026
 ;;^UTILITY(U,$J,358.3,3050,0)
 ;;=E87.70^^18^213^36
 ;;^UTILITY(U,$J,358.3,3050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3050,1,3,0)
 ;;=3^Fluid Overload,Unspec
 ;;^UTILITY(U,$J,358.3,3050,1,4,0)
 ;;=4^E87.70
 ;;^UTILITY(U,$J,358.3,3050,2)
 ;;=^5003023
 ;;^UTILITY(U,$J,358.3,3051,0)
 ;;=R73.01^^18^213^50
 ;;^UTILITY(U,$J,358.3,3051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3051,1,3,0)
 ;;=3^Impaired Fasting Glucose
 ;;^UTILITY(U,$J,358.3,3051,1,4,0)
 ;;=4^R73.01
 ;;^UTILITY(U,$J,358.3,3051,2)
 ;;=^5019561
 ;;^UTILITY(U,$J,358.3,3052,0)
 ;;=R73.02^^18^213^51
 ;;^UTILITY(U,$J,358.3,3052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3052,1,3,0)
 ;;=3^Impaired Oral Glucose Tolerance
 ;;^UTILITY(U,$J,358.3,3052,1,4,0)
 ;;=4^R73.02
 ;;^UTILITY(U,$J,358.3,3052,2)
 ;;=^5019562
 ;;^UTILITY(U,$J,358.3,3053,0)
 ;;=E83.119^^18^213^37
 ;;^UTILITY(U,$J,358.3,3053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3053,1,3,0)
 ;;=3^Hemochromatosis,Unspec
 ;;^UTILITY(U,$J,358.3,3053,1,4,0)
 ;;=4^E83.119
 ;;^UTILITY(U,$J,358.3,3053,2)
 ;;=^5002995
 ;;^UTILITY(U,$J,358.3,3054,0)
 ;;=E83.52^^18^213^38
 ;;^UTILITY(U,$J,358.3,3054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3054,1,3,0)
 ;;=3^Hypercalcemia
 ;;^UTILITY(U,$J,358.3,3054,1,4,0)
 ;;=4^E83.52
 ;;^UTILITY(U,$J,358.3,3054,2)
 ;;=^59932
 ;;^UTILITY(U,$J,358.3,3055,0)
 ;;=E11.65^^18^213^22
 ;;^UTILITY(U,$J,358.3,3055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3055,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,3055,1,4,0)
 ;;=4^E11.65
