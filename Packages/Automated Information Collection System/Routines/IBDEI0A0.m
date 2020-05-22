IBDEI0A0 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24502,1,4,0)
 ;;=4^S06.2X6S
 ;;^UTILITY(U,$J,358.3,24502,2)
 ;;=^5020746
 ;;^UTILITY(U,$J,358.3,24503,0)
 ;;=S06.2X3S^^76^1006^42
 ;;^UTILITY(U,$J,358.3,24503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24503,1,3,0)
 ;;=3^Diffuse TBI w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,24503,1,4,0)
 ;;=4^S06.2X3S
 ;;^UTILITY(U,$J,358.3,24503,2)
 ;;=^5020737
 ;;^UTILITY(U,$J,358.3,24504,0)
 ;;=S06.2X1S^^76^1006^43
 ;;^UTILITY(U,$J,358.3,24504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24504,1,3,0)
 ;;=3^Diffuse TBI w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,24504,1,4,0)
 ;;=4^S06.2X1S
 ;;^UTILITY(U,$J,358.3,24504,2)
 ;;=^5020731
 ;;^UTILITY(U,$J,358.3,24505,0)
 ;;=S06.2X2S^^76^1006^44
 ;;^UTILITY(U,$J,358.3,24505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24505,1,3,0)
 ;;=3^Diffuse TBI w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,24505,1,4,0)
 ;;=4^S06.2X2S
 ;;^UTILITY(U,$J,358.3,24505,2)
 ;;=^5020734
 ;;^UTILITY(U,$J,358.3,24506,0)
 ;;=S06.2X4S^^76^1006^45
 ;;^UTILITY(U,$J,358.3,24506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24506,1,3,0)
 ;;=3^Diffuse TBI w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,24506,1,4,0)
 ;;=4^S06.2X4S
 ;;^UTILITY(U,$J,358.3,24506,2)
 ;;=^5020740
 ;;^UTILITY(U,$J,358.3,24507,0)
 ;;=S06.2X9S^^76^1006^46
 ;;^UTILITY(U,$J,358.3,24507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24507,1,3,0)
 ;;=3^Diffuse TBI w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,24507,1,4,0)
 ;;=4^S06.2X9S
 ;;^UTILITY(U,$J,358.3,24507,2)
 ;;=^5020755
 ;;^UTILITY(U,$J,358.3,24508,0)
 ;;=S06.2X0S^^76^1006^47
 ;;^UTILITY(U,$J,358.3,24508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24508,1,3,0)
 ;;=3^Diffuse TBI w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,24508,1,4,0)
 ;;=4^S06.2X0S
 ;;^UTILITY(U,$J,358.3,24508,2)
 ;;=^5020728
 ;;^UTILITY(U,$J,358.3,24509,0)
 ;;=S06.4X5S^^76^1006^48
 ;;^UTILITY(U,$J,358.3,24509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24509,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,24509,1,4,0)
 ;;=4^S06.4X5S
 ;;^UTILITY(U,$J,358.3,24509,2)
 ;;=^5021043
 ;;^UTILITY(U,$J,358.3,24510,0)
 ;;=S06.4X6S^^76^1006^49
 ;;^UTILITY(U,$J,358.3,24510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24510,1,3,0)
 ;;=3^Epidural hemorrhage w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,24510,1,4,0)
 ;;=4^S06.4X6S
 ;;^UTILITY(U,$J,358.3,24510,2)
 ;;=^5021046
 ;;^UTILITY(U,$J,358.3,24511,0)
 ;;=S06.4X3S^^76^1006^50
 ;;^UTILITY(U,$J,358.3,24511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24511,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,24511,1,4,0)
 ;;=4^S06.4X3S
 ;;^UTILITY(U,$J,358.3,24511,2)
 ;;=^5021037
 ;;^UTILITY(U,$J,358.3,24512,0)
 ;;=S06.4X1S^^76^1006^51
 ;;^UTILITY(U,$J,358.3,24512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24512,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,24512,1,4,0)
 ;;=4^S06.4X1S
 ;;^UTILITY(U,$J,358.3,24512,2)
 ;;=^5021031
 ;;^UTILITY(U,$J,358.3,24513,0)
 ;;=S06.4X2S^^76^1006^52
 ;;^UTILITY(U,$J,358.3,24513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24513,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,24513,1,4,0)
 ;;=4^S06.4X2S
 ;;^UTILITY(U,$J,358.3,24513,2)
 ;;=^5021034
 ;;^UTILITY(U,$J,358.3,24514,0)
 ;;=S06.4X4S^^76^1006^53
 ;;^UTILITY(U,$J,358.3,24514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24514,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,24514,1,4,0)
 ;;=4^S06.4X4S
 ;;^UTILITY(U,$J,358.3,24514,2)
 ;;=^5021040
 ;;^UTILITY(U,$J,358.3,24515,0)
 ;;=S06.4X9S^^76^1006^54
 ;;^UTILITY(U,$J,358.3,24515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24515,1,3,0)
 ;;=3^Epidural hemorrhage w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,24515,1,4,0)
 ;;=4^S06.4X9S
 ;;^UTILITY(U,$J,358.3,24515,2)
 ;;=^5021055
 ;;^UTILITY(U,$J,358.3,24516,0)
 ;;=S06.4X0S^^76^1006^55
 ;;^UTILITY(U,$J,358.3,24516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24516,1,3,0)
 ;;=3^Epidural hemorrhage without LOC, sequela
 ;;^UTILITY(U,$J,358.3,24516,1,4,0)
 ;;=4^S06.4X0S
 ;;^UTILITY(U,$J,358.3,24516,2)
 ;;=^5021028
 ;;^UTILITY(U,$J,358.3,24517,0)
 ;;=S06.825S^^76^1006^56
 ;;^UTILITY(U,$J,358.3,24517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24517,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,24517,1,4,0)
 ;;=4^S06.825S
 ;;^UTILITY(U,$J,358.3,24517,2)
 ;;=^5021163
 ;;^UTILITY(U,$J,358.3,24518,0)
 ;;=S06.826S^^76^1006^57
 ;;^UTILITY(U,$J,358.3,24518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24518,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,24518,1,4,0)
 ;;=4^S06.826S
 ;;^UTILITY(U,$J,358.3,24518,2)
 ;;=^5021166
 ;;^UTILITY(U,$J,358.3,24519,0)
 ;;=S06.823S^^76^1006^58
 ;;^UTILITY(U,$J,358.3,24519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24519,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,24519,1,4,0)
 ;;=4^S06.823S
 ;;^UTILITY(U,$J,358.3,24519,2)
 ;;=^5021157
 ;;^UTILITY(U,$J,358.3,24520,0)
 ;;=S06.821S^^76^1006^59
 ;;^UTILITY(U,$J,358.3,24520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24520,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,24520,1,4,0)
 ;;=4^S06.821S
 ;;^UTILITY(U,$J,358.3,24520,2)
 ;;=^5021151
 ;;^UTILITY(U,$J,358.3,24521,0)
 ;;=S06.822S^^76^1006^60
 ;;^UTILITY(U,$J,358.3,24521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24521,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,24521,1,4,0)
 ;;=4^S06.822S
 ;;^UTILITY(U,$J,358.3,24521,2)
 ;;=^5021154
 ;;^UTILITY(U,$J,358.3,24522,0)
 ;;=S06.824S^^76^1006^61
 ;;^UTILITY(U,$J,358.3,24522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24522,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,24522,1,4,0)
 ;;=4^S06.824S
 ;;^UTILITY(U,$J,358.3,24522,2)
 ;;=^5021160
 ;;^UTILITY(U,$J,358.3,24523,0)
 ;;=S06.829S^^76^1006^62
 ;;^UTILITY(U,$J,358.3,24523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24523,1,3,0)
 ;;=3^Inj left int carotid, intcr w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,24523,1,4,0)
 ;;=4^S06.829S
 ;;^UTILITY(U,$J,358.3,24523,2)
 ;;=^5021175
 ;;^UTILITY(U,$J,358.3,24524,0)
 ;;=S06.820S^^76^1006^63
 ;;^UTILITY(U,$J,358.3,24524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24524,1,3,0)
 ;;=3^Inj left int carotid, intcr w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,24524,1,4,0)
 ;;=4^S06.820S
 ;;^UTILITY(U,$J,358.3,24524,2)
 ;;=^5021148
 ;;^UTILITY(U,$J,358.3,24525,0)
 ;;=S06.815S^^76^1006^64
 ;;^UTILITY(U,$J,358.3,24525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24525,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,24525,1,4,0)
 ;;=4^S06.815S
 ;;^UTILITY(U,$J,358.3,24525,2)
 ;;=^5021133
 ;;^UTILITY(U,$J,358.3,24526,0)
 ;;=S06.816S^^76^1006^65
 ;;^UTILITY(U,$J,358.3,24526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24526,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,24526,1,4,0)
 ;;=4^S06.816S
 ;;^UTILITY(U,$J,358.3,24526,2)
 ;;=^5021136
 ;;^UTILITY(U,$J,358.3,24527,0)
 ;;=S06.813S^^76^1006^66
 ;;^UTILITY(U,$J,358.3,24527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24527,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,24527,1,4,0)
 ;;=4^S06.813S
 ;;^UTILITY(U,$J,358.3,24527,2)
 ;;=^5021127
 ;;^UTILITY(U,$J,358.3,24528,0)
 ;;=S06.811S^^76^1006^67
 ;;^UTILITY(U,$J,358.3,24528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24528,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,24528,1,4,0)
 ;;=4^S06.811S
 ;;^UTILITY(U,$J,358.3,24528,2)
 ;;=^5021121
 ;;^UTILITY(U,$J,358.3,24529,0)
 ;;=S06.812S^^76^1006^68
 ;;^UTILITY(U,$J,358.3,24529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24529,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,24529,1,4,0)
 ;;=4^S06.812S
 ;;^UTILITY(U,$J,358.3,24529,2)
 ;;=^5021124
 ;;^UTILITY(U,$J,358.3,24530,0)
 ;;=S06.814S^^76^1006^69
 ;;^UTILITY(U,$J,358.3,24530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24530,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,24530,1,4,0)
 ;;=4^S06.814S
 ;;^UTILITY(U,$J,358.3,24530,2)
 ;;=^5021130
 ;;^UTILITY(U,$J,358.3,24531,0)
 ;;=S06.819S^^76^1006^70
 ;;^UTILITY(U,$J,358.3,24531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24531,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,24531,1,4,0)
 ;;=4^S06.819S
 ;;^UTILITY(U,$J,358.3,24531,2)
 ;;=^5021145
 ;;^UTILITY(U,$J,358.3,24532,0)
 ;;=S06.810S^^76^1006^71
 ;;^UTILITY(U,$J,358.3,24532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24532,1,3,0)
 ;;=3^Inj right int carotid, intcr w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,24532,1,4,0)
 ;;=4^S06.810S
 ;;^UTILITY(U,$J,358.3,24532,2)
 ;;=^5021118
 ;;^UTILITY(U,$J,358.3,24533,0)
 ;;=S06.1X5S^^76^1006^72
 ;;^UTILITY(U,$J,358.3,24533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24533,1,3,0)
 ;;=3^Traum cerebral edema w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,24533,1,4,0)
 ;;=4^S06.1X5S
 ;;^UTILITY(U,$J,358.3,24533,2)
 ;;=^5020713
 ;;^UTILITY(U,$J,358.3,24534,0)
 ;;=S06.1X6S^^76^1006^73
 ;;^UTILITY(U,$J,358.3,24534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24534,1,3,0)
 ;;=3^Traum cerebral edema w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,24534,1,4,0)
 ;;=4^S06.1X6S
 ;;^UTILITY(U,$J,358.3,24534,2)
 ;;=^5020716
 ;;^UTILITY(U,$J,358.3,24535,0)
 ;;=S06.1X3S^^76^1006^107
 ;;^UTILITY(U,$J,358.3,24535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24535,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,24535,1,4,0)
 ;;=4^S06.1X3S
 ;;^UTILITY(U,$J,358.3,24535,2)
 ;;=^5020707
 ;;^UTILITY(U,$J,358.3,24536,0)
 ;;=S06.1X1S^^76^1006^74
 ;;^UTILITY(U,$J,358.3,24536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24536,1,3,0)
 ;;=3^Traum cerebral edema w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,24536,1,4,0)
 ;;=4^S06.1X1S
 ;;^UTILITY(U,$J,358.3,24536,2)
 ;;=^5020701
 ;;^UTILITY(U,$J,358.3,24537,0)
 ;;=S06.1X2S^^76^1006^108
 ;;^UTILITY(U,$J,358.3,24537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24537,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,24537,1,4,0)
 ;;=4^S06.1X2S
 ;;^UTILITY(U,$J,358.3,24537,2)
 ;;=^5020704
 ;;^UTILITY(U,$J,358.3,24538,0)
 ;;=S06.1X4S^^76^1006^109
 ;;^UTILITY(U,$J,358.3,24538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24538,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,24538,1,4,0)
 ;;=4^S06.1X4S
 ;;^UTILITY(U,$J,358.3,24538,2)
 ;;=^5020710
 ;;^UTILITY(U,$J,358.3,24539,0)
 ;;=S06.1X9S^^76^1006^110
 ;;^UTILITY(U,$J,358.3,24539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24539,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,24539,1,4,0)
 ;;=4^S06.1X9S
 ;;^UTILITY(U,$J,358.3,24539,2)
 ;;=^5020725
 ;;^UTILITY(U,$J,358.3,24540,0)
 ;;=S06.1X0S^^76^1006^111
 ;;^UTILITY(U,$J,358.3,24540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24540,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,24540,1,4,0)
 ;;=4^S06.1X0S
 ;;^UTILITY(U,$J,358.3,24540,2)
 ;;=^5020698
 ;;^UTILITY(U,$J,358.3,24541,0)
 ;;=S06.355S^^76^1006^75
 ;;^UTILITY(U,$J,358.3,24541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24541,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,24541,1,4,0)
 ;;=4^S06.355S
 ;;^UTILITY(U,$J,358.3,24541,2)
 ;;=^5020923
 ;;^UTILITY(U,$J,358.3,24542,0)
 ;;=S06.356S^^76^1006^76
 ;;^UTILITY(U,$J,358.3,24542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24542,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,24542,1,4,0)
 ;;=4^S06.356S
 ;;^UTILITY(U,$J,358.3,24542,2)
 ;;=^5020926
 ;;^UTILITY(U,$J,358.3,24543,0)
 ;;=S06.353S^^76^1006^77
 ;;^UTILITY(U,$J,358.3,24543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24543,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 1-5 hrs 59 minutes, sequela
 ;;^UTILITY(U,$J,358.3,24543,1,4,0)
 ;;=4^S06.353S
 ;;^UTILITY(U,$J,358.3,24543,2)
 ;;=^5020917
 ;;^UTILITY(U,$J,358.3,24544,0)
 ;;=S06.351S^^76^1006^78
 ;;^UTILITY(U,$J,358.3,24544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24544,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,24544,1,4,0)
 ;;=4^S06.351S
 ;;^UTILITY(U,$J,358.3,24544,2)
 ;;=^5020911
 ;;^UTILITY(U,$J,358.3,24545,0)
 ;;=S06.352S^^76^1006^79
 ;;^UTILITY(U,$J,358.3,24545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24545,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,24545,1,4,0)
 ;;=4^S06.352S
 ;;^UTILITY(U,$J,358.3,24545,2)
 ;;=^5020914
 ;;^UTILITY(U,$J,358.3,24546,0)
 ;;=S06.354S^^76^1006^80
 ;;^UTILITY(U,$J,358.3,24546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24546,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,24546,1,4,0)
 ;;=4^S06.354S
 ;;^UTILITY(U,$J,358.3,24546,2)
 ;;=^5020920
 ;;^UTILITY(U,$J,358.3,24547,0)
 ;;=S06.359S^^76^1006^81
 ;;^UTILITY(U,$J,358.3,24547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24547,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,24547,1,4,0)
 ;;=4^S06.359S
 ;;^UTILITY(U,$J,358.3,24547,2)
 ;;=^5020935
 ;;^UTILITY(U,$J,358.3,24548,0)
 ;;=S06.350S^^76^1006^82
 ;;^UTILITY(U,$J,358.3,24548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24548,1,3,0)
 ;;=3^Traum hemor left cerebrum w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,24548,1,4,0)
 ;;=4^S06.350S
 ;;^UTILITY(U,$J,358.3,24548,2)
 ;;=^5020908
 ;;^UTILITY(U,$J,358.3,24549,0)
 ;;=S06.345S^^76^1006^83
 ;;^UTILITY(U,$J,358.3,24549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24549,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,24549,1,4,0)
 ;;=4^S06.345S
 ;;^UTILITY(U,$J,358.3,24549,2)
 ;;=^5020893
 ;;^UTILITY(U,$J,358.3,24550,0)
 ;;=S06.346S^^76^1006^84
 ;;^UTILITY(U,$J,358.3,24550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24550,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,24550,1,4,0)
 ;;=4^S06.346S
 ;;^UTILITY(U,$J,358.3,24550,2)
 ;;=^5020896
 ;;^UTILITY(U,$J,358.3,24551,0)
 ;;=S06.343S^^76^1006^90
 ;;^UTILITY(U,$J,358.3,24551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24551,1,3,0)
 ;;=3^Traum hemor right cerebrumb w LOC of 1-5 hrs 59 minutes, sequela
 ;;^UTILITY(U,$J,358.3,24551,1,4,0)
 ;;=4^S06.343S
 ;;^UTILITY(U,$J,358.3,24551,2)
 ;;=^5020887
 ;;^UTILITY(U,$J,358.3,24552,0)
 ;;=S06.341S^^76^1006^85
 ;;^UTILITY(U,$J,358.3,24552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24552,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,24552,1,4,0)
 ;;=4^S06.341S
 ;;^UTILITY(U,$J,358.3,24552,2)
 ;;=^5020881
 ;;^UTILITY(U,$J,358.3,24553,0)
 ;;=S06.342S^^76^1006^86
 ;;^UTILITY(U,$J,358.3,24553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24553,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,24553,1,4,0)
 ;;=4^S06.342S
 ;;^UTILITY(U,$J,358.3,24553,2)
 ;;=^5020884
 ;;^UTILITY(U,$J,358.3,24554,0)
 ;;=S06.344S^^76^1006^87
 ;;^UTILITY(U,$J,358.3,24554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24554,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,24554,1,4,0)
 ;;=4^S06.344S
 ;;^UTILITY(U,$J,358.3,24554,2)
 ;;=^5020890
 ;;^UTILITY(U,$J,358.3,24555,0)
 ;;=S06.349S^^76^1006^88
 ;;^UTILITY(U,$J,358.3,24555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24555,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,24555,1,4,0)
 ;;=4^S06.349S
 ;;^UTILITY(U,$J,358.3,24555,2)
 ;;=^5020905
 ;;^UTILITY(U,$J,358.3,24556,0)
 ;;=S06.340S^^76^1006^89
 ;;^UTILITY(U,$J,358.3,24556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24556,1,3,0)
 ;;=3^Traum hemor right cerebrum w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,24556,1,4,0)
 ;;=4^S06.340S
 ;;^UTILITY(U,$J,358.3,24556,2)
 ;;=^5020878
 ;;^UTILITY(U,$J,358.3,24557,0)
 ;;=S06.6X5S^^76^1006^99
 ;;^UTILITY(U,$J,358.3,24557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24557,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,24557,1,4,0)
 ;;=4^S06.6X5S
 ;;^UTILITY(U,$J,358.3,24557,2)
 ;;=^5021103
 ;;^UTILITY(U,$J,358.3,24558,0)
 ;;=S06.6X6S^^76^1006^100
 ;;^UTILITY(U,$J,358.3,24558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24558,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,24558,1,4,0)
 ;;=4^S06.6X6S
 ;;^UTILITY(U,$J,358.3,24558,2)
 ;;=^5021106
 ;;^UTILITY(U,$J,358.3,24559,0)
 ;;=S06.6X3S^^76^1006^101
 ;;^UTILITY(U,$J,358.3,24559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24559,1,3,0)
 ;;=3^Traum subrac hem w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,24559,1,4,0)
 ;;=4^S06.6X3S
 ;;^UTILITY(U,$J,358.3,24559,2)
 ;;=^5021097
 ;;^UTILITY(U,$J,358.3,24560,0)
 ;;=S06.6X1S^^76^1006^102
 ;;^UTILITY(U,$J,358.3,24560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24560,1,3,0)
 ;;=3^Traum subrac hem w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,24560,1,4,0)
 ;;=4^S06.6X1S
 ;;^UTILITY(U,$J,358.3,24560,2)
 ;;=^5021091
 ;;^UTILITY(U,$J,358.3,24561,0)
 ;;=S06.6X2S^^76^1006^103
 ;;^UTILITY(U,$J,358.3,24561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24561,1,3,0)
 ;;=3^Traum subrac hem w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,24561,1,4,0)
 ;;=4^S06.6X2S
 ;;^UTILITY(U,$J,358.3,24561,2)
 ;;=^5021094
 ;;^UTILITY(U,$J,358.3,24562,0)
 ;;=S06.6X4S^^76^1006^104
 ;;^UTILITY(U,$J,358.3,24562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24562,1,3,0)
 ;;=3^Traum subrac hem w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,24562,1,4,0)
 ;;=4^S06.6X4S
 ;;^UTILITY(U,$J,358.3,24562,2)
 ;;=^5021100
 ;;^UTILITY(U,$J,358.3,24563,0)
 ;;=S06.6X9S^^76^1006^105
 ;;^UTILITY(U,$J,358.3,24563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24563,1,3,0)
 ;;=3^Traum subrac hem w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,24563,1,4,0)
 ;;=4^S06.6X9S
 ;;^UTILITY(U,$J,358.3,24563,2)
 ;;=^5021115
 ;;^UTILITY(U,$J,358.3,24564,0)
 ;;=S06.6X0S^^76^1006^106
 ;;^UTILITY(U,$J,358.3,24564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24564,1,3,0)
 ;;=3^Traum subrac hem w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,24564,1,4,0)
 ;;=4^S06.6X0S
 ;;^UTILITY(U,$J,358.3,24564,2)
 ;;=^5021088
 ;;^UTILITY(U,$J,358.3,24565,0)
 ;;=S06.5X5S^^76^1006^91
