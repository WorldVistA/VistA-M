IBDEI16D ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19983,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,19983,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,19983,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,19984,0)
 ;;=I07.9^^84^928^22
 ;;^UTILITY(U,$J,358.3,19984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19984,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,19984,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,19984,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,19985,0)
 ;;=I08.0^^84^928^16
 ;;^UTILITY(U,$J,358.3,19985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19985,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,19985,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,19985,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,19986,0)
 ;;=I09.89^^84^928^17
 ;;^UTILITY(U,$J,358.3,19986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19986,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,19986,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,19986,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,19987,0)
 ;;=I47.1^^84^928^24
 ;;^UTILITY(U,$J,358.3,19987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19987,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,19987,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,19987,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,19988,0)
 ;;=I48.0^^84^928^15
 ;;^UTILITY(U,$J,358.3,19988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19988,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,19988,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,19988,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,19989,0)
 ;;=I49.5^^84^928^23
 ;;^UTILITY(U,$J,358.3,19989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19989,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,19989,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,19989,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,19990,0)
 ;;=I49.8^^84^928^3
 ;;^UTILITY(U,$J,358.3,19990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19990,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,19990,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,19990,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,19991,0)
 ;;=I49.9^^84^928^2
 ;;^UTILITY(U,$J,358.3,19991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19991,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,19991,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,19991,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,19992,0)
 ;;=R00.1^^84^928^1
 ;;^UTILITY(U,$J,358.3,19992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19992,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,19992,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,19992,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,19993,0)
 ;;=I34.1^^84^928^14
 ;;^UTILITY(U,$J,358.3,19993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19993,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,19993,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,19993,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,19994,0)
 ;;=D68.4^^84^929^1
 ;;^UTILITY(U,$J,358.3,19994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19994,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,19994,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,19994,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,19995,0)
 ;;=D59.9^^84^929^2
 ;;^UTILITY(U,$J,358.3,19995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19995,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,19995,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,19995,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,19996,0)
 ;;=C91.00^^84^929^5
 ;;^UTILITY(U,$J,358.3,19996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19996,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
