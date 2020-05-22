IBDEI29P ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36202,1,3,0)
 ;;=3^Aphasia following unspecified cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,36202,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,36202,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,36203,0)
 ;;=F80.1^^139^1834^4
 ;;^UTILITY(U,$J,358.3,36203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36203,1,3,0)
 ;;=3^Expressive language disorder
 ;;^UTILITY(U,$J,358.3,36203,1,4,0)
 ;;=4^F80.1
 ;;^UTILITY(U,$J,358.3,36203,2)
 ;;=^331958
 ;;^UTILITY(U,$J,358.3,36204,0)
 ;;=F80.2^^139^1834^5
 ;;^UTILITY(U,$J,358.3,36204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36204,1,3,0)
 ;;=3^Mixed receptive-expressive language disorder
 ;;^UTILITY(U,$J,358.3,36204,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,36204,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,36205,0)
 ;;=R47.89^^139^1834^6
 ;;^UTILITY(U,$J,358.3,36205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36205,1,3,0)
 ;;=3^Speech disturbances NEC
 ;;^UTILITY(U,$J,358.3,36205,1,4,0)
 ;;=4^R47.89
 ;;^UTILITY(U,$J,358.3,36205,2)
 ;;=^5019493
 ;;^UTILITY(U,$J,358.3,36206,0)
 ;;=R49.8^^139^1834^7
 ;;^UTILITY(U,$J,358.3,36206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36206,1,3,0)
 ;;=3^Voice and resonance disorders NEC
 ;;^UTILITY(U,$J,358.3,36206,1,4,0)
 ;;=4^R49.8
 ;;^UTILITY(U,$J,358.3,36206,2)
 ;;=^5019505
 ;;^UTILITY(U,$J,358.3,36207,0)
 ;;=Z44.011^^139^1835^3
 ;;^UTILITY(U,$J,358.3,36207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36207,1,3,0)
 ;;=3^Fit/adjst of complete right artificial arm
 ;;^UTILITY(U,$J,358.3,36207,1,4,0)
 ;;=4^Z44.011
 ;;^UTILITY(U,$J,358.3,36207,2)
 ;;=^5062971
 ;;^UTILITY(U,$J,358.3,36208,0)
 ;;=Z44.012^^139^1835^1
 ;;^UTILITY(U,$J,358.3,36208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36208,1,3,0)
 ;;=3^Fit/adjst of complete left artificial arm
 ;;^UTILITY(U,$J,358.3,36208,1,4,0)
 ;;=4^Z44.012
 ;;^UTILITY(U,$J,358.3,36208,2)
 ;;=^5062972
 ;;^UTILITY(U,$J,358.3,36209,0)
 ;;=Z44.021^^139^1835^8
 ;;^UTILITY(U,$J,358.3,36209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36209,1,3,0)
 ;;=3^Fit/adjst of partial artificial right arm
 ;;^UTILITY(U,$J,358.3,36209,1,4,0)
 ;;=4^Z44.021
 ;;^UTILITY(U,$J,358.3,36209,2)
 ;;=^5062974
 ;;^UTILITY(U,$J,358.3,36210,0)
 ;;=Z44.022^^139^1835^6
 ;;^UTILITY(U,$J,358.3,36210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36210,1,3,0)
 ;;=3^Fit/adjst of partial artificial left arm
 ;;^UTILITY(U,$J,358.3,36210,1,4,0)
 ;;=4^Z44.022
 ;;^UTILITY(U,$J,358.3,36210,2)
 ;;=^5062975
 ;;^UTILITY(U,$J,358.3,36211,0)
 ;;=Z44.111^^139^1835^4
 ;;^UTILITY(U,$J,358.3,36211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36211,1,3,0)
 ;;=3^Fit/adjst of complete right artificial leg
 ;;^UTILITY(U,$J,358.3,36211,1,4,0)
 ;;=4^Z44.111
 ;;^UTILITY(U,$J,358.3,36211,2)
 ;;=^5062980
 ;;^UTILITY(U,$J,358.3,36212,0)
 ;;=Z44.112^^139^1835^2
 ;;^UTILITY(U,$J,358.3,36212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36212,1,3,0)
 ;;=3^Fit/adjst of complete left artificial leg
 ;;^UTILITY(U,$J,358.3,36212,1,4,0)
 ;;=4^Z44.112
 ;;^UTILITY(U,$J,358.3,36212,2)
 ;;=^5062981
 ;;^UTILITY(U,$J,358.3,36213,0)
 ;;=Z44.121^^139^1835^9
 ;;^UTILITY(U,$J,358.3,36213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36213,1,3,0)
 ;;=3^Fit/adjst of partial artificial right leg
 ;;^UTILITY(U,$J,358.3,36213,1,4,0)
 ;;=4^Z44.121
 ;;^UTILITY(U,$J,358.3,36213,2)
 ;;=^5062983
 ;;^UTILITY(U,$J,358.3,36214,0)
 ;;=Z44.122^^139^1835^7
 ;;^UTILITY(U,$J,358.3,36214,1,0)
 ;;=^358.31IA^4^2
