IBDEI15L ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18544,1,3,0)
 ;;=3^Tardive Akathisia
 ;;^UTILITY(U,$J,358.3,18544,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,18544,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,18545,0)
 ;;=G25.79^^91^945^9
 ;;^UTILITY(U,$J,358.3,18545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18545,1,3,0)
 ;;=3^Medication-Induced Movement Disorder,Other
 ;;^UTILITY(U,$J,358.3,18545,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,18545,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,18546,0)
 ;;=T43.205A^^91^945^4
 ;;^UTILITY(U,$J,358.3,18546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18546,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Init Encntr
 ;;^UTILITY(U,$J,358.3,18546,1,4,0)
 ;;=4^T43.205A
 ;;^UTILITY(U,$J,358.3,18546,2)
 ;;=^5050540
 ;;^UTILITY(U,$J,358.3,18547,0)
 ;;=T43.205D^^91^945^5
 ;;^UTILITY(U,$J,358.3,18547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18547,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,18547,1,4,0)
 ;;=4^T43.205D
 ;;^UTILITY(U,$J,358.3,18547,2)
 ;;=^5050541
 ;;^UTILITY(U,$J,358.3,18548,0)
 ;;=T43.205S^^91^945^6
 ;;^UTILITY(U,$J,358.3,18548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18548,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Sequela
 ;;^UTILITY(U,$J,358.3,18548,1,4,0)
 ;;=4^T43.205S
 ;;^UTILITY(U,$J,358.3,18548,2)
 ;;=^5050542
 ;;^UTILITY(U,$J,358.3,18549,0)
 ;;=G25.71^^91^945^7
 ;;^UTILITY(U,$J,358.3,18549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18549,1,3,0)
 ;;=3^Medication-Induced Acute Akathisia
 ;;^UTILITY(U,$J,358.3,18549,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,18549,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,18550,0)
 ;;=G24.02^^91^945^8
 ;;^UTILITY(U,$J,358.3,18550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18550,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,18550,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,18550,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,18551,0)
 ;;=G21.0^^91^945^12
 ;;^UTILITY(U,$J,358.3,18551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18551,1,3,0)
 ;;=3^Neuroleptic Malignant Syndrome
 ;;^UTILITY(U,$J,358.3,18551,1,4,0)
 ;;=4^G21.0
 ;;^UTILITY(U,$J,358.3,18551,2)
 ;;=^5003771
 ;;^UTILITY(U,$J,358.3,18552,0)
 ;;=T50.905A^^91^945^1
 ;;^UTILITY(U,$J,358.3,18552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18552,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Init Encntr
 ;;^UTILITY(U,$J,358.3,18552,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,18552,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,18553,0)
 ;;=T50.905S^^91^945^2
 ;;^UTILITY(U,$J,358.3,18553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18553,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Sequela
 ;;^UTILITY(U,$J,358.3,18553,1,4,0)
 ;;=4^T50.905S
 ;;^UTILITY(U,$J,358.3,18553,2)
 ;;=^5052162
 ;;^UTILITY(U,$J,358.3,18554,0)
 ;;=T50.905D^^91^945^3
 ;;^UTILITY(U,$J,358.3,18554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18554,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,18554,1,4,0)
 ;;=4^T50.905D
 ;;^UTILITY(U,$J,358.3,18554,2)
 ;;=^5052161
 ;;^UTILITY(U,$J,358.3,18555,0)
 ;;=F45.22^^91^946^1
 ;;^UTILITY(U,$J,358.3,18555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18555,1,3,0)
 ;;=3^Body Dysmorphic D/O
 ;;^UTILITY(U,$J,358.3,18555,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,18555,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,18556,0)
 ;;=F63.3^^91^946^8
 ;;^UTILITY(U,$J,358.3,18556,1,0)
 ;;=^358.31IA^4^2
