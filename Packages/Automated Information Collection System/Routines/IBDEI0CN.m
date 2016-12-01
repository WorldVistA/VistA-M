IBDEI0CN ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16007,1,4,0)
 ;;=4^S06.814S
 ;;^UTILITY(U,$J,358.3,16007,2)
 ;;=^5021130
 ;;^UTILITY(U,$J,358.3,16008,0)
 ;;=S06.819S^^47^708^77
 ;;^UTILITY(U,$J,358.3,16008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16008,1,3,0)
 ;;=3^Inj right int carotid, intcr w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,16008,1,4,0)
 ;;=4^S06.819S
 ;;^UTILITY(U,$J,358.3,16008,2)
 ;;=^5021145
 ;;^UTILITY(U,$J,358.3,16009,0)
 ;;=S06.810S^^47^708^78
 ;;^UTILITY(U,$J,358.3,16009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16009,1,3,0)
 ;;=3^Inj right int carotid, intcr w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,16009,1,4,0)
 ;;=4^S06.810S
 ;;^UTILITY(U,$J,358.3,16009,2)
 ;;=^5021118
 ;;^UTILITY(U,$J,358.3,16010,0)
 ;;=S06.1X5S^^47^708^79
 ;;^UTILITY(U,$J,358.3,16010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16010,1,3,0)
 ;;=3^Traum cerebral edema w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,16010,1,4,0)
 ;;=4^S06.1X5S
 ;;^UTILITY(U,$J,358.3,16010,2)
 ;;=^5020713
 ;;^UTILITY(U,$J,358.3,16011,0)
 ;;=S06.1X6S^^47^708^80
 ;;^UTILITY(U,$J,358.3,16011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16011,1,3,0)
 ;;=3^Traum cerebral edema w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,16011,1,4,0)
 ;;=4^S06.1X6S
 ;;^UTILITY(U,$J,358.3,16011,2)
 ;;=^5020716
 ;;^UTILITY(U,$J,358.3,16012,0)
 ;;=S06.1X3S^^47^708^114
 ;;^UTILITY(U,$J,358.3,16012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16012,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,16012,1,4,0)
 ;;=4^S06.1X3S
 ;;^UTILITY(U,$J,358.3,16012,2)
 ;;=^5020707
 ;;^UTILITY(U,$J,358.3,16013,0)
 ;;=S06.1X1S^^47^708^81
 ;;^UTILITY(U,$J,358.3,16013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16013,1,3,0)
 ;;=3^Traum cerebral edema w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,16013,1,4,0)
 ;;=4^S06.1X1S
 ;;^UTILITY(U,$J,358.3,16013,2)
 ;;=^5020701
 ;;^UTILITY(U,$J,358.3,16014,0)
 ;;=S06.1X2S^^47^708^115
 ;;^UTILITY(U,$J,358.3,16014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16014,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,16014,1,4,0)
 ;;=4^S06.1X2S
 ;;^UTILITY(U,$J,358.3,16014,2)
 ;;=^5020704
 ;;^UTILITY(U,$J,358.3,16015,0)
 ;;=S06.1X4S^^47^708^116
 ;;^UTILITY(U,$J,358.3,16015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16015,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,16015,1,4,0)
 ;;=4^S06.1X4S
 ;;^UTILITY(U,$J,358.3,16015,2)
 ;;=^5020710
 ;;^UTILITY(U,$J,358.3,16016,0)
 ;;=S06.1X9S^^47^708^117
 ;;^UTILITY(U,$J,358.3,16016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16016,1,3,0)
 ;;=3^Traumatic cerebral edema w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,16016,1,4,0)
 ;;=4^S06.1X9S
 ;;^UTILITY(U,$J,358.3,16016,2)
 ;;=^5020725
 ;;^UTILITY(U,$J,358.3,16017,0)
 ;;=S06.1X0S^^47^708^118
 ;;^UTILITY(U,$J,358.3,16017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16017,1,3,0)
 ;;=3^Traumatic cerebral edema w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,16017,1,4,0)
 ;;=4^S06.1X0S
 ;;^UTILITY(U,$J,358.3,16017,2)
 ;;=^5020698
 ;;^UTILITY(U,$J,358.3,16018,0)
 ;;=S06.355S^^47^708^82
 ;;^UTILITY(U,$J,358.3,16018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16018,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,16018,1,4,0)
 ;;=4^S06.355S
 ;;^UTILITY(U,$J,358.3,16018,2)
 ;;=^5020923
 ;;^UTILITY(U,$J,358.3,16019,0)
 ;;=S06.356S^^47^708^83
 ;;^UTILITY(U,$J,358.3,16019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16019,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,16019,1,4,0)
 ;;=4^S06.356S
 ;;^UTILITY(U,$J,358.3,16019,2)
 ;;=^5020926
 ;;^UTILITY(U,$J,358.3,16020,0)
 ;;=S06.353S^^47^708^84
 ;;^UTILITY(U,$J,358.3,16020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16020,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 1-5 hrs 59 minutes, sequela
 ;;^UTILITY(U,$J,358.3,16020,1,4,0)
 ;;=4^S06.353S
 ;;^UTILITY(U,$J,358.3,16020,2)
 ;;=^5020917
 ;;^UTILITY(U,$J,358.3,16021,0)
 ;;=S06.351S^^47^708^85
 ;;^UTILITY(U,$J,358.3,16021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16021,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,16021,1,4,0)
 ;;=4^S06.351S
 ;;^UTILITY(U,$J,358.3,16021,2)
 ;;=^5020911
 ;;^UTILITY(U,$J,358.3,16022,0)
 ;;=S06.352S^^47^708^86
 ;;^UTILITY(U,$J,358.3,16022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16022,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,16022,1,4,0)
 ;;=4^S06.352S
 ;;^UTILITY(U,$J,358.3,16022,2)
 ;;=^5020914
 ;;^UTILITY(U,$J,358.3,16023,0)
 ;;=S06.354S^^47^708^87
 ;;^UTILITY(U,$J,358.3,16023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16023,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,16023,1,4,0)
 ;;=4^S06.354S
 ;;^UTILITY(U,$J,358.3,16023,2)
 ;;=^5020920
 ;;^UTILITY(U,$J,358.3,16024,0)
 ;;=S06.359S^^47^708^88
 ;;^UTILITY(U,$J,358.3,16024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16024,1,3,0)
 ;;=3^Traum hemor left cerebrum w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,16024,1,4,0)
 ;;=4^S06.359S
 ;;^UTILITY(U,$J,358.3,16024,2)
 ;;=^5020935
 ;;^UTILITY(U,$J,358.3,16025,0)
 ;;=S06.350S^^47^708^89
 ;;^UTILITY(U,$J,358.3,16025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16025,1,3,0)
 ;;=3^Traum hemor left cerebrum w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,16025,1,4,0)
 ;;=4^S06.350S
 ;;^UTILITY(U,$J,358.3,16025,2)
 ;;=^5020908
 ;;^UTILITY(U,$J,358.3,16026,0)
 ;;=S06.345S^^47^708^90
 ;;^UTILITY(U,$J,358.3,16026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16026,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,16026,1,4,0)
 ;;=4^S06.345S
 ;;^UTILITY(U,$J,358.3,16026,2)
 ;;=^5020893
 ;;^UTILITY(U,$J,358.3,16027,0)
 ;;=S06.346S^^47^708^91
 ;;^UTILITY(U,$J,358.3,16027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16027,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,16027,1,4,0)
 ;;=4^S06.346S
 ;;^UTILITY(U,$J,358.3,16027,2)
 ;;=^5020896
 ;;^UTILITY(U,$J,358.3,16028,0)
 ;;=S06.343S^^47^708^97
 ;;^UTILITY(U,$J,358.3,16028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16028,1,3,0)
 ;;=3^Traum hemor right cerebrumb w LOC of 1-5 hrs 59 minutes, sequela
 ;;^UTILITY(U,$J,358.3,16028,1,4,0)
 ;;=4^S06.343S
 ;;^UTILITY(U,$J,358.3,16028,2)
 ;;=^5020887
 ;;^UTILITY(U,$J,358.3,16029,0)
 ;;=S06.341S^^47^708^92
 ;;^UTILITY(U,$J,358.3,16029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16029,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,16029,1,4,0)
 ;;=4^S06.341S
 ;;^UTILITY(U,$J,358.3,16029,2)
 ;;=^5020881
 ;;^UTILITY(U,$J,358.3,16030,0)
 ;;=S06.342S^^47^708^93
 ;;^UTILITY(U,$J,358.3,16030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16030,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,16030,1,4,0)
 ;;=4^S06.342S
 ;;^UTILITY(U,$J,358.3,16030,2)
 ;;=^5020884
 ;;^UTILITY(U,$J,358.3,16031,0)
 ;;=S06.344S^^47^708^94
 ;;^UTILITY(U,$J,358.3,16031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16031,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,16031,1,4,0)
 ;;=4^S06.344S
 ;;^UTILITY(U,$J,358.3,16031,2)
 ;;=^5020890
 ;;^UTILITY(U,$J,358.3,16032,0)
 ;;=S06.349S^^47^708^95
 ;;^UTILITY(U,$J,358.3,16032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16032,1,3,0)
 ;;=3^Traum hemor right cerebrum w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,16032,1,4,0)
 ;;=4^S06.349S
 ;;^UTILITY(U,$J,358.3,16032,2)
 ;;=^5020905
 ;;^UTILITY(U,$J,358.3,16033,0)
 ;;=S06.340S^^47^708^96
 ;;^UTILITY(U,$J,358.3,16033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16033,1,3,0)
 ;;=3^Traum hemor right cerebrum w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,16033,1,4,0)
 ;;=4^S06.340S
 ;;^UTILITY(U,$J,358.3,16033,2)
 ;;=^5020878
 ;;^UTILITY(U,$J,358.3,16034,0)
 ;;=S06.6X5S^^47^708^106
 ;;^UTILITY(U,$J,358.3,16034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16034,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,16034,1,4,0)
 ;;=4^S06.6X5S
 ;;^UTILITY(U,$J,358.3,16034,2)
 ;;=^5021103
 ;;^UTILITY(U,$J,358.3,16035,0)
 ;;=S06.6X6S^^47^708^107
 ;;^UTILITY(U,$J,358.3,16035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16035,1,3,0)
 ;;=3^Traum subrac hem w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,16035,1,4,0)
 ;;=4^S06.6X6S
 ;;^UTILITY(U,$J,358.3,16035,2)
 ;;=^5021106
 ;;^UTILITY(U,$J,358.3,16036,0)
 ;;=S06.6X3S^^47^708^108
 ;;^UTILITY(U,$J,358.3,16036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16036,1,3,0)
 ;;=3^Traum subrac hem w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,16036,1,4,0)
 ;;=4^S06.6X3S
 ;;^UTILITY(U,$J,358.3,16036,2)
 ;;=^5021097
 ;;^UTILITY(U,$J,358.3,16037,0)
 ;;=S06.6X1S^^47^708^109
 ;;^UTILITY(U,$J,358.3,16037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16037,1,3,0)
 ;;=3^Traum subrac hem w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,16037,1,4,0)
 ;;=4^S06.6X1S
 ;;^UTILITY(U,$J,358.3,16037,2)
 ;;=^5021091
 ;;^UTILITY(U,$J,358.3,16038,0)
 ;;=S06.6X2S^^47^708^110
 ;;^UTILITY(U,$J,358.3,16038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16038,1,3,0)
 ;;=3^Traum subrac hem w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,16038,1,4,0)
 ;;=4^S06.6X2S
 ;;^UTILITY(U,$J,358.3,16038,2)
 ;;=^5021094
 ;;^UTILITY(U,$J,358.3,16039,0)
 ;;=S06.6X4S^^47^708^111
 ;;^UTILITY(U,$J,358.3,16039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16039,1,3,0)
 ;;=3^Traum subrac hem w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,16039,1,4,0)
 ;;=4^S06.6X4S
 ;;^UTILITY(U,$J,358.3,16039,2)
 ;;=^5021100
