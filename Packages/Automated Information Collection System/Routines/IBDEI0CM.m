IBDEI0CM ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15975,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC w dth d/t oth cause bf consc,sqla
 ;;^UTILITY(U,$J,358.3,15975,1,4,0)
 ;;=4^S06.378S
 ;;^UTILITY(U,$J,358.3,15975,2)
 ;;=^5020992
 ;;^UTILITY(U,$J,358.3,15976,0)
 ;;=S06.379S^^47^708^43
 ;;^UTILITY(U,$J,358.3,15976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15976,1,3,0)
 ;;=3^Contus/lac/hem crblm w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,15976,1,4,0)
 ;;=4^S06.379S
 ;;^UTILITY(U,$J,358.3,15976,2)
 ;;=^5020995
 ;;^UTILITY(U,$J,358.3,15977,0)
 ;;=S06.370S^^47^708^46
 ;;^UTILITY(U,$J,358.3,15977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15977,1,3,0)
 ;;=3^Contus/lac/hem crblm w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,15977,1,4,0)
 ;;=4^S06.370S
 ;;^UTILITY(U,$J,358.3,15977,2)
 ;;=^5020968
 ;;^UTILITY(U,$J,358.3,15978,0)
 ;;=S06.2X5S^^47^708^47
 ;;^UTILITY(U,$J,358.3,15978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15978,1,3,0)
 ;;=3^Diffuse TBI w LOC >24 hr w return to consc levels, sequela
 ;;^UTILITY(U,$J,358.3,15978,1,4,0)
 ;;=4^S06.2X5S
 ;;^UTILITY(U,$J,358.3,15978,2)
 ;;=^5020743
 ;;^UTILITY(U,$J,358.3,15979,0)
 ;;=S06.2X6S^^47^708^48
 ;;^UTILITY(U,$J,358.3,15979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15979,1,3,0)
 ;;=3^Diffuse TBI w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,15979,1,4,0)
 ;;=4^S06.2X6S
 ;;^UTILITY(U,$J,358.3,15979,2)
 ;;=^5020746
 ;;^UTILITY(U,$J,358.3,15980,0)
 ;;=S06.2X3S^^47^708^49
 ;;^UTILITY(U,$J,358.3,15980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15980,1,3,0)
 ;;=3^Diffuse TBI w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,15980,1,4,0)
 ;;=4^S06.2X3S
 ;;^UTILITY(U,$J,358.3,15980,2)
 ;;=^5020737
 ;;^UTILITY(U,$J,358.3,15981,0)
 ;;=S06.2X1S^^47^708^50
 ;;^UTILITY(U,$J,358.3,15981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15981,1,3,0)
 ;;=3^Diffuse TBI w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,15981,1,4,0)
 ;;=4^S06.2X1S
 ;;^UTILITY(U,$J,358.3,15981,2)
 ;;=^5020731
 ;;^UTILITY(U,$J,358.3,15982,0)
 ;;=S06.2X2S^^47^708^51
 ;;^UTILITY(U,$J,358.3,15982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15982,1,3,0)
 ;;=3^Diffuse TBI w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,15982,1,4,0)
 ;;=4^S06.2X2S
 ;;^UTILITY(U,$J,358.3,15982,2)
 ;;=^5020734
 ;;^UTILITY(U,$J,358.3,15983,0)
 ;;=S06.2X4S^^47^708^52
 ;;^UTILITY(U,$J,358.3,15983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15983,1,3,0)
 ;;=3^Diffuse TBI w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,15983,1,4,0)
 ;;=4^S06.2X4S
 ;;^UTILITY(U,$J,358.3,15983,2)
 ;;=^5020740
 ;;^UTILITY(U,$J,358.3,15984,0)
 ;;=S06.2X9S^^47^708^53
 ;;^UTILITY(U,$J,358.3,15984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15984,1,3,0)
 ;;=3^Diffuse TBI w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,15984,1,4,0)
 ;;=4^S06.2X9S
 ;;^UTILITY(U,$J,358.3,15984,2)
 ;;=^5020755
 ;;^UTILITY(U,$J,358.3,15985,0)
 ;;=S06.2X0S^^47^708^54
 ;;^UTILITY(U,$J,358.3,15985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15985,1,3,0)
 ;;=3^Diffuse TBI w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,15985,1,4,0)
 ;;=4^S06.2X0S
 ;;^UTILITY(U,$J,358.3,15985,2)
 ;;=^5020728
 ;;^UTILITY(U,$J,358.3,15986,0)
 ;;=S06.4X5S^^47^708^55
 ;;^UTILITY(U,$J,358.3,15986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15986,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,15986,1,4,0)
 ;;=4^S06.4X5S
 ;;^UTILITY(U,$J,358.3,15986,2)
 ;;=^5021043
 ;;^UTILITY(U,$J,358.3,15987,0)
 ;;=S06.4X6S^^47^708^56
 ;;^UTILITY(U,$J,358.3,15987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15987,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,15987,1,4,0)
 ;;=4^S06.4X6S
 ;;^UTILITY(U,$J,358.3,15987,2)
 ;;=^5021046
 ;;^UTILITY(U,$J,358.3,15988,0)
 ;;=S06.4X3S^^47^708^57
 ;;^UTILITY(U,$J,358.3,15988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15988,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,15988,1,4,0)
 ;;=4^S06.4X3S
 ;;^UTILITY(U,$J,358.3,15988,2)
 ;;=^5021037
 ;;^UTILITY(U,$J,358.3,15989,0)
 ;;=S06.4X1S^^47^708^58
 ;;^UTILITY(U,$J,358.3,15989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15989,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,15989,1,4,0)
 ;;=4^S06.4X1S
 ;;^UTILITY(U,$J,358.3,15989,2)
 ;;=^5021031
 ;;^UTILITY(U,$J,358.3,15990,0)
 ;;=S06.4X2S^^47^708^59
 ;;^UTILITY(U,$J,358.3,15990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15990,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,15990,1,4,0)
 ;;=4^S06.4X2S
 ;;^UTILITY(U,$J,358.3,15990,2)
 ;;=^5021034
 ;;^UTILITY(U,$J,358.3,15991,0)
 ;;=S06.4X4S^^47^708^60
 ;;^UTILITY(U,$J,358.3,15991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15991,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,15991,1,4,0)
 ;;=4^S06.4X4S
 ;;^UTILITY(U,$J,358.3,15991,2)
 ;;=^5021040
 ;;^UTILITY(U,$J,358.3,15992,0)
 ;;=S06.4X9S^^47^708^61
 ;;^UTILITY(U,$J,358.3,15992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15992,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,15992,1,4,0)
 ;;=4^S06.4X9S
 ;;^UTILITY(U,$J,358.3,15992,2)
 ;;=^5021055
 ;;^UTILITY(U,$J,358.3,15993,0)
 ;;=S06.4X0S^^47^708^62
 ;;^UTILITY(U,$J,358.3,15993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15993,1,3,0)
 ;;=3^Epidural hemorrhage without LOC, sequela
 ;;^UTILITY(U,$J,358.3,15993,1,4,0)
 ;;=4^S06.4X0S
 ;;^UTILITY(U,$J,358.3,15993,2)
 ;;=^5021028
 ;;^UTILITY(U,$J,358.3,15994,0)
 ;;=S06.825S^^47^708^63
 ;;^UTILITY(U,$J,358.3,15994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15994,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,15994,1,4,0)
 ;;=4^S06.825S
 ;;^UTILITY(U,$J,358.3,15994,2)
 ;;=^5021163
 ;;^UTILITY(U,$J,358.3,15995,0)
 ;;=S06.826S^^47^708^64
 ;;^UTILITY(U,$J,358.3,15995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15995,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,15995,1,4,0)
 ;;=4^S06.826S
 ;;^UTILITY(U,$J,358.3,15995,2)
 ;;=^5021166
 ;;^UTILITY(U,$J,358.3,15996,0)
 ;;=S06.823S^^47^708^65
 ;;^UTILITY(U,$J,358.3,15996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15996,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,15996,1,4,0)
 ;;=4^S06.823S
 ;;^UTILITY(U,$J,358.3,15996,2)
 ;;=^5021157
 ;;^UTILITY(U,$J,358.3,15997,0)
 ;;=S06.821S^^47^708^66
 ;;^UTILITY(U,$J,358.3,15997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15997,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,15997,1,4,0)
 ;;=4^S06.821S
 ;;^UTILITY(U,$J,358.3,15997,2)
 ;;=^5021151
 ;;^UTILITY(U,$J,358.3,15998,0)
 ;;=S06.822S^^47^708^67
 ;;^UTILITY(U,$J,358.3,15998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15998,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,15998,1,4,0)
 ;;=4^S06.822S
 ;;^UTILITY(U,$J,358.3,15998,2)
 ;;=^5021154
 ;;^UTILITY(U,$J,358.3,15999,0)
 ;;=S06.824S^^47^708^68
 ;;^UTILITY(U,$J,358.3,15999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15999,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,15999,1,4,0)
 ;;=4^S06.824S
 ;;^UTILITY(U,$J,358.3,15999,2)
 ;;=^5021160
 ;;^UTILITY(U,$J,358.3,16000,0)
 ;;=S06.829S^^47^708^69
 ;;^UTILITY(U,$J,358.3,16000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16000,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,16000,1,4,0)
 ;;=4^S06.829S
 ;;^UTILITY(U,$J,358.3,16000,2)
 ;;=^5021175
 ;;^UTILITY(U,$J,358.3,16001,0)
 ;;=S06.820S^^47^708^70
 ;;^UTILITY(U,$J,358.3,16001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16001,1,3,0)
 ;;=3^Inj left int carotid, intcr w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,16001,1,4,0)
 ;;=4^S06.820S
 ;;^UTILITY(U,$J,358.3,16001,2)
 ;;=^5021148
 ;;^UTILITY(U,$J,358.3,16002,0)
 ;;=S06.815S^^47^708^71
 ;;^UTILITY(U,$J,358.3,16002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16002,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,16002,1,4,0)
 ;;=4^S06.815S
 ;;^UTILITY(U,$J,358.3,16002,2)
 ;;=^5021133
 ;;^UTILITY(U,$J,358.3,16003,0)
 ;;=S06.816S^^47^708^72
 ;;^UTILITY(U,$J,358.3,16003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16003,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,16003,1,4,0)
 ;;=4^S06.816S
 ;;^UTILITY(U,$J,358.3,16003,2)
 ;;=^5021136
 ;;^UTILITY(U,$J,358.3,16004,0)
 ;;=S06.813S^^47^708^73
 ;;^UTILITY(U,$J,358.3,16004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16004,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,16004,1,4,0)
 ;;=4^S06.813S
 ;;^UTILITY(U,$J,358.3,16004,2)
 ;;=^5021127
 ;;^UTILITY(U,$J,358.3,16005,0)
 ;;=S06.811S^^47^708^74
 ;;^UTILITY(U,$J,358.3,16005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16005,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,16005,1,4,0)
 ;;=4^S06.811S
 ;;^UTILITY(U,$J,358.3,16005,2)
 ;;=^5021121
 ;;^UTILITY(U,$J,358.3,16006,0)
 ;;=S06.812S^^47^708^75
 ;;^UTILITY(U,$J,358.3,16006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16006,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,16006,1,4,0)
 ;;=4^S06.812S
 ;;^UTILITY(U,$J,358.3,16006,2)
 ;;=^5021124
 ;;^UTILITY(U,$J,358.3,16007,0)
 ;;=S06.814S^^47^708^76
 ;;^UTILITY(U,$J,358.3,16007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16007,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 6-24 hrs, sequela
