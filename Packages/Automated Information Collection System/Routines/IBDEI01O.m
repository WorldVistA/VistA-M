IBDEI01O ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,286,1,4,0)
 ;;=4^G21.11
 ;;^UTILITY(U,$J,358.3,286,2)
 ;;=^5003772
 ;;^UTILITY(U,$J,358.3,287,0)
 ;;=G24.02^^3^34^8
 ;;^UTILITY(U,$J,358.3,287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,287,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,287,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,287,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,288,0)
 ;;=G24.01^^3^34^16
 ;;^UTILITY(U,$J,358.3,288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,288,1,3,0)
 ;;=3^Tardive Dyskinesia
 ;;^UTILITY(U,$J,358.3,288,1,4,0)
 ;;=4^G24.01
 ;;^UTILITY(U,$J,358.3,288,2)
 ;;=^5003784
 ;;^UTILITY(U,$J,358.3,289,0)
 ;;=G24.09^^3^34^17
 ;;^UTILITY(U,$J,358.3,289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,289,1,3,0)
 ;;=3^Tardive Dystonia
 ;;^UTILITY(U,$J,358.3,289,1,4,0)
 ;;=4^G24.09
 ;;^UTILITY(U,$J,358.3,289,2)
 ;;=^5003786
 ;;^UTILITY(U,$J,358.3,290,0)
 ;;=G25.1^^3^34^12
 ;;^UTILITY(U,$J,358.3,290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,290,1,3,0)
 ;;=3^Medication-Induced Postural Tremor
 ;;^UTILITY(U,$J,358.3,290,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,290,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,291,0)
 ;;=G25.71^^3^34^15
 ;;^UTILITY(U,$J,358.3,291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,291,1,3,0)
 ;;=3^Tardive Akathisia/Medication-Induced Acute Akatisia
 ;;^UTILITY(U,$J,358.3,291,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,291,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,292,0)
 ;;=G25.79^^3^34^10
 ;;^UTILITY(U,$J,358.3,292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,292,1,3,0)
 ;;=3^Medication-Induced Movement Disorder NEC
 ;;^UTILITY(U,$J,358.3,292,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,292,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,293,0)
 ;;=T43.205A^^3^34^4
 ;;^UTILITY(U,$J,358.3,293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,293,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Init Encntr
 ;;^UTILITY(U,$J,358.3,293,1,4,0)
 ;;=4^T43.205A
 ;;^UTILITY(U,$J,358.3,293,2)
 ;;=^5050540
 ;;^UTILITY(U,$J,358.3,294,0)
 ;;=T43.205D^^3^34^5
 ;;^UTILITY(U,$J,358.3,294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,294,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,294,1,4,0)
 ;;=4^T43.205D
 ;;^UTILITY(U,$J,358.3,294,2)
 ;;=^5050541
 ;;^UTILITY(U,$J,358.3,295,0)
 ;;=T43.205S^^3^34^6
 ;;^UTILITY(U,$J,358.3,295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,295,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Sequela
 ;;^UTILITY(U,$J,358.3,295,1,4,0)
 ;;=4^T43.205S
 ;;^UTILITY(U,$J,358.3,295,2)
 ;;=^5050542
 ;;^UTILITY(U,$J,358.3,296,0)
 ;;=G25.71^^3^34^7
 ;;^UTILITY(U,$J,358.3,296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,296,1,3,0)
 ;;=3^Medication-Induced Acute Akathisia
 ;;^UTILITY(U,$J,358.3,296,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,296,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,297,0)
 ;;=G24.02^^3^34^9
 ;;^UTILITY(U,$J,358.3,297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,297,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,297,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,297,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,298,0)
 ;;=G21.0^^3^34^13
 ;;^UTILITY(U,$J,358.3,298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,298,1,3,0)
 ;;=3^Neuroleptic Malignant Syndrome
 ;;^UTILITY(U,$J,358.3,298,1,4,0)
 ;;=4^G21.0
 ;;^UTILITY(U,$J,358.3,298,2)
 ;;=^5003771
 ;;^UTILITY(U,$J,358.3,299,0)
 ;;=T50.905A^^3^34^1
 ;;^UTILITY(U,$J,358.3,299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,299,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Init Encntr
 ;;^UTILITY(U,$J,358.3,299,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,299,2)
 ;;=^5052160
