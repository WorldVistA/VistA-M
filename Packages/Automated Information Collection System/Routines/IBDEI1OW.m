IBDEI1OW ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28729,1,1,0)
 ;;=1^Post Op Visit in Global
 ;;^UTILITY(U,$J,358.3,28729,1,2,0)
 ;;=2^99024
 ;;^UTILITY(U,$J,358.3,28730,0)
 ;;=99241^^114^1447^1
 ;;^UTILITY(U,$J,358.3,28730,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,28730,1,1,0)
 ;;=1^Prob Focused Exam
 ;;^UTILITY(U,$J,358.3,28730,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,28731,0)
 ;;=99242^^114^1447^2
 ;;^UTILITY(U,$J,358.3,28731,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,28731,1,1,0)
 ;;=1^Exp Prob Focused Exam
 ;;^UTILITY(U,$J,358.3,28731,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,28732,0)
 ;;=99243^^114^1447^3
 ;;^UTILITY(U,$J,358.3,28732,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,28732,1,1,0)
 ;;=1^Detailed Exam
 ;;^UTILITY(U,$J,358.3,28732,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,28733,0)
 ;;=99244^^114^1447^4
 ;;^UTILITY(U,$J,358.3,28733,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,28733,1,1,0)
 ;;=1^Comprehensive,Moderate
 ;;^UTILITY(U,$J,358.3,28733,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,28734,0)
 ;;=99245^^114^1447^5
 ;;^UTILITY(U,$J,358.3,28734,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,28734,1,1,0)
 ;;=1^Comprehensive,High
 ;;^UTILITY(U,$J,358.3,28734,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,28735,0)
 ;;=O01.9^^115^1448^16
 ;;^UTILITY(U,$J,358.3,28735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28735,1,3,0)
 ;;=3^Hydatidiform mole, unspecified
 ;;^UTILITY(U,$J,358.3,28735,1,4,0)
 ;;=4^O01.9
 ;;^UTILITY(U,$J,358.3,28735,2)
 ;;=^5015977
 ;;^UTILITY(U,$J,358.3,28736,0)
 ;;=O02.81^^115^1448^17
 ;;^UTILITY(U,$J,358.3,28736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28736,1,3,0)
 ;;=3^Inapprop chg quantitav hCG in early pregnancy
 ;;^UTILITY(U,$J,358.3,28736,1,4,0)
 ;;=4^O02.81
 ;;^UTILITY(U,$J,358.3,28736,2)
 ;;=^340611
 ;;^UTILITY(U,$J,358.3,28737,0)
 ;;=O02.1^^115^1448^18
 ;;^UTILITY(U,$J,358.3,28737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28737,1,3,0)
 ;;=3^Missed abortion
 ;;^UTILITY(U,$J,358.3,28737,1,4,0)
 ;;=4^O02.1
 ;;^UTILITY(U,$J,358.3,28737,2)
 ;;=^1259
 ;;^UTILITY(U,$J,358.3,28738,0)
 ;;=O00.8^^115^1448^15
 ;;^UTILITY(U,$J,358.3,28738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28738,1,3,0)
 ;;=3^Ectopic Pregnancy NEC
 ;;^UTILITY(U,$J,358.3,28738,1,4,0)
 ;;=4^O00.8
 ;;^UTILITY(U,$J,358.3,28738,2)
 ;;=^5015974
 ;;^UTILITY(U,$J,358.3,28739,0)
 ;;=O08.7^^115^1448^45
 ;;^UTILITY(U,$J,358.3,28739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28739,1,3,0)
 ;;=3^Venous comp following an ectopic and molar pregnancy NEC
 ;;^UTILITY(U,$J,358.3,28739,1,4,0)
 ;;=4^O08.7
 ;;^UTILITY(U,$J,358.3,28739,2)
 ;;=^5016042
 ;;^UTILITY(U,$J,358.3,28740,0)
 ;;=O08.81^^115^1448^13
 ;;^UTILITY(U,$J,358.3,28740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28740,1,3,0)
 ;;=3^Cardiac arrest following an ectopic and molar pregnancy
 ;;^UTILITY(U,$J,358.3,28740,1,4,0)
 ;;=4^O08.81
 ;;^UTILITY(U,$J,358.3,28740,2)
 ;;=^5016043
 ;;^UTILITY(U,$J,358.3,28741,0)
 ;;=O08.83^^115^1448^44
 ;;^UTILITY(U,$J,358.3,28741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28741,1,3,0)
 ;;=3^Urinary tract infection fol an ectopic and molar pregnancy
 ;;^UTILITY(U,$J,358.3,28741,1,4,0)
 ;;=4^O08.83
 ;;^UTILITY(U,$J,358.3,28741,2)
 ;;=^5016045
 ;;^UTILITY(U,$J,358.3,28742,0)
 ;;=O08.89^^115^1448^14
 ;;^UTILITY(U,$J,358.3,28742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28742,1,3,0)
 ;;=3^Complications following an ectopic and molar pregnancy NEC
 ;;^UTILITY(U,$J,358.3,28742,1,4,0)
 ;;=4^O08.89
 ;;^UTILITY(U,$J,358.3,28742,2)
 ;;=^5016046
 ;;^UTILITY(U,$J,358.3,28743,0)
 ;;=O20.0^^115^1448^43
 ;;^UTILITY(U,$J,358.3,28743,1,0)
 ;;=^358.31IA^4^2
