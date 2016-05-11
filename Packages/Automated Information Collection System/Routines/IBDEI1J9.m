IBDEI1J9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26017,1,3,0)
 ;;=3^Tardive Akathisia/Medication-Induced Acute Akatisia
 ;;^UTILITY(U,$J,358.3,26017,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,26017,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,26018,0)
 ;;=G25.79^^98^1220^10
 ;;^UTILITY(U,$J,358.3,26018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26018,1,3,0)
 ;;=3^Medication-Induced Movement Disorder NEC
 ;;^UTILITY(U,$J,358.3,26018,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,26018,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,26019,0)
 ;;=T43.205A^^98^1220^4
 ;;^UTILITY(U,$J,358.3,26019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26019,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Init Encntr
 ;;^UTILITY(U,$J,358.3,26019,1,4,0)
 ;;=4^T43.205A
 ;;^UTILITY(U,$J,358.3,26019,2)
 ;;=^5050540
 ;;^UTILITY(U,$J,358.3,26020,0)
 ;;=T43.205D^^98^1220^5
 ;;^UTILITY(U,$J,358.3,26020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26020,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,26020,1,4,0)
 ;;=4^T43.205D
 ;;^UTILITY(U,$J,358.3,26020,2)
 ;;=^5050541
 ;;^UTILITY(U,$J,358.3,26021,0)
 ;;=T43.205S^^98^1220^6
 ;;^UTILITY(U,$J,358.3,26021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26021,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Sequela
 ;;^UTILITY(U,$J,358.3,26021,1,4,0)
 ;;=4^T43.205S
 ;;^UTILITY(U,$J,358.3,26021,2)
 ;;=^5050542
 ;;^UTILITY(U,$J,358.3,26022,0)
 ;;=G25.71^^98^1220^7
 ;;^UTILITY(U,$J,358.3,26022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26022,1,3,0)
 ;;=3^Medication-Induced Acute Akathisia
 ;;^UTILITY(U,$J,358.3,26022,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,26022,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,26023,0)
 ;;=G24.02^^98^1220^9
 ;;^UTILITY(U,$J,358.3,26023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26023,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,26023,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,26023,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,26024,0)
 ;;=G21.0^^98^1220^13
 ;;^UTILITY(U,$J,358.3,26024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26024,1,3,0)
 ;;=3^Neuroleptic Malignant Syndrome
 ;;^UTILITY(U,$J,358.3,26024,1,4,0)
 ;;=4^G21.0
 ;;^UTILITY(U,$J,358.3,26024,2)
 ;;=^5003771
 ;;^UTILITY(U,$J,358.3,26025,0)
 ;;=T50.905A^^98^1220^1
 ;;^UTILITY(U,$J,358.3,26025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26025,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Init Encntr
 ;;^UTILITY(U,$J,358.3,26025,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,26025,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,26026,0)
 ;;=T50.905D^^98^1220^3
 ;;^UTILITY(U,$J,358.3,26026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26026,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,26026,1,4,0)
 ;;=4^T50.905D
 ;;^UTILITY(U,$J,358.3,26026,2)
 ;;=^5052161
 ;;^UTILITY(U,$J,358.3,26027,0)
 ;;=T50.905S^^98^1220^2
 ;;^UTILITY(U,$J,358.3,26027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26027,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Sequela
 ;;^UTILITY(U,$J,358.3,26027,1,4,0)
 ;;=4^T50.905S
 ;;^UTILITY(U,$J,358.3,26027,2)
 ;;=^5052162
 ;;^UTILITY(U,$J,358.3,26028,0)
 ;;=F42.^^98^1221^7
 ;;^UTILITY(U,$J,358.3,26028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26028,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,26028,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,26028,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,26029,0)
 ;;=F45.22^^98^1221^1
 ;;^UTILITY(U,$J,358.3,26029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26029,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,26029,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,26029,2)
 ;;=^5003588
