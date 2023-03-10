IBDEI18F ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19986,1,4,0)
 ;;=4^S06.5X0S
 ;;^UTILITY(U,$J,358.3,19986,2)
 ;;=^5021058
 ;;^UTILITY(U,$J,358.3,19987,0)
 ;;=M84.351S^^67^883^114
 ;;^UTILITY(U,$J,358.3,19987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19987,1,3,0)
 ;;=3^Stress fracture, right femur, sequela
 ;;^UTILITY(U,$J,358.3,19987,1,4,0)
 ;;=4^M84.351S
 ;;^UTILITY(U,$J,358.3,19987,2)
 ;;=^5013685
 ;;^UTILITY(U,$J,358.3,19988,0)
 ;;=M84.352S^^67^883^113
 ;;^UTILITY(U,$J,358.3,19988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19988,1,3,0)
 ;;=3^Stress fracture, left femur, sequela
 ;;^UTILITY(U,$J,358.3,19988,1,4,0)
 ;;=4^M84.352S
 ;;^UTILITY(U,$J,358.3,19988,2)
 ;;=^5013691
 ;;^UTILITY(U,$J,358.3,19989,0)
 ;;=M84.451S^^67^883^102
 ;;^UTILITY(U,$J,358.3,19989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19989,1,3,0)
 ;;=3^Pathological fracture, right femur, sequela
 ;;^UTILITY(U,$J,358.3,19989,1,4,0)
 ;;=4^M84.451S
 ;;^UTILITY(U,$J,358.3,19989,2)
 ;;=^5013907
 ;;^UTILITY(U,$J,358.3,19990,0)
 ;;=M84.452S^^67^883^101
 ;;^UTILITY(U,$J,358.3,19990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19990,1,3,0)
 ;;=3^Pathological fracture, left femur, sequela
 ;;^UTILITY(U,$J,358.3,19990,1,4,0)
 ;;=4^M84.452S
 ;;^UTILITY(U,$J,358.3,19990,2)
 ;;=^5013913
 ;;^UTILITY(U,$J,358.3,19991,0)
 ;;=S72.021S^^67^883^17
 ;;^UTILITY(U,$J,358.3,19991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19991,1,3,0)
 ;;=3^Displaced epiphy fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,19991,1,4,0)
 ;;=4^S72.021S
 ;;^UTILITY(U,$J,358.3,19991,2)
 ;;=^5037136
 ;;^UTILITY(U,$J,358.3,19992,0)
 ;;=S72.022S^^67^883^16
 ;;^UTILITY(U,$J,358.3,19992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19992,1,3,0)
 ;;=3^Displaced epiphy fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,19992,1,4,0)
 ;;=4^S72.022S
 ;;^UTILITY(U,$J,358.3,19992,2)
 ;;=^5037152
 ;;^UTILITY(U,$J,358.3,19993,0)
 ;;=S72.024S^^67^883^65
 ;;^UTILITY(U,$J,358.3,19993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19993,1,3,0)
 ;;=3^Nondisp epiphy fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,19993,1,4,0)
 ;;=4^S72.024S
 ;;^UTILITY(U,$J,358.3,19993,2)
 ;;=^5037184
 ;;^UTILITY(U,$J,358.3,19994,0)
 ;;=S72.025S^^67^883^64
 ;;^UTILITY(U,$J,358.3,19994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19994,1,3,0)
 ;;=3^Nondisp epiphy fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,19994,1,4,0)
 ;;=4^S72.025S
 ;;^UTILITY(U,$J,358.3,19994,2)
 ;;=^5037200
 ;;^UTILITY(U,$J,358.3,19995,0)
 ;;=S72.031S^^67^883^33
 ;;^UTILITY(U,$J,358.3,19995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19995,1,3,0)
 ;;=3^Displaced midcervical fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,19995,1,4,0)
 ;;=4^S72.031S
 ;;^UTILITY(U,$J,358.3,19995,2)
 ;;=^5037232
 ;;^UTILITY(U,$J,358.3,19996,0)
 ;;=S72.032S^^67^883^32
 ;;^UTILITY(U,$J,358.3,19996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19996,1,3,0)
 ;;=3^Displaced midcervical fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,19996,1,4,0)
 ;;=4^S72.032S
 ;;^UTILITY(U,$J,358.3,19996,2)
 ;;=^5037248
 ;;^UTILITY(U,$J,358.3,19997,0)
 ;;=S72.034S^^67^883^81
 ;;^UTILITY(U,$J,358.3,19997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19997,1,3,0)
 ;;=3^Nondisp midcervical fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,19997,1,4,0)
 ;;=4^S72.034S
 ;;^UTILITY(U,$J,358.3,19997,2)
 ;;=^5037280
 ;;^UTILITY(U,$J,358.3,19998,0)
 ;;=S72.035S^^67^883^80
 ;;^UTILITY(U,$J,358.3,19998,1,0)
 ;;=^358.31IA^4^2
