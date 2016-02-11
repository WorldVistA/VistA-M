IBDEI2WR ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48816,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,48816,1,4,0)
 ;;=4^S06.375S
 ;;^UTILITY(U,$J,358.3,48816,2)
 ;;=^5020983
 ;;^UTILITY(U,$J,358.3,48817,0)
 ;;=S06.376S^^216^2412^38
 ;;^UTILITY(U,$J,358.3,48817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48817,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,48817,1,4,0)
 ;;=4^S06.376S
 ;;^UTILITY(U,$J,358.3,48817,2)
 ;;=^5020986
 ;;^UTILITY(U,$J,358.3,48818,0)
 ;;=S06.373S^^216^2412^39
 ;;^UTILITY(U,$J,358.3,48818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48818,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,48818,1,4,0)
 ;;=4^S06.373S
 ;;^UTILITY(U,$J,358.3,48818,2)
 ;;=^5020977
 ;;^UTILITY(U,$J,358.3,48819,0)
 ;;=S06.371S^^216^2412^40
 ;;^UTILITY(U,$J,358.3,48819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48819,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,48819,1,4,0)
 ;;=4^S06.371S
 ;;^UTILITY(U,$J,358.3,48819,2)
 ;;=^5020971
 ;;^UTILITY(U,$J,358.3,48820,0)
 ;;=S06.372S^^216^2412^41
 ;;^UTILITY(U,$J,358.3,48820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48820,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,48820,1,4,0)
 ;;=4^S06.372S
 ;;^UTILITY(U,$J,358.3,48820,2)
 ;;=^5020974
 ;;^UTILITY(U,$J,358.3,48821,0)
 ;;=S06.374S^^216^2412^42
 ;;^UTILITY(U,$J,358.3,48821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48821,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,48821,1,4,0)
 ;;=4^S06.374S
 ;;^UTILITY(U,$J,358.3,48821,2)
 ;;=^5020980
 ;;^UTILITY(U,$J,358.3,48822,0)
 ;;=S06.377S^^216^2412^44
 ;;^UTILITY(U,$J,358.3,48822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48822,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC w dth d/t brain inj bf consc,sqla
 ;;^UTILITY(U,$J,358.3,48822,1,4,0)
 ;;=4^S06.377S
 ;;^UTILITY(U,$J,358.3,48822,2)
 ;;=^5020989
 ;;^UTILITY(U,$J,358.3,48823,0)
 ;;=S06.378S^^216^2412^45
 ;;^UTILITY(U,$J,358.3,48823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48823,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC w dth d/t oth cause bf consc,sqla
 ;;^UTILITY(U,$J,358.3,48823,1,4,0)
 ;;=4^S06.378S
 ;;^UTILITY(U,$J,358.3,48823,2)
 ;;=^5020992
 ;;^UTILITY(U,$J,358.3,48824,0)
 ;;=S06.379S^^216^2412^43
 ;;^UTILITY(U,$J,358.3,48824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48824,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,48824,1,4,0)
 ;;=4^S06.379S
 ;;^UTILITY(U,$J,358.3,48824,2)
 ;;=^5020995
 ;;^UTILITY(U,$J,358.3,48825,0)
 ;;=S06.370S^^216^2412^46
 ;;^UTILITY(U,$J,358.3,48825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48825,1,3,0)
 ;;=3^Contus/lac/hem crblm w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,48825,1,4,0)
 ;;=4^S06.370S
 ;;^UTILITY(U,$J,358.3,48825,2)
 ;;=^5020968
 ;;^UTILITY(U,$J,358.3,48826,0)
 ;;=S06.2X5S^^216^2412^47
 ;;^UTILITY(U,$J,358.3,48826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48826,1,3,0)
 ;;=3^Diffuse TBI w LOC >24 hr w return to consc levels, sequela
 ;;^UTILITY(U,$J,358.3,48826,1,4,0)
 ;;=4^S06.2X5S
 ;;^UTILITY(U,$J,358.3,48826,2)
 ;;=^5020743
 ;;^UTILITY(U,$J,358.3,48827,0)
 ;;=S06.2X6S^^216^2412^48
 ;;^UTILITY(U,$J,358.3,48827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48827,1,3,0)
 ;;=3^Diffuse TBI w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,48827,1,4,0)
 ;;=4^S06.2X6S
 ;;^UTILITY(U,$J,358.3,48827,2)
 ;;=^5020746
 ;;^UTILITY(U,$J,358.3,48828,0)
 ;;=S06.2X3S^^216^2412^49
