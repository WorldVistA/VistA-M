IBDEI28X ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38103,1,3,0)
 ;;=3^Tardive Dystonia
 ;;^UTILITY(U,$J,358.3,38103,1,4,0)
 ;;=4^G24.09
 ;;^UTILITY(U,$J,358.3,38103,2)
 ;;=^5003786
 ;;^UTILITY(U,$J,358.3,38104,0)
 ;;=G25.1^^145^1839^12
 ;;^UTILITY(U,$J,358.3,38104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38104,1,3,0)
 ;;=3^Medication-Induced Postural Tremor
 ;;^UTILITY(U,$J,358.3,38104,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,38104,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,38105,0)
 ;;=G25.71^^145^1839^15
 ;;^UTILITY(U,$J,358.3,38105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38105,1,3,0)
 ;;=3^Tardive Akathisia/Medication-Induced Acute Akatisia
 ;;^UTILITY(U,$J,358.3,38105,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,38105,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,38106,0)
 ;;=G25.79^^145^1839^10
 ;;^UTILITY(U,$J,358.3,38106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38106,1,3,0)
 ;;=3^Medication-Induced Movement Disorder NEC
 ;;^UTILITY(U,$J,358.3,38106,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,38106,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,38107,0)
 ;;=T43.205A^^145^1839^4
 ;;^UTILITY(U,$J,358.3,38107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38107,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Init Encntr
 ;;^UTILITY(U,$J,358.3,38107,1,4,0)
 ;;=4^T43.205A
 ;;^UTILITY(U,$J,358.3,38107,2)
 ;;=^5050540
 ;;^UTILITY(U,$J,358.3,38108,0)
 ;;=T43.205D^^145^1839^5
 ;;^UTILITY(U,$J,358.3,38108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38108,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,38108,1,4,0)
 ;;=4^T43.205D
 ;;^UTILITY(U,$J,358.3,38108,2)
 ;;=^5050541
 ;;^UTILITY(U,$J,358.3,38109,0)
 ;;=T43.205S^^145^1839^6
 ;;^UTILITY(U,$J,358.3,38109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38109,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Sequela
 ;;^UTILITY(U,$J,358.3,38109,1,4,0)
 ;;=4^T43.205S
 ;;^UTILITY(U,$J,358.3,38109,2)
 ;;=^5050542
 ;;^UTILITY(U,$J,358.3,38110,0)
 ;;=G25.71^^145^1839^7
 ;;^UTILITY(U,$J,358.3,38110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38110,1,3,0)
 ;;=3^Medication-Induced Acute Akathisia
 ;;^UTILITY(U,$J,358.3,38110,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,38110,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,38111,0)
 ;;=G24.02^^145^1839^9
 ;;^UTILITY(U,$J,358.3,38111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38111,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,38111,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,38111,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,38112,0)
 ;;=G21.0^^145^1839^13
 ;;^UTILITY(U,$J,358.3,38112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38112,1,3,0)
 ;;=3^Neuroleptic Malignant Syndrome
 ;;^UTILITY(U,$J,358.3,38112,1,4,0)
 ;;=4^G21.0
 ;;^UTILITY(U,$J,358.3,38112,2)
 ;;=^5003771
 ;;^UTILITY(U,$J,358.3,38113,0)
 ;;=T50.905A^^145^1839^1
 ;;^UTILITY(U,$J,358.3,38113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38113,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Init Encntr
 ;;^UTILITY(U,$J,358.3,38113,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,38113,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,38114,0)
 ;;=T50.905D^^145^1839^3
 ;;^UTILITY(U,$J,358.3,38114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38114,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,38114,1,4,0)
 ;;=4^T50.905D
 ;;^UTILITY(U,$J,358.3,38114,2)
 ;;=^5052161
 ;;^UTILITY(U,$J,358.3,38115,0)
 ;;=T50.905S^^145^1839^2
 ;;^UTILITY(U,$J,358.3,38115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38115,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Sequela
