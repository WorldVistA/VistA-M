IBDEI1HQ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25300,0)
 ;;=G25.1^^95^1150^12
 ;;^UTILITY(U,$J,358.3,25300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25300,1,3,0)
 ;;=3^Medication-Induced Postural Tremor
 ;;^UTILITY(U,$J,358.3,25300,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,25300,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,25301,0)
 ;;=G25.71^^95^1150^15
 ;;^UTILITY(U,$J,358.3,25301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25301,1,3,0)
 ;;=3^Tardive Akathisia/Medication-Induced Acute Akatisia
 ;;^UTILITY(U,$J,358.3,25301,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,25301,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,25302,0)
 ;;=G25.79^^95^1150^10
 ;;^UTILITY(U,$J,358.3,25302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25302,1,3,0)
 ;;=3^Medication-Induced Movement Disorder NEC
 ;;^UTILITY(U,$J,358.3,25302,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,25302,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,25303,0)
 ;;=T43.205A^^95^1150^4
 ;;^UTILITY(U,$J,358.3,25303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25303,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Init Encntr
 ;;^UTILITY(U,$J,358.3,25303,1,4,0)
 ;;=4^T43.205A
 ;;^UTILITY(U,$J,358.3,25303,2)
 ;;=^5050540
 ;;^UTILITY(U,$J,358.3,25304,0)
 ;;=T43.205D^^95^1150^5
 ;;^UTILITY(U,$J,358.3,25304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25304,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,25304,1,4,0)
 ;;=4^T43.205D
 ;;^UTILITY(U,$J,358.3,25304,2)
 ;;=^5050541
 ;;^UTILITY(U,$J,358.3,25305,0)
 ;;=T43.205S^^95^1150^6
 ;;^UTILITY(U,$J,358.3,25305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25305,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Sequela
 ;;^UTILITY(U,$J,358.3,25305,1,4,0)
 ;;=4^T43.205S
 ;;^UTILITY(U,$J,358.3,25305,2)
 ;;=^5050542
 ;;^UTILITY(U,$J,358.3,25306,0)
 ;;=G25.71^^95^1150^7
 ;;^UTILITY(U,$J,358.3,25306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25306,1,3,0)
 ;;=3^Medication-Induced Acute Akathisia
 ;;^UTILITY(U,$J,358.3,25306,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,25306,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,25307,0)
 ;;=G24.02^^95^1150^9
 ;;^UTILITY(U,$J,358.3,25307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25307,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,25307,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,25307,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,25308,0)
 ;;=G21.0^^95^1150^13
 ;;^UTILITY(U,$J,358.3,25308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25308,1,3,0)
 ;;=3^Neuroleptic Malignant Syndrome
 ;;^UTILITY(U,$J,358.3,25308,1,4,0)
 ;;=4^G21.0
 ;;^UTILITY(U,$J,358.3,25308,2)
 ;;=^5003771
 ;;^UTILITY(U,$J,358.3,25309,0)
 ;;=T50.905A^^95^1150^1
 ;;^UTILITY(U,$J,358.3,25309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25309,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Init Encntr
 ;;^UTILITY(U,$J,358.3,25309,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,25309,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,25310,0)
 ;;=T50.905D^^95^1150^3
 ;;^UTILITY(U,$J,358.3,25310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25310,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,25310,1,4,0)
 ;;=4^T50.905D
 ;;^UTILITY(U,$J,358.3,25310,2)
 ;;=^5052161
 ;;^UTILITY(U,$J,358.3,25311,0)
 ;;=T50.905S^^95^1150^2
 ;;^UTILITY(U,$J,358.3,25311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25311,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Sequela
 ;;^UTILITY(U,$J,358.3,25311,1,4,0)
 ;;=4^T50.905S
 ;;^UTILITY(U,$J,358.3,25311,2)
 ;;=^5052162
 ;;^UTILITY(U,$J,358.3,25312,0)
 ;;=F42.^^95^1151^7
 ;;^UTILITY(U,$J,358.3,25312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25312,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
