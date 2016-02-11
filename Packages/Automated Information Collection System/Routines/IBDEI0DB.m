IBDEI0DB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5787,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,5788,0)
 ;;=M47.25^^40^376^27
 ;;^UTILITY(U,$J,358.3,5788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5788,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Thoracolumbar Region NEC
 ;;^UTILITY(U,$J,358.3,5788,1,4,0)
 ;;=4^M47.25
 ;;^UTILITY(U,$J,358.3,5788,2)
 ;;=^5012064
 ;;^UTILITY(U,$J,358.3,5789,0)
 ;;=M47.892^^40^376^36
 ;;^UTILITY(U,$J,358.3,5789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5789,1,3,0)
 ;;=3^Spondylosis,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,5789,1,4,0)
 ;;=4^M47.892
 ;;^UTILITY(U,$J,358.3,5789,2)
 ;;=^5012078
 ;;^UTILITY(U,$J,358.3,5790,0)
 ;;=M47.893^^40^376^37
 ;;^UTILITY(U,$J,358.3,5790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5790,1,3,0)
 ;;=3^Spondylosis,Cervicothoracic Region NEC
 ;;^UTILITY(U,$J,358.3,5790,1,4,0)
 ;;=4^M47.893
 ;;^UTILITY(U,$J,358.3,5790,2)
 ;;=^5012079
 ;;^UTILITY(U,$J,358.3,5791,0)
 ;;=M47.896^^40^376^38
 ;;^UTILITY(U,$J,358.3,5791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5791,1,3,0)
 ;;=3^Spondylosis,Lumbar Region NEC
 ;;^UTILITY(U,$J,358.3,5791,1,4,0)
 ;;=4^M47.896
 ;;^UTILITY(U,$J,358.3,5791,2)
 ;;=^5012082
 ;;^UTILITY(U,$J,358.3,5792,0)
 ;;=M47.897^^40^376^39
 ;;^UTILITY(U,$J,358.3,5792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5792,1,3,0)
 ;;=3^Spondylosis,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,5792,1,4,0)
 ;;=4^M47.897
 ;;^UTILITY(U,$J,358.3,5792,2)
 ;;=^5012083
 ;;^UTILITY(U,$J,358.3,5793,0)
 ;;=M47.891^^40^376^40
 ;;^UTILITY(U,$J,358.3,5793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5793,1,3,0)
 ;;=3^Spondylosis,Occipito-Atlanto-Axial Region NEC
 ;;^UTILITY(U,$J,358.3,5793,1,4,0)
 ;;=4^M47.891
 ;;^UTILITY(U,$J,358.3,5793,2)
 ;;=^5012077
 ;;^UTILITY(U,$J,358.3,5794,0)
 ;;=M47.898^^40^376^41
 ;;^UTILITY(U,$J,358.3,5794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5794,1,3,0)
 ;;=3^Spondylosis,Sacral/Sacrococcygeal Region NEC
 ;;^UTILITY(U,$J,358.3,5794,1,4,0)
 ;;=4^M47.898
 ;;^UTILITY(U,$J,358.3,5794,2)
 ;;=^5012084
 ;;^UTILITY(U,$J,358.3,5795,0)
 ;;=M47.894^^40^376^42
 ;;^UTILITY(U,$J,358.3,5795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5795,1,3,0)
 ;;=3^Spondylosis,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,5795,1,4,0)
 ;;=4^M47.894
 ;;^UTILITY(U,$J,358.3,5795,2)
 ;;=^5012080
 ;;^UTILITY(U,$J,358.3,5796,0)
 ;;=M47.895^^40^376^43
 ;;^UTILITY(U,$J,358.3,5796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5796,1,3,0)
 ;;=3^Spondylosis,Thoracolumbar Region NEC
 ;;^UTILITY(U,$J,358.3,5796,1,4,0)
 ;;=4^M47.895
 ;;^UTILITY(U,$J,358.3,5796,2)
 ;;=^5012081
 ;;^UTILITY(U,$J,358.3,5797,0)
 ;;=M75.121^^40^376^19
 ;;^UTILITY(U,$J,358.3,5797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5797,1,3,0)
 ;;=3^Rotator Cuff Syndrome,Right Shoulder
 ;;^UTILITY(U,$J,358.3,5797,1,4,0)
 ;;=4^M75.121
 ;;^UTILITY(U,$J,358.3,5797,2)
 ;;=^5013248
 ;;^UTILITY(U,$J,358.3,5798,0)
 ;;=M75.122^^40^376^18
 ;;^UTILITY(U,$J,358.3,5798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5798,1,3,0)
 ;;=3^Rotator Cuff Syndrome,Left Shoulder
 ;;^UTILITY(U,$J,358.3,5798,1,4,0)
 ;;=4^M75.122
 ;;^UTILITY(U,$J,358.3,5798,2)
 ;;=^5013249
 ;;^UTILITY(U,$J,358.3,5799,0)
 ;;=M47.816^^40^376^30
 ;;^UTILITY(U,$J,358.3,5799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5799,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,5799,1,4,0)
 ;;=4^M47.816
 ;;^UTILITY(U,$J,358.3,5799,2)
 ;;=^5012073
 ;;^UTILITY(U,$J,358.3,5800,0)
 ;;=M47.817^^40^376^31
 ;;^UTILITY(U,$J,358.3,5800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5800,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
