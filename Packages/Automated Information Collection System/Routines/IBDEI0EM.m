IBDEI0EM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6386,1,3,0)
 ;;=3^96125
 ;;^UTILITY(U,$J,358.3,6387,0)
 ;;=96105^^42^394^1^^^^1
 ;;^UTILITY(U,$J,358.3,6387,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6387,1,2,0)
 ;;=2^ASSESSMENT OF APHASIA INTERP & RPT
 ;;^UTILITY(U,$J,358.3,6387,1,3,0)
 ;;=3^96105
 ;;^UTILITY(U,$J,358.3,6388,0)
 ;;=96127^^42^394^2^^^^1
 ;;^UTILITY(U,$J,358.3,6388,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6388,1,2,0)
 ;;=2^BRF EMOTIONAL/BEHAV ASSESS-SCORING & DOCUMENT
 ;;^UTILITY(U,$J,358.3,6388,1,3,0)
 ;;=3^96127
 ;;^UTILITY(U,$J,358.3,6389,0)
 ;;=F10.96^^43^395^2
 ;;^UTILITY(U,$J,358.3,6389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6389,1,3,0)
 ;;=3^Alcohol-Induced Persisting Amnestic Disorder
 ;;^UTILITY(U,$J,358.3,6389,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,6389,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,6390,0)
 ;;=F10.27^^43^395^3
 ;;^UTILITY(U,$J,358.3,6390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6390,1,3,0)
 ;;=3^Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,6390,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,6390,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,6391,0)
 ;;=F10.951^^43^395^4
 ;;^UTILITY(U,$J,358.3,6391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6391,1,3,0)
 ;;=3^Alcohol-Induced Psychotic Disorder w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,6391,1,4,0)
 ;;=4^F10.951
 ;;^UTILITY(U,$J,358.3,6391,2)
 ;;=^5003106
 ;;^UTILITY(U,$J,358.3,6392,0)
 ;;=F10.231^^43^395^1
 ;;^UTILITY(U,$J,358.3,6392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6392,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,6392,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,6392,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,6393,0)
 ;;=F03.91^^43^396^2
 ;;^UTILITY(U,$J,358.3,6393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6393,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,6393,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,6393,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,6394,0)
 ;;=F03.90^^43^396^3
 ;;^UTILITY(U,$J,358.3,6394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6394,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,6394,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,6394,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,6395,0)
 ;;=F06.8^^43^396^4
 ;;^UTILITY(U,$J,358.3,6395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6395,1,3,0)
 ;;=3^Mental Disorders d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,6395,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,6395,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,6396,0)
 ;;=F03.90^^43^396^1
 ;;^UTILITY(U,$J,358.3,6396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6396,1,3,0)
 ;;=3^Delirium d/t Dementia w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,6396,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,6396,2)
 ;;=^5003050^F05.
 ;;^UTILITY(U,$J,358.3,6397,0)
 ;;=F01.51^^43^396^5
 ;;^UTILITY(U,$J,358.3,6397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6397,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,6397,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,6397,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,6398,0)
 ;;=F01.50^^43^396^6
 ;;^UTILITY(U,$J,358.3,6398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6398,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,6398,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,6398,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,6399,0)
 ;;=F19.921^^43^397^24
 ;;^UTILITY(U,$J,358.3,6399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6399,1,3,0)
 ;;=3^Psychoactive Subs Use w/ Intoxication Delirium Intoxication w/ Delirium
 ;;^UTILITY(U,$J,358.3,6399,1,4,0)
 ;;=4^F19.921
