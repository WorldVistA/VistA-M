IBDEI2DC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39769,0)
 ;;=F43.25^^183^2030^1
 ;;^UTILITY(U,$J,358.3,39769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39769,1,3,0)
 ;;=3^Adjustment disorder w mixed disturb of emotions and conduct
 ;;^UTILITY(U,$J,358.3,39769,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,39769,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,39770,0)
 ;;=F43.10^^183^2030^15
 ;;^UTILITY(U,$J,358.3,39770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39770,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,39770,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,39770,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,39771,0)
 ;;=F43.12^^183^2030^14
 ;;^UTILITY(U,$J,358.3,39771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39771,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,39771,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,39771,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,39772,0)
 ;;=F43.8^^183^2030^16
 ;;^UTILITY(U,$J,358.3,39772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39772,1,3,0)
 ;;=3^Reactions to severe stress NEC
 ;;^UTILITY(U,$J,358.3,39772,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,39772,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,39773,0)
 ;;=F43.20^^183^2030^6
 ;;^UTILITY(U,$J,358.3,39773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39773,1,3,0)
 ;;=3^Adjustment disorder, unspecified
 ;;^UTILITY(U,$J,358.3,39773,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,39773,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,39774,0)
 ;;=F07.0^^183^2030^13
 ;;^UTILITY(U,$J,358.3,39774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39774,1,3,0)
 ;;=3^Personality change due to known physiological condition
 ;;^UTILITY(U,$J,358.3,39774,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,39774,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,39775,0)
 ;;=F32.9^^183^2030^12
 ;;^UTILITY(U,$J,358.3,39775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39775,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,39775,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,39775,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,39776,0)
 ;;=F98.5^^183^2031^1
 ;;^UTILITY(U,$J,358.3,39776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39776,1,3,0)
 ;;=3^Adult onset fluency disorder
 ;;^UTILITY(U,$J,358.3,39776,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,39776,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,39777,0)
 ;;=R47.01^^183^2031^2
 ;;^UTILITY(U,$J,358.3,39777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39777,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,39777,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,39777,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,39778,0)
 ;;=I69.920^^183^2031^3
 ;;^UTILITY(U,$J,358.3,39778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39778,1,3,0)
 ;;=3^Aphasia following unspecified cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,39778,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,39778,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,39779,0)
 ;;=F80.1^^183^2031^4
 ;;^UTILITY(U,$J,358.3,39779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39779,1,3,0)
 ;;=3^Expressive language disorder
 ;;^UTILITY(U,$J,358.3,39779,1,4,0)
 ;;=4^F80.1
 ;;^UTILITY(U,$J,358.3,39779,2)
 ;;=^331958
 ;;^UTILITY(U,$J,358.3,39780,0)
 ;;=F80.2^^183^2031^5
 ;;^UTILITY(U,$J,358.3,39780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39780,1,3,0)
 ;;=3^Mixed receptive-expressive language disorder
 ;;^UTILITY(U,$J,358.3,39780,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,39780,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,39781,0)
 ;;=R47.89^^183^2031^6
 ;;^UTILITY(U,$J,358.3,39781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39781,1,3,0)
 ;;=3^Speech disturbances NEC
