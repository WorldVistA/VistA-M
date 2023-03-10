IBDEI188 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19907,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,19907,1,4,0)
 ;;=4^S06.375S
 ;;^UTILITY(U,$J,358.3,19907,2)
 ;;=^5020983
 ;;^UTILITY(U,$J,358.3,19908,0)
 ;;=S06.376S^^67^882^33
 ;;^UTILITY(U,$J,358.3,19908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19908,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,19908,1,4,0)
 ;;=4^S06.376S
 ;;^UTILITY(U,$J,358.3,19908,2)
 ;;=^5020986
 ;;^UTILITY(U,$J,358.3,19909,0)
 ;;=S06.373S^^67^882^34
 ;;^UTILITY(U,$J,358.3,19909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19909,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19909,1,4,0)
 ;;=4^S06.373S
 ;;^UTILITY(U,$J,358.3,19909,2)
 ;;=^5020977
 ;;^UTILITY(U,$J,358.3,19910,0)
 ;;=S06.371S^^67^882^35
 ;;^UTILITY(U,$J,358.3,19910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19910,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,19910,1,4,0)
 ;;=4^S06.371S
 ;;^UTILITY(U,$J,358.3,19910,2)
 ;;=^5020971
 ;;^UTILITY(U,$J,358.3,19911,0)
 ;;=S06.372S^^67^882^36
 ;;^UTILITY(U,$J,358.3,19911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19911,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,19911,1,4,0)
 ;;=4^S06.372S
 ;;^UTILITY(U,$J,358.3,19911,2)
 ;;=^5020974
 ;;^UTILITY(U,$J,358.3,19912,0)
 ;;=S06.374S^^67^882^37
 ;;^UTILITY(U,$J,358.3,19912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19912,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,19912,1,4,0)
 ;;=4^S06.374S
 ;;^UTILITY(U,$J,358.3,19912,2)
 ;;=^5020980
 ;;^UTILITY(U,$J,358.3,19913,0)
 ;;=S06.379S^^67^882^38
 ;;^UTILITY(U,$J,358.3,19913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19913,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,19913,1,4,0)
 ;;=4^S06.379S
 ;;^UTILITY(U,$J,358.3,19913,2)
 ;;=^5020995
 ;;^UTILITY(U,$J,358.3,19914,0)
 ;;=S06.370S^^67^882^39
 ;;^UTILITY(U,$J,358.3,19914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19914,1,3,0)
 ;;=3^Contus/lac/hem crblm w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,19914,1,4,0)
 ;;=4^S06.370S
 ;;^UTILITY(U,$J,358.3,19914,2)
 ;;=^5020968
 ;;^UTILITY(U,$J,358.3,19915,0)
 ;;=S06.2X5S^^67^882^40
 ;;^UTILITY(U,$J,358.3,19915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19915,1,3,0)
 ;;=3^Diffuse TBI w LOC >24 hr w return to consc levels, sequela
 ;;^UTILITY(U,$J,358.3,19915,1,4,0)
 ;;=4^S06.2X5S
 ;;^UTILITY(U,$J,358.3,19915,2)
 ;;=^5020743
 ;;^UTILITY(U,$J,358.3,19916,0)
 ;;=S06.2X6S^^67^882^41
 ;;^UTILITY(U,$J,358.3,19916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19916,1,3,0)
 ;;=3^Diffuse TBI w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,19916,1,4,0)
 ;;=4^S06.2X6S
 ;;^UTILITY(U,$J,358.3,19916,2)
 ;;=^5020746
 ;;^UTILITY(U,$J,358.3,19917,0)
 ;;=S06.2X3S^^67^882^42
 ;;^UTILITY(U,$J,358.3,19917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19917,1,3,0)
 ;;=3^Diffuse TBI w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,19917,1,4,0)
 ;;=4^S06.2X3S
 ;;^UTILITY(U,$J,358.3,19917,2)
 ;;=^5020737
 ;;^UTILITY(U,$J,358.3,19918,0)
 ;;=S06.2X1S^^67^882^43
 ;;^UTILITY(U,$J,358.3,19918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19918,1,3,0)
 ;;=3^Diffuse TBI w LOC of 30 minutes or less, sequela
