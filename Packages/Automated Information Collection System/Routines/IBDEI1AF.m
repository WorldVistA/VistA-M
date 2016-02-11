IBDEI1AF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21516,1,4,0)
 ;;=4^S06.371S
 ;;^UTILITY(U,$J,358.3,21516,2)
 ;;=^5020971
 ;;^UTILITY(U,$J,358.3,21517,0)
 ;;=S06.372S^^101^1032^41
 ;;^UTILITY(U,$J,358.3,21517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21517,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,21517,1,4,0)
 ;;=4^S06.372S
 ;;^UTILITY(U,$J,358.3,21517,2)
 ;;=^5020974
 ;;^UTILITY(U,$J,358.3,21518,0)
 ;;=S06.374S^^101^1032^42
 ;;^UTILITY(U,$J,358.3,21518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21518,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,21518,1,4,0)
 ;;=4^S06.374S
 ;;^UTILITY(U,$J,358.3,21518,2)
 ;;=^5020980
 ;;^UTILITY(U,$J,358.3,21519,0)
 ;;=S06.377S^^101^1032^44
 ;;^UTILITY(U,$J,358.3,21519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21519,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC w dth d/t brain inj bf consc,sqla
 ;;^UTILITY(U,$J,358.3,21519,1,4,0)
 ;;=4^S06.377S
 ;;^UTILITY(U,$J,358.3,21519,2)
 ;;=^5020989
 ;;^UTILITY(U,$J,358.3,21520,0)
 ;;=S06.378S^^101^1032^45
 ;;^UTILITY(U,$J,358.3,21520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21520,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC w dth d/t oth cause bf consc,sqla
 ;;^UTILITY(U,$J,358.3,21520,1,4,0)
 ;;=4^S06.378S
 ;;^UTILITY(U,$J,358.3,21520,2)
 ;;=^5020992
 ;;^UTILITY(U,$J,358.3,21521,0)
 ;;=S06.379S^^101^1032^43
 ;;^UTILITY(U,$J,358.3,21521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21521,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,21521,1,4,0)
 ;;=4^S06.379S
 ;;^UTILITY(U,$J,358.3,21521,2)
 ;;=^5020995
 ;;^UTILITY(U,$J,358.3,21522,0)
 ;;=S06.370S^^101^1032^46
 ;;^UTILITY(U,$J,358.3,21522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21522,1,3,0)
 ;;=3^Contus/lac/hem crblm w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,21522,1,4,0)
 ;;=4^S06.370S
 ;;^UTILITY(U,$J,358.3,21522,2)
 ;;=^5020968
 ;;^UTILITY(U,$J,358.3,21523,0)
 ;;=S06.2X5S^^101^1032^47
 ;;^UTILITY(U,$J,358.3,21523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21523,1,3,0)
 ;;=3^Diffuse TBI w LOC >24 hr w return to consc levels, sequela
 ;;^UTILITY(U,$J,358.3,21523,1,4,0)
 ;;=4^S06.2X5S
 ;;^UTILITY(U,$J,358.3,21523,2)
 ;;=^5020743
 ;;^UTILITY(U,$J,358.3,21524,0)
 ;;=S06.2X6S^^101^1032^48
 ;;^UTILITY(U,$J,358.3,21524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21524,1,3,0)
 ;;=3^Diffuse TBI w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,21524,1,4,0)
 ;;=4^S06.2X6S
 ;;^UTILITY(U,$J,358.3,21524,2)
 ;;=^5020746
 ;;^UTILITY(U,$J,358.3,21525,0)
 ;;=S06.2X3S^^101^1032^49
 ;;^UTILITY(U,$J,358.3,21525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21525,1,3,0)
 ;;=3^Diffuse TBI w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,21525,1,4,0)
 ;;=4^S06.2X3S
 ;;^UTILITY(U,$J,358.3,21525,2)
 ;;=^5020737
 ;;^UTILITY(U,$J,358.3,21526,0)
 ;;=S06.2X1S^^101^1032^50
 ;;^UTILITY(U,$J,358.3,21526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21526,1,3,0)
 ;;=3^Diffuse TBI w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,21526,1,4,0)
 ;;=4^S06.2X1S
 ;;^UTILITY(U,$J,358.3,21526,2)
 ;;=^5020731
 ;;^UTILITY(U,$J,358.3,21527,0)
 ;;=S06.2X2S^^101^1032^51
 ;;^UTILITY(U,$J,358.3,21527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21527,1,3,0)
 ;;=3^Diffuse TBI w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,21527,1,4,0)
 ;;=4^S06.2X2S
 ;;^UTILITY(U,$J,358.3,21527,2)
 ;;=^5020734
 ;;^UTILITY(U,$J,358.3,21528,0)
 ;;=S06.2X4S^^101^1032^52
 ;;^UTILITY(U,$J,358.3,21528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21528,1,3,0)
 ;;=3^Diffuse TBI w LOC of 6 hours to 24 hours, sequela
