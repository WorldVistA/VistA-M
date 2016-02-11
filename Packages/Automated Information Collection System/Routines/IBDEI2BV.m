IBDEI2BV ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39085,0)
 ;;=R49.8^^180^1993^7
 ;;^UTILITY(U,$J,358.3,39085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39085,1,3,0)
 ;;=3^Voice and resonance disorders NEC
 ;;^UTILITY(U,$J,358.3,39085,1,4,0)
 ;;=4^R49.8
 ;;^UTILITY(U,$J,358.3,39085,2)
 ;;=^5019505
 ;;^UTILITY(U,$J,358.3,39086,0)
 ;;=Z44.011^^180^1994^3
 ;;^UTILITY(U,$J,358.3,39086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39086,1,3,0)
 ;;=3^Fit/adjst of complete right artificial arm
 ;;^UTILITY(U,$J,358.3,39086,1,4,0)
 ;;=4^Z44.011
 ;;^UTILITY(U,$J,358.3,39086,2)
 ;;=^5062971
 ;;^UTILITY(U,$J,358.3,39087,0)
 ;;=Z44.012^^180^1994^1
 ;;^UTILITY(U,$J,358.3,39087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39087,1,3,0)
 ;;=3^Fit/adjst of complete left artificial arm
 ;;^UTILITY(U,$J,358.3,39087,1,4,0)
 ;;=4^Z44.012
 ;;^UTILITY(U,$J,358.3,39087,2)
 ;;=^5062972
 ;;^UTILITY(U,$J,358.3,39088,0)
 ;;=Z44.021^^180^1994^8
 ;;^UTILITY(U,$J,358.3,39088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39088,1,3,0)
 ;;=3^Fit/adjst of partial artificial right arm
 ;;^UTILITY(U,$J,358.3,39088,1,4,0)
 ;;=4^Z44.021
 ;;^UTILITY(U,$J,358.3,39088,2)
 ;;=^5062974
 ;;^UTILITY(U,$J,358.3,39089,0)
 ;;=Z44.022^^180^1994^6
 ;;^UTILITY(U,$J,358.3,39089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39089,1,3,0)
 ;;=3^Fit/adjst of partial artificial left arm
 ;;^UTILITY(U,$J,358.3,39089,1,4,0)
 ;;=4^Z44.022
 ;;^UTILITY(U,$J,358.3,39089,2)
 ;;=^5062975
 ;;^UTILITY(U,$J,358.3,39090,0)
 ;;=Z44.111^^180^1994^4
 ;;^UTILITY(U,$J,358.3,39090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39090,1,3,0)
 ;;=3^Fit/adjst of complete right artificial leg
 ;;^UTILITY(U,$J,358.3,39090,1,4,0)
 ;;=4^Z44.111
 ;;^UTILITY(U,$J,358.3,39090,2)
 ;;=^5062980
 ;;^UTILITY(U,$J,358.3,39091,0)
 ;;=Z44.112^^180^1994^2
 ;;^UTILITY(U,$J,358.3,39091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39091,1,3,0)
 ;;=3^Fit/adjst of complete left artificial leg
 ;;^UTILITY(U,$J,358.3,39091,1,4,0)
 ;;=4^Z44.112
 ;;^UTILITY(U,$J,358.3,39091,2)
 ;;=^5062981
 ;;^UTILITY(U,$J,358.3,39092,0)
 ;;=Z44.121^^180^1994^9
 ;;^UTILITY(U,$J,358.3,39092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39092,1,3,0)
 ;;=3^Fit/adjst of partial artificial right leg
 ;;^UTILITY(U,$J,358.3,39092,1,4,0)
 ;;=4^Z44.121
 ;;^UTILITY(U,$J,358.3,39092,2)
 ;;=^5062983
 ;;^UTILITY(U,$J,358.3,39093,0)
 ;;=Z44.122^^180^1994^7
 ;;^UTILITY(U,$J,358.3,39093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39093,1,3,0)
 ;;=3^Fit/adjst of partial artificial left leg
 ;;^UTILITY(U,$J,358.3,39093,1,4,0)
 ;;=4^Z44.122
 ;;^UTILITY(U,$J,358.3,39093,2)
 ;;=^5062984
 ;;^UTILITY(U,$J,358.3,39094,0)
 ;;=Z44.8^^180^1994^5
 ;;^UTILITY(U,$J,358.3,39094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39094,1,3,0)
 ;;=3^Fit/adjst of external prosthetic devices
 ;;^UTILITY(U,$J,358.3,39094,1,4,0)
 ;;=4^Z44.8
 ;;^UTILITY(U,$J,358.3,39094,2)
 ;;=^5062992
 ;;^UTILITY(U,$J,358.3,39095,0)
 ;;=Z44.9^^180^1994^10
 ;;^UTILITY(U,$J,358.3,39095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39095,1,3,0)
 ;;=3^Fit/adjst of unsp external prosthetic device
 ;;^UTILITY(U,$J,358.3,39095,1,4,0)
 ;;=4^Z44.9
 ;;^UTILITY(U,$J,358.3,39095,2)
 ;;=^5062993
 ;;^UTILITY(U,$J,358.3,39096,0)
 ;;=Z47.89^^180^1994^11
 ;;^UTILITY(U,$J,358.3,39096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39096,1,3,0)
 ;;=3^Orthopedic Aftercare NEC
 ;;^UTILITY(U,$J,358.3,39096,1,4,0)
 ;;=4^Z47.89
 ;;^UTILITY(U,$J,358.3,39096,2)
 ;;=^5063032
 ;;^UTILITY(U,$J,358.3,39097,0)
 ;;=Z51.89^^180^1994^12
 ;;^UTILITY(U,$J,358.3,39097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39097,1,3,0)
 ;;=3^Specified Aftercare NEC
