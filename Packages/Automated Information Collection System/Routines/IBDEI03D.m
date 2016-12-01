IBDEI03D ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3978,0)
 ;;=S61.401A^^20^273^43
 ;;^UTILITY(U,$J,358.3,3978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3978,1,3,0)
 ;;=3^Open Wound of Right Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,3978,1,4,0)
 ;;=4^S61.401A
 ;;^UTILITY(U,$J,358.3,3978,2)
 ;;=^5032981
 ;;^UTILITY(U,$J,358.3,3979,0)
 ;;=S61.402A^^20^273^12
 ;;^UTILITY(U,$J,358.3,3979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3979,1,3,0)
 ;;=3^Open Wound of Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,3979,1,4,0)
 ;;=4^S61.402A
 ;;^UTILITY(U,$J,358.3,3979,2)
 ;;=^5032984
 ;;^UTILITY(U,$J,358.3,3980,0)
 ;;=S61.001A^^20^273^60
 ;;^UTILITY(U,$J,358.3,3980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3980,1,3,0)
 ;;=3^Open Wound of Right Thumb w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3980,1,4,0)
 ;;=4^S61.001A
 ;;^UTILITY(U,$J,358.3,3980,2)
 ;;=^5032684
 ;;^UTILITY(U,$J,358.3,3981,0)
 ;;=S61.002A^^20^273^29
 ;;^UTILITY(U,$J,358.3,3981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3981,1,3,0)
 ;;=3^Open Wound of Left Thumb w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3981,1,4,0)
 ;;=4^S61.002A
 ;;^UTILITY(U,$J,358.3,3981,2)
 ;;=^5032687
 ;;^UTILITY(U,$J,358.3,3982,0)
 ;;=S61.101A^^20^273^59
 ;;^UTILITY(U,$J,358.3,3982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3982,1,3,0)
 ;;=3^Open Wound of Right Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3982,1,4,0)
 ;;=4^S61.101A
 ;;^UTILITY(U,$J,358.3,3982,2)
 ;;=^5032723
 ;;^UTILITY(U,$J,358.3,3983,0)
 ;;=S61.102A^^20^273^28
 ;;^UTILITY(U,$J,358.3,3983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3983,1,3,0)
 ;;=3^Open Wound of Left Thumb w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3983,1,4,0)
 ;;=4^S61.102A
 ;;^UTILITY(U,$J,358.3,3983,2)
 ;;=^5135687
 ;;^UTILITY(U,$J,358.3,3984,0)
 ;;=S61.200A^^20^273^46
 ;;^UTILITY(U,$J,358.3,3984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3984,1,3,0)
 ;;=3^Open Wound of Right Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3984,1,4,0)
 ;;=4^S61.200A
 ;;^UTILITY(U,$J,358.3,3984,2)
 ;;=^5032741
 ;;^UTILITY(U,$J,358.3,3985,0)
 ;;=S61.201A^^20^273^15
 ;;^UTILITY(U,$J,358.3,3985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3985,1,3,0)
 ;;=3^Open Wound of Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3985,1,4,0)
 ;;=4^S61.201A
 ;;^UTILITY(U,$J,358.3,3985,2)
 ;;=^5032744
 ;;^UTILITY(U,$J,358.3,3986,0)
 ;;=S61.202A^^20^273^54
 ;;^UTILITY(U,$J,358.3,3986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3986,1,3,0)
 ;;=3^Open Wound of Right Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3986,1,4,0)
 ;;=4^S61.202A
 ;;^UTILITY(U,$J,358.3,3986,2)
 ;;=^5032747
 ;;^UTILITY(U,$J,358.3,3987,0)
 ;;=S61.203A^^20^273^23
 ;;^UTILITY(U,$J,358.3,3987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3987,1,3,0)
 ;;=3^Open Wound of Left Middle Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3987,1,4,0)
 ;;=4^S61.203A
 ;;^UTILITY(U,$J,358.3,3987,2)
 ;;=^5032750
 ;;^UTILITY(U,$J,358.3,3988,0)
 ;;=S61.204A^^20^273^56
 ;;^UTILITY(U,$J,358.3,3988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3988,1,3,0)
 ;;=3^Open Wound of Right Ring Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3988,1,4,0)
 ;;=4^S61.204A
 ;;^UTILITY(U,$J,358.3,3988,2)
 ;;=^5032753
 ;;^UTILITY(U,$J,358.3,3989,0)
 ;;=S61.205A^^20^273^25
 ;;^UTILITY(U,$J,358.3,3989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3989,1,3,0)
 ;;=3^Open Wound of Left Ring Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3989,1,4,0)
 ;;=4^S61.205A
 ;;^UTILITY(U,$J,358.3,3989,2)
 ;;=^5032756
 ;;^UTILITY(U,$J,358.3,3990,0)
 ;;=S61.206A^^20^273^51
 ;;^UTILITY(U,$J,358.3,3990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3990,1,3,0)
 ;;=3^Open Wound of Right Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3990,1,4,0)
 ;;=4^S61.206A
 ;;^UTILITY(U,$J,358.3,3990,2)
 ;;=^5032759
 ;;^UTILITY(U,$J,358.3,3991,0)
 ;;=S61.207A^^20^273^20
 ;;^UTILITY(U,$J,358.3,3991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3991,1,3,0)
 ;;=3^Open Wound of Left Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3991,1,4,0)
 ;;=4^S61.207A
 ;;^UTILITY(U,$J,358.3,3991,2)
 ;;=^5032762
 ;;^UTILITY(U,$J,358.3,3992,0)
 ;;=S61.300A^^20^273^45
 ;;^UTILITY(U,$J,358.3,3992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3992,1,3,0)
 ;;=3^Open Wound of Right Index Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3992,1,4,0)
 ;;=4^S61.300A
 ;;^UTILITY(U,$J,358.3,3992,2)
 ;;=^5032891
 ;;^UTILITY(U,$J,358.3,3993,0)
 ;;=S61.301A^^20^273^14
 ;;^UTILITY(U,$J,358.3,3993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3993,1,3,0)
 ;;=3^Open Wound of Left Index Finger w/ Damage to Nail,Init Encntr
 ;;^UTILITY(U,$J,358.3,3993,1,4,0)
 ;;=4^S61.301A
 ;;^UTILITY(U,$J,358.3,3993,2)
 ;;=^5135735
 ;;^UTILITY(U,$J,358.3,3994,0)
 ;;=S61.302A^^20^273^53
 ;;^UTILITY(U,$J,358.3,3994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3994,1,3,0)
 ;;=3^Open Wound of Right Middle Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3994,1,4,0)
 ;;=4^S61.302A
 ;;^UTILITY(U,$J,358.3,3994,2)
 ;;=^5032894
 ;;^UTILITY(U,$J,358.3,3995,0)
 ;;=S61.303A^^20^273^22
 ;;^UTILITY(U,$J,358.3,3995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3995,1,3,0)
 ;;=3^Open Wound of Left Middle Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3995,1,4,0)
 ;;=4^S61.303A
 ;;^UTILITY(U,$J,358.3,3995,2)
 ;;=^5135738
 ;;^UTILITY(U,$J,358.3,3996,0)
 ;;=S61.304A^^20^273^55
 ;;^UTILITY(U,$J,358.3,3996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3996,1,3,0)
 ;;=3^Open Wound of Right Ring Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3996,1,4,0)
 ;;=4^S61.304A
 ;;^UTILITY(U,$J,358.3,3996,2)
 ;;=^5032897
 ;;^UTILITY(U,$J,358.3,3997,0)
 ;;=S61.305A^^20^273^24
 ;;^UTILITY(U,$J,358.3,3997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3997,1,3,0)
 ;;=3^Open Wound of Left Ring Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3997,1,4,0)
 ;;=4^S61.305A
 ;;^UTILITY(U,$J,358.3,3997,2)
 ;;=^5135741
 ;;^UTILITY(U,$J,358.3,3998,0)
 ;;=S61.306A^^20^273^50
 ;;^UTILITY(U,$J,358.3,3998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3998,1,3,0)
 ;;=3^Open Wound of Right Little Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3998,1,4,0)
 ;;=4^S61.306A
 ;;^UTILITY(U,$J,358.3,3998,2)
 ;;=^5032900
 ;;^UTILITY(U,$J,358.3,3999,0)
 ;;=S61.307A^^20^273^19
 ;;^UTILITY(U,$J,358.3,3999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3999,1,3,0)
 ;;=3^Open Wound of Left Little Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3999,1,4,0)
 ;;=4^S61.307A
 ;;^UTILITY(U,$J,358.3,3999,2)
 ;;=^5135744
 ;;^UTILITY(U,$J,358.3,4000,0)
 ;;=S71.102A^^20^273^27
 ;;^UTILITY(U,$J,358.3,4000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4000,1,3,0)
 ;;=3^Open Wound of Left Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,4000,1,4,0)
 ;;=4^S71.102A
 ;;^UTILITY(U,$J,358.3,4000,2)
 ;;=^5037011
 ;;^UTILITY(U,$J,358.3,4001,0)
 ;;=S71.101A^^20^273^58
 ;;^UTILITY(U,$J,358.3,4001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4001,1,3,0)
 ;;=3^Open Wound of Right Thigh,Init Encntr
 ;;^UTILITY(U,$J,358.3,4001,1,4,0)
 ;;=4^S71.101A
 ;;^UTILITY(U,$J,358.3,4001,2)
 ;;=^5037008
 ;;^UTILITY(U,$J,358.3,4002,0)
 ;;=S71.002A^^20^273^13
 ;;^UTILITY(U,$J,358.3,4002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4002,1,3,0)
 ;;=3^Open Wound of Left Hip,Init Encntr
 ;;^UTILITY(U,$J,358.3,4002,1,4,0)
 ;;=4^S71.002A
 ;;^UTILITY(U,$J,358.3,4002,2)
 ;;=^5036972
 ;;^UTILITY(U,$J,358.3,4003,0)
 ;;=S71.001A^^20^273^44
 ;;^UTILITY(U,$J,358.3,4003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4003,1,3,0)
 ;;=3^Open Wound of Right Hip,Init Encntr
 ;;^UTILITY(U,$J,358.3,4003,1,4,0)
 ;;=4^S71.001A
 ;;^UTILITY(U,$J,358.3,4003,2)
 ;;=^5036969
 ;;^UTILITY(U,$J,358.3,4004,0)
 ;;=S91.002A^^20^273^5
 ;;^UTILITY(U,$J,358.3,4004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4004,1,3,0)
 ;;=3^Open Wound of Left Ankle,Init Encntr
 ;;^UTILITY(U,$J,358.3,4004,1,4,0)
 ;;=4^S91.002A
 ;;^UTILITY(U,$J,358.3,4004,2)
 ;;=^5044132
 ;;^UTILITY(U,$J,358.3,4005,0)
 ;;=S91.001A^^20^273^36
 ;;^UTILITY(U,$J,358.3,4005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4005,1,3,0)
 ;;=3^Open Wound of Right Ankle,Init Encntr
 ;;^UTILITY(U,$J,358.3,4005,1,4,0)
 ;;=4^S91.001A
 ;;^UTILITY(U,$J,358.3,4005,2)
 ;;=^5044129
 ;;^UTILITY(U,$J,358.3,4006,0)
 ;;=S81.802A^^20^273^21
 ;;^UTILITY(U,$J,358.3,4006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4006,1,3,0)
 ;;=3^Open Wound of Left Lower Leg,Init Encntr
 ;;^UTILITY(U,$J,358.3,4006,1,4,0)
 ;;=4^S81.802A
 ;;^UTILITY(U,$J,358.3,4006,2)
 ;;=^5040068
 ;;^UTILITY(U,$J,358.3,4007,0)
 ;;=S81.801A^^20^273^52
 ;;^UTILITY(U,$J,358.3,4007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4007,1,3,0)
 ;;=3^Open Wound of Right Lower Leg,Init Encntr
 ;;^UTILITY(U,$J,358.3,4007,1,4,0)
 ;;=4^S81.801A
 ;;^UTILITY(U,$J,358.3,4007,2)
 ;;=^5040065
 ;;^UTILITY(U,$J,358.3,4008,0)
 ;;=S81.002A^^20^273^16
 ;;^UTILITY(U,$J,358.3,4008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4008,1,3,0)
 ;;=3^Open Wound of Left Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,4008,1,4,0)
 ;;=4^S81.002A
 ;;^UTILITY(U,$J,358.3,4008,2)
 ;;=^5040029
 ;;^UTILITY(U,$J,358.3,4009,0)
 ;;=S81.001A^^20^273^47
 ;;^UTILITY(U,$J,358.3,4009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4009,1,3,0)
 ;;=3^Open Wound of Right Knee,Init Encntr
 ;;^UTILITY(U,$J,358.3,4009,1,4,0)
 ;;=4^S81.001A
 ;;^UTILITY(U,$J,358.3,4009,2)
 ;;=^5040026
 ;;^UTILITY(U,$J,358.3,4010,0)
 ;;=S91.301A^^20^273^40
 ;;^UTILITY(U,$J,358.3,4010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4010,1,3,0)
 ;;=3^Open Wound of Right Foot,Init Encntr
 ;;^UTILITY(U,$J,358.3,4010,1,4,0)
 ;;=4^S91.301A
 ;;^UTILITY(U,$J,358.3,4010,2)
 ;;=^5044314
 ;;^UTILITY(U,$J,358.3,4011,0)
 ;;=S91.302A^^20^273^9
 ;;^UTILITY(U,$J,358.3,4011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4011,1,3,0)
 ;;=3^Open Wound of Left Foot,Init Encntr
