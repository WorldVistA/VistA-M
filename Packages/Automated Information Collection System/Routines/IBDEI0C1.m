IBDEI0C1 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5186,1,3,0)
 ;;=3^Signs/Symptoms in Breast NEC
 ;;^UTILITY(U,$J,358.3,5186,1,4,0)
 ;;=4^N64.59
 ;;^UTILITY(U,$J,358.3,5186,2)
 ;;=^5015797
 ;;^UTILITY(U,$J,358.3,5187,0)
 ;;=N64.89^^40^355^3
 ;;^UTILITY(U,$J,358.3,5187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5187,1,3,0)
 ;;=3^Breast Disorders NEC
 ;;^UTILITY(U,$J,358.3,5187,1,4,0)
 ;;=4^N64.89
 ;;^UTILITY(U,$J,358.3,5187,2)
 ;;=^336616
 ;;^UTILITY(U,$J,358.3,5188,0)
 ;;=Z12.39^^40^355^31
 ;;^UTILITY(U,$J,358.3,5188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5188,1,3,0)
 ;;=3^Screening for Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,5188,1,4,0)
 ;;=4^Z12.39
 ;;^UTILITY(U,$J,358.3,5188,2)
 ;;=^5062686
 ;;^UTILITY(U,$J,358.3,5189,0)
 ;;=C50.021^^40^356^12
 ;;^UTILITY(U,$J,358.3,5189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5189,1,3,0)
 ;;=3^Malig Neop of Nipple/Areola,Right Breast
 ;;^UTILITY(U,$J,358.3,5189,1,4,0)
 ;;=4^C50.021
 ;;^UTILITY(U,$J,358.3,5189,2)
 ;;=^5001162
 ;;^UTILITY(U,$J,358.3,5190,0)
 ;;=C50.022^^40^356^11
 ;;^UTILITY(U,$J,358.3,5190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5190,1,3,0)
 ;;=3^Malig Neop of Nipple/Areola,Left Breast
 ;;^UTILITY(U,$J,358.3,5190,1,4,0)
 ;;=4^C50.022
 ;;^UTILITY(U,$J,358.3,5190,2)
 ;;=^5001163
 ;;^UTILITY(U,$J,358.3,5191,0)
 ;;=C50.121^^40^356^5
 ;;^UTILITY(U,$J,358.3,5191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5191,1,3,0)
 ;;=3^Malig Neop of Central Portion of Right Breast
 ;;^UTILITY(U,$J,358.3,5191,1,4,0)
 ;;=4^C50.121
 ;;^UTILITY(U,$J,358.3,5191,2)
 ;;=^5001168
 ;;^UTILITY(U,$J,358.3,5192,0)
 ;;=C50.122^^40^356^4
 ;;^UTILITY(U,$J,358.3,5192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5192,1,3,0)
 ;;=3^Malig Neop of Central Portion of Left Breast
 ;;^UTILITY(U,$J,358.3,5192,1,4,0)
 ;;=4^C50.122
 ;;^UTILITY(U,$J,358.3,5192,2)
 ;;=^5001169
 ;;^UTILITY(U,$J,358.3,5193,0)
 ;;=C50.221^^40^356^17
 ;;^UTILITY(U,$J,358.3,5193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5193,1,3,0)
 ;;=3^Malig Neop of Upper-Inner Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,5193,1,4,0)
 ;;=4^C50.221
 ;;^UTILITY(U,$J,358.3,5193,2)
 ;;=^5001174
 ;;^UTILITY(U,$J,358.3,5194,0)
 ;;=C50.222^^40^356^16
 ;;^UTILITY(U,$J,358.3,5194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5194,1,3,0)
 ;;=3^Malig Neop of Upper-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,5194,1,4,0)
 ;;=4^C50.222
 ;;^UTILITY(U,$J,358.3,5194,2)
 ;;=^5001175
 ;;^UTILITY(U,$J,358.3,5195,0)
 ;;=C50.321^^40^356^8
 ;;^UTILITY(U,$J,358.3,5195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5195,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,5195,1,4,0)
 ;;=4^C50.321
 ;;^UTILITY(U,$J,358.3,5195,2)
 ;;=^5001178
 ;;^UTILITY(U,$J,358.3,5196,0)
 ;;=C50.322^^40^356^7
 ;;^UTILITY(U,$J,358.3,5196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5196,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,5196,1,4,0)
 ;;=4^C50.322
 ;;^UTILITY(U,$J,358.3,5196,2)
 ;;=^5133334
 ;;^UTILITY(U,$J,358.3,5197,0)
 ;;=C50.421^^40^356^19
 ;;^UTILITY(U,$J,358.3,5197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5197,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,5197,1,4,0)
 ;;=4^C50.421
 ;;^UTILITY(U,$J,358.3,5197,2)
 ;;=^5001180
 ;;^UTILITY(U,$J,358.3,5198,0)
 ;;=C50.422^^40^356^18
 ;;^UTILITY(U,$J,358.3,5198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5198,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,5198,1,4,0)
 ;;=4^C50.422
 ;;^UTILITY(U,$J,358.3,5198,2)
 ;;=^5133336
 ;;^UTILITY(U,$J,358.3,5199,0)
 ;;=C50.521^^40^356^10
