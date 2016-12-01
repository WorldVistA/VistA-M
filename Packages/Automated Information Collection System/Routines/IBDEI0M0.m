IBDEI0M0 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27850,2)
 ;;=^5020698
 ;;^UTILITY(U,$J,358.3,27851,0)
 ;;=S06.1X1A^^77^1192^47
 ;;^UTILITY(U,$J,358.3,27851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27851,1,3,0)
 ;;=3^Traum cereb edema w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,27851,1,4,0)
 ;;=4^S06.1X1A
 ;;^UTILITY(U,$J,358.3,27851,2)
 ;;=^5020699
 ;;^UTILITY(U,$J,358.3,27852,0)
 ;;=S06.1X1D^^77^1192^48
 ;;^UTILITY(U,$J,358.3,27852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27852,1,3,0)
 ;;=3^Traum cereb edema w LOC of 30 minutes or less, subs
 ;;^UTILITY(U,$J,358.3,27852,1,4,0)
 ;;=4^S06.1X1D
 ;;^UTILITY(U,$J,358.3,27852,2)
 ;;=^5020700
 ;;^UTILITY(U,$J,358.3,27853,0)
 ;;=S06.1X1S^^77^1192^49
 ;;^UTILITY(U,$J,358.3,27853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27853,1,3,0)
 ;;=3^Traum cereb edema w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,27853,1,4,0)
 ;;=4^S06.1X1S
 ;;^UTILITY(U,$J,358.3,27853,2)
 ;;=^5020701
 ;;^UTILITY(U,$J,358.3,27854,0)
 ;;=S06.1X2A^^77^1192^50
 ;;^UTILITY(U,$J,358.3,27854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27854,1,3,0)
 ;;=3^Traum cereb edema w LOC of 31-59 min, init
 ;;^UTILITY(U,$J,358.3,27854,1,4,0)
 ;;=4^S06.1X2A
 ;;^UTILITY(U,$J,358.3,27854,2)
 ;;=^5020702
 ;;^UTILITY(U,$J,358.3,27855,0)
 ;;=S06.1X2D^^77^1192^51
 ;;^UTILITY(U,$J,358.3,27855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27855,1,3,0)
 ;;=3^Traum cereb edema w LOC of 31-59 min, subs
 ;;^UTILITY(U,$J,358.3,27855,1,4,0)
 ;;=4^S06.1X2D
 ;;^UTILITY(U,$J,358.3,27855,2)
 ;;=^5020703
 ;;^UTILITY(U,$J,358.3,27856,0)
 ;;=S06.1X2S^^77^1192^52
 ;;^UTILITY(U,$J,358.3,27856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27856,1,3,0)
 ;;=3^Traum cereb edema w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,27856,1,4,0)
 ;;=4^S06.1X2S
 ;;^UTILITY(U,$J,358.3,27856,2)
 ;;=^5020704
 ;;^UTILITY(U,$J,358.3,27857,0)
 ;;=S06.1X3A^^77^1192^44
 ;;^UTILITY(U,$J,358.3,27857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27857,1,3,0)
 ;;=3^Traum cereb edema w LOC of 1-5 hrs 59 min, init
 ;;^UTILITY(U,$J,358.3,27857,1,4,0)
 ;;=4^S06.1X3A
 ;;^UTILITY(U,$J,358.3,27857,2)
 ;;=^5020705
 ;;^UTILITY(U,$J,358.3,27858,0)
 ;;=S06.1X3D^^77^1192^45
 ;;^UTILITY(U,$J,358.3,27858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27858,1,3,0)
 ;;=3^Traum cereb edema w LOC of 1-5 hrs 59 min, subs
 ;;^UTILITY(U,$J,358.3,27858,1,4,0)
 ;;=4^S06.1X3D
 ;;^UTILITY(U,$J,358.3,27858,2)
 ;;=^5020706
 ;;^UTILITY(U,$J,358.3,27859,0)
 ;;=S06.1X3S^^77^1192^46
 ;;^UTILITY(U,$J,358.3,27859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27859,1,3,0)
 ;;=3^Traum cereb edema w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,27859,1,4,0)
 ;;=4^S06.1X3S
 ;;^UTILITY(U,$J,358.3,27859,2)
 ;;=^5020707
 ;;^UTILITY(U,$J,358.3,27860,0)
 ;;=S06.1X4A^^77^1192^53
 ;;^UTILITY(U,$J,358.3,27860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27860,1,3,0)
 ;;=3^Traum cereb edema w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,27860,1,4,0)
 ;;=4^S06.1X4A
 ;;^UTILITY(U,$J,358.3,27860,2)
 ;;=^5020708
 ;;^UTILITY(U,$J,358.3,27861,0)
 ;;=S06.1X4D^^77^1192^54
 ;;^UTILITY(U,$J,358.3,27861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27861,1,3,0)
 ;;=3^Traum cereb edema w LOC of 6 hours to 24 hours, subs
 ;;^UTILITY(U,$J,358.3,27861,1,4,0)
 ;;=4^S06.1X4D
 ;;^UTILITY(U,$J,358.3,27861,2)
 ;;=^5020709
 ;;^UTILITY(U,$J,358.3,27862,0)
 ;;=S06.1X4S^^77^1192^55
 ;;^UTILITY(U,$J,358.3,27862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27862,1,3,0)
 ;;=3^Traum cereb edema w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,27862,1,4,0)
 ;;=4^S06.1X4S
 ;;^UTILITY(U,$J,358.3,27862,2)
 ;;=^5020710
 ;;^UTILITY(U,$J,358.3,27863,0)
 ;;=S06.1X5A^^77^1192^38
 ;;^UTILITY(U,$J,358.3,27863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27863,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,27863,1,4,0)
 ;;=4^S06.1X5A
 ;;^UTILITY(U,$J,358.3,27863,2)
 ;;=^5020711
 ;;^UTILITY(U,$J,358.3,27864,0)
 ;;=S06.1X5D^^77^1192^39
 ;;^UTILITY(U,$J,358.3,27864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27864,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w ret consc lev, subs
 ;;^UTILITY(U,$J,358.3,27864,1,4,0)
 ;;=4^S06.1X5D
 ;;^UTILITY(U,$J,358.3,27864,2)
 ;;=^5020712
 ;;^UTILITY(U,$J,358.3,27865,0)
 ;;=S06.1X5S^^77^1192^40
 ;;^UTILITY(U,$J,358.3,27865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27865,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,27865,1,4,0)
 ;;=4^S06.1X5S
 ;;^UTILITY(U,$J,358.3,27865,2)
 ;;=^5020713
 ;;^UTILITY(U,$J,358.3,27866,0)
 ;;=S06.1X6A^^77^1192^41
 ;;^UTILITY(U,$J,358.3,27866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27866,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,27866,1,4,0)
 ;;=4^S06.1X6A
 ;;^UTILITY(U,$J,358.3,27866,2)
 ;;=^5020714
 ;;^UTILITY(U,$J,358.3,27867,0)
 ;;=S06.1X6D^^77^1192^42
 ;;^UTILITY(U,$J,358.3,27867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27867,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w/o ret consc w surv, subs
 ;;^UTILITY(U,$J,358.3,27867,1,4,0)
 ;;=4^S06.1X6D
 ;;^UTILITY(U,$J,358.3,27867,2)
 ;;=^5020715
 ;;^UTILITY(U,$J,358.3,27868,0)
 ;;=S06.1X6S^^77^1192^43
 ;;^UTILITY(U,$J,358.3,27868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27868,1,3,0)
 ;;=3^Traum cereb edema w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,27868,1,4,0)
 ;;=4^S06.1X6S
 ;;^UTILITY(U,$J,358.3,27868,2)
 ;;=^5020716
 ;;^UTILITY(U,$J,358.3,27869,0)
 ;;=S06.1X7A^^77^1192^59
 ;;^UTILITY(U,$J,358.3,27869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27869,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t brain inj bf consc, init
 ;;^UTILITY(U,$J,358.3,27869,1,4,0)
 ;;=4^S06.1X7A
 ;;^UTILITY(U,$J,358.3,27869,2)
 ;;=^5020717
 ;;^UTILITY(U,$J,358.3,27870,0)
 ;;=S06.1X7D^^77^1192^60
 ;;^UTILITY(U,$J,358.3,27870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27870,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t brain inj bf consc, subs
 ;;^UTILITY(U,$J,358.3,27870,1,4,0)
 ;;=4^S06.1X7D
 ;;^UTILITY(U,$J,358.3,27870,2)
 ;;=^5020718
 ;;^UTILITY(U,$J,358.3,27871,0)
 ;;=S06.1X7S^^77^1192^61
 ;;^UTILITY(U,$J,358.3,27871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27871,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t brain inj bf consc, sqla
 ;;^UTILITY(U,$J,358.3,27871,1,4,0)
 ;;=4^S06.1X7S
 ;;^UTILITY(U,$J,358.3,27871,2)
 ;;=^5020719
 ;;^UTILITY(U,$J,358.3,27872,0)
 ;;=S06.1X8A^^77^1192^62
 ;;^UTILITY(U,$J,358.3,27872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27872,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,27872,1,4,0)
 ;;=4^S06.1X8A
 ;;^UTILITY(U,$J,358.3,27872,2)
 ;;=^5020720
 ;;^UTILITY(U,$J,358.3,27873,0)
 ;;=S06.1X8D^^77^1192^63
 ;;^UTILITY(U,$J,358.3,27873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27873,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t oth cause bf consc, subs
 ;;^UTILITY(U,$J,358.3,27873,1,4,0)
 ;;=4^S06.1X8D
 ;;^UTILITY(U,$J,358.3,27873,2)
 ;;=^5020721
 ;;^UTILITY(U,$J,358.3,27874,0)
 ;;=S06.1X8S^^77^1192^64
 ;;^UTILITY(U,$J,358.3,27874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27874,1,3,0)
 ;;=3^Traum cereb edema w LOC w death d/t oth cause bf consc, sqla
 ;;^UTILITY(U,$J,358.3,27874,1,4,0)
 ;;=4^S06.1X8S
 ;;^UTILITY(U,$J,358.3,27874,2)
 ;;=^5020722
 ;;^UTILITY(U,$J,358.3,27875,0)
 ;;=S06.1X9A^^77^1192^56
 ;;^UTILITY(U,$J,358.3,27875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27875,1,3,0)
 ;;=3^Traum cereb edema w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,27875,1,4,0)
 ;;=4^S06.1X9A
 ;;^UTILITY(U,$J,358.3,27875,2)
 ;;=^5020723
 ;;^UTILITY(U,$J,358.3,27876,0)
 ;;=S06.1X9D^^77^1192^57
 ;;^UTILITY(U,$J,358.3,27876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27876,1,3,0)
 ;;=3^Traum cereb edema w LOC of unsp duration, subs
 ;;^UTILITY(U,$J,358.3,27876,1,4,0)
 ;;=4^S06.1X9D
 ;;^UTILITY(U,$J,358.3,27876,2)
 ;;=^5020724
 ;;^UTILITY(U,$J,358.3,27877,0)
 ;;=S06.1X9S^^77^1192^58
 ;;^UTILITY(U,$J,358.3,27877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27877,1,3,0)
 ;;=3^Traum cereb edema w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,27877,1,4,0)
 ;;=4^S06.1X9S
 ;;^UTILITY(U,$J,358.3,27877,2)
 ;;=^5020725
 ;;^UTILITY(U,$J,358.3,27878,0)
 ;;=M54.2^^77^1193^4
 ;;^UTILITY(U,$J,358.3,27878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27878,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,27878,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,27878,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,27879,0)
 ;;=I65.21^^77^1193^9
 ;;^UTILITY(U,$J,358.3,27879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27879,1,3,0)
 ;;=3^Occlusion and stenosis of right carotid artery
 ;;^UTILITY(U,$J,358.3,27879,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,27879,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,27880,0)
 ;;=I65.22^^77^1193^8
 ;;^UTILITY(U,$J,358.3,27880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27880,1,3,0)
 ;;=3^Occlusion and stenosis of left carotid artery
 ;;^UTILITY(U,$J,358.3,27880,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,27880,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,27881,0)
 ;;=M47.812^^77^1193^17
 ;;^UTILITY(U,$J,358.3,27881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27881,1,3,0)
 ;;=3^Spondylosis w/o myelopathy or radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,27881,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,27881,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,27882,0)
 ;;=M47.12^^77^1193^16
 ;;^UTILITY(U,$J,358.3,27882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27882,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,27882,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,27882,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,27883,0)
 ;;=M48.02^^77^1193^14
 ;;^UTILITY(U,$J,358.3,27883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27883,1,3,0)
 ;;=3^Spinal stenosis, cervical region
 ;;^UTILITY(U,$J,358.3,27883,1,4,0)
 ;;=4^M48.02
