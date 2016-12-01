IBDEI0P8 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31983,1,3,0)
 ;;=3^Osteoarthritis of knee, unspecified
 ;;^UTILITY(U,$J,358.3,31983,1,4,0)
 ;;=4^M17.9
 ;;^UTILITY(U,$J,358.3,31983,2)
 ;;=^5010794
 ;;^UTILITY(U,$J,358.3,31984,0)
 ;;=M15.0^^94^1409^19
 ;;^UTILITY(U,$J,358.3,31984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31984,1,3,0)
 ;;=3^Primary generalized (osteo)arthritis
 ;;^UTILITY(U,$J,358.3,31984,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,31984,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,31985,0)
 ;;=M19.072^^94^1409^20
 ;;^UTILITY(U,$J,358.3,31985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31985,1,3,0)
 ;;=3^Primary osteoarthritis, left ankle and foot
 ;;^UTILITY(U,$J,358.3,31985,1,4,0)
 ;;=4^M19.072
 ;;^UTILITY(U,$J,358.3,31985,2)
 ;;=^5010821
 ;;^UTILITY(U,$J,358.3,31986,0)
 ;;=M19.042^^94^1409^21
 ;;^UTILITY(U,$J,358.3,31986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31986,1,3,0)
 ;;=3^Primary osteoarthritis, left hand
 ;;^UTILITY(U,$J,358.3,31986,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,31986,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,31987,0)
 ;;=M19.012^^94^1409^22
 ;;^UTILITY(U,$J,358.3,31987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31987,1,3,0)
 ;;=3^Primary osteoarthritis, left shoulder
 ;;^UTILITY(U,$J,358.3,31987,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,31987,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,31988,0)
 ;;=M19.071^^94^1409^23
 ;;^UTILITY(U,$J,358.3,31988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31988,1,3,0)
 ;;=3^Primary osteoarthritis, right ankle and foot
 ;;^UTILITY(U,$J,358.3,31988,1,4,0)
 ;;=4^M19.071
 ;;^UTILITY(U,$J,358.3,31988,2)
 ;;=^5010820
 ;;^UTILITY(U,$J,358.3,31989,0)
 ;;=M19.041^^94^1409^24
 ;;^UTILITY(U,$J,358.3,31989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31989,1,3,0)
 ;;=3^Primary osteoarthritis, right hand
 ;;^UTILITY(U,$J,358.3,31989,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,31989,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,31990,0)
 ;;=M19.011^^94^1409^25
 ;;^UTILITY(U,$J,358.3,31990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31990,1,3,0)
 ;;=3^Primary osteoarthritis, right shoulder
 ;;^UTILITY(U,$J,358.3,31990,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,31990,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,31991,0)
 ;;=M76.12^^94^1409^26
 ;;^UTILITY(U,$J,358.3,31991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31991,1,3,0)
 ;;=3^Psoas tendinitis, left hip
 ;;^UTILITY(U,$J,358.3,31991,1,4,0)
 ;;=4^M76.12
 ;;^UTILITY(U,$J,358.3,31991,2)
 ;;=^5013271
 ;;^UTILITY(U,$J,358.3,31992,0)
 ;;=M76.11^^94^1409^27
 ;;^UTILITY(U,$J,358.3,31992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31992,1,3,0)
 ;;=3^Psoas tendinitis, right hip
 ;;^UTILITY(U,$J,358.3,31992,1,4,0)
 ;;=4^M76.11
 ;;^UTILITY(U,$J,358.3,31992,2)
 ;;=^5013270
 ;;^UTILITY(U,$J,358.3,31993,0)
 ;;=M70.62^^94^1409^58
 ;;^UTILITY(U,$J,358.3,31993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31993,1,3,0)
 ;;=3^Trochanteric bursitis, left hip
 ;;^UTILITY(U,$J,358.3,31993,1,4,0)
 ;;=4^M70.62
 ;;^UTILITY(U,$J,358.3,31993,2)
 ;;=^5013060
 ;;^UTILITY(U,$J,358.3,31994,0)
 ;;=M70.61^^94^1409^59
 ;;^UTILITY(U,$J,358.3,31994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31994,1,3,0)
 ;;=3^Trochanteric bursitis, right hip
 ;;^UTILITY(U,$J,358.3,31994,1,4,0)
 ;;=4^M70.61
 ;;^UTILITY(U,$J,358.3,31994,2)
 ;;=^5013059
 ;;^UTILITY(U,$J,358.3,31995,0)
 ;;=S22.9XXS^^94^1410^6
 ;;^UTILITY(U,$J,358.3,31995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31995,1,3,0)
 ;;=3^Fracture of bony thorax, part unspecified, sequela
 ;;^UTILITY(U,$J,358.3,31995,1,4,0)
 ;;=4^S22.9XXS
 ;;^UTILITY(U,$J,358.3,31995,2)
 ;;=^5023158
 ;;^UTILITY(U,$J,358.3,31996,0)
 ;;=S42.92XS^^94^1410^14
 ;;^UTILITY(U,$J,358.3,31996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31996,1,3,0)
 ;;=3^Fracture of left shoulder girdle, part unspecified, sequela
 ;;^UTILITY(U,$J,358.3,31996,1,4,0)
 ;;=4^S42.92XS
 ;;^UTILITY(U,$J,358.3,31996,2)
 ;;=^5027656
 ;;^UTILITY(U,$J,358.3,31997,0)
 ;;=S12.9XXS^^94^1410^21
 ;;^UTILITY(U,$J,358.3,31997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31997,1,3,0)
 ;;=3^Fracture of neck, unspecified, sequela
 ;;^UTILITY(U,$J,358.3,31997,1,4,0)
 ;;=4^S12.9XXS
 ;;^UTILITY(U,$J,358.3,31997,2)
 ;;=^5021964
 ;;^UTILITY(U,$J,358.3,31998,0)
 ;;=S42.91XS^^94^1410^31
 ;;^UTILITY(U,$J,358.3,31998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31998,1,3,0)
 ;;=3^Fracture of right shoulder girdle, part unspecified, sequela
 ;;^UTILITY(U,$J,358.3,31998,1,4,0)
 ;;=4^S42.91XS
 ;;^UTILITY(U,$J,358.3,31998,2)
 ;;=^5027649
 ;;^UTILITY(U,$J,358.3,31999,0)
 ;;=S72.001S^^94^1410^40
 ;;^UTILITY(U,$J,358.3,31999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31999,1,3,0)
 ;;=3^Fracture of unspecified part of neck of right femur, sequela
 ;;^UTILITY(U,$J,358.3,31999,1,4,0)
 ;;=4^S72.001S
 ;;^UTILITY(U,$J,358.3,31999,2)
 ;;=^5037062
 ;;^UTILITY(U,$J,358.3,32000,0)
 ;;=S32.9XXS^^94^1410^41
 ;;^UTILITY(U,$J,358.3,32000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32000,1,3,0)
 ;;=3^Fracture of unspecified parts of lumbosacral spine & pelvis, sequela
 ;;^UTILITY(U,$J,358.3,32000,1,4,0)
 ;;=4^S32.9XXS
 ;;^UTILITY(U,$J,358.3,32000,2)
 ;;=^5025126
 ;;^UTILITY(U,$J,358.3,32001,0)
 ;;=S92.902S^^94^1410^10
 ;;^UTILITY(U,$J,358.3,32001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32001,1,3,0)
 ;;=3^Fracture of left foot, sequela
 ;;^UTILITY(U,$J,358.3,32001,1,4,0)
 ;;=4^S92.902S
 ;;^UTILITY(U,$J,358.3,32001,2)
 ;;=^5045591
 ;;^UTILITY(U,$J,358.3,32002,0)
 ;;=S52.92XS^^94^1410^11
 ;;^UTILITY(U,$J,358.3,32002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32002,1,3,0)
 ;;=3^Fracture of left forearm, sequela
 ;;^UTILITY(U,$J,358.3,32002,1,4,0)
 ;;=4^S52.92XS
 ;;^UTILITY(U,$J,358.3,32002,2)
 ;;=^5031189
 ;;^UTILITY(U,$J,358.3,32003,0)
 ;;=S82.92XS^^94^1410^12
 ;;^UTILITY(U,$J,358.3,32003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32003,1,3,0)
 ;;=3^Fracture of left lower leg, sequela
 ;;^UTILITY(U,$J,358.3,32003,1,4,0)
 ;;=4^S82.92XS
 ;;^UTILITY(U,$J,358.3,32003,2)
 ;;=^5136992
 ;;^UTILITY(U,$J,358.3,32004,0)
 ;;=S82.002S^^94^1410^13
 ;;^UTILITY(U,$J,358.3,32004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32004,1,3,0)
 ;;=3^Fracture of left patella, sequela
 ;;^UTILITY(U,$J,358.3,32004,1,4,0)
 ;;=4^S82.002S
 ;;^UTILITY(U,$J,358.3,32004,2)
 ;;=^5040135
 ;;^UTILITY(U,$J,358.3,32005,0)
 ;;=S92.912S^^94^1410^15
 ;;^UTILITY(U,$J,358.3,32005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32005,1,3,0)
 ;;=3^Fracture of left toe(s), sequela
 ;;^UTILITY(U,$J,358.3,32005,1,4,0)
 ;;=4^S92.912S
 ;;^UTILITY(U,$J,358.3,32005,2)
 ;;=^5045605
 ;;^UTILITY(U,$J,358.3,32006,0)
 ;;=S62.92XS^^94^1410^16
 ;;^UTILITY(U,$J,358.3,32006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32006,1,3,0)
 ;;=3^Fracture of left wrist and hand, sequela
 ;;^UTILITY(U,$J,358.3,32006,1,4,0)
 ;;=4^S62.92XS
 ;;^UTILITY(U,$J,358.3,32006,2)
 ;;=^5034892
 ;;^UTILITY(U,$J,358.3,32007,0)
 ;;=S42.402S^^94^1410^17
 ;;^UTILITY(U,$J,358.3,32007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32007,1,3,0)
 ;;=3^Fracture of lower end of left humerus, sequela
 ;;^UTILITY(U,$J,358.3,32007,1,4,0)
 ;;=4^S42.402S
 ;;^UTILITY(U,$J,358.3,32007,2)
 ;;=^5134725
 ;;^UTILITY(U,$J,358.3,32008,0)
 ;;=S42.401S^^94^1410^18
 ;;^UTILITY(U,$J,358.3,32008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32008,1,3,0)
 ;;=3^Fracture of lower end of right humerus, sequela
 ;;^UTILITY(U,$J,358.3,32008,1,4,0)
 ;;=4^S42.401S
 ;;^UTILITY(U,$J,358.3,32008,2)
 ;;=^5027300
 ;;^UTILITY(U,$J,358.3,32009,0)
 ;;=S92.901S^^94^1410^27
 ;;^UTILITY(U,$J,358.3,32009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32009,1,3,0)
 ;;=3^Fracture of right foot, sequela
 ;;^UTILITY(U,$J,358.3,32009,1,4,0)
 ;;=4^S92.901S
 ;;^UTILITY(U,$J,358.3,32009,2)
 ;;=^5045584
 ;;^UTILITY(U,$J,358.3,32010,0)
 ;;=S52.91XS^^94^1410^28
 ;;^UTILITY(U,$J,358.3,32010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32010,1,3,0)
 ;;=3^Fracture of right forearm, sequela
 ;;^UTILITY(U,$J,358.3,32010,1,4,0)
 ;;=4^S52.91XS
 ;;^UTILITY(U,$J,358.3,32010,2)
 ;;=^5031173
 ;;^UTILITY(U,$J,358.3,32011,0)
 ;;=S82.91XS^^94^1410^29
 ;;^UTILITY(U,$J,358.3,32011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32011,1,3,0)
 ;;=3^Fracture of right lower leg, sequela
 ;;^UTILITY(U,$J,358.3,32011,1,4,0)
 ;;=4^S82.91XS
 ;;^UTILITY(U,$J,358.3,32011,2)
 ;;=^5136991
 ;;^UTILITY(U,$J,358.3,32012,0)
 ;;=S82.001S^^94^1410^30
 ;;^UTILITY(U,$J,358.3,32012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32012,1,3,0)
 ;;=3^Fracture of right patella, sequela
 ;;^UTILITY(U,$J,358.3,32012,1,4,0)
 ;;=4^S82.001S
 ;;^UTILITY(U,$J,358.3,32012,2)
 ;;=^5040119
 ;;^UTILITY(U,$J,358.3,32013,0)
 ;;=S92.911S^^94^1410^32
 ;;^UTILITY(U,$J,358.3,32013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32013,1,3,0)
 ;;=3^Fracture of right toe(s), sequela
 ;;^UTILITY(U,$J,358.3,32013,1,4,0)
 ;;=4^S92.911S
 ;;^UTILITY(U,$J,358.3,32013,2)
 ;;=^5045598
 ;;^UTILITY(U,$J,358.3,32014,0)
 ;;=S62.91XS^^94^1410^33
 ;;^UTILITY(U,$J,358.3,32014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32014,1,3,0)
 ;;=3^Fracture of right wrist and hand, sequela
 ;;^UTILITY(U,$J,358.3,32014,1,4,0)
 ;;=4^S62.91XS
 ;;^UTILITY(U,$J,358.3,32014,2)
 ;;=^5034885
 ;;^UTILITY(U,$J,358.3,32015,0)
 ;;=S42.302S^^94^1410^34
 ;;^UTILITY(U,$J,358.3,32015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32015,1,3,0)
 ;;=3^Fracture of shaft of humerus, left arm, sequela
 ;;^UTILITY(U,$J,358.3,32015,1,4,0)
 ;;=4^S42.302S
 ;;^UTILITY(U,$J,358.3,32015,2)
 ;;=^5027044
 ;;^UTILITY(U,$J,358.3,32016,0)
 ;;=S42.301S^^94^1410^35
 ;;^UTILITY(U,$J,358.3,32016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32016,1,3,0)
 ;;=3^Fracture of shaft of humerus, right arm, sequela
 ;;^UTILITY(U,$J,358.3,32016,1,4,0)
 ;;=4^S42.301S
 ;;^UTILITY(U,$J,358.3,32016,2)
 ;;=^5027037
 ;;^UTILITY(U,$J,358.3,32017,0)
 ;;=S42.202S^^94^1410^42
 ;;^UTILITY(U,$J,358.3,32017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32017,1,3,0)
 ;;=3^Fracture of upper end of left humerus, sequela
