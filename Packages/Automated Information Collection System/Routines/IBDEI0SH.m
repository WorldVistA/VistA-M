IBDEI0SH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13357,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,13357,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,13357,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,13358,0)
 ;;=I07.9^^53^592^22
 ;;^UTILITY(U,$J,358.3,13358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13358,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,13358,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,13358,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,13359,0)
 ;;=I08.0^^53^592^16
 ;;^UTILITY(U,$J,358.3,13359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13359,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,13359,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,13359,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,13360,0)
 ;;=I09.89^^53^592^17
 ;;^UTILITY(U,$J,358.3,13360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13360,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,13360,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,13360,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,13361,0)
 ;;=I47.1^^53^592^24
 ;;^UTILITY(U,$J,358.3,13361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13361,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,13361,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,13361,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,13362,0)
 ;;=I48.0^^53^592^15
 ;;^UTILITY(U,$J,358.3,13362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13362,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,13362,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,13362,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,13363,0)
 ;;=I49.5^^53^592^23
 ;;^UTILITY(U,$J,358.3,13363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13363,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,13363,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,13363,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,13364,0)
 ;;=I49.8^^53^592^3
 ;;^UTILITY(U,$J,358.3,13364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13364,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,13364,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,13364,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,13365,0)
 ;;=I49.9^^53^592^2
 ;;^UTILITY(U,$J,358.3,13365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13365,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,13365,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,13365,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,13366,0)
 ;;=R00.1^^53^592^1
 ;;^UTILITY(U,$J,358.3,13366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13366,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,13366,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,13366,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,13367,0)
 ;;=I34.1^^53^592^14
 ;;^UTILITY(U,$J,358.3,13367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13367,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,13367,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,13367,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,13368,0)
 ;;=D68.4^^53^593^1
 ;;^UTILITY(U,$J,358.3,13368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13368,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,13368,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,13368,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,13369,0)
 ;;=D59.9^^53^593^2
 ;;^UTILITY(U,$J,358.3,13369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13369,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,13369,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,13369,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,13370,0)
 ;;=C91.00^^53^593^5
 ;;^UTILITY(U,$J,358.3,13370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13370,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
