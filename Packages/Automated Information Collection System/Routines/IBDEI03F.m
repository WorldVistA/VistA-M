IBDEI03F ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4045,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,4045,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,4046,0)
 ;;=M47.25^^20^274^27
 ;;^UTILITY(U,$J,358.3,4046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4046,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Thoracolumbar Region NEC
 ;;^UTILITY(U,$J,358.3,4046,1,4,0)
 ;;=4^M47.25
 ;;^UTILITY(U,$J,358.3,4046,2)
 ;;=^5012064
 ;;^UTILITY(U,$J,358.3,4047,0)
 ;;=M47.892^^20^274^36
 ;;^UTILITY(U,$J,358.3,4047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4047,1,3,0)
 ;;=3^Spondylosis,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,4047,1,4,0)
 ;;=4^M47.892
 ;;^UTILITY(U,$J,358.3,4047,2)
 ;;=^5012078
 ;;^UTILITY(U,$J,358.3,4048,0)
 ;;=M47.893^^20^274^37
 ;;^UTILITY(U,$J,358.3,4048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4048,1,3,0)
 ;;=3^Spondylosis,Cervicothoracic Region NEC
 ;;^UTILITY(U,$J,358.3,4048,1,4,0)
 ;;=4^M47.893
 ;;^UTILITY(U,$J,358.3,4048,2)
 ;;=^5012079
 ;;^UTILITY(U,$J,358.3,4049,0)
 ;;=M47.896^^20^274^38
 ;;^UTILITY(U,$J,358.3,4049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4049,1,3,0)
 ;;=3^Spondylosis,Lumbar Region NEC
 ;;^UTILITY(U,$J,358.3,4049,1,4,0)
 ;;=4^M47.896
 ;;^UTILITY(U,$J,358.3,4049,2)
 ;;=^5012082
 ;;^UTILITY(U,$J,358.3,4050,0)
 ;;=M47.897^^20^274^39
 ;;^UTILITY(U,$J,358.3,4050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4050,1,3,0)
 ;;=3^Spondylosis,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,4050,1,4,0)
 ;;=4^M47.897
 ;;^UTILITY(U,$J,358.3,4050,2)
 ;;=^5012083
 ;;^UTILITY(U,$J,358.3,4051,0)
 ;;=M47.891^^20^274^40
 ;;^UTILITY(U,$J,358.3,4051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4051,1,3,0)
 ;;=3^Spondylosis,Occipito-Atlanto-Axial Region NEC
 ;;^UTILITY(U,$J,358.3,4051,1,4,0)
 ;;=4^M47.891
 ;;^UTILITY(U,$J,358.3,4051,2)
 ;;=^5012077
 ;;^UTILITY(U,$J,358.3,4052,0)
 ;;=M47.898^^20^274^41
 ;;^UTILITY(U,$J,358.3,4052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4052,1,3,0)
 ;;=3^Spondylosis,Sacral/Sacrococcygeal Region NEC
 ;;^UTILITY(U,$J,358.3,4052,1,4,0)
 ;;=4^M47.898
 ;;^UTILITY(U,$J,358.3,4052,2)
 ;;=^5012084
 ;;^UTILITY(U,$J,358.3,4053,0)
 ;;=M47.894^^20^274^42
 ;;^UTILITY(U,$J,358.3,4053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4053,1,3,0)
 ;;=3^Spondylosis,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,4053,1,4,0)
 ;;=4^M47.894
 ;;^UTILITY(U,$J,358.3,4053,2)
 ;;=^5012080
 ;;^UTILITY(U,$J,358.3,4054,0)
 ;;=M47.895^^20^274^43
 ;;^UTILITY(U,$J,358.3,4054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4054,1,3,0)
 ;;=3^Spondylosis,Thoracolumbar Region NEC
 ;;^UTILITY(U,$J,358.3,4054,1,4,0)
 ;;=4^M47.895
 ;;^UTILITY(U,$J,358.3,4054,2)
 ;;=^5012081
 ;;^UTILITY(U,$J,358.3,4055,0)
 ;;=M75.121^^20^274^19
 ;;^UTILITY(U,$J,358.3,4055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4055,1,3,0)
 ;;=3^Rotator Cuff Syndrome,Right Shoulder
 ;;^UTILITY(U,$J,358.3,4055,1,4,0)
 ;;=4^M75.121
 ;;^UTILITY(U,$J,358.3,4055,2)
 ;;=^5013248
 ;;^UTILITY(U,$J,358.3,4056,0)
 ;;=M75.122^^20^274^18
 ;;^UTILITY(U,$J,358.3,4056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4056,1,3,0)
 ;;=3^Rotator Cuff Syndrome,Left Shoulder
 ;;^UTILITY(U,$J,358.3,4056,1,4,0)
 ;;=4^M75.122
 ;;^UTILITY(U,$J,358.3,4056,2)
 ;;=^5013249
 ;;^UTILITY(U,$J,358.3,4057,0)
 ;;=M47.816^^20^274^30
 ;;^UTILITY(U,$J,358.3,4057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4057,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,4057,1,4,0)
 ;;=4^M47.816
 ;;^UTILITY(U,$J,358.3,4057,2)
 ;;=^5012073
 ;;^UTILITY(U,$J,358.3,4058,0)
 ;;=M47.817^^20^274^31
 ;;^UTILITY(U,$J,358.3,4058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4058,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,4058,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,4058,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,4059,0)
 ;;=M47.811^^20^274^32
 ;;^UTILITY(U,$J,358.3,4059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4059,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Occipito/Atlanto/Axial Region
 ;;^UTILITY(U,$J,358.3,4059,1,4,0)
 ;;=4^M47.811
 ;;^UTILITY(U,$J,358.3,4059,2)
 ;;=^5012068
 ;;^UTILITY(U,$J,358.3,4060,0)
 ;;=M47.818^^20^274^33
 ;;^UTILITY(U,$J,358.3,4060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4060,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,4060,1,4,0)
 ;;=4^M47.818
 ;;^UTILITY(U,$J,358.3,4060,2)
 ;;=^5012075
 ;;^UTILITY(U,$J,358.3,4061,0)
 ;;=M47.814^^20^274^34
 ;;^UTILITY(U,$J,358.3,4061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4061,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,4061,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,4061,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,4062,0)
 ;;=M47.815^^20^274^35
 ;;^UTILITY(U,$J,358.3,4062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4062,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,4062,1,4,0)
 ;;=4^M47.815
 ;;^UTILITY(U,$J,358.3,4062,2)
 ;;=^5012072
 ;;^UTILITY(U,$J,358.3,4063,0)
 ;;=S08.111A^^20^275^3
 ;;^UTILITY(U,$J,358.3,4063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4063,1,3,0)
 ;;=3^Complete Traumatic Amputation of Right Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,4063,1,4,0)
 ;;=4^S08.111A
 ;;^UTILITY(U,$J,358.3,4063,2)
 ;;=^5021251
 ;;^UTILITY(U,$J,358.3,4064,0)
 ;;=S08.112A^^20^275^2
 ;;^UTILITY(U,$J,358.3,4064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4064,1,3,0)
 ;;=3^Complete Traumatic Amputation of Left Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,4064,1,4,0)
 ;;=4^S08.112A
 ;;^UTILITY(U,$J,358.3,4064,2)
 ;;=^5021254
 ;;^UTILITY(U,$J,358.3,4065,0)
 ;;=S08.0XXA^^20^275^1
 ;;^UTILITY(U,$J,358.3,4065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4065,1,3,0)
 ;;=3^Avulsion of Scalp,Init Encntr
 ;;^UTILITY(U,$J,358.3,4065,1,4,0)
 ;;=4^S08.0XXA
 ;;^UTILITY(U,$J,358.3,4065,2)
 ;;=^5021248
 ;;^UTILITY(U,$J,358.3,4066,0)
 ;;=S09.90XA^^20^275^6
 ;;^UTILITY(U,$J,358.3,4066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4066,1,3,0)
 ;;=3^Injury of Head,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,4066,1,4,0)
 ;;=4^S09.90XA
 ;;^UTILITY(U,$J,358.3,4066,2)
 ;;=^5021332
 ;;^UTILITY(U,$J,358.3,4067,0)
 ;;=S09.8XXA^^20^275^5
 ;;^UTILITY(U,$J,358.3,4067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4067,1,3,0)
 ;;=3^Injury of Head NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,4067,1,4,0)
 ;;=4^S09.8XXA
 ;;^UTILITY(U,$J,358.3,4067,2)
 ;;=^5021329
 ;;^UTILITY(U,$J,358.3,4068,0)
 ;;=S08.89XA^^20^275^7
 ;;^UTILITY(U,$J,358.3,4068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4068,1,3,0)
 ;;=3^Traumatic Amputation of Parts of Head NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,4068,1,4,0)
 ;;=4^S08.89XA
 ;;^UTILITY(U,$J,358.3,4068,2)
 ;;=^5021275
 ;;^UTILITY(U,$J,358.3,4069,0)
 ;;=S09.93XA^^20^275^4
 ;;^UTILITY(U,$J,358.3,4069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4069,1,3,0)
 ;;=3^Injury of Face,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,4069,1,4,0)
 ;;=4^S09.93XA
 ;;^UTILITY(U,$J,358.3,4069,2)
 ;;=^5021341
 ;;^UTILITY(U,$J,358.3,4070,0)
 ;;=M79.671^^20^276^13
 ;;^UTILITY(U,$J,358.3,4070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4070,1,3,0)
 ;;=3^Right Foot Pain
 ;;^UTILITY(U,$J,358.3,4070,1,4,0)
 ;;=4^M79.671
 ;;^UTILITY(U,$J,358.3,4070,2)
 ;;=^5013350
 ;;^UTILITY(U,$J,358.3,4071,0)
 ;;=M79.675^^20^276^9
 ;;^UTILITY(U,$J,358.3,4071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4071,1,3,0)
 ;;=3^Left Toe(s) Pain
 ;;^UTILITY(U,$J,358.3,4071,1,4,0)
 ;;=4^M79.675
 ;;^UTILITY(U,$J,358.3,4071,2)
 ;;=^5013354
 ;;^UTILITY(U,$J,358.3,4072,0)
 ;;=M79.674^^20^276^19
 ;;^UTILITY(U,$J,358.3,4072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4072,1,3,0)
 ;;=3^Right Toe(s) Pain
 ;;^UTILITY(U,$J,358.3,4072,1,4,0)
 ;;=4^M79.674
 ;;^UTILITY(U,$J,358.3,4072,2)
 ;;=^5013353
 ;;^UTILITY(U,$J,358.3,4073,0)
 ;;=M79.672^^20^276^3
 ;;^UTILITY(U,$J,358.3,4073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4073,1,3,0)
 ;;=3^Left Foot Pain
 ;;^UTILITY(U,$J,358.3,4073,1,4,0)
 ;;=4^M79.672
 ;;^UTILITY(U,$J,358.3,4073,2)
 ;;=^5013351
 ;;^UTILITY(U,$J,358.3,4074,0)
 ;;=M79.661^^20^276^17
 ;;^UTILITY(U,$J,358.3,4074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4074,1,3,0)
 ;;=3^Right Lower Leg Pain
 ;;^UTILITY(U,$J,358.3,4074,1,4,0)
 ;;=4^M79.661
 ;;^UTILITY(U,$J,358.3,4074,2)
 ;;=^5013347
 ;;^UTILITY(U,$J,358.3,4075,0)
 ;;=M79.662^^20^276^7
 ;;^UTILITY(U,$J,358.3,4075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4075,1,3,0)
 ;;=3^Left Lower Leg Pain
 ;;^UTILITY(U,$J,358.3,4075,1,4,0)
 ;;=4^M79.662
 ;;^UTILITY(U,$J,358.3,4075,2)
 ;;=^5013348
 ;;^UTILITY(U,$J,358.3,4076,0)
 ;;=M79.652^^20^276^8
 ;;^UTILITY(U,$J,358.3,4076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4076,1,3,0)
 ;;=3^Left Thigh Pain
 ;;^UTILITY(U,$J,358.3,4076,1,4,0)
 ;;=4^M79.652
 ;;^UTILITY(U,$J,358.3,4076,2)
 ;;=^5013345
 ;;^UTILITY(U,$J,358.3,4077,0)
 ;;=M79.651^^20^276^18
 ;;^UTILITY(U,$J,358.3,4077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4077,1,3,0)
 ;;=3^Right Thigh Pain
 ;;^UTILITY(U,$J,358.3,4077,1,4,0)
 ;;=4^M79.651
 ;;^UTILITY(U,$J,358.3,4077,2)
 ;;=^5013344
 ;;^UTILITY(U,$J,358.3,4078,0)
 ;;=M79.605^^20^276^6
 ;;^UTILITY(U,$J,358.3,4078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4078,1,3,0)
 ;;=3^Left Leg Pain
 ;;^UTILITY(U,$J,358.3,4078,1,4,0)
 ;;=4^M79.605
 ;;^UTILITY(U,$J,358.3,4078,2)
 ;;=^5013329
 ;;^UTILITY(U,$J,358.3,4079,0)
 ;;=M79.621^^20^276^20
 ;;^UTILITY(U,$J,358.3,4079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4079,1,3,0)
 ;;=3^Right Upper Arm Pain
 ;;^UTILITY(U,$J,358.3,4079,1,4,0)
 ;;=4^M79.621
 ;;^UTILITY(U,$J,358.3,4079,2)
 ;;=^5013332
 ;;^UTILITY(U,$J,358.3,4080,0)
 ;;=M79.622^^20^276^10
 ;;^UTILITY(U,$J,358.3,4080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4080,1,3,0)
 ;;=3^Left Upper Arm Pain
 ;;^UTILITY(U,$J,358.3,4080,1,4,0)
 ;;=4^M79.622
 ;;^UTILITY(U,$J,358.3,4080,2)
 ;;=^5013333
 ;;^UTILITY(U,$J,358.3,4081,0)
 ;;=M79.631^^20^276^14
