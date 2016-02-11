IBDEI34Q ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52525,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,52525,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,52525,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,52526,0)
 ;;=G47.23^^237^2613^4
 ;;^UTILITY(U,$J,358.3,52526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52526,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,52526,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,52526,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,52527,0)
 ;;=G47.24^^237^2613^5
 ;;^UTILITY(U,$J,358.3,52527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52527,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,52527,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,52527,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,52528,0)
 ;;=G47.26^^237^2613^6
 ;;^UTILITY(U,$J,358.3,52528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52528,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,52528,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,52528,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,52529,0)
 ;;=G47.20^^237^2613^7
 ;;^UTILITY(U,$J,358.3,52529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52529,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,52529,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,52529,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,52530,0)
 ;;=F51.3^^237^2613^14
 ;;^UTILITY(U,$J,358.3,52530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52530,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,52530,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,52530,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,52531,0)
 ;;=F51.4^^237^2613^15
 ;;^UTILITY(U,$J,358.3,52531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52531,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,52531,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,52531,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,52532,0)
 ;;=F51.5^^237^2613^13
 ;;^UTILITY(U,$J,358.3,52532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52532,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,52532,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,52532,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,52533,0)
 ;;=G47.52^^237^2613^17
 ;;^UTILITY(U,$J,358.3,52533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52533,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,52533,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,52533,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,52534,0)
 ;;=G25.81^^237^2613^18
 ;;^UTILITY(U,$J,358.3,52534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52534,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,52534,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,52534,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,52535,0)
 ;;=G47.19^^237^2613^8
 ;;^UTILITY(U,$J,358.3,52535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52535,1,3,0)
 ;;=3^Hypersomnolence Disorder NEC
 ;;^UTILITY(U,$J,358.3,52535,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,52535,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,52536,0)
 ;;=G47.8^^237^2613^19
 ;;^UTILITY(U,$J,358.3,52536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52536,1,3,0)
 ;;=3^Sleep-Wake Disorder NEC
 ;;^UTILITY(U,$J,358.3,52536,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,52536,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,52537,0)
 ;;=F10.10^^237^2614^1
 ;;^UTILITY(U,$J,358.3,52537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52537,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,52537,1,4,0)
 ;;=4^F10.10
