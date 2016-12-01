IBDEI0SI ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37629,1,3,0)
 ;;=3^Contus/lac/hem brnst w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,37629,1,4,0)
 ;;=4^S06.380S
 ;;^UTILITY(U,$J,358.3,37629,2)
 ;;=^5020998
 ;;^UTILITY(U,$J,358.3,37630,0)
 ;;=S06.375S^^106^1592^37
 ;;^UTILITY(U,$J,358.3,37630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37630,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,37630,1,4,0)
 ;;=4^S06.375S
 ;;^UTILITY(U,$J,358.3,37630,2)
 ;;=^5020983
 ;;^UTILITY(U,$J,358.3,37631,0)
 ;;=S06.376S^^106^1592^38
 ;;^UTILITY(U,$J,358.3,37631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37631,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,37631,1,4,0)
 ;;=4^S06.376S
 ;;^UTILITY(U,$J,358.3,37631,2)
 ;;=^5020986
 ;;^UTILITY(U,$J,358.3,37632,0)
 ;;=S06.373S^^106^1592^39
 ;;^UTILITY(U,$J,358.3,37632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37632,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,37632,1,4,0)
 ;;=4^S06.373S
 ;;^UTILITY(U,$J,358.3,37632,2)
 ;;=^5020977
 ;;^UTILITY(U,$J,358.3,37633,0)
 ;;=S06.371S^^106^1592^40
 ;;^UTILITY(U,$J,358.3,37633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37633,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,37633,1,4,0)
 ;;=4^S06.371S
 ;;^UTILITY(U,$J,358.3,37633,2)
 ;;=^5020971
 ;;^UTILITY(U,$J,358.3,37634,0)
 ;;=S06.372S^^106^1592^41
 ;;^UTILITY(U,$J,358.3,37634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37634,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,37634,1,4,0)
 ;;=4^S06.372S
 ;;^UTILITY(U,$J,358.3,37634,2)
 ;;=^5020974
 ;;^UTILITY(U,$J,358.3,37635,0)
 ;;=S06.374S^^106^1592^42
 ;;^UTILITY(U,$J,358.3,37635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37635,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,37635,1,4,0)
 ;;=4^S06.374S
 ;;^UTILITY(U,$J,358.3,37635,2)
 ;;=^5020980
 ;;^UTILITY(U,$J,358.3,37636,0)
 ;;=S06.377S^^106^1592^44
 ;;^UTILITY(U,$J,358.3,37636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37636,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC w dth d/t brain inj bf consc,sqla
 ;;^UTILITY(U,$J,358.3,37636,1,4,0)
 ;;=4^S06.377S
 ;;^UTILITY(U,$J,358.3,37636,2)
 ;;=^5020989
 ;;^UTILITY(U,$J,358.3,37637,0)
 ;;=S06.378S^^106^1592^45
 ;;^UTILITY(U,$J,358.3,37637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37637,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC w dth d/t oth cause bf consc,sqla
 ;;^UTILITY(U,$J,358.3,37637,1,4,0)
 ;;=4^S06.378S
 ;;^UTILITY(U,$J,358.3,37637,2)
 ;;=^5020992
 ;;^UTILITY(U,$J,358.3,37638,0)
 ;;=S06.379S^^106^1592^43
 ;;^UTILITY(U,$J,358.3,37638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37638,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,37638,1,4,0)
 ;;=4^S06.379S
 ;;^UTILITY(U,$J,358.3,37638,2)
 ;;=^5020995
 ;;^UTILITY(U,$J,358.3,37639,0)
 ;;=S06.370S^^106^1592^46
 ;;^UTILITY(U,$J,358.3,37639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37639,1,3,0)
 ;;=3^Contus/lac/hem crblm w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,37639,1,4,0)
 ;;=4^S06.370S
 ;;^UTILITY(U,$J,358.3,37639,2)
 ;;=^5020968
 ;;^UTILITY(U,$J,358.3,37640,0)
 ;;=S06.2X5S^^106^1592^47
 ;;^UTILITY(U,$J,358.3,37640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37640,1,3,0)
 ;;=3^Diffuse TBI w LOC >24 hr w return to consc levels, sequela
 ;;^UTILITY(U,$J,358.3,37640,1,4,0)
 ;;=4^S06.2X5S
 ;;^UTILITY(U,$J,358.3,37640,2)
 ;;=^5020743
 ;;^UTILITY(U,$J,358.3,37641,0)
 ;;=S06.2X6S^^106^1592^48
 ;;^UTILITY(U,$J,358.3,37641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37641,1,3,0)
 ;;=3^Diffuse TBI w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,37641,1,4,0)
 ;;=4^S06.2X6S
 ;;^UTILITY(U,$J,358.3,37641,2)
 ;;=^5020746
 ;;^UTILITY(U,$J,358.3,37642,0)
 ;;=S06.2X3S^^106^1592^49
 ;;^UTILITY(U,$J,358.3,37642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37642,1,3,0)
 ;;=3^Diffuse TBI w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,37642,1,4,0)
 ;;=4^S06.2X3S
 ;;^UTILITY(U,$J,358.3,37642,2)
 ;;=^5020737
 ;;^UTILITY(U,$J,358.3,37643,0)
 ;;=S06.2X1S^^106^1592^50
 ;;^UTILITY(U,$J,358.3,37643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37643,1,3,0)
 ;;=3^Diffuse TBI w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,37643,1,4,0)
 ;;=4^S06.2X1S
 ;;^UTILITY(U,$J,358.3,37643,2)
 ;;=^5020731
 ;;^UTILITY(U,$J,358.3,37644,0)
 ;;=S06.2X2S^^106^1592^51
 ;;^UTILITY(U,$J,358.3,37644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37644,1,3,0)
 ;;=3^Diffuse TBI w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,37644,1,4,0)
 ;;=4^S06.2X2S
 ;;^UTILITY(U,$J,358.3,37644,2)
 ;;=^5020734
 ;;^UTILITY(U,$J,358.3,37645,0)
 ;;=S06.2X4S^^106^1592^52
 ;;^UTILITY(U,$J,358.3,37645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37645,1,3,0)
 ;;=3^Diffuse TBI w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,37645,1,4,0)
 ;;=4^S06.2X4S
 ;;^UTILITY(U,$J,358.3,37645,2)
 ;;=^5020740
 ;;^UTILITY(U,$J,358.3,37646,0)
 ;;=S06.2X9S^^106^1592^53
 ;;^UTILITY(U,$J,358.3,37646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37646,1,3,0)
 ;;=3^Diffuse TBI w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,37646,1,4,0)
 ;;=4^S06.2X9S
 ;;^UTILITY(U,$J,358.3,37646,2)
 ;;=^5020755
 ;;^UTILITY(U,$J,358.3,37647,0)
 ;;=S06.2X0S^^106^1592^54
 ;;^UTILITY(U,$J,358.3,37647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37647,1,3,0)
 ;;=3^Diffuse TBI w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,37647,1,4,0)
 ;;=4^S06.2X0S
 ;;^UTILITY(U,$J,358.3,37647,2)
 ;;=^5020728
 ;;^UTILITY(U,$J,358.3,37648,0)
 ;;=S06.4X5S^^106^1592^55
 ;;^UTILITY(U,$J,358.3,37648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37648,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,37648,1,4,0)
 ;;=4^S06.4X5S
 ;;^UTILITY(U,$J,358.3,37648,2)
 ;;=^5021043
 ;;^UTILITY(U,$J,358.3,37649,0)
 ;;=S06.4X6S^^106^1592^56
 ;;^UTILITY(U,$J,358.3,37649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37649,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,37649,1,4,0)
 ;;=4^S06.4X6S
 ;;^UTILITY(U,$J,358.3,37649,2)
 ;;=^5021046
 ;;^UTILITY(U,$J,358.3,37650,0)
 ;;=S06.4X3S^^106^1592^57
 ;;^UTILITY(U,$J,358.3,37650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37650,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,37650,1,4,0)
 ;;=4^S06.4X3S
 ;;^UTILITY(U,$J,358.3,37650,2)
 ;;=^5021037
 ;;^UTILITY(U,$J,358.3,37651,0)
 ;;=S06.4X1S^^106^1592^58
 ;;^UTILITY(U,$J,358.3,37651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37651,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,37651,1,4,0)
 ;;=4^S06.4X1S
 ;;^UTILITY(U,$J,358.3,37651,2)
 ;;=^5021031
 ;;^UTILITY(U,$J,358.3,37652,0)
 ;;=S06.4X2S^^106^1592^59
 ;;^UTILITY(U,$J,358.3,37652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37652,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,37652,1,4,0)
 ;;=4^S06.4X2S
 ;;^UTILITY(U,$J,358.3,37652,2)
 ;;=^5021034
 ;;^UTILITY(U,$J,358.3,37653,0)
 ;;=S06.4X4S^^106^1592^60
 ;;^UTILITY(U,$J,358.3,37653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37653,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,37653,1,4,0)
 ;;=4^S06.4X4S
 ;;^UTILITY(U,$J,358.3,37653,2)
 ;;=^5021040
 ;;^UTILITY(U,$J,358.3,37654,0)
 ;;=S06.4X9S^^106^1592^61
 ;;^UTILITY(U,$J,358.3,37654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37654,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,37654,1,4,0)
 ;;=4^S06.4X9S
 ;;^UTILITY(U,$J,358.3,37654,2)
 ;;=^5021055
 ;;^UTILITY(U,$J,358.3,37655,0)
 ;;=S06.4X0S^^106^1592^62
 ;;^UTILITY(U,$J,358.3,37655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37655,1,3,0)
 ;;=3^Epidural hemorrhage without LOC, sequela
 ;;^UTILITY(U,$J,358.3,37655,1,4,0)
 ;;=4^S06.4X0S
 ;;^UTILITY(U,$J,358.3,37655,2)
 ;;=^5021028
 ;;^UTILITY(U,$J,358.3,37656,0)
 ;;=S06.825S^^106^1592^63
 ;;^UTILITY(U,$J,358.3,37656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37656,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,37656,1,4,0)
 ;;=4^S06.825S
 ;;^UTILITY(U,$J,358.3,37656,2)
 ;;=^5021163
 ;;^UTILITY(U,$J,358.3,37657,0)
 ;;=S06.826S^^106^1592^64
 ;;^UTILITY(U,$J,358.3,37657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37657,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,37657,1,4,0)
 ;;=4^S06.826S
 ;;^UTILITY(U,$J,358.3,37657,2)
 ;;=^5021166
 ;;^UTILITY(U,$J,358.3,37658,0)
 ;;=S06.823S^^106^1592^65
 ;;^UTILITY(U,$J,358.3,37658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37658,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,37658,1,4,0)
 ;;=4^S06.823S
 ;;^UTILITY(U,$J,358.3,37658,2)
 ;;=^5021157
 ;;^UTILITY(U,$J,358.3,37659,0)
 ;;=S06.821S^^106^1592^66
 ;;^UTILITY(U,$J,358.3,37659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37659,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,37659,1,4,0)
 ;;=4^S06.821S
 ;;^UTILITY(U,$J,358.3,37659,2)
 ;;=^5021151
 ;;^UTILITY(U,$J,358.3,37660,0)
 ;;=S06.822S^^106^1592^67
 ;;^UTILITY(U,$J,358.3,37660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37660,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,37660,1,4,0)
 ;;=4^S06.822S
 ;;^UTILITY(U,$J,358.3,37660,2)
 ;;=^5021154
 ;;^UTILITY(U,$J,358.3,37661,0)
 ;;=S06.824S^^106^1592^68
 ;;^UTILITY(U,$J,358.3,37661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37661,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 6-24 hrs, sequela
