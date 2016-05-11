IBDEI1F3 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24094,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,24094,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,24095,0)
 ;;=G25.71^^90^1046^15
 ;;^UTILITY(U,$J,358.3,24095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24095,1,3,0)
 ;;=3^Tardive Akathisia/Medication-Induced Acute Akatisia
 ;;^UTILITY(U,$J,358.3,24095,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,24095,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,24096,0)
 ;;=G25.79^^90^1046^10
 ;;^UTILITY(U,$J,358.3,24096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24096,1,3,0)
 ;;=3^Medication-Induced Movement Disorder NEC
 ;;^UTILITY(U,$J,358.3,24096,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,24096,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,24097,0)
 ;;=T43.205A^^90^1046^4
 ;;^UTILITY(U,$J,358.3,24097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24097,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Init Encntr
 ;;^UTILITY(U,$J,358.3,24097,1,4,0)
 ;;=4^T43.205A
 ;;^UTILITY(U,$J,358.3,24097,2)
 ;;=^5050540
 ;;^UTILITY(U,$J,358.3,24098,0)
 ;;=T43.205D^^90^1046^5
 ;;^UTILITY(U,$J,358.3,24098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24098,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,24098,1,4,0)
 ;;=4^T43.205D
 ;;^UTILITY(U,$J,358.3,24098,2)
 ;;=^5050541
 ;;^UTILITY(U,$J,358.3,24099,0)
 ;;=T43.205S^^90^1046^6
 ;;^UTILITY(U,$J,358.3,24099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24099,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Sequela
 ;;^UTILITY(U,$J,358.3,24099,1,4,0)
 ;;=4^T43.205S
 ;;^UTILITY(U,$J,358.3,24099,2)
 ;;=^5050542
 ;;^UTILITY(U,$J,358.3,24100,0)
 ;;=G25.71^^90^1046^7
 ;;^UTILITY(U,$J,358.3,24100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24100,1,3,0)
 ;;=3^Medication-Induced Acute Akathisia
 ;;^UTILITY(U,$J,358.3,24100,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,24100,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,24101,0)
 ;;=G24.02^^90^1046^9
 ;;^UTILITY(U,$J,358.3,24101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24101,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,24101,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,24101,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,24102,0)
 ;;=G21.0^^90^1046^13
 ;;^UTILITY(U,$J,358.3,24102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24102,1,3,0)
 ;;=3^Neuroleptic Malignant Syndrome
 ;;^UTILITY(U,$J,358.3,24102,1,4,0)
 ;;=4^G21.0
 ;;^UTILITY(U,$J,358.3,24102,2)
 ;;=^5003771
 ;;^UTILITY(U,$J,358.3,24103,0)
 ;;=T50.905A^^90^1046^1
 ;;^UTILITY(U,$J,358.3,24103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24103,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Init Encntr
 ;;^UTILITY(U,$J,358.3,24103,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,24103,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,24104,0)
 ;;=T50.905D^^90^1046^3
 ;;^UTILITY(U,$J,358.3,24104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24104,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,24104,1,4,0)
 ;;=4^T50.905D
 ;;^UTILITY(U,$J,358.3,24104,2)
 ;;=^5052161
 ;;^UTILITY(U,$J,358.3,24105,0)
 ;;=T50.905S^^90^1046^2
 ;;^UTILITY(U,$J,358.3,24105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24105,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Sequela
 ;;^UTILITY(U,$J,358.3,24105,1,4,0)
 ;;=4^T50.905S
 ;;^UTILITY(U,$J,358.3,24105,2)
 ;;=^5052162
 ;;^UTILITY(U,$J,358.3,24106,0)
 ;;=F42.^^90^1047^7
 ;;^UTILITY(U,$J,358.3,24106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24106,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,24106,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,24106,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,24107,0)
 ;;=F45.22^^90^1047^1
