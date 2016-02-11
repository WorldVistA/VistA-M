IBDEI03V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1103,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,1103,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,1104,0)
 ;;=N28.9^^12^128^2
 ;;^UTILITY(U,$J,358.3,1104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1104,1,3,0)
 ;;=3^Kidney & Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1104,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,1104,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,1105,0)
 ;;=R53.81^^12^129^1
 ;;^UTILITY(U,$J,358.3,1105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1105,1,3,0)
 ;;=3^Malaise,Other
 ;;^UTILITY(U,$J,358.3,1105,1,4,0)
 ;;=4^R53.81
 ;;^UTILITY(U,$J,358.3,1105,2)
 ;;=^5019518
 ;;^UTILITY(U,$J,358.3,1106,0)
 ;;=N52.9^^12^129^2
 ;;^UTILITY(U,$J,358.3,1106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1106,1,3,0)
 ;;=3^Male Erectile Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,1106,1,4,0)
 ;;=4^N52.9
 ;;^UTILITY(U,$J,358.3,1106,2)
 ;;=^5015763
 ;;^UTILITY(U,$J,358.3,1107,0)
 ;;=E46.^^12^129^3
 ;;^UTILITY(U,$J,358.3,1107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1107,1,3,0)
 ;;=3^Malnutrition,Protein-Calorie,Unspec
 ;;^UTILITY(U,$J,358.3,1107,1,4,0)
 ;;=4^E46.
 ;;^UTILITY(U,$J,358.3,1107,2)
 ;;=^5002790
 ;;^UTILITY(U,$J,358.3,1108,0)
 ;;=I21.3^^12^129^9
 ;;^UTILITY(U,$J,358.3,1108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1108,1,3,0)
 ;;=3^Myocardial Infarction (STEMI) Unspec Site
 ;;^UTILITY(U,$J,358.3,1108,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,1108,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,1109,0)
 ;;=G43.909^^12^129^6
 ;;^UTILITY(U,$J,358.3,1109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1109,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus
 ;;^UTILITY(U,$J,358.3,1109,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,1109,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,1110,0)
 ;;=Z00.00^^12^129^4
 ;;^UTILITY(U,$J,358.3,1110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1110,1,3,0)
 ;;=3^Medical Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,1110,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,1110,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,1111,0)
 ;;=G35.^^12^129^7
 ;;^UTILITY(U,$J,358.3,1111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1111,1,3,0)
 ;;=3^Multiple Sclerosis
 ;;^UTILITY(U,$J,358.3,1111,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,1111,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,1112,0)
 ;;=M79.1^^12^129^8
 ;;^UTILITY(U,$J,358.3,1112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1112,1,3,0)
 ;;=3^Myalgia
 ;;^UTILITY(U,$J,358.3,1112,1,4,0)
 ;;=4^M79.1
 ;;^UTILITY(U,$J,358.3,1112,2)
 ;;=^5013321
 ;;^UTILITY(U,$J,358.3,1113,0)
 ;;=I25.2^^12^129^10
 ;;^UTILITY(U,$J,358.3,1113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1113,1,3,0)
 ;;=3^Myocardial Infarction,Old
 ;;^UTILITY(U,$J,358.3,1113,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,1113,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,1114,0)
 ;;=R35.0^^12^129^5
 ;;^UTILITY(U,$J,358.3,1114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1114,1,3,0)
 ;;=3^Mictrurition Frequency
 ;;^UTILITY(U,$J,358.3,1114,1,4,0)
 ;;=4^R35.0
 ;;^UTILITY(U,$J,358.3,1114,2)
 ;;=^5019334
 ;;^UTILITY(U,$J,358.3,1115,0)
 ;;=I35.0^^12^130^8
 ;;^UTILITY(U,$J,358.3,1115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1115,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,1115,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,1115,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,1116,0)
 ;;=I35.2^^12^130^9
 ;;^UTILITY(U,$J,358.3,1116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1116,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,1116,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,1116,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,1117,0)
 ;;=D47.4^^12^130^17
