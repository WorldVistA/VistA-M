IBDEI1Z3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33036,1,3,0)
 ;;=3^Narcolepsy
 ;;^UTILITY(U,$J,358.3,33036,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,33036,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,33037,0)
 ;;=G47.33^^146^1606^16
 ;;^UTILITY(U,$J,358.3,33037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33037,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,33037,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,33037,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,33038,0)
 ;;=G47.31^^146^1606^1
 ;;^UTILITY(U,$J,358.3,33038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33038,1,3,0)
 ;;=3^Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,33038,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,33038,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,33039,0)
 ;;=G47.21^^146^1606^3
 ;;^UTILITY(U,$J,358.3,33039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33039,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,33039,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,33039,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,33040,0)
 ;;=G47.22^^146^1606^2
 ;;^UTILITY(U,$J,358.3,33040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33040,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,33040,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,33040,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,33041,0)
 ;;=G47.23^^146^1606^4
 ;;^UTILITY(U,$J,358.3,33041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33041,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,33041,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,33041,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,33042,0)
 ;;=G47.24^^146^1606^5
 ;;^UTILITY(U,$J,358.3,33042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33042,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,33042,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,33042,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,33043,0)
 ;;=G47.26^^146^1606^6
 ;;^UTILITY(U,$J,358.3,33043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33043,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,33043,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,33043,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,33044,0)
 ;;=G47.20^^146^1606^7
 ;;^UTILITY(U,$J,358.3,33044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33044,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,33044,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,33044,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,33045,0)
 ;;=F51.3^^146^1606^14
 ;;^UTILITY(U,$J,358.3,33045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33045,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,33045,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,33045,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,33046,0)
 ;;=F51.4^^146^1606^15
 ;;^UTILITY(U,$J,358.3,33046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33046,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,33046,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,33046,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,33047,0)
 ;;=F51.5^^146^1606^13
 ;;^UTILITY(U,$J,358.3,33047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33047,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,33047,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,33047,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,33048,0)
 ;;=G47.52^^146^1606^17
 ;;^UTILITY(U,$J,358.3,33048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33048,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
