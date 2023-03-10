IBDEI0XV ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15256,0)
 ;;=F43.10^^58^718^15
 ;;^UTILITY(U,$J,358.3,15256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15256,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,15256,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,15256,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,15257,0)
 ;;=F43.12^^58^718^14
 ;;^UTILITY(U,$J,358.3,15257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15257,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,15257,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,15257,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,15258,0)
 ;;=F43.8^^58^718^16
 ;;^UTILITY(U,$J,358.3,15258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15258,1,3,0)
 ;;=3^Reactions to severe stress NEC
 ;;^UTILITY(U,$J,358.3,15258,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,15258,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,15259,0)
 ;;=F43.20^^58^718^6
 ;;^UTILITY(U,$J,358.3,15259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15259,1,3,0)
 ;;=3^Adjustment D/O,Unspec
 ;;^UTILITY(U,$J,358.3,15259,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,15259,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,15260,0)
 ;;=F07.0^^58^718^13
 ;;^UTILITY(U,$J,358.3,15260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15260,1,3,0)
 ;;=3^Personality change due to known physiological condition
 ;;^UTILITY(U,$J,358.3,15260,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,15260,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,15261,0)
 ;;=F98.5^^58^719^1
 ;;^UTILITY(U,$J,358.3,15261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15261,1,3,0)
 ;;=3^Adult onset fluency disorder
 ;;^UTILITY(U,$J,358.3,15261,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,15261,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,15262,0)
 ;;=R47.01^^58^719^2
 ;;^UTILITY(U,$J,358.3,15262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15262,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,15262,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,15262,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,15263,0)
 ;;=I69.920^^58^719^4
 ;;^UTILITY(U,$J,358.3,15263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15263,1,3,0)
 ;;=3^Aphasia following unspecified cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,15263,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,15263,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,15264,0)
 ;;=F80.1^^58^719^5
 ;;^UTILITY(U,$J,358.3,15264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15264,1,3,0)
 ;;=3^Expressive language disorder
 ;;^UTILITY(U,$J,358.3,15264,1,4,0)
 ;;=4^F80.1
 ;;^UTILITY(U,$J,358.3,15264,2)
 ;;=^331958
 ;;^UTILITY(U,$J,358.3,15265,0)
 ;;=F80.2^^58^719^6
 ;;^UTILITY(U,$J,358.3,15265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15265,1,3,0)
 ;;=3^Mixed receptive-expressive language disorder
 ;;^UTILITY(U,$J,358.3,15265,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,15265,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,15266,0)
 ;;=R47.89^^58^719^7
 ;;^UTILITY(U,$J,358.3,15266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15266,1,3,0)
 ;;=3^Speech disturbances NEC
 ;;^UTILITY(U,$J,358.3,15266,1,4,0)
 ;;=4^R47.89
 ;;^UTILITY(U,$J,358.3,15266,2)
 ;;=^5019493
 ;;^UTILITY(U,$J,358.3,15267,0)
 ;;=R49.8^^58^719^8
 ;;^UTILITY(U,$J,358.3,15267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15267,1,3,0)
 ;;=3^Voice and resonance disorders NEC
 ;;^UTILITY(U,$J,358.3,15267,1,4,0)
 ;;=4^R49.8
 ;;^UTILITY(U,$J,358.3,15267,2)
 ;;=^5019505
 ;;^UTILITY(U,$J,358.3,15268,0)
 ;;=I69.320^^58^719^3
 ;;^UTILITY(U,$J,358.3,15268,1,0)
 ;;=^358.31IA^4^2
