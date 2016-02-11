IBDEI02G ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,380,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,380,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,381,0)
 ;;=F51.3^^3^48^14
 ;;^UTILITY(U,$J,358.3,381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,381,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,381,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,381,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,382,0)
 ;;=F51.4^^3^48^15
 ;;^UTILITY(U,$J,358.3,382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,382,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,382,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,382,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,383,0)
 ;;=F51.5^^3^48^13
 ;;^UTILITY(U,$J,358.3,383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,383,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,383,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,383,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,384,0)
 ;;=G47.52^^3^48^17
 ;;^UTILITY(U,$J,358.3,384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,384,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,384,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,384,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,385,0)
 ;;=G25.81^^3^48^18
 ;;^UTILITY(U,$J,358.3,385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,385,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,385,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,385,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,386,0)
 ;;=G47.19^^3^48^8
 ;;^UTILITY(U,$J,358.3,386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,386,1,3,0)
 ;;=3^Hypersomnolence Disorder NEC
 ;;^UTILITY(U,$J,358.3,386,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,386,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,387,0)
 ;;=G47.8^^3^48^19
 ;;^UTILITY(U,$J,358.3,387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,387,1,3,0)
 ;;=3^Sleep-Wake Disorder NEC
 ;;^UTILITY(U,$J,358.3,387,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,387,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,388,0)
 ;;=F10.10^^3^49^1
 ;;^UTILITY(U,$J,358.3,388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,388,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,388,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,388,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,389,0)
 ;;=F10.14^^3^49^8
 ;;^UTILITY(U,$J,358.3,389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,389,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,389,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,389,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,390,0)
 ;;=F10.182^^3^49^10
 ;;^UTILITY(U,$J,358.3,390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,390,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,390,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,390,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,391,0)
 ;;=F10.20^^3^49^2
 ;;^UTILITY(U,$J,358.3,391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,391,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,391,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,391,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,392,0)
 ;;=F10.21^^3^49^3
 ;;^UTILITY(U,$J,358.3,392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,392,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,392,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,392,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,393,0)
 ;;=F10.230^^3^49^4
 ;;^UTILITY(U,$J,358.3,393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,393,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,393,1,4,0)
 ;;=4^F10.230
