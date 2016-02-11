IBDEI08B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3331,1,4,0)
 ;;=4^E11.8
 ;;^UTILITY(U,$J,358.3,3331,2)
 ;;=^5002665
 ;;^UTILITY(U,$J,358.3,3332,0)
 ;;=E11.9^^28^252^29
 ;;^UTILITY(U,$J,358.3,3332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3332,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,3332,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,3332,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,3333,0)
 ;;=E11.36^^28^252^9
 ;;^UTILITY(U,$J,358.3,3333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3333,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,3333,1,4,0)
 ;;=4^E11.36
 ;;^UTILITY(U,$J,358.3,3333,2)
 ;;=^5002642
 ;;^UTILITY(U,$J,358.3,3334,0)
 ;;=E11.22^^28^252^10
 ;;^UTILITY(U,$J,358.3,3334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3334,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,3334,1,4,0)
 ;;=4^E11.22
 ;;^UTILITY(U,$J,358.3,3334,2)
 ;;=^5002630
 ;;^UTILITY(U,$J,358.3,3335,0)
 ;;=E11.29^^28^252^12
 ;;^UTILITY(U,$J,358.3,3335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3335,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Kidney Complication
 ;;^UTILITY(U,$J,358.3,3335,1,4,0)
 ;;=4^E11.29
 ;;^UTILITY(U,$J,358.3,3335,2)
 ;;=^5002631
 ;;^UTILITY(U,$J,358.3,3336,0)
 ;;=E11.21^^28^252^13
 ;;^UTILITY(U,$J,358.3,3336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3336,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,3336,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,3336,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,3337,0)
 ;;=E11.39^^28^252^16
 ;;^UTILITY(U,$J,358.3,3337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3337,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Ophthalmic Complication
 ;;^UTILITY(U,$J,358.3,3337,1,4,0)
 ;;=4^E11.39
 ;;^UTILITY(U,$J,358.3,3337,2)
 ;;=^5002643
 ;;^UTILITY(U,$J,358.3,3338,0)
 ;;=E11.311^^28^252^20
 ;;^UTILITY(U,$J,358.3,3338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3338,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,3338,1,4,0)
 ;;=4^E11.311
 ;;^UTILITY(U,$J,358.3,3338,2)
 ;;=^5002632
 ;;^UTILITY(U,$J,358.3,3339,0)
 ;;=E11.319^^28^252^19
 ;;^UTILITY(U,$J,358.3,3339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3339,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Reinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,3339,1,4,0)
 ;;=4^E11.319
 ;;^UTILITY(U,$J,358.3,3339,2)
 ;;=^5002633
 ;;^UTILITY(U,$J,358.3,3340,0)
 ;;=Z72.4^^28^252^30
 ;;^UTILITY(U,$J,358.3,3340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3340,1,3,0)
 ;;=3^Diet & Eating Habits,Inappropriate
 ;;^UTILITY(U,$J,358.3,3340,1,4,0)
 ;;=4^Z72.4
 ;;^UTILITY(U,$J,358.3,3340,2)
 ;;=^5063257
 ;;^UTILITY(U,$J,358.3,3341,0)
 ;;=R68.81^^28^252^31
 ;;^UTILITY(U,$J,358.3,3341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3341,1,3,0)
 ;;=3^Early Satiety
 ;;^UTILITY(U,$J,358.3,3341,1,4,0)
 ;;=4^R68.81
 ;;^UTILITY(U,$J,358.3,3341,2)
 ;;=^5019554
 ;;^UTILITY(U,$J,358.3,3342,0)
 ;;=E34.9^^28^252^32
 ;;^UTILITY(U,$J,358.3,3342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3342,1,3,0)
 ;;=3^Endocrine Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3342,1,4,0)
 ;;=4^E34.9
 ;;^UTILITY(U,$J,358.3,3342,2)
 ;;=^5002777
 ;;^UTILITY(U,$J,358.3,3343,0)
 ;;=R62.7^^28^252^33
 ;;^UTILITY(U,$J,358.3,3343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3343,1,3,0)
 ;;=3^Failure to Thrive,Adult
 ;;^UTILITY(U,$J,358.3,3343,1,4,0)
 ;;=4^R62.7
 ;;^UTILITY(U,$J,358.3,3343,2)
 ;;=^322019
 ;;^UTILITY(U,$J,358.3,3344,0)
 ;;=R63.3^^28^252^34
 ;;^UTILITY(U,$J,358.3,3344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3344,1,3,0)
 ;;=3^Feeding Difficulty
