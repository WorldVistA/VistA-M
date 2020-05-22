IBDEI281 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35470,1,3,0)
 ;;=3^Adjustment D/O w/ Anxiety
 ;;^UTILITY(U,$J,358.3,35470,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,35470,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,35471,0)
 ;;=F43.23^^137^1803^5
 ;;^UTILITY(U,$J,358.3,35471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35471,1,3,0)
 ;;=3^Adjustment D/O w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,35471,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,35471,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,35472,0)
 ;;=F43.24^^137^1803^4
 ;;^UTILITY(U,$J,358.3,35472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35472,1,3,0)
 ;;=3^Adjustment D/O w/ Conduct Disturbance
 ;;^UTILITY(U,$J,358.3,35472,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,35472,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,35473,0)
 ;;=F43.25^^137^1803^1
 ;;^UTILITY(U,$J,358.3,35473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35473,1,3,0)
 ;;=3^Adjustment D/O w/ Mixed Disturb Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,35473,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,35473,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,35474,0)
 ;;=F43.10^^137^1803^15
 ;;^UTILITY(U,$J,358.3,35474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35474,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,35474,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,35474,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,35475,0)
 ;;=F43.12^^137^1803^14
 ;;^UTILITY(U,$J,358.3,35475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35475,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,35475,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,35475,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,35476,0)
 ;;=F43.8^^137^1803^16
 ;;^UTILITY(U,$J,358.3,35476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35476,1,3,0)
 ;;=3^Reactions to severe stress NEC
 ;;^UTILITY(U,$J,358.3,35476,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,35476,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,35477,0)
 ;;=F43.20^^137^1803^6
 ;;^UTILITY(U,$J,358.3,35477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35477,1,3,0)
 ;;=3^Adjustment D/O,Unspec
 ;;^UTILITY(U,$J,358.3,35477,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,35477,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,35478,0)
 ;;=F07.0^^137^1803^13
 ;;^UTILITY(U,$J,358.3,35478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35478,1,3,0)
 ;;=3^Personality change due to known physiological condition
 ;;^UTILITY(U,$J,358.3,35478,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,35478,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,35479,0)
 ;;=F32.9^^137^1803^12
 ;;^UTILITY(U,$J,358.3,35479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35479,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,35479,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,35479,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,35480,0)
 ;;=F98.5^^137^1804^1
 ;;^UTILITY(U,$J,358.3,35480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35480,1,3,0)
 ;;=3^Adult onset fluency disorder
 ;;^UTILITY(U,$J,358.3,35480,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,35480,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,35481,0)
 ;;=R47.01^^137^1804^2
 ;;^UTILITY(U,$J,358.3,35481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35481,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,35481,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,35481,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,35482,0)
 ;;=I69.920^^137^1804^3
 ;;^UTILITY(U,$J,358.3,35482,1,0)
 ;;=^358.31IA^4^2
