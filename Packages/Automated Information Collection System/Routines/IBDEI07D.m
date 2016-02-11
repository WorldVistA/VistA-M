IBDEI07D ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2873,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,2873,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,2874,0)
 ;;=G31.01^^28^243^34
 ;;^UTILITY(U,$J,358.3,2874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2874,1,3,0)
 ;;=3^Dementia,Pick's Disease
 ;;^UTILITY(U,$J,358.3,2874,1,4,0)
 ;;=4^G31.01
 ;;^UTILITY(U,$J,358.3,2874,2)
 ;;=^329915
 ;;^UTILITY(U,$J,358.3,2875,0)
 ;;=A81.2^^28^243^35
 ;;^UTILITY(U,$J,358.3,2875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2875,1,3,0)
 ;;=3^Dementia,Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,2875,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,2875,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,2876,0)
 ;;=G31.1^^28^243^36
 ;;^UTILITY(U,$J,358.3,2876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2876,1,3,0)
 ;;=3^Dementia,Senile Degeneration of Brain NEC
 ;;^UTILITY(U,$J,358.3,2876,1,4,0)
 ;;=4^G31.1
 ;;^UTILITY(U,$J,358.3,2876,2)
 ;;=^5003809
 ;;^UTILITY(U,$J,358.3,2877,0)
 ;;=F03.90^^28^243^21
 ;;^UTILITY(U,$J,358.3,2877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2877,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,2877,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,2877,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,2878,0)
 ;;=F03.91^^28^243^18
 ;;^UTILITY(U,$J,358.3,2878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2878,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,2878,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,2878,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,2879,0)
 ;;=F01.51^^28^243^37
 ;;^UTILITY(U,$J,358.3,2879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2879,1,3,0)
 ;;=3^Dementia,Vascular w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,2879,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,2879,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,2880,0)
 ;;=F01.50^^28^243^38
 ;;^UTILITY(U,$J,358.3,2880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2880,1,3,0)
 ;;=3^Dementia,Vascular w/o Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,2880,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,2880,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,2881,0)
 ;;=R42.^^28^243^39
 ;;^UTILITY(U,$J,358.3,2881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2881,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,2881,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,2881,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,2882,0)
 ;;=R45.86^^28^243^40
 ;;^UTILITY(U,$J,358.3,2882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2882,1,3,0)
 ;;=3^Emotional Lability
 ;;^UTILITY(U,$J,358.3,2882,1,4,0)
 ;;=4^R45.86
 ;;^UTILITY(U,$J,358.3,2882,2)
 ;;=^5019475
 ;;^UTILITY(U,$J,358.3,2883,0)
 ;;=R44.3^^28^243^43
 ;;^UTILITY(U,$J,358.3,2883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2883,1,3,0)
 ;;=3^Hallucinations,Unspec
 ;;^UTILITY(U,$J,358.3,2883,1,4,0)
 ;;=4^R44.3
 ;;^UTILITY(U,$J,358.3,2883,2)
 ;;=^5019458
 ;;^UTILITY(U,$J,358.3,2884,0)
 ;;=R46.0^^28^243^46
 ;;^UTILITY(U,$J,358.3,2884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2884,1,3,0)
 ;;=3^Hygiene,Personal,Very Low Level
 ;;^UTILITY(U,$J,358.3,2884,1,4,0)
 ;;=4^R46.0
 ;;^UTILITY(U,$J,358.3,2884,2)
 ;;=^5019478
 ;;^UTILITY(U,$J,358.3,2885,0)
 ;;=Z91.83^^28^243^52
 ;;^UTILITY(U,$J,358.3,2885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2885,1,3,0)
 ;;=3^Personal Hx of Wandering
 ;;^UTILITY(U,$J,358.3,2885,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,2885,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,2886,0)
 ;;=A81.9^^28^243^6
 ;;^UTILITY(U,$J,358.3,2886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2886,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,2886,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,2886,2)
 ;;=^5000414
