IBDEI0X0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15487,0)
 ;;=G21.11^^58^669^14
 ;;^UTILITY(U,$J,358.3,15487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15487,1,3,0)
 ;;=3^Neuroleptic-Induced Parkinsonism
 ;;^UTILITY(U,$J,358.3,15487,1,4,0)
 ;;=4^G21.11
 ;;^UTILITY(U,$J,358.3,15487,2)
 ;;=^5003772
 ;;^UTILITY(U,$J,358.3,15488,0)
 ;;=G24.02^^58^669^8
 ;;^UTILITY(U,$J,358.3,15488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15488,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,15488,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,15488,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,15489,0)
 ;;=G24.01^^58^669^16
 ;;^UTILITY(U,$J,358.3,15489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15489,1,3,0)
 ;;=3^Tardive Dyskinesia
 ;;^UTILITY(U,$J,358.3,15489,1,4,0)
 ;;=4^G24.01
 ;;^UTILITY(U,$J,358.3,15489,2)
 ;;=^5003784
 ;;^UTILITY(U,$J,358.3,15490,0)
 ;;=G24.09^^58^669^17
 ;;^UTILITY(U,$J,358.3,15490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15490,1,3,0)
 ;;=3^Tardive Dystonia
 ;;^UTILITY(U,$J,358.3,15490,1,4,0)
 ;;=4^G24.09
 ;;^UTILITY(U,$J,358.3,15490,2)
 ;;=^5003786
 ;;^UTILITY(U,$J,358.3,15491,0)
 ;;=G25.1^^58^669^12
 ;;^UTILITY(U,$J,358.3,15491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15491,1,3,0)
 ;;=3^Medication-Induced Postural Tremor
 ;;^UTILITY(U,$J,358.3,15491,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,15491,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,15492,0)
 ;;=G25.71^^58^669^15
 ;;^UTILITY(U,$J,358.3,15492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15492,1,3,0)
 ;;=3^Tardive Akathisia/Medication-Induced Acute Akatisia
 ;;^UTILITY(U,$J,358.3,15492,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,15492,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,15493,0)
 ;;=G25.79^^58^669^10
 ;;^UTILITY(U,$J,358.3,15493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15493,1,3,0)
 ;;=3^Medication-Induced Movement Disorder NEC
 ;;^UTILITY(U,$J,358.3,15493,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,15493,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,15494,0)
 ;;=T43.205A^^58^669^4
 ;;^UTILITY(U,$J,358.3,15494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15494,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Init Encntr
 ;;^UTILITY(U,$J,358.3,15494,1,4,0)
 ;;=4^T43.205A
 ;;^UTILITY(U,$J,358.3,15494,2)
 ;;=^5050540
 ;;^UTILITY(U,$J,358.3,15495,0)
 ;;=T43.205D^^58^669^5
 ;;^UTILITY(U,$J,358.3,15495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15495,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,15495,1,4,0)
 ;;=4^T43.205D
 ;;^UTILITY(U,$J,358.3,15495,2)
 ;;=^5050541
 ;;^UTILITY(U,$J,358.3,15496,0)
 ;;=T43.205S^^58^669^6
 ;;^UTILITY(U,$J,358.3,15496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15496,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Sequela
 ;;^UTILITY(U,$J,358.3,15496,1,4,0)
 ;;=4^T43.205S
 ;;^UTILITY(U,$J,358.3,15496,2)
 ;;=^5050542
 ;;^UTILITY(U,$J,358.3,15497,0)
 ;;=G25.71^^58^669^7
 ;;^UTILITY(U,$J,358.3,15497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15497,1,3,0)
 ;;=3^Medication-Induced Acute Akathisia
 ;;^UTILITY(U,$J,358.3,15497,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,15497,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,15498,0)
 ;;=G24.02^^58^669^9
 ;;^UTILITY(U,$J,358.3,15498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15498,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,15498,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,15498,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,15499,0)
 ;;=G21.0^^58^669^13
 ;;^UTILITY(U,$J,358.3,15499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15499,1,3,0)
 ;;=3^Neuroleptic Malignant Syndrome
 ;;^UTILITY(U,$J,358.3,15499,1,4,0)
 ;;=4^G21.0
