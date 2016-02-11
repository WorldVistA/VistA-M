IBDEI03A ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,796,1,3,0)
 ;;=3^Irritant Contact Dermatitis d/t Oils/Greases
 ;;^UTILITY(U,$J,358.3,796,1,4,0)
 ;;=4^L24.1
 ;;^UTILITY(U,$J,358.3,796,2)
 ;;=^5009127
 ;;^UTILITY(U,$J,358.3,797,0)
 ;;=L24.2^^9^88^100
 ;;^UTILITY(U,$J,358.3,797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,797,1,3,0)
 ;;=3^Irritant Contact Dermatitis d/t Solvents
 ;;^UTILITY(U,$J,358.3,797,1,4,0)
 ;;=4^L24.2
 ;;^UTILITY(U,$J,358.3,797,2)
 ;;=^5009128
 ;;^UTILITY(U,$J,358.3,798,0)
 ;;=L24.3^^9^88^93
 ;;^UTILITY(U,$J,358.3,798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,798,1,3,0)
 ;;=3^Irritant Contact Dermatitis d/t Cosmetics
 ;;^UTILITY(U,$J,358.3,798,1,4,0)
 ;;=4^L24.3
 ;;^UTILITY(U,$J,358.3,798,2)
 ;;=^5009129
 ;;^UTILITY(U,$J,358.3,799,0)
 ;;=L24.5^^9^88^98
 ;;^UTILITY(U,$J,358.3,799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,799,1,3,0)
 ;;=3^Irritant Contact Dermatitis d/t Oth Chemical Products
 ;;^UTILITY(U,$J,358.3,799,1,4,0)
 ;;=4^L24.5
 ;;^UTILITY(U,$J,358.3,799,2)
 ;;=^5009131
 ;;^UTILITY(U,$J,358.3,800,0)
 ;;=L24.6^^9^88^95
 ;;^UTILITY(U,$J,358.3,800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,800,1,3,0)
 ;;=3^Irritant Contact Dermatitis d/t Food in Contact w/ Skin
 ;;^UTILITY(U,$J,358.3,800,1,4,0)
 ;;=4^L24.6
 ;;^UTILITY(U,$J,358.3,800,2)
 ;;=^5009132
 ;;^UTILITY(U,$J,358.3,801,0)
 ;;=L24.7^^9^88^99
 ;;^UTILITY(U,$J,358.3,801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,801,1,3,0)
 ;;=3^Irritant Contact Dermatitis d/t Plants
 ;;^UTILITY(U,$J,358.3,801,1,4,0)
 ;;=4^L24.7
 ;;^UTILITY(U,$J,358.3,801,2)
 ;;=^5009133
 ;;^UTILITY(U,$J,358.3,802,0)
 ;;=L24.81^^9^88^96
 ;;^UTILITY(U,$J,358.3,802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,802,1,3,0)
 ;;=3^Irritant Contact Dermatitis d/t Metals
 ;;^UTILITY(U,$J,358.3,802,1,4,0)
 ;;=4^L24.81
 ;;^UTILITY(U,$J,358.3,802,2)
 ;;=^5009134
 ;;^UTILITY(U,$J,358.3,803,0)
 ;;=R21.^^9^88^107
 ;;^UTILITY(U,$J,358.3,803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,803,1,3,0)
 ;;=3^Rash/Nonspecific Skin Eruption
 ;;^UTILITY(U,$J,358.3,803,1,4,0)
 ;;=4^R21.
 ;;^UTILITY(U,$J,358.3,803,2)
 ;;=^5019283
 ;;^UTILITY(U,$J,358.3,804,0)
 ;;=L27.0^^9^88^110
 ;;^UTILITY(U,$J,358.3,804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,804,1,3,0)
 ;;=3^Skin Eruption d/t Drugs/Meds Taken Internally
 ;;^UTILITY(U,$J,358.3,804,1,4,0)
 ;;=4^L27.0
 ;;^UTILITY(U,$J,358.3,804,2)
 ;;=^5009144
 ;;^UTILITY(U,$J,358.3,805,0)
 ;;=Z91.010^^9^88^35
 ;;^UTILITY(U,$J,358.3,805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,805,1,3,0)
 ;;=3^Allergy to Peanuts
 ;;^UTILITY(U,$J,358.3,805,1,4,0)
 ;;=4^Z91.010
 ;;^UTILITY(U,$J,358.3,805,2)
 ;;=^5063599
 ;;^UTILITY(U,$J,358.3,806,0)
 ;;=Z91.011^^9^88^32
 ;;^UTILITY(U,$J,358.3,806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,806,1,3,0)
 ;;=3^Allergy to Milk Products
 ;;^UTILITY(U,$J,358.3,806,1,4,0)
 ;;=4^Z91.011
 ;;^UTILITY(U,$J,358.3,806,2)
 ;;=^5063600
 ;;^UTILITY(U,$J,358.3,807,0)
 ;;=Z91.012^^9^88^29
 ;;^UTILITY(U,$J,358.3,807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,807,1,3,0)
 ;;=3^Allergy to Eggs
 ;;^UTILITY(U,$J,358.3,807,1,4,0)
 ;;=4^Z91.012
 ;;^UTILITY(U,$J,358.3,807,2)
 ;;=^5063601
 ;;^UTILITY(U,$J,358.3,808,0)
 ;;=Z91.013^^9^88^37
 ;;^UTILITY(U,$J,358.3,808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,808,1,3,0)
 ;;=3^Allergy to Seafood
 ;;^UTILITY(U,$J,358.3,808,1,4,0)
 ;;=4^Z91.013
 ;;^UTILITY(U,$J,358.3,808,2)
 ;;=^5063602
 ;;^UTILITY(U,$J,358.3,809,0)
 ;;=Z91.030^^9^88^52
 ;;^UTILITY(U,$J,358.3,809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,809,1,3,0)
 ;;=3^Bee Allergy
 ;;^UTILITY(U,$J,358.3,809,1,4,0)
 ;;=4^Z91.030
