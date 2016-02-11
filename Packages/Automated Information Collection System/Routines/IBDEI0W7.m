IBDEI0W7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14839,1,3,0)
 ;;=3^Screening for Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,14839,1,4,0)
 ;;=4^Z12.39
 ;;^UTILITY(U,$J,358.3,14839,2)
 ;;=^5062686
 ;;^UTILITY(U,$J,358.3,14840,0)
 ;;=C50.021^^85^798^12
 ;;^UTILITY(U,$J,358.3,14840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14840,1,3,0)
 ;;=3^Malig Neop of Nipple/Areola,Right Breast
 ;;^UTILITY(U,$J,358.3,14840,1,4,0)
 ;;=4^C50.021
 ;;^UTILITY(U,$J,358.3,14840,2)
 ;;=^5001162
 ;;^UTILITY(U,$J,358.3,14841,0)
 ;;=C50.022^^85^798^11
 ;;^UTILITY(U,$J,358.3,14841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14841,1,3,0)
 ;;=3^Malig Neop of Nipple/Areola,Left Breast
 ;;^UTILITY(U,$J,358.3,14841,1,4,0)
 ;;=4^C50.022
 ;;^UTILITY(U,$J,358.3,14841,2)
 ;;=^5001163
 ;;^UTILITY(U,$J,358.3,14842,0)
 ;;=C50.121^^85^798^5
 ;;^UTILITY(U,$J,358.3,14842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14842,1,3,0)
 ;;=3^Malig Neop of Central Portion of Right Breast
 ;;^UTILITY(U,$J,358.3,14842,1,4,0)
 ;;=4^C50.121
 ;;^UTILITY(U,$J,358.3,14842,2)
 ;;=^5001168
 ;;^UTILITY(U,$J,358.3,14843,0)
 ;;=C50.122^^85^798^4
 ;;^UTILITY(U,$J,358.3,14843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14843,1,3,0)
 ;;=3^Malig Neop of Central Portion of Left Breast
 ;;^UTILITY(U,$J,358.3,14843,1,4,0)
 ;;=4^C50.122
 ;;^UTILITY(U,$J,358.3,14843,2)
 ;;=^5001169
 ;;^UTILITY(U,$J,358.3,14844,0)
 ;;=C50.221^^85^798^17
 ;;^UTILITY(U,$J,358.3,14844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14844,1,3,0)
 ;;=3^Malig Neop of Upper-Inner Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,14844,1,4,0)
 ;;=4^C50.221
 ;;^UTILITY(U,$J,358.3,14844,2)
 ;;=^5001174
 ;;^UTILITY(U,$J,358.3,14845,0)
 ;;=C50.222^^85^798^16
 ;;^UTILITY(U,$J,358.3,14845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14845,1,3,0)
 ;;=3^Malig Neop of Upper-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,14845,1,4,0)
 ;;=4^C50.222
 ;;^UTILITY(U,$J,358.3,14845,2)
 ;;=^5001175
 ;;^UTILITY(U,$J,358.3,14846,0)
 ;;=C50.321^^85^798^8
 ;;^UTILITY(U,$J,358.3,14846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14846,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,14846,1,4,0)
 ;;=4^C50.321
 ;;^UTILITY(U,$J,358.3,14846,2)
 ;;=^5001178
 ;;^UTILITY(U,$J,358.3,14847,0)
 ;;=C50.322^^85^798^7
 ;;^UTILITY(U,$J,358.3,14847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14847,1,3,0)
 ;;=3^Malig Neop of Lower-Inner Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,14847,1,4,0)
 ;;=4^C50.322
 ;;^UTILITY(U,$J,358.3,14847,2)
 ;;=^5133334
 ;;^UTILITY(U,$J,358.3,14848,0)
 ;;=C50.421^^85^798^19
 ;;^UTILITY(U,$J,358.3,14848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14848,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,14848,1,4,0)
 ;;=4^C50.421
 ;;^UTILITY(U,$J,358.3,14848,2)
 ;;=^5001180
 ;;^UTILITY(U,$J,358.3,14849,0)
 ;;=C50.422^^85^798^18
 ;;^UTILITY(U,$J,358.3,14849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14849,1,3,0)
 ;;=3^Malig Neop of Upper-Outer Quadrant of Left Breast
 ;;^UTILITY(U,$J,358.3,14849,1,4,0)
 ;;=4^C50.422
 ;;^UTILITY(U,$J,358.3,14849,2)
 ;;=^5133336
 ;;^UTILITY(U,$J,358.3,14850,0)
 ;;=C50.521^^85^798^10
 ;;^UTILITY(U,$J,358.3,14850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14850,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Right Breast
 ;;^UTILITY(U,$J,358.3,14850,1,4,0)
 ;;=4^C50.521
 ;;^UTILITY(U,$J,358.3,14850,2)
 ;;=^5001182
 ;;^UTILITY(U,$J,358.3,14851,0)
 ;;=C50.522^^85^798^9
 ;;^UTILITY(U,$J,358.3,14851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14851,1,3,0)
 ;;=3^Malig Neop of Lower-Outer Quadrant of Left Breast
