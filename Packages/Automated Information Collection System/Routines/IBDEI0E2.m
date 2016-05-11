IBDEI0E2 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6465,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,6466,0)
 ;;=I05.9^^30^395^20
 ;;^UTILITY(U,$J,358.3,6466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6466,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6466,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,6466,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,6467,0)
 ;;=I07.1^^30^395^21
 ;;^UTILITY(U,$J,358.3,6467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6467,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,6467,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,6467,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,6468,0)
 ;;=I07.9^^30^395^22
 ;;^UTILITY(U,$J,358.3,6468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6468,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,6468,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,6468,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,6469,0)
 ;;=I08.0^^30^395^16
 ;;^UTILITY(U,$J,358.3,6469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6469,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,6469,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,6469,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,6470,0)
 ;;=I09.89^^30^395^17
 ;;^UTILITY(U,$J,358.3,6470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6470,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,6470,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,6470,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,6471,0)
 ;;=I47.1^^30^395^24
 ;;^UTILITY(U,$J,358.3,6471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6471,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,6471,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,6471,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,6472,0)
 ;;=I48.0^^30^395^15
 ;;^UTILITY(U,$J,358.3,6472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6472,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,6472,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,6472,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,6473,0)
 ;;=I49.5^^30^395^23
 ;;^UTILITY(U,$J,358.3,6473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6473,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,6473,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,6473,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,6474,0)
 ;;=I49.8^^30^395^3
 ;;^UTILITY(U,$J,358.3,6474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6474,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,6474,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,6474,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,6475,0)
 ;;=I49.9^^30^395^2
 ;;^UTILITY(U,$J,358.3,6475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6475,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,6475,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,6475,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,6476,0)
 ;;=R00.1^^30^395^1
 ;;^UTILITY(U,$J,358.3,6476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6476,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,6476,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,6476,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,6477,0)
 ;;=I34.1^^30^395^14
 ;;^UTILITY(U,$J,358.3,6477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6477,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,6477,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,6477,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,6478,0)
 ;;=D68.4^^30^396^1
 ;;^UTILITY(U,$J,358.3,6478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6478,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,6478,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,6478,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,6479,0)
 ;;=D59.9^^30^396^2
 ;;^UTILITY(U,$J,358.3,6479,1,0)
 ;;=^358.31IA^4^2
