IBDEI1JA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25635,1,4,0)
 ;;=4^F11.24
 ;;^UTILITY(U,$J,358.3,25635,2)
 ;;=^5003134
 ;;^UTILITY(U,$J,358.3,25636,0)
 ;;=F11.29^^124^1254^2
 ;;^UTILITY(U,$J,358.3,25636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25636,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,25636,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,25636,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,25637,0)
 ;;=F11.220^^124^1254^1
 ;;^UTILITY(U,$J,358.3,25637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25637,1,3,0)
 ;;=3^Opioid Dependence w/ Intoxication,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25637,1,4,0)
 ;;=4^F11.220
 ;;^UTILITY(U,$J,358.3,25637,2)
 ;;=^5003129
 ;;^UTILITY(U,$J,358.3,25638,0)
 ;;=F19.10^^124^1255^3
 ;;^UTILITY(U,$J,358.3,25638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25638,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25638,1,4,0)
 ;;=4^F19.10
 ;;^UTILITY(U,$J,358.3,25638,2)
 ;;=^5003416
 ;;^UTILITY(U,$J,358.3,25639,0)
 ;;=F19.14^^124^1255^1
 ;;^UTILITY(U,$J,358.3,25639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25639,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,25639,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,25639,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,25640,0)
 ;;=F19.182^^124^1255^2
 ;;^UTILITY(U,$J,358.3,25640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25640,1,3,0)
 ;;=3^Psychoactive Substance Abuse NEC w/ Induced Sleep Disorder
 ;;^UTILITY(U,$J,358.3,25640,1,4,0)
 ;;=4^F19.182
 ;;^UTILITY(U,$J,358.3,25640,2)
 ;;=^5003429
 ;;^UTILITY(U,$J,358.3,25641,0)
 ;;=F19.20^^124^1255^6
 ;;^UTILITY(U,$J,358.3,25641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25641,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,Uncomplicated
 ;;^UTILITY(U,$J,358.3,25641,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,25641,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,25642,0)
 ;;=F19.21^^124^1255^5
 ;;^UTILITY(U,$J,358.3,25642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25642,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC,In Remission
 ;;^UTILITY(U,$J,358.3,25642,1,4,0)
 ;;=4^F19.21
 ;;^UTILITY(U,$J,358.3,25642,2)
 ;;=^5003432
 ;;^UTILITY(U,$J,358.3,25643,0)
 ;;=F19.24^^124^1255^4
 ;;^UTILITY(U,$J,358.3,25643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25643,1,3,0)
 ;;=3^Psychoactive Substance Dependence NEC w/ Induced Mood Disorder
 ;;^UTILITY(U,$J,358.3,25643,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,25643,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,25644,0)
 ;;=F13.10^^124^1256^1
 ;;^UTILITY(U,$J,358.3,25644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25644,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,25644,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,25644,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,25645,0)
 ;;=F13.14^^124^1256^7
 ;;^UTILITY(U,$J,358.3,25645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25645,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Depressive,Bipolar or Related Disorder w/ Mild use Disorder
 ;;^UTILITY(U,$J,358.3,25645,1,4,0)
 ;;=4^F13.14
 ;;^UTILITY(U,$J,358.3,25645,2)
 ;;=^5003193
 ;;^UTILITY(U,$J,358.3,25646,0)
 ;;=F13.182^^124^1256^8
 ;;^UTILITY(U,$J,358.3,25646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25646,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25646,1,4,0)
 ;;=4^F13.182
 ;;^UTILITY(U,$J,358.3,25646,2)
 ;;=^5003199
 ;;^UTILITY(U,$J,358.3,25647,0)
 ;;=F13.20^^124^1256^2
 ;;^UTILITY(U,$J,358.3,25647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25647,1,3,0)
 ;;=3^Sedative,Hypnotic or Anxiolytic Use Disorder,Moderate-Severe
