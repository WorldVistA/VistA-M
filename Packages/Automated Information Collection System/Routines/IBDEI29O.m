IBDEI29O ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36190,1,3,0)
 ;;=3^Adjustment D/O w/ Anxiety
 ;;^UTILITY(U,$J,358.3,36190,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,36190,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,36191,0)
 ;;=F43.23^^139^1833^5
 ;;^UTILITY(U,$J,358.3,36191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36191,1,3,0)
 ;;=3^Adjustment D/O w/ Mixed Anxiety & Depressed Mood
 ;;^UTILITY(U,$J,358.3,36191,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,36191,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,36192,0)
 ;;=F43.24^^139^1833^4
 ;;^UTILITY(U,$J,358.3,36192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36192,1,3,0)
 ;;=3^Adjustment D/O w/ Conduct Disturbance
 ;;^UTILITY(U,$J,358.3,36192,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,36192,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,36193,0)
 ;;=F43.25^^139^1833^1
 ;;^UTILITY(U,$J,358.3,36193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36193,1,3,0)
 ;;=3^Adjustment D/O w/ Mixed Disturb Emotions & Conduct
 ;;^UTILITY(U,$J,358.3,36193,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,36193,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,36194,0)
 ;;=F43.10^^139^1833^15
 ;;^UTILITY(U,$J,358.3,36194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36194,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,36194,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,36194,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,36195,0)
 ;;=F43.12^^139^1833^14
 ;;^UTILITY(U,$J,358.3,36195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36195,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,36195,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,36195,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,36196,0)
 ;;=F43.8^^139^1833^16
 ;;^UTILITY(U,$J,358.3,36196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36196,1,3,0)
 ;;=3^Reactions to severe stress NEC
 ;;^UTILITY(U,$J,358.3,36196,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,36196,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,36197,0)
 ;;=F43.20^^139^1833^6
 ;;^UTILITY(U,$J,358.3,36197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36197,1,3,0)
 ;;=3^Adjustment D/O,Unspec
 ;;^UTILITY(U,$J,358.3,36197,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,36197,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,36198,0)
 ;;=F07.0^^139^1833^13
 ;;^UTILITY(U,$J,358.3,36198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36198,1,3,0)
 ;;=3^Personality change due to known physiological condition
 ;;^UTILITY(U,$J,358.3,36198,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,36198,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,36199,0)
 ;;=F32.9^^139^1833^12
 ;;^UTILITY(U,$J,358.3,36199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36199,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,36199,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,36199,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,36200,0)
 ;;=F98.5^^139^1834^1
 ;;^UTILITY(U,$J,358.3,36200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36200,1,3,0)
 ;;=3^Adult onset fluency disorder
 ;;^UTILITY(U,$J,358.3,36200,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,36200,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,36201,0)
 ;;=R47.01^^139^1834^2
 ;;^UTILITY(U,$J,358.3,36201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36201,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,36201,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,36201,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,36202,0)
 ;;=I69.920^^139^1834^3
 ;;^UTILITY(U,$J,358.3,36202,1,0)
 ;;=^358.31IA^4^2
