IBDEI0IV ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8491,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,8491,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,8491,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,8492,0)
 ;;=I47.1^^39^400^24
 ;;^UTILITY(U,$J,358.3,8492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8492,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,8492,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,8492,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,8493,0)
 ;;=I48.0^^39^400^15
 ;;^UTILITY(U,$J,358.3,8493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8493,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,8493,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,8493,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,8494,0)
 ;;=I49.5^^39^400^23
 ;;^UTILITY(U,$J,358.3,8494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8494,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,8494,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,8494,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,8495,0)
 ;;=I49.8^^39^400^3
 ;;^UTILITY(U,$J,358.3,8495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8495,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,8495,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,8495,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,8496,0)
 ;;=I49.9^^39^400^2
 ;;^UTILITY(U,$J,358.3,8496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8496,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,8496,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,8496,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,8497,0)
 ;;=R00.1^^39^400^1
 ;;^UTILITY(U,$J,358.3,8497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8497,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,8497,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,8497,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,8498,0)
 ;;=I34.1^^39^400^14
 ;;^UTILITY(U,$J,358.3,8498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8498,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,8498,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,8498,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,8499,0)
 ;;=D68.4^^39^401^1
 ;;^UTILITY(U,$J,358.3,8499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8499,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,8499,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,8499,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,8500,0)
 ;;=D59.9^^39^401^2
 ;;^UTILITY(U,$J,358.3,8500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8500,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,8500,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,8500,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,8501,0)
 ;;=C91.00^^39^401^5
 ;;^UTILITY(U,$J,358.3,8501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8501,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,8501,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,8501,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,8502,0)
 ;;=C91.01^^39^401^4
 ;;^UTILITY(U,$J,358.3,8502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8502,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,8502,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,8502,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,8503,0)
 ;;=C92.01^^39^401^7
 ;;^UTILITY(U,$J,358.3,8503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8503,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,8503,1,4,0)
 ;;=4^C92.01
