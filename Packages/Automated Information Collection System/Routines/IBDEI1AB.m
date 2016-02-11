IBDEI1AB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21468,1,3,0)
 ;;=3^Fit/adjst of complete right artificial leg
 ;;^UTILITY(U,$J,358.3,21468,1,4,0)
 ;;=4^Z44.111
 ;;^UTILITY(U,$J,358.3,21468,2)
 ;;=^5062980
 ;;^UTILITY(U,$J,358.3,21469,0)
 ;;=Z44.122^^101^1031^9
 ;;^UTILITY(U,$J,358.3,21469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21469,1,3,0)
 ;;=3^Fit/adjst of partial artificial left leg
 ;;^UTILITY(U,$J,358.3,21469,1,4,0)
 ;;=4^Z44.122
 ;;^UTILITY(U,$J,358.3,21469,2)
 ;;=^5062984
 ;;^UTILITY(U,$J,358.3,21470,0)
 ;;=Z44.121^^101^1031^11
 ;;^UTILITY(U,$J,358.3,21470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21470,1,3,0)
 ;;=3^Fit/adjst of partial artificial right leg
 ;;^UTILITY(U,$J,358.3,21470,1,4,0)
 ;;=4^Z44.121
 ;;^UTILITY(U,$J,358.3,21470,2)
 ;;=^5062983
 ;;^UTILITY(U,$J,358.3,21471,0)
 ;;=Z44.8^^101^1031^6
 ;;^UTILITY(U,$J,358.3,21471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21471,1,3,0)
 ;;=3^Fit/adjst of external prosthetic devices
 ;;^UTILITY(U,$J,358.3,21471,1,4,0)
 ;;=4^Z44.8
 ;;^UTILITY(U,$J,358.3,21471,2)
 ;;=^5062992
 ;;^UTILITY(U,$J,358.3,21472,0)
 ;;=Z46.89^^101^1031^7
 ;;^UTILITY(U,$J,358.3,21472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21472,1,3,0)
 ;;=3^Fit/adjst of oth devices
 ;;^UTILITY(U,$J,358.3,21472,1,4,0)
 ;;=4^Z46.89
 ;;^UTILITY(U,$J,358.3,21472,2)
 ;;=^5063023
 ;;^UTILITY(U,$J,358.3,21473,0)
 ;;=Z47.81^^101^1031^14
 ;;^UTILITY(U,$J,358.3,21473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21473,1,3,0)
 ;;=3^Ortho aftercare following surgical amp
 ;;^UTILITY(U,$J,358.3,21473,1,4,0)
 ;;=4^Z47.81
 ;;^UTILITY(U,$J,358.3,21473,2)
 ;;=^5063030
 ;;^UTILITY(U,$J,358.3,21474,0)
 ;;=Z47.82^^101^1031^13
 ;;^UTILITY(U,$J,358.3,21474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21474,1,3,0)
 ;;=3^Ortho aftercare following scoliosis surgery
 ;;^UTILITY(U,$J,358.3,21474,1,4,0)
 ;;=4^Z47.82
 ;;^UTILITY(U,$J,358.3,21474,2)
 ;;=^5063031
 ;;^UTILITY(U,$J,358.3,21475,0)
 ;;=Z47.89^^101^1031^12
 ;;^UTILITY(U,$J,358.3,21475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21475,1,3,0)
 ;;=3^Ortho Aftercare NEC
 ;;^UTILITY(U,$J,358.3,21475,1,4,0)
 ;;=4^Z47.89
 ;;^UTILITY(U,$J,358.3,21475,2)
 ;;=^5063032
 ;;^UTILITY(U,$J,358.3,21476,0)
 ;;=Z51.89^^101^1031^1
 ;;^UTILITY(U,$J,358.3,21476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21476,1,3,0)
 ;;=3^Encounter for Other Specified Aftercare
 ;;^UTILITY(U,$J,358.3,21476,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,21476,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,21477,0)
 ;;=S06.0X5S^^101^1032^1
 ;;^UTILITY(U,$J,358.3,21477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21477,1,3,0)
 ;;=3^Concussion w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,21477,1,4,0)
 ;;=4^S06.0X5S
 ;;^UTILITY(U,$J,358.3,21477,2)
 ;;=^5020683
 ;;^UTILITY(U,$J,358.3,21478,0)
 ;;=S06.0X6S^^101^1032^2
 ;;^UTILITY(U,$J,358.3,21478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21478,1,3,0)
 ;;=3^Concussion w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,21478,1,4,0)
 ;;=4^S06.0X6S
 ;;^UTILITY(U,$J,358.3,21478,2)
 ;;=^5020686
 ;;^UTILITY(U,$J,358.3,21479,0)
 ;;=S06.0X3S^^101^1032^3
 ;;^UTILITY(U,$J,358.3,21479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21479,1,3,0)
 ;;=3^Concussion w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,21479,1,4,0)
 ;;=4^S06.0X3S
 ;;^UTILITY(U,$J,358.3,21479,2)
 ;;=^5020677
 ;;^UTILITY(U,$J,358.3,21480,0)
 ;;=S06.0X1S^^101^1032^4
 ;;^UTILITY(U,$J,358.3,21480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21480,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,21480,1,4,0)
 ;;=4^S06.0X1S
 ;;^UTILITY(U,$J,358.3,21480,2)
 ;;=^5020671
