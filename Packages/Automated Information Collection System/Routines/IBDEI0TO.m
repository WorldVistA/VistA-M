IBDEI0TO ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29855,0)
 ;;=M19.132^^111^1434^20
 ;;^UTILITY(U,$J,358.3,29855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29855,1,3,0)
 ;;=3^Post-traumatic osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,29855,1,4,0)
 ;;=4^M19.132
 ;;^UTILITY(U,$J,358.3,29855,2)
 ;;=^5010830
 ;;^UTILITY(U,$J,358.3,29856,0)
 ;;=M19.231^^111^1434^26
 ;;^UTILITY(U,$J,358.3,29856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29856,1,3,0)
 ;;=3^Secondary osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,29856,1,4,0)
 ;;=4^M19.231
 ;;^UTILITY(U,$J,358.3,29856,2)
 ;;=^5010844
 ;;^UTILITY(U,$J,358.3,29857,0)
 ;;=M19.232^^111^1434^25
 ;;^UTILITY(U,$J,358.3,29857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29857,1,3,0)
 ;;=3^Secondary osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,29857,1,4,0)
 ;;=4^M19.232
 ;;^UTILITY(U,$J,358.3,29857,2)
 ;;=^5010845
 ;;^UTILITY(U,$J,358.3,29858,0)
 ;;=S63.502D^^111^1434^28
 ;;^UTILITY(U,$J,358.3,29858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29858,1,3,0)
 ;;=3^Sprain of left wrist, subsequent encounter
 ;;^UTILITY(U,$J,358.3,29858,1,4,0)
 ;;=4^S63.502D
 ;;^UTILITY(U,$J,358.3,29858,2)
 ;;=^5035587
 ;;^UTILITY(U,$J,358.3,29859,0)
 ;;=S63.501D^^111^1434^30
 ;;^UTILITY(U,$J,358.3,29859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29859,1,3,0)
 ;;=3^Sprain of right wrist, subsequent encounter
 ;;^UTILITY(U,$J,358.3,29859,1,4,0)
 ;;=4^S63.501D
 ;;^UTILITY(U,$J,358.3,29859,2)
 ;;=^5035584
 ;;^UTILITY(U,$J,358.3,29860,0)
 ;;=S52.501D^^111^1434^12
 ;;^UTILITY(U,$J,358.3,29860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29860,1,3,0)
 ;;=3^Fracture of the lower end of right radius, subs encntr
 ;;^UTILITY(U,$J,358.3,29860,1,4,0)
 ;;=4^S52.501D
 ;;^UTILITY(U,$J,358.3,29860,2)
 ;;=^5030590
 ;;^UTILITY(U,$J,358.3,29861,0)
 ;;=Z89.442^^111^1435^1
 ;;^UTILITY(U,$J,358.3,29861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29861,1,3,0)
 ;;=3^Acquired absence of left ankle
 ;;^UTILITY(U,$J,358.3,29861,1,4,0)
 ;;=4^Z89.442
 ;;^UTILITY(U,$J,358.3,29861,2)
 ;;=^5063564
 ;;^UTILITY(U,$J,358.3,29862,0)
 ;;=Z89.432^^111^1435^2
 ;;^UTILITY(U,$J,358.3,29862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29862,1,3,0)
 ;;=3^Acquired absence of left foot
 ;;^UTILITY(U,$J,358.3,29862,1,4,0)
 ;;=4^Z89.432
 ;;^UTILITY(U,$J,358.3,29862,2)
 ;;=^5063561
 ;;^UTILITY(U,$J,358.3,29863,0)
 ;;=Z89.412^^111^1435^3
 ;;^UTILITY(U,$J,358.3,29863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29863,1,3,0)
 ;;=3^Acquired absence of left great toe
 ;;^UTILITY(U,$J,358.3,29863,1,4,0)
 ;;=4^Z89.412
 ;;^UTILITY(U,$J,358.3,29863,2)
 ;;=^5063555
 ;;^UTILITY(U,$J,358.3,29864,0)
 ;;=Z89.112^^111^1435^4
 ;;^UTILITY(U,$J,358.3,29864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29864,1,3,0)
 ;;=3^Acquired absence of left hand
 ;;^UTILITY(U,$J,358.3,29864,1,4,0)
 ;;=4^Z89.112
 ;;^UTILITY(U,$J,358.3,29864,2)
 ;;=^5063538
 ;;^UTILITY(U,$J,358.3,29865,0)
 ;;=Z89.622^^111^1435^5
 ;;^UTILITY(U,$J,358.3,29865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29865,1,3,0)
 ;;=3^Acquired absence of left hip joint
 ;;^UTILITY(U,$J,358.3,29865,1,4,0)
 ;;=4^Z89.622
 ;;^UTILITY(U,$J,358.3,29865,2)
 ;;=^5063576
 ;;^UTILITY(U,$J,358.3,29866,0)
 ;;=Z89.612^^111^1435^6
 ;;^UTILITY(U,$J,358.3,29866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29866,1,3,0)
 ;;=3^Acquired absence of left leg above knee
 ;;^UTILITY(U,$J,358.3,29866,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,29866,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,29867,0)
 ;;=Z89.512^^111^1435^7
 ;;^UTILITY(U,$J,358.3,29867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29867,1,3,0)
 ;;=3^Acquired absence of left leg below knee
 ;;^UTILITY(U,$J,358.3,29867,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,29867,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,29868,0)
 ;;=Z89.212^^111^1435^8
 ;;^UTILITY(U,$J,358.3,29868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29868,1,3,0)
 ;;=3^Acquired absence of left upper limb below elbow
 ;;^UTILITY(U,$J,358.3,29868,1,4,0)
 ;;=4^Z89.212
 ;;^UTILITY(U,$J,358.3,29868,2)
 ;;=^5063546
 ;;^UTILITY(U,$J,358.3,29869,0)
 ;;=Z89.422^^111^1435^9
 ;;^UTILITY(U,$J,358.3,29869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29869,1,3,0)
 ;;=3^Acquired absence of other left toe(s)
 ;;^UTILITY(U,$J,358.3,29869,1,4,0)
 ;;=4^Z89.422
 ;;^UTILITY(U,$J,358.3,29869,2)
 ;;=^5063558
 ;;^UTILITY(U,$J,358.3,29870,0)
 ;;=Z89.421^^111^1435^10
 ;;^UTILITY(U,$J,358.3,29870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29870,1,3,0)
 ;;=3^Acquired absence of other right toe(s)
 ;;^UTILITY(U,$J,358.3,29870,1,4,0)
 ;;=4^Z89.421
 ;;^UTILITY(U,$J,358.3,29870,2)
 ;;=^5063557
 ;;^UTILITY(U,$J,358.3,29871,0)
 ;;=Z89.441^^111^1435^11
 ;;^UTILITY(U,$J,358.3,29871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29871,1,3,0)
 ;;=3^Acquired absence of right ankle
 ;;^UTILITY(U,$J,358.3,29871,1,4,0)
 ;;=4^Z89.441
 ;;^UTILITY(U,$J,358.3,29871,2)
 ;;=^5063563
 ;;^UTILITY(U,$J,358.3,29872,0)
 ;;=Z89.431^^111^1435^12
 ;;^UTILITY(U,$J,358.3,29872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29872,1,3,0)
 ;;=3^Acquired absence of right foot
 ;;^UTILITY(U,$J,358.3,29872,1,4,0)
 ;;=4^Z89.431
 ;;^UTILITY(U,$J,358.3,29872,2)
 ;;=^5063560
 ;;^UTILITY(U,$J,358.3,29873,0)
 ;;=Z89.411^^111^1435^13
 ;;^UTILITY(U,$J,358.3,29873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29873,1,3,0)
 ;;=3^Acquired absence of right great toe
 ;;^UTILITY(U,$J,358.3,29873,1,4,0)
 ;;=4^Z89.411
 ;;^UTILITY(U,$J,358.3,29873,2)
 ;;=^5063554
 ;;^UTILITY(U,$J,358.3,29874,0)
 ;;=Z89.111^^111^1435^14
 ;;^UTILITY(U,$J,358.3,29874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29874,1,3,0)
 ;;=3^Acquired absence of right hand
 ;;^UTILITY(U,$J,358.3,29874,1,4,0)
 ;;=4^Z89.111
 ;;^UTILITY(U,$J,358.3,29874,2)
 ;;=^5063537
 ;;^UTILITY(U,$J,358.3,29875,0)
 ;;=Z89.621^^111^1435^15
 ;;^UTILITY(U,$J,358.3,29875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29875,1,3,0)
 ;;=3^Acquired absence of right hip joint
 ;;^UTILITY(U,$J,358.3,29875,1,4,0)
 ;;=4^Z89.621
 ;;^UTILITY(U,$J,358.3,29875,2)
 ;;=^5063575
 ;;^UTILITY(U,$J,358.3,29876,0)
 ;;=Z89.611^^111^1435^16
 ;;^UTILITY(U,$J,358.3,29876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29876,1,3,0)
 ;;=3^Acquired absence of right leg above knee
 ;;^UTILITY(U,$J,358.3,29876,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,29876,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,29877,0)
 ;;=Z89.511^^111^1435^17
 ;;^UTILITY(U,$J,358.3,29877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29877,1,3,0)
 ;;=3^Acquired absence of right leg below knee
 ;;^UTILITY(U,$J,358.3,29877,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,29877,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,29878,0)
 ;;=Z89.211^^111^1435^18
 ;;^UTILITY(U,$J,358.3,29878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29878,1,3,0)
 ;;=3^Acquired absence of right upper limb below elbow
 ;;^UTILITY(U,$J,358.3,29878,1,4,0)
 ;;=4^Z89.211
 ;;^UTILITY(U,$J,358.3,29878,2)
 ;;=^5063545
 ;;^UTILITY(U,$J,358.3,29879,0)
 ;;=Z48.02^^111^1436^2
 ;;^UTILITY(U,$J,358.3,29879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29879,1,3,0)
 ;;=3^Removal of sutures
 ;;^UTILITY(U,$J,358.3,29879,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,29879,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,29880,0)
 ;;=Z48.01^^111^1436^1
 ;;^UTILITY(U,$J,358.3,29880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29880,1,3,0)
 ;;=3^Change or removal of surgical wound dressing
 ;;^UTILITY(U,$J,358.3,29880,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,29880,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,29881,0)
 ;;=Z47.1^^111^1437^1
 ;;^UTILITY(U,$J,358.3,29881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29881,1,3,0)
 ;;=3^Aftercare following joint replacement surgery
 ;;^UTILITY(U,$J,358.3,29881,1,4,0)
 ;;=4^Z47.1
 ;;^UTILITY(U,$J,358.3,29881,2)
 ;;=^5063025
 ;;^UTILITY(U,$J,358.3,29882,0)
 ;;=Z46.89^^111^1437^2
