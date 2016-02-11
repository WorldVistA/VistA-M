IBDEI1XK ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32319,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,32319,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,32320,0)
 ;;=F31.5^^143^1519^13
 ;;^UTILITY(U,$J,358.3,32320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32320,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,32320,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,32320,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,32321,0)
 ;;=F31.75^^143^1519^14
 ;;^UTILITY(U,$J,358.3,32321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32321,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,32321,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,32321,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,32322,0)
 ;;=F31.76^^143^1519^15
 ;;^UTILITY(U,$J,358.3,32322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32322,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,32322,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,32322,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,32323,0)
 ;;=F31.9^^143^1519^16
 ;;^UTILITY(U,$J,358.3,32323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32323,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,32323,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,32323,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,32324,0)
 ;;=F31.81^^143^1519^17
 ;;^UTILITY(U,$J,358.3,32324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32324,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,32324,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,32324,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,32325,0)
 ;;=F34.0^^143^1519^18
 ;;^UTILITY(U,$J,358.3,32325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32325,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,32325,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,32325,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,32326,0)
 ;;=F10.232^^143^1520^2
 ;;^UTILITY(U,$J,358.3,32326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32326,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,32326,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,32326,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,32327,0)
 ;;=F10.231^^143^1520^3
 ;;^UTILITY(U,$J,358.3,32327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32327,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,32327,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,32327,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,32328,0)
 ;;=F10.121^^143^1520^6
 ;;^UTILITY(U,$J,358.3,32328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32328,1,3,0)
 ;;=3^Mild Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,32328,1,4,0)
 ;;=4^F10.121
 ;;^UTILITY(U,$J,358.3,32328,2)
 ;;=^5003070
 ;;^UTILITY(U,$J,358.3,32329,0)
 ;;=F10.221^^143^1520^7
 ;;^UTILITY(U,$J,358.3,32329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32329,1,3,0)
 ;;=3^Moderate/Severe Alcohol Use Disorder w/ Intoxication Delirium
 ;;^UTILITY(U,$J,358.3,32329,1,4,0)
 ;;=4^F10.221
 ;;^UTILITY(U,$J,358.3,32329,2)
 ;;=^5003084
 ;;^UTILITY(U,$J,358.3,32330,0)
 ;;=F10.921^^143^1520^1
 ;;^UTILITY(U,$J,358.3,32330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32330,1,3,0)
 ;;=3^Alcohol Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,32330,1,4,0)
 ;;=4^F10.921
 ;;^UTILITY(U,$J,358.3,32330,2)
 ;;=^5003102
 ;;^UTILITY(U,$J,358.3,32331,0)
 ;;=F05.^^143^1520^4
 ;;^UTILITY(U,$J,358.3,32331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32331,1,3,0)
 ;;=3^Delirium d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,32331,1,4,0)
 ;;=4^F05.
