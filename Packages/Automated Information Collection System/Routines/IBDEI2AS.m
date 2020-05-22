IBDEI2AS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36684,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Left Ankle/Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,36684,1,4,0)
 ;;=4^S95.902A
 ;;^UTILITY(U,$J,358.3,36684,2)
 ;;=^5137720
 ;;^UTILITY(U,$J,358.3,36685,0)
 ;;=S55.902A^^142^1863^225
 ;;^UTILITY(U,$J,358.3,36685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36685,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Left Forearm,Init Encntr
 ;;^UTILITY(U,$J,358.3,36685,1,4,0)
 ;;=4^S55.902A
 ;;^UTILITY(U,$J,358.3,36685,2)
 ;;=^5135411
 ;;^UTILITY(U,$J,358.3,36686,0)
 ;;=S75.902A^^142^1863^226
 ;;^UTILITY(U,$J,358.3,36686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36686,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Left Hip/Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,36686,1,4,0)
 ;;=4^S75.902A
 ;;^UTILITY(U,$J,358.3,36686,2)
 ;;=^5136535
 ;;^UTILITY(U,$J,358.3,36687,0)
 ;;=S85.902A^^142^1863^227
 ;;^UTILITY(U,$J,358.3,36687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36687,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Left Lower Leg,Init Encntr
 ;;^UTILITY(U,$J,358.3,36687,1,4,0)
 ;;=4^S85.902A
 ;;^UTILITY(U,$J,358.3,36687,2)
 ;;=^5137130
 ;;^UTILITY(U,$J,358.3,36688,0)
 ;;=S45.902A^^142^1863^228
 ;;^UTILITY(U,$J,358.3,36688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36688,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Left Shoulder/Upper Arm,Init Encntr
 ;;^UTILITY(U,$J,358.3,36688,1,4,0)
 ;;=4^S45.902A
 ;;^UTILITY(U,$J,358.3,36688,2)
 ;;=^5028125
 ;;^UTILITY(U,$J,358.3,36689,0)
 ;;=S65.902A^^142^1863^229
 ;;^UTILITY(U,$J,358.3,36689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36689,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Left Wrist/Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,36689,1,4,0)
 ;;=4^S65.902A
 ;;^UTILITY(U,$J,358.3,36689,2)
 ;;=^5136085
 ;;^UTILITY(U,$J,358.3,36690,0)
 ;;=S95.901A^^142^1863^230
 ;;^UTILITY(U,$J,358.3,36690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36690,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Right Ankle/Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,36690,1,4,0)
 ;;=4^S95.901A
 ;;^UTILITY(U,$J,358.3,36690,2)
 ;;=^5046038
 ;;^UTILITY(U,$J,358.3,36691,0)
 ;;=S55.901A^^142^1863^231
 ;;^UTILITY(U,$J,358.3,36691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36691,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Right Forearm,Init Encntr
 ;;^UTILITY(U,$J,358.3,36691,1,4,0)
 ;;=4^S55.901A
 ;;^UTILITY(U,$J,358.3,36691,2)
 ;;=^5031547
 ;;^UTILITY(U,$J,358.3,36692,0)
 ;;=S75.901A^^142^1863^232
 ;;^UTILITY(U,$J,358.3,36692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36692,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Right Hip/Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,36692,1,4,0)
 ;;=4^S75.901A
 ;;^UTILITY(U,$J,358.3,36692,2)
 ;;=^5039492
 ;;^UTILITY(U,$J,358.3,36693,0)
 ;;=S85.901A^^142^1863^233
 ;;^UTILITY(U,$J,358.3,36693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36693,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Right Lower Leg,Init Encntr
 ;;^UTILITY(U,$J,358.3,36693,1,4,0)
 ;;=4^S85.901A
 ;;^UTILITY(U,$J,358.3,36693,2)
 ;;=^5043415
 ;;^UTILITY(U,$J,358.3,36694,0)
 ;;=S45.901A^^142^1863^235
 ;;^UTILITY(U,$J,358.3,36694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36694,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Right Shoulder/Upper Arm,Init Encntr
 ;;^UTILITY(U,$J,358.3,36694,1,4,0)
 ;;=4^S45.901A
 ;;^UTILITY(U,$J,358.3,36694,2)
 ;;=^5028122
 ;;^UTILITY(U,$J,358.3,36695,0)
 ;;=S85.901A^^142^1863^234
 ;;^UTILITY(U,$J,358.3,36695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36695,1,3,0)
 ;;=3^Injury Blood Vessel Unspec Right Lower Leg,Init Encntr
