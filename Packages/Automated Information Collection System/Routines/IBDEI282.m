IBDEI282 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35482,1,3,0)
 ;;=3^Aphasia following unspecified cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,35482,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,35482,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,35483,0)
 ;;=F80.1^^137^1804^4
 ;;^UTILITY(U,$J,358.3,35483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35483,1,3,0)
 ;;=3^Expressive language disorder
 ;;^UTILITY(U,$J,358.3,35483,1,4,0)
 ;;=4^F80.1
 ;;^UTILITY(U,$J,358.3,35483,2)
 ;;=^331958
 ;;^UTILITY(U,$J,358.3,35484,0)
 ;;=F80.2^^137^1804^5
 ;;^UTILITY(U,$J,358.3,35484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35484,1,3,0)
 ;;=3^Mixed receptive-expressive language disorder
 ;;^UTILITY(U,$J,358.3,35484,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,35484,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,35485,0)
 ;;=R47.89^^137^1804^6
 ;;^UTILITY(U,$J,358.3,35485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35485,1,3,0)
 ;;=3^Speech disturbances NEC
 ;;^UTILITY(U,$J,358.3,35485,1,4,0)
 ;;=4^R47.89
 ;;^UTILITY(U,$J,358.3,35485,2)
 ;;=^5019493
 ;;^UTILITY(U,$J,358.3,35486,0)
 ;;=R49.8^^137^1804^7
 ;;^UTILITY(U,$J,358.3,35486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35486,1,3,0)
 ;;=3^Voice and resonance disorders NEC
 ;;^UTILITY(U,$J,358.3,35486,1,4,0)
 ;;=4^R49.8
 ;;^UTILITY(U,$J,358.3,35486,2)
 ;;=^5019505
 ;;^UTILITY(U,$J,358.3,35487,0)
 ;;=Z44.011^^137^1805^3
 ;;^UTILITY(U,$J,358.3,35487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35487,1,3,0)
 ;;=3^Fit/adjst of complete right artificial arm
 ;;^UTILITY(U,$J,358.3,35487,1,4,0)
 ;;=4^Z44.011
 ;;^UTILITY(U,$J,358.3,35487,2)
 ;;=^5062971
 ;;^UTILITY(U,$J,358.3,35488,0)
 ;;=Z44.012^^137^1805^1
 ;;^UTILITY(U,$J,358.3,35488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35488,1,3,0)
 ;;=3^Fit/adjst of complete left artificial arm
 ;;^UTILITY(U,$J,358.3,35488,1,4,0)
 ;;=4^Z44.012
 ;;^UTILITY(U,$J,358.3,35488,2)
 ;;=^5062972
 ;;^UTILITY(U,$J,358.3,35489,0)
 ;;=Z44.021^^137^1805^8
 ;;^UTILITY(U,$J,358.3,35489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35489,1,3,0)
 ;;=3^Fit/adjst of partial artificial right arm
 ;;^UTILITY(U,$J,358.3,35489,1,4,0)
 ;;=4^Z44.021
 ;;^UTILITY(U,$J,358.3,35489,2)
 ;;=^5062974
 ;;^UTILITY(U,$J,358.3,35490,0)
 ;;=Z44.022^^137^1805^6
 ;;^UTILITY(U,$J,358.3,35490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35490,1,3,0)
 ;;=3^Fit/adjst of partial artificial left arm
 ;;^UTILITY(U,$J,358.3,35490,1,4,0)
 ;;=4^Z44.022
 ;;^UTILITY(U,$J,358.3,35490,2)
 ;;=^5062975
 ;;^UTILITY(U,$J,358.3,35491,0)
 ;;=Z44.111^^137^1805^4
 ;;^UTILITY(U,$J,358.3,35491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35491,1,3,0)
 ;;=3^Fit/adjst of complete right artificial leg
 ;;^UTILITY(U,$J,358.3,35491,1,4,0)
 ;;=4^Z44.111
 ;;^UTILITY(U,$J,358.3,35491,2)
 ;;=^5062980
 ;;^UTILITY(U,$J,358.3,35492,0)
 ;;=Z44.112^^137^1805^2
 ;;^UTILITY(U,$J,358.3,35492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35492,1,3,0)
 ;;=3^Fit/adjst of complete left artificial leg
 ;;^UTILITY(U,$J,358.3,35492,1,4,0)
 ;;=4^Z44.112
 ;;^UTILITY(U,$J,358.3,35492,2)
 ;;=^5062981
 ;;^UTILITY(U,$J,358.3,35493,0)
 ;;=Z44.121^^137^1805^9
 ;;^UTILITY(U,$J,358.3,35493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35493,1,3,0)
 ;;=3^Fit/adjst of partial artificial right leg
 ;;^UTILITY(U,$J,358.3,35493,1,4,0)
 ;;=4^Z44.121
 ;;^UTILITY(U,$J,358.3,35493,2)
 ;;=^5062983
 ;;^UTILITY(U,$J,358.3,35494,0)
 ;;=Z44.122^^137^1805^7
 ;;^UTILITY(U,$J,358.3,35494,1,0)
 ;;=^358.31IA^4^2
