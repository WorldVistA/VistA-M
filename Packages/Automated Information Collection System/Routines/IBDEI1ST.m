IBDEI1ST ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31718,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,31718,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,31719,0)
 ;;=I69.920^^180^1964^3
 ;;^UTILITY(U,$J,358.3,31719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31719,1,3,0)
 ;;=3^Aphasia following unspecified cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,31719,1,4,0)
 ;;=4^I69.920
 ;;^UTILITY(U,$J,358.3,31719,2)
 ;;=^5007553
 ;;^UTILITY(U,$J,358.3,31720,0)
 ;;=F80.1^^180^1964^4
 ;;^UTILITY(U,$J,358.3,31720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31720,1,3,0)
 ;;=3^Expressive language disorder
 ;;^UTILITY(U,$J,358.3,31720,1,4,0)
 ;;=4^F80.1
 ;;^UTILITY(U,$J,358.3,31720,2)
 ;;=^331958
 ;;^UTILITY(U,$J,358.3,31721,0)
 ;;=F80.2^^180^1964^5
 ;;^UTILITY(U,$J,358.3,31721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31721,1,3,0)
 ;;=3^Mixed receptive-expressive language disorder
 ;;^UTILITY(U,$J,358.3,31721,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,31721,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,31722,0)
 ;;=R47.89^^180^1964^6
 ;;^UTILITY(U,$J,358.3,31722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31722,1,3,0)
 ;;=3^Speech disturbances NEC
 ;;^UTILITY(U,$J,358.3,31722,1,4,0)
 ;;=4^R47.89
 ;;^UTILITY(U,$J,358.3,31722,2)
 ;;=^5019493
 ;;^UTILITY(U,$J,358.3,31723,0)
 ;;=R49.8^^180^1964^7
 ;;^UTILITY(U,$J,358.3,31723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31723,1,3,0)
 ;;=3^Voice and resonance disorders NEC
 ;;^UTILITY(U,$J,358.3,31723,1,4,0)
 ;;=4^R49.8
 ;;^UTILITY(U,$J,358.3,31723,2)
 ;;=^5019505
 ;;^UTILITY(U,$J,358.3,31724,0)
 ;;=Z44.011^^180^1965^3
 ;;^UTILITY(U,$J,358.3,31724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31724,1,3,0)
 ;;=3^Fit/adjst of complete right artificial arm
 ;;^UTILITY(U,$J,358.3,31724,1,4,0)
 ;;=4^Z44.011
 ;;^UTILITY(U,$J,358.3,31724,2)
 ;;=^5062971
 ;;^UTILITY(U,$J,358.3,31725,0)
 ;;=Z44.012^^180^1965^1
 ;;^UTILITY(U,$J,358.3,31725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31725,1,3,0)
 ;;=3^Fit/adjst of complete left artificial arm
 ;;^UTILITY(U,$J,358.3,31725,1,4,0)
 ;;=4^Z44.012
 ;;^UTILITY(U,$J,358.3,31725,2)
 ;;=^5062972
 ;;^UTILITY(U,$J,358.3,31726,0)
 ;;=Z44.021^^180^1965^8
 ;;^UTILITY(U,$J,358.3,31726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31726,1,3,0)
 ;;=3^Fit/adjst of partial artificial right arm
 ;;^UTILITY(U,$J,358.3,31726,1,4,0)
 ;;=4^Z44.021
 ;;^UTILITY(U,$J,358.3,31726,2)
 ;;=^5062974
 ;;^UTILITY(U,$J,358.3,31727,0)
 ;;=Z44.022^^180^1965^6
 ;;^UTILITY(U,$J,358.3,31727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31727,1,3,0)
 ;;=3^Fit/adjst of partial artificial left arm
 ;;^UTILITY(U,$J,358.3,31727,1,4,0)
 ;;=4^Z44.022
 ;;^UTILITY(U,$J,358.3,31727,2)
 ;;=^5062975
 ;;^UTILITY(U,$J,358.3,31728,0)
 ;;=Z44.111^^180^1965^4
 ;;^UTILITY(U,$J,358.3,31728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31728,1,3,0)
 ;;=3^Fit/adjst of complete right artificial leg
 ;;^UTILITY(U,$J,358.3,31728,1,4,0)
 ;;=4^Z44.111
 ;;^UTILITY(U,$J,358.3,31728,2)
 ;;=^5062980
 ;;^UTILITY(U,$J,358.3,31729,0)
 ;;=Z44.112^^180^1965^2
 ;;^UTILITY(U,$J,358.3,31729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31729,1,3,0)
 ;;=3^Fit/adjst of complete left artificial leg
 ;;^UTILITY(U,$J,358.3,31729,1,4,0)
 ;;=4^Z44.112
 ;;^UTILITY(U,$J,358.3,31729,2)
 ;;=^5062981
 ;;^UTILITY(U,$J,358.3,31730,0)
 ;;=Z44.121^^180^1965^9
 ;;^UTILITY(U,$J,358.3,31730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31730,1,3,0)
 ;;=3^Fit/adjst of partial artificial right leg
 ;;^UTILITY(U,$J,358.3,31730,1,4,0)
 ;;=4^Z44.121
 ;;^UTILITY(U,$J,358.3,31730,2)
 ;;=^5062983
 ;;^UTILITY(U,$J,358.3,31731,0)
 ;;=Z44.122^^180^1965^7
 ;;^UTILITY(U,$J,358.3,31731,1,0)
 ;;=^358.31IA^4^2
